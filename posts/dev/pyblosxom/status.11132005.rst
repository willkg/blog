.. title: PyBlosxom status: 11/13/2005
.. slug: status.11132005
.. date: 2005-11-13 12:50:02
.. tags: pyblosxom, dev, python

I re-re-wrote the flavour template code for the upcoming PyBlosxom 1.3
release. It works like this now:

#. Pulls flavour templates from *taste*.flav that comes with PyBlosxom
   if that flavour exists.
#. In either $datadir OR $flavourdir:

   #. If there is a directory named *taste*.flav, then it will take the
      template files from there and override the ones it got from step
      1.
   #. OTHERWISE, it will look for files ending in *.taste* and override
      the ones it got from step 1.

#. If the request is for a non-root path, it'll look in all the
   directories between $datadir (OR $flavourdir) and
   $datadir/*path_info*/ (OR $flavourdir/*path_info*/) looking for
   *taste*.flav directories OR files ending in *.taste*.

This allows you to put all your flavour files in a flavour directory
that you specify in your config.py file.

This allows you to put all the flavour files in a *taste*.flav directory
(for example, html.flav, happygoodness.flav, rss20.flav, atom10.flav,
...).

This allows you to override individual template files from the default
flavours. For example, if you wanted to add RSS enclosures, you can put
a story.rss file in your $datadir/, $flavourdir/, $datadir/rss.flav/, or
$flavourdir/rss.flav/ directory (depending on how you set things up)
with the enclosure markup in it and PyBlosxom will pull the default rss
templates and use your story.rss template.

This allows you to override individual template files depending on what
category the user is looking at.

This makes it easier to package and distribute flavour packs because
they can all sit in a single directory all by themselves.

There should be no backwards-compatibility issues with the new code
between PyBlosxom 1.2 and 1.3.

**NOTE:** The code needs to bake a bit. I tested a lot of combinations
of things, but I'm still finding occasional issues. This blog is using
the latest code, so if you find any issues, write a comment below
(assuming that's not broken) and I'll fix the issue.

I have one more big thing on my list of things to do for PyBlosxom 1.3.
After that I'll probably release an RC1. Depending on school work, that
could happen in the next few weeks. If you want to see the code now, get
it from CVS (`instructions for CVS access
here <http://sourceforge.net/cvs/?group_id=67445>`__).
