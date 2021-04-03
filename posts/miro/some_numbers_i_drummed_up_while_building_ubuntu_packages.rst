.. title: some numbers I drummed up while building Ubuntu packages....
.. slug: some_numbers_i_drummed_up_while_building_ubuntu_packages
.. date: 2008-03-21 13:16:50
.. tags: miro, work

After that lunch on Wednesday where I talked about how much I really
love the numbers and pretty graphs that are on
`planet.mozilla.org <http://planet.mozilla.org/>`__ regularly, I wanted
to do stats on Miro.

>

There are two things I'm interested in measuring. The first is
measurements related to release cycles and development process. The
second is measurements related to contributions.

Anyhow, here are some rough tables:

::

              tag      tv/    released    cycle
              ------   -----  ----------  -------
   Miro 1.0   151 MB   53 MB  11/13/2007  N/A
   Miro 1.1   169 MB   58 MB  1/10/2008   58 days
   Miro 1.2   253 MB   63 MB  3/20/2008   70 days

* "tag" - size in MB of the codebase which includes binary kits and
  other stuff
* "tv/" - size in MB of just the tv/ directory
* "released" - release date
* "cycle" - the length in days of the release cycle

We're still doing tight release cycles. I'm hoping we'll trend towards
longer release cycles. Something in the 3 month range would be easier on
the devs and probably other people, too.

::

              bugs fixed all gtk mac win    bugs created all gtk mac win
              ---------- --- --- --- ---    ------------ --- --- --- ---
   Miro 1.0   65         18  17  15  15     85           20  17  17  31
   Miro 1.1   40         16  6   10  8      106          44  21  20  21
   Miro 1.2   82         26  14  13  29     --

* bugs fixed - number of bugs fixed and then broken down by platform
* bugs created - number of bugs created against this version and then
  broken down by platform

I'll let you interpret the data as you like. I think the "bugs fixed"
column is indicative of our priorities between the releases: 1.0 was a
stability-focused release, 1.1 put out libtorrent, and 1.2 involved a
code overhaul which caused a lot of regressions.

::

             languages
             ---------
   Miro 1.0  63
   Miro 1.1  66
   Miro 1.2  70

I'd like to figure out how to get a rough measure of quality of
translations, but I'm not really sure how to go about doing that. I
threw together a script to count the number of instances where ``msgid``
differs from ``msgstr``, but the results don't seem very indicative of a
correctness or completeness figure. Launchpad has statistics, but
there's no way to look "back in time" at previous releases that I can
find. Are there any ideas for how to do that by looking at the ``.po``
files?

::

             patches from contributors applied
             ---------------------------------
   Miro 1.0  4
   Miro 1.1  2
   Miro 1.2  1

What this table shows is that almost all development is being done by
PCF. This table troubles me the most--more about that at the end. On to
stats from Bugzilla.... First off, our Bugzilla data before October is
probably mediocre, so I'm not really even looking at that. After that,
the data has been getting better as more people are helping to triage
and annotate bugs. Also, some bugs never make it to Bugzilla. I know
that sedatg and some other people mention issues to us on IRC
semi-regularly which get fixed, but aren't tied back to Bugzilla bugs.
It's probably fair to say these stats are indicative of things but
aren't 100% accurate.

::

   Miro 1.2 stats
   ==============
   length of cycle:      70 days
   bugs fixed:           82 total
     By Operating System:
        all:             26
        gtkx11:          14
        osx:             13
        win:             29

     By Severity:
        blocker:          1
        critical:        12
        major:            5
        normal:          58
        minor:            2
        enhancement:      4

     By Component:
        Channels         11
        Download          4
        Feeds             1
        Guides            3
        Install           5
        Library - New     3
        Menu - Shortcut   3
        Min - Max         1
        Playback         14
        Playlists         2
        Search            6
        Startup          10
        Storage           1
        System settings   2
        User interface    5
        main             11

   bug reporters:        24 total
        pcf people:       7
        community:       17

Miro is benefiting greatly from the community with testing and
translations--that's really great and it's helping a ton! However, Miro
is not getting much help from the community with code and PCF is pretty
much funding all development. This is troubling. Miro is getting bigger
over time and the complexity is growing, too. There are a lot of moving
pieces in the stack of external components that Miro relies upon. There
are two ways for Miro development to scale well:

#. more contributors
#. additional funding for PCF so that they can fund developers

If you can contribute code, please let me know if there's something
blocking your path. If you can't contribute code and/or you're
interested in Miro getting better, then install
`iHeartMiro <http://www.iheartmiro.org/>`__ (there are versions for
Firefox and IE) and/or `donate
money <https://www.getmiro.com/about/donate/>`__ and help PCF fund
developers.
