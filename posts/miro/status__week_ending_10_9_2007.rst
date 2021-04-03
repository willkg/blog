.. title: status: week ending 10/9/2007
.. slug: status__week_ending_10_9_2007
.. date: 2007-10-09 21:04:08
.. tags: miro, work

It's been a really really busy week. I put Mediabar down and played
catch-up with Miro and infrastructure.

I fixed (or at least think I fixed) a few UDE-type errors (#8705, #8706,
#8699, #8820, #8737), passed a bug to BDK, passed a bug to Chris, and I
think I may have passed a bug to Nassar, too.

We didn't previously have any official policy regarding contributions
from non-PCF employees. I spent some time putting together a policy for
handling code contributions and also for checking code into the SVN
repository. I've talked with Ben and Chris about it so far and ironed
out some issues. I think it's pretty decent now.
https://develop.participatoryculture.org/trac/democracy/wiki/TheRules

I spent some time going through all the code and adding GPL/Copyright
headers to files that didn't already have them. I haven't done this to
XML, XUL, or DTD files--I think I'm going to leave them be. Part of the
reason is that there are a lot of them. The other part of the reason is
that they're in a bunch of different markups and I'm not wildly psyched
about trying to jam GPL/Copyright headers into them in such a way that
it doesn't screw up how those files are used in the code.

I finished up an "alpha" version of the timeline script for Bugzilla. It
needs some more work and it has some bugs, so it's not quite ready for
prime time. I hope to have this done by the end of the week, but finding
time to work on it has been difficult.

Dean is talking to contarc/Jay about skinning Bugzilla and making other
changes. In order for that to work well, I needed to re-work things so
we can manage the changes we're making to Bugzilla better. I spent today
fixing my changes to meet the `Bugzilla recommended method for
changes <http://www.bugzilla.org/docs/3.0/html/customization.html>`__
and checked everything into SVN.

It'll be really nice to have a better Bugzilla, but we need to make sure
that it meets the needs of the developers and testers as well as the
rest of the community. I've heard a lot of opinions about what it should
and shouldn't look like and that concerns me. While we're pushing to get
Miro 1.0 and Mediabar 1.0 out the door, I don't think we should be
spending gobs of time on changing minor things in Bugzilla unless the
changes are necessary to fix some real problem we all agree exists.

On Sunday, Dean, Chris and I met up with Asheesh from Creative Commons
and SJ from OLPC and talked about the world as it revolves around Miro
and other things. It was really interesting stuff, but also pretty
overwhelming. Then we went to a GNOME Summit bar thing.

I'm planning on switching back to Mediabar stuff tomorrow (Wednesday). I
need to finish the tab-friendly re-architecture and I need to figure out
how to deal with the recent rss-download issue Neil bumped into. Then
there's a lot of little stuff that needs to be done. My rough guess is
that I'll be working on Mediabar for another couple of weeks with some
time spent on Miro and Bugzilla.

I think I'm going to lay low on IRC for the next week--I need to be
talking less and doing more. My queue of things to do is starting to get
too big for me to wrap my head around and I'm starting to feel a bit
overwhelmed.
