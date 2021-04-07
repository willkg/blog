.. title: Input: 2015q2 quarter in review
.. slug: input_2015q2
.. date: 2015-07-13 16:00
.. tags: mozilla, work, input


2015q2 was a bit slower bug-count-wise than 2015q1, but we got some
important things accomplished.

Things to know:

* `Input <https://input.mozilla.org/>`_ is Mozilla's product feedback site.
* `Fjord <https://github.com/mozilla/fjord>`_ is the code that runs
  Input.
* We maintain project details and plans at
  `<https://wiki.mozilla.org/Firefox/Input>`_.
* I am Will Kahn-Greene and I'm the tech lead, architect, QA and
  primary developer on Input.

This is the quarter in review for Mozilla Input!

.. TEASER_END


Bugzilla and git stats
======================

::
   
    Quarter 2015q2 (2015-04-01 -> 2015-07-01)
    =========================================
    
    
    Bugzilla
    ========
    
    Bugs created: 56
    Creators: 4
    
             Will Kahn-Greene [:willkg] : 49
         Ricky Rosario [:rrosario, :r1c : 3
                   Chris Lonnen :lonnen : 2
                          L. Guruprasad : 2
    
    Bugs resolved: 40
    
                                WONTFIX : 1
                                  FIXED : 38
                                INVALID : 1
    
                             Tracebacks : 1
                               Research : 1
                                Tracker : 2
    
    Research bugs: 1
    
        1133774: [research] figure out how to track performance of new
            thank you page
    
    Tracker bugs: 2
    
        1107729: [tracker] 12-factor app compliance
        1161144: [tracker] suggest framework
    
    Resolvers: 4
    
             Will Kahn-Greene [:willkg] : 28
         Ricky Rosario [:rrosario, :r1c : 7
                          L. Guruprasad : 3
                                 willkg : 2
    
    Commenters: 9
    
                                 willkg : 249
                               rrosario : 19
                              lgp171188 : 6
                                 aokoye : 5
                                mgrimes : 3
                           chris.lonnen : 2
                                 mverdi : 2
                                    cww : 1
                                mcooper : 1
    
    git
    ===
    
    Total commits: 169
    
          Will Kahn-Greene :   144  (+10554, -8021, files 596)
             Ricky Rosario :    18  (+734, -434, files 53)
             L. Guruprasad :     7  (+546, -220, files 20)
    
    Total lines added: 11834
    Total lines deleted: 8675
    Total files changed: 669
    
    Everyone
    ========
    
        aokoye
        Chris Lonnen :lonnen
        cww
        L. Guruprasad
        mcooper
        mgrimes
        mverdi
        Ricky Rosario [:rrosario, :r1cky]
        Will Kahn-Greene [:willkg]


Code line counts::

    2014q1: April 1st, 2014:        15195 total  6953 Python
    2014q2: July 1st, 2014:         20456 total  9247 Python
    2014q3: October 7th. 2014:      23466 total  11614 Python
    2014q4: December 31st, 2014:    30158 total  13615 Python
    2015q1: April 1st, 2015:        28977 total  12623 Python
    2015q2: July 13th, 2015:        29549 total  13572 Python

Input didn't grow a lot this quarter. Plus the rest of the numbers are
lower than the previous quarter. This is in large part to us working
on several big projects that took a long time to work through and
didn't result in a lot of code. In the previous quarter, we worked
through a lot of littler bugs.


Contributor stats
=================

L Guruprasad redid the pre-commit linting infrastructure and added
support for editorconfig both of which are super helpful.

Ricky worked on the Django 1.8 upgrade, but we couldn't finish because
we got blocked on other people.


Accomplishments
===============

**Suggest framework**: We have a new suggestion framework that we'll
use for providing users leaving feedback with links that help them
with problems they're probably leaving feedback about, getting
additional help and other things. So far, we've only implemented
a SUMO Search suggester, but we have a trigger-keyword suggester
in the works for 2015q3 and ideas for others.

`Suggest framework <https://wiki.mozilla.org/Firefox/Input/Suggest>`_

**Thank you page suggestions**: We implemented the infrastructure for
a suggester system and also built the first suggester to use it.  This
suggesters looks at sad feedback for en-US locale for the Firefox
product and runs it through a SUMO search to see if there are relevant
KB articles. It then displays the top 3 scoring articles to the user
on the Thank You page.

`Thank you page overhaul: phase 1 <https://wiki.mozilla.org/Firefox/Input/Thank_you_page>`_

A lot of thinking went into this. I think it was a big success.

:doc:`Thank you page project writeup <input_thankyou_phase1>`

**Lots of upgrades and rewritings to make way for Django 1.8**: We're
still using Django 1.7, but there are only a few blocking items
before we can upgrade to Django 1.8.

Amongst other things, this work involved upgrading to django-rest-framework
3 which involved rewriting a lot of our API code, fixing our celery
infrastructure, ditching tower, upgrading django-browserid, fixing
django-waffle and a few other things.

**Switch to py.test**: We switched from nose to py.test this quarter.
This is nice because now we're using py.test for both our unit tests
and our smoketests. The tests take the same time to run--no
performance changes. The error output is a lot nicer and the
skip/xfail infrastructure is super.


Summary
=======

2015q2 seemed slower, but we got a lot of important things
accomplished. It was a good quarter.
