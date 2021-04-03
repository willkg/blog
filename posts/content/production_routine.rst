.. title: movies from Canon Powershot S230 to CD for my DVD player
.. slug: production_routine
.. date: 2005-11-12 21:00:04
.. tags: computers

This is more for my notes. I figured if I post it here, then I've got it
written down in a place I can find again some day.

I have a Canon Powershot S230 and it records video in some format that
has a .AVI extension and I think it's Motion JPEG or something like
that.

Kino doesn't like the format, though. So I need to use ffmpeg to convert
the files to a format that Kino does like:

.. code-block:: shell

   ffmpeg -i FILENAME -target ntsc-dv FILENAME.dv

Kino seems totally fine with that. No clue why or how--I figured it out
by trial and error.

Then I insert all the .dv files I want in a given "movie" into Kino.
After doing some fiddling around, I **Export**, click on the **DV Pipe**
tab, make sure the frame of: dropdown thingy is set to **All**, write
the file name in, make sure the tool is set to **FFMPEG VCD Export** and
then click on the **Export** button. That creates a file that's in a
format that I can record to a cd as a data file and it plays magically
on my Philips DVD player.
