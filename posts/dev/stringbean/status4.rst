.. title: In Stringbean land everything is a big mess....
.. slug: status4
.. date: 2002-12-18 00:20:15
.. tags: stringbean, dev, muds

It's true.  I started to add Callout functionality, but also started
splitting the driver into a driver and a mudlib, renaming driver.world
to driver.engine, adding a mudlib.world module with a World object in it
(and moving functionality from the old world to the new world), and a 
series of other things.  All of this will take some time to sort through.
I'm also looking into adding a series of hooks to the driver to tie
the mudlib into the driver.  The good news being that Strinbean will be
pretty nice once all this is done.
