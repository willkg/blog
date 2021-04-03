.. title: Input: 2013 retrospective
.. slug: input_2013
.. date: 2013-12-19 16:20
.. tags: mozilla, work, input


It was a big year for `Input <https://input.mozilla.org/>`_. In 2012,
we spent the last half rewriting Input. In 2013, it went through
secreview, had a bunch of things fixed and then we migrated to the new
system.

Since then, we've been fixing bugs, reimplementing features that were
lost and writing the scaffolding for the new set of User Advocacy
dashboards and tools.

Let's look at some Bugzilla and git stats for the year:

::

    Twas the year: 2013
    ===================


    Bugzilla
    ========

    Bugs created: 150
    
                    willkg : 100
                cwwmozilla : 5
                    fbraun : 4
                   mgrimes : 4
                   tdowner : 3
            stephen.donner : 3
               me+bugzilla : 2
            gasell+mozilla : 2
                   mcooper : 2
                     glind : 2
                 mozaakash : 1
            kdurant35rules : 1
                hitmanarky : 1
                  kbrosnan : 1
            bob.silverberg : 1
                  splewako : 1
                  rrosario : 1
                 mattbasta : 1
                  educmale : 1
                    feer56 : 1
                    326374 : 1
                   anthony : 1
            shopov.bogomil : 1
                   peterbe : 1
                      l10n : 1
        chrismore.bugzilla : 1
                    landis : 1
              dron.rathore : 1
                        rq : 1
                 MattN+bmo : 1
              joshua-smith : 1
                    cturra : 1
            swagat.kanungo : 1
    
    Bugs resolved: 268
    
                    willkg : 157
                           :    WONTFIX 50
                           :      FIXED 89
                           : WORKSFORME 8
                           :  DUPLICATE 9
                           :    INVALID 1
                cwwmozilla : 57
                           :      FIXED 1
                           :    WONTFIX 7
                           : WORKSFORME 29
                           :  DUPLICATE 1
                           :    INVALID 19
                   mgrimes : 10
                           :      FIXED 1
                           :  DUPLICATE 1
                           : WORKSFORME 5
                           :    INVALID 3
            shopov.bogomil : 7
                           :    WONTFIX 1
                           : WORKSFORME 2
                           :    INVALID 1
                           :      FIXED 2
                           :  DUPLICATE 1
                   mcooper : 6
                           :  DUPLICATE 1
                           :      FIXED 5
                   mozilla : 5
                           :      FIXED 5
               me+bugzilla : 4
                           :    WONTFIX 1
                           :      FIXED 1
                           :  DUPLICATE 1
                           :    INVALID 1
                 mozaakash : 2
                           : WORKSFORME 1
                           :    INVALID 1
            trifandreialin : 2
                           : WORKSFORME 2
                  rrosario : 2
                           :      FIXED 2
              joshua-smith : 2
                           :      FIXED 1
                           :    INVALID 1
               aaron.train : 2
                           :    WONTFIX 1
                           :  DUPLICATE 1
            stephen.donner : 1
                           : INCOMPLETE 1
                   emorley : 1
                           :      FIXED 1
                   curtisk : 1
                           :    INVALID 1
                   unghost : 1
                           : WORKSFORME 1
              rajul.iitkgp : 1
                           :      FIXED 1
                 jruderman : 1
                           : INCOMPLETE 1
              chris.lonnen : 1
                           :      FIXED 1
                 nigelbabu : 1
                           :      FIXED 1
                  tofumatt : 1
                           :      FIXED 1
                    cturra : 1
                           :      FIXED 1
                   fwenzel : 1
                           :      FIXED 1
                   mbrandt : 1
                           :      FIXED 1
    
                INCOMPLETE : 2
                 DUPLICATE : 15
                   INVALID : 28
                WORKSFORME : 48
                   WONTFIX : 60
                     FIXED : 115


    git
    ===

    Total commits: 277

          Will Kahn-Greene :   251  (+51614, -16878, files 1132)
               Mike Cooper :    12  (+38545, -249, files 219)
            Brandon Burton :     5  (+21, -178, files 6)
             Ricky Rosario :     4  (+36, -19, files 6)
            Bob Silverberg :     2  (+11, -6, files 2)
                     Rajul :     1  (+3, -0, files 1)
              Joshua Smith :     1  (+10, -5, files 1)
                   bogomil :     1  (+1, -1, files 1)


    Total lines added:   90241
    Total lines deleted: 17336
    Total files changed: 1368


