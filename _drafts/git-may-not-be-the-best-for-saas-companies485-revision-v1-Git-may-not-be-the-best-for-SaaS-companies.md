---
id: 500
title: 'Git may not be the best for SaaS companies'
date: '2019-12-30T09:25:01-05:00'
author: 'Srikanth Sastry'
layout: revision
guid: 'https://srikanth.sastry.name/485-revision-v1/'
permalink: '/?p=500'
---

<!-- wp:image {"id":492,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/12/2C08C1F4-1EF1-44F7-90FA-DB1030628817.jpeg" alt="" class="wp-image-492"/></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Yes, I realize that this is going to be pretty controversial :) Let’s dive in, shall we?</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>In the past half decade or so, Git has sky rocketed in popularity and is becoming the defacto choice for version control. While I understand its popularity, I have found it to be a poor fit for one specific, but popular, environment: SaaS development in a medium to large size enterprise.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Let’s take a quick look at what developing software in a SaaS enterprise is like. For the most part, it involves a significant number of developers concurrently committing code to a single master branch with frequent releases to prod and no long lived branches or versions. In a services environment, it also includes coordinated deployment of multiple services that have complementary server and client API spec.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>While Git has been used in such environments with varying degrees of success, I have seen teams really trying to work around Git rather than Git just work for them. I have seen Git get in the way when teams get large, when teams get siloed into their own branches, when teams starts working with junior developers, and when having to develop across multiple services. While there are mechanisms in Git workflows and tools to mitigate this, it only adds additional complexity to developing software instead of taking it away.</p>
<!-- /wp:paragraph -->

<!-- wp:more -->
<!--more-->
<!-- /wp:more -->

<!-- wp:heading -->
<h2>Scaling Git with team size</h2>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":498,"sizeSlug":"medium"} -->
<div class="wp-block-image"><figure class="aligncenter size-medium"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/12/WjxpQc4-450x395.jpg" alt="" class="wp-image-498"/><figcaption>Git branches for large teams</figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Git serializes all commits. So it does not scale well for large orgs natively. The common way to get around this is with more branching. Each team and developer ends up creating dependent branches from master, and either does a best effort merge into master, or designates one engineer to deal with the mess of merging multiple feature branches into master. Note that all this overhead make sense if you are having named releases and have to maintain multiple versions of the software. But in the SaaS world, you are continuously releasing to prod. There is not need to keep v2.1 around that is 8 weeks old! So all this overhead becomes an artifact of using Git.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Instead, consider Mercurial or Perforce where you can have concurrent commits as long as the commits don’t touch the same files or modules. Here is it much easier to support concurrent updates to master across different engineers who are not working on the same set of files. Granted, this can potentially break build on master despite each of the individual commits not breaking the build, but with a good CI set up, it should be quick to catch and easy to fix. And as a long as the master is in good health, you cut another release and move on.<br>The use of branches in Git brings me to the next issue that I have seen with Git in SaaS software development environments.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Git encourages branching despite conceptually not needing it</h2>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":496,"sizeSlug":"medium"} -->
<div class="wp-block-image"><figure class="aligncenter size-medium"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/12/4994396370_c118bbce78_o-450x318.jpg" alt="" class="wp-image-496"/><figcaption>Source:https://flic.kr/p/8BkA3f<br>License: https://creativecommons.org/licenses/by-nc-sa/2.0/</figcaption></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Anyone who has used Git has heard "never commit directly to master". The common pattern is to create a feature branch for development. Let's consider this for a minute. In a SaaS deployment with continuous release, you want every diff to go into master asap, and have it deployed so that you can iterate faster. With Git, you end up doing this with creating a new branch, committing changes to it, getting it reviewed, and then (if you are smart) squash merging it to master. Now, if a team is developing a feature together, the pattern becomes that of creating a feature branch that everyone commits to, and after the feature is complete, you merge into master. Conceptually, you really just want to "commit directly to master", but in Git bad things can happen with less than well-seasoned developers if you allow it. So you create branches. Effectively, Git is forcing you to create branches.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>This pattern leads to two problems: (1) Large features do not hit prod iteratively in small merges; instead they hit in one large merge to master. This has its own issues with stability and bug discovery earlier during the SDLC. (2) Unless an org is extremely vigilant against branching, you are likely to see long running ‘feature branches’ that compete with the main branch for attention. In practice, this means all fixes end up needing porting across multiple branches and the longer this goes on, the more feature branches diverge from master, which makes merging that much more unpleasant, and so it tends to get postponed making problem worse. Are there workarounds to prevent this from happening? Sure! You can write any sort of framework and tooling around Git. Have I see it often enough to think it’s standard? Not even close!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Really, all you need is to be able to release from master, and if there is a bug, just fix it in master, and keep adding features to master. There is no need for anything more sophisticated.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The above issue with branches is actually the symptom of a bigger attribute of Git: complexity.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Git is complicated; a little too complicated.</h2>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":497,"sizeSlug":"large"} -->
<div class="wp-block-image"><figure class="aligncenter size-large"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/12/push-rejected-rebaseor-merge-38-git-push-force-git-commit-amend-git-25695648.png" alt="" class="wp-image-497"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Git is complicated, and there is no way around it. Git (much like C++) makes it way too easy to shoot yourself in the foot. It gives way too much power to all developers including ones who shouldn’t have it, and don’t want it. As a junior developer, I cannot count the number of times I ended up with a detached HEAD on Git despite doing very simple operations. In general, git makes it very hard to follow simple workflows. It is way too easy to get into a bad state from which recovery is very difficult, if not impossible. But that’s the benign case. Git allows you to do all kinds of crazy stuff including rewrite history. This can be very dangerous in the hands of an inexperienced developer. A bad merge to master can put your report in a state from which rollback is near impossible.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>It is easy to dismiss this argument with “With great power comes great responsibility”, but the fact of the matter is that (1) having inexperience developers is to be expected and your VCS should be robust to their shenanigans, and (2) most developers don’t want to be an Git expert. They just want to be able to write good software without the tools getting in their way, which Git steadfastly refuses to do.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Even with experienced developers, Git can get contentious/tricky. Just ask a bunch of developers if you should merge or rebase, and watch the fireworks that ensues.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Git encourages multiple repos, and that’s not always a good thing</h2>
<!-- /wp:heading -->

