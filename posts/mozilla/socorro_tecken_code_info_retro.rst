.. title: Tecken/Socorro: Code info lookup: retrospective (2023)
.. slug: socorro_tecken_code_info_retro
.. date: 2023-10-30 14:33:05 UTC-04:00
.. tags: mozilla, work, socorro, tecken, dev, python, story, retrospective

Project
=======

:time: 6 weeks
:impact:
    * improved visibility on set of crash reports by fixing symbolication and
      signatures
    * better understanding of consequences of sampling Firefox / Windows < 8.1
      / ESR crash reports


Summary
=======

In November, 2021, we wrote up a bug in the Tecken product to support download
symbols files using the code file and code id.

In July, 2023, Mozilla migrated users for Windows 7, 8, and 8.1 from Firefox
release channel to ESR channel. Firefox / Windows / release is sampled by the
Socorro collector, so the system only accepts and processes 10% of incoming
crash reports. When the users were migrated, their crash reports moved to an
unsampled group, so then we were getting 100% of those incoming crash reports.
That caused a volume increase of 30k.

I looked into adding another sampling rule for Firefox / Windows < 8.1 / ESR,
but many of the crash reports had a xul module where there wasn't a debug file
and debug id in the module list stream in the minidump, so we couldn't get
symbols files for them. Because of that, we didn't have much visibility into
this group of crash reports.

I looked at :bz:`1746940` and worked out how to fix it. I thought it would be
relatively straight-forward, so I prioritized working on it with the assumption
it'd take a week to do.

I hit a bunch of road bumps and it took me 6 weeks to work through several
attempts, settle on a final architecture, implement it, test it, and push all
the pieces to production. I finished the work on October 24th, 2023.

The end result is a radically reduced number of crash reports where the
stackwalker couldn't symbolicate ``xul.dll`` addresses because of missing debug
file and debug id.


.. TEASER_END

What is Socorro and Tecken?
===========================

`Socorro <https://github.com/mozilla-services/socorro>`__ is the crash ingestion
pipeline for Mozilla products like Firefox, Fenix, Thunderbird, and MozillaVPN.

When Firefox crashes, the crash reporter asks the user if the user would like
to send a crash report. If the user answers "yes!", then the crash reporter
collects data related to the crash, generates a crash report, and submits that
crash report as an HTTP POST to Socorro. Socorro saves the submitted crash
report, processes it, and has tools for viewing and analyzing crash data.

`Tecken <https://github.com/mozilla-services/tecken>`__ is the Mozilla Symbols
Server where we store Breakpad-style symbols files for binaries.

`rust-minidump <https://github.com/mozilla/rust-minidump>`__ is the set of Rust
crates that make up the stackwalker that the Socorro processor uses.


Problem
=======

If a crash report had modules where we had no debug file or debug id, but did
have a code file and code id, then those modules would not get symbolicated.

For example, here's the output from the stackwalker for a module from the
module list stream in the minidump that has all the information we need for
finding the symbols file::

    {
        "base_addr": "0x01930000",
        "cert_subject": "Mozilla Corporation",
        "code_id": "652de0ed706d000",
        "corrupt_symbols": false,
        "debug_file": "xul.pdb",
        "debug_id": "569E0A6C6B88C1564C4C44205044422E1",
        "end_addr": "0x0899d000",
        "filename": "xul.dll",
        "loaded_symbols": true,
        "missing_symbols": false,
        "symbol_url": "https://symbols.mozilla.org/try/xul.pdb/569E0A6C6B88C1564C4C44205044422E1/xul.sym",
        "version": "115.4.0.8689"
    }


Take note of ``debug_file`` and ``debug_id``. The stackwalker uses that to
request the symbols file using this url::

    https://symbols.mozilla.org/try/xul.pdb/569E0A6C6B88C1564C4C44205044422E1/xul.sym
                                    ^^^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                    |       |
                                    |       debug id
                                    debug file


