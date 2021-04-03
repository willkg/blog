.. title: status: week ending 11/13/2007
.. slug: status__week_ending_11_13_2007
.. date: 2007-11-14 14:21:16
.. tags: miro, work

I did a bunch of release-management stuff, some minor bug triage work
and some minor Gutsy work.

I passed a bunch of email back and forth with
`BDK <http://pculture.org/devblogs/bdk>`__ and James regarding problems
between Miro and the sun-java*-plugin packages on Gutsy and Feisty (`bug
8444 <http://bugzilla.pculture.org/show_bug.cgi?id=8444>`__ and now `bug
9064 <http://bugzilla.pculture.org/show_bug.cgi?id=9064>`__). BDK looked
into it further but in the end either the test we're using to determine
whether the problem exists or not is bogus or we didn't fix the issue.
Regardless, after much discussion it was decided that the package
conflicts were worse than the problem so we removed the conflicts for
1.0 final.

I got in touch with Dean's friend Ben (not to be confused with BDK or my
brother Ben), and he and I are going to go through our Gutsy and Feisty
packaging and fix any outstanding issues (like `bug
8716 <http://bugzilla.pculture.org/show_bug.cgi?id=8716>`__). I think
this is pretty cool and hope that this is the first of many Boston-area
Miro hack-fests.

I also worked on Mediabar. I've been doing a pass at cleaning up
namespace issues and code cleanup. After I'm done with that, I'll work
on the tab rearchitecture and the rss discovery problems. Neil and I
traded some email and he's eager to work on things again. I'm currently
the bottleneck on further Mediabar progress--I'll be spending the rest
of the week fixing that. I want to get back to working on the Firefox
patch, too and get that done ASAP.

On a side note, I was selected for the `Nokia n810 device
program <http://maemo.org/news/announcements/view/500_fortunate_applicants.html>`__.
I want to look into porting Miro over to the device and do some other
development, too. It'll be a good system for figuring out how Miro could
work on "smaller devices" and what a slimmed down version of Miro can
do. I also want to look into what it would take to get Miro working with
Conduit so that Linux users can move video content to their n810 and
other portable video playing devices.

As a side note, I live in Somerville, MA. If anyone (users, testers,
developers, ...) is interested in getting together to triage bugs,
working out issues, fix problems, add features, ... let me know. I'm
totally game for hack-fests and getting together.
