.. title: Input: 2015q3 quarter in review
.. slug: input_2015q3
.. date: 2015-10-13
.. tags: mozilla, work, input


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
   
    Quarter 2015q3 (2015-07-01 -> 2015-10-01)
    =========================================


    Bugzilla
    ========

    Bugs created: 60
    Creators: 4

             Will Kahn-Greene [:willkg] : 57
                 Karen Rudnitski [:kar] : 1
                                    Rob : 1
                    David Weir (satdav) : 1

    Bugs resolved: 58

                                        : 1
                                WONTFIX : 3
                                  FIXED : 52
                             WORKSFORME : 2

                             Tracebacks : 2
                               Research : 0
                                Tracker : 2

    Tracker bugs: 2

        1007840: [tracker] make thank you page for sad feedback helpful
            (phase 1)
        1193335: [tracker] remove eq_ and ok_

    Resolvers: 6

             Will Kahn-Greene [:willkg] : 38
                              reachtotj : 10
                                 willkg : 5
                          L. Guruprasad : 3
          Rehan Dalal [:rehan, :rdalal] : 1
         Ricky Rosario [:rrosario, :r1c : 1

    Commenters: 19

                                 willkg : 352
                               rrosario : 6
                                sarentz : 5
                              randersen : 4
                                mgrimes : 4
                               rrayborn : 4
                                rnewman : 3
                             krudnitski : 3
                              reachtotj : 3
                              tonnes.mb : 3
                                  glind : 2
                           iankronquist : 2
                               rtanglao : 1
                                   alam : 1
                                 adrian : 1
                             hripat1989 : 1
                                dhenein : 1
                            vivek.kiran : 1
                              lgp171188 : 1

    git
    ===

    Total commits: 225

          Will Kahn-Greene :   208  (+12017, -8524, files 798)
                 Taranjeet :     9  (+715, -704, files 26)
             L. Guruprasad :     5  (+55, -52, files 11)
               Rehan Dalal :     2  (+636, -97, files 57)
                       R&D :     1  (+637, -93, files 52)

    Total lines added: 14060
    Total lines deleted: 9470
    Total files changed: 944

    Everyone
    ========

        adrian
        alam
        David Weir (satdav)
        dhenein
        glind
        hripat1989
        iankronquist
        Karen Rudnitski [:kar]
        L Guruprasad
        mgrimes
        R&D
        randersen
        reachtotj
        Rehan Dalal [:rehan, :rdalal]
        Ricky Rosario [:rrosario, :r1cky]
        rnewman
        Rob
        rrayborn
        rtanglao
        sarentz
        Taranjeet
        tonnes.mb
        vivek.kiran
        Will Kahn-Greene [:willkg]


Code line counts::

    2014q1: April 1st, 2014:        15195 total  6953 Python
    2014q2: July 1st, 2014:         20456 total  9247 Python
    2014q3: October 7th. 2014:      23466 total  11614 Python
    2014q4: December 31st, 2014:    30158 total  13615 Python
    2015q1: April 1st, 2015:        28977 total  12623 Python
    2015q2: July 13th, 2015:        29549 total  13572 Python
    2015q3: September 30th, 2015:   30571 total  15119 Python

Nothing exciting this quarter. We added more tests and a new
suggester.


Contributor stats
=================

Taranjeet finished cleaning up after switching from nose to pytest.
We no longer use ``eq_`` and ``ok_``.

L Guruprasad updated requirements--something we haven't done in a while.
He also fixed the pre-commit issues we were having (yay!) and created
an AnalyzerProfileFactory which simplified a bunch of repetitive test
code.


Accomplishments
===============

**Trigger rule suggester**: We created a trigger rule suggester that 
suggests links to users leaving feedback that matches existing rules.

`Trigger rule suggester <https://wiki.mozilla.org/Firefox/Input/Trigger_suggester>`_

`Input: Trigger rule project Phase 1 <http://bluesock.org/~willkg/blog/mozilla/input_trigger_rules_phase1.html>`_

**Upgrade to Django 1.8**: This took us a long time to work through
because there were all kinds of things that needed to be fixed first.
It's done now!

I wrote up a blog post summarizing all the things involved.

`Input: Moving to Django 1.8 <http://bluesock.org/~willkg/blog/mozilla/input_django_1_8_upgrade.html>`_

**Lots of updates**: We upgraded a lot of requirements to more recent
versions of things. Further, we nixed a bunch that we weren't really
using.


Summary
=======

It was a decent quarter. Nothing special, but nothing worrying either.
