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

Before:
```python
env_val = os.environ.get('...')
switcher_val = False
if env_val is not None:
    jk_val = True
    if env_val.lower() is in ["true", "1", "yes"]:
        env_val = True
    else:
        evn_val = False
else:
    env_val = True
    try:
        switch_name = "/switch/name/from/config"
        switcher_val = switcher.check(switch_name, switchval=region)
    except Exception as e:
        print(f"Failed to retrieve switch {switch_name}: {e}")
if env_val or switcher_val:
    apply_some_config(job)
```

After:
```python
# Apply config when '...' environment variable is True, else check the switch
__ENV_VARIABLE = '...'
__SWITCHER_KEY = '/switch/name/from/config'
if __ENV_VARIABLE in os.environ.keys():
    if os.environ.get(__ENV_VARIABLE).lower() in set("true", "1", "yes"):
        apply_some_config(job)
    # else, assume that __ENV_VARIABLE is explicitly set to False and do not apply config.
    return
# Apply the config if the switcher is set.
try:
    if switcher.check(__SWITCHER_KEY, switchval=region):
        apply_some_config(job)
except  Exceptiopn as e:
    print(f"Failed to retrieve switch {__SWITCHER_KEY}: {e}")
```
