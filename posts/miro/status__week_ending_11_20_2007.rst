.. title: status: week ending 11/20/2007
.. slug: status__week_ending_11_20_2007
.. date: 2007-11-20 22:55:34
.. tags: miro, work

I spent Wednesday, Thursday, Friday and part of Saturday watching new
bugs, helping users out with 1.0 issues, continuing to build a Windows
VM (I've almost got it working again) and working on Mediabar.

I checked in a minor overhaul of Mediabar. There are two big issues with
Mediabar that need to be fixed that involve architecture changes (I've
been talking about this for a month now). I figured since I'm
overhauling the code for that, I might as well overhaul the code and fix
namespace issues and tighten up the existing architecture to make it
easier to fix the big issues. In the process of making the changes, I
noticed the flv extraction code doesn't work. I'm not sure how it's
supposed to do what it does, though, so I'm not sure if it's something I
did or something that was pre-existing or something I'm
misunderstanding. When I work on Mediabar again, I'll talk to NPR and
Dean about how it should behave and what kinds of things it should be
picking up and write it down into an ad hoc specification. On a side
note, anyone have any idea how to do agile-like development with Firefox
extensions? Where does the testing code go and how do you kick it off?

On Sunday, I got worried that I'm going to miss the deadline for the
Firefox patch I'm working on. The work is under `bug
#400059 <https://bugzilla.mozilla.org/show_bug.cgi?id=400059>`__ in the
Mozilla Bugzilla db. I spent Monday and Tuesday working on adding
enclosure detection to the FeedProcessor and then adding enclosure
support to FeedWriter so that you can see enclosure links on the feed
subscribe preview page. When I get this working, I'll submit it as a
patch against `bug
#303645 <https://bugzilla.mozilla.org/show_bug.cgi?id=303645>`__. Making
those changes paves the way towards adding support for distinguishing
between video, audio and text feeds and supporting applications for
handling those different feed types.

I will be off of email and IRC for the rest of the week but I'll be
studying.

I hope you all have pleasant holidays or work days (depending on where
you live)!