Here's the output from the stackwalker for a module that's missing the debug
file and debug id::

    {
        "base_addr": "0x69920000",
        "cert_subject": "Mozilla Corporation",
        "code_id": "64e782c570c4000",
        "corrupt_symbols": false,
        "debug_file": "",
        "debug_id": "000000000000000000000000000000000",
        "end_addr": "0x709e4000",
        "filename": "xul.dll",
        "loaded_symbols": false,
        "missing_symbols": true,
        "symbol_url": null,
        "version": "117.0.0.8636"
    }


Here, the debug file is the empty string and the debug id is null represented
by 33 0s. Because the Tecken download API requires the debug file and debug id,
the stackwalker doesn't have the information it needs to request the symbols
file. So it doesn't. So it marks the file as missing.


**Why does the minidump lack the debug file and debug id information?**

Gabriele says this:

    We don't know for sure, but most of the crashes which were missing those
    bits of information were OOMs. I suspect that windbg.dll failed to
    extract those values when memory was tight. This happened very often to
    xul.dll in particular, so I wonder if the fact that it's a very large
    library made this more likely.

That's about all we know.


**How does this affect us?**

The stackwalker can't find the symbols file for the xul module which affects
stack unwinding and symbolication. That in turn affects signature generation.

Here's the top 6 lines of the October 23rd, 2023 weekly missing symbols report
email:

================  ===================  =====================================  ==================
Name              Version              Debug ID                               # of crash reports
================  ===================  =====================================  ==================
**xul.dll**       **115.3.1.8670**     **000000000000000000000000000000000**  **8066**
nvidiactl         None                 000000000000000000000000000000000      4832
**xul.dll**       **118.0.2.8682**     **000000000000000000000000000000000**  **2091**
omni.ja           None                 000000000000000000000000000000000      2040
icon-theme.cache  None                 000000000000000000000000000000000      1625
libxul.so         None                 000000000000000000000000000000000      1542
================  ===================  =====================================  ==================

``xul.dll`` with no debug id accounts for like 10k crash reports out of like
300k crash reports.

Here's the top 10 signatures for the week ending October 22nd where
``xul.dll/000000000000000000000000000000000`` is a module in the stack:

====  ======================================================================  =====  ==========
Rank  Signature                                                               Count  Percentage
====  ======================================================================  =====  ==========
1     OOM | small                                                             11678  34.31%
2     OOM | large | mozalloc_abort | xul.dll | _PR_NativeRunThread | pr_root  5161   15.16%
3     xul.dll | _PR_NativeRunThread | pr_root                                 3628   10.66%
4     xul.dll                                                                 3466   10.18%
5     OOM | large | xul.dll | _PR_NativeRunThread | pr_root                   1759   5.17%
6     OOM | large | mozalloc_abort | xul.dll | do_main                        1506   4.42%     
7     xul.dll | do_main                                                       1177   3.46%
8     xul.dll | BaseThreadInitThunk                                           621    1.82%
9     OOM | large | mozalloc_abort | xul.dll | BaseThreadInitThunk            475    1.40%
10    OOM | large | xul.dll | do_main                                         393    1.15%
====  ======================================================================  =====  ==========

Not particularly helpful.


**How do we tie code file and code id to debug file and debug id?**

With our current system, the stackwalker has no way to figure out the debug
file and debug id using the code file and code id. We need to maintain a map of
``code file / code id`` -> ``debug file / debug id`` somewhere.

Symbols files for Windows modules have this header::

    MODULE windows arm64 46A0ADB3F299A70B4C4C44205044422E1 xul.pdb
    INFO CODE_ID 64EC878F867C000 xul.dll
    INFO GENERATOR mozilla/dump_syms 2.2.0


If Tecken reads and parses the headers of uploaded symbols files, it can save
that information in the database. Then we can wrap that in some kind of API
that the stackwalker in the Socorro processor can access.


A learning experience
=====================

My initial understanding suggested that to fix this, I would just need to make
changes to Tecken and the stackwalker and Socorro wouldn't need any changes.
That's what led me to believe I could fix this in a week. I was wrong.


Attempt 1
---------

I adjusted the upload API handler in Tecken to read and parse the header for
symbols files and store it in the ``upload_fileupload`` table.

I adjusted the download API in Tecken such that when the debug id is
``000000000000000000000000000000000``, use the ``code_file`` and ``code_id`` in
the querystring parameters to look up the correct debug file and debug id.

