.. title: Input: 2014q2 post-mortem
.. slug: input_2014q2
.. date: 2014-07-01 14:20
.. tags: mozilla, work, input


I'm going to start doing quarterly post-mortems for `Input
<https://input.mozilla.org/>`_ development. The goal is to be more
communicative about what happened, why, what's in the works and what I
need more help with.

NB: "Fjord" is the name of the codebase that runs Input.


Bug and git stats
=================

::

    Bugzilla
    ========

    Bugs created:        63
    Bugs fixed:          54

    git
    ===

    Total commits: 151

          Will Kahn-Greene :   143  (+15123, -4602, files 446)
            ossreleasefeed :     3  (+197, -42, files 9)
              Joshua Smith :     2  (+65, -31, files 5)
              Anna Philips :     1  (+367, -3, files 12)
         Swarnava Sengupta :     1  (+2, -2, files 1)
             Ricky Rosario :     1  (+0, -0, files 0)

    Total lines added: 15754
    Total lines deleted: 4680
    Total files changed: 473


We added a lot of lines of code this quarter:

* April 1st, 2014: 15195 total, 6953 Python
* July 1st, 2014: 20456 total, 9247 Python

That's a pretty big jump in LOC. I think a bunch of that is the
translation-related changes.


Contributor stats
=================

5 non-core people contributed to Fjord development.

I spent some time over the weekend finishing up Vagrant provisioning
script and rewriting the docs. I'm planning to spend some more time in
2014q3 reducing the complexity and barriers for setting up a Fjord
development environment to the point where someone can
contribute.

Additionally, I'm planning to create more bugs that are
contributor-friendly. I started doing that in the last week. I think a
good goal for Input is to have around 20 contributor-y bugs hanging
around at any given time.


Accomplishments
===============

**Site health dashboard**: I wrote a mediocre site health dashboard
that's good enough to give me a feel for how the site is performing
before and after a deployment. This still needs some work, but I'll
schedule that for a rainy day.

**Client side smoke tests**: I wrote smoke tests for the client
side. I based it on the defunct input-tests code that QA was
maintaining up until we rewrote Input. There are still a bunch of
tests that I want to write to have a better coverage of things, but
having something is way better than nothing. I'm hoping the smoke
tests will reduce the amount of manual testing I'm doing, too.

**Vagrant**: I took some inspiration from Erik Rose and DXR and wrote
a Vagrant provisioning shell script. This includes a docs overhaul as
well. This work is almost done, but needs some more testing and will
probably land in the next week or two. This will make peoples' lives
easier.

**Automated translation system (human and machine)**: I wrote an
automated translation system. It's generalized so that it isn't
model/field specific. It's also generalized so that we can add plugins
for other translation systems. It's currently got plugins for `Dennis
<https://dennis.readthedocs.org/>`_, Gengo machine translation and
Gengo human translation. I turned the automated human translation on
yesterday and it seems to be working well. That was a *HUGE*
project. I'm glad it's done.

One thing it includes is a lot of auditing and metrics gathering. This
will make it possible for me to go back in time and look at how the
translation system worked on various Input feedback responses and hone
the system going forward to reduce the number of human translations
we're doing and also reduce the number of problems we have doing them.

**Better query syntax**: We were upgraded to Elasticsearch 0.90.10. I
switched the query syntax for the dashboard search field to use
Elasticsearch ``simple_query_string``. That allows users to express
search queries they weren't previously able to express.

**utm_source and utm_campaign handling**: I finished the support for
handling ``utm_source`` and ``utm_campaign`` querystring
parameters. This allows us to differentiate between organic feedback
and non-organic feedback.

**More like this**: I added a "more like this" section to the response
view. This makes it possible for UA analyzers to look at a response
and see other responses that are similar.


Dashboards for you, dashboards for everyone!
============================================

I'm putting this in its own section because it's intriguing. I'll
write another blog post about it later in July as things gel.

On Thursday, a couple of days after d3 training that Matt organized,
I threw together a better GET API for Input feedback responses. It's
not documented, it probably has some bugs and it's probably going to
change a bit, but the gist of it is that it lets you more easily build
a dashboard that meets your needs against live Input data.

Here's a proof-of-concept:

http://bl.ocks.org/willkg/c4d5a272f86ae4510750

That's looking at live Input data using the new GET API. The code is
in a GitHub gist. It auto-updates every 2 minutes.

The problem is that I've got a ton of Input work to do and I just
can't write dashboard code on Input fast enough. Further, of the
people I've talked to that use the front page dashboard, they all have
really different questions they're asking of the data. I'm hoping this
alleviates that bottleneck by letting you and everyone else write
dashboards that meet your needs.

I encourage you to take my proof-of-concept, fork the gist, tweak it,
use bl.ocks.org or something to "host" the gist. Build the dashboard
that answers your questions. Share it with other people. Plus, let me
know about it. If you have issues with the API, `submit a bug and tell
me
<https://bugzilla.mozilla.org/enter_bug.cgi?product=Input&rep_platform=all&op_sys=all>`_.

If this scratches the itch I think needs scratching, it should result
in a bunch of interesting dashboards. If that happens, I'll write some
code in Input to create a curated list of them so people can find them
more easily.


Summary
=======

This was a really nuts quarter and parts of it really sucked, but we
got a lot accomplished and we laid some groundwork for some really
interesting things for 2014q3.


**Update April 21st, 2015**

LGuruprasad found a bug in the script that caused commits-by-author
information to be wrong. Fixed the script and updated the stats!
