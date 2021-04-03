.. title: Gutsy package for Miro status
.. slug: gutsy_package_for_miro_status
.. date: 2007-10-19 16:08:15
.. tags: miro, work

Here's the current state of Miro on Gutsy:

* we don't have a Gutsy package of Miro for 0.9.9.1 (the current
  release)
* Gutsy does work with what will become Miro 0.9.9.9 (the very
  soon-to-be released release)

The first Miro version we plan on supporting for Gutsy is 0.9.9.9 which
will be released soon--probably in the next week if all goes well. We
have been testing with Gutsy over the last month and we have
`instructions for building Miro on
Gutsy <https://develop.participatoryculture.org/trac/democracy/wiki/GTKX11BuildDocs>`__
in Trac. I want to emphasize that Miro 0.9.9.9 will work nicely on Gutsy
and the primary issue here is a packaging one.

The Gutsy universe repository has a Miro 0.9.8 package in it. I've
tested it on my Gutsy box and it works for me, however it's missing a
lot of the fixes that we've made for 0.9.9.9 which should alleviate
problems with Miro and specific video cards. So if it works for you,
then that's great, but if it doesn't, then you're going to have to wait
until 0.9.9.9.

I plan on making a pass through
`Bugzilla <http://bugzilla.pculture.org/>`__ and make sure any
outstanding Gutsy issues are resolved. Additionally, I'll take a pass
through `LaunchPad <https://launchpad.net/ubuntu/+source/miro/+bugs>`__
and make sure we catch any bugs that didn't get reported upstream to us.

We'll be tagging our repository for 0.9.9.9 rc1 soon--hopefully today
and have an rc1 out by tomorrow for Windows and Mac OSX. We'll get a
Gutsy rc1 out as soon as we can, but it'll probably take a few days.

If you want to help out with testing rc1, let me know and I'll be sure
to point you in the right direction and/or watch the `Miro Testing
blog <http://pculture.org/devblogs/mirotesting>`__.

If you have any problems, please write up a bug in
`Bugzilla <http://bugzilla.pculture.org/>`__, comment on an existing bug
with additional information, and/or hop on ``#miro`` on
``irc.freenode.net`` and let us know.

If you have any thoughts, please comment here and if the plan changes at
all, I'll post an update.

As an aside, Gutsy is a great Ubuntu release--I'm running it on one of
my machines already and look forward to upgrading my other machine.