It worked great with curl and with this solution, we wouldn't need to make any
changes to rust-minidump.

I pushed those changes to stage and then started testing it out with the
Socorro processor and the stackwalker. The code was correct, but the
stackwalker wasn't getting the symbols files.

After debugging the stackwalker to figure out what the problem was, I
discovered the stackwalker doesn't do a download API request when the debug
file and debug id are empty. I re-read the bug and discovered that's what
Gabriele had mentioned in comment 1 a couple of years ago. I didn't understand
it until now.

Boo.


Attempt 2
---------

I adjusted the upload API handler in Tecken to read and parse the header for
symbols files and store it in the ``upload_fileupload`` table.

I adjust the download API handler in Tecken such that if there's no symbol for
debug file and debug id and the debug id looks like it could be a code id, then
do a lookup in the database for the code file and code id. If we get a db hit,
return an HTTP 302 with the ``Location`` set to the download API url with the
correct debug file and debug id.

I sketched out what we should do in rust-minidump and wrote up issue 870:

https://github.com/rust-minidump/rust-minidump/issues/870

I then pushed the Tecken API changes to production on September 13th which
resulted in a production outage because of several mistakes I made.

Boo.


Attempt 3
---------

I reworked the Tecken API changes I had made:

1. **Added an index we could use for code file / code id queries**

   This way the query wasn't doing a table scan on a large table which tied
   up the db.

2. **Added a separate API endpoint that I could use to test the query**

   This way I could test the index and query without touching the download API
   and causing another outage.

   I did a few rounds of changes and honed the query using this new API.

3. **Constrained the code in the download API**

   Once I had the query working, I re-added it to the download API.

   Previously, the download API would do a code info lookup *any time* the
   symbols file wasn't found. I needed to constrain it to **only** do a code
   info lookup if the debug id looked like it was probably a code id.

I implemented the rust-minidump changes:

https://github.com/rust-minidump/rust-minidump/pull/872

I reworked rust-minidump so that in the case where the debug file and debug id
are empty, it does a lookup against all the symbols suppliers using the code
file and code id.

For symbols servers that support this (i.e. Tecken), it'll return an HTTP 302
with the correct url with the debug file and debug id in the ``Location``
header. For symbols servers that don't support this (i.e. all the other symbols
servers in the world), it'd act like any other missing symbols file.

If the code info lookup gets back an HTTP 302, it parses out the debug file and
debug id, then uses those to look at the on disk symbols cache and request the
symbols file using the symbols suppliers.

In this way, it has the right debug file and debug id when it checks the on
disk symbols cache, so it can take advantage of the cache and we end up with
the correct symbols url in the module data in the stackwalker output.

I pushed all the changes in Tecken to production.

I built the stackwalker with the changes. I updated Socorro to use the new
stackwalker. I landed those changes in Socorro and they deployed to stage.

I reprocessed some crash reports that were affected, but the stackwalker
couldn't find the symbols.

I discovered another bug in the way I was parsing the path for the url returned
in the ``Location`` header. I fixed that bug in rust-minidump, updated the
stackwalker in Socorro, deployed that to stage.

Now everything worked!

Then I load tested the Socorro processor in stage. I needed to know how it
would affect Socorro and Tecken. Everything looked good.

On October 24th, 2023, I deployed the last change in Socorro to production and
we've been running with that ever since.

https://github.com/mozilla-services/socorro/releases/tag/2023.10.24


All together
------------

Thus we have:

* Tecken:

  1. capture code file and code id information when symbols were uploaded
  2. store this information in the database
  3. expose this information in the download API

* rust-minidump:

  1. recognize the situation when acquiring symbols files when a debug file and
     debug id were not available, but a code file and code id was
  2. look up the debug file and debug id using a code file and code id
  3. use the newly discovered debug file and debug id to download the symbols
     file

* socorro-stackalker:

  1. update the stackwalker to the new version
  2. build the stackwalker and package the binaries

* Socorro:

  1. update to the new stackwalker that has the changes for the code info
     lookup


Implementation decisions
========================

**Using the upload_fileupload table**


**Overloading the download API**


**Checking all symbols suppliers**


