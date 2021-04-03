.. title: Gutsy packages for 0.9.9.9-rc0 available -- please help us test
.. slug: gutsy_packages_for_0_9_9_9_rc0_available____please_help_us_test
.. date: 2007-10-23 16:05:05
.. tags: miro, work

It's been a wild couple of days. I finished up the rc0 release for
Windows and Mac OSX on Saturday, spent Sunday upgrading my laptop from
Feisty to Gutsy and then on Monday we had some quirky subversion
collisions.

We've worked out some/most of the issues with the Ubuntu packaging for
Miro and build a package for Gutsy. This package is available in the
Miro repositories.

**Things to note:**

#. This package is release candidate 0 for version 0.9.9.9. If you are
   at all squeamish about testing software in a beta state, you should
   wait for the 0.9.9.9 final release which will be sometime this week
   or next week.
#. Back up your ``~/.miro`` directory BEFORE installing and using this
   package. If there were issues, you want to be able to go back to your
   previous Miro state.
#. Miro conflicts with ``sun-java6-plugin``. You can't have both
   installed at the same time. This is a workaround for problems we're
   having with the sun-java6-plugin, gtkmozembed, and Miro. If this is a
   problem for you, you should wait until the 0.9.9.9 final release.
   It's possible we'll have a different fix for it by then, but it's
   more likely that this will happen in version 1.0 or later. If you
   know how to set up gtkmozembed so that it doesn't load plugins, let
   us know.

**Instructions:**

If you follow the directions at
http://www.getmiro.com/download/ubuntu.php but use:

``deb http://ftp.osuosl.org/pub/pculture.org/miro/linux/repositories/ubuntu gutsy/``

as the line to add, then you'll pick up the Miro repository for Gutsy.

**What to do if things don't work:**

Let us know if you have any problems. Good ways to do this would be:

* add to an existing bug report or create a new bug report in our
  `Bugzilla system <http://bugzilla.pculture.org>`__, and/or
* comment here (but make sure I have some way to reply to you)
* hop on ``#miro`` on ``irc.freenode.net`` and let us know.

And if it worked great, we'd love to know that, too.
