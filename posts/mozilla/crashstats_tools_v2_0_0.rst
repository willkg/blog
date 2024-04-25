.. title: crashstats-tools v2.0.0 released!
.. slug: crashstats_tools_v2_0_0
.. date: 2024-04-25 12:00
.. tags: python, dev, socorro, mozilla, story

What is it?
===========

`crashstats-tools <https://github.com/willkg/crashstats-tools/>`_ is a set of
command-line tools for working with Crash Stats
(`<https://crash-stats.mozilla.org/>`_).

crashstats-tools comes with four commands:

* supersearch: for performing Crash Stats Super Search queries
* supersearchfacet: for performing aggregations, histograms, and cardinality
  Crash Stats Super Search queries
* fetch-data: for fetching raw crash, dumps, and processed crash data for
  specified crash ids
* reprocess: for sending crash report reprocess requests


v2.0.0 released!
================

There have been a lot of improvements since the last blog post for the v1.0.1
release. New commands, new features, improved cli ui, etc.

v2.0.0 focused on two major things:

1. improving ``supersearchfacet`` to support nested aggregation, histogram, and
   cardinality queries
2. moving some of the code into a ``crashstats_tools.libcrashstats`` module
   improving its use as a library


Improved supersearchfacet
=========================

The other day, `Alex and team finished up the crash reporter Rust rewrite
<https://hacks.mozilla.org/2024/04/porting-a-cross-platform-gui-application-to-rust/>`__.
The crash reporter rewrite landed and is available in Firefox, nightly channel,
where ``build_id >= 20240321093532``.

The crash reporter is one of the clients that submits crash reports to Socorro
which is now maintained by the Observability Team. Firefox has multiple crash
reporter clients and there are many ways that crash reports can get submitted
to Socorro.

One of the changes we can see in the crash report data now is the change in
``User-Agent`` header. The new rewritten crash reporter sends a header of
``crash-reporter/1.0.0``. That gets captured by the collector and put in the
raw crash ``metadata.user_agent`` field. It doesn't get indexed, so we can't
search on it directly.

We can get a sampling of the last 100 crash reports, download the raw crash
data, and look at the user agents.

.. code-block:: bash

   $ supersearch --num=100 --product=Firefox --build_id='>=20240321093532' \
       --release_channel=nightly > crashids.txt
   $ fetch-data --raw --no-dumps --no-processed crashdata < crashids.txt
   $ jq .metadata.user_agent crashdata/raw_crash/*/* | sort | uniq -c
        16 "crashreporter/1.0.0"
         2 "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:127.0) Gecko/20100101 Firefox/127.0"
         1 "Mozilla/5.0 (Windows NT 10.0; rv:127.0) Gecko/20100101 Firefox/127.0"
         2 "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:126.0) Gecko/20100101 Firefox/126.0"
        63 "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0"
         1 "Mozilla/5.0 (X11; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/126.0"
        12 "Mozilla/5.0 (X11; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127.0"
         3 "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127.0"


16 out of 100 crash reports were submitted by the new crash reporter. We were
surprised there are so many Firefox user agents. We discussed this on Slack. I
loosely repeat it here because it's a great way to show off some of the changes
of ``supersearchfacet`` in v2.0.0.

First, the rewritten crash reporter only affects the parent (aka main) process.
The other processes have different crash reporters that weren't rewritten.

How many process types are there for Firefox crash reports in the last week? We
can see that in the ``ProcessType`` annotation
(`docs
<https://crash-stats.mozilla.org/documentation/datadictionary/dataset/annotation/field/ProcessType>`__)
which is processed and saved in the ``process_type`` field
(`docs
<https://crash-stats.mozilla.org/documentation/datadictionary/dataset/processed/field/process_type>`__).

.. code-block:: bash

   $ supersearchfacet --product=Firefox --build_id='>=20240321093532' --release_channel=nightly
       --_facets=process_type
   process_type
    process_type | count 
   --------------|-------
    content      | 3664  
    parent       | 2323  
    gpu          | 855   
    utility      | 225   
    rdd          | 60    
    plugin       | 18    
    socket       | 2     
    total        | 7147  


Judging by that output, I would expect to see a higher percentage of
``crashreporter/1.0.0`` in our sampling of 100 crash reports.

Turns out that Firefox uses different code to submit crash reports not just by
process type, but also by user action. That's in the ``SubmittedFrom`` annotation
(`docs
<https://crash-stats.mozilla.org/documentation/datadictionary/dataset/annotation/field/SubmittedFrom>`__)
which is processed and saved in the ``submitted_from`` field
(`docs
<https://crash-stats.mozilla.org/documentation/datadictionary/dataset/processed/field/submitted_from>`__).

.. code-block:: bash

   $ supersearchfacet --product=Firefox --build_id='>=20240321093532' --release_channel=nightly \
       --_facets=submitted_from
   submitted_from
    submitted_from | count 
   ----------------|-------
    Auto           | 3477  
    Client         | 1741  
    CrashedTab     | 928   
    Infobar        | 792   
    AboutCrashes   | 209   
    total          | 7147  


What is "Auto"? The user can opt-in to auto-send crash reports. When Firefox
upgrades and this setting is set, then Firefox will auto-send any unsubmitted
crash reports. The nightly channel has two updates a day, so there's lots of
opportunity for this event to trigger.

What're the counts for ``submitted_from``/``process_type`` pairs?

.. code-block:: bash

   $ supersearchfacet --product=Firefox --build_id='>=20240321093532' --release_channel=nightly \
       --_aggs.process_type=submitted_from
   process_type / submitted_from
    process_type / submitted_from | count 
   -------------------------------|-------
    content / Auto                | 2214  
    content / CrashedTab          | 926   
    content / Infobar             | 399   
    content / AboutCrashes        | 125   
    parent / Client               | 1741  
    parent / Auto                 | 450   
    parent / Infobar              | 107   
    parent / AboutCrashes         | 25    
    gpu / Auto                    | 565   
    gpu / Infobar                 | 236   
    gpu / AboutCrashes            | 54    
    utility / Auto                | 198   
    utility / Infobar             | 25    
    utility / AboutCrashes        | 2     
    rdd / Auto                    | 34    
    rdd / Infobar                 | 23    
    rdd / AboutCrashes            | 3     
    plugin / Auto                 | 14    
    plugin / CrashedTab           | 2     
    plugin / Infobar              | 2     
    socket / Auto                 | 2     
    total                         | 7147  


We can spot check these different combinations to see what the user-agent looks
like.

For brevity, we'll just look at ``parent / Client`` in this blog post.

.. code-block:: bash

   $ supersearch --num=100 --product=Firefox --build_id='>=20240321093532' --release_channel=nightly \
       --process_type=parent --submitted_from='~Client' > crashids_clarified.txt
   $ fetch-data --raw --no-dumps --no-processed crashdata_clarified < crashids_clarified.txt
   $ jq .metadata.user_agent crashdata_clarified/raw_crash/*/* | sort | uniq -c
       100 "crashreporter/1.0.0"


