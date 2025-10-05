.. title: Socorro Smooth Mega-Migration: retrospective (2018)
.. slug: socorro_migration_2018
.. date: 2018-04-04 12:00
.. tags: mozilla, work, socorro, story, dev, retrospective

Project
=======

:period: 1.5 years
:impact:
    * vastly reduced technical debt
    * vastly improved developer efficiency
    * reduced infrastructure security risks


Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`__ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the Breakpad
crash reporter asks the user if they would like to send a crash report. If
the user answers "yes!", then the Breakpad crash reporter collects data related
to the crash, generates a crash report, and submits that crash report as an HTTP
POST to Socorro. Socorro collects and saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

Over the last year and a half, we've been working on a new infrastructure for
Socorro and migrating the project to it. It was a massive undertaking and
involved changing a lot of code and some architecture and then redoing all the
infrastructure scripts and deploy pipelines.

On Thursday, March 28th, 2018, we pushed the button and switched to the new
infrastructure. The transition was super smooth. Now we're on the new infra!

This blog post talks a little about the old and new infrastructures and the work
we did to migrate.

.. TEASER_END


Why switch this time?
=====================

First, some context. Way back in the day, Socorro was hosted in a Mozilla data
center on long-running virtual servers running CentOS. The hardware was
out-of-warranty and dying, so work was underway to figure out the next
infrastructure. Then the plan changed and that datacenter was scheduled for
decommission. The Socorro team had to scramble to move it somewhere else.

They decided to move it to AWS, but there wasn't enough time to re-architect
and rebuild Socorro to work well in AWS. For expedience, they opted for a
hybrid approach between the old way of doing things on servers in the
datacenter and doing things with AWS best practices.

The new infrastructure was vastly improved from the one before it. Developers
had a lot of autonomy and visibility into the complex system. Deploys were
simpler and more automated. Nodes could be resized to be larger as computational
requirements changed. There were scaling groups, so an increase in load could be
handled by throwing more nodes at it. So on and so forth.

That migration project was considered a success. I wasn't on the project at the
time, but I was sitting at the next table over at the All Hands when they
finished the migration. It was cool stuff.

However, the hybrid approach resulted in a unicorn infrastructure that was
unlike anything else at Mozilla. It was cute but quirky in some ways and
really awkward in others. The plan was never to leave it in this state, but to
incrementally change it into a more AWS-like system over time. We worked on that
for a while, but it became clear that it would be easier to build a new
infrastructure and migrate rather than continue to iterate on the existing one.

Let's talk about some of the quirky and awkward things about the old
infrastructure.

**Complicated deploy pipelines and confusion about deploy artifacts.**
Deploys to stage happened automatically any time we merged to the master branch.
These would build an RPM of Socorro components, install the RPM on CentOS, bake
an AMI, and push that out to stage. Deploys to prod happened by tagging a commit
in the master branch. The AMIs associated with that commit would get pushed to
prod. RPM filenames included the tag of the Socorro build it was built on.
However, since RPMs were built in the deploy to stage and the tag was created to
deploy to prod, the RPMs that were in prod had the previous tag. That was
constantly confusing for me.

**Local development, stage, and production environments were too different.**
Our local development environment was completely different from the stage and
production environments. It was really hard to get them to more closely match
stage and production. Periodically, we'd have problems in stage and production
that we couldn't reproduce locally and vice versa.

Because migrations and configuration changes were done manually, our stage and
production environments weren't like one another. Over the years, some changes
to be done were forgotten, and the environments diverged. I had several instances
where a migration I wrote would work fine on my local machine, work fine on
stage, but fail in production because there was a stored procedure or a table
with foreign keys that didn't exist in other environments.

**Long-running admin nodes with manual (often forgotten) updates.**
Both stage and production had a long-running admin node that we updated manually
after deploys. Further, we had to manually run migrations and do configuration
changes.

**Configuration was unwieldy and not tracked.**
Configuration was managed in `Consul <https://www.consul.io/>`_. We had 170+
environment variables (some with structurally complex values > 100 characters
long) per environment controlling how Socorro worked. Configuration data wasn't
version-controlled and had a "review process" that consisted of conversations
like this:

