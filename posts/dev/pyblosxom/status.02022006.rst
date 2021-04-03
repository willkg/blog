.. title: PyBlosxom status: 02/02/2006
.. slug: status.02022006
.. date: 2006-02-02 23:55:34
.. tags: pyblosxom, dev, python

Norbert took over Debian packaging and has sent me a plethora of fixes,
questions, and errata most of which I've applied, replied to, or at
least thought about. Martin has also sent in several issues that will be
fixed for PyBlosxom 1.3.1. Additionally, I went through all the bug
reports on the SourceForge bugtracker and dealt with them.

In the process of doing all that, there were a bunch of bugs with 1.3
that got fixed. I also fixed Joey's problem regarding num_entries
behavior. I'm re-thinking how some of PyBlosxom works (or doesn't work)
and I've gotten all excited about making some changes.

I've done another huge push on the manual fixing a bunch of minor issues
and folding documentation that existed in other places into the manual
in the proper places. The manual is in docbook format and when I compile
it (or whatever the verb should be) into a PDF, it clocks in at 76
pages. It's definitely the longest manual I've ever written. As time
goes on, it gets more and more comprehensive. I hope people use it if
only because I've spent days writing, honing, editing, and cursing it.

Next week some time (time-willing), I'll do another pass at overhauling
the web-site and fixing the massive problem with plugins that we have.
The issue is that I don't want to be doing contributed plugin
packs--it's a pain in the ass and none of them are tested except the
ones I use. On top of that, over the years people stop hosting their
plugins which has caused some of the entries in the registry to become
obsolete. I'm going to switch how I do things, ditch the registry
plugin, and change the system so that the site hosts all the plugins
that are offered. I'm also going to enforce some rules regarding things
plugins need to have in order to be added to the registry.
