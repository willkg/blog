.. title: Socorro signature generation overhaul and command line interface: retrospective (2017)
.. slug: socorro_signature_generation
.. date: 2017-10-06 9:00
.. tags: mozilla, work, socorro, dev, python, story, retrospective

Project
=======

:time: 6 months
:impact:
    * improved ease of contribution for signature generation changes
    * improved ability to experiment with signatures
    * improved ability to use Socorro-style crash signatures in other projects


Summary
=======

This quarter I worked on creating a command line interface for signature
generation and in doing that extracted it from the processor into a
standalone-ish module.

The end result of this work is that:

1. anyone making changes to signature generation can can test the changes out on
   their local machine using a Socorro `local development environment
   <http://socorro.readthedocs.io/en/latest/gettingstarted.html>`_

2. I can trivially test incoming signature generation changes--this both saves
   me time and gives me a much higher confidence of correctness without having
   to merge the code and test it in our -stage environment [#]_

3. we can research and experiment with changes to the signature generation
   algorithm and how that affects existing crash signatures

4. it's a step closer to being usable by other groups

This blog post talks about that work briefly and then talks about some of the
things I've been able to do with it.


.. [#] I can't overstate how awesome this is.

.. TEASER_END


What is Socorro?
================

First off, what is Socorro?

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Firefox and other Mozilla products.

When Firefox crashes, the crash reporter asks the user if the user would like to
send a crash report. If the user answers "yes!", then the crash reporter
collects data related to the crash, generates a crash report, and submits that
crash report as an HTTP POST to Socorro. Socorro saves the crash report,
processes it, and has tools for viewing and analyzing crash data.


What is signature generation?
=============================

For every crash report that is processed, Socorro creates a *signature* for that
crash report. The algorithm for generating a signature consists of an intricate
series of gestures and transformations honed over many years codified as a
pipeline of rules and several lists.

For example, a crash report for an out-of-memory crash might end up with a
signature like this::

  OOM | large | mozalloc_abort | mozalloc_handle_oom | moz_xmalloc | std::_Allocate
  | std::vector<T>::_Reallocate 


Another related to GPU might look like this::

 	mozilla::gfx::GfxPrefValue::AssertSanity 


We use signatures for a couple of things: categorization and correlation.

**We use signatures to categorize crashes into buckets in order to discern
signal from the noise.** We get a lot of crashes and we can't look at all of
them. What we really want to do is look at important ones:

* security issues
* crashes that heavily affect a lot of people
* crashes that heavily affect a specific group of people (people using a
  right-to-left language, people using a specific GPU, people using a specific
  version of Windows, people using a specific antivirus plugin, and so on)
* crashes on a specific channel (release, beta, nightly)

As such, Socorro's analysis tools look at groups of crashes rather than
individual crashes. Signatures let us group crashes by rough indication of the
cause of the crash.

For example, the `Top Crashers report
<https://crash-stats.mozilla.com/topcrashers/?product=Firefox>`_ shows top crash
signatures for some period and movement in rank since the last period. This
report helps us prioritize engineering work and in the case of the nightly and
beta channels, helps us suss out bugs in recent changes.

**We use signatures to correlate groups of crashes between different data
sets.** This should theoretically let us analyze data trends in one system, then
use signatures to look up group of crashes in other systems. This would be super
helpful because Mozilla has different sets of crash data that come from
different places and connecting these data sets will surface issues we can't
otherwise see.

Over the last year, I've had several conversations with people who had data sets
they wanted to correlate with Socorro's crash data.

Late last year, David and team were trying to do client-side symbolification and
signature generation for `crash ping
<https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/data/crash-ping.html>`_
data in Telemetry. Signature generation would allow them to analyze change in
rates on a different data set that had different properties than Socorro's, but
then take the fruits of that analysis and examine the bigger issues in a more
detailed way with Socorro data.

Adam spent some time copying Socorro signature generation code and distilling it
down so that it could run in an IPython notebook. That was probably a ton of
work and great for a prototype, but completely not viable for long-term usage.

Christian built a separate crash ingestion system for collecting crashes from
fuzzing Firefox. These crashes don't come from real users, so it's good to have
them in a separate system. He really wanted to correlate their data with Socorro
data to see if crashes they were seeing from fuzzing existed in the wild. These
could be possible security problems.

Socorro signatures are unique to our system plus they're constantly changing.
Anyone who wanted to correlate using signatures would need to use our code and
since our code is impossible to use or extract, that makes this a very sad story
currently.


Current state of Socorro's signature generation
===============================================

Socorro is like 10 years old. Over that period of time, we've honed signature
generation to fix signatures that were too big and too small and handle changes
in Firefox architecture, libraries, compilers, platforms, and additional
products.

The signature generation system is deeply embedded into the Socorro processor.
It consists of a set of processor transform rules that take in raw and processed
crash data and adjust the signature accordingly. The rules look at many parts of
the crash report and the processed crash report to create a signature: the stack
of the crashing thread, classifications, IPC channel name and error (if there
was one), status strings, and other things. There's no way to run signature
generation on a crash without also processing it and because it's intricately
tied into the processor, it's impossible to use outside of Socorro.

There's a spectrum of signature quality: good to bad.

A good signature is one that puts crashes that have differing symptoms but the
same cause into a single group with a single signature.

A bad signature is one that puts crashes that don't really have anything to do
with one another in the same group. Maybe it groups a bunch of crashes that
happened on a Thursday in June. Nice, but unlikely to be helpful. Bad signatures
can also create groups that are "too big" (too many unrelated crashes) or groups
that are "too small" (many signatures cover the same problem).

Signatures are in constant flux and can be affected by many things: new versions
of operating systems system libraries, changes to libraries Firefox uses, and
changes to Firefox (contents of crash report, JIT changes, architecture changes,
and so on).

Today's crashes will probably look different than crashes from 6 months ago even
if they're for the same problem. However, the better our signatures are, the
more likely we can see causes of crashes over long periods of time.

We're constantly tweaking signature generation. Most changes happen in files
that contain lists of regular expressions for tokens that show up in stack
frames. We call these "siglists" for reasons I'm not entirely sure of. Maybe
it's short for "signature lists" or something. We have a list for tokens we
never care about. We have a list for tokens that should be part of the signature
and indicate we should continue to the next frame of the stack. I think we
average a change a week, but they tend to come in spurts.

When someone goes to make a change to one of the lists, they open up a pull
request with the change. There's no way to test the change before opening a pull
request. There's no way to test the change during review, either. Generally, we
eyeball the change, harumph a few times, merge it, and then test it once it's
been deployed to our -stage environment by reprocessing a few selected crashes.

In summary, our signature generation system has been honed over many years, is
intricately tied to the processor, consists of many intricate steps, changes
often, and doesn't have a good workflow for changing it.


Why work on it now?
===================

Adrian used to review all incoming signature generation pull requests, but then
he went off to a different team and I took over his duties. He was familiar with
signature generation. I was not. So there I was trying to review changes with no
experience/wisdom with how changes can affect signatures.

Lonnen wanted me to look at other ways we could generate signatures particularly
whether generating signatures using less of the raw and processed crash was
viable. In order to do that, I'd have to build a harness of some kind that
didn't exist, yet.

Lastly, I had finished up extracting the Socorro collector (now called Antenna)
into a separate project and was looking at how to do the same thing for the
processor. The processor is more complicated, so I was thinking it might be nice
to extract signature generation first and thus break it up into a series of
smaller, more impactful steps.

Relatedly, I had conversations with other groups about correlating using
signatures and it's a sad story. There's a lot of work that we'd need to do to
fix that. Seems like a good idea to take a step in that direction now while I'm
making it easier to test changes and experiment.

All of that led up to me throwing together a prototype to prove viability of
this project and then spending a quarter on extracting signature generation and
throwing a command line interface on it.


Goals
=====

I set out to make the following things possible:

**People making changes can test changes in a local development environment.**
People can verify their changes are correct before making a pull request. I can
verify correctness when merging. I can also test changes on 1000s of crashes and
see if they affect things in adverse ways.

Fixing this will improve our ability to make signature generation changes
quickly and accurately and improve our confidence for correctness. Because
signatures are one of the cornerstones for most of Socorro's analysis tools,
this is a big deal.


**I want to experiment with signature generation changes.** I want to be able to
test changes on 1000s of crashes and understand what changed. This makes it
possible to do projects like "make signatures for this group of crashes better".
Right now that kind of project is like "shovel the driveway with this spoon".

I want to be able to test changes on crashes that meet certain criteria. For
example, testing signature changes on all the crashes for Firefox 58 in the
nightly channel that are shutdownhangs.

We need tools to be able to experiment with the signature generation system in
order to improve it.


**I want to be able to support multiple signatures.** During processing, Socorro
generates two signatures: a "proto signature" which is based entirely on the
stack frames of the crashing thread and a "signature" which is generated from
the signature generation algorithm. Both of these are created with the current
signature generation system.

Signature generation is a static pipeline of rules. Socorro can only create
these two signatures and no others during processing.

I want to turn signature generation into its own pipeline so that we can run
multiple pipelines and get multiple signatures. This opens up some possibilities
for correlation in the future.


**We want to make it easier for other groups to use our signature generation
code.** Socorro's signatures are kind of like Nonna's special sauce--you can't
make them anywhere else. It's impossible to correlate data between systems if
there's no common key. If we want to use the Socorro signature as the common key,
then other groups need to be able to generate that from their crash data.


**Reduce maintenance burden.** Socorro is huge. We need to make changes that
enable us to do more, better, with less resources. This change has to reduce
maintenance burden.


What I did
==========

In July, I wrote a prototype. I wanted to know if I could build a signature
generation system that could generate signatures for crashes using data that was
publicly available from the Socorro APIs. The prototype took me a couple of days
to build. That let me show Lonnen that the idea had legs, plus I could show him
all the fancy things I could do with it even though it was a *rough* prototype.

The prototype proved the project was viable so I wrote up `bug #1385970
<https://bugzilla.mozilla.org/show_bug.cgi?id=1385970>`_ which focused on
writing a signature generation command line interface with extracting signature
generation being a side-effect of working on the bug.

I was concerned about how big the project was, so I spent time reducing the
scope. Having a standalone library would be great, but that's a lot of
additional up-front work and ongoing maintenance work. I pushed standalone
library work off to a later phase, but kept this in mind as I worked on the
project.

We had a bunch of other big projects in the queue for Socorro, so this project
simmered on the back burner and when I had time to work on it, I ended up
rewriting it a couple of times. The prototype was *rough*, so this was for the
best.

I spent a lot of time landing smaller changes that could stand on their own.
This reduced the size of the final pull request making it smaller, easier to
review, and less risk. It also meant I was making progress by shipping small
changes. However, it probably added to the overall length of the project.

I cleaned up the tests for signature generation rules.

I converted the processor transform rules into signature transform rules so
generating signatures no longer depends on the rest of the processor.

I simplified the rule structure, too, since we didn't need to support
requirements the rest of the processor had. I wish I had simplified it
more--it feels clunky now.

I removed use of ``DotDict`` and ``configman`` and other Socorro-y things from
signature generation code. It still uses some things from Socorro, but only
minor ones. I tried to minimize the number of libraries required. This will
reduce the work required to fully extract the library when we eventually do
that.

I moved the ``SignatureJitCategory`` rule to be with the rest of the signature
generation rules. That rule originally ran later in the processor pipeline, but
if we wanted to generate a signature as a single step, I needed to move that
earlier to be with the other signature generation rules.

I wrapped the whole thing in a command line interface that can take crash ids
from stdin or the command line. (More on that in a bit.)

I went through and made it a bit more Python 3 friendly. We don't run it in a
Python 3 environment and there's no Python 3 testing, but it's more likely to
work in Python 3 now.

I wrote a couple of "outputters" for the command line interface so it can spit
out output in text as well as CSV. I figured those were the formats that help me
do my work. We can easily add others if someone needs them.


The new command line interface
==============================

Let's talk about what we have now.

The command line interface runs in the processor container of the Socorro local
development environment. You could build a different container to run it in--it
just needs certain Python libraries to be installed.

It has a usage like this::

  $ python -m socorro.signature CRASHID [CRASHID ...]


You can get help like this::

  $ python -m socorro.signature --help


It can format the output in text::

  $ python -m socorro.signature eabeedd9-5e6f-4e03-a7f2-220a70171004
  Crash id: eabeedd9-5e6f-4e03-a7f2-220a70171004
  Original: mozalloc_abort | abort | core::option::expect_failed | webrender::frame_builder::FrameBuilder::build
  New:      mozalloc_abort | abort | core::option::expect_failed | webrender::frame_builder::FrameBuilder::build
  Same?:    True


Or CSV (long line that I wrapped)::

  $ python -m socorro.signature --format=csv eabeedd9-5e6f-4e03-a7f2-220a70171004
  "crashid","old","new","same?","notes"
  "eabeedd9-5e6f-4e03-a7f2-220a70171004","mozalloc_abort | abort | core::option::expect_failed | webrender::fram
  e_builder::FrameBuilder::build","mozalloc_abort | abort | core::option::expect_failed | webrender::frame_build
  er::FrameBuilder::build","True","[]"


When you're working on changes and want to see how changes affect a lot of
crashes, you can use the ``--different-only`` flag to show just the signatures
that changed.

It can take crash ids from stdin as well as from the command line. You can use
it in concert with ``scripts/fetch_crashids.py`` to do a Super Search in Crash
Stats for signatures that contain some string and run all those through
signature generation. For example, this looks at all signatures for the Firefox
product from yesterday that have "shutdownhang" in the signature::

  $ ./scripts/fetch_crashids.py --signature-contains=shutdownhang | \
      python -m socorro.signature


Before this change, reviews used to go like this:

1. Someone would put together a PR.
2. I'd be like "looks ok", but I really have no idea until we've landed the
   change and deployed it to -stage.

   * If the change is good, we're fine.
   * If the change is bad, then we have to revert it or do another PR.
     Meanwhile, we can't deploy anything to prod until we resolve this.

Fully reviewing signature generation changes would take an hour or more
depending on how long it took to deploy to -stage.

After overhauling signature generation, we have conversations like this:

https://github.com/mozilla-services/socorro/pull/3992

I can verify the change works in minutes and also look at other crash reports
to see if it causes unintended changes. We can modify the changes in the PR in
multiple iterations if it warrants.

I also worked on `bug #1402037
<https://bugzilla.mozilla.org/show_bug.cgi?id=1402037>`_ which aimed to improve
signatures for shutdownhang crashes which exceeded 255 characters and thus were
truncated. One of the things I did for that bug was make a big text file with
all the crash ids for shutdownhang crashes over the last week. There were around
17,000 crash ids in that list.

I built the list like this::

  (container) $ ./scripts/fetch_crashids.py --url=REALLYLONGSUPERSEARCHURL > bug1402037.txt


Then I ran signature generation like this::

  (container) $ cat bug1402037.txt | python -m socorro.signature --format=csv > output.csv


Then I'd pull the file into LibreOffice Calc and sort it and see what happened.

The signature generation command line interface makes that easy. However, it
takes a really long time to run because for each crash it's pulling raw and
processed information from the Crash Stats APIs. I wrote up `bug 1403339
<https://bugzilla.mozilla.org/show_bug.cgi?id=1403339>`_ for caching raw and
processed data which would radically speed up running signature generation a
second time on the same set of crash ids.

Tada!

There's more information about signature generation in the `signature generation
documentation
<http://socorro.readthedocs.io/en/latest/architecture/signaturegeneration.html>`_.


Random thoughts
===============

**Prototypes grease the wheels of progress.** The prototype proved the project
was viable and worth working on.

**It's not quite perfect especially regarding JIT-related crashes.** There's a
JIT classification annotation in the processed crash that's not available from
the public processed crash API. That means you need an API token with permission
to view personally identifiable information to see JIT classification. If you
don't have an API token, then JIT-related crashes will end up with a different
signature when running the signature generation command line interface in a
local development environment. There's nothing we can do about this.

**It's still a sad story for external users, but a step in the right
direction.** I didn't fully extract the library, so it's still hard to use for
non-Socorro things. I did document some things we didn't previously know about
signature generation. For example, now we know exactly what data it requires.
We'll need to do more to make this viable for external uses.

**The API is lacking.** The pseudo-extracted library has a terrible API making
it hard to use. We'll need to do more to make this viable for external uses.

**Reducing scope helps things ship.** Socorro has two developers [#]_ and in
2017q3, we were juggling a bunch of big projects. I ended up prioritizing and
then deprioritizing this project several times. We had merge conflicts due to
other work, so I rewrote it a few times. It would have been easier if there was
less going on and if I had focused on this until it shipped. Life is hard! If I
hadn't reduced the scope, it wouldn't have shipped in this environment.

.. [#] Two Socorro developers for a codebase that's roughly 62k LOC Python and
       then 20k bash, SQL, JS, and other things.


Conclusion and where we could go from here
==========================================

I've been able to work on signature generation bugs I wasn't able to work on
before. I can review signature generation pull requests and tell the author
exactly how the change affects signatures. Theoretically, other people can test
their changes now, though I don't know if anyone has.

In extracting signature generation, we improved the documentation for it and how
it works as well as what parts of the raw and processed crash it requires.

It's easier to pull this code out of Socorro and use it elsewhere, thought
probably still not viable.

I think all-in-all it's a good step in the right direction. But there's more we
could do!

**We could improve the API.** The API for the pipeline is terrible. This is in
part because I wanted to minimize the number of changes I made to extract it
from being part of the processor. The signature generation pipeline doesn't need
to think about raw and processed crash structures--it can just think about the
data it's being passed in.

Similarly, it modifies the signature value in the processed crash. Instead of
modifying the processed crash, it should be returning a signature structure
which gets passed to the next rule in the pipeline. Then we can treat the crash
data as immutable and reduce weirdo side-effects of the pipeline.

Improving the API will make it easier for others to use.

**We could document all the bits that go into making a signature.** The command
line interface code extracts the bits it needs from the raw and processed crash,
but no where do we explain what those bits are or what they look like. Fixing
this would make it easier to use.

Further, it's likely we could reduce the data we need even more. Instead of
providing all the threads of data, we only need the *important* one which is the
crashing thread or thread 0 (I think that's what it is). We don't need the
others. Maybe there's other data like that which we could remove?

**We could extract into a standalone library or put it in a web service or
something.** In its current state, it's hard for anyone else to use. I was
thinking we could turn it into a standalone library, but that has some tough
maintenance costs around using it in Socorro and releases and such. There are
solutions to those problems, but all of them involve an additional maintenance
burden for a very very small team.

Ted suggested making a web service. That's definitely doable. Then anyone could
use it regardless of the programming language they're using. It's worth asking
around and seeing what the usage requirements and impact of doing this would be.
Does it help some team a lot? Is it a silver bullet for work on Firefox
stability?

The next step would probably involve talking with other groups who need to
correlate crash data with Socorro and figuring out how can we do that in a way
that maximizes ease of use but minimizes maintenance.

If you're in such a group, get a hold of me!

**We could experiment with other signature generation algorithms.**
`Backtrace <https://backtrace.io>`_ uses a machine learning algorithm on a large
crash data set to suss out what makes a good signature and then uses that. They
update their corpus periodically. We've probably got enough data that this could
be an interesting approach. Maybe use it as a second categorization system?

There's probably a need for generation signatures using less information--maybe
just using the stack. Does that help correlating with other data sets? Should
crashes have multiple signatures?


That's it!
==========

That's the story of the signature generation command line interface. Any factual
errors are because of a lack of ice cream while writing this.

If you have any questions or bump into bugs, we hang out on ``#breakpad`` on
``irc.mozilla.org``. You can also write up a `bug for Socorro
<https://bugzilla.mozilla.org/enter_bug.cgi?format=__standard__&product=Socorro>`_.

Hopefully this helps. If not, let us know!