::

  <willkg> can someone review this config change?
  <willkg> consulate kv set socorro/processor/new_crash_source.new_crash_so
  urce_class=socorro.external.fs.fs_new_crash_source.FSNewCrashSource
  *   peterbe looks.
  <peterbe> looks ok to me.
  *   willkg makes the change.
  <willkg> done!


Since we weren't running Consul in the local development environment,
configuration changes were effectively tested in stage.

One nice thing about Consul the way we had it set up was that after a
configuration change, Consul would restart all the processor processes
immediately--we didn't have to wait for a deploy. That made the occasional
feature-flipping or A/B testing a lot easier.

**Logs only existed on instances.**
Logs were created and existed on the instances. There was no log aggregation
and no central storage. To look at logs, we'd have to log into individual
nodes. Every time we did a deploy, we'd lose all the logs. Thus, we could never
look very far back in time at logs.

**The processor cluster didn't auto-scale.**
The processor nodes were in a fixed autoscaling group and didn't scale
automatically. Periodically, something in the world would happen, and we'd get a
larger-than-normal flow of crashes, and the processors would be working
furiously, but the queue would back up, and our ops person would have to manually
add nodes to the group. After a deploy, it'd return to the original number, and
we'd have to manually scale it up again.

**Periods in AWS S3 bucket names. Ugh.**
We use AWS S3 for storage of crash data. However, when we set that up years ago,
we put periods in our bucket names. For example, we had a bucket like
``org.allizom.crash-stats.rhelmer-test.crashes``. That becomes a problem when
you're using HTTPS because the SSL wildcard certificate creates problems.

**Too much access to too many things.**
Another thing we wanted to do was further reduce which things had access to
what storage systems. Reducing access would reduce the likelihood of security
breaches and data leaks.

In summary, we had a list of things that we wanted:

1. aggregated, centralized logs, and log history
2. Docker-based deploys
3. no more manual post-deploy steps leading to diverging environments
4. disposable nodes
5. configuration that was in version control alongside code and infrastructure
   and requiring review of changes
6. reduced access to storage systems
7. automatic scaling
8. AWS S3 bucket names that don't have periods

Knowing what we wanted out of a new infrastructure, we set about moving forward.


Why did it take a year and a half?
==================================

It took a year and a half because there was a lot that needed to be figured
out, a lot to change, and you can't rush baking a cake. Also, the team changed
over that time as people rolled on and off the project.

What's involved in baking this cake? A lot of steps.

**We split the Socorro collector out as a separate project.**
The collector is the part of the crash ingestion pipeline that accepts incoming
crash reports and saves the crash data. As such, it has a different uptime
requirement than the rest of the system. Splitting it out into a separate
project with its own deploy pipeline made this project a lot easier and a lot
less risky. (See :doc:`Antenna: post-mortem and project wrap-up
<antenna_project_wrapup>`.)

**We stopped supporting Socorro for non-Mozilla users, allowing us to remove
swaths of code we didn't use.**
"Socorro" was both Mozilla's crash-ingestion pipeline as well as an Open Source
project for building crash-ingestion pipelines other people/companies could
use. In order to maintain backwards compatibility, we had been piling on new
features, generic implementations of APIs, backwards-compatible shims, HTTP URL
redirects, and other things for years.

I never met anyone else who ran Socorro, nor did I figure out how to find out
who they were and interact with them. As far as I could tell, we were drowning
in a backwards-compatibility marsh for an Open Source project that had an
unknown user base that didn't participate in its maintenance.

The Socorro codebase was *HUGE*, and vast swaths of it weren't used by us--it was
the `Gormenghast <https://en.wikipedia.org/wiki/Gormenghast_(castle)>`_ of
systems! We had a small team. We needed to reduce the maintenance load. We needed
to reduce the complexity. To do this, we needed to end Socorro-the-product. We
made the decision to make it explicit that we were no longer supporting other
Socorro instances.

