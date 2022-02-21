---
id: 403
title: 'Object Composition for Service Migration'
date: '2019-01-24T16:13:37-05:00'
author: 'Srikanth Sastry'
layout: post
guid: 'https://srikanth.sastry.name/?p=403'
permalink: /object-composition-for-service-migration/
categories:
    - Professional
tags:
    - 'design pattern'
    - migration
    - 'object composition'
    - services
    - 'software engineering'
---

<!-- wp:paragraph -->
<p><a href="https://en.wikipedia.org/wiki/Object_composition">Object Composition</a> is a very powerful and pervasive software design technique. Yet, paradoxically, it is an underutilized design pattern whose lack of usage is the root of many anti-patterns in software development. One that I continue to come across regularly has to do with not using composition to test and migrate a piece of software from one service to another.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Briefly, <em>Object Composition</em> is combining two or more objects to create more complex objects while keeping definitions of the constituent objects unchanged (unlike <a href="https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)">inheritance</a>, which extends these definitions)</p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:heading -->
<h2>Set Up </h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Say you have an existing backend service that your code currently uses. It has evolved over time to become a chimera that needs replacing, and you have a brand new implementation of that service that can replace your old service. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Say, the two client implementations looks something like the following:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">class OldAndBusted implements ServiceClient {<br>  @override<br>  Response process(Request request) {<br>    // Hacky code.<br>    if (request.type == A) {<br>      // Ugly code.<br>    } else if (request.type == B) {<br>      // Even uglier code.<br>    } else {<br>      // A monstrosity that needs to be killed with fire<br>    }<br>    return response;<br>  }<br>}<br><br>class NewHotness implements ServiceClient {<br>  @override<br>  Response process(Request request) {<br>    // Best code ever written.<br>    return response;<br>  }<br>}</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>The goal is to migrate your code from using OldAndBusted to NewHotness. There are several ways to do this wrong. So it is easier if I demonstrate a right way to do this using Object Composition.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>A right way</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>There are really four steps to such a migration.</p>
<!-- /wp:paragraph -->

<!-- wp:list {"ordered":true} -->
<ol><li><em>Verify equivalence</em>: Shadow a percentage of your calls to the new service, log mismatches in the response, and fix all such mismatches.</li><li><em>Configure migration</em>: Setup service migration to proceed in phases.</li><li><em>Migrate and clean up</em>: Complete migration and delete the old service.</li></ol>
<!-- /wp:list -->

<!-- wp:heading {"level":3} -->
<h3>Step 1. Verify equivalence</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The goal here is to ensure that before we start migration, the new service is functionally identical to the old service. We accomplish this through composition of old and new service as sketched out next.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">class ClientWithShadow implements ServiceClient {<br>  ClientWithShadow(ServiceClient oldAndBusted, <br>                   ServiceClient newHotness) {<br>    this.oldAndBusted = oldAndBusted;<br>    this.newHotness = newHotness;<br>  }<br>  @override<br>  Response process(Request request) {<br>    oldResponse = oldAndBusted.process(request);<br>    if (shouldShadow(request)) {<br>      newResponse = newHotness.process(request);<br>      if (!oldResponse.equals(newResponse)) {<br>        logMismatch(oldResponse, newResponse);<br>      }<br>    }<br>    return newResponse;<br>  }<br><br></pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>The pseudocode code above simply delegates calls to the old service, and if shadowing is requires, it additionally delegates to the new service as well and compares the two outputs. It logs any mismatches it sees so that the developer can then take a look at it to ensure that it is addressed.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>You simply replace all calls to OldAndBusted with calls to ClientWithShadow.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Step 2. Configure migration</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>After you have determined that the two services are indeed functionally alike, we can then prep for migration. Again, object composition helps us set this up cleanly.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Pseudocode for setting up such a migration follows next. Here, I assume that there is a Config object that contains the migration related config.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">class MigrationClient implements ServiceClient {<br>  MigrationClient(ServiceClient oldAndBusted, <br>                  ServiceClient newHotness,<br>                  Config migrationConfig) {<br>    this.oldAndBusted = oldAndBusted;<br>    this.newHotness = newHotness;<br>    this.migrationConfig = migrationConfig;<br>  }<br>  @override<br>  Response process(Request request) {<br>    if (migrationConfig.useNewService(request)) {<br>     return newHotness.process(request);<br>    }<br>    return oldAndBusted.process(request);<br>  }</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>You simply replace all instances of ClientWithShadow with MigrationClient. Yes, it really is that simple! The migration config has all the info it needs to figure out whether a given request should use the new service or the old service.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Step 3. Migrate and clean up</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Here, we do the actual migration. We set up the config to slowly start shifting some of the load from the old service to the new one, while monitoring to make sure everything is going well. We can always roll back the migration by editing the config without actually modifying the code, which is a big deal here.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>After migration to the new service a 100%, you can simply replace MigrationClient instances with NewHotness instances, and delete all the old code (OldAndBusted, ClientWithShadow, and MigrationClient). And you are all cleaned up. Profit!</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>So many wrong ways<br></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Unfortunately, I have seen this done in way too many wrong ways.</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li> I have seen use of inheritance to extend OldAndBusted to NewHotness, and some hacky switch inside the NewHotness implementation to do shadowing and migration.</li><li>I have seen hacky if-else modification of OldAndBusted that the new if-block implementing NewHotness functionality.</li><li>I have seen developers skip shadowing entirely only to cause major service incidents.</li><li>Many more ways that are not that interesting, except for disaster tourism.</li></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>So, object composition is useful, it is powerful, and please use it more!</p>
<!-- /wp:paragraph -->