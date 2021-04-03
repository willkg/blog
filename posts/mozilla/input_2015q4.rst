.. title: Input: 2015q4 quarter in review
.. slug: input_2015q4
.. date: 2016-01-04
.. tags: mozilla, work, input


Things to know:

* `Input <https://input.mozilla.org/>`_ is Mozilla's product feedback site.
* `Fjord <https://github.com/mozilla/fjord>`_ is the code that runs
  Input.
* We maintain project details and plans at
  `<https://wiki.mozilla.org/Firefox/Input>`_.
* I am Will Kahn-Greene and I was the tech lead, architect, QA and
  primary developer on Input.

This is the quarter in review for Mozilla Input!

.. TEASER_END


Bugzilla and git stats
======================

::
   
    Quarter 2015q4 (2015-10-01 -> 2016-01-01)
    =========================================


    Bugzilla
    ========

    Bugs created: 46
    Creators: 6

             Will Kahn-Greene [:willkg] : 38
         Justin Crawford [:hoosteeno] [ : 3
         Michael Kelly [:mkelly,:Osmose : 2
                      Artem Polivanchuk : 1
                                    Jen : 1
               Francesco Lodolo [:flod] : 1

    Bugs resolved: 55

                                WONTFIX : 23
                                  FIXED : 29
                              DUPLICATE : 3

                             Tracebacks : 2
                               Research : 6
                                Tracker : 3

    Research bugs: 6

        1179534: [research] geo for heartbeat
        1213373: [research] better way to collapse whitespace in Jinja2
            trans blocks
        1222442: [research] way to distinguish feedback from Fennec
            about:feedback and Input generic form

    Tracker bugs: 3

        1146686: [tracker] upgrade to django 1.8
        1198758: [tracker] trigger suggester project

    Resolvers: 4

             Will Kahn-Greene [:willkg] : 53
                                  jorge : 1
                          L. Guruprasad : 1

    Commenters: 25

                                 willkg : 342
                                mgrimes : 14
                             ankititsme : 9
                                  zfang : 5
                           jennifer72tx : 4
                           mr.reception : 4
                                neminaa : 4
                                  hello : 4
                             deshrajdry : 3
                                  glind : 3
                              standard8 : 2
                         bansalutkarsh3 : 2
                              lgp171188 : 2
                               rrosario : 2
                                 gioyik : 2
                            aaronkalair : 1
                              reachtotj : 1
                          a.polivanchuk : 1
                                madhava : 1
                                    cww : 1
                                  mhoye : 1
                               rajat503 : 1
                              aman_alam : 1
                                  jorge : 1
                                 mkelly : 1

    git
    ===

    Total commits: 96

          Will Kahn-Greene :    92  (+3214, -2880, files 266)
             L. Guruprasad :     4  (+17, -12, files 5)

    Total lines added: 3231
    Total lines deleted: 2892
    Total files changed: 271

    Everyone
    ========

        aaronkalair
        aman_alam
        ankititsme
        Artem Polivanchuk
        bansalutkarsh3
        cww
        deshrajdry
        Francesco Lodolo [:flod]
        gioyik
        glind
        hello
        Jen
        jennifer72tx
        jorge
        Justin Crawford [:hoosteeno] [:jcrawford]
        L Guruprasad
        madhava
        Matt Grimes
        mhoye
        Michael Kelly [:mkelly,:Osmose]
        mr.reception
        neminaa
        rajat503
        reachtotj
        rrosario
        standard8
        Will Kahn-Greene [:willkg]
        zfang


Code line counts::

    2014q1: April 1st, 2014:        15195 total  6953 Python
    2014q2: July 1st, 2014:         20456 total  9247 Python
    2014q3: October 7th. 2014:      23466 total  11614 Python
    2014q4: December 31st, 2014:    30158 total  13615 Python

    2015q1: April 1st, 2015:        28977 total  12623 Python
    2015q2: July 13th, 2015:        29549 total  13572 Python
    2015q3: September 30th, 2015:   30571 total  15119 Python
    2015q4: December 30th, 2015:    31116 total  15364 Python


We removed a lot of code this quarter and did a fair amount of code cleanup. It
was a good quarter for improving the quality of the code without improving the
quantity of the code.


Contributor stats
=================

There wasn't a lot of non-me activity this quarter. Generally 4th quarter tends
to be slower all around.


Accomplishments
===============

**Switched to Puente**: We ditched a lot of code in Fjord for l10n support and
switched to use `Puente <https://puente.readthedocs.org/>`_. In the process of
doing that, we improved Puente by a lot, solved a bunch of mysteries and
generally have a much better l10n situation than we did previously.

**Emoji**: I spent a lot of time tracking down problems with Input falling over
when emoji was in the feedback. The problem is that we're using MySQL with utf8
and MySQL's utf8 is 3-byte. In order to store emoji, we need to be using 4-byte
utf8mb4. Switching to that is a bit of a trick and I hit a lot of problems. I'm
not sure when we'll get this fixed, but at least we understand the issues
involved now.

**Heartbeat Health Check**: We added a healthcheck system for Heartbeat to
prevent future data problems. This system is pretty flexible, so we can
easily expand it with additional checks in the future.

**Updates, bug fixes, etc**: We had the regular amount of library updates, minor
bug fixes and other improvements. We added a lot of tests and removed a lot of
half-done or dead code. Generally, the quality of the project is higher, though
as with most things, there are always things to improve.


Summary
=======

It was a decent quarter. Nothing special, but nothing worrying either.
