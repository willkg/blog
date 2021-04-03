.. title: status: week ending 12/18/2007
.. slug: status__week_ending_12_18_2007
.. date: 2007-12-18 22:19:50
.. tags: miro, work

I submitted a new patch for `bug
303645 <https://bugzilla.mozilla.org/show_bug.cgi?id=303645>`__ on the
12th. On the 13th, I started having problems seeing the feed preview
page. I talked with the folks on ``#develop``, but wasn't able to get it
working. No clue what the problem is. I did a fresh checkout on a
different machine and that works fine, so I continued working on the
second machine and produced a better version of the 303645 patch. I'm
gone next week and between that and the time I'm going to have to put
into the 1.1 release, I don't think I will get a patch together for the
rest of the changes for `bug
400059 <https://bugzilla.mozilla.org/show_bug.cgi?id=400059>`__.

Firefox takes me about an hour to compile from scratch. While trying to
figure out what my feed preview page problem was, I spent some time
using the reports feature in Bugzilla and doing bug triage on old bugs.
I also wrote a script to remove comment spam from the comments we
migrated from our old Trac bug-tracker. There's still a lot of comment
spam in there. Ick.

I merged the libtorrent changes from trunk to the 1.0 branch and tested
out the GTKX11 platform. I went through Ubuntu Gutsy, Gutsy-64, Feisty
and Dapper, made sure Miro in the 1.0 branch compiled and updated the
requirements as listed in GTKX11BuildDocs.

I tried to test the 1.0 branch of Miro in Windows, but I'm hitting the
LIBEAY32.dll problem in `bug
9327 <http://bugzilla.pculture.org/show_bug.cgi?id=9327>`__ and the fix
suggested in the comments isn't working for me. So... my Windows build
environment isn't working again and I don't know whether the 1.0 branch
is stable or not after the merges I did.

That about covers me for this last week.

In the next few days, I plan to help out with the 1.1 release, make sure
I have the Ubuntu platforms covered and continue working on the Firefox
patch.

I'm gone from December 23rd through December 31st. After December 22nd,
I won't be online again until January 1st.
