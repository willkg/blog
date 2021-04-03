.. title: PyBlosxom 1.1 status
.. slug: pyblosxom1.1.status
.. date: 2004-10-12 16:51:11
.. tags: pyblosxom, dev, python

I finished taking the GRE so now I'm going to start the long process of moving
everything in /contrib to the registry, moving the flavours to the registry,
and then going through the steps to release PyBlosxom 1.1.

We'll do an RC and wait a week for people to speak up about issues.  That puts
a PyBlosxom 1.1 release around the end of October.  Things that will be in the
release:

* a bunch of important performance enhancements
* some bug fixes
* some other minor changes

We're also removing the contrib directory and all the flavour examples.  This
is probably going to be controversial, but I don't think we have enough polish
to continue distributing them with PyBlosxom and it'll be easier to distribute
fixes and such if they're separate from the PyBlosxom release.
