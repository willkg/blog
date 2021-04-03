.. title: Input: 2015q1 quarter in review
.. slug: input_2015q1
.. date: 2015-04-14 16:00
.. tags: mozilla, work, input


We got a lot of stuff done in 2015q1--it was a busy quarter. 

Things to know:

* `Input <https://input.mozilla.org/>`_ is Mozilla's product feedback site.
* `Fjord <https://github.com/mozilla/fjord>`_ is the code that runs
  Input.
* We maintain project details and plans at
  `<https://wiki.mozilla.org/Firefox/Input>`_.
* I am Will Kahn-Greene and I'm the tech lead, architect, QA and
  primary developer on Input.

This is the quarter in review!

.. TEASER_END
   
  
Bugzilla and git stats
======================

::

    Quarter 2015q1 (2015-01-01 -> 2015-03-31)
    =========================================
    
    
    Bugzilla
    ========
    
    Bugs created: 73
    Creators: 7
    
             Will Kahn-Greene [:willkg] : 67
         Gregg Lind (User Advocacy - He : 1
                      Shashishekhar H M : 1
                  Matt Grimes [:Matt_G] : 1
               Mark Banner (:standard8) : 1
                             deshrajdry : 1
                          L. Guruprasad : 1
    
    Bugs resolved: 97
    
                                WONTFIX : 13
                                  FIXED : 82
                              DUPLICATE : 1
                             INCOMPLETE : 1
    
                             Tracebacks : 4
                               Research : 2
                                Tracker : 6
    
    Research bugs: 2
    
        1124412: [research] evaluate SUMO search APIs for best results
            given a piece of feedback
    
    Tracker bugs: 6
    
        907871: [tracker] add analytics infrastructure and reports to
            Input
        967037: [tracker] add classifier page to Firefox OS feedback form
        968230: [tracker] capture carrier in Firefox OS form
        1092280: [tracker] heartbeat v2 (Input-specific changes)
        1104932: [tracker] about:support support tracker
        1130599: [tracker] Alerts phase 1
    
    Resolvers: 6
    
             Will Kahn-Greene [:willkg] : 65
                          L. Guruprasad : 16
         Ricky Rosario [:rrosario, :r1c : 7
                                 aokoye : 5
                                mgrimes : 2
                             deshrajdry : 2
    
    Commenters: 22
    
                                 willkg : 579
                               rrosario : 25
                             deshrajdry : 10
                                mcooper : 10
                              lgp171188 : 10
                                mgrimes : 9
                                    cww : 8
                                  glind : 8
                             adnan.ayon : 6
                                 aokoye : 4
                                   robb : 4
                                brnet00 : 3
                              mozaakash : 2
                            John99-bugs : 2
                               chofmann : 2
                                bwalker : 1
                                  laura : 1
                              standard8 : 1
                        shashishekharhm : 1
                              christian : 1
                                fwenzel : 1
                              dlucian93 : 1
    
    git
    ===
    
    Total commits: 276

          Will Kahn-Greene :   224  (+11000, -9452, files 743)
             Ricky Rosario :    22  (+875, -5382, files 159)
             L. Guruprasad :    20  (+459, -202, files 119)
                Adam Okoye :     3  (+105, -6, files 6)
                   deshraj :     3  (+30, -17, files 5)
             ricky rosario :     2  (+150, -46, files 21)
             Michael Kelly :     1  (+1, -1, files 2)
          Adrian Gaudebert :     1  (+10, -3, files 2)

    Total lines added: 12630
    Total lines deleted: 15109
    Total files changed: 1057
    
    Everyone
    ========
    
        Adam Okoye
        adnan.ayon
        Adrian Gaudebert
        brnet00
        bwalker
        chofmann
        christian
        cww
        deshrajdry
        dlucian93
        fwenzel
        Gregg Lind (User Advocacy - Heartbeat - Test Pilot)
        John99-bugs
        L. Guruprasad
        laura
        Mark Banner (:standard8)
        Matt Grimes [:Matt_G]
        mcooper
        Michael Kelly
        mozaakash
        Ricky Rosario
        robb
        Shashishekhar H M
        standard8
        Will Kahn-Greene
    
   
Code line counts::

    2014q1: April 1st, 2014:        15195 total  6953 Python
    2014q2: July 1st, 2014:         20456 total  9247 Python
    2014q3: October 7th. 2014:      23466 total  11614 Python
    2014q4: December 31st, 2014:    30158 total  13615 Python
    2015q1: April 1st, 2015:        28977 total  12623 Python


Input finally shrunk, though this is probably due to switching from
the South migration system to the Django 1.7 migration system and in
the process of doing that ditching most of our old migration code.


Contributor stats
=================

L Guruprasad worked through 16 bugs this quarter--that's awesome!

Adam worked on the Thank You page overhaul. It's not quite done, but
it's in a good place--I'll be finishing up that work in 2015q2.

Ricky finished up the Django 1.7 update just in time for Django 1.8 to
be released. In doing that work, we cleaned up a lot of code, shed a
bunch of dependencies and are in a much better place in regards to
technical debt. Yay!

Thank you to everyone who contributed!


Accomplishments
===============

**Django 1.7 upgrade**: We upgraded to Django 1.7. That's a big deal
since Django 1.8 was just released so Django 1.6 isn't supported
anymore.  Django 1.7 has a new migration system, so there was a lot of
work required to upgrade Input.

**Heartbeat v2**: We did most of Heartbeat v2 in 2014q4, however it
didn't really launch until 2015q1. We did a bunch of work to tweak
things for the release.

**Alerts v1**: We added an Alerts API. Input collects a variety of
feedback-type data. After several discussions, we decided that it was
a better idea to have alert systems live outside of Input, but push
alert events to Input. This allows us to develope alert emitting
systems faster because they're outside of the Input development
process. Further, it relaxes implementation details. The Alerts API
has GET and POST abilities and lets us capture and report on arbitrary
alert events.

`Alerts API <https://wiki.mozilla.org/Firefox/Input/Alerts>`_.

**Remote troubleshooting data capture**: We finished this work in
2015q1. It's now rolled out for specific products and in all locales.

`Remote troubleshooting data capture project plan 
<https://wiki.mozilla.org/Firefox/Input/Support_aboutsupport>`_.

**12 Factor App**: At some point, we're going to move Input to AWS.
In the process of doing that, we're going to change how Input is
configured and deployed and switch to a 12-factor-app-friendly model.
I spent a good portion this quarter cleaning things up and redoing
configuration so it's more 12-factor-app-compliant.

There's still some work to do, but it'll be easier to do as we're in
the process of switching to AWS and know more about how the
infrastructure is going to be structured.

`12 Factor App
<https://wiki.mozilla.org/Firefox/Input/12_Factor_App>`_.

**Snow removal**: I live next town over from Lowell, MA, USA. We got
118 inches of snow this winter the bulk of which came in a 6-week
period where it pretty much snowed every three days. It was
exhausting.

I did a lot of shoveling, but never really solved the
problem. However, it did subside after a while and now it's gone.

`Snow removal <https://wiki.mozilla.org/Firefox/Input/Snow_removal>`_.


Summary
=======

2015q1 went by really fast and we got a lot of stuff done and we
worked through a lot of technical debt, too. It was a good quarter.

**Update April 21st, 2015**

LGuruprasad found a bug in the script that caused commits-by-author
information to be wrong. Fixed the script and updated the stats!
