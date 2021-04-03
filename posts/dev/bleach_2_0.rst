.. title: Bleach v2.0 released!
.. slug: bleach_2_0
.. date: 2017-03-08 14:00
.. tags: python, dev, bleach, mozilla, story

What is it?
===========

`Bleach <https://bleach.readthedocs.io/>`_ is a Python library for sanitizing
and linkifying text from untrusted sources for safe usage in HTML.


Bleach v2.0 released!
=====================

Bleach 2.0 is a massive rewrite. Bleach relies on the `html5lib
<https://github.com/html5lib/html5lib-python/>`_ library. html5lib 0.99999999 (8
9s) changed the APIs that Bleach was using to sanitize text. As such, in order
to support html5lib >= 0.99999999 (8 9s), I needed to rewrite Bleach.

Before embarking on the rewrite, I improved the tests and added a set of tests
based on XSS example strings from the OWASP site. Spending quality time with
tests before a rewrite or refactor is both illuminating (you get a better
understanding of what the requirements are) and also immensely helpful (you know
when your rewrite/refactor differs from the original). That was time well spent.

Given that I was doing a rewrite anyways, I decided to take this opportunity to
break the Bleach API to make it more flexible and easier to use:

* added Cleaner and Linkifier classes that you can create once and reuse to
  reduce redundant work--suggested in `#125
  <https://github.com/mozilla/bleach/issues/125>`_

* created BleachSanitizerFilter which is now an html5lib filter that can be used
  anywhere you can use an html5lib filter

* created LinkifyFilter as an html5lib filter that can be used anywhere you use
  an html5lib filter including as part of cleaning allowing you to clean and
  linkify in one pass--suggested in `#46
  <https://github.com/mozilla/bleach/issues/46>`_

* changed arguments for attribute callables and linkify callbacks

* and so on


During and after the rewrite, I improved the documentation converting all the
examples to doctest format so they're testable and verifiable and adding
examples where there weren't any. This uncovered bugs in the documentation and
pointed out some annoyances with the new API.

As I rewrote and refactored code, I focused on making the code simpler and
easier to maintain going forward and also documented the intentions so I and
others can know what the code should be doing.

I also adjusted the internals to make it easier for users to extend, subclass,
swap out and whatever else to adjust the functionality to meet their needs
without making Bleach harder to maintain for me or less safe because of
additional complexity.

For API-adjustment inspiration, I went through the Bleach issue tracker and
tried to address every possible issue with this update: infinite loops,
unintended behavior, inflexible APIs, suggested refactorings, features, bugs,
etc.

The rewrite took a while. I tried to be meticulous because this is a security
library and it's a complicated problem domain and I was working on my own during
slow times on work projects. When working on one's own, you don't have benefit
of review. Making sure to have good test coverage and waiting a day to
self-review after posting a PR caught a lot of issues. I also go through the PR
and add comments explaining why I did things to give context to future me. Those
habits help a lot, but probably aren't as good as a code review by someone else.


Some stats
==========

OMG! This blog post is so boring! Walls of text everywhere so far!

There were 61 commits between v1.5 and v2.0:

* Vadim Kotov: 1
* Alexandr N. Zamaraev: 2
* me: 58

I closed out 22 issues--possibly some more.

The rewrite has the following ``git diff --shortstat``::

   64 files changed, 2330 insertions(+), 1128 deletions(-)

Lines of code for Bleach 1.5::

   ~/mozilla/bleach> cloc bleach/ tests/
         11 text files.
         11 unique files.                              
          0 files ignored.

   http://cloc.sourceforge.net v 1.60  T=0.07 s (152.4 files/s, 25287.2 lines/s)
   -------------------------------------------------------------------------------
   Language                     files          blank        comment           code
   -------------------------------------------------------------------------------
   Python                          11            353            200           1272
   -------------------------------------------------------------------------------
   SUM:                            11            353            200           1272
   -------------------------------------------------------------------------------
   ~/mozilla/bleach> 


Lines of code for Bleach 2.0::

   ~/mozilla/bleach> cloc bleach/ tests/
         49 text files.
         49 unique files.                              
         36 files ignored.

   http://cloc.sourceforge.net v 1.60  T=0.13 s (101.7 files/s, 20128.5 lines/s)
   -------------------------------------------------------------------------------
   Language                     files          blank        comment           code
   -------------------------------------------------------------------------------
   Python                          13            545            406           1621
   -------------------------------------------------------------------------------
   SUM:                            13            545            406           1621
   -------------------------------------------------------------------------------
   ~/mozilla/bleach> 