Results
=======

In the past, if a crash report had modules where we had no debug file or debug
id, but did have a code file and code id, then those modules would not get
symbolicated. There was no way in our system for something to take a code
file/code id and figure out the debug file/debug id in order to find the
symbols file in the symbols bucket.

Bug 1746940 will fix that going forward. Now the Mozilla Symbols Server
captures information in the header of the symbols file and stores it in the
database. Additionally, the Socorro stackwalker will request symbols files
using the code file/code id and the Mozilla Symbols Server will look that up
and figure out the debug file/debug id (if it exists) and return that. This
allows the stackwalker to symbolicate symbols in modules which we couldn't get
symbols files for before.

You'll see evidence of this in a couple of places:

1. crash reports that used to have "xul.dll" or other unsymbolicated things in
   them will now have symbolicated things--we'll see changes in signature
   reports and maybe topcrashers
2. the cases of module/000000000000000000000000000000000 will drop in the
   missing symbols report


**Change in weekly missing symbols report**

October 23rd, 2023:

=================  ============  =================================  ==================
Name               Version       Debug ID                           # of crash reports
=================  ============  =================================  ==================
xul.dll            115.3.1.8670  000000000000000000000000000000000  8066
nvidiactl          None          000000000000000000000000000000000  4832
xul.dll            118.0.2.8682  000000000000000000000000000000000  2091
omni.ja            None          000000000000000000000000000000000  2040
icon-theme.cache   None          000000000000000000000000000000000  1625
libxul.so          None          000000000000000000000000000000000  1542
eOppBrowser.dll    1.0.96.0      6C808BD32F864AA4A5D9542E361D70B61  761
libevent-2.1.so.7  None          1F78309265444CFA435D0A0E5CCF98980  703
DejaVuSans.ttf     None          000000000000000000000000000000000  665
firefox-esr        None          000000000000000000000000000000000  597
=================  ============  =================================  ==================

October 30th, 2023:

=================  ===============  =================================  ==================
Name               Version          Debug ID                           # of crash reports
=================  ===============  =================================  ==================
nvidiactl          None             000000000000000000000000000000000  5814
icon-theme.cache   None             000000000000000000000000000000000  2031
omni.ja            None             000000000000000000000000000000000  1981
libxul.so          None             000000000000000000000000000000000  1581
gschemas.compiled  None             000000000000000000000000000000000  887
kernel32.dll       10.0.22621.2506  6F7660385E7D8D33ED9B5A39B03822F01  821
KERNELBASE.dll     10.0.22621.2506  A068E29BB5CB518EECE623EE824191E31  820
ntdll.dll          10.0.22621.2506  58A282C24AEE7E03A8CF8CB0A782CE0C1  820
ucrtbase.dll       10.0.22621.2506  A18B58F2E2DD692A4591DD05331782BA1  817
libevent-2.1.so.7  None             1F78309265444CFA435D0A0E5CCF98980  814
=================  ===============  =================================  ==================

The ``xul.dll/000000000000000000000000000000000`` items don't show up until
much later in the list now.

=======  ============  =================================  ==================
Name     Version       Debug ID                           # of crash reports
=======  ============  =================================  ==================
xul.dll  115.0.3.8607  000000000000000000000000000000000  175
xul.dll  115.2.1.8655  000000000000000000000000000000000  91
=======  ============  =================================  ==================

Here's the top 10 signatures for the week ending October 23nd where
``xul.dll/000000000000000000000000000000000`` is a module in the stack:

====  ======================================================================  =====  ==========
Rank  Signature                                                               Count  Percentage
====  ======================================================================  =====  ==========
1     OOM | small                                                             11678  34.31%
2     OOM | large | mozalloc_abort | xul.dll | _PR_NativeRunThread | pr_root  5161   15.16%
3     xul.dll | _PR_NativeRunThread | pr_root                                 3628   10.66%
4     xul.dll                                                                 3466   10.18%
5     OOM | large | xul.dll | _PR_NativeRunThread | pr_root                   1759   5.17%
6     OOM | large | mozalloc_abort | xul.dll | do_main                        1506   4.42%     
7     xul.dll | do_main                                                       1177   3.46%
8     xul.dll | BaseThreadInitThunk                                           621    1.82%
9     OOM | large | mozalloc_abort | xul.dll | BaseThreadInitThunk            475    1.40%
10    OOM | large | xul.dll | do_main                                         393    1.15%
====  ======================================================================  =====  ==========

