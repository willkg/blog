.. title: regular expressions in highlights and telnet control handling
.. slug: updates
.. date: 2002-12-27 11:32:13
.. tags: dev, lyntin, python

I fixed some issues with telnet control handling which were borked.
I also adjusted some things so that we show up more favorably on the
`Cryosphere mud client support table <http://www.cryosphere.org/telnet>`_
after talking with the maintainer of that table.  I may look
into adding some more features based on that table--like NAWS support.
The existing problem is that for the textui, I can't seem to determine
what the LINES/COLS numbers should be if you're running Lyntin over
telnet/ssh.  I'm tossing around adding hooks for telnet control
negotiation and changing the MudEcho handling to use this hook instead.
That'd open up the possibility of creating something like a wxPython
ui which is completely xterm compliant.  I have to toss this around a bit
more.  I also want to enable logging of incoming telnet control code
sequences so I can see what's going on.

I finally added Sebastians patch for regular expressions in highlights,
though I made some adjustments to account for the current codebase
(the patch was from like 6 months ago or so) and also to use our
regular expression syntax instead of a toggle on the Session.

It's slick!  The regular expression implementation is also faster than
my original string.find implementation.  Doing something like this::

   > #highlight red e
   lyntin: highlight: {red} {e} added.
   > #highlight green i
   lyntin: highlight: {green} {i} added.
   > #highlight blue a
   lyntin: highlight: {blue} {a} added.

doesn't tax Lyntin as much as it did with the string.find method.  I 
kind of wish I had done this a few months ago, but didn't really get
around to putting in the time to figure out what needed to be done.
I think I'm going to overhaul substitutes/gags in the same way next.
