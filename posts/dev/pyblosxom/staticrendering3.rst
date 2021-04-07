.. title: More more static rendering....
.. slug: staticrendering3
.. date: 2004-05-04 17:48:05
.. tags: dev, pyblosxom, python

I checked in some fixes to the static rendering code and it's working
nicely.  I fixed my flavour files, made some adjustments to my
plugins and then re-rendered everything.  My statically rendered
site is at ``/~willkg/test/``.

Things the static renderer is not good at:

* figuring out if an entry has moved from one category to another
  (you'll probably end up with two versions)
* comments (if someone adds a comment, that doesn't adjust
  the mtime on the entry file, so we won't re-render)
* figuring out if material has changed on other pages 
  (if you add an entry to april on the 4th, the other april pages 
  won't reflect this in the calendar--they would need to be 
  re-rendered but pyblosxom can't figure that out nicely in a 
  general fashion)

Those are somewhat complex problems.  One way to fix them is to store
a record of which pages belong to which categories and dates.  So then
if an entry is updated in April, we'd figure out that we really need
to update all April entries.  That fixes the immediate problem of 
pycalendar, but doesn't provide a generic fix and I'd prefer not to have
to store records of things if I don't have to.

Robert suggested I add a callback for plugins to tell me what urls need
to be rendered.  If you extrapolate on that, the plugins could also take
a look at what's changed since the last time we rendered and figure out
the related pages that also need to be re-rendered.  For example,
pycalendar could implement the callback, get a list of entries that
are going to be re-rendered, notice that one of them is in april, and
then tell Pyblosxom all the April entries need to be re-rendered as
well as the entries in May (because of the "next month" link) and
March (because of the "previous month" link).  Not sure that's a really
wildly good idea.  And the effort involved is pretty high.  I think
it'd be easier on everyone if the suggested fix is to build a cron
script that does this:

.. code-block:: shell

   #!/bin/bash
   cd /home/willkg/public_html/cgi-bin/
   ./pyblosxom.cgi --static
   find /home/willkg/public_html/test -mmin +30 -exec 'rm' '{}' ';'


That'll run the static renderer and then remove any file that was
modified over 30 minutes ago (i.e. it didn't get touched by the
static renderer).
