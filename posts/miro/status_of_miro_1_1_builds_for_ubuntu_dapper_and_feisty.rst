.. title: status of Miro 1.1 builds for Ubuntu Dapper and Feisty
.. slug: status_of_miro_1_1_builds_for_ubuntu_dapper_and_feisty
.. date: 2008-01-15 19:20:50
.. tags: miro, work, ubuntu

I haven't put Dapper and Feisty builds for Miro 1.1 into the repository
yet. The Gutsy builds are there, but there are some issues with
segfaulting when watching videos with them. I've only heard about Gutsy
segfaulting with Miro 1.1 from one person and there aren't any new bugs
for the issue. From that I'm guessing the issue is pretty limited
user-wise, but don't really have a good way to measure.

The last few days went like this. We did a Miro 1.1 release on Thursday
and I started building Ubuntu builds for Dapper, Feisty and Gutsy that
afternoon using the new pbuilder-based scripts I've been working on. The
pbuilder-based scripts are great in that I can automate building
packages for Dapper, Feisty and Gutsy for i686 on a single machine (no
longer need VMs) and they verify the build-depends lines in the .dsc
files. That'll make building from source possible.

The problem with Miro 1.1 is that the switch from BitTorrent code to
libtorrent code causes compiling to take longer. Additionally, the
pbuilder-based scripts pull down all the dependencies and build the
environment to do the build in for each distribution and that takes a
while, too.

When working on builds, I had problems with the Dapper and Feisty builds
segfaulting when playing videos during testing. I first blamed the new
build scripts. I spent 8 hours or so fiddling with them, verifying all
the build steps, and eventually running them in the distribution VMs I
had. On Saturday, I decided that theory wasn't a good one.

I tried a few other things and then started bisecting the svn changes
since Miro 1.0 in my Feisty VM to see if I could find the checkin that
caused the problem. After a few more hours, I discovered that it was a
change to xine_impl.c that I made for `bug
9373 <http://bugzilla.pculture.org/show_bug.cgi?id=9373>`__ that causes
the segfaults when viewing videos. Another hour later and I verified
this is the same problem with the Dapper build.

I backed out that change and re-ran and re-tested everything.

In summary, the pbuilder-based scripts are fine and backing out that
xine_impl.c fix fixes the issues I was seeing.

We're working on a Miro 1.1.1 release that has some changes that allow
for co-branding. We decided to push these changes off to 1.1.1 so that
we could release Miro 1.1 a week earlier. I decided that I'd skip builds
for Feisty and Dapper for Miro 1.1 and instead do builds when we
released Miro 1.1.1 this week. That should happen in the next day or so.

I really apologize for the current situation. It was a confluence of
several circumstances that led to me taking a long time to figuring out
the cause of the problem which sucked.

I should have 1.1.1 builds of Gutsy, Feisty and Dapper out by Friday
night if not sooner.
