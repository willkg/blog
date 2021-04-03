.. title: Year end: 2010
.. slug: year_end_2010
.. date: 2011-01-05 13:26:53
.. tags: miro, work

I'm really proud of the work we did this year. Miro went through two
major version releases that added support for conversions and subtitles,
fixed a lot of issues, and fixed a lot of performance issues. Behind the
scenes, we reworked the Windows build environment making building Miro
on Windows sooooo much easier. We also switched from our home-grown
httpclient to libcurl for faster, better HTTP downloads. We drastically
improved our QA and testing. We migrated from Trac to Mediawiki for
documentation.

Then in August, Nick stepped up to home plate, hefted his bat a few
times, then pointed his finger clear across the field into the stands.
Thus started the very aggressive and ambitious Miro 4.0 development
cycle. The earth-shaking thunder of changes hitting git master has been
growing into a deafening roar.

But the fun doesn't stop there! `Miro
Community <http://www.mirocommunity.org/>`__ has come a long way in the
last year. There are dozens of really great Miro Community communities
now and I regularly see urls to Miro Community site pages in Stack
Overflow, forum conversations, blog posts, ....

Additionally, `Universal Subtitles <http://universalsubtitles.org/>`__
has gone from a gleam in someone's eye to a system for collaborating on
subtitles and translating subtitles for videos across the Internet.
Translating video and making it accessible to people is so important.
This system is making that magic happen. It's awesome.

It's been a huge year for PCF and the projects we work on.

I want to bring it back down to the project I work on: Miro. `Last
year <http://bluesock.org/~willkg/blog/miro/year_end_2010.html>`__ I
wrote a year-end post with some stats I culled from Bugzilla and git
along with some commentary. I do so again this year.

**Bugzilla stats:**

I took a look at last year's overall stats and I have no idea where I
got those numbers. So I tweaked my script and produced new stats.

::

   Last Year's Overall statistics
   ------------------------------
                                     2007  2008  2009
   Opened reports at end of year:     453   705  1102  
   Opened:                           4052  1625  1593
   Closed:                           4368  2032  1654  
   Users created:                     644  1083   771  
   Comments created:                13564  7529  8329  


   Overall statistics (recalculated)
   ---------------------------------
                                     2007  2008  2009  2010
   Opened reports at end of year:     453   705  1102   720
   Created:                          3805  1518  1162   968
   Resolved:                         1038  1842  1157  1197
   Comments created:                12588  6749  6191  6843
   Users created:                     644  1083   771   611

"Opened reports at end of year" is the total number of opened bugs at
the end of that year. So at the end of 2007, we had 453 open bugs. At
the end of 2008, we had 705 open bugs, ...

As a reminder, we switched from Trac to Bugzilla half-way through 2007
which drastically reduced the amount of bug and comment spam we were
getting and dealing with.

Looking at the overall statistics and the recomputed set, the new
numbers are lower. I think the old numbers involved all bugs in our
Bugzilla instance--Miro and non-Miro bugs. Prior to 2009, that was
pretty much the only project we were working on, so the numbers made
more sense. Now that Miro Community, Miro Video Converter and Universal
Subtitles are using Bugzilla, we need to explicitly focus on Miro bugs.

We have the same problem with the Bugs closed by activity data I did for
last year.

The drop in total opened bugs for 2010 happened because a bunch of us
did a massive triage campaign at the end of December and resolved a lot
of old, stale bugs.

::

   Bugs closed by activity (old set)
   ---------------------------------

                2007  2008  2009
   fixed         736   932   969
   invalid       170   133    85
   wontfix        35   142    71
   duplicate     139   313   190
   worksforme    169   344   151
   incomplete      0    57    84


   Bugs closed by activity (recalculated)
   --------------------------------------

                2007  2008  2009  2010
   fixed         545   887   648   570
   invalid       167   126    72    83
   wontfix        34   135    49   160
   duplicate     132   305   173   141
   worksforme    160   335   133    87
   incomplete      0    54    82   156

For most of 2010, there were only two and a half developers working on
Miro. We've picked up Geoffrey and Kaz and Paul has come back from Miro
Community, so we're churning through fixes faster now. But it's
definitely the case that the lower number of fixed bugs is due to
reduced staff.

