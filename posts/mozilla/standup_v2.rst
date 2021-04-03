.. title: Standup v2: the rewrite
.. slug: standup_v2_rewrite
.. date: 2016-10-28 11:00
.. tags: mozilla, webdev, work, standup, dev

What is Standup?
================

`Standup <http://standu.ps/>`_ is a system for capturing standup-style posts
from individuals making it easier to see what's going on for teams and projects.
It has an associated IRC bot ``standups`` for posting messages from IRC.

This post talks a bit about the Standup v2 rewrite. Why and how we did it and
what's next.


.. TEASER_END

Why?
====

Back in January 2016 or so, it occurred to me that none of the original
maintainers of Standups used or maintained it anymore. Further, it occurred to
me that no one knew this was the case.

I double-checked with everyone and then wrote up an issue along the lines of
"This is not maintained!" Then I moved on with my life.

A couple of months later, Byron wrote up an issue about how Standups should
switch from Persona to something else. I replied, "Thanks for the heads up, but
this project is dead." At that point, a bunch of people started paying attention
and there was a flurry of activity as people declared how useful it is to them.
Further, there wasn't another service or system out there that provided the same
feature set.

At this point, I started to feel bad. I had thought no one was really using
Standup. In my eyes, the system was interesting, but had a ton of issues. Turns
out a bunch of people use it day-to-day. By letting the system die, I was
probably screwing up a bunch of teams at Mozilla.


How?
====

I mulled over fixing the existing Standup. Then I mulled over doing a rewrite.
The rewrite would be a chance to switch to Django which better fit our needs and
also fix some underlying architecture issues. I wasn't wildly excited about
embarking on this on my own, though.

Then just before London, Paul indicated interest and after London we launched on
a secret mission to rewrite Standups. Why secret? Mostly because we wanted the
ability to drop it if it was going to be more involved than we wanted to deal.

After a couple of weeks, we had enough momentum and critical mass that we
figured we'd make it public and finish it up.

I think overall it took us about 6 weeks between the two of us in our spare
time.

I think the results turned out pretty great. Let me enumerate the good things
that came with the rewrite:

1. We're off Persona and onto Github Auth which was a feat for a variety of
   complicated reasons.
2. The entire thing runs in docker which makes dev environments much easier.
3. We have a for-realz admin now that's "for free" because we switched to
   Django.
4. We have a better API token system.
5. We're HTTPS-only with CSP and `score well on Observatory
   <https://observatory.mozilla.org/analyze.html?host=standu.ps>`_.
6. We can deploy a new version of the site by tagging and pushing a commit.


So what next?
=============

When we switched to v2, we kept an eye on the system, helped users migrate to
Github auth, fixed some issues that came up that needed to get fixed pronto and
write issues in the tracker for anything we could defer. Then Paul and I got
really busy and haven't really touched the site since.

Things I'd like to see happen at some point:

1. Freddy indicated an interest in fixing the standup-irc bot and making it
   better. That would be awesome--I need to track him down and empower him.

2. I want to add search.

3. I want to add user tokens to the API. Currently, we have "system tokens", but
   I also want user tokens that are restricted to doing things on behalf of the
   user that owns the token. This makes it possible for people to write their
   own clients which would be SUPER!

4. I want to flesh out the API so writing an external client is possible.

5. I'd like to add tests for the things that don't currently have tests.


How will this work happen? Paul and I haven't been able to do much with Standups
since we did the v2 rewrite so it's probably fair to say we have limited free
time. Standup needs a larger group of maintainers. We need other people who are
interested to help out.

If you're interested in working on Standup in any capacity (documentation,
security, accessibility, testing, UX, user support, coding, etc), join us on
``#standup`` on irc.mozilla.org or reply on issues in the `issue tracker
<https://github.com/mozilla/standup/issues>`_. Start a new issue if you like. I
hang out on IRC between 9:am and 5:pm EST (UTC -5) Monday through Friday. Feel
free to ping me--I'm ``willkg``.

If you're going to Hawaii and interested in doing a sprint, `chime in here
<https://github.com/mozilla/standup/issues/281>`_.

That's it! Yay Standup v2!
