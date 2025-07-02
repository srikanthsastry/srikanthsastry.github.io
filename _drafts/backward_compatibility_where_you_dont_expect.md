---
title: "When Backward Compatibility Can Rescue Leaky Abstraction"
date: 2025-06-28
layout: post
categories:
    - Professional
tags:
    - software engineering
    - debugging
    - best practices
permalink: /backward-compatibility-where-you-dont-expect/
image: /assets/images/usb_c_into_ethernet_port.jpg
---
I ran into an interesting bug when working on a [Dataswarm](https://medium.com/@AnalyticsAtMeta/data-engineering-at-meta-high-level-overview-of-the-internal-tech-stack-a200460a44fe) pipeline which points to a prototypical case of leaky abstraction. The fix for it involved actually building backward compatibitlity into a Python function that only ever called within the same module. I thought y'all might enjoy this story.

# The bug

I had an Dataswarm operator that would execute a Python function every day, and the output of that Python function was a list of tasks (more functions) that would be performed on that day.

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

I soon got a bug report that said that my pipeline failed with an error: `TypeError: 'arg2' is an invalid keyword argument for task_generator()`. This had me completely confused. My expectation was that either the _previous_ version of the pipeline would be executed, in which `task_generator()` is defined to expect `arg2` and `tasks_to_be_executed` passes a value for `arg2`, or the _new_ version of the pipeline would be executed, in which `task_generator()` is defined to expect `arg3`, and `tasks_to_be_executed` passes a value for `arg3`. Neither of those two scenarios result in a `TypeError: 'arg2' is an invalid keyword argument for task_generator()`. So, what's going on?

# The root cause
After some debugging, I saw that the `tasks_to_be_executed` task instance that errored out started off two days ago, but was waiting for the `wait_for_data` to complete, and the `wait_for_data` task didn't complete until the current day, after which the `tasks_to_be_executed` task instance ran and errored out. Eventually, after some more digging into the implementation fo `DynamicTasks` I discovered that when it is scheduled, it actually persists both `task_gen_function` and `task_gen_args` as a json blob and waits for the upstream tasks to complete. After the upstream tasks complete, `DynamicTasks` deserializes the json blob, extracts the `task_gen_function` name, loads the function with that name from the repo HEAD and calls it with the `task_gen_args` arguments. Putting these two pieces of information together, here is a timeline of the events that lead up the the failure.

![](/assets/images/dynamicTask-dataswarm-pipeline-failure-2025-07-01.png)

Now, the only way I could have figured this out is by actually looking into the implementation of `DynamicTasks`, and that is classic [leaky abstraction](https://en.wikipedia.org/wiki/Leaky_abstraction)!

# The fix

Changing the Dataswarm operator implementation to not leak its implementation detail was a pretty heavy lift, and I needed a more scoped down change to unblock myself. So, I needed a way to make sure that I can change the `task_generator` implementation without running into such combinations of race conditions and leaky abstraction again. Making `task_generator` implementation backward compatible accomplishes this quire nicely. But first, I need to make sure that it can be made backwards compatible. That involves a few steps.

## Step 1. Add **kwargs

First, we need to ensure that passing in parameters from the previous version of `task_generator` does not throw an unexpected exception. We can do that by swallowing all unspecified paramters in `**kwargs` as follows.

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
2. It makes all parameters optional with a defualt value of `None`. This ensures that not setting any specific parameter does not invalidate the call. The reasoning for this is similar to the ones in [proto3 that made all fields optional](https://github.com/protocolbuffers/protobuf/issues/2497).
3. If the caller invokes with a parameter (say) `arg13`, then the function won't throw an ungraceful exception, and instead throws a warning about the unrecongnized parameter and proceeds to execute the function with the remaining parameters.

Land this change and wait for it to be picked up by all your task instances.

## Step 2. Change your function signature
Now you are ready to make changes to your function signature without breaking existing tasks. Say, you want to remove `arg2` and introduce `arg3`, your diff will look as follows.

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

When you land this, you could have tasks scheduled to run that are currently persisting the old function signature. When such tasks exeucute your new function definition, `**kwargs` will swalloe `arg2` and `arg3` is set to its default value `None`. You function will now see that `arg3` is `None`, and so it will look for `arg2` in the `kwargs` and execute the old bsuiness logic.

However, for all new instances of your task, `arg3` is set, and so the function executes the new business logc. Backward compatibilty accomplished!

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

# Final thoughts

You don't always control the libraries you call or depend on. However, you can write defensive code to protect yourself from the darker corners of your dependencies execution behavior. Ensuring backward compatibility happens to be one of them. It is a bit more work than usual, but I promise you, it is worthwhile.






