.. title: Gaia: First week
.. slug: gaia_onboarding
.. date: 2012-10-23 15:40
.. tags: mozilla, dev, gaia, firefoxos


For the next few months, I'm switching projects to help work on `Gaia
<https://wiki.mozilla.org/Gaia>`_. I essentially started yesterday,
but I'm still missing a bunch of pieces, so I haven't actually done
any work. What I have done is spent time immersing myself in the
project and trying to get my bearings.

Thus this blog post covers how I got my bearings so far.

Gaia is a project in heavy flux and moving fast. The state and
stability of things changes day to day. There are things that aren't
documented. There are things that are documented that are out of
date. There are dozens of etherpads, lists of bugs, wiki pages, and
tips and tricks scattered around. This is the way it is
currently. Even this will probably change.

However it's not all chaos and entropy. While a lot of things are in
flux, some things stay the same. That's why I decided to write this
blog post of things I think help get you up and running faster.

.. Note::

   This blog post definitely has a lifespan. If you're reading this in
   2013, it's probably out of date.


**On Monday**

Read through these hacking wiki pages:

* `Gaia/Hacking wiki page <https://wiki.mozilla.org/Gaia/Hacking>`_
* `B2G/Hacking wiki page <https://wiki.mozilla.org/B2G/Hacking>`_

Join the ``#gaia`` and ``#b2g`` IRC channels on irc.mozilla.org.

Join the `dev-gaia mailing list
<https://lists.mozilla.org/listinfo/dev-gaia>`_.

Fork and clone the `Gaia github repository
<https://github.com/mozilla-b2g/gaia>`_.

That seems like a short list, but take the time to catalog in your
head all the things that are there.


**On Tuesday**

Go to the `Gaia weekly meeting
<https://wiki.mozilla.org/B2G#Meetings>`_.

Mute and facemute yourself. Make sure to follow along in the Etherpad
notes they link to. The meeting I went to used this Etherpad:
https://etherpad.mozilla.org/gaia-meeting-notes

About 1/3 of the way down that pad, there's a list of components,
who's working on them, their status, etc---that's current as of the
time of this writing.

In going to the meeting and reading through the notes, you'll get a
sense of who's who, who's working on what, what the current sprint
priorities are, and you might also get an indication of where you can
help out.

After that, work on `getting Gaia working in the B2G desktop nightly
build <https://wiki.mozilla.org/Gaia/Hacking#B2G_Desktop>`_.

The B2G desktop periodically has stability issues. If you run into
problems, ask on ``#gaia`` on IRC.

.. Note::

   I have a ThinkPad x200 running Debian testing and I couldn't get
   the B2G desktop to work well enough to use. The animations were
   super slow. I have problems with graphics acceleration on this
   laptop with other applications, so I'm pretty sure that's the
   problem. Because of that, I switched to a Macbook Pro running OSX
   10.8.

   I have no experience with B2G desktop on other systems. I've heard
   it works fine in Linux in some situations, but I have no clue what
   the details are.


**On Wednesday**

Assuming you have everything working so far, now's the time to start
looking for bugs to work on and/or testing the existing apps.

As of the time of this writing, the `B2G/Triage wiki page
<https://wiki.mozilla.org/B2G/Triage>`_ has a variety of lists of bugs
in various states. There's the P1 and P2 lists in the Gaia section.

Also, I've accumulated these lists, but they may not be valid anymore:

* `unowned polish bugs <https://bugzilla.mozilla.org/buglist.cgi?quicksearch=component%3Agaia%20sw%3Apolish%20%40nobody;list_id=4753373>`_
* `very short list of bugs marked with the mentored tag <https://bugzilla.mozilla.org/buglist.cgi?field0-0-0=cf_blocking_basecamp;resolution=---;resolution=DUPLICATE;emailtype1=substring;status_whiteboard_type=allwordssubstr;emailassigned_to1=1;query_format=advanced;status_whiteboard=[label%3Amentored];email1=nobody;type0-0-0=equals;value0-0-0=%2B;component=Gaia;component=Gaia%3A%3ABrowser;component=Gaia%3A%3ACalendar;component=Gaia%3A%3AE-Mail;product=Boot2Gecko>`_

I think the workflow is something like this:

1. find a bug you can work on that's not assigned to anyone
2. assign that bug to yourself
3. work on it
4. produce a patch --- must include tests!
5. create a pull request on github
6. find a reviewer to look at it --- probably want someone who works
   on that component; ask on ``#gaia`` on IRC
7. go through review until it's good
8. get someone to land it --- I'm fuzzy on this step, but the person
   needs commit access to the repository on github; ask on ``#gaia``
   on IRC


**Thursday, Friday, etc**

Rinse, repeat.


**Conclusion**

Hope this helps someone else! I think the important thing is to go to
a Gaia weekly meeting.


**Addendums**

Random thoughts that didn't fit anywhere else in this hastily written
post:

1. If you bump into incorrect information in the Gaia/Hacking wiki
   page, please update it or ask someone on ``#gaia`` to verify it's
   incorrect.
2. If you ask a question and no one replies to you on IRC, wait a bit,
   then ask again. Folks are busy and in different time zones, but
   they are paying attention.
3. If you see anything in this blog post that's incorrect, find me on
   IRC. I'm willkg.
4. e.me stands for "everything.me"
5. FTU stands for "first-time-usage"

Also, I overheard this on IRC and it helped::

    <fzzzy> here's something important to understand about ffos:
    there's b2g, and there's gaia

    <fzzzy> b2g is the big compiled blob of c++ and some js modules

    <fzzzy> gaia is all js, but it is preprocessed into a profile
    directory

    <fzzzy> if you double-click B2G.app, you get a gaia profile
    that is inside of the app

    <fzzzy> if you run b2g-bin from the command line, you can pass
    the -profile /path/to/profile flag, and b2g will use that gaia

    <fzzzy> it just depends if you want to just kick the tires, or
    actually hack on gaia itself
