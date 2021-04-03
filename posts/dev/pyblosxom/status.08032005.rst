.. title: PyBlosxom status: 08/03/2005
.. slug: status.08032005
.. date: 2005-08-03 15:37:44
.. tags: pyblosxom, dev, python

I merged all the changes I've made in the PYBLOSXOM_1_2 branch back into
HEAD. Now I'm in HEAD and I'm going to do PyBlosxom 1.3 work until I'm
ready to release. At that point, I'll make another branch for PyBlosxom
1.3 fixes and such.

I've got the following items in my todo list for PyBlosxom 1.3:

* figure out what additional variables are needed to produce RSS 2 and
  Atom 0.3 feeds without the rss2renderer and without additional
  plugins [1]_
* add a timezone variable to the data dict
* fix bugs
  `1239484 <http://sourceforge.net/tracker/index.php?func=detail&aid=1239484&group_id=67445&atid=517918>`__
  and
  `1202107 <http://sourceforge.net/tracker/index.php?func=detail&aid=1202107&group_id=67445&atid=517918>`__.
  and
  `1252678 <http://sourceforge.net/tracker/index.php?func=detail&aid=1252678&group_id=67445&atid=517918>`__.
* possibly add new sample flavours: rss 0.9, rss 2.0, atom 0.3, and
  several html flavours [2]_
* minor clean-up and documentation work

Why make this PyBlosxom 1.3 and not another minor 1.2 revision? Well, it
has to do with the adjustments needed to fix bug 1202107. PyBlosxom
checks the content-type to see if it's xml and if it is, then it escapes
the $title and $body variables which makes everyone trying to do an
xhtml or other xml output sad. The only ways to fix the issue is to do a
hack on the hack or introduce a backwards-incompatible change. Given
that I'm more interested in the latter, I figured it's better to bump
the version so that it's clearer that the user will need to make some
adjustments to their PyBlosxom configuration when they upgrade.

.. [1] $title_encoded, $body_encoded, rfc822 date, iso8601 date,
   and possibly other stuff

.. [2] If you want to help with building flavours, let me know.

**Updates:**

8/6/2005 I added bug 1252678 to the list of bugs to be fixed in
PyBlosxom 1.3.
