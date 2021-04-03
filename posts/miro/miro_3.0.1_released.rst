.. title: Miro 3.0.1 released!
.. slug: miro_3.0.1_released
.. date: 2010-04-15 19:26:14
.. tags: miro, work, ubuntu

We pushed out Miro 3.0.1 a couple of days ago to address a few problems
that we discovered with 3.0. If you haven't upgraded to 3.0.1 yet, it's
definitely worth doing.

Release notes for Miro 3.0.1 are
`here <https://develop.participatoryculture.org/trac/democracy/wiki/3.0ReleaseNotes>`__.

The other big change with this release is that I've moved our Ubuntu
packages from repositories on OSUOSL to our **miro-releases** Launchpad
PPA.

As of 3.0.1, we're no longer pushing packages to our repositories on
OSUOSL.

Details on the **miro-releases** PPA are at
`here <https://launchpad.net/~pcf/+archive/miro-releases>`__.

I do plan on doing packages for Lucid, but there's a problem with Miro's
embedded XULRunner browser on Lucid. It's captured in `bug
13169 <http://bugzilla.pculture.org/show_bug.cgi?id=13169>`__. Ben and I
are working on it, but if you've got experience with XULRunner, GTK,
and/or gtkmozembed, we could use some help. Details and status of the
problem are in the bug. This bug is definitely blocking packages for
Lucid. If you can help, ping us on ``#miro-hackers`` on freenode.net.

Update 4/22/2010: Lucid packages are in the PPA, too.
