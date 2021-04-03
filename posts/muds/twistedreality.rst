.. title: Twisted Reality
.. slug: twistedreality
.. date: 2004-11-04 13:43:02
.. tags: muds

Every once in a while, someone emails me about
`Stringbean </~willkg/stringbean/>`__ and wonders why I'm not working on
it much. Stringbean is more like an LPMud than a MOO and would allow for
in-game coding of objects in Python. I've been giving a few reasons of
why I'm not really actively working on it:

* It's not currently possible (without a lot of work) to build a
  restricted execution environment within the Python interpreter to
  protect the driver from the mudlib codebase if both are implemented
  in Python. That's not a wildly large issue except that it forces you
  to really trust in-game developers. The Zope folks have something
  like this in place, but I don't know if it would help me solve my
  problem or not. Mostly this requires a lot of research and work.
* It's difficult to terminate infinite loops and other long-running
  code which will cause mudlag. It's not uncommon for me to
  accidentally create an infinite loop. If you can't somehow halt
  execution, then this forces you to shut down the whole mud and
  restart it. When working on Varium, we created a reaper thread which
  would send a signal to the Python process causing the execution
  thread (which was the main thread of execution) to throw an exception
  and thus "terminate" execution. Even with this, it's not clear what
  state the driver would be in. This also requires a lot more research
  and work.
* I bumped into Twisted Reality (which is what this post is all about).

`Twisted Reality <http://twistedmatrix.com/products/reality>`__ is a MOO
oriented mud so it's got a different focus than Stringbean does.
However, Twisted Reality is also attempting to solve another big problem
I have with muds using Aspects.

The problem is this: you build a bunch of objects the player can
manipulate (things like torches, swords, hammers, nails, screwdrivers,
etc) and in order to add another way for the players to manipulate and
modify these objects, you have to code
manipulation/modification-handling code for every single object. What if
you wanted to allow players to burn an object? Well, for every object,
you'd have to implement burn-handling code.

You could implement this using multiple inheritance. Each object
inherits from a object-type class (armor, weapon, container, etc) as
well as a material class (iron, wood, organic, copper, glass, etc). The
material classes could handle effects like burning. But what if you had
something like an axe with a wooden handle and an iron blade?

Anyhow, it'd be easier if the burn code could be centralized into one
place--an aspect. The stuff in the Reality mailing list is interesting
enough that even though I haven't looked into it further, it's caused me
to want to wait to research it more before I go work on Stringbean
again.
