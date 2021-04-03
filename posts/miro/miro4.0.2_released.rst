.. title: Miro 4.0.2 released!
.. slug: miro4.0.2_released
.. date: 2011-07-01 07:54:26
.. tags: dev, miro, work

A couple of days ago while I was on vacation, the team finished up the
changes for Miro 4.0.2.

There was a problem with the original 4.0.2 builds for people who were
running Miro for the first time which we fixed yesterday.  Thus, I
re-tagged v4.0.2 and built a new set of 4.0.2 builds.  The new set
are identical to the old set except that the new set doesn't have the
first time startup bug and it also has updated translations.

If you have the original Miro 4.0.2 and Miro starts up, then you
don't need to "upgrade" to the new Miro 4.0.2 build.

If you don't know which version of Miro 4.0.2 you have, launch Miro,
go to Help -> About in the menu and if the sha is e1cafdd1 (the v4.0.2
tag) or be096d8e (the rev in the Miro-4.0 branch that the v4.0.2 tag
points to), then you've got the most recent v4.0.2.

Here are the md5 sums for the correct 4.0.2 builds::

    8521a85eefbbe4d43e7d92d227249505  Miro-4.0.2.dmg
    4d789791279be3dc4951e64aeae06be2  Miro-4.0.2.exe
    8d32421082220579c1ee8f26a0032007  miro-4.0.2.tar.gz

Additionally, I pushed out packages for Ubuntu Lucid, Maverick and Natty
about an hour ago. 

See the release notes:

https://develop.participatoryculture.org/index.php/4.0ReleaseNotes

Download at:

http://getmiro.com/

For the most part, the team is now working on various projects that will
land in Miro 4.1 or future releases.  We have no plans to do a 4.0.3, but
will do so if the need presents itself.

To see what we're working on, see the Miro 4.1 roadmap:

http://bugzilla.pculture.org/roadmap.cgi?product=Miro&target=4.1
