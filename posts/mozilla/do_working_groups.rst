.. title: Data Org Working Groups: retrospective (2020)
.. slug: do_working_groups
.. date: 2021-02-25 10:00:00 UTC-05:00
.. tags: mozilla, data, story, retrospective
.. category: 
.. link: 
.. description: Data Org Working Groups project
.. type: text

Project
=======

:time: 1 month
:impact: established cross organization groups as a tool for grouping people


Problem statement
=================

Data Org architects, builds, and maintains a data ingestion system and the
ecosystem of pieces around it. It covers a swath of engineering and data
science disciplines and problem domains. Many of us are generalists and have
expertise and interests in multiple areas. Many projects cut across
disciplines, problem domains, and organizational structures. Some projects,
disciplines, and problem domains benefit from participation of other
stakeholders who aren't in Data Org.

In order to succeed in tackling the projects of tomorrow, we need to formalize
creating, maintaining, and disbanding groups composed of interested
stakeholders focusing on specific missions. Further, we need a set of best
practices to help make these groups successful.

.. TEASER_END

Prelude
=======

Data Org had just had a re-org and a bunch of people were now in new teams.
There was a concern that as generalists in new teams, it would be difficult to
do some of the kinds of work we used to do especially where it's not part of
the mandate for our new teams.

This re-org meant that I was solo-ish again. I was mulling over how I can
create a good enough approximation of being on a team without a ton of extra
work.

Further, I work on crash ingestion which is the other side of crash reporting
and this particular system involves teams and individuals spread out across
Mozilla. I was trying to figure out how we could coordinate better. Mozilla
doesn't have anything I'm aware of to support that.

Anyhow, so I was talking with Mark about that in a 1:1 and he mentioned how he
was trying to figure out how to group people in ways that aren't organizational
structure. I offered to do a Google doc and collect research and links on
working groups and like structures.

That evolved into a proposal for Data Org Working Groups which was accepted and
turned into a thing at the end of 2020.


What I found
============

There are a lot of links out there to blog posts and introspectives on
different ways to structure groups that cross organizational boundaries. Many
of them are structured in a specific way to solve specific needs and it seemed
like they had a lot of bookkeeping and management to keep them going.

Here's my rough notes on research--they're rough and possibly wrong in places
especially where the blog post doesn't match reality.

* Python special interest groups

  https://www.python.org/community/sigs/guidelines/

  * Every SIG must have a clear mission with a well defined conclusion and end
    date.
  * SIGs shouldn't overlap with other SIGs
  * Every SIG has a coordinator who is responsible for reporting on the SIG
    activity and for shepherding.
  * SIG activity occurs on mailing lists that are managed automatically.
  * To create a new SIG, you have to request it on the meta-SIG.

* Mozilla module owners

  https://wiki.mozilla.org/Modules

  * Modules are defined by a significant chunk of code or work
  * Modules have "owners" and "peers" who are responsible for the module,
    decisions, and governance of the module
  * Module owners can change the owners and peers for a module over time.
  * There is a Firefox Technical Leadership Module which oversees all modules.

* ACM SIGs

  https://www.acm.org/special-interest-groups

  https://www.acm.org/special-interest-groups/about-special-interest-groups

  * SIGs focus on specific topics and improving the skills of their members.
  * SIGs offer opportunities to network and stay connected with peers.
  * SIGs publish newsletters and magazines, have recognition programs, and run
    conferences and trainings.
  * It might be interesting to have research-focused working groups.

* Spotify guilds

  https://www.atlassian.com/agile/agile-at-scale/spotify

  * Guilds are a grouping of people across tribes.
  * Anyone can join a guild. They consist of a coordinator, active members, and
    passive members.
  * Coordinators don't "own" a guild--they coordinate the guild's activities.
  * Guilds can focus on anything from engineering disciplines (e.g. web
    frontends) to shared interests (e.g. making coffee)

* Pods

  https://blog.walkme.com/pod-structure-in-rnd-teams/

  * Pods are autonomous groups of people with complementary skills.
  * Pods are organized around a shared purpose. In the article, it was a
    product feature. The pod owned all the tasks for involved in their tasked
    feature.
  * Pods have minimal dependency on external groups--they have representatives
    for all the things they need in the pod.


How I thought about it
======================

Minimal system
--------------

I wanted to create a "working group system" that had enough structure to be
tangible.

I was also painfully aware that as a group, we have a lot of work to do and
couldn't spare a person to be managing this working group system full time. So
whatever system we ended up with needed to be either very light-weight
maintenance-wise or self-managing.

The system should provide enough infrastructure to make running a group
straight-forward.


Ability to evolve
-----------------

If we build the smallest possible thing and it's successful, it'll outgrow
what we build. It's important that it can evolve as needs arise.

The idea that this system evolves over time should be baked into the system.

