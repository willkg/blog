.. title: Experimenting with Symbolic
.. slug: experimenting_with_symbolic
.. date: 2020-04-28 20:00
.. tags: mozilla, work, socorro, tecken, dev, python


One of the things I work on is
`Tecken <https://github.com/mozilla-services/tecken>`_ which runs
`Mozilla Symbols Server <https://symbols.mozilla.org>`_. It's a server that handles
Breakpad symbols files upload, download, and stack symbolication.

`Bug #1614928 <https://bugzilla.mozilla.org/show_bug.cgi?id=1614928>`_ covers adding
line numbers to the symbolicated stack results for the symbolication API. The
current code doesn't parse line records in Breakpad symbols files, so it
doesn't know anything about line numbers. I spent some time looking at how much
effort it'd take to improve the hand-written Breakpad symbol file parsing code
to parse line records which requires us to carry those changes through to the
caching layer and some related parts--it seemed really tricky.

That's the point where I decided to go look at
`Symbolic <https://github.com/getsentry/symbolic>`_ which I had been meaning
to look at since Jan wrote the
`Native Crash Reporting: Symbol Servers, PDBs, and SDK for C and c++ <https://blog.sentry.io/2019/05/23/native-crash-reporting-symbol-servers-pdbs-sdk-c-c-plus-plus>`_
blog post a year ago.


What is symbolication?
======================

There are lots of places where stacks are interesting. For example:

1. the stack of the crashing thread in a crash report
2. the stacks of the parent and child processes in a hung IPC channel
3. the stack of a thread being profiled
4. the stack of a thread at a given point in time for debugging

"The stack" is an array of addresses in memory corresponding to the value of
the instruction pointer for each of those stack frames. You can use the module
information to convert that array of memory offsets to an array of ``[module,
module_offset]`` pairs. Something like this::

   [ 3, 6516407 ],
   [ 3, 12856365 ],
   [ 3, 12899916 ],
   [ 3, 13034426 ],
   [ 3, 13581214 ],
   [ 3, 13646510 ],
   ...

with modules::

   [ "firefox.pdb", "5F84ACF1D63667F44C4C44205044422E1" ],
   [ "mozavcodec.pdb", "9A8AF7836EE6141F4C4C44205044422E1" ],
   [ "Windows.Media.pdb", "01B7C51B62E95FD9C8CD73A45B4446C71" ],
   [ "xul.pdb", "09F9D7ECF31F60E34C4C44205044422E1" ],
   ...


That's neat, but hard to work with.

What you really want is a human-readable stack of function names and files and
line numbers. Then you can go look at the code in question and start your
debugging adventure.

When the program is compiled, the act of compiling produces a bunch of compiler
debugging information. We use ``dump_syms`` to extract the symbol information
and put it into the Breakpad symbols file format. Those files get uploaded to
Mozilla Symbols Server where they join all the symbols files for all the builds
for the last 2 years.

Symbolication takes the array of ``[module, module_offset]`` pairs, the list of
modules in memory, and the Breakpad symbols files for those modules and looks
up the symbols for the ``[module, module_offset]`` pairs producing symbolicated
frames.

Then you get something nicer like this::

   0  xul.pdb  mozilla::ConsoleReportCollector::FlushReportsToConsole(unsigned long long, nsIConsoleReportCollector::ReportAction)
   1  xul.pdb  mozilla::net::HttpBaseChannel::MaybeFlushConsoleReports()",
   2  xul.pdb  mozilla::net::HttpChannelChild::OnStopRequest(nsresult const&, mozilla::net::ResourceTimingStructArgs const&, mozilla::net::nsHttpHeaderArray const&, nsTArray<mozilla::net::ConsoleReportCollected> const&)
   3  xul.pdb  std::_Func_impl_no_alloc<`lambda at /builds/worker/checkouts/gecko/netwerk/protocol/http/HttpChannelChild.cpp:1001:11',void>::_Do_call()
   ...

Yay! Much rejoicing! Something we can do something with!

I wrote about this a bit in :doc:`Crash pings and crash reports
<crash_pings_crash_reports>`.

Tecken has a symbolication API, so you can send in a well-crafted HTTP POST and
it'll symbolicate the stack for you and return it.


Quickstart with Symbolic in Python
==================================

Symbolic is a Rust crate with a Python library wrapper. The Sentry folks do a
great job of generating wheels and uploading those to PyPI, so installing
Symbolic is as easy as::

    pip install symbolic


The Symbolic docs are terse. I found the following documentation:

* `the README <https://github.com/getsentry/symbolic/blob/master/README.md>`_
* `the docs.rs docs <https://docs.rs/symbolic/>`_

