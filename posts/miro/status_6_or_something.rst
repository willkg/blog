.. title: status (6 or something)
.. slug: status_6_or_something
.. date: 2008-09-03 21:41:28
.. tags: miro, work

I haven't written much in the last couple of weeks because I was on
vacation. On the first day of vacation, I went to the beach and got
knocked over by a wave, somersaulted for a while, jammed my shoulder
somehow, skinned my knee, and finally came up for air. I said, "Screw
this!" and went back to my beach chair where I sat around, bled, whined
about how my shoulder hurt and ended up with a serious sunburn. I spent
the next few days indoors--vacation is dangerous.

In the last couple of weeks, I threw together a preferences panel and a
channel settings dialog which, while mostly functional, are "putrid
looking". Luc is going to spend some time fixing that. Ben spent time
re-implementing itemlists and allowing for channel searches, saving
channel searches, and some other things. We've been tweaking the widgets
to make them more functional and pretty.

We still have a lot of other ui stuff that still needs fixing and
tweaking. The dialogs that you sometimes see at startup when things are
awry need reimplementing. The sort bars need to be reimplemented. There
are some other tawdry odds and ends that also need to be redone.
Generally, things are coming together and most of the big features are
in, but there's a bunch of work that still needs to happen.

This morning, we talked about where we want to draw the line and
encourage people to start testing the nightlies again. We haven't thus
far because the laundry list of things that weren't working was pretty
long. Janet thinks it's probably a good idea until most of her litmus
tests pass. Otherwise you'll all be wasting your time finding things we
already know about.

However, I think if you're interested in testing out Miro 2.0, we've hit
a point where it's stable enough to use. I think we're at what other
projects would deem an Alpha 2 state.

Definitely take the time to back up your database BEFORE you try testing
a nightly.

We've got a laundry list of `issues targeted for
2.0 <http://bugzilla.pculture.org/buglist.cgi?query_format=simple&order=relevance+desc&product=Miro&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&target_milestone=2.0&keywords_type=allwords&keywords=>`__.
If you encounter problems with a nightly, let us know. We hang out on
``#miro-hackers`` on ``freenode`` and on the ``develop`` mailing list,
too.

If you're interested in helping out, we sure could use the help:
testing, translating, triaging existing bugs, writing patches, drawing a
fancy 20 page comic describing how great Miro 2.0 is going to be, ....
