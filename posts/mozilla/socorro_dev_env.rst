.. title: Socorro local development environment: retrospective (2017)
.. slug: socorro_dev_env
.. date: 2017-09-20 12:34
.. tags: mozilla, work, socorro, dev, story, retrospective

Project
=======

:time: 1 year
:impact:
    * vastly reduced time-to-onboard for new developers and contributors
    * vastly improved developer efficacy


Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the Breakpad
crash reporter asks the user if the user would like to send a crash report. If
the user answers "yes!", then the Breakpad crash reporter collects data related
to the crash, generates a crash report, and submits that crash report as an HTTP
POST to Socorro. Socorro saves the crash report, processes it, and provides an
interface for aggregating, searching, and looking at crash reports.

This (long-ish) blog post talks about how when I started on Socorro, there
wasn't really a local development environment and how I went on a magical
journey through dark forests and craggy mountains to find one.

If you do anything with Socorro at Mozilla, you definitely want to at least read
the "Tell me more about this local development environment" part.


.. TEASER_END

When I started, March 2016
==========================

When I joined the Socorro team in March 2016, there wasn't a functional local
development environment. By that, I mean there was no local development
environment you could use to run Socorro the way we run it at Mozilla.

There were developers on Socorro and they were doing development, but not with a
local development environment.

There was a partially working Vagrant environment, but it was for "Socorro the
product" rather than "Socorro as we run it at Mozilla". "Socorro the product" is
vastly different than "Socorro as we run it at Mozilla". The latter is the
former combined with:

1. around 200 environment variables which determine at runtime which Socorro
   components are used and how they work

2. data in a bunch of lookup tables covering products, releases, and other
   information that Socorro needs to process and analyze crashes

3. a pinch of salt

At the time I joined, I think only my manager was using the Vagrant environment.
Since then, the Nintendo Switch came out, so I'm not sure he uses it anymore.
Other people did other things which I'm not going to go into here mostly because
I never set up Socorro in those ways.

The documentation for setting up the Vagrant environment was very involved and
tangled with setup docs for other environments like running it on your host
machine or on Ubuntu using the Socorro package which we haven't produced in a
long time. It was hard to follow. It was out of date. It could have won a prize
in a small interactive fiction contest.

No one had been onboarded on the Socorro team in a long long while, so updating
the Vagrant environment and relevant documentation had taken a back burner to
the myriad of other things that had more impact to others and more value to
Mozilla. That sort of makes sense--why maintain things that you don't need.

Thus when I started, there was no functional local development environment.


It started with socorro-zero, March 2016 to May 2017
====================================================

I like having a local development environment. I love the way you can throw them
out, build a new one, and pretend nothing happened when you do something
epically foolish.

So one of the first things I did in March 2016 was start `socorro-zero
<https://github.com/willkg/socorro-zero/>`_.

My intention at the time was to:

1. create an out-of-the-box Socorro-as-Mozilla-runs-it local development
   environment

2. create scripts and documentation to make using that environment easier

3. make it usable for others

I started it as a separate project figuring I can prototype and tinker a lot
faster if it's not tied to the Socorro repository. Then later if it turned out
ok, I could pull it into Socorro proper.

socorro-zero started out as a modified/updated Vagrant environment. Then in
August 2016, I switched it to be Docker-based. I tinkered with it from time to
time. I used it mostly to run tests. I told other people about it, but I don't
think anyone else used it.


What would a good local development environment for Socorro look like?
======================================================================

I was hoping to have the following things in a local development environment for
Socorro:

**Anyone who can run Docker can have a Socorro local development environment
that runs Socorro as we run it at Mozilla in like 5 steps.**

There are other people who use Socorro that have an impetus to help fix the
issues that affect them. It behooves us to make building a local development
environment straight-forward without requiring people to become Socorro
domain experts.

The Socorro team is changing. It behooves us to be able to onboard a new
developer in days rather than months. Building a local development environment
is critical for that.

