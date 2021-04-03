.. title: It's 2:30pm--do you know what your laptop is doing now?
.. slug: stillcompiling
.. date: 2003-10-07 14:42:07
.. tags: gentoo, computers

I know what my laptop is doing.  It's compiling Xfree86.  I figured I'd 
do an ``emerge rsync`` and an ``emerge -uD world``
yesterday.  I let it run through the night and when I awoke this
morning, it was still chugging through XFree86.

I must admit, it's really awe-inspiring thinking about how much code
is involved and how long it takes to compile it.  It makes one
think seriously about the::

   code  ->  compile  -> examine issues -> fix code
                ^                            |
                |                            |
                 ------------<---------------


methodology.  Fixing a bug that way on my laptop would take weeks.
When I was in college, I would tutor CS 1 and CS 2.  It was difficult
to watch people do theme-and-variations programming with syntax
"Maybe I should add a ; here?...  Nope.  How about an extra \*?...
Nope--that didn't work either.  How about ( ) around this?...  Nope..."

Then I would point out, "Um--this would never work.  Remove that extra
\*."

And they would say, "Nope--that won't work because it segfaults." Then I would
sit there and try to explain why the two things are completely different issues
and all I'd get back would be vacant looks.

That seems like a tough place to be in.
