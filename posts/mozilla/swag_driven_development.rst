.. title: Side projects and swag-driven development
.. slug: swag_driven_development
.. date: 2018-03-12 22:00
.. tags: mozilla, work, standups

Summary
=======

I work at Mozilla. I work on a lot of stuff:

* a main project I do a ton of work on and maintain: `Socorro
  <https://socorro.readthedocs.io/>`_
* a bunch of projects related to that project which I work on and maintain:
  `Antenna <https://antenna.readthedocs.io/>`_, `Everett
  <https://everett.readthedocs.io/>`_, `Markus
  <https://markus.readthedocs.io/>`_
* some projects that I work on occasionally but don't maintain:
  `mozilla-django-oidc <https://mozilla-django-oidc.readthedocs.io/>`_
* one project that many Mozilla sites use that somehow I ended up with but has
  no relation to my main project: `Bleach <https://bleach.readthedocs.io/>`_
* some projects I'm probably forgetting about
* a side-project that isn't related to anything else I do that I "maintain":
  `Standups <https://standu.ps/>`_

For most of those projects, they're either part of my main job or I like working
on them or I get some recognition for owning them. Whatever the reason, I don't
work on them because *I feel bad*. Then there's Standups which I work on solely
because *I feel bad*.

This blog post talks about me and Standups, pontificates about some options I've
talked with others about, and then lays out the concept of swag-driven
development.


.. TEASER_END

Standups
========

Standups originated many years ago as a side-project by the SUMO engineering
team. We were working with a group that wanted a very detailed and up-to-date
account of what we were working on. Following checkins on GitHub or components
in Bugzilla wasn't good enough. We somehow had to keep them up to date, but do
it in a way that didn't involve spending gobs of time in meetings [#]_.

So we wrote Standups. It was social-media-esque. We could interact with it via a
bot in our project IRC channel. It had feeds. Later, I wrote a system that would
roll up a week of Standups updates, throw them in an email, do some rough
analysis, and send it weekly. It worked. It was good enough.

While writing Standups, we experimented with writing Flask apps, IRC bots
written in Node, Persona authentication, and other things. That was cool, too.

Then a bunch of other people showed up and started using Standups. They had
various requests. Suddenly we had all this additional maintenance work to
support new users and new usages.

The SUMO team broke up. None of them still use the system. I use it on and off
depending on how overwhelmed I'm feeling and probably some other things.

In January 2016, we had this situation that can be rougly summarized like this:

1. None of the original maintainers still used it.
2. It was effectively abandoned.
3. No one knew that.
4. Standups had a bunch of technical debt including that it was using Persona
   which was getting shut down.
5. Standups had a bunch of users who were using it as a tool in their work lives
   to help them do *important things*.

Paul indicated some interest in rewriting it just before the London All Hands
in 2016. Over the next few months, we rewrote it in our spare time and thus was
born Standups v2. I wrote a
:doc:`blog post about Standup v2 <standup_v2_rewrite>`.

