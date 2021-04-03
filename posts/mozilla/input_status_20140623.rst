.. title: Input status: June 23rd, 2014
.. slug: input_status_20140623
.. date: 2014-06-23 10:25
.. tags: mozilla, work, input, dev, python


I publish a status report to the `input-dev mailing list
<https://mail.mozilla.org/listinfo/input-dev>`_ every couple of weeks
or so covering what was accomplished and by whom and also what I'm
focusing on over the next couple of week. I sometimes ruminate on some
of my concerns. I think one time I told a joke.

Since the last report:

Landed and deployed:

* fb83dd5 [:bz:`1017828`] Add translation auditing
* dccfb76 [:bz:`1026019`] Rework bigram generation

Landed, but not deployed:

* c348989 Add bug triaging for new contributors section
* 5b7dc67 Add Gengo API tests and skip_if infrastructure
* 98d30fb [:bz:`1026131`] Add Gengo human translations bookkeeping
* 38d8584 [:bz:`1026131`] Rework translations system logging code
* 1d9e67a [:bz:`1027293`] Add audit records to response view

HEAD: 1d9e67a


Mostly I spent the last couple of weeks working on automated Gengo
human translation support. This involved some infrastructure rewriting
plus some additional infrastructure so that when we push all this out,
we can see what's going on as it is happening.

Additionally, I went through and updated the mentor metadata for
mentored bugs, added a bunch of new mentored bugs and worked with two
potential contributors on them.

Over the next week (last week in 2014q2):

1. finish up automated Gengo human translation work


First thing in 2014q3, I'll spend some time "opening up" the
development side of the project. This will make it easier/possible to
follow and participate in development. I'm still figuring out some of
the details and it's likely I'll continue to change how things work
over the course of the quarter, but plan to follow advice from the
Community Building team and Erik Rose who seems to be doing really
super with `DXR <https://wiki.mozilla.org/DXR>`_.