<!-- wp:image {"align":"center","id":499,"sizeSlug":"large"} -->
<div class="wp-block-image"><figure class="aligncenter size-large"><img src="https://srikanth.sastry.name/wp-content/uploads/2019/12/32n8q6.jpg" alt="" class="wp-image-499"/></figure></div>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Git does not like large repos; the recommended way around the complexity of a large repo is to split your codebase into multiple repos. This multi-repo approach to services creates a problem in the (micro)services world. Where do you define the source of truth for a service endpoint API spec? This problem is accentuated when using frameworks such as gRPC, or Thrift. Where do you store the Thrift/protobuf message definitions that need to be accessed by both the client code and the server code? Servers and clients are often distinct services that are implemented in different repos. If you define them in the server repo, then how do you ensure that when you change the API spec on the server side, the client will pick that change up as well? (Remember that this is enterprise environment where we control both client and server). Sure you can use git submodules, but that is not without its hassels. Developers could pinky swear to keep the definitions in sync, but we all know how that often goes.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>More generally, Git has encouraged us to move away from mono-repos, and I think that’s a mistake. Note that mono-repo vs multi-repo and monolith vs micro services are completely orthogonal issues. You can have a mono-repo with all micro services implemented in that single repo. Alternatively, you can have a single service implemented across multiple repos. Git’s constraints on scaling for larger code bases has created new set of problems that need working around, but if you were to use a different solution like mercurial or even a centralized version control, then the problem wouldn’t exist in the first place.</p>
<!-- /wp:paragraph -->