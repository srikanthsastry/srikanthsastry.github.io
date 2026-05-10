---
title: 'Object Composition for Service Migration'
published: '2019-01-24T16:13:37-05:00'
tags:
  - 'design pattern'
  - migration
  - 'object composition'
  - services
  - 'software engineering'
abbrlink: 'object-composition-for-service-migration'
lang: ''
categories:
  - Professional

---

[Object Composition](https://en.wikipedia.org/wiki/Object_composition) is a very powerful and pervasive software design technique. Yet, paradoxically, it is an underutilized design pattern whose lack of usage is the root of many anti-patterns in software development. One that I continue to come across regularly has to do with not using composition to test and migrate a piece of software from one service to another.

Briefly, *Object Composition* is combining two or more objects to create more complex objects while keeping definitions of the constituent objects unchanged (unlike [inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)), which extends these definitions)

## Set Up

Say you have an existing backend service that your code currently uses. It has evolved over time to become a chimera that needs replacing, and you have a brand new implementation of that service that can replace your old service.

Say, the two client implementations looks something like the following:

```java
class OldAndBusted implements ServiceClient {
  @override
  Response process(Request request) {
    // Hacky code.
    if (request.type == A) {
      // Ugly code.
    } else if (request.type == B) {
      // Even uglier code.
    } else {
      // A monstrosity that needs to be killed with fire
    }
    return response;
  }
}

class NewHotness implements ServiceClient {
  @override
  Response process(Request request) {
    // Best code ever written.
    return response;
  }
}
```

The goal is to migrate your code from using OldAndBusted to NewHotness. There are several ways to do this wrong. So it is easier if I demonstrate a right way to do this using Object Composition via the [shadow-verify-migrate pattern](/garden/shadow-verify-migrate-pattern/).

## A right way

There are really four steps to such a migration.

1. *Verify equivalence*: Shadow a percentage of your calls to the new service, log mismatches in the response, and fix all such mismatches.
2. *Configure migration*: Setup service migration to proceed in phases.
3. *Migrate and clean up*: Complete migration and delete the old service.

### Step 1. Verify equivalence

The goal here is to ensure that before we start migration, the new service is functionally identical to the old service. We accomplish this through composition of old and new service as sketched out next.

```java
class ClientWithShadow implements ServiceClient {
  ClientWithShadow(ServiceClient oldAndBusted,
                   ServiceClient newHotness) {
    this.oldAndBusted = oldAndBusted;
    this.newHotness = newHotness;
  }
  @override
  Response process(Request request) {
    oldResponse = oldAndBusted.process(request);
    if (shouldShadow(request)) {
      newResponse = newHotness.process(request);
      if (!oldResponse.equals(newResponse)) {
        logMismatch(oldResponse, newResponse);
      }
    }
    return newResponse;
  }
```

The pseudocode code above simply delegates calls to the old service, and if shadowing is requires, it additionally delegates to the new service as well and compares the two outputs. It logs any mismatches it sees so that the developer can then take a look at it to ensure that it is addressed.

You simply replace all calls to OldAndBusted with calls to ClientWithShadow.

### Step 2. Configure migration

After you have determined that the two services are indeed functionally alike, we can then prep for migration. Again, object composition helps us set this up cleanly.

Pseudocode for setting up such a migration follows next. Here, I assume that there is a Config object that contains the migration related config.

```java
class MigrationClient implements ServiceClient {
  MigrationClient(ServiceClient oldAndBusted,
                  ServiceClient newHotness,
                  Config migrationConfig) {
    this.oldAndBusted = oldAndBusted;
    this.newHotness = newHotness;
    this.migrationConfig = migrationConfig;
  }
  @override
  Response process(Request request) {
    if (migrationConfig.useNewService(request)) {
     return newHotness.process(request);
    }
    return oldAndBusted.process(request);
  }
```

You simply replace all instances of ClientWithShadow with MigrationClient. Yes, it really is that simple! The migration config has all the info it needs to figure out whether a given request should use the new service or the old service.

### Step 3. Migrate and clean up

Here, we do the actual migration. We set up the config to slowly start shifting some of the load from the old service to the new one, while monitoring to make sure everything is going well. We can always roll back the migration by editing the config without actually modifying the code, which is a big deal here.

After migration to the new service a 100%, you can simply replace MigrationClient instances with NewHotness instances, and delete all the old code (OldAndBusted, ClientWithShadow, and MigrationClient). And you are all cleaned up. Profit!

## So many wrong ways

Unfortunately, I have seen this done in way too many wrong ways.

- I have seen use of inheritance to extend OldAndBusted to NewHotness, and some hacky switch inside the NewHotness implementation to do shadowing and migration.
- I have seen hacky if-else modification of OldAndBusted that the new if-block implementing NewHotness functionality.
- I have seen developers skip shadowing entirely only to cause major service incidents.
- Many more ways that are not that interesting, except for disaster tourism.

So, object composition is useful, it is powerful, and please use it more!
