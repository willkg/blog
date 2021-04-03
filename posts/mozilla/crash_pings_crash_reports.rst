.. title: Crash pings (Telemetry) and crash reports (Socorro/Crash Stats)
.. slug: crash_pings_crash_reports
.. date: 2019-07-03 15:00
.. tags: mozilla, work, socorro


I keep getting asked questions that stem from confusion about crash pings and
crash reports, the details of where they come from, differences between the two
data sets, what each is currently good for, and possible future directions for
work on both. I figured I'd write it all down.

This is a brain dump and sort of a blog post and possibly not a good version of
either. I desperately wished it was more formal and mind-blowing like something
written by `Chutten <https://chuttenblog.wordpress.com/>`_ or `Alessio
<https://www.a2p.it/wordpress/en/>`_.

It's likely that this is 90% true today but as time goes on, things will change
and it may be horribly wrong depending on how far in the future you're reading
this. As I find out things are wrong, I'll keep notes. Any errors are my own.

.. contents:: Table of contents because this is long


Summary
=======

We (Mozilla) have two different data sets for crashes: crash pings in Telemetry
and crash reports in Socorro/Crash Stats. When Firefox crashes, the crash
reporter collects information about the crash and this results in crash ping
and crash report data. From there, the two different data things travel two
different paths and end up in two different systems.

This blog post covers these two different journeys, their destinations, and the
resulting properties of both data sets.

This blog post specifically talks about Firefox and not other products which
have different crash reporting stories.


Updates
=======

Updates and changes to this blog post since I wrote it:

* 2019-07-04: Crash ping data is not publicly available. Blog post updated
  accordingly. Thank you, Chutten!
* 2019-11-07: Added note that you can download symbols files using any http
  client and that the file you get back is gzipped. Thank you, Steven!


CRASH!
======

Firefox crashes. It happens.

The crash reporter kicks in. It uses the Breakpad library to collect data about
the crashed process, package it up into a minidump. The minidump has
information about the registers, what's in memory, the stack of the crashing
thread, stacks of other threads, what modules are in memory, and so on.

* https://firefox-source-docs.mozilla.org/toolkit/crashreporter/crashreporter/index.html
* https://chromium.googlesource.com/breakpad/breakpad/+/master/docs/getting_started_with_breakpad.md
* https://chromium.googlesource.com/breakpad/breakpad/+/master/docs/exception_handling.md

Additionally, the crash reporter collects a set of annotations for the crash.
Annotations like ``ProductName``, ``Version``, ``ReleaseChannel``, ``BuildID``
and others help us group crashes for the same product and build.

* https://hg.mozilla.org/mozilla-central/file/tip/toolkit/crashreporter/CrashAnnotations.yaml

The crash reporter assembles the portions of the crash report that don't have
personally identifiable information (PII) in them into a crash ping. It uses
minidump-analyzer to unwind the stack. The crash ping with this stack is sent
via the crash ping sender to Telemetry.

* https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/pingsender.html
* https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/data/crash-ping.html

If Telemetry is disabled, then the crash ping will not get sent to Telemetry.

The crash reporter will show a crash report dialog informing the user that
Firefox crashed. The crash report dialog includes a comments field for
additional data about the crash and an email field. The user can choose to send
the crash report or not.

If the user chooses to send the crash report, then the crash report is sent via
HTTP POST to the collector for the crash ingestion pipeline. The entire crash
ingestion pipeline is called Socorro. The website part is called Crash Stats.

* https://socorro.readthedocs.io/en/latest/overview.html

If the user chooses not to send the crash report, then the crash report never
goes to Socorro.

If Firefox is unable to send the crash report, it keeps it on disk. It might
ask the user to try to send it again later. The user can access
``about:crashes`` and send it explicitly.


Relevant backstory
==================

What is symbolication?
----------------------

Before we get too much further, let's talk about symbolication.

minidump-whatever will walk the stack starting with the top-most frame. It
uses frame information to find the caller frame and works backwards to
produce a list of frames. It also includes a list of modules that are
in memory.

