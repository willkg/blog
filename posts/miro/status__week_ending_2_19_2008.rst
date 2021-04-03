.. title: status: week ending 2/19/2008
.. slug: status__week_ending_2_19_2008
.. date: 2008-02-20 14:26:54
.. tags: miro, work

It was a pretty slow week.

* I spent some time trying to implement
  `5403 <http://bugzilla.pculture.org/show_bug.cgi?id=5403>`__ and
  `8619 <http://bugzilla.pculture.org/show_bug.cgi?id=8619>`__ on Mac
  OSX, but then discovered that Luc must use some gui builder tool that
  I don't have. So I ended up passing those two bugs off to him.
* I spent some time doing bug triage.
* I fixed a few problems from code flux.
* I worked on
  `9521 <http://bugzilla.pculture.org/show_bug.cgi?id=9521>`__ for a
  few days. It's a lot more complicated than I thought it was partially
  because it touches sections of the code I haven't touched yet. Nassar
  thinks it's probably not something we want to bother with. I think I
  might be able to implement it, but I think it'll take a week to get
  it right. I think we should defer it to a future version.

Things I'm planning on doing this week:

* Possibly continue working on
  `9521 <http://bugzilla.pculture.org/show_bug.cgi?id=9521>`__
  depending on the call.
* The two-stage installer bug is still out there and I have access to
  pcf3 now, so I think I can solve it. I sent an email to plans
  regarding that subscribe.getmiro.com site being all kinds of
  bit-rotty and whether I should spend time fixing it, but didn't get
  any replies.
* We got a patch for bug
  `8793 <http://bugzilla.pculture.org/show_bug.cgi?id=8793>`__ for
  implementing ratio restrictions for torrents for GTKX11. The bulk of
  the patch is the glade code for GTKX11; the actual code is pretty
  trivial. I'd like to look into this and probably apply it.
* Check out Miro on Ubuntu Hardy (which is in alpha 4 now) and get a
  feel for where it's at.
