.. title: Socorro: migrating to Python 3: retrospective (2018)
.. slug: socorro_python3
.. date: 2018-12-14 10:00
.. tags: mozilla, work, python, socorro, story

Project
=======

:scope: Socorro and Mozilla sites
:period: 2 years
:impact: migrated Socorro to Python 3 and paved the way for other Mozilla sites


Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the Breakpad
crash reporter asks the user if the user would like to send a crash report. If
the user answers "yes!", then the Breakpad crash reporter collects data related
to the crash, generates a crash report, and submits that crash report as an HTTP
POST to Socorro. Socorro saves the crash report, processes it, and provides an
interface for aggregating, searching, and looking at crash reports.

This blog post talks about the project migrating Socorro to Python 3. It covers
the incremental steps we did and why we chose that path plus some of the
technical problems we hit.


.. TEASER_END

It all began...
===============

It all began when I switched from MDN to Socorro in March 2016. I joined the
Socorro team and then spent a while coming up to speed. There was a ton of
technical debt and we were in a new AWs-based infrastructure. There were a lot
of problems and growing pains. Generally things were working, but in rough
shape.

I spent some time breaking off the collector and rewriting it from scratch in
Python 3. That was the `Antenna <https://github.com/mozilla-services/antenna/>`_
project. Our thinking at the time was that we would break off components and
rewrite them in Python 3 one at a time. That worked really well for the
collector because it was pretty distinct from the rest of the pipeline and
didn't need to share any code. I wrote about that project in
:doc:`<antenna_project_wrapup>`.

That left crontabber, the processor, and the webapp which were tangled up
around ownership and usage of PostgreSQL and Elasticsearch. Carving another
component out was doable, but there were a lot of consequences that I wasn't
enthused about.


Figuring out the project scope
==============================

At this point, I started mulling over what a Python 3 migration project looked
like. What was the end goal? What were the requirements we needed to meet over
the course of the project?

I never codified these, but I was thinking along these lines:

1. **Migrate existing codebase in-place.** We couldn't carve out other
   components and rewrite them because they were too tangled. We had to fix the
   existing codebase.

2. **Don't break the crash ingestion pipeline.** We couldn't disrupt the
   service. Socorro is the crash ingestion pipeline for Firefox and Firefox for
   Android as well as other products. While we were doing this migration,
   release management and engineering were working on a huge rewrite of large
   parts of Firefox. Problems with crash ingestion or analysis tools would
   seriously affect that work. Firefox 57 was a critical release. We couldn't
   mess that up--heads would roll.

3. **Progress had to be in small steps.** We had an unstable environment to work
   in. We had re-orgs, staff turnover, infrastructure moves, etc. We needed to
   be able to work on and land small steps towards the big goal otherwise we'd
   never make any progress. Steps that took a week or less were ideal.

4. **The schedule had to be flexible.** Engineering priorities kept changing and
   other things were going on. I wanted to be able to keep marching on this
   project amid (and despite) everything else. No drop-dead dates, no death
   marches, no goals, etc. Just the quiet pitter-patter of rain on the roof.

Large codebase. Do it in small steps. Keep the service running. This is a recipe
for a long-term project.


High level course of the migration project
==========================================

At this point, I started doing some basic project pre-work that needed to
get done before we could plan anything. That was roughly the following:

1. audit the tests
2. build a local development environment
3. remove unused code
4. address dependencies

After that, I had a better idea of where everything was at and around October
2017, I wrote up ":bz:`1406703` [tracker] switch to python 3". That tracked
the rest of the work we needed to do to migrate Socorro to Python 3. Roughly it
was this set of steps:

5. lint the code with flake8 in Python 3 and fix issues
6. get tests passing in Python 3
7. get the project running in Python 3
8. remove Python 2 things and six-isms

Let's talk about all those steps.


The pre-work
============

Audit the tests
---------------

First thing I did was go through the test suite to see what it was like. I was
new-ish on the project, so I had no idea.

