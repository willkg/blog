.. title: MozRepl
.. slug: mozrepl
.. date: 2007-09-29 11:51:02
.. tags: miro, work

I've been doing Firefox extension development and it's been going pretty
slowly because it's hard for me to figure out what's going on when
things are running (and I'm not wildly familiar with the things I'm
working with).

After whining about how I wish there was a REPL for JavaScript, I did a
Google search and came across
`MozRepl <http://dev.hyperstruct.net/mozlab/wiki/MozRepl>`__. It's
helping a lot so far. I'm not spending hours hunting for object
documentation anymore.

On an interesting note, you connect to MozRepl with telnet and it has a
line-mode interface. Turns out that
`Lyntin <http://lyntin.sourceforge.net/>`__ (a mud client I worked on
years ago) works fantastically for this. I would assume most mud clients
would because at heart they're line-mode telnet clients with a bunch of
features designed to remove repetition in common tasks and make it
easier to skim large amounts of output quickly without having to read
through all of it.