Here's the top 10 signatures for the week ending October 30nd where
``xul.dll/000000000000000000000000000000000`` is a module in the stack:

====  ======================================================================  =====  ==========
Rank  Signature                                                               Count  Percentage
====  ======================================================================  =====  ==========
1     OOM | small                                                             12197  35.50%
2     mozilla::ipc::FatalError | mozilla::ipc::IProtocol::HandleFatalErro...  3492   10.16%
3     OOM | large | mozalloc_abort | webrender::renderer::Renderer::rende...  2371   6.90%
4     OOM | large | mozalloc_abort | xul.dll | _PR_NativeRunThread | pr_root  1771   5.15%
5     mozilla::ipc::FatalError | mozilla::ipc::IProtocol::HandleFatalErro...  1287   3.75%
6     xul.dll | _PR_NativeRunThread | pr_root                                 1232   3.59%
7     xul.dll                                                                 1050   3.06%
8     OOM | large | NS_ABORT_OOM | mozilla::gfx::SourceSurfaceSharedDataW...  1029   2.99%
9     OOM | large | mozalloc_abort | alloc::vec::Vec<T>::push   Add term      780    2.27%     
10    OOM | large | mozalloc_abort | alloc::raw_vec::RawVec<T>::with_capa...  774    2.25%
====  ======================================================================  =====  ==========

There are still a fair number of out-of-memory errors, but the signatures are
much better now.

Skimming the last missing symbols report, I'm guessing this affects 10k out of
like 300k crash reports. I'm not sure if those are all actionable or meaningful
crash reports, but signatures like this (#3 in Top Crashers for Firefox
115.4.0esr)::

    OOM | large | mozalloc_abort | xul.dll | _PR_NativeRunThread | pr_root


switch to something like this::

    OOM | large | mozalloc_abort | webrender::renderer::Renderer::render_impl


Random thoughts
===============

I've been working on Socorro and Tecken alone for a while. I do self-review
because there isn't anyone else to review the work I do. Historically, this has
been good enough. I occasionally make mistakes, but they're caught in CI or
stage environments. In the case where it gets to production, it's usually minor
and I can fix it and push out a fix.

In this case, I made some big errors that probably would have been caught in
code review. I definitely feel bad about them. I added a couple more things to
think about when I do self-review so I don't do something like this again.

Further, starting October 16th, I'll have a team with other people who can
review, so this will further reduce the likelihood of this occurrence.

Along with the changes for this project, I fixed a bunch of minor issues in the
Tecken, socorro-stackwalker, and Socorro repositories to make it easier to
implement and test these changes.

I also built a glossary for Tecken and one for Socorro that adds definitions
for many of the terms used as well as links to references, specifications, etc.

Tecken glossary: https://tecken.readthedocs.io/en/latest/glossary.html

Socorro glossary: https://socorro.readthedocs.io/en/latest/glossary.html


Conclusion and where we could go from here
==========================================

One caveat is that because we have to capture information from the symbol file
and store it in the database in the Mozilla Symbols Server, we won't have code
file/code id -> debug file/debug id information for symbols files that were
uploaded before October 2023. We can backfill this information as we discover
other files it'd be useful for.


That's it!
==========

That's the story of how I implemented code info lookup which required changes
in multiple systems.

Many thanks to Gabriele who helped me understand the problem, figure out how to
fix it, and reviewed (and vastly improved) the rust-minidump changes. Also, to
Markus who helped with understanding the problem and figuring out how to fix
it. Also to Harold and Mikael who helped me work through the production outage
I caused.

If you have any questions or bump into bugs, I hang out on ``#crashreporting`` on
``chat.mozilla.org``. You can also write up a `bug for Socorro
<https://bugzilla.mozilla.org/enter_bug.cgi?format=__standard__&product=Socorro>`_.

Hopefully this helps. If not, let me know!
