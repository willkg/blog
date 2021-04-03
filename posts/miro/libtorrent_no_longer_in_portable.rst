.. title: libtorrent out of portable
.. slug: libtorrent_no_longer_in_portable
.. date: 2009-11-02 22:47:30
.. tags: miro, work, dev

Miro uses
`libtorrent-rasterbar <http://www.rasterbar.com/products/libtorrent/>`__
for bittorrent downloading. We had a copy of the libtorrent source code
in the ``portable`` section of our repository. Miro would compile
libtorrent as a Python extension along with all the other stuff to build
Miro binaries. Not any more.

Luc is almost done carrying my changes over to OSX 10.4, but as of
today, libtorrent-rasterbar is no longer in the ``portable`` section of
our repository.

What does this mean?

For Windows, a clean build on our Windows build box went from taking
enough time for me to make dinner, eat dinner, and then completely
forget what I was working on (26 minutes) to 4 minutes. In my Windows XP
vm, a clean build went from 8 minutes to 1 minute. Plus I fixed the
unicode problems Miro had with Windows and libtorrent and updated Miro
to use libtorrent 0.14.6 on Windows.

For OSX, a clean build on my mac mini running OSX 10.5.8 went from 17
minutes to 1 minute. Plus I updated Miro to use libtorrent 0.14.6 on
OSX, too.

For gtk-x11, libtorrent is now a required system package. Miro will no
longer compile its own libtorrent if you don't already have it
installed. I'm pretty sure that most modern versions of the major Linux
distributions have packages for libtorrent-rasterbar and the Python
bindings.

We have a couple of other changes that affect the project structure
almost done. I'll blog about them as they finish landing.

**Updates:**

11/4/2009 This is completed now. Many thanks to Luc who sorted out the
issues I was running into with compiling libtorrent on OSX 10.4 with
Boost 1.35.0.
