.. title: New registry plugin soon!
.. slug: registrysoon
.. date: 2004-06-04 11:30:33
.. tags: dev, pyblosxom, python

Last night I did a lot of work on my registry plugin. I'm completely
re-writing it from scratch--how it works, what it does, so on and so
forth.

One of the things I never bothered to do was separate my blog (what
you're looking at now) from my development. So whenever I make a mistake
and create a bug, my whole blog goes down. Sometimes, in the case of
last night, interesting things happen. I was playing with FileEntry and
the generation of the absolute_path which had the effect of mucking up
all the categories and permalinks on my site.

Anyhow, so things go up and come down pretty often on this blog since
it's very very bleeding edge in terms of the source code and I'm often
editing things live.

Having said that, I'm almost done the new registry plugin. I'll install
it on Planet PyBlosxom soon and overhaul all the existing registry
entries. This version of the registry plugin will make it easier to do a
flavour registry as well. It's also a heck of a lot easier to set up and
maintain.