I like having an environment that doesn't require a lot of work to
maintain--that frees me up to work on actual work.


**Local development environments can be thrown away and rebuilt.**

The local development environment needs to be trivial to throw away and rebuild
because I want to be able to review pull requests some of which are going to be
large ground-shaking changes.

For example, switching to a new version of Elasticsearch is a big change and
it's nice to be able to build that from scratch, test it, and then throw it out
and go back to the master branch without spending a half-day switching back and
forth.

If you can't throw the environment out and start over trivially, then these
sorts of changes are much harder to work on and much harder to review.


**Documentation covers getting started and important use cases, but isn't a
maintenance burden.**

I want documentation that doesn't fall out of date. I've tried to do this in a
few ways:

1. Document critical things, but minimally.

2. Make as much of the documentation sourced from the code where it's much more
   likely to be updated and much easier to update.

   For example, instead of documenting all the arguments for a command line
   script, document the basic invocation and then how to run the script to get
   command line help.

   For example, instead of documenting how to use a class, use Sphinx's autodoc
   and pull all that data from the class' docstring.

3. Don't repeat existing documentation. Set it up so you can ``.. include::``
   it instead.


**All behavioral-type configuration is codified in env files in the Socorro
repository.**

Socorro has around 200 environment variables in our production environment.
Those fall roughly into two groups:

1. secrets and environment: usernames, passwords, keys, hosts, ports, database
   urls

2. behavioral: which crashstorage classes to save a crash to, the default
   product, which processing algorithm to use


Of those two groups, we want the behavioral configuration put in version control
alongside the code. It makes it much easier to make behavioral changes that we
can push out and roll back as a unit when all the things that affect those
changes are in the same place.

Plus then behavior configuration will get reviewed and approved along with the
code changes it's related to. Fewer possibility of typos and other goofs.

Plus it's much more likely configuration will get cleaned up when the related
code changes. We have a lot of obsolete configuration in consul right now
because of typos and because people forget. It's a project to figure out what's
required and what's not and to fix this situation. It's much easier if it's in
version control.

We will have an audit trail for behavior configuration changes in the repository
with the rest of the code.


**Configuration is easily overridden by inviduals in a way that's easy to build
a mental model about, easy to verify, works across all of Socorro, and is
difficult to accidentally commit to the repository.**

There are some things in Socorro that have to be set up individually like Google
OAuth keys, so we need to set these individually.

We need to temporarily set/unset configuration during development.

Some developers may have certain configuration in place all the time like
preferred logging level values.

All this should be doable in a standard way that's very hard to accidentally
commit to the repository.

Configuration files should be in formats that allow comments.


**Build scripts that do "one thing well" with interfaces that lend themselves to
be used in shell scripts for more complicated tasks.**

If scripts do one thing well and can be strung together, you can orchestrate
complex things with a minimal amount of code. This keeps the scripts small and
flexible.

Help text for scripts should cover how to use the script and possibly some
common invocations.

Scripts should be able to pull from the command line as well as stdin to
facilitate pipes.


**Minimal maintenance burden because I want to spend time doing real work rather
than fixing my local development environment.**

This should be a tool to help us get our work done and not another project that
sucks up all our time.


**When I'm done working on Socorro, I don't want remnants of Socorro all over my
computer.**

Some day, I'm going to switch to a new project. Contributors come and go. We
shouldn't be plagued with Socorro bits on our machines forever.

The local development environment should be self-contained and easy to remove.


Building the Docker-based local development environment
=======================================================

In May 2017, I redid the Docker infrastructure that I had tinkered with in
socorro-zero and put it in Socorro proper. It stunk. It wasn't very usable, but
it could run the test suite which was really helpful. It had potential.

Over the course of July, August, and September, I fixed a bunch of issues to get
the local development environment to work with Socorro and Socorro to work with
the local development environment.

