.. title: Project audit experiences
.. slug: auditing_experiences
.. date: 2022-01-16 18:00:00
.. tags: dev, python, mozilla, story, tecken, buildhub, pollbot, mls

Back in January 2020, I wrote :doc:`auditing_projects`. I received some
comments about it over the last couple of years, but I don't think I really did
anything with them. Then Sumana sent an email asking whether I'd blogged about
my experiences auditing projects and estimating how long it takes and things
like that.

That got me to re-reading the original blog post and it was clear it needed an
update, so I did that. One thing I focused on was differentiating between
"service" and "non-service" projects. The post feels better now.

But that's not this post! This post is about my experiences with auditing. What
happened in that Summer of 2019 which formed the basis of that blog post? What
were those 5 [1]_ fabled projects? How did those audits go? Where are those
projects now?

.. [1] It ended up being 6 projects. I think I didn't originally count Mozilla
   Location Services for some reason.


.. TEASER_END

When is an audit "done"?
========================

For most of the projects I'll talk about in this post, the purpose of the audit
was to:

1. determine if there were things in the project that needed to be dealt with
   urgently: security vulnerabilities, legal issues, outages, etc
2. wrap my head around a service, it's context, the parts, the people
3. figure out what needed to be down right now
4. figure out the short-term plan for the project

When I hit "good enough" for those things, it didn't make sense to keep working
on the audit, so I wrapped up the document and moved on.

If the purpose of my audit was to end up with a document or other set of
artifacts that I was going to present on or give to a manager for business
decisions, I would have spent more time to finish them.

Even though the audits were never *finished*, I continue to refer to these
audit documents long after moving on from them.

.. Note::

   One thing to think about is how your audits play in your career development
   and prospects. Is this an artifact you'd want to put in your portfolio for
   promotion? Is this an artifact you want to use in an argument to switch
   teams or switch projects? Is this an artifact/experience you want to use to
   get a new job?

   Project artifacts can serve these purposes.


How long does it take to do an audit?
=====================================

I spend as much time on an audit as I'm getting value out of the work. Before I
start an audit, I want to figure out what I need to get out of it. Then I work
on fleshing things out until I've gotten what I need.

In college, I was a studio art major for a time and spent a lot of time
sketching and doing underpaintings. Both of these processes start out with a
blank canvas and help to flesh out layout, composition, structure, tones,
lighting, and color. Sometimes the sketch/underpainting evolves into a final
piece. Sometimes it doesn't.

During the Summer of 2019, I was auditing projects much like a
sketch/underpainting--iterating over different aspects of the canvas and
filling in bits until it was time to move on. Sketches can be very meaningful.

I think it takes me a week or so to audit a small-to-medium sized project
enough to figure out what it is, where it's at, and what needs work. Doing a
complete audit where I've answered all the questions that need answering might
take a month or two.

I don't know how long it'd take to audit a large project (100K+ LOC?). Is the
size to time-to-audit linear? Probably not.

I don't know what it's like to audit a project that doesn't share much with
things I'm familiar with (paradigms, architectures, languages, frameworks,
etc). Can I effectively audit a project in a language I'm not familiar with?
Does it take twice as long? Three times a long?

I don't know what it's like to audit a project that's not open source. Open
source projects tend to have artifacts and project resources with a certain
shape and in a few typical places. If I was working at a company that wasn't
open source, it might be harder to track down the pieces for a project,
stakeholders, who's using it, etc. How much harder could it be? Ten times as
hard? Maybe it depends on the company size and number of projects it has?

Lots of grains of salt here. Your experiences will be different.


Audits of Summer of 2019
========================

I had been working on Socorro, Mozilla's crash ingestion pipeline, alone for a
while and was eager to pick up a team member. In order to pick up a team
member, my boss did a three-way trade where I got a team member and also 5
additional projects that needed triaging and a home.

