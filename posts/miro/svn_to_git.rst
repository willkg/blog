.. title: Subversion to git transition
.. slug: svn_to_git
.. date: 2009-08-15 22:26:59
.. tags: miro, work, dev

We're switching the Miro repository from svn to git. This frees us up
considerably and will make development life a lot easier for us. We
chose git over other dvcs systems because most of us were already using
git-svn to access svn and we're already using git for Miro Guide, Miro
Community, Miro Fullscreen and other projects.

For the last week or so, I've been converting the Miro svn repository to
git. It's taken a long time because I ran into several complications:

#. I've been moving from an apartment to a house which sucked up a few
   days.
#. We treated tags in svn like branches: we'd tag a release, then make
   some adjustments "in the tag". Tags in git are immutable which is a
   good thing--they should be immutable. I've spent a bunch of time
   figuring out how to convert our svn tags into git tags and tweak the
   history accordingly. It takes around 20 minutes to fix each instance
   of the problem and there were a lot of instances of it--one for each
   release, release candidate, beta, .... Many many thanks to James Vega
   for helping me out on this.
#. I'm running out of disk space on my laptop. I've had to do some
   archiving to free up space and that's taken a while.

Hopefully, I'll be done in the next day or so. Once I finish, I'll push
the new git repository to a public space, have the other devs run
through it for issues, post a message about it on the develop mailing
list and then I'll start work on changing build scripts and other things
like that to use the git repository rather than the svn one.

One thing that's happened as a result of this work is that I've really
come to appreciate git internals and how it's all structured. I have no
idea how Bazaar and Mercurial structure things, but git's pretty neat.

**Updates:**

8/17/2009: My math was way off. I've got another 50 tags to go at
20 minutes per tag that's at least another couple of days.
