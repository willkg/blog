.. title: status: week ending 3/5/2008
.. slug: status__week_ending_3_5_2008
.. date: 2008-03-05 23:17:38
.. tags: miro, work

This week was an ok bug-fixing week. I worked on:

* `Bug 9644 <http://bugzilla.pculture.org/show_bug.cgi?id=9644>`__:
  implemented a preference allowing you to switch between renderers on
  GTKX11--it's not great, but it's good enough (probably).
* `Bug 3067 <http://bugzilla.pculture.org/show_bug.cgi?id=3067>`__:
  applied a patch for suspending the screensaver when playing video in
  fullscreen on GTKX11... then I found a couple of problems with it and
  backed it out today.
* Fixed a bunch of other bugs related to gstreamer renderer, ff/rew,
  revver, mefeedia, ...
* Worked on `bug
  9214 <http://bugzilla.pculture.org/show_bug.cgi?id=9124>`__ where if
  you click on the delete link when viewing a video in fullscreen on
  GTKX11, then you're stuck in fullscreen. I worked on it for a couple
  of days and ended up giving up today.
* Sent out a proposed tentative release schedule for Miro 1.2 to the
  develop mailing list.
* Helped with some of the initial GSoC preparation.

Next week I'm going to:

* `Bug 9692 <http://bugzilla.pculture.org/show_bug.cgi?id=9692>`__.
  Check out Fabien's patches for Ubuntu that get Miro to work with
  xulrunner 1.9.
* `Bug 9691 <http://bugzilla.pculture.org/show_bug.cgi?id=9691>`__.
  Look into Miro compiling with gcc 4.3. Uwe said something that
  suggested that gcc 4.3 on Debian is imminent. So... this needs to be
  figured out.
* Continue to shepherd Miro 1.2 until it's out the door.

Busy busy busy....