Then a month or two later, my new co-worker and I had to put all the projects
we were maintaining down and switch to Mozilla Location Services full time, so
we audited that project, too.

That's 6 projects in the span of a few months. Here's what I remember of that
experience.


Buildhub and Buildhub2
----------------------

**Buildhub**

:repository: https://github.com/mozilla-services/buildhub
:CLOC: 9,914 LOC (Python, JavaScript)
:audit time: about a week
:outcome: deprecated and decommissioned

**Buildhub2**

:repository: https://github.com/mozilla-releng/buildhub2
:CLOC: 4,031 LOC (Python, JavaScript)
:audit time: about 2 weeks
:outcome: addressed immediate issues, handled migration from Buildhub, cleaned up, handed it off

Buildhub was written a while back to index, store, and make searchable Mozilla
product build information (build ids, dates, versions, SHAs, etc). I was
cursorily involved because I was a stakeholder and had a similar system that I
wanted Buildhub to replace.

Buildhub2 was a rewrite of Buildhub to address some of Buildhub's fundamental
issues. One of the problems is that Buildhub spent a lot of time and energy
inferring build information from incomplete records. Buildhub2 took a different
tact.

When these two projects were handed over to me, I already knew what it did,
why, and who the stakeholders were. I didn't know the specifics of how they
worked, project health, security issues, maintenance burden, why there were two
of them, etc. I was pretty sure one of the things I would end up doing was
migrating to one and decommissioning the other.

I spent a week auditing Buildhub and Buildhub2 to understand where they were
at. Auditing involved:

* tracking down project resources (documentation, repository, issue tracker, etc)
* skimming open issues and pull requests in the issue tracker
* talking to the people who wrote and maintained the project to find out what
  tasks needed doing
* reading through project plan documents
* determine the stakeholders and current users of each system

As part of auditing, I wrapped my head around a half-completed migration
project from Buildhub to Buildhub2. The two systems had different problems and
things they were good at. Neither had a complete record of build information.

From my audit, I determined that Buildhub2 had "better bones" and it was more
likely I could fix the problems blocking a migration to Buildhub2 than I could
fix the fundamental problems Buildhub had. I decided we should decommission
Buildhub and move forward with Buildhub2. I wrote up a project plan for that
and circulated it.

Once that happened, I still needed to know stakeholders and users of Buildhub
so I could plan the migration, but otherwise there wasn't any point in
continuing to audit Buildhub so I stopped.

I continued auditing Buildhub2, but in a more passive capacity by writing out
answers to questions I had in the document as I bumped into them while working
on migrating and decommissioning Buildhub.

I fixed the outstanding issues with Buildhub2, I fixed the data problems, we
decommissioned Buildhub, and I fleshed out runbooks, documentation, architecture
overview, and other operational things for Buildhub2.

At some point later, I handed Buildhub2 off to its new owner. I'm pretty sure
the audit document and the work I did to flesh out operational documentation
helped them get settled quickly.


PollBot and Delivery Dashboard
------------------------------

**PollBot**

:repository: https://github.com/mozilla/PollBot
:CLOC: 3,884 (Python)
:audit time: about 2 days
:outcome: addressed immediate issues, handed it off

**Delivery Dashboard**

:repository: https://github.com/mozilla/delivery-dashboard
:CLOC: 8,332 (JavaScript)
:audit time: about 2 days
:outcome: addressed immediate issues, handed it off

PollBot is the backend/API for the DeliveryDashboard. The DeliveryDashboard
lets you see the status of and verify correctness artifacts, build steps, data
in specific places, and other things like that for Firefox releases.

We collected some links and checked the security vulnerability status of
PollBot. There was some talk of decommissioning both of these projects, so I
started tracking down stakeholders and figuring out whether that was possible
or not.

However, we didn't get very far with either of these projects--maybe 10%. We
got about as far as "what is this?" and "is it currently on fire?"

In my notes, I say we handed it off to someone, but I don't remember who or
how. I think Release Engineering owns it now.


