.. title: Antenna: retrospective (2017)
.. slug: antenna_project_wrapup
.. date: 2017-07-17 12:00
.. tags: mozilla, work, socorro, story, retrospective


Project
=======

:time: 6 months
:impact:
    * reduced risk for deployments
    * improved reliability of collector
    * reduced technical debt
    * improved developer efficacy


Problem statement
=================

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the Breakpad
crash reporter asks the user if the user would like to send a crash report. If
the user answers "yes!", then the Breakpad crash reporter collects data related
to the crash, generates a crash report, and submits that crash report as an HTTP
POST to Socorro--specifically the Socorro collector.

The Socorro collector is one of several components that comprise Socorro. Each
of the components has different uptime requirements and different security risk
profiles. However, all the code is maintained in a single repository and we
deploy everything every time we do a deploy. This is increasingly inflexible and
makes it difficult for us to make architectural changes to Socorro without
affecting everything and incurring uptime risk for components that have high
uptime requirements.

Because of that, in early 2016, we embarked on a re-architecture to split out
some components of Socorro into separate services. The first component to get
split out was the Socorro collector since it needs has the highest uptime
requirements of all the Socorro components, but rarely changes, so it'd be a lot
easier to meet those requirements if it was separate from the rest of Socorro.

Thus I was tasked with splitting out the Socorro collector and this blog post
covers that project. It's a bit stream-of-consciousness, because I think there's
some merit to explaining the thought process behind how I did the work over the
course of the project for other people working on projects.


.. TEASER_END

What does it do?
================

The collector is a web service that listens for HTTP POSTs each of which is an
incoming crash report.

For each incoming crash report, the collector:

1. deserializes the POST from multipart/form-data into crash metadata and a set
   of binary blobs each of which is a memory dump

2. generates a crash id which it returns to the Breakpad crash reporter client
   allowing users to see their crash reports (see ``about:crashes`` in your
   Firefox browser)

3. looks at the crash metadata and throttles the crash based on a set of
   throttle rules; for example, the collector sends all crashes from the Firefox
   desktop nightly channel for processing, but only 10% of the Firefox desktop
   release channel

4. saves the crash metadata and memory dumps to Amazon S3

5. for crashes that should get processed, adds a crash id to the processing
   queue


What makes the Socorro collector interesting?
=============================================

Largish payloads
----------------

Compared with Telemetry, the collector handles large payloads. At the time I
wrote the specification for the new collector, we were seeing crash report
payload sizes of:

* average: 500kb
* 95%: 1.5mb
* max: 3mb

With the changes for e10s and project Quantum and the kind of data they want to
get back to make crashes more actionable, we predicted 95% and max sizes to
increase over time and possibly the average, too.


Stricter uptime requirements
----------------------------

The collector has stricter uptime requirements than the rest of Socorro. If
other components in Socorro go down, we can restart them and have them resume
where they left off--no big deal. If the collector goes down, then we
potentially lose any crashes being sent plus crashes that have been accepted,
but not saved to Amazon S3. This is bad.

If the collector can't keep up with incoming crashes, then some of those
incoming crashes won't make it to Amazon S3 and the rest of processing and then
we end up with a view of the world that isn't correct. This is bad, too.

If there's an Amazon S3 outage, the collector needs to be able to queue crashes
to save, otherwise we'll lose them. This is also bad.

The collector handles incoming HTTP POST requests with large payloads, does some
minimal work on them, and then saves them to Amazon S3. Because of this, it's
essentially bound by network upload/download rates.


Periodic load
-------------

The collector experiences load that has an ebb and flow to it. First, each day
rises gently, then peaks, then ebbs. Second, weekdays (Monday through Friday)
have higher crash rates than weekends (Saturday and Sunday). Firefox is on a
6-week release schedule and we sometimes see more crashes in the first couple of
weeks of a new release especially now that there's a "submit all unsubmitted
crashes" widget that pops up which causes a big spike in crash collection.

I used the peak weekday number as representative of "1x" load. That's roughly 20
crashes/s.

At peak just after a Firefox release when that "submit all the unsubmitted
crashes" widget pops up for some people, Socorro collector can get up to 30
crashes/s.


Figuring out requirements
=========================

When I started, there were no specifications covering how the collector worked,
requirements it had, details on how it transformed the data, and a variety of
other things. Further, the Socorro collector can be configured to do any number
of things and this was dictated by how it was configured. I had to figure out
exactly what it was doing as configured in our production environment. Thus
I had to get a hold of the configuration we had in production, read through the
code with that configuration in mind, and figure out what it was actually
doing. I used this research to build the collector specification document
that defined what we were building.