Socorro's tests were comprehensive in some places and not so much in other
places. There was a lot of mocking. Some things had no tests at all.

If this was a library, I would have spent time fleshing out the test suite.
Having a high quality test suite makes porting to Python 3 a lot easier and less
risky.

Since this isn't a library and it was very very large with lots of stuff I
didn't understand, I decided to defer spending a lot of time fixing tests
until I needed to.

I did take the time to switch the codebase from nose to pytest and
clean up some of the test infrastructure.

We also switched on "warnings are considered errors" and fixed a bunch of
deprecation warnings.


Build a local development environment
-------------------------------------

When I started, there wasn't a good local development environment for Socorro,
so I couldn't really run Socorro locally without a lot of work. I needed an
environment that I could build, throw away, reset, etc. This would make it a lot
easier to do migration work in isolation without the day-to-day ongoing
development, maintenance, and running of the project.

I wrote about that work in
:doc:`Socorro local development environment <socorro_dev_env>`.


Remove unused code
------------------

When I took over Socorro, one of the first things I did was change the mission.
The mission used to be something like:

  Socorro is an open source project covering all the parts you need to build a
  crash ingestion pipeline--oh, and we also used it at Mozilla".

I had no idea who else was using Socorro. I never heard from users of Socorro or
if I had, I had no idea who they were. I had no list of users of Socorro that I
could communicate with. 99.9% of development work and costs were borne by
Mozilla. It sucks, but we couldn't continue doing that.

I changed the mission to:

  Socorro is an open source project to build the crash ingestion pipeline of
  Mozilla.

Doing that gave me freedom to remove a lot of code and abstraction layers that
we didn't use. I tried to make the changes in such a way that there was still
some flexibility and someone could use Socorro to run their crash ingestion
pipeline, but even so, I removed a lot of stuff.

Thus began a lot of code removal which I did over the course of the entire
Python 3 migration project and not just in the pre-work stage.

When I started working on Socorro in March 2016, Socorro looked like this::

  --------------------------------------------------------------------------------
  Language                      files          blank        comment           code
  --------------------------------------------------------------------------------
  JSON                            136             21              0         362812
  Python                          550          17048          21384          85228
  JavaScript                       97           5107           3730          31059
  HTML                             82            822             24           6552
  C++                              11            795            466           5938
  SQL                             157            857            582           5039
  LESS                             20            124             60           3182
  CSS                              18            434            253           2663
  Bourne Shell                     42            336            365           1554
  C/C++ Header                     12            322            608           1253
  MSBuild script                    3              0              0            463
  Puppet                            2             26              1            183
  make                              3             42              7            166
  DOS Batch                         1             21              1            148
  Bourne Again Shell                2             18             22            104
  INI                               1             12              0             37
  YAML                              2              7              0             28
  Mako                              1             10              0             20
  Markdown                          1             10              0             18
  --------------------------------------------------------------------------------
  SUM:                           1141          26012          27503         506447
  --------------------------------------------------------------------------------


Now (December 13th, 2018 after the Python 3 migration) it looks like this::

  -------------------------------------------------------------------------------
  Language                     files          blank        comment           code
  -------------------------------------------------------------------------------
  Python                         292           8501           6703          41011
  JSON                            92             21              0          12994
  C++                             11            827            474           6095
  HTML                            51            487             19           4281
  JavaScript                      44            637            794           3443
  LESS                            36            287             51           2712
  C/C++ Header                    12            322            614           1259
  CSS                              3             27             53            704
  MSBuild script                   3              0              0            463
  Bourne Shell                    21            166            253            421
  YAML                             3             29             34            232
  make                             3             36             15            142
  Dockerfile                       1             15             13             37
  INI                              1              0              0              8
  -------------------------------------------------------------------------------
  SUM:                           573          11355           9023          73802
  -------------------------------------------------------------------------------


<understatement>We removed some stuff.</understatement>


Address dependencies
--------------------