For example, part of the crash ping might look like this:

::

      "modules": [
        ...
        {
          "debug_file": "xul.pdb",
          "base_addr": "0x7fecca50000",
          "version": "69.0.0.7091",
          "debug_id": "4E1555BE725E9E5C4C4C44205044422E1",
          "filename": "xul.dll",
          "end_addr": "0x7fed32a9000",
          "code_id": "5CF2591C6859000"
        },
        ...
      ],
      "threads": [
        {
          "frames": [
            {
              "trust": "context",
              "module_index": 8,
              "ip": "0x7feccfc3337"
            },
            {
              "trust": "cfi",
              "module_index": 8,
              "ip": "0x7feccfb0c8f"
            },
            {
              "trust": "cfi",
              "module_index": 8,
              "ip": "0x7feccfae0af"
            },
            {
              "trust": "cfi",
              "module_index": 8,
              "ip": "0x7feccfae1be"
            },
    ...


The "ip" is an instruction pointer.

The "module_index" refers to another list of modules that were all in memory at
the time.

The "trust" refers to how the stack unwinding figured out how to unwind that
frame. Sometimes it doesn't have enough information and it does an educated
guess.

Symbolication takes the module name, the module debug id, and the offset
and looks it up with the symbols it knows about. So for the first
frame, it'd do this:

1. module index 8 is xul.dll
2. get the symbols for xul.pdb debug id 4E1555BE725E9E5C4C4C44205044422E1 which
   is at https://symbols.mozilla.org/xul.pdb/4E1555BE725E9E5C4C4C44205044422E1/xul.sym
3. figure out that 0x7feccfc3337 (ip) - 0x7fecca50000 (base addr for xul.pdb
   module) is 0x573337
4. look up 0x573337 in the SYM file and I think that's
   ``nsTimerImpl::InitCommon(mozilla::BaseTimeDuration<mozilla::TimeDurationValueCalculator> const &,unsigned int,nsTimerImpl::Callback &&)``

Symbolication does that for every frame and then we end up with a helpful
symbolicated stack.

.. Note::

   You can use wget, curl, or any http client to download symbols using
   urls like in step 2. One thing to know is that the file you get back
   is gzipped, so you'll need to un-gzip it to read it.


Tecken has a `symbolication API
<https://tecken.readthedocs.io/en/latest/symbolication.html#symbolication>`_
which takes the module and stack information in a minimal form and
symbolicates using symbols it manages.

It takes a form like this:

::

    {
      "memoryMap": [
        [
          "xul.pdb",
          "44E4EC8C2F41492B9369D6B9A059577C2"
        ],
        [
          "wntdll.pdb",
          "D74F79EB1F8D4A45ABCD2F476CCABACC2"
        ]
      ],
      "stacks": [
        [
          [0, 11723767],
          [1, 65802]
        ]
      ]
    }

This has two data structures. The first is a list of (module name, module debug
id) tuples. The second is a list of (module id, memory offset) tuples.


What is Socorro-style signature generation?
-------------------------------------------

Socorro has a signature generator that goes through the stack, normalizes
the frames so that frames look the same across platforms, and then uses
that to generate a "signature" for the crash that suggests a common
cause for all the crash reports with that signature.

It's a fragile and finicky process. It works well for some things and poorly
for others. There are other ways to generate signatures. This is the one that
Socorro currently uses. We're constantly honing it. 

I export Socorro's signature generation system as a Python library
called `siggen <https://github.com/willkg/socorro-siggen/>`_.

For examples of stacks -> signatures, look at crash reports on
`Crash Stats <https://crash-stats.mozilla.org/>`_.


What is it and where does it go?
================================

Crash pings in Telemetry
------------------------

Crash pings are only sent if Telemetry is enabled in Firefox.

The crash ping contains the stack for the crash, but little else about
the crashed process. No register data, no memory data, nothing found
on the heap.

The stack is unwound by minidump-analyzer in the client on the user's machine.
Because of that, driver information can be used by unwinding so for some kinds
of crashes, we may get a better stack than crash reports in Socorro.

* https://hg.mozilla.org/mozilla-central/file/tip/toolkit/crashreporter/minidump-analyzer
* https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/data/crash-ping.html#stack-traces

Stacks in crash pings are not symbolicated.

There's an error aggregates data set generated from the crash pings which
is used by Mission Control.

* https://docs.telemetry.mozilla.org/datasets/streaming/error_aggregates/reference.html


Crash reports in Socorro
------------------------

Socorro does not get crash reports if the user chooses not to send a crash
report.

Socorro collector discards crash reports for unsupported products.

Socorro collector throttles incoming crash reports for Firefox release
channel--it accepts 10% of those for processing and rejects the other 90%.

* https://github.com/mozilla-services/antenna/blob/master/antenna/throttler.py

The Socorro processor runs minidump-stackwalk on the minidump which unwinds the
stack. Then it symbolicates the stack using symbols uploaded during the build
process to symbols.mozilla.org.

* https://github.com/mozilla-services/socorro/tree/master/minidump-stackwalk
* https://tecken.readthedocs.io/en/latest/download.html

If we don't have symbols for modules, minidump-stackwalk will guess at the
unwinding. This can work poorly for crashes that involve drivers and system
libraries we don't have symbols for.


Crash pings vs. Crash reports
=============================

Because of the above, there are big differences in collection of crash data
between the two systems and what you can do with it.


Representative of the real world
--------------------------------

Because crash ping data doesn't require explicit consent by users on a
crash-by-crash basis and crash pings are sent using the Telemetry
infrastructure which is pretty resilient to network issues and other problems,
crash ping data in Telemetry is likely more representative of crashes happening
for our users.

Crash report data in Socorro is limited to what users explicitly send us.
Further, there are cases where Firefox isn't able to run the crash reporter
dialog to ask the user.

For example, on Friday, June 28th, 2019 for Firefox release channel:

* Telemetry got 1,706,041 crash pings
* Socorro processed 42,939 crash reports, so figure it got around 420,000
  crash reports


Stack quality
-------------

A crash report can have a different stack in the crash ping than in the crash
report.

Crash ping data in Telemetry is unwound in the client. On Windows,
minidump-analyzer can access CFI unwinding data, so the stacks can be better
especially in cases where the stack contains system libraries and drivers.

* https://hg.mozilla.org/mozilla-central/file/tip/toolkit/crashreporter/minidump-analyzer/Win64ModuleUnwindMetadata.cpp
* https://bugzilla.mozilla.org/show_bug.cgi?id=1372830

We haven't implemented this yet on non-Windows platforms.

Crash report data in Socorro is unwound by the Socorro processor and is heavily
dependent on what symbols we have available. It doesn't do a good job with
unwinding through drivers and we often don't have symbols for Linux system
libraries.

* https://bugzilla.mozilla.org/show_bug.cgi?id=951229

Gabriele says sometimes stacks are unwound better for crashes on MacOS and
Linux platforms than what the crash ping contains.


Symbolication and signatures
----------------------------

Crash ping data is not symbolicated and we're not generating Socorro-style
signatures, so it's hard to bucket them and see change in crash rates for
specific crashes.

There's an fx-crash-sig Python library which has code to symbolicate crash ping
stacks and generate a Socorro-style signature from that stack. This is helpful
for one-off analysis but this is not a long-term solution.

* https://github.com/mozilla/fx-crash-sig

Crash report data in Socorro is symbolicated and has Socorro-style signatures.

* https://socorro.readthedocs.io/en/latest/signaturegeneration.html

The consequence of this is that in Telemetry, we can look at crash rates
for builds, but can't look at crash rates for specific kinds of crashes as
bucketed by signatures.

The Signature Report and Top Crashers Report in Crash Stats can't be
implemented in Telemetry (yet).


Tooling
-------

Telemetry has better tooling for analyzing crash ping data.

* https://docs-origin.telemetry.mozilla.org/datasets/batch_view/crash_summary/reference.html

Crash ping data drives Mission Control.

* https://missioncontrol.telemetry.mozilla.org/#/

Socorro's tooling is limited to Supersearch web ui and API which is ok at some
things and not great at others. I've heard some people really like the
Supersearch web ui.

There are parts of the crash report which are not searchable. For example, it's
not possible to search for crash reports where a certain module is in the
stack. Socorro has a signature report and a topcrashers page which help, but
they're not flexible for answering questions outside of what we've explicitly
coded them for.

Socorro sends a copy of processed crash reports to Telemetry and this is in the
"socorro_crash" dataset.

* https://docs-origin.telemetry.mozilla.org/datasets/other/socorro_crash/reference.html


PII and data access
-------------------

Telemetry crash ping data does not contain PII. It is not publicly available,
except in aggregate via `Mission Control
<https://missioncontrol.telemetry.mozilla.org/>`_.

Socorro crash report data contains PII. A subset of the crash data is available
to view and search by anyone. The PII data is restricted to users explicitly
granted access to it. PII data includes user email addresses, user-provided
comments, CPU register data, what else was in memory, and other things.


Data expiration
---------------

Telemetry crash ping data isn't expired, but I think that's changing at some
point.

Socorro crash report data is kept for 6 months.


Data latency
------------

Socorro data is near real-time. Crash reports get collected and processed and
are available in searches and reports within a few minutes.

Crash ping data gets to Telemetry almost immediately.

* https://mozilla.report/post/projects/crash_ping_delays_pingSender.kp/index.html

Main ping data has some latency between when it's generated and when it is
collected. This affects normalization numbers if you were looking at crash
rates from crash ping data.

* https://www.a2p.it/wordpress/tech-stuff/mozilla/firefox-data-faster-shutdown-pingsender/ (June 2017)
* https://blog.mozilla.org/data/2017/09/19/two-days-or-how-long-until-the-data-is-in/ (September 2017)

Derived data sets may have some latency depending on how they're generated.


Conclusions and future plans
============================

Socorro
-------

Socorro is still good for deep dives into specific crash reports since it
contains the full minidump and sometimes a user email address and user
comments.

Socorro has Socorro-style signatures which make it possible to aggregate crash
reports into signature buckets. Signatures are kind of fickle and we adjust how
they're generated over time as compilers, symbols extraction, and other things
change. We can build Signature Reports and Top Crasher reports and those are
ok, but they use total counts and not rates.

I want to tackle switching from Socorro's minidump-stackwalk to
minidump-analyzer so we're using the same stack walker in both places. I don't
know when that will happen.

Socorro is going to GCP which means there will be different tools available
for data analysis. Further, we may switch to BigQuery or some other data
store that lets us search the stack. That'd be a big win.


Telemetry
---------

Telemetry crash ping data is more representative of the real world, but stacks
are symbolicated and there's no signature generation, so you can't look at
aggregates by cause.

Symbolication and signature generation of crash pings will get figured out at
some point.

Work continues on Mission Control 2.0.

Telemetry is going to GCP which means there will be different tools available
for data analysis.


Together
--------

At the All Hands, I had a few conversations about fixing tooling for both
crash reports and crash pings so the resulting data sets were more similar and
you could move from one to the other. For example, if you notice a troubling
trend in the crash ping data, can you then go to Crash Stats and find crash
reports to deep dive into?

I also had conversations around use cases. Which data set is better for
answering certain questions?

We think having a guide that covers which data set is good for what kinds of
analysis, tools to use, and how to move between the data sets would be really
helpful.


Thanks!
=======

Many thanks to everyone who helped with this: Will Lachance, W Chris Beard,
Gabriele Svelto, Nathan Froyd, and Chutten.

Also, many thanks to Chutten and Alessio who write fantastic blog posts about
Telemetry things. Those are gold.