I architected how all the pieces would come together.

I based the environment on Ubuntu rather than CentOS/RedHat.

I wrote a whole new set of scripts that:

1. built Docker images
2. bootstrapped Socorro
3. created a new database and ran migrations and loaded important lookup table
   information
4. maintained the lookup table information
5. fetch and manipulate crash data for processing
6. manipulate the local S3 container
7. ran tests

I ended up writing a new infrastructure for writing scripts so that they were
easier to test.

Most of the scripts I wrote do one thing well, have inline documentation, and
support command line and stdin arguments. They're written in a way that makes it
easier to write unit tests for them. They're not tangled up with existing
Socorro scripts for server, Vagrant, and other environments. Most of them have
terrible names, but some day someone with opinions will show up and fix that.

I fixed the tests to run in a Docker container. Then I fixed them again to run
in Circle CI 2.0's Docker infrastructure so we have CI for the local development
environment.

I rewrote the Socorro documentation basing it on the new local development
environment and its tools.

There are still things to do and some things that are broken, but generally,
this local development environment is pretty solid now and I'm able to use it
full time for all my development needs.


A bit about fake data
=====================

Socorro is a crash ingestion pipeline, so it thirsts for data and without data
it's pretty boring. The local development environment needed a source for crash
report data.

A crash report consists of a couple of parts:

* a bunch of metadata about the crash: CPU, GPU, install time, version, build
  id, and so on
* one or more memory dumps

At first, I worked on writing a fake data generator for crash reports. I figured
I could probably get a fake crash data generator for terrible crash data
working. I soon tossed aside such a foolish notion for a few reasons:

1. To generate really terrible crash data is easy--throw a bunch of random
   values in and a junk memory dump. However, the crash metadata is inextricably
   tied to the memory dump and we need a well-formed memory dump to test the
   processor and if the output is gibberish, the results won't make sense in the
   webapp.

   To generate mediocre fake crash data is really hard. You need to build a
   correctly structured memory dump with crash metadata to match. It's really hard
   to generate a well-formed but fake memory dump.

2. People making code changes to Firefox are constantly changing the shape and
   contents of crash reports. If we were able to build a fake data system that
   had fake memory dumps, we'd have to update it every week to reflect changes
   in the data we're getting from crash reports from the nightly channel.

   Why does it have to be so up-to-date? A chunk of the work we do on Socorro is
   to deal with changes in crash reports just after they've happened.

3. Even if we could figure out mediocre fake crash data and accounted for
   Firefox crash reports changing regularly, the rest of the world is also
   changing. New processors. New GPUs. Changes in operating systems. Changes in
   libraries and stack frames.

Between looking at the fake crash data generation system that Socorro has,
tinkering with building a new one, and conversations I've had with Lonnen and
Ted and others over the last year, I decided a mediocre fake data generation
system is a significant project and it wasn't worth doing now.

Instead, I wrote a script that pulls publicly available information from
`<https://crash-stats.mozilla.com/>`_. That was way easier, has a much lower
maintenance burden, and met our current needs.

Maybe someone will attempt the white whale that is a mediocre fake crash data
generation system some day.


Tell me more about this local development environment
=====================================================

The new local development environment gives me a lot more confidence that the
changes I'm making are good *before* I push them to our -stage server
environment. I can experiment and prototype and throw things away if I need to.
I can more effectively review other peoples' code changes. It's empowering. It
gives me a hug on rainy days.

But enough banal bluster! Let me show you!


Five steps to a local development environment
---------------------------------------------

Let's get a Socorro local development environment set up in five steps:

1. Download and install Docker, docker-compose, git, and bash.
2. Clone the Socorro repository.
3. Run ``make dockerbuild`` to build Docker images required.
4. Run ``make dockersetup`` to set up the database.
5. Run ``make dockerupdatedata`` to load lookup tables.

This takes my machine at home between 8 and 15 minutes with ``make
dockerupdatedata`` taking the longest.