::

   Top 10 bug reporters:
   --------------------

        252 - Janet [pcf QA]
        100 - Will Kahn-Greene [pcf dev]
         51 - Geoffrey Lee
         47 - Ben [pcf_dev]
         26 - Nicholas Reville
         23 - Kaz Wesley
         12 - Paul Swartz [PCF dev]
         11 - m.shamraeva (qa-team)
         10 - Dean Jansen
          6 - Nicuta Nicolae

Of the 968 bugs created in 2010, 532 were reported by Miro developers
and Janet's QA team.

I'm skipping the top 10 closers this year since it's not clear that
number is very meaningful.

::

   Top 10 bug commenters:
   ---------------------

       3417 - Will Kahn-Greene [pcf dev]
       1111 - Janet [pcf QA]
        525 - Ben [pcf_dev]
        388 - Geoffrey Lee
        192 - Paul Swartz [PCF dev]
        137 - Nicholas Reville
        113 - Luc Heinrich
         64 - Kaz Wesley
         24 - David Stoll
         16 - Dean Jansen

Most of these people are PCF staff. David Stoll is not--he helped a ton
in fixing httpauth and http proxy issues for Miro 3.5.

**Git stats**

In 2010, we did 6 releases (2 major, 4 bugfix). We did 14 releases if
you include release candidates. Version 3.0 added subtitles and a lot of
performance fixes. Version 3.5 added http proxy and auth support, switch
to libcurl, conversions and a lot of polish and some performance fixes.

| Between Miro 2.5 and 3.0:
| 1017 files changed, 190346 insertions(+), 280726 deletions(-)
| 667 checkins

| Between Miro 3.0 and 3.5:
| 1021 files changed, 307395 insertions(+), 253431 deletions(-)
| 606 checkins

Paul, Geoffrey and Kaz hopped on the Miro team post 3.5, so I think it's
interesting to measure changes between 3.5 and HEAD:

| Between Miro 3.5 and git master HEAD:
| 552 files changed, 31627 insertions(+), 22898 deletions(-)
| 521 checkins

You'll notice the number of insertions and deletions is an order of
magnitude smaller--a lot of that churn happens before a release when I
sync translations. I haven't synced translations in git master for 4.0,
yet, so the insertion/deletion numbers are much lower.

In 2009, we did 1,382 commits. In 2010, we did 1,341 commits.

**Contributor stats**

In 2009, we had 19 contributed fixes. I doubt I checked in that many
patches this year, but I don't have good stats for that this year.

Having said that, with Miro 3.5 we introduced a CREDITS file which is a
much more comprehensive list of contributors since it covers people who
report bugs, comment on bugs, fix bugs, translate, help with QA, donate
money, ... This CREDITS file will be a better measure of how we're doing
contributor-wise than looking at Bugzilla stats alone was. I still need
to figure out a better method for figuring out who has helped with
translations, testing nightlies, and supporting other Miro users --
those areas are important, but more difficult to quantify.

We continued to work on reducing the barriers to entry for contributing
to Miro:

* We switched from Trac to Mediawiki which will make it much easier to
  write, edit, and curate documentation on the project.
* We hired Asheesh from `OpenHatch <http://openhatch.org/>`__ to help
  us figure out how to build a community of contributors.
* We overhauled the Windows build environment making it possible for
  people to build Miro on Windows. Prior to this work, we were using
  Python 2.5 and Visual Studio 2003 which wasn't available.
* We continued triaging bugs and adding the "bitesized" keyword to bugs
  we think would be easier for new contributors to work on.

There's always more work to do.

**Summary**

The Miro 2.5 release in 2009 sucked. We've made a lot of improvements to
our infrastructure, process, and code quality since then. 2010 was a
good year and we got a lot accomplished despite having a painfully small
number of staff for most of the year.

I'd love to see more contributions from other people. If you have some
free time or some passion and want to help out, let me know. If you
don't have free time, but have some spare change floating around, please
`donate <https://www.miroguide.com/donate>`__--this helps PCF pay for
staff to work on Miro. Having more staff and more contributors
absolutely affect Miro's speed of growth.

Also, contributing to Miro gets your name in the Credits! I got my name
in the Firefox 3.0 credits for work I did and it was one of the
highlights of my year.