This project existed in the context of a bunch of other projects we were working
on, one of which was cleaning up and reworking our AWS infrastructure. The
schedule for that project changed regularly, which affected the schedule and
requirements for the new collector, too. Because of this, I tried to establish
"hard" requirements that I needed to figure out now and wouldn't change and
"soft" requirements that I pushed off as long as possible to figure out.

Other people had ideas for this project, too. I wanted to keep the scope of the
project as small as possible so as to increase the likelihood that it shipped.
At first, I listened to new ideas and adjusted the project scope as we went
along. As time went on, I switched to aggressively defering ideas, but in a
"not now" manner rather than a "no way" manner--we could look at these other
ideas in future phases.

Over the course of the project, the requirements changed a bit. We ended up with
these:

1. The new collector had to handle incoming crash reports exactly like the old
   collector did.

   It needed to interact with the Breakpad crash reporter in exactly the same way:

   * same url
   * handle incoming multipart/form-data HTTP POSTs
   * handle gzip-compressed HTTP POST payloads as well as uncompressed payloads
   * generate crash ids with the same properties and shape and return them in
     exactly the same manner to the Breakpad crash reporter

   This required me to document how the old collector worked.

   It also meant that at some point, we'd need to write some infrastructure that
   let us compare the output of the old collector vs. the output of the new
   collector.

2. Minimize changes to the processor (that's the component that's next in the
   pipeline after the collector) so that switching from the old collector to the
   new one is as easy as possible:

   * convert from multipart/form-data to JSON exactly the same
   * throttle incoming crashes similarly
   * add the same additional key/vals to the raw crash metadata
   * save files to the same buckets and pseudo-directories in Amazon S3

   This also required extensive research and documentation.

3. Generate metrics to surface performance, health, and work load.

4. Implemented using Python 3 and asynchronous I/O.