Tecken
------

**Tecken**

:repo: https://github.com/mozilla-services/tecken
:cloc: 20,779 LOC (Python, JS)
:audit time: about 1 month
:outcome: addressed immediate issues, cleaned up, I continue to own it

Tecken is the Mozilla Symbols Server. When Mozilla does builds of Firefox and
other products, there's a build step to extract debugging symbols and upload
them to the Mozilla Symbols Server. Tools like stackwalkers, debuggers, and
profilers, download debugging symbols files from the symbols server. It's a
critical part of our engineering infrastructure.

I spent about a month auditing Tecken. I was doing other work as well, so I
didn't spend the month *solely* auditing Tecken. At the time, I thought I had
gotten 80% of the audit done. I've been maintaining this service for a couple
of years now and in retrospect I probably only finished 60% of the audit. I
learned a lot after I had decided I was done auditing.

I was involved in improving the Snappy Symbolication Server from a service that
ran on a computer under someone's desk to a cloud service. That was incredibly
difficult. Then it was decided to centralize all the symbols-related things
into a single service. Thus was born Tecken. A system I maintained was one of
the stakeholders. Because of that, I was vaguely familiar with the project.

When I got Tecken, it ran fine, but I don't think it had fully gotten over the
"prototype to production" hump.

The project was gearing up for an AWS to GCP migration, so part of the audit
covered figuring out where that project was at and next steps.

The audit identified a series of things that needed to get fixed. Some of them
were bugs, some were project organization/workflow issues, and some caused
undue maintenance burden.

Because the crash ingestion pipeline that I maintained relied on Tecken, I
ended up keeping this project rather than handing it off to someone else. I
revisit the audit periodically for historical research.


Mozilla Location Services
-------------------------

**Mozilla Location Services**

:repository: https://github.com/mozilla/ichnaea/
:CLOC: 75,216 (Python, JavaScript)
:audit time: about a month
:outcome: addressed immediate issues, owned for 9 months-ish, left it with
          co-worker in a re-org

My co-worker and I picked up Mozilla Location Services (aka MLS). I had no idea
what it was or how it worked. It had been in "maintenance-mode" and effectively
unowned for a long while.

MLS probably took a month to get through 80% of my audit questions. We had
several things we needed to do that were pretty urgent, so we prioritized parts
of the audit first that would make tasks easier.

MLS was medium-sized and shaped very differently from any of the projects I had
worked on so far.

.. Note::

   It's easier for me to audit things that are like things I've seen before and
   harder to audit things that are built in ways I have no experience with and
   feel foreign.


MLS felt foreign, but at its heart it was a data ingestion pipeline, a set of
APIs, and a webapp.

We audited MLS, worked on the urgent tasks, converted the local dev environment
to Docker, upgraded the project to Python 3, redid its infrastructure and
deploy pipeline, overhauled the documentation, and fixed a bunch of data
processing issues.

I stayed on MLS until April 2020 but then slowly shifted back to Socorro and
Tecken and then in August 2020, Socorro, Tecken, and I got moved to the Data
Org at Mozilla and I didn't touch MLS much after that.


Conclusion
==========

I wonder if there's value in doing an audit on a project I've been working for
a while. Does auditing help bring the project "back in line" with current
standards and expectations? I do periodic audits to cover quality assurance.
Maybe it would be interesting to audit one aspect of a project periodically.

I haven't spent much time to see what other work there is out there that covers
something similar to what I've outlined. I wonder who else is thinking about
this.

I have another blog post I keep meaning to write about the process of putting a
project into a low-maintenance mode, what low-maintenance mode entails, and the
process of taking it out of low-maintenance mode into more active development.
It might be helpful to do an audit when taking a project out of low-maintenance
mode. It might also be helpful to do an audit when converting a service from a
prototype to a production system. I wonder what other points in a service's
life cycle audits help.
