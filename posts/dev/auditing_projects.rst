.. title: How to pick up a project with an audit
.. slug: auditing_projects
.. date: 2020-01-07 14:00
.. tags: dev, python, mozilla, story

Over the last year, I was handed a bunch of services in various states. One of
the first things I do when being handed an existing service that I'm now
suddenly responsible for is to audit the service. That helps me figure out what
I'm looking at and what I need to do with it next.

This blog post covers my process for auditing services I'm suddenly the proud
owner of.


.. TEASER_END

History
=======

* January 7th, 2020: Initial writing.
* February 6th, 2020: Incorporated insightful comments from the inimitable
  ckolos.
* January 13th, 2022: Overhaul after two years.


A short note about service vs. non-service projects
===================================================

I originally wrote this post about "auditing projects", but that's not wildly
clear. I maintain software projects which are running as *services*. I also
maintain software projects that are libraries and tools and other things.  I
think the interesting dichotomy for the purposes of auditing is service
projects and non-service projects and the two groups of projects have different
auditing needs.

I did a pass through this post and added notes clarifying whether items applied
to only one of those groups. This makes it easier on me--it means I don't feel
compelled to write another post covering non-service projects.


What do I mean by "audit"?
==========================

When I was younger, I'd wander around a project and figure it out as I went
along. That takes a long time during which I don't really know what I'm doing,
I don't understand the full context of what I'm doing it in, I don't feel good
about it, and I'm learning too many things from reacting to nasty surprises
(outages, security bugs, etc). I don't enjoy that.

Now I take a methodical approach to picking up a project. I spend a week or so
working through a set of questions and writing everything up in a document. I
find this approach makes for a good survey of the project and the context it
exists in. It helps me to see what I don't understand, yet. It also surfaces
issues for my preliminary list of things to do.

The primary audience for the audit is me--I'm using this process as a way to
explore the project to acquire a general understanding of it. I'm a software
engineer so I'm focused on those aspects of a project.

For services, this is something like:

* why does this service exist and what are the goals?
* development and maintenance load
* security policies and processes
* project workflow
* data collection, access, usage, and retention policies and processes
* data flow
* uptime and reliability
* observability
* stakeholders and impact on them
* costs and budgets
* infrastructure, deploys, runbooks
* documentation, training, and support

For non-service projects, this is something like:

* why does this service exist and what are the goals?
* development and maintenance load
* security policies and processes
* project workflow
* stakeholders and impact on them
* documentation, training, and support

The next audience is my manager, co-workers, peers, co-maintainers and whoever
else I might pass this project on to or might be interested.

I use the word "audit" to cover that period of time just after I've been given
a project where I'm trying to figure out what it's all about until I feel like
I have a good grasp of the project.

The audit should answer questions in (roughly) these four categories:

1. What is it?
2. What are the project details?
3. How is it maintained?
4. What is the current status?

When doing an audit, I start a document and work through questions and answers.
For questions I don't know the answer to, I'll add a note to look into it later
and move on. Many answers bring up more questions--I put those in the document,
too. I keep iterating over the document until I've fleshed out enough of the
document that I feel like I have a good grasp of the project.

Let's walk through the parts.


Part 1: What is it?
-------------------

Mission

1. Why does this project exist?
2. What does this project do?
3. What is the context in which it exists?

Stakeholders

1. Who has worked on this project in the past?
2. Who is currently working on this project?
3. Who are the stake-holders?
4. (services) Who "owns" this service?
5. Who will cry out in anguish when the service goes down or the tool/library
   has a bug?
6. Are there other projects that depend on it? What are they?
7. Are there users or groups of users that this project is working towards?
8. Is there an active community around this project?

Community

1. Does this project have an active community?
2. Is there a code of conduct? Is the community healthy?
3. Where does this community hang out?

Impact

1. Does this project affect revenue?
2. Does this project have a budget? Is it within the budget?
3. Does this project have service-level agreements (SLA) or service-level
   objectives (SLO)? What are they?


Part 2: What are the project details?
-------------------------------------

Project details

1. What are the URLs to project documentation like the website, user
   documentation, tutorials, howtos, license, runbook, roadmap, etc?
2. What are the URLs to project management resources like the code repository,
   issue tracker, milestone tracker, and development planning?
3. What are the URLs to communication venues like IRC channels, Slack,
   Discourse, Telegram, mailing lists, Matrix, and other forums that the
   project uses?
