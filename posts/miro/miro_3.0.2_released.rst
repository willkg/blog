.. title: Miro 3.0.2 released!
.. slug: miro_3.0.2_released
.. date: 2010-05-23 19:33:14
.. tags: miro, work

I just pushed out Miro 3.0.2 to address a few problems that users have
discovered since we released 3.0.1. If you haven't upgraded to a Miro 3
series release, it's worth doing.

This is the last release we're doing for OSX 10.4. Miro 3.1 and future
releases will not work on OSX 10.4.

I'm in the process of building packages for Ubuntu Jaunty, Karmic and
Lucid now. As a reminder, Ubuntu packages are in the **miro-releases**
Launchpad PPA at
`here <https://launchpad.net/~pcf/+archive/miro-releases>`__.

There were two big things that drove this release. The first is that
Miro on Linux sucked if you had XULRunner 1.9.2. This release fixes that
by switching from XULRunner to WebKit. One of the big benefits we get
from that is that it's much easier to compile Miro on Linux. The second
set of changes had to do with the changes I made to the GStreamer
renderer on Linux. This release fixes thumbnail building, playback from
one media item to the next, and volume.

As always, release notes for Miro 3.0.2 are
`here <https://develop.participatoryculture.org/trac/democracy/wiki/3.0ReleaseNotes>`__.

Update 5/23/2010: I just finished up Ubuntu packages and pushed them to
the PPA.
