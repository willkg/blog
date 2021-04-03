.. title: Status 10/19/2005
.. slug: status.10192005
.. date: 2005-10-19 13:00:48
.. tags: content, life, pyblosxom

It's been a month since my last blog entry. I haven't done any blog
updates since I haven't really made any progress with anything.
Nonetheless, here's an update of where things are.

My algorithms course is just killing me. I'm doing some 40 hours of
homework and studying for it each week and ... there are still some
topics that I haven't really wrapped my head around. My computer systems
course, however, is pretty easy--for some bizarre reason I'm very
familiar with much of the material we've covered so far.

I've been very slowly working through PyBlosxom 1.3. It's going to
contains a series of bug fixes (I have to re-organize everything so I
know which ones have gone in so far) and also an overhaul of the flavour
code allowing for flavour directories, subdirectory handling in the
flavourdir, shipped flavours (better ones), ATOM 1.0, RSS 2.0, and
hopefully with the changes it'll be much easier for people to build new
flavours, package them up, and ship them around in a way that's trivial
to install. That's the theory.

I think the ATOM 1.0 flavour is done--I need to do some more testing
with it. I think I'll do this by upgrading my blog to the code in CVS
and working with it there.

I don't think I've finished with the RSS 2.0 code yet. I don't remember
where I am with that.

I'm trying to figure out how to pull images, css files, and other
flavour-helper content in a flavour directory and source it through
PyBlosxom. I think I may build a handler for it and have the handler
kick off before the default blosxom_handler. It would then figure out
which flavour is being displayed by looking at the referer and various
other things available, check to see if the image/css file is there, and
serve it if it is. I'm pretty sure there are corner cases here. It'd be
nice if people could turn on and turn off this feature, too, since it
could cause issues with other plugins. Though since it's a handler that
runs if none of the other handlers ran, maybe it's not a big deal. It
still needs thought. (Also, this isn't a comprehensive description.)

Also, I need to put together (or at least start putting together) a TODO
list for the web-site. I'm having huge problems wrapping my head around
this, though. I'd love to do this as a plugin, but... I think I may end
up doing it all by hand. The other possibility is to enter in all the
items into the SF bug and feature trackers--but I really dislike them.
Tempting thoughts would be to move all development to my server,
installing subversion and Trac, and doing the whole thing with those.
But... that's a lot of work and it puts me in a position where I can't
just throw my hands in the air and walk away.
