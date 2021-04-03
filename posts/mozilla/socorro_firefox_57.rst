.. title: Socorro and Firefox 57
.. slug: socorro_firefox_57
.. date: 2017-09-13 12:34
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the Breakpad
crash reporter asks the user if the user would like to send a crash report. If
the user answers "yes!", then the Breakpad crash reporter collects data related
to the crash, generates a crash report, and submits that crash report as an HTTP
POST to Socorro--specifically the Socorro collector.

Teams at Mozilla are feverishly working on Firefox 57. That's super important
work and we're getting down to the wire. Socorro is a critical part of that
development work as it collects incoming crashes, processes them, and has tools
for analysis.

This blog post covers some of the things Socorro engineering has been doing to
facilitate that work and what we're planning from now until Firefox 57 release.


This quarter
============

This quarter, we replaced Snappy with `Tecken <https://symbols.mozilla.org>`_
for more reliable symbol lookup in Visual Studio and other clients.

We built a Docker-based local dev environment for Socorro making it easier to
run Socorro on your local machine configured like crash-stats.mozilla.com. It
now `takes five steps to getting Socorro running on your computer
<http://socorro.readthedocs.io/en/latest/gettingstarted.html#quickstart>`_.

We also overhauled the signature generation system in Socorro and slapped on a
command-line interface. Now you can `test the effects of signature generation
changes on specific crashes as well as groups of crashes on your local machine
<http://socorro.readthedocs.io/en/latest/architecture/signaturegeneration.html#signature-generation-module>`_.

We've also been fixing stability issues and bugs and myriad other things.


Now until Firefox 57
====================

Starting today and continuing until after Firefox 57 release, we are:

1. prioritizing your signature generation changes, getting them landed, and
   pushing them to -prod

2. triaging Socorro bugs into "need it right now" and "everything else" buckets

3. deferring big changes to Socorro until after Firefox 57 including API
   endpoint deprecation, major UI changes to the crash-stats interface, and
   other things that would affect your workflow


We want to make sure crash analysis is working as best as it can so you can do
the best you can so we can have a successful Firefox 57.


Please contact us if you need something!
========================================

We hang out on ``#breakpad`` on ``irc.mozilla.org``. You can also `write up bugs
<https://bugzilla.mozilla.org/enter_bug.cgi?format=__standard__&product=Socorro>`_.

Hopefully this helps. If not, let us know!
