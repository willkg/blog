.. title: Input: 2014 retrospective
.. slug: input_2014
.. date: 2014-12-31 14:20
.. tags: mozilla, work, input


What is it?
===========

The purpose of `Input <https://input.mozilla.org/>`_ is to collect
actionable feedback from our user base across each channel of our
software development process. The application collects feedback and
offers a set of analysis methods for looking at the resulting data. 

`Project site <https://wiki.mozilla.org/Firefox/Input>`_.

This is my 2014 retrospective for Input.

.. TEASER_END


2014 was a big year for Input. This is
the year we hit a point where the project is mature and stable. This
is the year we worked on making it easier for new people to start
working on Input. This is the year we fixed all the issues that made
it difficult for Input to support multiple products. This is the year
we created an API that allowed anyone to access the data to let them
write their own dashboards. This is the year we implemented a
translation infrastructure so that non-English feedback can flow
through our tools (previously, it was handled manually). It was
a big year.


Bugzilla and git stats
======================

Let's look at some Bugzilla and git stats for the year::

    Year 2014 (2014-01-01 -> 2014-12-31)
    ====================================


    Bugzilla
    ========

    Bugs created: 277
    Creators:

             Will Kahn-Greene [:willkg] : 240
                                 [:Cww] : 8
         Ricky Rosario [:rrosario, :r1c : 4
          Swarnava Sengupta (:Swarnava) : 3
         Nicolas Perriault (:NiKo`) — n : 1
                               vivek :) : 1
               Trif Andrei-Alin[:AlinT] : 1
                 Kohei Yoshino [:kohei] : 1
                 t.schmittlauch+persona : 1
         Mike "Pomax" Kamermans [:pomax : 1
                           Mark Filipak : 1
                  Matt Grimes [:Matt_G] : 1
            Padraic Harley [:thelodger] : 1
                             deshrajdry : 1
               Matt Brubeck (:mbrubeck) : 1
                      Christian Corrodi : 1
                  phaneendra.chiruvella : 1
                            vivek.kiran : 1
                              lgp171188 : 1
                                     me : 1
                    Matthew N. [:MattN] : 1
                    David Weir (satdav) : 1
         Hal Wine [:hwine] (use needinf : 1
              Ian Kronquist (:muricula) : 1
                           EventHorizon : 1
                   Laura Thomson :laura : 1

    Bugs resolved: 245

                                        : 1
                                WONTFIX : 17
                             WORKSFORME : 8
                              DUPLICATE : 13
                                  FIXED : 206

                             Tracebacks : 9
                               Research : 5
                                Tracker : 11

    Research bugs: 5

        788597: [research] Should we use a stacked graph on the dashboard?
        792976: [research] swap jingo-minify for django-compressor and
            django-jingo-offline-compressor
        889370: [research] morelikethis for feedback responses
        990774: [research] Investigate database schema changes for easier
            extensibility
        1048459: [research] check if updating from a tarball in a virtual
            environment with peep removes files

    Tracker bugs: 11

        963275: [tracker] support Metro
        964260: [tracker] overhaul mobile and desktop feedback forms
        965791: [tracker] implement product table
        966425: [tracker] create analyzer search view
        985645: [tracker] Upgrade to Django 1.6
        988612: [tracker] product dashboards
        1040773: [tracker] dashboards for everyone
        1042669: [tracker] reduce contributor pain
        1052459: [tracker] heartbeat v1
        1062429: [tracker] integrate spicedham classifier
        1081412: [tracker] add tests for fjord_utils.js functions

    Resolvers: 14

             Will Kahn-Greene [:willkg] : 209
                              lgp171188 : 7
                                 aokoye : 7
              Ian Kronquist (:muricula) : 5
         Ricky Rosario [:rrosario, :r1c : 4
               Joshua Smith [:joshua-s] : 3
          Swarnava Sengupta (:Swarnava) : 2
          Rehan Dalal [:rehan, :rdalal] : 2
                        Ruben Vereecken : 1
                                    Rob : 1
                                    cww : 1
         Schalk Neethling [:espressive] : 1
                        bhargav.kowshik : 1
                                   Anna : 1

    Commenters: 65

                                 willkg : 1261
                               rrosario : 19
                                mgrimes : 17
                                    cww : 14
                              MattN+bmo : 11
                                mcooper : 11
                              thewanuki : 7
                                 aokoye : 7
                       swarnavasengupta : 7
                                padraic : 6
                           iankronquist : 6
                    MarkFilipak.mozilla : 5
                     nicolas.barbulesco : 5
                  schalk.neethling.bugs : 5
                                  hwine : 4
                                 rdalal : 4
                              lgp171188 : 4
                         stephen.donner : 4
                               educmale : 4
                                anthony : 4
                               mbrubeck : 4
                         ms.annaphilips : 4
                              nigelbabu : 3
                                  rdaub : 3
                            me+bugzilla : 3
                                  pomax : 3
                             deshrajdry : 3
                        bhargav.kowshik : 3
                         rubenvereecken : 3
                               rrayborn : 3
                           rajul.iitkgp : 2
                               kbrosnan : 2
                              christian : 2
                                  glind : 2
                                peterbe : 2
                                hcondei : 2
                             david.weir : 2
                           dron.rathore : 1
                           pradeeppaddy : 1
                                tdowner : 1
                      margaret.leibovic : 1
                            aaron.train : 1
                         scottstensland : 1
                                senicar : 1
                  phaneendra.chiruvella : 1
                         trifandreialin : 1
                                  jesse : 1
                 t.schmittlauch+persona : 1
                         viveknjadhav19 : 1
                              mozaakash : 1
                                     me : 1
                                   glob : 1
                                 cturra : 1
                             nperriault : 1
                              rmcguigan : 1
                            vivek.kiran : 1
                         kdurant35rules : 1
                             vega.james : 1
                                 fbraun : 1
                                 326374 : 1
                    vivekb.balakrishnan : 1
                                  mhoye : 1
                                  mluna : 1
                                 feer56 : 1
                             lorenzo567 : 1

    git
    ===

    Total commits: 653

          Will Kahn-Greene :   590  (+244588, -206236, files 2774)
                Adam Okoye :    15  (+128, -38, files 39)
             L. Guruprasad :    13  (+203, -39, files 17)
             Ricky Rosario :    10  (+165, -350, files 30)
             Ian Kronquist :     7  (+201, -53, files 11)
            ossreleasefeed :     3  (+197, -42, files 9)
           Bhargav Kowshik :     3  (+127, -13, files 14)
              Joshua Smith :     3  (+91, -36, files 10)
         Swarnava Sengupta :     2  (+2, -2, files 2)
               Rehan Dalal :     2  (+315, -169, files 13)
              Anna Philips :     1  (+367, -3, files 12)
           Ruben Vereecken :     1  (+34, -14, files 6)
                Gregg Lind :     1  (+9, -8, files 3)
             Deshraj Yadav :     1  (+1, -1, files 1)
                    aokoye :     1  (+2, -2, files 1)

    Total lines added: 246430
    Total lines deleted: 207006
    Total files changed: 2942

    Everyone
    ========

        326374
        aaron.train
        Adam Okoye
        Anna
        Anna Philips
        anthony
        Bhargav Kowshik
        christian
        Christian Corrodi
        cturra
        cww
        David Weir
        Deshraj Yadav
        deshrajdry
        dron.rathore
        educmale
        EventHorizon
        fbraun
        feer56
        glob
        Gregg Lind
        Hal Wine
        hcondei
        Ian Kronquist
        jesse
        Joshua Smith
        kbrosnan
        kdurant35rules
        Kohei Yoshino [:kohei]
        L. Guruprasad
        Laura Thomson :laura
        lorenzo567
        margaret.leibovic
        Mark Filipak
        Matt Brubeck (:mbrubeck)
        Matt Grimes
        Matthew N. [:MattN]
        Mike Cooper
        me
        me+bugzilla
        mhoye
        Mike "Pomax" Kamermans [:pomax]
        mluna
        mozaakash
        ms.annaphilips
        Nicolas Perriault
        nicolas.barbulesco
        nigelbabu
        Padraic Harley [:thelodger]
        peterbe
        phaneendra.chiruvella
        pomax
        pradeeppaddy
        rajul.iitkgp
        Ralph Daub
        Rehan Dalal
        Ricky Rosario
        rmcguigan
        Rob
        Robert Rayborn
        Ruben Vereecken
        Schalk Neethling
        scottstensland
        senicar
        Stephen Donner
        Swarnava Sengupta
        t.schmittlauch+persona
        Tyler Downer
        thewanuki
        Trif Andrei-Alin
        vega.james
        vivek.kiran
        vivekb.balakrishnan
        viveknjadhav19
        Will Kahn-Greene


Some observations:

1. In 2013, we resolved more bugs than we created partially because we
   closed a bunch of bugs related to the old Input that weren't
   relevant anymore.

   In 2014, we created more bugs than we closed by 10%. I think that's
   about what we want.

2. 15 people had git commits. 26 people created bugs. 14 people
   resolved bugs. 65 people commented on bugs.

   One thing I don't have is counts for who helped translate strings
   which is a really important part of development. My apologies.

3. Of all those people, only 1 is a "core developer"--that's
   me. Everyone else contributed their time and energies towards
   making Input better. I really appreciate that. Thank you!


That's the stats!


Accomplishments
===============

Things we did in 2014:

**Site health dashboard**: I wrote a site health dashboard that helps
me understand how the site is performing before and after deployments
as well as after releases and other events.

**Client side smoke tests**: I wrote smoke tests for the client
side. I based it on the defunct input-tests code that QA was
maintaining up until we rewrote Input. The smoke tests have been
invaluable for reducing/eliminating data-loss bugs.

**Vagrant**: I took some inspiration from Erik Rose and DXR and wrote
a Vagrant provisioning shell script. This includes a docs overhaul as
well.

**Automated translation system (human and machine)**: I wrote an
automated translation system. It's generalized so that it isn't
model/field specific. It's also generalized so that we can add plugins
for other translation systems. It's currently got plugins for `Dennis
<https://dennis.readthedocs.org/>`_, Gengo machine translation and
Gengo human translation. We're machine translating most incoming
feedback.  We're human translating Firefox OS feedback. This was a
*HUGE* project, but it's been immensely valuable.

**Better query syntax**: We were upgraded to Elasticsearch 0.90.10. I
switched the query syntax for the dashboard search field to use
Elasticsearch ``simple_query_string``. That allows users to express
search queries they weren't previously able to express.

**utm_source and utm_campaign handling**: I finished the support for
handling ``utm_source`` and ``utm_campaign`` querystring
parameters. This allows us to differentiate between organic feedback
and non-organic feedback.

**More like this**: I added a "more like this" section to the response
view. This makes it possible for UA analyzers to look at a response
and see other responses that are similar.

**Dashboards for everyone**: We wrote an API and some compelling
examples of dashboards you can build using the API. It's being used in
a few places now. We'll grow it going forward as needs arise. I'm
pretty psyched about this since it makes it possible for people with
needs to help themselves and not have to wait for me to get around to
their work.

`Dashboards for everyone project plan
<https://wiki.mozilla.org/Firefox/Input/Dashboards_for_Everyone>`_.

**Vagrant**: We took the work I did last quarter and improved upon it,
rewrote the docs and have a decent Vagrant setup now. L. Guruprasad
improved on this and the documentation and setting up a Vagrant-based
vm for Input development is much easier.

`Reduce contributor pain project plan
<https://wiki.mozilla.org/Firefox/Input/Reduce_Contributor_Pain>`_.

**Abuse detection**: Ian spent his internship working on an abuse
classifier so that we can more proactively detect and prevent abusive
feedback from littering Input. We gathered some interesting data and
the next step is probably to change the approach we used and apply
some more complex ML things to the problem. The key here is that we
want to detect abuse with confidence and not accidentally catch swaths
of non-abuse. Input feedback has some peculiar properties that make
this difficult.

`Reduce the abuse project plan
<https://wiki.mozilla.org/Firefox/Input/Reduce_the_Abuse>`_.

**Loop support**: Loop is now using Input for user sentiment feedback.

**Heartbeat support**: User Advocacy is working on a project to give
us a better baseline for user sentiment. This project was titled
Heartbeat, but I'm not sure whether that'll change or not. Regardless,
we added support for the initial prototype.

`Heartbeat v1 project plan
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

`Heartbeat v2 project plan
<https://wiki.mozilla.org/Firefox/Input/Heartbeat#v2:_beat_harder>`_.

**Feedback form overhaul**: We rewrote the feedback form to clean up
the text, reduce confusion about what data is made public and what
data is kept private, reduce the number of steps to leave feedback and
improve the form for both desktop and mobile devices.

`Feedback form overhaul project plan
<https://wiki.mozilla.org/Firefox/Input/Feedback_form_overhaul>`_.

We also fixed the form so it supports multiple products because we're
collecting feedback for multiple products on Input now.

`Multiple products project plan
<https://wiki.mozilla.org/Firefox/Input/Multiple_Products>`_.


Thoughts
========

Looking at the stats above, it's pretty clear that this is predominantly
a one-person project. Ricky, Mike and Rehan do all my code review. Without
them, things would be a lot worse.

Having said that, the "baby-factor" stinks on this project. That's
something I'm going to work on over 2015:

* improving the documentation and making sure all the important things
  are covered or easily figured out

* improving the project planning and making sure most/all project
  planning is done in public or at least has a publicly available
  record

* reducing the complexity of the application, reducing dependencies
  and making the parts less tangled

* reducing the number of things that make Input a "special snowflake"
  in regards to other sites my peers maintain


Want to be a part of the team?
==============================

Input is a great little Django application that collects feedback for
Mozilla products. It's an important part of the Mozilla product
ecosystem. Working on it helps millions of people. If you're
interested in being a part of the team that develops it, here are
some helpful links:

* We maintain a `Get Involved page <https://wiki.mozilla.org/Webdev/GetInvolved/input.mozilla.org>`_.
* We hang out on ``#input`` on irc.mozilla.org.
* We have an `input-dev mailing list <https://mail.mozilla.org/listinfo/input-dev>`_.

**Update April 21st, 2015**

LGuruprasad found a bug in the script that caused commits-by-author
information to be wrong. Fixed the script and updated the stats!