Socorro has a lot of dependencies. Some of them are libraries we extracted out
of Socorro and so that other people could use them (configman, crontabber, etc).
Some of them were written by other Mozillians for other projects that we used
(poster, etc). Some of them we added to Socorro for one reason or another, but
then many years later, we're not using it anymore, but it's still hanging around
because it's really hard to know which dependencies are used. Some dependencies
are now unmaintained. Some dependencies were deprecated in favor of other
libraries. Some never made the transition to Python 3.

Before we did anything, we did an audit of all the dependencies in the
requirements file. Then we worked through the issues like this:

1. **Redo how we manage dependencies.**

   Osmose split our massive requirements file into two files--a default
   file with first-order dependencies and a constraints file with everything
   those dependencies need.

   Then Osmose changed how dependencies are installed and used the ``-c`` flag
   for the constraints file. That way we can specify versions of what we use and
   hashes and if a dependency listed in the constraints file isn't explicitly
   pulled in by one of the other dependencies, it's ignored and not installed.

2. **Removed any dependencies that weren't being used.**

   When splitting the requirements file, Osmose removed any dependencies that
   weren't being used.

3. **Update dependencies to recent versions.**

   Osmose set us up with `pyup <https://pyup.io/>`_ to keep dependencies up
   to date and we did a few passes on updating dependencies to recent versions.

4. **Remove unmaintained dependencies and dependencies that didn't support Python 3.**

   I didn't want to keep using unmaintained dependencies and at this point if
   a library didn't support Python 3, I figured that was a sign to stop using it.
   Some libraries were deprecated in favor of other libraries.

   I went through and checked the maintenance and Python 3 status of everything
   and rewrote code to remove things that needed to be removed.


This took a while, but it made our dependency situation a lot better.


Done with pre-work
------------------

At this point we were done with the pre-work and could start working on getting
things to run in Python 3.

Pre-work is super important. First off, a lot of this was addressing technical
debt that had accrued over the years. All projects have that in common. It's
good to deal with that before moving forward because now we had less code to
fix, we knew what our dependency situation was, we had better testing situation,
and we knew what we could rely on to help us out.

Yay pre-work!


The migration
=============

Lint the code with flake8 in Python 3 and fix issues
----------------------------------------------------

Linting is an easy first step to do since it's easy to automate and it produces
a list of issues. We set up some scaffolding to run flake8 in a Python 3 Docker
container and did iterations of run-and-fix until the codebase passed in flake8
in both Python 2 and Python 3.

Ced was one of our Summer 2018 interns and took this on. He fixed issues
stemming from Python 3 dropping ``.iterkeys()``, ``.itervalues()``, and
``.iteritems()`` from dict. He removed uses of ``xrange`` and ``raw_input``.

He fixed issues with raising exceptions. There were many "exception handling"
sections of code that would capture exception data, do some stuff, and then
re-raise the original exception. Most of these had to be reworked. The easiest
thing to do was adjust the code to use ``six.reraise``.

Ced also changed instances of ``str`` and ``unicode`` to appropriate six-isms.

Through all of these changes, we took care to make sure we didn't introduce
behavioral changes when running in Python 2.


Get tests passing in Python 3
-----------------------------

Initially, the tests failed all over the place. We wrote some scaffolding to
run specific "known-good" tests in pytest in a Python 3 Docker container. In
this way, we could fix all the issues in a test file and then add it to the
"known-good" list and keep moving incrementally forward.

Socorro has two test suites--one for everything in ``socorro/`` and one for
everything in ``webapp-django/``. The ``socorro/`` suite test runner script
looked like this:

