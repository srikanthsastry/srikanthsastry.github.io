---
title: 'Unit tests FTW! — Part 4'
published: '2017-11-28T16:21:11-05:00'
tags:
  - 'software engineering'
  - 'software testing'
abbrlink: 'unit-tests-ftw-part-4'
lang: ''
series: 'unit-testing'
series_order: 4
series_label: 'Unit Testing'
series_section: 'Merits'
categories:
  - Professional

---

Cross posted on [LinkedIn](https://www.linkedin.com/pulse/unit-tests-ftw-part-4-srikanth-sastry/)

In the previous three  parts of this series, I have talked about how unit tests are useful in a  lot more than just verifying that your code works. We've talked its  uses for [documentation](http://srikanth.sastry.name/merits-of-unit-tests-part-1/), [refactoring and code health](http://srikanth.sastry.name/the-merits-of-unit-tests-part-2/), and [writing better software](http://srikanth.sastry.name/the-merits-of-unit-tests-part-3/). Next, we'll see how unit tests helps you debug issues in production.

### Debugging

A single unit test is supposed to test a single code path within your
 class. I don't always follow this maxim, but it is nevertheless a very
good rule of thumb. Given that the number of code paths within a given
code if often increases exponentially with the size of the code, unit
tests are often a lot more lines of code than the actual production code
 itself. This is a good thing when it comes to debugging.

If your unit tests cover sufficiently many code paths (which any good
 unit test suite should do), then when an issue arises in production,
and you narrow it down to your code, then you know that the [offending
 code path could not have been the several code paths that your unit
tests already covered](/garden/tests-prune-debugging-search-space/). This pruning makes your debugging a lot simpler
than before.

> Unit tests can prune the possible set of offending code paths to make debugging tractable,

**EXAMPLE**

Let's go back to the example I gave you in [Part 3](https://www.linkedin.com/pulse/merits-unit-tests-part-3-srikanth-sastry/).
 Here is that piece of code. Recall that it takes a large query, splits
it up into multiple subqueries, sends them off in parallel, collects
their responses back, munges them and returns the munged response to the
 caller via a callback

```java
public class QueryManager {
   void sendRequest(Query query, Callback queryCallback) {
     List<Subquery> subqueries = splitQuery(query);
     for (Subquery subquery : subqueries) {
       sendQuery(subquery, new Subquery.Callback() {
           @Override
           public onSuccess(Response response) {
             // Do some processing. ...
             if (allResponses()) {
               queryCallback.finalResult();
              } else {
                queryCallback.incrementalResult();
              }
            }
            @Override
            public onFailure(Error e) {
              // Do some error handling. ...
              if (allResponses()) {
                queryCallback.finalResult();
              }
            }
          });
     }
   }
     // Other methods. ...
}
```

I ran into this code because of an issue that we were seeing in production.

Every so often the logs showed a really really long query that timed
out, but it did manage to serve the response back to the user. Digging
into it some more, I managed to narrow it down to this class. But beyond
 that, things were a mystery. Recall that in my last post I mentioned
how there were no unit tests here, and the code actually needed
refactoring to pull out the anonymous class. We pick up the story here
after all that.

Once I had all the unit tests put in, I discovered that the root cause for the bug is actually a race condition.

The unit tests had ruled out sufficiently many code paths to lead me
to a strong suspicion that it was a race condition in the allresponses()
 function causing two overlapping 'last' responses to both trigger the
incrementalResult() callback function, and so the finalResult() method
was never invoked.

Once you have a candidate cause, reproducing and verifying it becomes
 pretty straightforward (not necessarily easy or simple, but
straightforward), and the rest is just mundane software engineering.

See, unit tests are more than a one trick pony! :)