That helped, but I had questions those didn't answer. I have an intrepid
freshman understanding of Rust, so I ended up reading the code, tests, and
examples.

The one big thing that tripped me up was that Symbolic can't parse Breakpad
symbols files from a byte stream--they need to be files on disk. Tecken doesn't
store Breakpad symbols files on disk--they're in AWS S3 buckets. So it
downloads them and parses the byte stream. In order to use Symbolic, we'll have
to adjust that to save the file to disk, then parse it, then delete the file
afterwards. [1]_

.. [1] If that's not true, please let me know.

Anyhow, here's some sample annotated code using Symbolic to do symbol lookups:

.. code:: python

    import symbolic

    # This is a Breakpad symbols file I have on disk.
    archive = symbolic.Archive.open("XUL/75A79CFA0E783A35810F8ADF2931659A0/XUL.sym")

    # We do debug ids as all-uppercase with no hyphens. However, symbolic
    # requires that get normalized into the form it likes.
    debug_id = symbolic.normalize_debug_id("75A79CFA0E783A35810F8ADF2931659A0")

    # This parses the Breakpad symbols file and returns a symcache that we can
    # look up addresses in.
    obj = archive.get_object(debug_id=ndebug_id)
    symcache = obj.make_symcache()

    # Symbol lookup returns a list of LineInfo objects.
    lineinfos = symcache.lookup(0xf5aa0)

    print("line: %s symbol: %s" % (lineinfos[0].line, lineinfos[0].symbol))


Cool!

Symbolic parses Breakpad symbols files. It uses a cache format for fast symbol
lookups. Loading the cache file is very fast.

Further, Symbolic  parses files of a variety of other debug binary formats.
This could be handy for skipping the intermediary Breakpad symbol file and
using the debug binaries directly. More on that idea later.

Tecken is maintained by a team of two and we have other projects, so it spends
a lot of time sitting in the corner feeling sad. Meanwhile, Symbolic is
actively worked on by Sentry and a cadre of other contributors including
Mozilla engineers because it's one of the cornerstone crates for the great Rust
rewrite of Breakpad things. That's a big win for me.


So then I built a prototype
===========================

Today, I threw together a web app that does symbolication using Symbolic and
called it Sherwin Syms.

https://github.com/willkg/sherwin-syms/

Building a separate prototype gives me something to tinker with that's not in
production. I was able to add line number information pretty quickly. I can
experiment with caching on disk. I can compare the symbolication API output for
stacks between the prototype and what the Mozilla Symbols Server produces.

There's a lot of scaffolding in there. The Symbolic-using bits are in this
file:

https://github.com/willkg/sherwin-syms/blob/master/src/sherwin_syms/symbols.py


Next steps
==========

I need to integrate this into Tecken. I think that means writing a new v6 API
view because the v4 and v5 code is tangled up with downloading and caching.

Markus and Gabriele suggested Tecken skip the Breakpad symbols files and use
the debug binaries directly--Symbolic can handle those, too. The compelling
reason for this is that Breakpad symbols files lose all the information for
symbolicating inline functions correctly. I hope to look into that soon.


Summary
=======

That summarizes the week I spent with Symbolic.