I want to highlight some interesting bits:

1. We resolved more bugs than we created. That's partially due to us
   going through and closing out old bugs for the old Input that
   aren't relevant anymore.

2. According to the Bugzilla and git data, there were 47 contributors
   to Input this year: 326374, Bob Silverberg, Brandon Burton, Joshua
   Smith, MattN+bmo, Mike Cooper, Rajul, Ricky Rosario, Will
   Kahn-Greene, aaron.train, anthony, bogomil, chris.lonnen,
   chrismore.bugzilla, cturra, curtisk, cwwmozilla, dron.rathore,
   educmale, emorley, fbraun, feer56, fwenzel, gasell+mozilla, glind,
   hitmanarky, jruderman, kbrosnan, kdurant35rules, l10n, landis,
   mattbasta, mbrandt, me+bugzilla, mgrimes, mozaakash, nigelbabu,
   peterbe, rajul.iitkgp, rq, splewako, stephen.donner,
   swagat.kanungo, tdowner, tofumatt, trifandreialin, and unghost.

   That doesn't include localizers who do a ton of work translating
   the strings in the Input ui.

   That includes some of the folks who work on the input-tests
   repository, but possibly misses some.

3. Most of the 47 contributors are not "core developers". That's cool,
   but I could be doing a better job here making it easier for
   non-core developers.

   We maintain a `Get Involved page <https://wiki.mozilla.org/Webdev/GetInvolved/input.mozilla.org>`_
   and we hang out on ``#input`` on irc.mozilla.org. We have a
   `input-dev mailing list <https://mail.mozilla.org/listinfo/input-dev>`_.
   If you want to work on Input, this is where it's at!


Those are the stats.

At a high-level, we accomplished the following:

1. stood up a new Input code base

2. the beginnings of spam identification and removal

3. Input API for feedback submission

4. Firefox OS feedback form

5. infrastructure for an Analysts group with special privileges

6. the beginnings of an Occurrence Comparison report dashboard


One thing I discovered in 2013q4 was that it's really hard to be the
mostly-solo dev on a project like this. I'm lucky that I'm part of a
larger team, so peer reviews for work I've done is possible and
timely. However, I find I'm switching contexts between the technical
details of what I'm working on now and the high-level details of a
bunch of possible future tasks/projects. That's really hard to do
day-to-day and still maintain development momentum. I have some
thoughts on how to serialize my work so that I'm doing less context
switching and I can focus on individual things more deeply which
should produce better outcomes.

My goals for Input for 2014 are these:

1. clean up the code base: there's still a bunch of weird stuff in
   there from the rapid development work we did in 2012

2. reduce barriers to entry for new contributors: better
   documentation, fewer steps to get up and running, more bugs marked
   for mentoring, more outreach, ...

3. build infrastructure that we can use for better User Advocacy
   tools: watched alerts, email notifications, dashboards, ...

4. flesh out tests: we're really light on smoketests and
   regression-catching tests

5. work with Matt and Cheng to figure out where Input fits into the
   grand scheme of things; how can we make it a general-purpose feedback
   system? how can we handle non Firefox products and initiatives?


Yay for 2013!

**Update 7:08pm**

My script only showed top tens which misses tons of people
who did work. I redid the data and that increases the number
of contributors from 16 to 47. Oops!

**Update April 21st, 2015**

LGuruprasad found a bug in the script that caused commits-by-author
information to be wrong. Fixed the script and updated the stats!