This also allows us to push off a lot of decisions to future iterations.


Different kinds of groups
-------------------------

I wanted to support different kinds of groups:

* **Core working groups that have KRs they're responsible for**

  For example, "Revenue data working group" or "Firefox health working group".

* **Problem domain working groups**

  For example, platform infrastructure working group that owns platform
  infrastructure for Data Org.

* **Discipline working groups**

  For example, Staff Engineer working group where staff engineers can discuss
  career goals or Python Working Group for discussing Python things.

* **Topic working groups**

  For example, Coffee Working Group for discussing coffee making.


All of these have shared system needs and I think we can create a system that
covers them all.


Participation
-------------

I wanted to create a system that supported groups that included people from
wherever regardless of whether they were in Data Org or even a Mozilla
employee.


Support all stages of group lifecycle
-------------------------------------

I wanted to make sure our system supported all stages of group lifecycle:

* **Creating groups**

  Have a template for figuring out:

  * Why does this group exist and what does it cover?
  * What kind of group is this?
  * Who should be in this group?
  * What are the deliverables/artifacts (if any)?
  * How does it communicate?

  Have a set of conventions for mailing list/Slack channel/Matrix channel
  naming and links to instructions on how to create them.

  Have a process for how to go from an idea for a group to an actual group.

* **Running groups**

  Have "recipes" for running groups.

  * How to run a group that's primarily public. How to run a group that's
    primarly Mozilla-only.
  * How to run asynchronous groups that rely on mailing lists and other
    asynchronous methods.
  * How to run synchronous groups that have meeting cadences or Slack/Matrix
    channels.

* **Ending groups**

  We don't want to be saddled with groups that are dormant or have long
  outlived their usefulness. We need a light-weight way to figure out when a
  group has run its course and needs to be disbanded.


Conventions that lead to safe, respectful spaces
------------------------------------------------

We want people to be great. Unsafe, disrespectful spaces destroy that.

This system should codify conventions and practices that lead to safe and
respectful spaces by default.


NDA and security-sensitive materials
------------------------------------

Data Org often is under NDA for various things. Further, we manage data and
other security-sensitive things.

This system should codify conventions and practices that lead to reducing
mistakes around releasing NDA and security-sensitive material.


Findable
--------

Managers should know which working groups exist so they can help their team
join working groups that are useful.

People should be able to find working groups they're interested in joining or
are related to work they're doing.


Artifacts
---------

We're constantly losing historical knowledge--let's work to reduce that here.

This system should codify conventions and practices for capturing artifacts of
group decisions. How to use issue trackers, how to keep meeting notes, etc.


What we ended up with
=====================

I put together a proposal and shopped it around for a couple of months
incorporating feedback as I got it.

The end result is the `Data Org Working Group
<https://mana.mozilla.org/wiki/pages/viewpage.action?spaceKey=DATA&title=Data+Org+Working+Groups>`_
[1]_.

.. [1] This is a page in Mozilla's Mana which is for Mozilla employees only.

That Mana page covers:

1. how to define and create a working group
2. how to run groups
3. how to disband groups

It includes a bunch of prompts for things to think about when setting up a
group and what shape it should have. Is it predominantly synchronous (bad for
timezone diversity) or asynchronous (sometimes things take longer)? Is it
public (everyone can participate) or private (can handle NDA and
security-related material)? Does it have deliverables? Does it own KRs? Does it
have stakeholders? How are they notified and communicated with? Where do group
artifacts end up? What would cause this group to wind down?

It includes a small list of best practices for setting up and running groups.
Conventions for naming things, where we suggest keeping notes, etc.

It includes an index of existing groups with links to their respective Mana and
wiki.mozilla.org pages. This makes it possible to find groups you're looking
for.

It includes an owner for the working group system.

We have a few groups already that we could convert to Data Org Working Groups.


Next steps
==========

Creating working groups involves creating a proposal and shopping it around. I
plan to keep an eye on proposals and see what gaps in the system they
highlight.

I plan to revisit and do a Data Org Working Group v1.1 pass in March 2021. I'd
like to improve some of the conventions. For example, what if someone has
questions about working groups--where do they go to ask?

I think I also want to check in with groups every 3 months or something like
that so as to hone the Data Org Working Groups scaffolding and conventions and
also to help groups stay healthy. "How're things going? Are you hitting any
issues?"


Conclusion
==========

I talked to a few people about working groups, but I wish I had more input from
others. I should have set up 1:1s with certain people to discuss working
groups. It was the end of 2020 and everything was hard, but I wish I had found
the time/energy.

I put a lot of thought into some aspects that I decided to push off to a future
iteration of Data Org Working Groups. I don't think that thought was wasted,
but I'll feel happier when it gets integrated.

I like that it has the ability to evolve over time. I think that'll give it a
good chance of staying relevant, so that's cool.
