.. title: Reducing complexity for 2.6
.. slug: reducing_complexity
.. date: 2009-11-18 18:31:21
.. tags: miro, work, dev

We've been working on reducing the complexity of the code for Miro 2.6.
We've done this in a few different ways and I want to summarize them
here.

**moved binary kit stuff to separate repositories**

This dropped the size of the git repository for miro a lot. Cloning the
repository is much faster now. Plus it's easier to build Miro on Windows
and OSX from the source tarball.

**moving libtorrent out of portable**

On Linux, this allows us to rely upon Linux distributions to have
packages for libtorrent (the Rasterbar version) and the Python bindings.
We don't need to compile libtorrent as part of the Miro build process
anymore. That dropped the build time like a rock, reduced the tarball
size, and removed a bunch of issues from configuring and compiling Miro
on Linux.

**removing sorts.pyx and fasttypes.pyx**

Removing these allowed us to remove the build dependency on Boost. That
removes a bunch of assy code we had in the setup.py file. This also
reduced the time it takes to build Miro on Linux.

**adjustments to setup.py to be more whiny when things are missing**

I added some code to the gtk-x11 setup.py to make it clearer when it's
missing build dependencies. I then tested this on Kubuntu Karmic, Fedora
12, and OpenSUSE 11.2. Miro will still try to run if it's missing
things--I'll look into this soon.

**updated gtkx11 build docs**

I went through and updated the build recipes in the `gtk-x11 build docs
page <https://develop.participatoryculture.org/trac/democracy/wiki/GTKX11BuildDocs>`__.
I updated the recipes for Ubuntu Karmic, added recipes for Fedora 12 and
OpenSUSE 11.2 (though it won't work because I couldn't find a libtorrent
rasterbar package), and removed a bunch of old recipes that would never
work. I'm planning to do Gentoo and some other distributions next.

I updated the build and runtime requirements lists, too.

**removing xine**

This hasn't been done yet, but it'll happen soon. This will remove some
build requirements and it'll make our lives easier since we'll only have
to support one renderer on Linux. Supporting two takes a time and effort
and we're only doing a so-so job of it. Better to cut xine loose and
focus on gstreamer. I'm sorry that this will affect some people. I'm
hoping to rework the code so that additional renderers can be released
as separate packages like I did with frontends.

**conclusion**

We're focusing on reducing the complexity of the codebase and build
requirements to make it easier for new people to pick it up, build and
contribute. If there's anything else we can do on this front--or better
if there's anything YOU can help us do--let us know.
