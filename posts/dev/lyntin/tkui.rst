.. title: Tk is irksome
.. slug: tkui
.. date: 2003-01-07 01:08:12
.. tags: dev, lyntin, python

So for some reason (and I haven't done enough research to even
describe the problem adequately) Tk in Python 2.2.2 will hang
(the entire Python process) when you go futzing around with the
members of whatever you get back from ``Tkinter.Tk()``.
It only seems to have this problem on Windows 2000 and Windows XP.
No one has mentioned issues on other platforms.

Anyhow, so I was going to do a version release this last weekend
(that would be January 5th), except now I have to go puzzle through
why Tk is being so twitchy.