.. code:: shell

   #!/bin/bash

   # This Source Code Form is subject to the terms of the Mozilla Public
   # License, v. 2.0. If a copy of the MPL was not distributed with this
   # file, You can obtain one at http://mozilla.org/MPL/2.0/.
   
   # This script marks all the tests we know work in Python 3.
   #
   # Usage: ./docker/run_tests_python3.sh
   
   # This is the list of known working tests by directory/filename. When you
   # have tests in a directory/file working, add it to this list as a new line.
   WORKING_TESTS=(
       socorro/signature/tests/test_*.py
       # socorro/unittest/app/test_*.py
       # socorro/unittest/cron/test_*.py
       # socorro/unittest/cron/jobs/test_*.py
       # socorro/unittest/external/test_*.py
       # socorro/unittest/external/boto/test_*.py
       # socorro/unittest/external/es/test_*.py
       # socorro/unittest/external/fs/test_*.py
       # socorro/unittest/external/postgresql/test_*.py
       # socorro/unittest/external/rabbitmq/test_*.py
       # socorro/unittest/lib/test_*.py
       # socorro/unittest/processor/test_*.py
       # socorro/unittest/processor/rules/test_*.py
       # socorro/unittest/scripts/test_*.py
   )

   pytest ${WORKING_TESTS[@]}


We did PRs by directory-by-directory so we could make incremental progress
without worrying about bit rot and long-running branches.

We had the Python 3 tests running in CI so that work being done elsewhere didn't
cause us to regress.

Ced worked on ``socorro/unittest/lib/`` and ``socorro/unittest/external/``
directories. One of the issues he kept hitting was code that was throwing around
"string" data willy-nilly and in some cases it was binary data and in other
cases it was string data with unknown encoding. Each of these bits of code and
all its callers needed to be painstakingly analyzed and in some cases rewritten
to be correct in Python 3 which is less willy-nilly about binary vs. string
data. I think these were the hardest issues to deal with.

Ced worked on issues where strings differ between Python 2 and Python 3 and we
had to adjust the tests to be less specific about the contents of the string.
This was particularly a problem with tests that asserted things about exception
strings.

Ced fixed a bunch of code that used ``Queue`` and ``urlparse`` and friends to
use six to import those things.

Ced fixed a bunch of places where the code expected a list, but in Python 3, the
thing returns an iterable. For example, in Python 3 ``.keys()`` on a dict
returns an iterable and no longer returns a list.

Lonnen fixed test code that was raising ``StopIteration`` in the test to make
assertions about generator code.

Lonnen hit problems with a module we had in Socorro that wrapped operations in a "transactional"
like thing and also did retrying. It looked at attributes of the connection
class to determine which exceptions were retryable. However, it did something
like this:

.. code:: python

   while True:
       try:
           fun_operation(connection, *args, **kwargs)
       except connection.retryable_exceptions:
           backoff = connection.get_backoff()
       time.sleep(backoff)


The problem was connection classes that had ``retryable_exceptions`` set to
``()`` -- Python 2 was fine with that, but it made Python 3 very grumpy.

Lonnen suggested we change it to ``except Exception as exc:`` and then check the
exception types. That would have worked. In my investigations, I decided this
code was trying to do too many things and it made the callers much harder to
read. I couldn't tell which invariants were being upheld for which callers. So I
decided it was better to refactor the code and I broke it up into a
transactional context manager and a retry function.

Then I rewrote all the exception-handling code in the processor of which there
were several layers and it was unclear which layer was enforcing which
invariants and where exceptions were getting silenced and thrown out.

I also spent some time at this stage to finish up the work that Peter and Adrian
started in fixing the processor error handling such that it always sent errors
to Sentry. That way when we deployed the Python 3 version of things, it wouldn't
silently fail but instead explode in great fiery plumes of spectacle if there
were problems.


Get the project running in Python 3
-----------------------------------

At this point, we had a lot less code. What remained passed linting and passed
tests. We had an isolated local development environment we could run everything
in and scaffolding for doing integration tests to make sure all the individual
parts work. This was a good position to be in. I felt pretty confident in the
state of things.

Getting crontabber, the processor, and the webapp running in Python 3 took a
couple of hours--that's it. I hit one minor issue in the rabbitmq code where a
method was returning bytes and the thing that was consuming the returned value
did the wrong thing with it. That didn't pop up in tests because the test code
is all mocked out and didn't test reality.

