.. title: New Windows build environment
.. slug: new_windows_environment
.. date: 2010-08-13 16:38:02
.. tags: miro, work, dev

I spent a good amount of time over the last few months migrating Miro on
Windows to a new Windows build environment that uses Python 2.6.5 and
Visual C++ 9.0 (part of Visual Studio 2008).

I landed the changes two weeks ago. Janet, Ben and I identified a couple
of problems and sorted those out. Last week I got the Windows build box
to produce nightlies without requiring any babysitting.

Yay!

Features of the new Windows build environment:

#. It's a lot easier to configure. Previously, we had to set PATH,
   INCLUDE, and LIB environment variables to the right magic values to
   build correctly. Python 2.6 automatically pulls those values from
   Visual Studio 2008 files. So we don't need to deal with those
   anymore.
#. It uses Visual C++ 9.0 (Visual Studio 2008) rather than VC++ 7.1 (VS
   2003). The latter can no longer be acquired legally (thank you MS).
   There's an Express version of the former available on the Microsoft
   site for free.
#. We were using Python 2.5 which had a bunch of bugs we had workarounds
   for. We're now using Python 2.6.5 which doesn't have these issues and
   also has a series of optimizations that should make Miro run better.
#. There's a ``get_requirements.sh`` script that downloads the versions
   of Python and libraries that you need automatically.

This also means that we can require Python 2.6 or later on all platforms
for Miro. Therefore we can:

* fix try/except blocks http://www.python.org/dev/peps/pep-0352/
* use with and contexts
  http://docs.python.org/release/2.6.5/whatsnew/2.6.html#pep-343-the-with-statement

The one thing we still want to do is upgrade from gtk 2.16 to gtk 2.20.
`Bug 14037 <http://bugzilla.pculture.org/show_bug.cgi?id=14037>`__
covers the problems here. We're blocked by `Bug
625972 <https://bugzilla.gnome.org/show_bug.cgi?id=625972>`__ in gtk.

I've written up instructions on setting up the new Windows build
environment. It takes me about 30 minutes to do--mostly because it takes
a while to install Visual C++ 9.0 Express. It's much easier to set up
the new environment than the previous environment. When I first started
at PCF a few years ago, it took me a couple of days to get the Windows
build environment working.

For more details on the new Windows build environment, see `the wiki
page on
WindowsBuildDocs <https://develop.participatoryculture.org/trac/democracy/wiki/WindowsBuildDocs>`__.