Seems like the crash reporter rewrite only affects crash reports where
``ProcessType=parent`` and ``SubmittedFrom=Client``. All the other
``process_type``/``submitted_from`` combinations get submitted a different way
where the user agent is the browser itself.

How many crash reports has the new crash reporter submitted over time?

.. code-block:: bash

   $ supersearchfacet --_histogram.date=product --_histogram.interval=1d --denote-weekends \
       --date='>=2024-03-20' --date='<=2024-04-25' \
       --release_channel=nightly --product=Firefox --build_id='>=20240321093532' \
       --submitted_from='~Client' --process_type=parent
   histogram_date.product
    histogram_date | Firefox | total 
   ----------------|---------|-------
    2024-03-21     | 58      | 58    
    2024-03-22     | 124     | 124   
    2024-03-23 **  | 189     | 189   
    2024-03-24 **  | 289     | 289   
    2024-03-25     | 202     | 202   
    2024-03-26     | 164     | 164   
    2024-03-27     | 199     | 199   
    2024-03-28     | 187     | 187   
    2024-03-29     | 188     | 188   
    2024-03-30 **  | 155     | 155   
    2024-03-31 **  | 146     | 146   
    2024-04-01     | 201     | 201   
    2024-04-02     | 226     | 226   
    2024-04-03     | 236     | 236   
    2024-04-04     | 266     | 266   
    2024-04-05     | 259     | 259   
    2024-04-06 **  | 227     | 227   
    2024-04-07 **  | 214     | 214   
    2024-04-08     | 259     | 259   
    2024-04-09     | 257     | 257   
    2024-04-10     | 223     | 223   
    2024-04-11     | 250     | 250   
    2024-04-12     | 235     | 235   
    2024-04-13 **  | 154     | 154   
    2024-04-14 **  | 162     | 162   
    2024-04-15     | 207     | 207   
    2024-04-16     | 201     | 201   
    2024-04-17     | 346     | 346   
    2024-04-18     | 270     | 270   
    2024-04-19     | 221     | 221   
    2024-04-20 **  | 190     | 190   
    2024-04-21 **  | 183     | 183   
    2024-04-22     | 266     | 266   
    2024-04-23     | 303     | 303   
    2024-04-24     | 308     | 308   


There are more examples in the `crashstats-tools README <https://github.com/willkg/crashstats-tools>`__.


crashstats_tools.libcrashstats library
======================================

Starting with v2.0.0, you can use ``crashstats_tools.libcrashstats`` as a
library for Python scripts.

For example:

.. code-block:: python

   from crashstats_tools.libcrashstats import supersearch

   results = supersearch(params={"_columns": "uuid"}, num_results=100)

   for result in results:
       print(f"{result}")


``libcrashstats`` makes using the Crash Stats API a little more ergonomic.

See the ``crashstats_tools.libcrashstats``
`library documentation <https://github.com/willkg/crashstats-tools?tab=readme-ov-file#library>`__.


Be thoughtful about using data
==============================

Make sure to use these tools in compliance with our data policy:

https://crash-stats.mozilla.org/documentation/protected_data_access/


Where to go for more
====================

See the project on GitHub which includes a README which contains everything
about the project including examples of usage, the issue tracker, and the
source code:

https://github.com/willkg/crashstats-tools

Let me know whether this helps you!
