---
layout: post
title: "Reduce Cyclomatic Complexity"
date: 2024-06-11
author: 'Srikanth Sastry'
categories:
  - professional
tags: 
  - cyclomatic-complexity
  - refactoring
  - best-practices
permalink: /reduce-cyclomatic-complexity/
---
Ever heard of [Cyclomatic Complexity](https://en.wikipedia.org/wiki/Cyclomatic_complexity)? Intuitively, you can think of it as the number of possible paths a single execution of a function can take. 

For example, `a = b + c` has a cyclomatic complexity of one, and `a = b + c if foo else d + e` has a cyclomatic complexity of two: one path is when `foo` is `True` and the effective logic is `a = b + c`, and the other path is when `foo` is `False` and the effective logic is `a = d + e`.

If you take just one thing away from this note, then let it be this.

> Strive to reduce the Cyclomatic Complexity of your code; your team and your future self will thank you!

As an exercise, I will let you figure out the cyclomatic complexity of the following piece of code:

```python
env_val = os.environ.get('...')
switcher_val = False
if env_val is not None:
    jk_val = True
    if env_val.lower() is in ["true", "1", "yes"]:
        env_val = True
    else:
        env_val = False
else:
    env_val = True
    switch_name = "/switch/name/from/config"
    switcher_val = switcher.check(switch_name, switchval=region)
if env_val or switcher_val:
    apply_some_config(job)
```

I'll wait...

Give up? Turns out, it is $4$: three if-checks contribute to three branching points, and the cyclomatic complexity is one more than that; _ergo_ $4$.

Next, by spending no more than 60 seconds looking this code, can you tell me what exactly it is doing? BTW, this is real production code that I ran across when debugging some issue, and it took me a long while to make sure I knew exactly when and how the config is applied. It wasn't obvious at all. If you can grok this in 60 seconds, take a bow!

Anyway, making sense of functions with high cyclomatic complexity is annoying; it is notoriously difficult to write tests with good coverage for these functions, and in general, they tend to be bug factories. And yet, somehow, a lot of senior software engineers don't seem to grok this. I say this because I see a lot of code that with high cyclomatic complexity, and somehow it does not seem to bother senior devs. It is almost as if these folks have baked-in the cognitive overhead of reading such a code, and seem to think little of it. Why?! Why are you deliberately allowing such a confusing piece of code in your software?

I don't get it!

Coming back to the above example, the confusion and ugliness of this code really got to me, and I practically drew up a Karnaugh map to understand what was happening, and after some much needed grokking, I managed to simplify it down to a Cyclomatic complexity of $2$! :)

Ladies and gentlemen, here is all that that poor little code snippet was trying to do:

```python
# Apply config when '...' environment variable is True, else check the switch
__ENV_VARIABLE = '...'
__SWITCHER_KEY = '/switch/name/from/config'
def has_env_override():
    val = os.environ.get(__ENV_VARIABLE)
    return val is not None and val.lower() in {"true", "1", "yes"}
if has_env_override() or switcher.check(__SWITCHER_KEY, switchval=region):
    apply_some_config(job)
```

See! So much easier to make sense of, test, and debug.
