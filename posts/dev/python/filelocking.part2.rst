.. title: File locking in Python--help! (part 2)
.. slug: filelocking.part2
.. date: 2004-07-02 15:02:52
.. tags: dev, python

I got a bunch of really helpful responses from my previous entry 
and I'm pretty sure that my problems were two-fold: my code was missing 
some stuff (the code I posted and what I actually had were different--go 
figure) and my testing program had a bug (or two or three).

Anyhow, my knowledge of file locking on Linux (and possibly other Unixs)
is pretty abundant now (or so I think).  This helped to fix a problem I had 
at work as well (not the file locking part, but the thing I needed file 
locking for helped me at work).

Python has the ``fcntl`` module which has a ``flock`` and ``lockf``.  I'm not
entirely sure what the difference is, but there are man pages on both functions
as the Python versions call their C counter-parts.

There's a good article on file locking that might be located at
``/usr/src/linux/Documentation/mandatory.txt`` (though it wasn't on my system--a
Google search helped me out) that's pretty interesting.  Also, there's
explanations of file locking between processes and the issues involved in
*Advanced Programming in the Unix Environment* and *Linux
Application Development*.

My specific issue was with Exim and PINE.  Both have documentation as
to how they lock mbox files before playing with them--things a Google
search reveals without much effort.

Anyhow, I'm pretty sure my code works now.  I'll do some more sophisticated
testing this weekend to make sure everything is fine.

Thanks to Chris, Jason, John and Lance for their help.
