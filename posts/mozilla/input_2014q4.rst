.. title: Input: 2014q4 quarter in review
.. slug: input_2014q4
.. date: 2014-12-31 12:00
.. tags: mozilla, work, input


What is it?
===========

The purpose of `Input <https://input.mozilla.org/>`_ is to collect
actionable feedback from our user base across each channel of our
software development process. The application collects feedback and
offers a set of analysis methods for looking at the resulting data. 

`Project site <https://wiki.mozilla.org/Firefox/Input>`_.

This is my 2014q4 retrospective on Input.

.. TEASER_END

2014q4 was interesting. Between the faux all-hands, holidays and production
freezes, it was essentially a two-month quarter. I literally raced through
the quarter getting things done as quickly as I could do them opting
for the minimal viable implementation wherever possible. That's not a great
thing, but so it goes.

Things to know:

* `Input <https://input.mozilla.org/>`_ is Mozilla's product feedback site.
* `Fjord <https://github.com/mozilla/fjord>`_ is the code that runs
  Input.
* We maintain project details and plans at
  `<https://wiki.mozilla.org/Firefox/Input>`_.
* I am Will Kahn-Greene and I'm the tech lead, architect, QA and
  primary developer on Input.


Bugzilla and git stats
======================

I rewrote my script and the data is richer now.

::

    Quarter 2014q4 (2014-10-01 -> 2014-12-31)
    =========================================


    Bugzilla
    ========

    Bugs created: 95
    Creators:

             Will Kahn-Greene [:willkg] : 85
                                     me : 1
         Nicolas Perriault (:NiKo`) — n : 1
                    David Weir (satdav) : 1
                           Mark Filipak : 1
                               vivek :) : 1
                   Laura Thomson :laura : 1
          Swarnava Sengupta (:Swarnava) : 1
                                 [:Cww] : 1
                             deshrajdry : 1
                  phaneendra.chiruvella : 1

    Bugs resolved: 89

                                WONTFIX : 13
                             WORKSFORME : 4
                              DUPLICATE : 5
                                  FIXED : 67

                             Tracebacks : 1
                               Research : 4
                                Tracker : 7

    Research bugs: 4

        788597: [research] Should we use a stacked graph on the dashboard?
        792976: [research] swap jingo-minify for django-compressor and
            django-jingo-offline-compressor
        889370: [research] morelikethis for feedback responses
        1048459: [research] check if updating from a tarball in a virtual
            environment with peep removes files

    Tracker bugs: 7

        964260: [tracker] overhaul mobile and desktop feedback forms
        985645: [tracker] Upgrade to Django 1.6
        988612: [tracker] product dashboards
        1040773: [tracker] dashboards for everyone
        1042669: [tracker] reduce contributor pain
        1052459: [tracker] heartbeat v1
        1081412: [tracker] add tests for fjord_utils.js functions

    Resolvers: 7

             Will Kahn-Greene [:willkg] : 75
                                 aokoye : 7
                              lgp171188 : 4
                                    cww : 1
                        bhargav.kowshik : 1
          Rehan Dalal [:rehan, :rdalal] : 1

    Commenters: 27

                                 willkg : 420
                                 aokoye : 7
                                mcooper : 6
                                padraic : 6
                    MarkFilipak.mozilla : 5
                                  hwine : 4
                                 rdalal : 4
                         stephen.donner : 4
                              nigelbabu : 3
                             deshrajdry : 3
                        bhargav.kowshik : 3
                             david.weir : 2
                                mgrimes : 2
                           dron.rathore : 1
                             lorenzo567 : 1
                                senicar : 1
                         viveknjadhav19 : 1
                             nperriault : 1
                                    cww : 1
                       swarnavasengupta : 1
                              mozaakash : 1
                            me+bugzilla : 1
                  phaneendra.chiruvella : 1
                                     me : 1
                                 fbraun : 1
                    vivekb.balakrishnan : 1
                               rrosario : 1

    git
    ===

    Total commits: 241

          Will Kahn-Greene :   210  (+28586, -11298, files 866)
                Adam Okoye :    15  (+128, -38, files 39)
             L. Guruprasad :    10  (+195, -21, files 14)
           Bhargav Kowshik :     3  (+127, -13, files 14)
                Gregg Lind :     1  (+9, -8, files 3)
             Deshraj Yadav :     1  (+1, -1, files 1)
                    aokoye :     1  (+2, -2, files 1)

    Total lines added: 29048
    Total lines deleted: 11381
    Total files changed: 938


    Everyone
    ========

        Adam Okoye
        Bhargav Kowshik
        cww
        David Weir
        Deshraj Yadav
        deshrajdry
        dron.rathore
        fbraun
        Gregg Lind
        hwine
        L. Guruprasad
        Laura Thomson :laura
        lorenzo567
        Mark Filipak
        mcooper
        mgrimes
        mozaakash
        Nicolas Perriault (:NiKo`) — needinfo me if you need my attention
        nigelbabu
        nperriault
        padraic
        phaneendra.chiruvella
        Rehan Dalal
        Ricky Rosario
        senicar
        stephen.donner
        Swarnava Sengupta
        vivekb.balakrishnan
        viveknjadhav19
        Will Kahn-Greene