Some off-the-cuff performance benchmarks
========================================

I ran some timings between Bleach 1.5 and various uses of Bleach 2.0 on the
`Standup <https://standu.ps>`_ corpus.

Here's the results:

========================================  =========================
what?                                     time to clean and linkify
========================================  =========================
Bleach 1.5                                1m33s
Bleach 2.0 (no code changes)              41s
Bleach 2.0 (using Cleaner and Linker)     10s
Bleach 2.0 (clean and linkify--one pass)  7s
========================================  =========================


How'd I compute the timings?

1. I'm using the Standup corpus which has 42000 status messages in it. Each
   status message is like a tweet--it's short, has some links, possibly has HTML
   in it, etc.

2. I wrote a timing harness that goes through all those status messages and
   times how long it takes to clean and linkify the status message content,
   accumulates those timings and then returns the total time spent cleaning and
   linking.

3. I ran that 10 times and took the median. The timing numbers were remarkably
   stable and there was only a few seconds difference between the high and low
   for all of the sets.

4. I wrote the median number down in that table above.

5. Then I'd adjust the code as specified in the table and run the timings again.


I have several observations/thoughts:

First, holy moly--1m33s to 7s is a **HUGE performance improvement**.

Second, just switching from Bleach 1.5 to 2.0 and making no code changes (in
other words, keeping your calls as ``bleach.clean`` and ``bleach.linkify``
rather than using ``Cleaner`` and ``Linker`` and ``LinkifyFilter``), gets you a
lot. Depending on whether your have attribute filter callables and linkify
callbacks, you may be able to just upgrade the libs and WIN!

Third, switching to reusing ``Cleaner`` and ``Linker`` also gets you a lot.

Fourth, your mileage may vary depending on the nature of your corpus. For
example, Standup status messages are short so if your text fragments are larger,
you may see more savings by clean-and-linkify in one pass because HTML parsing
takes more time.


How to upgrade
==============

Upgrading should be straight-forward.

Here's the minimal upgrade path:

1. Update Bleach to 2.0 and html5lib to >= 0.99999999 (8 9s).

2. If you're using attribute callables, you'll need to update them.

3. If you're using linkify callbacks, you'll need to update them.

4. Read through `version 2.0 changes
   <http://bleach.readthedocs.io/en/v2.0/changes.html#version-2-0-march-8th-2017>`_
   for any other backwards-incompatible changes that might affect you.

5. Run your tests and see how it goes.


.. Note::

   If you're using html5lib 1.0b8, then you have to explicitly upgrade the
   version. 1.0b8 is equivalent to html5lib 0.9999999 (7 9s) and that's not
   supported by Bleach 2.0.

   You have to explicitly upgrade because pip will think that 1.0b8 comes
   *after* 0.99999999 (8 9s) and it doesn't. So it won't upgrade html5lib for
   you.

   If you're doing 9s, make sure to upgrade to 0.99999999 (8 9s) or higher.

   If you're doing 1.0bs, make sure to upgrade to 1.0b9 or higher.


If you want better performance:

1. Switch to reusing ``bleach.sanitizer.Cleaner`` and
   ``bleach.linkifier.Linker``.


If you have large text fragments:

1. Switch to reusing ``bleach.sanitizer.Cleaner`` and set ``filters`` to include
   ``LinkifyFilter`` which lets you clean and linkify in one step.


Many thanks
===========

Many thanks to James Socol (previous maintainer) for walking me through why
things were the way they were.

Many thanks to Geoffrey Sneddon (html5lib maintainer) for answering questions,
helping with problems I encountered and all his efforts on html5lib which is a
huge library that he works on in his spare time for which he doesn't get
anywhere near enough gratitude.

Many thanks to Lonnen (my manager) who heard me talk about html5lib zero point
nine nine nine nine nine nine nine nine a bunch.

Also, many thanks to Mozilla for letting me work on this during slow periods of
the projects I should be working on. A bunch of Mozilla sites use Bleach, but
none of mine do.


Where to go for more
====================

For more specifics on this release, see here:
https://bleach.readthedocs.io/en/latest/changes.html#version-2-0-march-8th-2017

Documentation and quickstart here:
https://bleach.readthedocs.org/en/v2.0/

Source code and issue tracker here:
https://github.com/mozilla/bleach