That empowered us to remove parts of Socorro we weren't using and peel away
layers of unused features and backwards-compatible shims that had accumulated
over the years. We removed tens of thousands of lines of code. We removed a lot
of complexity. We removed dozens of stored procedures, database tables, database
views, classes, Python libraries, HTTP views, models, API endpoints, and a
variety of other things. (:bz:`1361394`, :bz:`1314814`, :bz:`1424027`,
:bz:`1424370`, :bz:`1398946`, :bz:`1387493`, :doc:`Socorro in 2017 <socorro_2017>`, etc)

**We folded the middleware into the webapp to centralize ownership of data storage.**
We finished the work to fold the middleware functionality into the webapp and
removed the middleware component. (:bz:`1353371`)

**We moved Super Search fields definition from being stored in Elasticsearch to a
Python module.** This unified Super Search fields and definitions across our
environments. (:bz:`1100354`)

**We updated Python dependencies and redid how we managed them.** We switched to
requirements files. (:bz:`1306731`)

**We updated JavaScript dependencies and redid how we managed them.** We switched
to npm. (:bz:`1388593`)

**We redid the local dev environment using Docker.** This let us set it up so it
was behaviorally like stage and production. That let us build and debug in an
environment very similar to our server environments. That let us move a lot
faster. (:doc:`Socorro local development environment <socorro_dev_env>`)

**We cleaned up and improved crontabber.** We unified crontabber configuration and
then audited crontabber and all the jobs it was running so that we could run
crontabber on a disposable node. (:bz:`1388130`, :bz:`1407671`)

**We audited and cleaned up configuration.** We audited configuration across all
environments and removed some configurability of Socorro by making it less
general and more "this is how we run it at Mozilla". We moved a bunch of
configuration into Python code. We audited configuration and reduced
the differences between local development, stage, and production environments.
(:bz:`1296238`, :bz:`1434132`, :bz:`1430860`, :bz:`1434133`)

**We audited and cleaned up database state.** We audited the databases across all
environments and made sure they had the same contents (tables, views, stored
procedures, lookup table contents, etc). (:bz:`1435313`)

**We wrote a secure proxy for private symbols data.** We threw together a proxy to
allow minidump stackwalker access to the private symbols data for stack
symbolication. (:bz:`1437928`)

**We cleaned up stackwalker configuration.** We redid how minidump stackwalker was
configured and unified that configuration across all environments.
(:bz:`1407997`)

