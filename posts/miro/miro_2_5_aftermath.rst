.. title: Miro 2.5 post-mortem
.. slug: miro_2_5_aftermath
.. date: 2009-08-07 21:57:42
.. tags: miro, work, dev

We released Miro 2.5 a couple of weeks ago and it was a messy release
which resulted in a Miro 2.5.1 a day or two later and a Miro 2.5.2 a few
days after that. It sucked. I wish it had been better.

Before a release has happened, a messy release looks like any other
release: development has wound down, lots of bugs have been fixed, a
bunch of new features have been implemented, testing is going well,
people who have looked at the nightlies and release candidates like the
new features and haven't encountered any issues, ... Then we decide to
pull the trigger and push it out.

It's only when a release is out that the messy release rears its ugly
head and the obviousness of its messiness is revealed. Usually this is
made abundantly clear by abusive emails from people who encounter
problems with the release, become frustrated, and express themselves
with abusive vitriol aimed at me and all the other people who worked
hard on the release.

It's at this point, I bite the bullet, prepare for the world of pain I'm
about to get involved in, and try to reach out to as many people as I
can, gather information to identify the issues so that we can fix them,
and provide support to people who are encountering problems to enable
them to get through them.

So what the hell happened with Miro 2.5?

Miro 2.5 started out with a big flaw: there was no upgrade dialog
showing when Miro was transforming the database from the old style to
the new style. If you have a small database like mine (8 mb), you'd
never notice. People who had huge databases would launch Miro 2.5 for
the first time and ... seemingly nothing would happen for minutes. The
person would assume Miro isn't starting, would kill the process, and
then try again. At this point, Miro would see a wedged database and
wouldn't start. We think there were on the order of 30,000 downloads at
this point and we had maybe 50 people who had problems.

We recognized the problem and we kicked into emergency mode. Janet and I
worked the GetSatisfaction forums, blog, and identi.ca. Ben poured over
the incoming data, made a few fixes and put in a progress dialog. We
pushed out Miro 2.5.1. Janet and I went through and talked to each user
who had problems to help them unwedge their database and get back to a
working Miro.

A day or two later, we found another couple of problems. I made some
fixes and pushed out Miro 2.5.2. Then I wrote a script people could run
to re-download data that was lost. Dataloss totally sucks. We did
everything we could to help alleviate the problem after we found out it
was there.

There are still a bunch of people for whom Miro doesn't work. I'm
talking with a few of them. Others have given up. It's always been the
case that there are people for whom Miro doesn't work and we do what we
can to figure out the causes.

And that's where we are now.

Going forward, we're going to figure out how to better test Miro release
candidates. We thought that 600 people would have fleshed out most of
the issues, but it seems that there are classes of people whose usage
patterns aren't reflected in our testers and testing. If you can help us
with testing, we'd love to have you. You will have a direct impact in
making Miro better.

Going forward, I'm going to work on making it easier for Miro to help
people identify problems and let us know. I'd also love to get some help
fixing Miro so that it doesn't lose data when things go wrong. Code
contributions would help a ton here.

Going forward, I'm going to ask for help more often. There are only 4
PCF developers and we're spread very thin between Miro, Miro Guide, Miro
Community, and the other things we're working on. We need your help.
This isn't a new situation. What is new is that I'm going to do a better
job making it explicit what I need help with right now.

I love working on Miro. I love what Miro is doing for people and for
communities. I love our mission. I need your help to help me help you.
Miro is your project as much as it is mine.

I hope the initiatives we're working on will eliminate messy releases in
the future.
