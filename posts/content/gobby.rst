.. title: Gobby - collaborative editing and group projects
.. slug: gobby
.. date: 2006-03-17 17:37:54
.. tags: content, software

I have two classes this semester both of which involve group projects.
Since the members of my groups are spread out across the MassBay area
and we all have very different schedules, it's been hard to come
together in one central place to do group work and have meetings and
such. No one else in the group has done any open source or decentralized
development, so that's adding to the complexities. On top of that, we've
got a couple of different operating systems involved.

We started doing meetings and document-editing together using
`Gobby <http://gobby.0x539.de/>`__. It has some minor syntax
highlighting that helps, but more importantly, it allows us to talk
using an irc-like pane on the bottom while editing a series of documents
together in real time.

One of the problems I'm having with it is that I want to add Scheme
syntax highlighting (not that there's much in the way of "syntax" in
Scheme). I can't figure out where it would go, though. It's either
handled by one of the libraries that Gobby uses or it's somewhere in the
code and I just haven't found it yet.

The other problem I'm having is that it only allows you to edit
text-based documents. I do realize that anything else would be wildly
difficult. Still, it'd be nice to be able to "share" other artifacts
other than text-based documents even if we couldn't all edit them. Right
now we're iterating over other files by checking them into CVS and doing
CVS update and also just sending things around by email.

Anyhow, it's definitely been really useful.
