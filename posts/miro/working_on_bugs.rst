.. title: Working on bugs: hurdles to bug squashing
.. slug: working_on_bugs
.. date: 2010-08-09 18:18:54
.. tags: miro, work, dev

There are two big hurdles to get through when starting on a bug before
I'm in a position where I can fix it. I think the bulk of the time spent
on most bugs is in getting through these two hurdles. If we could
somehow reduce the amount of time and energy I spend on getting through
the two hurdles, we can increase the speed that I can fix bugs.

|image0|

*Copyright
2008*\ `Flickr <http://flickr.com/>`__\ *user*\ `foxtongue <http://www.flickr.com/photos/foxtongue/>`__

**The first hurdle: what is the problem?**

I think most people confuse the question "what is the problem" with
"what's causing the problem". These are two distinct questions. The
first one can only be answered by whoever reported the problem and this
hurdle is a communication hurdle. I spend a lot of time trying to coach
people into explaining the problem they have in a way that's coherent
and complete.

It's not uncommon to get bug reports along the lines of "something's
wrong and Miro doesn't work". I'm psyched someone has taken the time to
report the issue, but there isn't enough detail here for me to do
anything. In order for me to do something with this bug, I spend time
walking the reporter through giving me enough details such that I have a
good idea as to what the problem is. Because this requires communicating
back and forth, this can take anywhere from a few hours to a few weeks
to transpire.

Because it takes so long and requires me to ask 20 questions, I'm pretty
sure most bug reporters find this phase very frustrating. Some question
and answer volleys are really frustrating for me, too. I want to help--I
just don't know what the problem is.

Assuming we get past that hurdle, then the second hurdle comes into
play....

**The second hurdle: what is the cause of the problem?**

This hurdle is sometimes difficult because I can't reproduce the
problem. I may not have the right context (e.g. "Problem XYZ happens to
all people in Ecuador") or the right equipment (e.g. "Problem XYZ
happens to people using Windows XP SP2 with video card Foo"). I'll read
through code and work with the reporter to try to figure out the cause.
Sometimes it works and sometimes it doesn't. When it doesn't it's really
frustrating.

Most bugs aren't like that, though. I'm able to either reproduce the
context and equipment or I'm able to use a reasonable facsimile. Then
figuring out the cause is entirely on my shoulders and I can work
through it like I do most things: code spelunking, research, Google
searches, talking with co-workers, talking with upstream developers,
....

**How can you help?**

The following helps a lot:

-  use an email address that you respond to
-  be as specific as you can in your bug report description
-  attach your Miro log file
-  be patient with me when I ask my 20 questions to figure out what the
   problem is
-  be prompt with responses--the longer it takes to turn around a
   question and answer, the longer it takes to get the bug fixed
-  thank people who help get your bug fixed: other people who comment on
   the bug providing additional details, people who worked on the bug,
   people who tested the bug fix--it takes a community to build an
   application

**Guess what....**

This isn't specific to me or Miro! This is true of all FLOSS
applications that you use: we're all working hard to build the best
applications ever. Doing the above helps everyone.

.. |image0| image:: http://farm3.static.flickr.com/2304/2402924924_4f5d30a7aa.jpg
   :target: http://www.flickr.com/photos/foxtongue/2402924924/
