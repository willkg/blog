.. title: tkui is all cleaned up
.. slug: tkui2
.. date: 2003-01-10 23:51:21
.. tags:  dev, lyntin, python

I broke out my Programming Python (2nd Edition) book and doubled
my Tk knowledge in the space of an hour or two.  I went through
the tkui and fixed up a lot of issues involving thread contention.
The tkui should be more stable now, titlebar manipulation works
again (through the settitle(...) method), NamedWindows work, I
fixed the Autotyper, and I went through and cleaned up the code
while I was at it.  All in a good night's work.

This was the last big issue I needed to solve before releasing
3.1 which has some sweeping fixes in it.
