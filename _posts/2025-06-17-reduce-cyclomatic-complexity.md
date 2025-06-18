---
layout: post
title: "Cyclomatic Complexity: How Low Can You Go?"
date: 2025-06-17
author: 'Srikanth Sastry'
categories:
  - professional
tags: 
  - cyclomatic-complexity
  - refactoring
  - best-practices
permalink: /reduce-cyclomatic-complexity/
---

![](/images/cpu-in-maze-pixel-art.png)
## What even _is_ Cyclomatic Complexity?
Ever spend 20 minutes trying to figure out why a config isn’t applying — only to realize you missed a buried branch in someone’s 10-path function? That’s [Cyclomatic Complexity](https://en.wikipedia.org/wiki/Cyclomatic_complexity) in action. Intuitively, you can think of Cyclomatic Complexity as the number of possible paths a single execution of a function can take. 

For example, `a = b + c` has a cyclomatic complexity of one, and `a = b + c if foo else d + e` has a cyclomatic complexity of two: one path is when `foo` is `True` and the effective logic is `a = b + c`, and the other path is when `foo` is `False` and the effective logic is `a = d + e`.

## Ain't got no time? Here's the goods.

If you take just one thing away from this note, then let it be this.

> **Strive to reduce the Cyclomatic Complexity of your code; your team and your future self will thank you!**

## Time to hit the brain gym, bro
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

I'll wait... (Spoiler: It's not pretty.)

Give up? Turns out, it is `4`: three if-checks contribute to three branching points, and the cyclomatic complexity is one more than that; _ergo_ `4`.

Next, by spending no more than 60 seconds looking this code, can you tell me what exactly it is doing? BTW, this is real production code that I ran across when debugging some issue, and it took me a long while to make sure I knew exactly when and how the config is applied. It wasn't obvious at all. If you can grok this in 60 seconds, take a bow!

## Reeling yet?

Anyway, making sense of functions with high cyclomatic complexity is annoying. It’s notoriously difficult to write tests with good coverage for these functions, and in general, they tend to be bug factories.

And yet — somehow — a lot of senior software engineers don’t seem to grok this. I keep seeing deeply nested `if-else` blocks, sometimes inside loops with `break`s and `continue`s, and it doesn’t seem to bother anyone! It’s like we’ve collectively normalized this cognitive overhead. 

Why?! Why are we putting up with this crap? It’d never fly in an interview.


## Yo, let's fix it up!
Coming back to the above example, the confusion and ugliness of this code really got to me. It got so bad I considered dusting off a Karnaugh map. After some much needed grokking, I managed to simplify it down to a cyclomatic complexity of `2`! :)

In the end, here’s what that poor little code snippet was trying to do:

```python
# Apply config when '...' environment variable is True, else check the switch
__ENV_VARIABLE = '...'
__SWITCHER_KEY = '/switch/name/from/config'
def has_env_override():
    val = os.environ.get(__ENV_VARIABLE)
    return val is not None and val.lower() in {"true", "1", "yes"}

if (
    has_env_override() or 
    switcher.check(__SWITCHER_KEY, switchval=region)
):
    apply_some_config(job)
```

Fewer paths, fewer bugs. Cleaner code. Happier teammates. What’s not to love?
