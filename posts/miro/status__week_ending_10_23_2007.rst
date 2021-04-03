.. title: status: week ending 10/23/2007
.. slug: status__week_ending_10_23_2007
.. date: 2007-10-23 22:26:12
.. tags: miro, work

I got a Mozilla Bugzilla account and commented on the bugs that Alex
Faaborg created to track changes we want to make for Firefox 3.0. We've
got a couple of months to do the changes, but Alex said that Chris said
that he'd like to see it as an extension first. I'm not sure we can do
that, but I plan on looking into it.

I spent an hour finishing up the Bugzilla timeline script that I've been
working on over the last month or so and made it public. You can see it
at http://bugzilla.pculture.org/timeline.cgi.

I spent a day or so pushing out rc0 and honing our ReleaseProcess
documentation. I also did a pass through our bugs for low hanging fruit
that we've been sitting on after looking at the LaunchPad bugs for Miro.
I had problems with the Windows build machine which Matt helped me
through.

Then I wrote some blog entries about our Gutsy situation so that users
and developers knew what the status was. I worked on the gutsy
packaging. BDK and I had an svn issue where he did an ``svn cp ...``
(r5515) and that wiped out my changes (r5512, r5513, and r5514). We're
not entirely sure what happened.

I conversed with an unhappy and frustrated user who doesn't like that
we've set up Miro to conflict with ``sun-java6-plugin``. No one thinks
it's an ideal solution, but it's the best one we've got right now. After
talking about it on ``#miro-hackers``, BDK created a bug to revisit the
java plugin situation for 1.0. I'm going to see if I can find anyone at
Mozilla that would know whether you can embed gtkmozembed without the
plugins (I think that's the right question to ask--if not, poke me). The
current consensus is that there's nothing we can do, but it sure would
be nice to find out that we're wrong and the magic pixie in the sky can
come down and make the problem go away.

Earlier today we released 0.9.9.9-rc0 gutsy package in a new gutsy
repository. It's my first packaging experience. Our ``README`` for it is
really good; I made some minor updates while I was fiddling with things.

Also, I thought PodCamp was last weekend--turns out it's next weekend.
That was confusing. I figured it out after traveling on the T, getting
there, puzzling about why no one else was there, calling my wife to see
if I was in the wrong place, sighing deeply when I found out I'm at the
right physical location but the wrong chronological location, and then
taking the T home. The good thing that came out of this is that I got to
test my raincoat which I had just waterproofed--it works pretty well.

I spent Sunday upgrading my laptop from Feisty to Gutsy and trying to
reproduce some of the gutsy bugs we've got--I haven't been able to. It's
likely there are other things involved that I'm not aware of yet.

I'm going to spend some time to upgrade my desktop to Gutsy as well and
then build virtual machines for Dapper, Feisty and Gutsy. So then we'll
have another person who can cover Ubuntu releases and testing and such.

**Updates:**

10/24/2007: I forgot to talk about the Mediabar Firefox extension... I haven't
touched it in at least two weeks--possibly more.  It has some big issues that
need to be figured out, but I've been spending time on other things. I do want
to get it fixed up because it is a useful extension. I'll try to find some time
for it in the next week or so.
