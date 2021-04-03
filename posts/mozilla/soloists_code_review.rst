.. title: Soloists: code review on a solo project
.. slug: soloists_code_review
.. date: 2017-07-24 12:00
.. tags: mozilla, work, soloists, python


Summary
=======

I work on some projects with other people, but I also spend a lot of time
working on projects by myself. When I'm working by myself, I have difficulties
with the following:

1. code review
2. bouncing ideas off of people
3. peer programming
4. long slogs
5. getting help when I'm stuck
6. publicizing my work
7. dealing with loneliness
8. going on vacation

I started a ``#soloists`` group at Mozilla figuring there are a bunch of other
Mozillians who are working on solo projects and maybe if we all work alone
together, then that might alleviate some of the problems of working solo. We
hang out in the ``#soloists`` IRC channel on irc.mozilla.org. If you're solo,
join us!

I keep thinking about writing a set of blog posts for things we've talked about
in the channel and how I do things. Maybe they'll help you.

This one covers code review.


.. TEASER_END

Code review on a solo project
=============================

`Erik Rose's Constructive Code Review
<http://pyvideo.org/pycon-us-2017/constructive-code-review.html>`_ talk at PyCon
US 2017 is a fantastic talk covering why you should do code review and how to
effectively and constructively review code.

In the video, Erik talks about the three reasons you should be doing code
review:

1. Build an excellent product.
2. Build people.
3. Build yourself.

That's awesome! Who wouldn't want that?

But what do you do if you're solo? The whole basis of code review is that
*someone else* reviews the code, so what if there is no one else? Maybe you're
working on a solo project at work. Maybe you're starting a new open source
project that hasn't picked up contributors.

I think projects differ greatly in a variety of ways. For some projects, there
is no substitute for having someone else knowledgeable in the project review
your code. If you're solo on a project like that, you're pretty stuck without
help. For all the other projects, I think there are some things you can do to at
least get by and help build an excellent product.

I work mostly in Python, so what I do works in Python land for software
development projects. If you're not doing software development or not using
Python, then you might have to adjust accordingly.


How we're going to talk about code reviews
==========================================

Code reviews can/should look at many aspects of the code change. I'm going to
bucket these roughly into the following five categories:

1. **developer best practices**: tests, documentation, development artifacts
2. **programming language/library best practices**: APIs, thread-safety
   properties, data structures, design patterns
3. **project conventions**: code style, what stuff goes where
4. **project experience**: anything that requires experience with the project
   to know like past decisions, goals and non-goals, and project history
5. **unknown unknowns**: things you don't know


Before you do anything, get a linter
====================================

Linters and static analyzers are super.

I set up linters to cover as many things as I can that I care about. Here
are some of the ones I use:

* `flake8 <https://pypi.python.org/pypi/flake8>`_: Covers style and some other
  issues.

  flake8 supports plugins, too. There are `lots of really great ones on pypi
  <https://pypi.python.org/pypi?%3Aaction=search&term=flake8&submit=search>`_.
  Definitely worth looking through them and adding whatever helps you.

  Might be worth writing your own for stuff you want that doesn't exist.

* `bandit <https://pypi.python.org/pypi/bandit>`_: Security oriented analyzer.
  This is helpful to run. It generates a lot of false positives for me, but it
  picks up good stuff, too.

* `check-manifest <https://pypi.python.org/pypi/check-manifest>`_: Checks
  MANIFEST.in files.


