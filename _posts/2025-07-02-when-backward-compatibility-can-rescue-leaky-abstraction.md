---
title: "When Backward Compatibility Can Rescue a Leaky Abstraction"
date: 2025-07-02
layout: post
categories:
    - Professional
tags:
    - software engineering
    - debugging
    - best practices
permalink: /backward-compatibility-where-you-dont-expect/
image: /assets/images/usb_c_into_ethernet_port.jpg
excerpt: >
    I thought I was making a simple change; changed a function signature that was only ever called in the same module.
    I thought it was safe, until my pipeline crashed days later because old tasks serialized with the previous signature tried calling the new code. 
    This is a story about how I wrangled backward compatibility, tamed a leaky abstraction, and kept my data flowing.
---

I ran into one of those delightful bugs that only show up in dynamic task generation of your data pipelines — the kind that teach you how a leaky abstraction in your pipeline platform can have you scratching your head in confusion.

The short version:
I made a simple function signature change, assuming only future runs would care. Instead, my pipeline broke days later when an old task serialized under the previous signature collided with the new code. The fix? Classic backward compatibility tricks that saved me from babysitting all existing task runs when making changes in the future.

Here’s the story — and how to avoid learning this lesson the hard way.

# The bug

I had a [Dataswarm](https://medium.com/@AnalyticsAtMeta/data-engineering-at-meta-high-level-overview-of-the-internal-tech-stack-a200460a44fe) operator that would execute a Python function every day, and the output of that Python function was a list of tasks (other functions) to be executed that day.

Here is what the function looked like:
```python
# Function that generates the tasks to be executed.
def task_generator(arg1, arg2) -> List[Task]:
    ...

# How the function is invoked
wait_for_data = SomeTaskWaitingForData(data)
tasks_to_be_executed = DynamicTasks(
    wait_for_tasks=[wait_for_data]
    task_gen_function=task_generator
    task_gen_args={
        "arg1": a,
        "arg2": b,
    }
)
```
I put in a diff that looked something like this:
```diff
# Function that generates the tasks to be executed.
- def task_generator(arg1, arg2) -> List[Task]:
+ def task_generator(arg1, arg3) -> List[Task]:
    ...

# How the function is invoked
wait_for_data = SomeTaskWaitingForData(data)
tasks_to_be_executed = DynamicTasks(
    wait_for_tasks=[wait_for_data]
    task_gen_function=task_generator
    task_gen_args={
        "arg1": a,
-        "arg2": b,
+        "arg3": c,
    }
)
```
You see, I just replaced `arg2` with `arg3` and everything looked fine. I tested the diff and landed it, expecting the next task instance to pick up the changes and move on. As you can imagine, that is not what happened :)

I soon got a bug report that said that my pipeline failed with an error: `TypeError: 'arg2' is an invalid keyword argument for task_generator()`. This had me completely confused. My expectation was that either the _previous_ version of the pipeline would be executed, in which `task_generator()` is defined to expect `arg2` and `tasks_to_be_executed` passes a value for `arg2`, or the _new_ version of the pipeline would run, where `task_generator()` expects `arg3` and `tasks_to_be_executed` passes arg3. Neither of those two scenarios result in a `TypeError: 'arg2' is an invalid keyword argument for task_generator()`. So, what's going on?

# The root cause
After some debugging, I saw that the `tasks_to_be_executed` task instance that errored out started off two days ago, but was waiting for the `wait_for_data` to complete, and the `wait_for_data` task didn't complete until the current day, after which the `tasks_to_be_executed` task instance ran and errored out. Eventually I found that `DynamicTasks` serializes the function name and args as a JSON blob at schedule time, waits for upstream tasks to finish, then reloads the function from HEAD and calls it with the original arguments. That’s why old args collided with new code.

![](/assets/images/dynamicTask-dataswarm-pipeline-failure-2025-07-01.png)