**We moved a ton of data.** We had to figure out how to move 40 TB of data [#]_
from one AWS S3 bucket to another (and in the process discovered we had crappy
keys--boo us!). We had problems with S3DistCp crashing after running for hours
without doing any copying. We had more success with `s3s3mirror
<https://github.com/cobbzilla/s3s3mirror>`__.

**We wrote a lot of temporary code to keep things working.** We wrote code
to maintain data flows for some data that's difficult to acquire. It now
resembles an M.C. Escher drawing, but it "works". I can't wait for it to go
away.

**We wrote new pipelines.** We wrote new deploy pipelines and Puppet files and
templates.

**We implemented new autoscaling.** We figured out autoscaling rules for processor
and webapp nodes. This allows us to reduce the minimum number of these nodes--they
now scale up when load goes up and scale down then load goes down.

**We implemented dashboards.** We set up new dashboards in Datadog, new RabbitMQ
accounts and queues, a new Elasticsearch cluster, new RDS instances, new AWS S3
buckets, monitors, alerts, deploy notifications, and so on. (:bz:`1419549`,
:bz:`1419550`, :bz:`1425925`, :bz:`1426148`, :bz:`1438288`, :bz:`1438390`)

**We wrote lots and lots of bugs, plans, checklists, etc.** We wrote migration
plans, load test plans, system comparison/verification scripts, system
checklists, tracker bugs, and meta tracker bugs. (:bz:`1429534`, :bz:`1429546`,
:bz:`1439019`, etc)

**We set up and ran load tests.** We ran load tests to understand the runtime
performance characteristics on the new infrastructure. We did several iterations
of running load tests, identifying issues to fix, and fixing them.

**Meetings.** We had meetings--tons of meetings! Pretty sure we had meetings to
discuss when we should have meetings.

We did all this while maintaining an existing infrastructure and fixing bugs and
adding features.

.. [#] It would have been more, but we wiped all our crash data at the end of
       December, so we only had 3 months of data to move.


Where are we at now?
====================

On March 28th, we cut over to the new system:

.. thumbnail:: /images/socorro_migration_2018_old.png

   Last days of disco....


.. thumbnail:: /images/socorro_migration_2018_new.png

   New infrastructure!


We had the most minor of minor issues:

* I forgot that the crontabber job for acquiring release data works differently
  than the other crontabber jobs in how it uses the window it's passed. When we
  cut over, we needed to manually tweak the crontabber record for it so that it
  would run correctly on Friday. We discovered the issue after a few hours,
  tweaked the crontabber record so it backfilled the missing days, and we're
  fine now.

* We discovered there was a bug in this thing we decided to rewrite wherein the
  process ends before the subthread has time to ack the crashes in RabbitMQ
  that it just pushed. The next time it starts up, it runs through the same
  crashes. Again. And again. And again. Every two minutes. Then on Sunday,
  those crashes started raising ``IntegrityErrors`` since the date embedded in
  the crash id did not match the ``submitted_timestamp``, and so the processor
  was trying to jam it in the wrong database table. We shut that off, and now
  that's fine.

* We discovered we needed to raise the nginx upload max file size for the
  reverse proxy that sits in front of Elasticsearch because some crashes are
  big. Like, really big. We raised it. Those crashes are saved to Elasticsearch.
  This is fine now.

* We had to wait for the last S3 mirror to finish, which took a couple of days.
  During that time, we were missing some crash data that had been collected and
  processed in the last week from S3 storage. It was indexed in Elasticsearch,
  so it was searchable. We just couldnt' access it. it was only sort of
  missing. We knew this and had notified users accordingly. This is fine now.

All minor things--no data loss. The equivalent of moving from one mansion to
another mansion in four hours and in the process misplacing your golf clubs in
the shower stall of the bathroom for ten minutes. No data loss. Low impact
issues.

This was a successful project. There are some minor things left to do. This
unblocks a bunch of other work. Things are good.

We probably could have done better. We did some of the work a few times, and if
we did it "right" the first time, we might have finished earlier, but it took
a few iterations to figure out what "right" looked like.

We had a lot of failures caught by simulations, tests, load tests, run-throughs of
system checklists, Sentry error reporting, Datadog graphs, and other places.

It's likely we'll hit some issues over the next few weeks as we get a feel for
the new system.

Still, it feels good to be done with this project.


Blog posts of past migrations
=============================

While working on this post, I uncovered posts from past infrastructure
migrations:

* April 20th, 2009: `Socorro Dumps Wave Goodbye to the Relational Database
  <https://blog.mozilla.org/webdev/2009/04/20/socorro-dumps-wave-good-bye-to-the-relational-database/>`_
* May 15th, 2009: `Socorro Moves to New Hardware
  <https://blog.mozilla.org/webdev/2009/05/15/socorro-moves-to-new-hardware/>`_
* January 1st, 2011: `The new Socorro
  <https://blog.mozilla.org/webdev/2011/01/26/the-new-socorro/>`_
* January 21st, 2011: `Socorro Data Center Migration Downtime
  <https://blog.mozilla.org/webdev/2011/01/21/socorro-data-center-migration-downtime/>`_
* January 17th, 2015: `The Smoothest Migration
  <http://www.twobraids.com/2015/01/the-smoothest-migration.html>`_

I didn't find one from the last big migration, which I think was in June or July
of 2015.

If you know of others, let me know. It's neat to see how it's changed over the
years.


Thanks!
=======

Members of the team over the period we built the new Socorro, in lexicographical
order:

* Adrian Gaudebert, dev
* Brian Pitts, ops
* Chris Hartjes, qa
* Greg Guthe, security
* JP, ops
* Lonnen, manager, dev
* Matt Brandt, qa
* Miles Crabill, ops
* Peter Bengtsson, dev

Good job!

Also, thank you to Miles, Brian, Mike, and Lonnen for proofing drafts of this!
