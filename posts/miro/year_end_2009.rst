.. title: Year end: 2009
.. slug: year_end_2009
.. date: 2010-01-02 13:59:00
.. tags: miro, work

This was a pretty big year for the Miro project and the first year for
the Miro Community project. In Miro-land, we pushed out Miro 2.0 which
was a complete re-write of the user interface. Then we pushed out Miro
2.5 which was a rewrite of the storage/database layer. We also switched
from svn to git. That's three really big changes for a single project in
one year.

Miro 2.5 was a messy release and we've made a bunch of changes so we
don't have to go through that again. We've been spending time on the
unit test, QA automation, and code quality for Miro 2.6. We've changed
the release process so that it buffers more time to catch issues. We're
doing more peer review of complex code changes. The switch to git will
help since branching and merging are much easier and less error-prone.

**Bugzilla stats:**

::

   Overall statistics
   ------------------
                                     2007  2008  2009
   Opened reports at end of year:     453   705  1102
   Opened:                           4052  1625  1593
   Closed:                           4368  2032  1654
   Users created:                     644  1083   771
   Comments created:                13564  7529  8329

"Opened reports at end of year" is the total number of opened bugs at
the end of that year. So at the end of 2007, we had 453 open bugs. At
the end of 2008, we had 705 open bugs, ...

I wasn't sure whether to include 2007 or not since half way through that
year we switched from Trac to Bugzilla. No one needed to create an
account in Trac, so user numbers should be lower. Also, we were getting
a lot of Trac spam, so comment, opened and closed numbers were much
higher.

::

   Bugs closed by activity:
   ------------------------
                2007  2008  2009
   fixed         736   932   969
   invalid       170   133    85
   wontfix        35   142    71
   duplicate     139   313   190
   worksforme    169   344   151
   incomplete      0    57    84

I thought this was an interesting data set.

The INCOMPLETE status was added mid-2008. We use this for whenever we
ask a user for some information that we need to work on a bug and the
user never gets back to us. It's better than marking it as INVALID or
WORKSFORME since it's easier to find this set of bugs that were pushed
to the side because need more information.

We're fixing on average 3 bugs a day--that's pretty impressive.

::

   Top 10 bug reporters:
   --------------------
      444 - Janet (PCF)
      183 - Anne Jonas (PCF)
       71 - Will Kahn-Greene (PCF)
       71 - Dean Jansen (PCF)
       42 - Nicholas Reville (PCF)
       39 - sg
       37 - Keith Lard
       28 - Uwe Hermann
       28 - Ben Dean-Kawamura (PCF)
       22 - Pan  ~ dietmar

Out of 1593 bugs, PCF employees reported 839--that's just over half. Of
the non-PCF people in this list, Uwe is the Debian packager for Miro and
Pan is an OpenSUSE packager for Miro. sg and Keith Lard both run OSX.

::

   Top 10 bug closers:
   ------------------
      421 - Janet (PCF)
      369 - Paul Swartz (PCF)
      353 - Will Kahn-Greene (PCF)
      195 - Ben Dean-Kawamura (PCF)
      114 - Luc Heinrich (PCF)
       26 - Christopher Webber (PCF)
       21 - Dean Jansen (PCF)
       20 - sg
       19 - Anne Jonas (PCF)
       14 - Nicholas Reville (PCF)

::

   Top 10 bug commenters:
   ---------------------
     2050 - Janet (PCF)
     1757 - Will Kahn-Greene (PCF)
      823 - Paul Swartz (PCF)
      533 - Ben Dean-Kawamura (PCF)
      354 - Anne Jonas (PCF)
      254 - Nicholas Reville (PCF)
      234 - Dean Jansen (PCF)
      187 - Luc Heinrich (PCF)
       98 - sg
       88 - Uwe Hermann 

**Git stats**

Moving along, I can now get stats out of our git repository. git ftw!

In 2009, we did 11 releases (22 releases if you include release
candidates) of which 2 were MASSIVE code overhaul releases. Miro 2.0
involved a re-write of the user interface using native widgets which
resulted us in dropping 4,000 files from the codebase (a large portion
of that was probably locale-related). Miro 2.5 involved a re-write of
the database layer. We had a lot of bug fix releases to stabilize things
after these two big releases.

Between Miro 1.0 and 1.1: 1606 files changed, 127775 insertions(+),
14605 deletions(-)

Between Miro 1.1 and 1.2: 2318 files changed, 233370 insertions(+),
185511 deletions(-)

Between Miro v1.2 and v2.0: 4715 files changed, 271506 insertions(+),
560366 deletions(-)

Between Miro v2.0 and v2.5: 662 files changed, 169258 insertions(+),
175292 deletions(-)

Half of the 2.0 work and all of the 2.5 work was done in 2009. 2.0 was
clearly a monumental release like no other release we've ever done.

In 2009, we did 1,382 commits. For comparison, we did 2,049 commits in
2008. The bulk of the work for Miro 2.0 was done at the end of 2008--I
think that accounts for the large discrepancy here.

**Contributor stats**

I don't have stats for testing contributions or translation
contributions so I can't speak to those. I can only speak to patches and
bug triage contributions.

In 2009, we had 19 contributed fixes/features. PCF employees are doing
the bulk of the work. This is still an area we could use help with.

In 2009, we've done a lot to lower the barriers to entry and make this
easier: improved code quality, wrote documentation, improved build
documentation, improved build scripts, added unit tests, ... In 2010,
we're continuing this work.

**Summary**

Despite the Miro 2.5 release which was pretty rocky, I think we had a
really good year and got a lot accomplished. I'm looking forward to Miro
2.6 (or whatever the next release gets called).

I'd love to see more contributions from other people. If you have some
free time or some passion and want to help out, let me know. If you
don't have free time, but have some spare change floating around, please
donate--this helps PCF pay for employees to work on Miro.
