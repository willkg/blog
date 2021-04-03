.. title: status: week ending 1/15/2008
.. slug: status__week_ending_1_15_2008
.. date: 2008-01-15 18:49:18
.. tags: miro, work

It was a really busy week--I essentially worked for the last 7 days
straight. It's been a good/bad week for me. I:

* pushed out the `Miro 1.1 release on
  Thursday <http://www.getmiro.com/blog/2008/01/announcing-miro-11-dramatically-faster-bittorrent/>`__
  which had some minor release-engineering issues (I forgot the
  symlinks for Miro.dmg, the appserial number is 20080101000 but should
  have been 20080110000, and Feisty and Dapper won't build)
* I updated the instructions for releases in the wikis which improves
  the release process going forward
* I spent Thursday night, Friday and most of Saturday investigating the
  segfaults with the Dapper and Feisty packages and traced it down to
  the fix for `bug
  9373 <http://bugzilla.pculture.org/show_bug.cgi?id=9373>`__
* I backed out the fix for `bug
  9373 <http://bugzilla.pculture.org/show_bug.cgi?id=9373>`__--I'll
  release Feisty and Dapper packages when we "release" Miro 1.1.1
* I worked on the Firefox patch work for `bug
  400061 <https://bugzilla.mozilla.org/show_bug.cgi?id=400061>`__
* I made some more changes to the patch for `bug
  303645 <https://bugzilla.mozilla.org/show_bug.cgi?id=303645>`__, it
  was reviewed, and it looks like it's on its way to Firefox 3
  (assuming all goes well)

I'm going to spend the next week:

* aiding Paul with the Miro 1.1.1 release
* continuing the work on `bug
  400061 <https://bugzilla.mozilla.org/show_bug.cgi?id=400061>`__ and
  friends
