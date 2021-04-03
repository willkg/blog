.. title: How to pick up a project with an audit
.. slug: auditing_projects
.. date: 2020-01-07 14:00
.. tags: dev, python, mozilla, story

Over the last year, I was handed a bunch of projects in various states.  One of
the first things I do when getting a new project that I'm suddenly responsible
for is to audit the project. That helps me figure out what I'm looking at and
what I need to do with it next.

This blog post covers my process for auditing projects I'm suddenly the proud
owner of.


.. TEASER_END

History
=======

* January 7th, 2020: Initial writing.
* February 6th, 2020: Incorporated insightful comments from the inimitable
  ckolos.


What do I mean by "audit"?
==========================

When I was younger, I'd wander around a project and figure it out as I went
along. That takes a long time during which I don't really know what I'm
doing, I don't feel good about it, and I'm learning too many things from
dealing with nasty surprises. I neither enjoy that nor does it make me look
good.

These days, I take a methodical approach to picking up a project. I spend a
week or so working through a set of questions. I find this approach makes for a
good survey of the project and the problem domain it exists in. Further, it
surfaces the grime that I should clean up thus avoiding nasty surprises.

The primary audience for the audit is me--I'm using the process as a way to
come up to speed on something. I'm a software engineer so I'm focused on
software development and maintenance aspects of the project. I'm concerned
about security and data policies, uptime and reliability, impact on
stake-holders, costs, budgets, infrastructure complexity, and ongoing
maintenance work.

The next audience is my manager and co-workers and whoever else I might pass
this project on to or might be interested.

I use the word "audit" to cover that period of time just after I've been given
a project where I'm trying to figure out what it's all about. I want to know
what the project is all about, what state is it in, how do I maintain it, 
who else is involved, and what do I need to change to make it maintainable.

I break it up into four parts:

1. What is it?
2. What are the project details?
3. How is it maintained?
4. What is the current status?

I start a document and work through questions and answers. For questions I
don't know the answer to, I'll add a note to look into it later and move on. I
keep iterating over the document until I've fleshed it out enough that I feel
like I have a good grasp of the project.

Let's walk through the parts.


Part 1: What is it?
-------------------

Mission

1. Why does this project exist?
2. What does this project do?
3. What is the context in which it exists?

Stake-holders

1. Who has worked on this project in the past?
2. Who is currently working on this project?
3. Who are the stake-holders? Who "owns" the service/application?
4. Who will cry out in anguish when the service/application goes down?
5. Are there other projects that depend on it? What are they?
6. Are there possible future users that this project is working towards?
7. Is there an active community around this project?

Impact

1. Does this project affect revenue?
2. Does this project have a budget? Is it within the budget?
3. Does this service/application have a service-level agreement? What is it?


Part 2: What are the project details?
-------------------------------------

Project details

1. What are the URLs to project website, documentation, license, runbook, and
   wiki?
2. What are the URLs to project repository, issue tracker, road-map, and
   development planning?
3. What are the URLs to IRC channels, Slack, Discourse, Telegram, mailing
   lists, Matrix, and other forums that the project uses?
4. What are the URLs to CI, metrics dashboard, site status, Pingdom, logs, and
   anything else for observing the health and status of the project?

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
2. What version control processes are used?
3. Is there a master repository? If so, where is it hosted?

Quality assurance

1. What are the requirements for the project?

   * Uptime requirements?
   * Browser support matrix?
   * API compatibility requirements?
   * Et cetera

2. What is the quality assurance story for the project and how does it ensure
   the requirements?
3. Where are the test suites? What do they test?
4. When are tests run? What's tested in CI? What's tested by hand?
5. Which linters are used? What do they lint? When is linting run?
6. What processes ensure dependencies are up-to-date?
7. What processes watch for security issues in dependencies?

Deployments/releases

1. How is the project deployed/released? Is it written down somewhere? Who
   needs to be involved to do it?
2. How often is it deployed/released?

Observability

1. What gets logged?
2. What is being measured to determine whether requirements are met?
3. What is being measured to determine health of the system?
4. Where are unhandled errors captured? What monitors them?

Data policy

1. How long are logs kept for? Who has access to the logs? Are logs archived
   somewhere? How long is that kept for?
2. How long are metrics kept for? Who has access to metrics? Are metrics
   archived somewhere? How long is that kept for?
3. What personally identifiable information is captured by the project? Where
   is it stored? How long is it stored for?


Part 4: What is the current status?
-----------------------------------

1. What periodic maintenance is required for the project? When was it last
   performed?
2. When was the last deployment/release? What has changed since then?  Is the
   project deployable/releasable now?
3. Are dependencies up-to-date? Are any of the dependencies in use obsolete,
   abandoned, or deprecated?
4. Are there things that are important or required, but not covered by tests?
5. When was the last security review done on the project? What was the outcome?
   Are there any security issues currently? Should it have another security
   review?
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
   
   I can use this to do my work as I become more familiar with the project. I
   can show this to my manager and coworkers so they're familiar with the
   project.  I use this to improve the runbook, FAQ, README, and other project
   documentation.

2. A prioritized list of things to do next.

   Some of the things will already be in an issue tracker. Some of the things
   will not be. I write up issues for all the things that should get done. I
   prioritize them and hit the ground running.


Last thoughts
=============

I have one co-worker. In Summer of 2019, we managed to pick up 5 additional
projects in various condition, audit them, and get them into a maintainable
state. We couldn't have done that without being methodical about picking up
projects.

If you find this helpful, let me know!
