.. title: Miro 1.2 released!  (working on Ubuntu packages now....)
.. slug: miro_1_2_released
.. date: 2008-03-20 13:45:35
.. tags: miro, work

Twenty minutes ago or so `we released Miro
1.2 <http://www.getmiro.com/blog/2008/03/announcing-miro-12-a-major-update/>`__.
I was talking to `Chris <http://www.0xdeadbeef.com/weblog/>`__,
`Bryan <http://clarkbw.net/blog/>`__, and `John <http://ejohn.org/>`__
about Miro 1.2 yesterday at lunch (mid-release) because while there was
a lot of work done on Miro 1.2, not a whole lot of it is immediately
obvious to the typical Miro user. That got me thinking about writing a
post that better explains what did happen and why it's important.

The `Miro 1.2 release
post <http://www.getmiro.com/blog/2008/03/announcing-miro-12-a-major-update/>`__
has a list of things we worked on for Miro 1.2. Most of that list
consists of things we did in a week or so. The majority of the release
cycle work hours were spent on two items: switching to xulrunner 1.9 on
Windows and re-architecting to further separate the "frontend" from the
"backend". I want to talk a bit about those two items and why they're
important.

Let's start with the xulrunner 1.9 change. Firefox 3 is based on
xulrunner 1.9. Switching to xulrunner 1.9 even though it's not released
yet was important because the Mozilla crew have done awesome work on
improving performance in their current release cycle. Many of the
performance improvements are memory-related. It definitely doesn't make
Miro the most optimized thing ever, but it helps. Additionally, Nassar
(who did the work) spent some time refactoring bits to make sure events
were happening in the correct thread of execution and reducing some of
the layers of abstraction and indirection involved. This work will make
Miro on Windows more stable than it was previously.

The re-architecture work that Ben did is also really important. Previous
versions of Miro had a backend and frontend that were tied together.
Creating new platforms was arduous and it hampered any efforts towards
building a daemonized platform or a platform that talked to MythTV or
Elisa.... He made the split between the two much cleaner and at the end
wrote a sample `command line
interface <http://pculture.org/devblogs/bdk/2008/02/26/lets-branch/>`__.
In the process of doing that work, he did a bunch of other things that
affected the entire code base: he fixed the namespace issues we had with
Miro Python modules and he did some refactoring.

This opens up a lot of possibilities. It will be easier to write a
daemon Miro platform that has an XMLRPC interface. It will be easier to
write a slimmed down version of Miro for smaller computers like the
Nokia n810. It's a good direction to be heading in.
