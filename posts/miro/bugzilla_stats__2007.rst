.. title: bugzilla stats: 2007
.. slug: bugzilla_stats__2007
.. date: 2008-01-10 00:30:31
.. tags: miro

Other projects are publishing their Bugzilla stats, so I took 30 minutes
and threw together a script to run some numbers against our Bugzilla
instance.

Two things to keep in mind when looking at these numbers:

#. We migrated our bugs from Trac to Bugzilla in mid-August. Trac wasn't
   working out for us and we've got a lot of crufty bug data still
   hanging around since then.
#. The numbers are slices of data. They can indicate things, but there's
   a lot of context that they don't take into account. So it's good to
   be careful about drawing conclusions based solely on the numbers
   reported.

::

   Stats for the year: 2007

   BUG STATS
   =========

   Total bugs created: 4052
         41 - Miro Mediabar
          3 - getmiro.com
         35 - Broadcast Machine
       3809 - Miro
        164 - Miroguide

   Bug activity:
        736 - FIXED
        170 - INVALID
         35 - WONTFIX
        139 - DUPLICATE
        169 - WORKSFORME
          0 - MOVED
          0 - NEEDSINFO

       4052 - CREATED
      13564 - COMMENTS

   USER STATS
   ==========

   Users created: 645

   Top 7 bug reporters:
       3172 - Janet
        138 - Dean Jansen
        102 - Nicholas Reville
         52 - Nick Nassar
         47 - sg
         35 - Fluteman
         28 - Ben Dean-Kawamura

   Top 7 bug commenters:
      10354 - Janet
        331 - Nick Nassar
        315 - Will Guaraldi
        312 - Ben Dean-Kawamura
        286 - Luc Heinrich
        259 - Dean Jansen
        217 - Paul Swartz

There are a few things I want to point out.

First, is that we've got 645 new Bugzilla users since mid-August. That's
really great!

Second, is that Janet is not a machine that generates 10 bugs and 30
comments every day. What's going on is that I tied her Bugzilla userid
to all the bugs I migrated from Trac for which I had no userid to tie
to.

Third, sg and Fluteman are really fantastic. The work they're doing is
making a huge difference in the direction and quality of Miro. Thank
you!

Thank you to everyone who's helped out in 2007. I hope the numbers for
2008 are doubly-impressive. :)
