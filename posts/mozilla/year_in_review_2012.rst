.. title: Mozilla: 1 year review
.. slug: year_in_review_2012
.. date: 2012-12-31 17:52:00
.. tags: webdev, mozilla, work, sumo, input

This was my first full year at Mozilla and it was intense. I
essentially worked on four projects: SUMO, Input, ElasticUtils and
Gaia. This blog post talks about the first two which are worked on
by the James' Rifles SUMINPUT Megalosaur team.

We accomplished a lot on SUMO this year. I spent a couple of hours
last week throwing together a rough "year in review" script
that looked at Bugzilla and git and crunched some numbers:

::

    Twas the year: 2012
    ===================
    
    
    Bugzilla
    ========
    
    Bugs created: 938
    
                  rrosario : 201
                   a.topal : 188
                    willkg : 108
               scoobidiver : 51
                   igarcia : 41
                    mverdi : 36
          swarnavasengupta : 30
                     james : 29
                      bram : 19
                tobbi.bugs : 17
    
    Bugs resolved: 1025
    
                  rrosario : 335
                           : WORKSFORME 18
                           :    INVALID 16
                           :  DUPLICATE 23
                           :    WONTFIX 7
                           :      FIXED 263
                           : INCOMPLETE 8
                   a.topal : 182
                           : WORKSFORME 36
                           :    INVALID 41
                           :  DUPLICATE 11
                           :    WONTFIX 70
                           :      FIXED 21
                           : INCOMPLETE 3
                    willkg : 131
                           :  DUPLICATE 6
                           :      FIXED 110
                           : WORKSFORME 2
                           :    WONTFIX 11
                           :    INVALID 2
                    rdalal : 84
                           :      FIXED 84
                     james : 51
                           : WORKSFORME 6
                           :    INVALID 5
                           :  DUPLICATE 3
                           :    WONTFIX 15
                           :      FIXED 14
                           : INCOMPLETE 8
                   mcooper : 37
                           :      FIXED 36
                           :    INVALID 1
                tobbi.bugs : 29
                           :      FIXED 29
                 tgavankar : 28
                           :    WONTFIX 1
                           : WORKSFORME 1
                           :      FIXED 26
               scoobidiver : 28
                           :      FIXED 4
                           :  DUPLICATE 4
                           : WORKSFORME 11
                           :    WONTFIX 3
                           :    INVALID 6
                   bmo2010 : 13
                           :      FIXED 1
                           :  DUPLICATE 3
                           : WORKSFORME 3
                           :    INVALID 6
    
                INCOMPLETE : 21
                 DUPLICATE : 61
                WORKSFORME : 82
                   INVALID : 91
                   WONTFIX : 117
                     FIXED : 653
    
    git
    ===
    
    Total commits: 916
    
             Ricky Rosario : 430
          Will Kahn-Greene : 192
               Rehan Dalal : 98
               Mike Cooper : 44
                 Erik Rose : 34
                     Tobbi : 29
            Tanay Gavankar : 23
               Kadir Topal : 11
                 Tim Watts : 10
             Berker Peksag : 9
               James Socol : 7
                Victor Neo : 6
          Cesar Carruitero : 5
               David Lilly : 4
                      Ibai : 3
            Isac Lagerblad : 2
                     icaaq : 1
               TylerDowner : 1
                  browning : 1
             ricky rosario : 1
        Anatoli Papirovski : 1
         Clauber Stipkovic : 1
              Jason Thomas : 1
                    atopal : 1
          Florin Strugariu : 1


There are some interesting bits in there:

1. Ricky does a lot of work! Holy cow!

2. There were 23 people who contributed code to Kitsune (the SUMO codebase)
   this year. Of those, about half are volunteer contributors.

   Compare with 2011, we had 19 people who contributed to the code base
   and less than half were volunteer contributors.

3. We resolved more bugs than we created in 2012. We did that in 2011
   as well, so that's two years in a row. I've never seen that happen
   before on a project I work on.


The codebase is pretty different now than it was at the beginning of
the year. I helped with the following semi-massive overhauls:

1. The push for more metrics and dashboards to view the numbers.

2. The switch from Sphinx to ElasticSearch.

3. The new Information Architecture which affected browsing and searching
   across the site.

4. The site redesign which covered both the desktop and mobile versions
   of the site.

5. The upgrade to Django 1.4.

6. The switch from `arecibo <https://github.com/andymckay/django-arecibo>`_
   to `sentry <https://getsentry.com/welcome/>`_.

7. The push to switch from fixtures to model makers for all our tests.

8. The switch from weekly deployments on Tuesdays to deploying whenever
   we want. Continuous deployment is fantastic.

9. Started switching the whole site from Webtrends to Google Analytics.
   I saw Ricky write up a bunch of bugs to finish up that work, so
   I'll say it's in progress.

10. During the redesign, Rehan redid all the CSS and switched us to
    use `LESS <http://lesscss.org/>`_.

11. I spun off some code I wrote for richard, then ported to Fjord, then
    improved into a project called `django-eadred
    <https://github.com/willkg/django-eadred>`_. That makes it a lot
    easier to generate sample data for a variety of purposes like new
    contributors, bootstrapping, and large random data sets.


On top of that, we did a lot of work on the documentation and making it
easier to get to a working Kitsune development environment. We switched
to a sprint-based work flow using `Scrumbugz <http://scrumbu.gs/>`_. We
also nixed our daily checkin conference call for an IRC-based checkin
system that we wrote called `Standup <https://github.com/rlr/standup>`_.

It's been a big year.

For Input, it was a bigger year. We decided to abandon the old Input
codebase (omfg yay) in favor of rewriting it from the ground up. The rewrite
took a couple of months and then has sort of been sitting around waiting
for a security review. In the meantime, we (actually, Mike did) fixed a
bunch of issues with the old site code because that's what's currently
in production.

Rewriting Input wouldn't have taken so long except that we did a lot of
work fixing bugs in external libraries and updating `Playdoh
<http://playdoh.readthedocs.org/en/latest/>`_. That work definitely cut
into our schedule, but it benefitted a bunch of other groups/people/sites,
so that's good.

That's the gist of the year: it was a lot of work, but we accomplished a
ton.

w00t for 2012!