4. (services) What are the URLs to monitoring resources like CI, metrics
   dashboard, site status, Pingdom, logs, and anything else for observing the
   health and status of the service?

Architecture

1. What are the major components, services, storage systems, queues, etc for
   the project?
2. What data does the project use and how does it flow through the system?
3. What languages, versions, and runtimes are used?
4. What infrastructure is used? How is it defined? Who is responsible?
5. Is there a system for authentication/authorization? How does it work? Who is
   responsible for the systems involved?


Part 3: How is it maintained?
-----------------------------

Code maintenance

1. What version control system is used?
2. Is there a primary repository? If so, where is it hosted?
3. What project workflow processes and tools exist?
4. Does the project practice continuous integration?

Quality assurance

1. What are the requirements for the project?

   * Uptime requirements?
   * Browser support matrix?
   * API compatibility requirements?
   * etc

2. What is the quality assurance story for the project and how does it ensure
   the requirements?
3. Where are the test suites? What do they test?
4. What's tested automatically? What's tested by hand? When are tests run?
5. Which linters are used? What do they lint? When is linting run?
6. What processes ensure dependencies are up-to-date?

Deployments/releases

1. How is the project deployed/released? Is the process written down?  Who
   needs to be involved to do it? How long does it generally take?
2. How often is the project deployed/released? When was the last
   deploy/release?
3. Does the project practice continuous deployment?

Observability (services)

1. What observability is implemented in the service? (Logs, structured logs,
   metrics, alerts, notifications, dashboards, tracing, error reports, etc.)
2. What/How is system health monitored?
3. How do you learn about problems/incidents?
4. How do you know what "normal operation" is?

Data policies (services)

1. Capture: What data is captured by the system? Where is data stored?
   (records, backups, logs, metrics, records, etc) Where is personal data is
   captured? (ip addresses, history, credit cards, identifiers, etc)
2. Access: Who has access to the data? How is access granted/revoked? Does
   access expire automatically or is it manually maintained? Are there records
   of access requests? 
3. Usage: What can people who have access to the data do with the data? Can it
   be combined with other data? Can it be exported to other systems? Can it be
   exported? Is it sent to other systems?
4. Retention: How long is data retained? Does it expire automatically?

Security

1. What processes watch for security issues in dependencies and dependencies of
   dependencies?
2. Is there a security policy for this project? Is it written down? Is the
   process working?


Part 4: What is the current status?
-----------------------------------

1. What periodic maintenance is required for the project? Is it written down
   somewhere? When was it last performed?
2. When was the last deployment/release? What has changed since then? Is the
   project deployable/releasable now?
3. Are dependencies up-to-date? Are any of the dependencies in use obsolete,
   abandoned, or deprecated?
4. Are there things that are important or required, but not covered by tests?
5. When was the last security review done on the project? What was the outcome?
   Are there any security issues in the project? Are there security issues with
   dependencies? Should it have another security review?
6. When was the last risk assessment done? Something that would cover risks
   from the data stored, the access required, etc.
7. Are there any in-progress projects? Technical debt cleanup? Migrations?
   What state are they in? What's the urgency? What's the next steps?
8. What urgent things need to be done on this project?


Outcomes
========

I work through the questions that are pertinent to the thing I'm auditing and
answers and often that surfaces other questions that need answers. I keep iterating
over that until I end up with two things:

1. An audit document.
   
   I can refer to this document when other people ask me questions.

   I can use this document to update and improve existing project documentation
   which might be unmaintained or missing important things.

   I can show this document to my manager, co-workers, co-maintainers, and
   other people so they're familiar with the project.

   I can use this document as an example of the quality of work I do for future
   promotions.

2. A prioritized list of things to do next.

   Some of the things will already be in an issue tracker. Some of the things
   will not be.

   I make sure the things I discover need to be done are all in the issue
   tracker and there's some rough idea of priority.

   I don't worry about capturing *all* the things that need to be done.

   Having a triaged list of issues enables me to know what to work on next.


Last thoughts
=============

In Summer of 2019, my co-worker and I managed to pick up 5 additional services
in various states of disrepair, audit them, and get them into a maintainable
state. We couldn't have done that without being methodical about picking up
projects.

I find this is helpful for joining existing projects that are actively
maintained as well.

If you find this helpful, let me know!
