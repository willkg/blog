.. title: Miro 2.0 rc3 released!
.. slug: miro_2_0_rc3_released_
.. date: 2009-02-07 21:47:05
.. tags: miro, work

I tagged and built Miro 2.0 rc3 builds and placed them in the sticky
section of the nightlies page.

Pre-release release notes are at
https://develop.participatoryculture.org/trac/democracy/wiki/2.0ReleaseNotes.

Changes since rc2:

* updated translations as of today
* bug 11329: decimal value for movie duration is never correct in
  channel view
* bug 11327: os x crash, windows error - when selecting item
  (non-ascii) to share
* bug 11149: New OSX DMG Background to replace current one
* bug 11296: 'show more' jumps back to top of list on 'Single Items'
  and 'New'
* bug 11322: File "miro\feedupdate.pyc", line 67, in update_finished
  KeyError: 26
* bug 11262: python 2.6 support (preliminary and untested)
* bug 11317: os x - crash after added torrent feed then selecting
  channel tab.
* bug 11354: "Global name 'time' is not defined" death on laptop
* bug 11348: os -x - automatic update failure
* bug 11357: list view for new tab broken
* bug 11027: Changing default guide on windows: AttributeError:
  'NoneType' object has no attribute 'url'
* bug 11321: ValueError: I/O operation on closed file
* bug 6179: Wrong Language (only some work done on this one)
* bug 11360: os x r9142 - update notification is show release notes
  text.
* bug 11362: Dissmising detached external playback dialog freezes Miro
* OSX crashers and memory leaks
* probably some other things I’m missing

The new Miro Guide will be launching very soon now. When that's
released, the second browser bar you see in Miro will go away.

I've synced translations, so rc3 has the latest translations. I will
sync them one more time before we do a release. If you’re a translator,
we sure could use your help! See more at
https://translations.launchpad.net/democracy.

We think this release candidate is release-worthy. Assuming testers
don't hit any snags, there shouldn't be any changes between now and the
final Miro 2.0 release. We're planning to follow Miro 2.0 with a 2.0.1
release in the near future to get the most updated translations and to
fix minor issues that pop up.

To Ubuntu Hardy and Intrepid users: Some day I’ll get to learning how
PPA works. When that happens, we’ll start building release candidate
builds for the Ubuntu versions we support. Until then, you’ll have to
download the tarball and build it yourself. If someone can spare some
time to help us with this, I’d be much obliged.

Barring snags with this release candidate, we're looking at a full on
Miro 2.0 release some time in the next few days. Getting really super
close now!
