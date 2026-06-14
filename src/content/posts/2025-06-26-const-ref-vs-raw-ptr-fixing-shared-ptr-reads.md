---
title: "Const Refs vs. Raw Pointers: Fixing Shared Pointer Reads"
published: 2025-06-26
tags:
  - 'C++'
  - 'software engineering'
abbrlink: 'const-ref-vs-raw-ptr-a-fix-for-shared-ptr-reads'
image: /assets/images/raw-pointer-smoking-gun-const-ref-vest.jpg
lang: ''
draft: false
excerpt: >
  Don't pass `shared_ptr<T>` by value unless you need ownership semantics.   Prefer `const T&` for read-only access, or `const std::shared_ptr<T>&` if you need to keep smart pointer semantics—without paying the refcount tax.   Avoid raw pointers unless you're absolutely sure they're the right tool.
categories:
  - Professional

---

## The problem

Recently, I encountered a subtle performance issue while refactoring some C++ code. I was passing a std::shared_ptr<T> by value into a function, even though the callee only needed read access. Infer flagged it as [`PULSE_READONLY_SHARED_PTR_PARAM`](https://fbinfer.com/docs/all-issue-types/#pulse_readonly_shared_ptr_param). Infer was right: passing shared pointers by value incurs refcount overhead, and if multiple threads are sharing the pointer, it can introduce performance regressions. My code looked something like this.
```c++
void caller(std::shared_ptr<T> shared_ptr) {
  ...
  callee(shared_ptr);
}

void callee(std::shared_ptr<T> ptr) {
  auto foo = ptr->read_value() + 1;
}
```

## Infer's suggestion, and why it's wrong

Infer's documentation around [`PULSE_READONLY_SHARED_PTR_PARAM`](https://fbinfer.com/docs/all-issue-types/#pulse_readonly_shared_ptr_param) says the following:

> This issue is reported when a shared pointer parameter is a) passed by value and b) is used only for reading, rather than lifetime extension. At the callsite, this might cause a potentially expensive unnecessary copy of the shared pointer, especially when many number of threads are sharing it. To avoid this, consider 1) passing the raw pointer instead and 2) use `std::shared_ptr::get` at callsites.

So, its suggestion was to change my code to the following:
```c++
void caller(std::shared_ptr<T> shared_ptr) {
  ...
  callee(shared_ptr.get());
}

void callee(T* ptr) {
  auto foo = ptr->read_value() + 1;
}
```

Sure, Infer got the diagnosis right, but the proposed solution of using raw pointers seems wrong. Smart pointers (unique_ptr and shared_ptr) were introduced precisely to avoid the many footguns associated with raw pointer memory management and safety. There should be almost no good reason to use raw pointers, and the use case above seems too trivial to warrant using a raw pointer. In fact, if I passed a raw pointer, some future developer might wrap it in a new shared_ptr and pass it elsewhere. That’s a recipe for double-free bugs and a nasty core dump.

Ranting aside, I still couldn’t let the change stand as-is; the infer error was pointing to a legitimate problem. So, how do we address this issue without resorting to raw pointers? Answer: const refs :)

## Const refs to the rescue
Instead of passing the raw pointer, what if we just passed the underlying object itself? Well, we don't really need a copy of the object, and so we can pass a reference to it. Since we’re only calling a read-only method, a const reference works just fine. With that, we have this fix:

```c++
void caller(std::shared_ptr<T> shared_ptr) {
  ...
  callee(*shared_ptr);
}

void callee(const T &obj) {
  auto foo = obj.read_value() + 1;
}
```

And it works like a charm.

## Why not const ref the shared pointer itself?

Of course, passing a const reference to the object isn’t the only way to avoid copying the shared pointer. You can also simply pass the shared pointer by reference!
```diff
void caller(std::shared_ptr<T> shared_ptr) {
  ...
  callee(shared_ptr);
}

- void callee(std::shared_ptr<T> ptr) {
+ void callee(const std::shared_ptr<T> &ptr) {
  auto foo = ptr->read_value() + 1;
}
```
(I showed this as a diff because the change is subtle! Also note: taking a reference to a `shared_ptr` avoids bumping the reference count, so there’s no added contention.)

Now, be careful here. You can't use this trick if `shared_ptr` could be a `nullptr`, because passing a reference to a `nullptr` and trying to dereference it is a great way to bring down your service! In my case, it turns out that `shared_ptr` was guaranteed to be non-null, and so this trick works well.

So next time someone suggests using a raw pointer, be skeptical—there’s almost always a safer alternative to that particular footgun.

## Oh, and one last thing...

I’ll stop here, but don’t walk away thinking const refs are a cure-all. They can backfire too. [This post in Belay the C++](https://belaycpp.com/2022/02/15/constant-references-are-not-always-your-friends/) outlines some of the less obvious pitfalls.