Code line counts::

    2014q1: April 1st, 2014:        15195 total  6953 Python
    2014q2: July 1st, 2014:         20456 total  9247 Python
    2014q3: October 7th. 2014:      23466 total  11614 Python
    2014q4: December 31st, 2014:    30158 total  13615 Python


Nothing wildly interesting there other than noting that the codebase
for Input continues to grow.


Contributor stats
=================

Adam Okoye started as an intern through OPW on December 9th. He's contributed
to Input in the past through the Ascend project. Over the course of the OPW
internship, he'll be working on Input bugs and the `Thank you page project
<https://wiki.mozilla.org/Firefox/Input/Thank_you_page>`_.

L. Guruprasad spent a lot of time working on pre-commit linters,
Vagrant provisioning and generally improving the experience
contributors will have.

We had a few commits from other people, too.

Thank you everyone who contributed!


Accomplishments
===============

**Python 2.7**: Input is now running on Python 2.7. Thank you, Jake!

**Remote troubleshooting data capture**: The generic feedback form
which is hosted on Input now has a section allowing users to opt-in
to sending data about their browser along with their feedback. This
data is crucial to helping us suss out problems with video playback,
graphics cards/drivers and malicious addons.

This code is still "alpha". We'll be finishing it up in 2015q1.

`Remote troubleshooting data capture project plan 
<https://wiki.mozilla.org/Firefox/Input/Support_aboutsupport>`_.

**Heartbeat v1 and v2**: People leave feedback on Input primarily when
they're frustrated with something. Because of this, the sentiment
numbers we get on Input tilt heavily negative and only represent
people who are frustrated and were able to find the feedback
form. Heartbeat will give us sentiment data that's more representative
of our entire user base.

As a stop-gap to get the project going, Input is the backend
collecting all the Heartbeat data. We rewrote the Heartbeat-related
code for Heartbeat v2 in 2014q4.

`Heartbeat v2 project plan <https://wiki.mozilla.org/Firefox/Input/Heartbeat#v2:_beat_harder>`_.

**Feedback form overhaul**: We rewrote the feedback form to clean up
the text, reduce confusion about what data is made public and what
data is kept private, reduce the number of steps to leave feedback and
improve the form for both desktop and mobile devices.

`Feedback form overhaul project plan <https://wiki.mozilla.org/Firefox/Input/Feedback_form_overhaul>`_.

We also fixed the form so it supports multiple products because we're
collecting feedback for multiple products on Input now.

`Multiple products project plan <https://wiki.mozilla.org/Firefox/Input/Multiple_Products>`_.


Summary
=======

2014q4 was tough because of the limited time, but it was a good quarter and
we got a lot done.

The faux all-hands involved a bunch of discussions related to Input development.
2015q1 is going to be busy busy busy.

**Update April 21st, 2015**

LGuruprasad found a bug in the script that caused commits-by-author
information to be wrong. Fixed the script and updated the stats!