Anything I can automatically check via a linter is one less thing I have to
think about [#]_.

Plus I usually have a shell script or a make rule or a tox environment or
something that runs all the linters in sequence which I can do before I create a
pull request.

Some linters integrate with code editors, so you can see issues as you type
them.

You can use linters with CI systems, so they can prevent problems from getting
merged.

.. [#] Unless the linter has a bug and then woo-hoo clown shoes!


How to find someone to review your code
=======================================

For developer best practices and programming language/library best practices,
here are some ways to find someone to review your code:

1. ask a mentor
2. ask people you have 1:1 meetings with [#]_; run code by them or try rubber
   ducking explanations because they might ask questions that surface issues and
   suggest better ways to do things
3. ask people working on similar projects, perhaps other projects at the same
   company you're at or other projects that use the same programming language
   and libraries; try trading reviews with someone in this group
4. ask for help from a community on the Internet like `Code Review
   <https://codereview.stackexchange.com/>`_
5. ask for help at a hackfest, user group, conference, or meetup group

Sometimes those sources can help with the unknowns, too.

If you're solo, then you're probably the only person with experience in your
project, so covering that aspect of code reviews is tough.

For open source projects, you could ask for help from someone who works on a
similar project. For example, if you're working on a PEG parsing library and you
go to a PyCon conference, find other people who've worked on parsers and ask to
trade reviews.

Keep in mind that if you're asking for help from people who don't normally help
you, it's best to keep your changes as small as possible. You won't make friends
by asking people to review 1,000+ line changes.

.. [#] I have 1:1s with people doing totally different things than I am because
       we learn a lot from each other and have vastly different perspectives on
       things. More on this in a different post.


How to approximate code review with a self-review
=================================================

Is self review a substitute for someone else reviewing your code? Definitely
not, but the premise here is that you're on a solo project and there isn't a
someone else. If you've exhausted the world's options, then you're just going to
have to get the best approximation you can get.


My development process leading up to code review
------------------------------------------------

Code review is just one step in the development process. I find code review
is easier and less risky if I follow these rules:

1. Research, think, and plan as much as possible before coding.

2. Talk to myself about what I'm doing. A lot.

3. Keep changes small.

   The larger a change is, the longer it takes to review and the higher risk
   of introducing bugs and failures.

   Sometimes I'll break up changes into a set of smaller atomic changes.
   Sometimes forcing myself to think about breaking big changes into small
   atomic changes makes it easier to do big changes.


My self-review flow
-------------------

I think those three things create a context in which it's easier to do
self-review.

For self-review, this is roughly what I do:

1. **I run all the linters and tests I have set up for the project.**

   This covers project conventions and makes sure everything is good as far as
   computers can tell. Forcing computers to do work means I do less.

2. **I go take a walk and do something somewhere else for 15 minutes.**

   This is a good time to get a glass of water [#]_. I work at home, so
   sometimes I'll spend some time decluttering or cleaning.

3. **I look at the changes in different ways using different tools.**

   When I come back, I try to look at the code changes in a bunch of different
   ways and see if it looks ok.

   I do::

      git diff master..HEAD

   or something equivalent in the terminal and read through my changes
   carefully. git has a variety of different diffing and ways to view. For
   example::

      git diff --histogram master..HEAD
      git diff --minimal master..HEAD
      git diff --patience master..HEAD
      git diff --word-diff=color master..HEAD

   Definitely worth reading through ``git diff --help`` to see what would help
   you.

   I may also look at each individual commit and the commit comments and
   summary.

   I may look at the original code in full (checkout the master branch) and then
   look at the changed code in full (checkout the branch tip).

   Looking at the changes using different tools and views helps force my brain
   to be more careful reading because it looks totally different. Different
   tools use different diffing algorithms, have different fonts and color
   schemes, and show different amounts of context.

   This sort of covers developer best practices, programming language/library
   best practices, and things that require someone who's been working on the
   project for a while.

4. **Fourth, I push my branch and create a pull request on GitHub.**

   The CI system I use (`Circle CI <https://circleci.com/>`_ or `Travis CI
   <https://travisci.com/>`_ depending on the project) happily runs all my tests
   and linters.

   If there are CI failures, I'll fix them.

5. **I leave it for a day.**

   I'll do other things and ignore the PR until the following day. A night of
   sleep between creating the PR and reviewing it gives me time to mull over
   things and helps me forget bits.

   Sometimes I get side-tracked on something else--I usually have multiple
   projects I'm working on, so I'll switch between them.

6. **I review my pull request.**

   I go through the pull request carefully and answer questions like the
   following: questions:

   1. How can this code fail? What have I done to prevent those failures? What
      have I done to surface those failures so I know if they're happening?

   2. What happens if this code is wrong? Will it cause data loss? Will it break
      the service-level agreement I have with my users? Can this change be
      backed out quickly if it's bad?

   3. Are these changes appropriately covered by the tests? Do the tests make
      sense?

      If I'm using mocks in my tests, have I verified that the mocks are
      correct?

   4. Do the changes match the documentation and surrounding comments?

   I take my time reviewing my pull requests. I don't rush it. If I'm tired, I
   take a break.

   I write comments to my PRs especially to explain design decisions that I
   think might look odd. Future me and any other developers that join this
   project will benefit greatly from me explaining why I did what I did. Also,
   this is sort of like rubber-ducking and I sometimes discover things I should
   change because they're either hard to explain or it becomes clear it's
   missing edge cases.

   This sort of covers developer best practices, programming language/library
   best practices, and things that require someone who's been working on the
   project for a while, too.

7. **I land the change!**

   After all that, I'll land the change. If there are issues, I'll fail forward
   and fix them if I can. If I can't do that, I'll back it out. I don't think
   I've ever backed anything out, though.


That's pretty much it.

Periodically, I revisit code a couple of weeks or a month later and see if it
still looks ok. Sometimes code doesn't evolve well over time and is worth
refactoring.

.. [#] It's good to drink water.


Do I do all these steps every time?
-----------------------------------

No. I try to balance the urgency of the change to land with the risks of failure
with the consequences of failure and base how much time I should spend reviewing
on that.

For example, if I'm fixing documentation, I won't spend a lot of time reviewing
it. If I'm fixing a critical method in a piece of code that needs to be
thread-safe and never fail, then I'll take a couple of days and be more
meticulous.


Warning: Self-review doesn't help you build people or build yourself!
---------------------------------------------------------------------

In a self-review, you're both the developer and the reviewer. That bites you
in both directions.

When you review other peoples' code, you share your experience and knowledge
with them and help them grow as a developer and grow as a contributor on your
project. If you're self-reviewing, you're not growing anyone.

When someone else reviews your code, they share their experience and knowledge
with you and cover the things that are unknown to you. Thus code review is a
unique opportunity to learn from others and grow as a developer. If you're
self-reviewing, you're not growing yourself.

If you're self-reviewing, you need to work harder to alleviate these missed
opportunities.


Many thanks
===========

Many thanks to the ``#soloists`` who I've bandied about some of these thoughts
with over the last year and those who read this and provided feedback. Many
many thanks to Erik who studiously reviewed earlier drafts and pointed out
many issues.


What do you do?
===============

Ever worked on a solo project? What do you do to alleviate the problems of not
having someone else to review code?

Let me know and I'll update this with your thoughts.