`See more details in the Getting Started docs.
<http://socorro.readthedocs.io/en/latest/gettingstarted.html>`_

Now we have a functional local development environment with no crashes in it.
The processor will work fine. Most crontabber jobs probably work fine. The
webapp will "work" but doesn't do anything interesting because it has no data to
look at.


Throw it out
------------

The local development environment is self-contained and easy to throw out, but
there are different levels of "throw it out".

You could rebuild the Docker images with::

  $ make dockerbuild
  $ make dockersetup
  $ make dockerupdatedata


You could wipe the state of the local development environment with::

  $ make dockersetup
  $ make dockerupdatedata


``make dockersetup`` drops the database and builds a new one. I wrote up a bug
to have it wipe Elasticsearch, local S3, and RabbitMQ, too.

If you're done with Socorro or you've gotten your local development environment
in a right mess, you can completely burn it down by removing all the containers
and volumes with::

  $ docker-compose down --rmi all -v --remove-orphans


If you wanted a fresh new one, you just built it again.


Configuration
-------------

Configuration is all in ``docker/config/``. The ``local_dev.env`` file covers
the secrets and environment configuration for the local development environment.
Then each component has its own env file for behavior configuration:
``processor.env`` for the processor, ``webapp.env`` for the webapp, and
``crontabber.env`` for crontabber.

You can override any of the configuration variables with a ``my.env`` in the
root of the repository.


Getting crash data and processing it
------------------------------------

Let's pull down 100 crashes and process them.

We're going to be running scripts inside our Docker container, but we're
creating files on our host file system. We want those files to be owned by a
user on the host computer--otherwise we have to deal with permission issues when
we remove them later.

So we do this to run a bash shell inside the Docker container using the uid/gid
of the user on my host computer::

  $ ./docker/as_me.sh bash

First, we get 100 crash ids from yesterday for Firefox to process. We want to
put them in a file called ``crashids.txt``.

::

  container$ ./scripts/fetch_crashids.py > crashids.txt


Then we pull down crash data for those crashes and save it in the ``testdata``
directory on our host machine::

  container$ cat crashids.txt | ./scripts/fetch_crash_data.py ./testdata


This pulls publicly available data from `<https://crash-stats.mozilla.com/>`_
with no personally identifyable information in it. That means no memory dumps,
email addresses, URLs, and other things. Because of that, processing it locally
isn't wildly interesting. If you have a Socorro API token that has permissions
to see personally identifiable information, then this will pull down unredacted
crash data.

Now that we have all that crash data, we have to sync it with the local S3
container::

  container$ ./scripts/socorro_aws.sh sync ./testdata s3://dev_bucket/


Then we add the crash ids to the processing queue::

  container$ cat crashids.txt | ./scripts/add_crashid_to_queue.py socorro.normal


Then we run the processor from the host::

  $ docker-compose up processor


It'll churn for a while.

Then we run the webapp::

  $ docker-compose up webapp


And we connect to ``http://localhost:8000`` with our web browser and see what
happened.

That's a decent amount of typing, but these scripts are doing a ton of work.
They're small building blocks that you can alias or put together in different
ways in shell scripts to meet your individual automation needs.

`See more details in the documentation for these scripts.
<http://socorro.readthedocs.io/en/latest/components/processor.html#processing-crashes>`_

Plus we can use these with other scripts that we've been building.

Tada!


Conclusion
==========

And that's the story about a boy who joined the Socorro project, had a dream
about a local development environment, and the wall of text journey he took to
find it.

There are still things to do to improve the local development environment, but
it's shipped, it's usable, and it's in use. I hope it's a solid foundation upon
which we can build, but also a minimal maintenance burden for us going forward.

If you find yourself using it and bump into a bug, please `let us know
<https://bugzilla.mozilla.org/enter_bug.cgi?format=__standard__&product=Socorro>`_.
