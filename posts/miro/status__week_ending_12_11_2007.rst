.. title: status: week ending 12/11/2007
.. slug: status__week_ending_12_11_2007
.. date: 2007-12-11 19:10:34
.. tags: miro, work

It's been a good-ish week.

Nathan finished up his changes for `bug
9077 <http://bugzilla.pculture.org/show_bug.cgi?id=9077>`__, they were
merged into the trunk and 1.0 branches, and Janet did some testing and
came up with `bugs
9334 <http://bugzilla.pculture.org/show_bug.cgi?id=9334>`__ and
`9335 <http://bugzilla.pculture.org/show_bug.cgi?id=9335>`__. I fixed
9334 but I think I'm going to skip 9335--it involves changing the
padding for those items in the item view and I'm not wildly excited
about doing that and I think the issue is cosmetic. We only implemented
CC metadata at the item scope--not the feed scope, yet.

I worked my way through some bonehead issues I had caused, finished up
the patch for `bug
303645 <https://bugzilla.mozilla.org/show_bug.cgi?id=303645>`__ and
submitted it. I'm a little apprehensive about submitting a patch to
Firefox, but ... I'll suck it up. The important thing is that this patch
populates the enclosures array for each FeedEntry item. That was a
pre-requisite for `bug
400059 <https://bugzilla.mozilla.org/show_bug.cgi?id=400059>`__. I'm
working on that one now. As a side note, the folks on ``#developer`` on
the Mozilla IRC channel have been really helpful.

On Friday, I went to lunch with Dean, Chris Blizzard and John
Resig--that was really neat. A little hard to quell the star-struck
feelings--hopefully I didn't make a total ass of myself.

I created the `"other packages"
page <http://getmiro.com/download/other.php>`__ for the `download
section <http://getmiro.com/download/>`__ of the getmiro web-site and
changed around the download page, too.

I sent an email to Justin at Mozilla in response to `his blog
entry <http://blog.mozilla.com/justin/2007/12/05/bugzilla-improvments/>`__.
I pointed him to the code for the timeline script and the script for
migrating data from Trac to Bugzilla.

Looking forward to a Miro 1.1 release with all its libtorrent and
CreativeCommons metadata goodness....
