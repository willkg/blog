.. title: parasite with miro on Linux
.. slug: parasite_with_miro_on_linux
.. date: 2009-01-22 11:17:09
.. tags: miro

I saw `Chip's blog entry announcing
Parasite <http://www.chipx86.com/blog/?p=292>`__ yesterday and checked
it out. I had problems getting it to work with Miro, but he has since
fixed the bug I was bumping into.

I think this will be a really useful tool, so I'm doing a short write up
of how to use `Parasite <http://chipx86.github.com/gtkparasite/>`__ with
Miro.

#. Grab Parasite from git compile and install it. Instructions are on
   the Parasite web-site.

#. When you run ``make install`` It'll install libgtkparasite.so into
   ``/usr/local/lib/gtk-2.0/modules/`` .

#. Launch Miro like this:

   ::

      LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib/gtk-2.0/modules/ GTK_MODULES=parasite ./run.sh

That'll launch Miro with Parasite showing you the widget hierarchy and
widget properties and all that.

There's a `screencast on the Parasite
site <http://chipx86.github.com/gtkparasite/video/parasite-intro.avi>`__
that shows off more things you can do.
