.. title: Bill Mill, pyblosxom 1.1, sourceforge, et al
.. slug: billmilletal
.. date: 2004-11-13 15:02:11
.. tags: pyblosxom, dev, python

I gave Bill Mill CVS checkin permissions the other day. He's interested
in working on the static rendering and the problems of storing metadata.
The former (static rendering), I'm psyched to pass off to someone who
will work on it and fix the various issues it has. At a bare minimum,
I'm psyched to pass it off to someone who wants to think about it.

The latter (metadata) is something we need to figure out how to deal
with and soonish. The pyblosxom-users and pyblosxom-devel mailing lists
have had several people pop up with their own ideas about what
constitutes metadata, where it should be stored, how it should be
stored, and how to access it. But few, if any, of the proposals seem to
be in-line with the PyBlosxom mission. Though maybe it's not clear what
the mission is. That's a topic for another entry.

Bottom line is that I'm going to hold off on releasing pyblosxom 1.1 for
a few days in case Bill wants to change things.

Bill Mill's weblog is `here <http://llimllib.f2o.org/blog/serve>`__. He
talks a bit about metadata in entries and del.icio.us-style keywords.

Also, SourceForge is finally getting around to updating their
web-servers and are planning to install a version of Python greater than
1.5.2. When that happens, I'm going to re-do and move the
PlanetPyBlosxom web-site. I'm hoping Wari will approve moving the
PyBlosxom main site as well. If he does that, then I want to merge the
two sites, fix our problems with documentation, and centralize
everything under one big project web-site that's agnostic of the people
involved. That's a bit project. It may be that I'll wait to do pyblosxom
1.1 release until after the "big move".

A while back, several people offered to help out but I severely lacked
the resources to sort everything out to take that offer. I'm hoping to
make development much easier for people who want to hop in, implement a
feature they need, and hop back out again and also make room for growing
PyBlosxom beyond its blosxom roots.

So that's the update. Any thoughts or comments, leave them below.