Now I've got this project I'm working on *in my spare time* [#]_ that I'm pretty
much doing solely because *I feel bad*.

Flash-forward a year and a half with Paul and I doing guilt-driven development
and wishing anyone else would show up and help out and/or take it from us.

Generally, the situation stinks--it's not good for me and not good for the
users--and there's nothing to indicate it will change any time soon.


So what are the options for failing, but important side-projects?
=================================================================

Let's step back a bit from my poor choices on how I spend my copious lack of
free time.

While the details I recounted so far are specific to Standups, I wonder how many
other side-projects at Mozilla are like this: someone starts it to solve some
immediate need, a bunch of users show up, no one helps out, someone continues
maintaining it because it's become a critical part of peoples' work
infrastructures.

How many guilt-driven development projects are there?

What are some options for climbing out of that free fall into the burnout abyss?

One option I keep hearing is, "Walk away." That has some niceties--it's easy to
do. But I feel bad for the people using the project. Seems like they're now
hosed. One might think, "If it was really important, then someone will pick it
up." But that has never happened in my experience except for the things I picked
up. As near as I can tell, things like this become a ticking timebomb of
technical obsolescence and then ends up as a HUGE problem later on when people
discover they rely on breaks.

Another option I keep hearing is to push Mozilla leadership into making
side-projects *real*. That seems like a good option and I think it happens
periodically. I sort of did this with Bleach. I spent tons of time trying to get
Bleach turned into a real project and it sort of is now.

Based on that experience, I think it requires a bunch of people and meetings to
come to a consensus on validating the project's existence which is a lot of work
and takes a lot of time. It's important that projects paid for by budgets have
impact and value and all that--I get that--but the work to get a side-project to
that point is unpleasant and time-consuming. I bet many side-projects can't pass
muster to become a real project. I think what happens instead is that
side-projects continue to exist in the misty "there be dragons" part of the
Mozilla universe map until the relevant people leave and stuff breaks.

There are probably other options.

I've been wondering about an option where where the maintainers aren't locked
into choosing between walking away and guilt-driven development for a project
that's important, but for some reason doesn't have a critical mass and doesn't
pass muster enough to turn into a real project.

I started wondering if my problem with Standups is two fold: first, I have no
incentive to work on it other than bad feelings, and second, it's a free service
so no one else has incentive to work on it either.

One incentive is getting paid in money, but that's messy, problematic, and hard
to do. But what if we used a different currency? There's a lot of swag at Mozilla.
What if we could use swag to drive development?

.. [#] This is my account of the situation. I bet other people have different
   accounts.

.. [#] I have family and I work on a bunch of big projects and I don't have
   a lot of free time, so this is a big deal.


Swag-driven development concept
===============================

Some of the swag at Mozilla is really neat! Many groups are making stickers
and t-shirts and plushies and a variety of other things. Some swag is
temporal--it exists in a time and a space and then it's gone. There's value
to swag!

I propose swag-driven development is an interesting possibility.

As a maintainer of a swag-driven development project, you could do something
like this:

1. Add a statement to the project documentation, README, and other similar
   places:

      This project follows swag-driven development. If this project
      is helpful to you, swag donations are encouraged and welcome.

2. When marking bugs fixed, add a note like this:

      I work on this as a side project. If this is helpful to you, swag
      donations are encouraged and welcome.

3. When asked to work on a bug that seems in-scope for the project and possibly
   helpful to someone, but it's not something you want to work on, you could
   respond like this:

      I recognize you want this feature implemented and it seems helpful, but
      this isn't something I want to work on. I would accept a pull request!
      Alternatively, if it's really important to you and no one else will do it,
      I'd be up for implementing this feature for a plushie.


As a user of a swag-driven development project (or any project, really), you
could do something like this:

1. Show appreciation for the maintenance efforts:

      This project helps my work significantly! I really appreciate you
      working on it! I've got some fab stickers--I'll get them to you!

2. Offer incentives to implement/fix things that are important to you:

      I realize this feature is a total slog, but it's really important
      to me! My team is doing plushies and I'll make sure you get one at
      the next All Hands [#]_!

3. Join and help out:

      Holy crap! I saw you strutting around the last All Hands in
      fancy A-Team snow pants [#]_! I'd love to score a set of those. I want
      to help out with maintaince! Where can I sign up!?


Maybe something like this doesn't solve all the problems. Maybe it makes some
aspects of project maintenance worse. Maybe it only works in some situations
with side-projects that have certain properties.

But it sounds really neat! I know when I was talking about it with Paul, he saw
potential! There's a lot of neat swag out there! Lots of people like swag!

Seems like it's worth trying.

.. [#] Mozilla has All Hands meetings every 6 months. They're pretty intense.

.. [#] The A-Team should totally do team snow pants.


Standups is switching to swag-driven development
================================================

I need to flesh out some phrasing such that requests for swag aren't
mean-spirited klaxons of heartless capitalist cruelty, but rather angelic
arpeggios of an angelic harp that evokes the eternal struggle of free time
versus the empathy and understanding that our side-projects help you do your
work and that's important to you and to us, too.

As soon as we figure that out, Standups is switching from guilt-driven
development to swag-driven development and we'll see whether that helps or not.