I fixed that issue and then removed all the scaffolding and extra bits we had to
run the project with Python 2, but also do linting and testing in Python 3. I
updated documentation and project metadata.

I wrote up a test plan and went through it with my local development
environment. I wrote up a list of things to look at after it landed on stage to
make sure everything was working correctly.

Then I landed it.

Then it deployed.

I watched logs, dashboards, and Sentry. I ran through the test plan again.
Everything was fine; no issues. It was so uneventful that I had to write an
email to tell everyone we were on Python 3 now.

We still have to push it to prod, but we're in code-freeze until January. That's
good because it'll let the code bake on stage for a while.


Remove Python 2 things and six-isms
-----------------------------------

I haven't finished this stage, yet. Cleanup is important and I'll be doing this
in dribs and drabs over the next month.

One nice thing about standardizing on fixing things with six is that it sticks
out in the code. Spotting and removing six-isms is straight-forward.

I did spend some time removing code that was checking ``six.PY2`` and
``six.PY3`` and doing different things depending on which it was using. I also
removed the ``from __future__ import ...`` statements which we no longer needed.


Done with migration!
--------------------

Regardless of some outstanding work and the fact that it's only in stage and not
in prod, yet, I'm calling the project effectively done.

We ended up on Python 3.6. I'd like to upgrade to 3.7, but need to figure out
some build issues in order to do that.

I look forward to asyncio, data classes, cascading exceptions, and a lot of
other things in Python 3.


Related bugs
============

There were a lot of bugs involved. Plus while working on unrelated bugs, I did
some Python 3 changes.

Here are some of them:

* :bz:`1322525` dockerize the repo

  * :bz:`1468815` squash docker images into a single highlander image
  * bunch of other bugs tweaking the Docker environment for better local
    development

* :bz:`1361764` switch to pytest for processor/middleware/external tests (not webapp)
* :bz:`1405675` switch to pytest for webapp
* :bz:`1419585` Make warnings into errors during test runs and fix existing warnings
* :bz:`1407449` redo requirements using a constraints file
* :bz:`1478080` vendor and fork crontabber
* :bz:`1504067` remove unittest.TestCase usage
* :bz:`1479097` clean up sentry code in processor
* :bz:`1471299` collapse fs crashstorage class hierarchy
* :bz:`1406703` [tracker] switch to python 3

  * :bz:`1362434` Send ALL processor exceptions to Sentry
  * :bz:`1426257` cleanup ProcessorApp._transform()
  * :bz:`1460035` implement python 3 test scaffolding
  * :bz:`1460707` fix python 3 linting errors
  * :bz:`1460708` hook up testing with python3 to CI
  * :bz:`1467308` Update socorro.lib folder for Python 3
  * :bz:`1469718` Update socorro.external folder for Python 3
  * :bz:`1503434` refactor transaction executor to avoid passing class attributes to "except"
  * :bz:`1503439` PEP 479 introduces interesting changes to python 3
  * :bz:`1505231` [tracker] rework error handling in processor
  * :bz:`1505233` cleanup error handling in processor rules
  * :bz:`1505591` update socorro.processor for Python 3
  * :bz:`1505592` update socorro.app for Python 3
  * :bz:`1505797` get rid of socorro.lib.util.DotDict
  * :bz:`1506228` update socorro.cron for python 3
  * :bz:`1507186` Update webapp tests for Python 3


Thank you!
==========

Thank you to my co-workers Peter, Osmose, and Adrian who did a lot of work on
Python 3 migration and code reviews and confidence checking; my manager Lonnen; the
2018 summer interns Alexis and Ced; our ops people JP, Miles, and Brian; and
Rob and Lars who answered many questions about what the code was doing and why.


Conclusion
==========

We finished our Python 3 migration--you can, too! Don't wait to get started!