5. Support the Ops Dockerflow requirements [#]_:

   * support required status endpoints
   * deployment using Docker containers, Docker hub, and Circle CI
   * log in mozlog format [#]_

   This would make the new collector like other Mozilla systems and easier to
   manage infrastructure-wise.


After figuring all this out, I started working on architectures.

.. [#] This requirement actually came half-way through the project after several
       changes to the infrastructure plans.

.. [#] This requirement was eventually met after we went to production.


Architectures and implementations
=================================

First pass: Antenna
-------------------

I named the first new collector Antenna. The figuring was that it's the data
collection part of Socorro and Socorro is `named after a VLA
<http://www.vla.nrao.edu/>`__ and "Antenna" seemed like a good choice for a
component that collected signals from "space".

Socorro is written in Python 2 and has code dating back a long time [#]_.
Further, it was infinitely configurable which is great for a product, but made
it difficult to develop and run at Mozilla. Socorro also makes heavy use of
threads.

Rather than extract the old collector and then update it, I decided it'd
probably be easier to write it from scratch using Python 3 and asynchronous I/O,
coroutines instead of threads, and implement the functionality that we need at
Mozilla rather than a flexible library of components that could be put together
in a variety of way to meet a variety of needs [#]_.

I proceeded with this for a couple of months. I was prototyping a new stack and
toying with the various libraries and frameworks to find a set that worked for
Antenna. I also decided I didn't like configuration libraries in Python and
`wrote my own <https://everett.readthedocs.io/>`__. Also, I was new to the
Socorro project, so I was also coming up to speed on everything while tackling
this non-trivial project. I felt slow and like I wasn't making much progress.

Then the infrastructure plans changed and it seemed like we were going to stick
with our current infrastructure for a lot longer and it'd be good to extract the
collector as quickly as possible. Further, we decided instead of building
something that'd last 5 years, we were going to go with a stop-gap solution that
we'd stick with for 1 year.

So I changed the plan.

.. [#] The first commit in the git history dates back to 2007. Looks like it was
       migrated from svn:

       https://github.com/mozilla-services/socorro/commit/315d561d2a20f2b130ee620b3803710a09d6dc02

.. [#] I claim it's often good to start a rewrite of something with the thinking
       that you can always abandon that strategy if you need to and you almost
       always learn a lot about the problem domain which is invaluable while
       doing it. The ability to throw things away makes learning a lot easier.


Second pass: socorro-collector
------------------------------

Instead of continuing with the ground-up rewrite, I started a new project called
"socorro-collector" [#]_ and extracted just the needed bits from the Socorro
codebase to run the collector with. Then I spent some quality time cleaning
things up and setting up the project scaffolding and all that.

I almost got this working. Then we had a work week in early September 2016 and
the infrastructure plans changed again. Further, after some discussion, we
decided we wanted a solution that would last longer than a year and also didn't
come with urgency for another rewrite.

Also, we added the Dockerflow requirements because the new collector would run
in the new Ops-managed infrastructure.

So I changed the plan again.

.. [#] This was a hilariously bad idea for a name. Months later, we had painful
       problems with the ambiguity of "Socorro collector" and
       "socorro-collector".


Third pass: Antenna again
-------------------------

I stopped working on the socorro-collector project and went back to `Antenna
<https://github.com/mozilla-services/antenna>`__. At this point, I had learned a
lot about the Socorro collector and how it worked, so I rewrote most of what I
had already written for Antenna and then continued with the ground-up rewrite.

I continued working on this iteration and in April 2017 it became the Antenna we
put in production.


Putting the Q in Quality
========================

I fail all the time--it's a thing I do. I never know what I don't know. I can't
predict the future. I have no idea what's lurking around the corner. This is
life.

But knowing that this is the way things are, I'm constantly thinking about what
changes I can make to reduce risk or reduce the consequences of failures. I had
a bunch of conversations with Lonnen, Rob, JP, and Phrawzty about what tools
they used when moving Socorro from the SCL3 datacenter to AWS in 2015 and how
they did integration tests and load tests and anything else that already existed
that I could re-use.

We talked about various failure scenarios they'd seen with the existing Socorro
collector and what kinds of things help to alleviate the impact of those failure
scenarios [#]_.

I looked at what the Mozilla telemetry group was doing [#]_ and how they tested
their system.

I read articles about data pipeline architectures and issues with them from
other companies.

From all this, I decided we needed the following things to happen for me to feel
good about putting Antenna in production:

1. I needed to write some infrastructure that let me compare the output of the
   Socorro collector to the output of Antenna for a "representative set of
   crashes".

2. ... But first, I needed to figure out what a "representative set of crashes"
   entailed.

3. We needed unit tests and integration tests that would run in CI for all pull
   requests.

4. We needed a system test that would run against each node in a new deployment
   and verify that configuration and permissions were correct--I didn't ever
   want Antenna to be accepting crashes, but in a broken state such that it
   can't save them.

5. We needed to run load tests on a prod-like environment to determine how
   Antenna performed under various levels of "representative" load so that we
   could fix unacceptable things.

   We needed to figure out what "representative" was.

   We needed to figure out what "extreme" and possible-denial-of-service was and
   test that, too.

6. Load testing will help us build helpful dashboards and alerts for later
   monitoring. Further, it'd help us tune the scaling rules.


Over a couple of months, we analyzed existing data and built the tools to meet
these needs.

Figuring out what "representative" meant involved looking at dashboards and
numbers for the Socorro collector. How many requests per minute did it handle
over the course of a month? What was the average, median, 95%? How big were
crash report payloads? What did they consist of? Did we have example crashes for
Firefox desktop as well as Firefox for Android (they produce different kinds of
crashes)? Compressed and uncompressed? Different combinations of memory dump
blobs? Data to trigger the various throttle rules? Fuzzed data?

I had been building unit and integration tests all along and they were already
hooked up to CI.

I wrote system test infrastructure and we connected it to our deploy pipeline so
that nodes would run a system test and if that passed, then they would go live.
Further, it would notify us on failures.

Matt, Richard, and I built load test scenarios and ran them with a distributed
load broker across a bunch of EC2 nodes to simulate load. We ran a variety of
different kinds of load tests: all at once fire hose, stepped load increases,
long duration loads, and so on.

We built dashboards in Datadog and tuned the graphs so they were easier to read
and interpret.

During heavy load tests, because Antenna is network-heavy, we had problems
getting statsd data off the node and to Datadog (yay UDP!). Figuring out how to
get good metrics during these situations was tricky. For some of the tests, we
ended up finishing the test, then--when there was bandwidth available--pulling
the logs for all the servers, aggregating them to a single host, and running a
log parser on them to figure out what happened during the load test.


.. [#] One thing that kept coming up is the statement "Amazon S3 never goes
       down!" but then it did in March 2017. Even so, we decided if Amazon S3
       goes down, then losing some crashes is ok.

.. [#] We have multiple data pipelines at Mozilla.


Finishing up
============

I wrote about Antenna's architecture details and some of the design decisions in
the `"Antenna Project specification: v1" document
<https://github.com/mozilla-services/antenna/blob/c32687e6b975fab1cc6289a734cf8339226c99fa/docs/spec_v1.rst>`__.
The spec was later moved to a Google doc. The Antenna spec was the basis from
which I later derived the specification for submitting crash reports:
`Specification: Submitting crash reports
<https://socorro.readthedocs.io/en/latest/spec_crashreport.html>`__.

During load testing, we bumped into additional issues, but pushed off as many as
possible until after we had gotten Antenna to production.

Then we wrote up a to-production plan that included a "back it out" plan in case
things went south.

On April 13th, 2017, we cut over from the Socorro collector to Antenna. It
collected crashes for 24 hours, then we started seeing evidence that things
could be on fire, so we switched back to the Socorro collector to give us time
to look into things.

There was one bug which would have been fine, but there was this other part that
retried errors infinitely. The combination of those two caused one bug with one
crash report to look like the system was on fire.

I fixed that bug and then redid the retry logic and then we cut over from
Socorro collector to Antenna again on April 17th, 2017, and it's been running
ever since.

All the work for Antenna: Phase 1 was done in the `switch to Antenna for incoming
crashes tracker bug <https://bugzilla.mozilla.org/show_bug.cgi?id=1315258>`_.

.. [#] The spec has been moved out of the ReadTheDocs docs and into a Google
       Doc. This is the last version of it.


How do I feel?
==============

Regrets:

* I feel like it took too long. Lots of good reasons. It was essentially a solo
  project. I was learning Socorro on the fly. We kept switching infrastructure
  plans. We used a brand new logging infrastructure. We used a brand new load
  testing infrastructure. I was probably overly conservative and cautious in
  moving forward at various stages. The longer projects go, the less likely it
  feels like they'll ever ship.

  I wish the project had taken less time.

* There's a bunch of code in Antenna that I wish was cleaner. Some code feels
  awkward. There are a bunch of FIXMEs. If I had to do it again, I might have
  chosen Flask instead of Falcon because there's more Flask use in-house than
  Falcon use.

  I wish it was cleaner and I had more confidence future developers won't look
  at the code and think, "Ugh. Seriously?"

* I wish I hadn't spent time on the socorro-collector. Having said that, working
  on that was wildly insightful. All the specs for this project were derived
  from reading code and fiddling with things and working on socorro-collector
  caused me to read a bunch of code I hadn't seen before.

  It wasn't a waste of time, but it kind of felt like it was. Plus switching
  directions was hard (amongst other things, I had to spend time arguing for
  each direction-switch) and throwing stuff out felt like a loss.


Contents:

* We inadvertently built and tested a whole bunch of new stuff:

  * Miles and I worked out some solid infrastructure which we'll use for breaking
    out other components--the system test scaffolding is super handy
  * I load tested Ops' new Logging 2.0 infrastructure
  * Peter and I worked out some nice libraries that make generating metrics
    (`Markus <https://github.com/willkg/markus>`_) and configuration (`Everett
    <https://github.com/willkg/everett>`_) and some other things a lot easier
  * Matt, Richard, and I beta-tested the new load scenario library QA is building
    (`molotov <https://github.com/loads/molotov>`_) and improved it

  Even if Antenna itself hadn't shipped, there was a lot of good work done on
  related projects.

* Cut over from Socorro collector to Antenna was super smooth. There were some
  minor bugs (there are always bugs), but no data loss.

  We didn't lose any data.

* Antenna feels really solid. Antenna collects about 8 million crashes per week
  [#]_.

  I rarely see bugs in Antenna--maybe one a month, if that.


I think Antenna is a success. It puts Socorro in a much better situation. It
makes it easier for us to extract the next component (probably the processor).
It relieves a lot of the risk for Socorro deploys because they no longer touch
the collector.

Yay!

.. [#] Interestingly, when we first pushed out Antenna, it was collecting like 8
       million crashes per week. Now, two months later, it's down to like 6.3
       million crashes per week.


Thanks!
=======

Thank you to everyone involved: Rob, JP, Phrawzty, Lonnen, Adrian, Peter, Matt,
Richard, Greg, Miles, Daniel, Tarek, and Lars!

**Update July 20th, 2017:** Cleaned up some text and added some additional
numbers.
