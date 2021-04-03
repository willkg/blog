.. title: Input: 2014q3 post-mortem
.. slug: input_2014q3
.. date: 2014-10-07 18:00
.. tags: mozilla, work, input


This is the 2014q3 Input post-mortem. It was a better quarter than
2014q2--that one kind of sucked.  Instead 2014q2 started out well and
then got kind of busy and then I was pretty overwhelmed by the end.

Things to know:

* `Input <https://input.mozilla.org/>`_ is Mozilla's product feedback site.
* `Fjord <https://github.com/mozilla/fjord>`_ is the code that runs
  Input.
* I unilaterally decided to extend 2014q3 to October 6th.
* I am Will Kahn-Greene and I'm the primary developer on Input.


Bug and git stats
=================

::

    Bugzilla
    ========

    Bugs created:        58
    Bugs fixed:          54

    git
    ===

    Total commits: 161

          Will Kahn-Greene :   150  (+195704, -188071, files 672)
             Ian Kronquist :     7  (+201, -53, files 11)
             L. Guruprasad :     3  (+8, -18, files 3)
           Ruben Vereecken :     1  (+34, -14, files 6)

    Total lines added: 195947
    Total lines deleted: 188156
    Total files changed: 692


We added a bunch of code this quarter:

* October 7th. 2014: 23466 total, 11614 Python

Compare to previous quarters:

* 2014q1: April 1st, 2014: 15195 total, 6953 Python
* 2014q2: July 1st, 2014: 20456 total, 9247 Python

Nothing wildly interesting there other than noting that the codebase
for Input continues to grow.


Contributor stats
=================

Ian Kronquist was the Input intern for Summer 2014. He contributed several
fixes to Input. Yay!

We spent a bunch of time making our docs and Vagrant provisioning
script less buggy so as to reduce the problems new contributors have
when working on Input. I talked with several people about things
they're interested in working on. Plus several people did some really
great work on Input.

Generally, I think Input is at a point where it's not too hard to get
up and running, we've got several lists of bugs that are good ones to
start with and the documentation is good-ish. I think the thing that's
hampering us right now is that I'm not spending enough time and energy
answering questions, managing the work and keeping things going.

Anyhow, welcome L. Guruprasad, Adam Okoye and Ruben Vereecken!
Additionally, many special thanks to L. Guruprasad who fixed a lot of
issues with the Vagrant provisioning scripts. That work is long and
tedious, but it helps everyone.


Accomplishments
===============

**Dashboards for everyone**: We wrote an API and some compelling
examples of dashboards you can build using the API. It's being used in
a few places now. We'll grow it going forward as needs arise. I'm
pretty psyched about this since it makes it possible for people with
needs to help themselves and not have to wait for me to get around to
their work. `Dashboards for everyone project plan
<https://wiki.mozilla.org/Firefox/Input/Dashboards_for_Everyone>`_.

**Vagrant**: We took the work I did last quarter and improved upon it,
rewrote the docs and have a decent Vagrant setup now.
`Reduce contributor pain project plan
<https://wiki.mozilla.org/Firefox/Input/Reduce_Contributor_Pain>`_.

**Abuse detection**: Ian spent his internship working on an abuse
classifier so that we can more proactively detect and prevent abusive
feedback from littering Input. We gathered some interesting data and
the next step is probably to change the approach we used and apply
some more complex ML things to the problem. The key here is that we
want to detect abuse with confidence and not accidentally catch swaths
of non-abuse. Input feedback has some peculiar properties that make
this difficult. `Reduce the abuse project plan
<https://wiki.mozilla.org/Firefox/Input/Reduce_the_Abuse>`_.

**Loop support**: Loop is now using Input for user sentiment feedback.

**Heartbeat support**: User Advocacy is working on a project to give
us a better baseline for user sentiment. This project was titled
Heartbeat, but I'm not sure whether that'll change or not. Regardless,
we added support for the initial prototype. `Heartbeat project plan
<https://wiki.mozilla.org/Firefox/Input/Heartbeat>`_.

**Data retention policy**: We've been talking about a data retention
policy for some time. We decided on one, finalized it and codified it
in code.

**Shed the last vestiges of Playdoh and funfactory**: We shed the last
bits of Playdoh and funfactory. Input uses the same protections and
security decisions those two projects enforced, but without being tied
to some of the infrastructure decisions. This made it easier to
switch to peep-based requirements management.

**Switched to FactoryBoy and overhauled tests**: Tests run pretty fast
in Fjord now. We switched to FactoryBoy, so writing model-based tests
is a lot easier than the stuff we had before.


Summary
=======

Better than 2014q2 and we fixed some more technical debt further making it
easier to develop for and maintain Input. Still, there's lots of work to do.

**Update April 21st, 2015**

LGuruprasad found a bug in the script that caused commits-by-author
information to be wrong. Fixed the script and updated the stats!
