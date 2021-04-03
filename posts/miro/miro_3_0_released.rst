.. title: Miro 3.0 released!
.. slug: miro_3_0_released
.. date: 2010-03-25 21:18:02
.. tags: miro, work, dev

We pushed out Miro 3.0 today. There are still some minor things to do
like Ubuntu packages (I'll work on that Friday), version updates on the
web-site, .... Still, it's really great to finally get the release out
the door.

This release has some great features in it:

* subtitle support
* lots of performance fixes
* fixes to the database layer reducing disk i/o
* context menu item and system preference for playing videos externally
  (thank you Jason Woofenden!)
* support for media keys on Ubuntu/Linux
* a ton of bug fixes
* and we wrote a `Miro User Manual <http://getmiro.com/userguide/>`__

Also important, but not something you would see direct evidence of, we
did a lot of work on infrastructure and process for developing Miro:

* Janet set up an automated ui test system
* we fixed our unit test framework to work on Windows
* we added 40 unit tests and updated/fixed a lot more
* we tweaked our testing and release processes to increase quality
* we switched from svn to git
* we re-wrote our nightly build scripts
* we reworked binary kits so they're versioned and in separate
  repositories
* we continued cleaning up and working on documentation
* we continued cleaning up our codebase using pylint to identify issues
* we worked on removing code complexity and dead code; ditched some
  pyrex code; ditched support for xine

We're working hard to make sure that this and future releases are good
quality releases. We're working hard to make sure that the four of us
can keep pushing Miro in new directions and provide better support for
Miro users. We're working hard to do more with less.

We're very excited about this release--it feels really good.

We've also already started on Miro 3.1 development. You can follow the
roadmap
`here <http://bugzilla.pculture.org/roadmap.cgi?product=Miro&target=3.1>`__.
