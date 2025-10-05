.. title: crashstats-tools v1.0.1 released! CLI for Crash Stats.
.. slug: crashstats_tools_v1_0_1
.. date: 2019-07-31 15:00
.. tags: python, dev, socorro, mozilla, story

What is it?
===========

`crashstats-tools <https://github.com/willkg/crashstats-tools/>`_ is a set of
command-line tools for working with Crash Stats
(`<https://crash-stats.mozilla.org/>`_).

crashstats-tools comes with two commands:

* supersearch: for performing Crash Stats Super Search queries
* fetch-data: for fetching raw crash, dumps, and processed crash data for
  specified crash ids


v1.0.1 released!
================

I extracted two commands we have in the Socorro local dev environment into a
separate Python project and released it on PyPI. This allows anyone to use
those two commands without having to set up a Socorro local dev environment.

The audience for this library is pretty limited, but I think it'll help
significantly with crash report testing and analysis tools.

For example, if I was looking at crash report minidump files and needed
to automate identifying, downloading, and performing additional analysis
on them, I could use the ``supersearch`` command to get a list of crash ids to
download data for and the ``fetch-data`` command to download the crash report
files.

.. code-block:: bash

   $ export CRASHSTATS_API_TOKEN=foo
   $ mkdir crashdata
   $ supersearch --product=Firefox --num=10 | \
       fetch-data --raw --dumps --no-processed crashdata

Then I can run my tools on the dumps in ``crashdata/upload_file_minidump/``.


Be thoughtful about using data
==============================

Make sure to use these tools in compliance with our data policy:

https://crash-stats.mozilla.org/documentation/memory_dump_access/


Where to go for more
====================

See the project on GitHub which includes a README that contains everything
about the project including examples of usage, the issue tracker, and the
source code:

https://github.com/willkg/crashstats-tools

Let me know whether this helps you!
