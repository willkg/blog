.. title: Miro 2.0 rc2 released!
.. slug: miro_2_0_rc2_released_
.. date: 2009-02-02 17:23:53
.. tags: miro, work

I tagged and built Miro 2.0 rc2 builds and placed them in the sticky
section of `the nightlies page <http://pculture.org/nightlies/>`__.

Pre-release release notes are at
https://develop.participatoryculture.org/trac/democracy/wiki/2.0ReleaseNotes.

Changes since rc1:

* updated translations as of today
* bug 11260: hover controls on OSX
* bug 10552: memory leaks in Windows
* bug 10299: re-enabled DailyMotion search (but it downloads 80x60 flv
  files so it still sucks)
* bug 11269: audio visualisation still present when playing video on
  Windows
* bug 11178: interface "hangs" when playing audio files
* bug 11272: removing folders dialog didn't show information about
  child feeds
* bug 11267: errors when searching on OSX
* bug 11266: videos play on OSX after dragging a video file onto Miro
* bug 11275, 11301: toolbar for watched folders no longer shows
  irrelevant functionality
* bug 11268: fix the save resume time functionality in regards to
  videos that have finished playback
* bug 11291: make sure pop in/out label is hidden/shown along with icon
* probably some other things I'm missing

When we release Miro 2.0, we'll also be releasing a new version of the
Miro Guide web-site. Amongst other things, this will remove the second
browser bar that you see.

Also, prior to releasing Miro 2.0, I'll sync translations from
Launchpad. If you're a translator, we sure could use your help!
https://translations.launchpad.net/democracy

There are still some outstanding issues that are blocking Miro 2.0, so
we're still working. You can see the existing set of bugs to fix
`here <http://bugzilla.pculture.org/buglist.cgi?query_format=advanced&short_desc_type=allwordssubstr&short_desc=&product=Miro&target_milestone=2.0&long_desc_type=substring&long_desc=&bug_file_loc_type=allwordssubstr&bug_file_loc=&status_whiteboard_type=allwordssubstr&status_whiteboard=&keywords_type=allwords&keywords=&deadlinefrom=&deadlineto=&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&priority=P1&emailassigned_to1=1&emailtype1=substring&email1=&emailassigned_to2=1&emailreporter2=1&emailcc2=1&emailtype2=substring&email2=&bugidtype=include&bug_id=&votes=&chfieldfrom=&chfieldto=Now&chfieldvalue=&cmdtype=doit&order=Reuse+same+sort+as+last+time&field0-0-0=noop&type0-0-0=noop&value0-0-0=>`__.

To Ubuntu Hardy and Intrepid users: Some day I'll get to learning how
PPA works. When that happens, we'll start building release candidate
builds for the Ubuntu versions we support. Until then, you'll have to
download the tarball and build it yourself. If someone can spare some
time to help us with this, I'd be much obliged.

Almost there!