Because `DynamicTasks` persists the function name and args and then later reloads HEAD, it breaks the assumption that changing a function signature only affects new pipeline runs. I only discovered this by digging into `DynamicTasks` implementation; classic [leaky abstraction](https://en.wikipedia.org/wiki/Leaky_abstraction)!

# The fix

Changing the Dataswarm operator implementation to not leak its implementation detail was a pretty heavy lift, and I needed a more scoped down change to unblock myself. So, I needed a way to make sure that I can change the `task_generator` implementation without running into such combinations of race conditions and leaky abstraction again. Making the task_generator implementation backward compatible accomplishes this quite nicely. But first, I need to make sure that it can be made backwards compatible. That involves a few steps.

## Step 1. Add **kwargs

First, we need to ensure that passing in parameters from the previous version of `task_generator` does not throw an unexpected exception. We can do that by swallowing all unspecified parameters in `**kwargs` as follows.

```diff
# Function that generates the tasks to be executed.
- def task_generator(arg1, arg2) -> List[Task]:
+ def task_generator(
+    *,
+    arg1=None, 
+    arg2=None,
+    **kwargs
+ ) -> List[Task]:
+    if kwargs:
+        LOG.warning(f"Found unspecified arguments {kwargs.keys()}")        
    ...
```

The diff does three things.

1. It ensures that all arguments are passed by name and not by position.
2. It makes all parameters optional with a default value of `None`. This ensures that leaving out any specific parameter doesn’t break the call. The reasoning for this is similar to the ones in [proto3 that made all fields optional](https://github.com/protocolbuffers/protobuf/issues/2497).
3. If the caller passes an unexpected parameter (say, arg13), the function won’t throw an exception. Instead, it logs a warning about the unrecognized parameter and proceeds to execute the function with the remaining parameters.

Land this change and wait for it to propagate to all your task instances.

## Step 2. Change your function signature
Now you are ready to make changes to your function signature without breaking existing tasks. Suppose you want to remove arg2 and introduce arg3. Your diff would look like this.

```diff
def task_generator(
    *,
    arg1=None, 
-   arg2=None,
+   arg3=None,
    **kwargs
) -> List[Task]:
    if kwargs:
        LOG.warning(f"Found unspecified arguments {kwargs.keys()}")
+   if not arg3:
+       arg2 = kwargs.get("arg2", None)
+       # Old business logic with arg2
        ...
+       return tasks
+   # New business logic with arg3
+   ...
+   return tasks
```

When you land this, you could have tasks scheduled to run that are currently persisting the old function signature. When such tasks execute your new function definition, `**kwargs` will swallow `arg2` and `arg3` is set to its default value `None`. The function will see that `arg3` is None, so it will look for `arg2` in kwargs and execute the old business logic.

However, for all new instances of your task, `arg3` is set, and so the function executes the new business logic. Backward compatibility accomplished!

## Step 3. Delete old functionality

After all your old task instances have completed execution, you are now ready to remove the old business logic. This is a simple red diff.
```diff
def task_generator(
    *,
    arg1=None, 
-   arg3=None,
    **kwargs
) -> List[Task]:
    if kwargs:
        LOG.warning(f"Found unspecified arguments {kwargs.keys()}")
-   if not arg3:
-       arg2 = kwargs.get("arg2", None)
-       # Old business logic with arg2
-        ...
-       return tasks
   # New business logic with arg3
   ...
   return tasks
```

And, you are done!

# Lessons learned

- Pipeline frameworks can serialize more than you think. DynamicTasks pickled the function name and arguments days earlier, then loaded the function definition fresh from HEAD. That mismatch broke everything.

- Stage changes with `**kwargs` and defaults. When changing function signatures that might still be called by older task payloads, always accept extra kwargs and use `None` defaults to gracefully detect old vs. new callers.

- Expect your abstractions to leak. If your orchestration tool stores data and code separately (JSON blobs now, functions later), your assumption that “old code only calls old function signatures” is toast.

- Logging unrecognized parameters is gold. Instead of crashing, you get explicit warnings when old payloads collide with new code. Debugging becomes a thousand times easier.
