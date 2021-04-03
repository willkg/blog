.. title: Playing with category feeds
.. slug: categoryfeeds
.. date: 2007-07-02 22:46:06
.. tags: blog, pyblosxom

It occurred to me that adding a link to category feeds was pretty
trivial, so I figured I'd give it a try. It's a bit cluttered to look at
(I'm talking about the Categories section on the right hand side there),
but ... it's functional.

In case anyone was wondering what my category properties looked like,
they're like this:

.. code-block:: python

   # category plugin properties
   py["category_start"] = ""
   py["category_begin"] = ""
   py["category_item"] = r'%(indent)s<a href="%(base_url)s/' + \
      r'%(fullcategory_urlencoded)sindex.%(flavour)s">%(category)s</a>' + \
      r' [<a href="%(base_url)s/%(fullcategory_urlencoded)sindex.xml">atom</a>]' + \
      r' (%(count)d)<br />'
   py["category_end"] = ""
   py["category_finish"] = ""
