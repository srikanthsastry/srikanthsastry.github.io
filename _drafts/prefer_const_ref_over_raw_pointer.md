---
title: "Prefer const Reference Over Raw Pointer"
date: 2025-06-25
layout: post
categories: 
    - Professional
tags:
    - c++
    - const references
    - pointers
    - code quality
draft: true
---

See https://fbinfer.com/docs/all-issue-types/#pulse_readonly_shared_ptr_param

It says that you should use a raw pointer instead of shared pointer for read-only use when you are not extending the lifetime of the underlying managed object.
However, raw pointers are tricky to work with. There is a reason smart pointer were created! So, instead of using raw pointers, consider using const references to the underlying managed object.
