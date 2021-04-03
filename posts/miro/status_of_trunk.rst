.. title: status of trunk
.. slug: status_of_trunk
.. date: 2008-07-03 09:50:50
.. tags: miro, work

Over the last week I've been coming up to speed on the architectural
changes that occurred when Ben landed the new widget code. I've also
been hooking up menu items to their respective behavior and fixing bugs
on the Linux and Windows platforms. In many cases, I've been
re-implementing the behavior using the new messaging system which has
required me to read through the "old" code and figure out what the
behavior used to be. Progress was slow at the beginning, but is picking
up now.

You can see checkins progress in the `Trac
timeline <https://develop.participatoryculture.org/trac/democracy/timeline>`__.

There's still a lot of work to do to get things working again, but
things are progressing.

So, why all the trouble? Why not just leave it as is? Off the top of my
head:

#. Miro's UI is no longer rendered using HTML templates. w00t!
#. It looks like overall memory usage is lower by around 20%.
#. Memory usage of Miro when displaying feeds with lots of items scales
   much better.
#. Miro's faster at displaying feeds with lots of items (where "lots" is
   defined as > 50).
#. Miro on Windows is no longer a XULRunner application; instead we're
   embedding XULRunner for web-browsing. XULRunner is a great platform,
   but this change makes Miro a Python application on OSX, Linux and
   Windows and we can unify our toolset. That's a huge win for us and
   reduces the amount of work it takes to maintain all three platforms.

Regarding the performance gains, I'm seeing those on Windows and Linux,
but I definitely haven't spent a lot of time doing rigorous
measurements. Treat them as if they were wild unsubstantiated rumor. I
haven't used Miro on Mac OSX enough to notice anything there, yet.

Getting there...!
