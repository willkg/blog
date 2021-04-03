.. title: Miro 1.0 released!
.. slug: miro_1_0_released_
.. date: 2007-11-13 14:32:54
.. tags: miro, work

`Miro 1.0 has been
released! <http://www.getmiro.com/blog/2007/11/miro-10-is-here/>`__ Yay!

I've only been with PCF since July (or maybe it was June--I forget), but
since I came on board we've been working hard on stability and honing
the feature set. Working on stability is hard because there are a near
infinite number of combinations of library versions, video card drivers,
operating systems, ... out there and all of them are slightly different.
Writing software that works on multiple platforms is non-trivial. It's a
huge testament to the community of users and testers and developers that
Miro is at the point it's at now.

One thing about 1.0 that I want to mention is that this is a snapshot in
time of a continually evolving piece of software. If you look at
Bugzilla, there are dozens of interesting features that we're all
interested in that range from starting Miro as a daemon process to
viewing video as it's downloading.

Chris, Nick and Ben are working on post-1.0 development already. There's
been discussions on the ``develop`` mailing list regarding reworking the
user interface to use native widgets and make it much faster and more
responsive. Paul is continuing work on the Miro Guide. Janet is working
on making community testing easier for everyone involved and produce
better testing data. I'm switching off to work on Mediabar. Dean and the
Team Miro folks are working on honing the documentation and they're
doing a fantastic job of testing and identifying issues for release
candidates and versions.

Miro development is moving along and its momentum is a direct result of
us all working towards a common goal: building an Internet video player
using Open Source and open standards that will enable the current
generation of media content to flourish.

One other thing I want to mention is that we ditched the conflicts
between the miro package and the sun-java*-plugin packages for Gutsy and
Feisty. The problem between the packages still exists and it's
intermittent, but several conversations with people caused me to rethink
adding the conflicts. So this doesn't fix anything--it's just trading
one set of problems for another, however I've come around to agree that
the conflict is more of a pain in the ass than occasional intermittent
crashes.
