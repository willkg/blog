.. title: RSS Problems
.. slug: rssproblems
.. date: 2005-01-02 18:27:39
.. tags: pyblosxom, dev, python

I was checking my apache logs and noticed there are dozens of feed readers
pulling my RSS data.  They're not pulling index.xml--which is the RSS 2.0
nicely-rendered data, but rather the RSS 0.9.1 flavour that comes by default
with PyBlosxom.

The problems with this are two-fold.  First, I don't have num_entries
set in config.py.  So every time someone requests the RSS 0.9.1 feed,
they get all of my entries.  It's around 340K or so.  I'm amazed no
one ever complained about this.  If they had, I would have told them
to get the other feed--the one I advertise--instead.

The second problem is that I didn't have the conditionalhttp plugin
running.  So every time someone requested the RSS 0.9.1 feed, they
get all my entries--even if I haven't added any new ones since the
last time they requested it.

I couldn't adjust the num_entries property in my config.py file, though,
because it would mess up my paging plugin.  So I tossed things around
a bit and decided to add this code to my config.py file:

.. code-block:: python

   import os
   query_string = os.environ.get("QUERY_STRING", "")
   if query_string.find("flav=rss") != -1:
       py['num_entries'] = 20


This code checks to see if someone is grabbing the RSS flavour of my
blog which is my unadvertised-I-wish-no-one-would-request-it RSS 0.9.1
feed and set the num_entries property to 20.  Otherwise, it doesn't
get set.

Then I tossed in the conditionalhttp plugin which does the whole
last-modified thing further reducing the amount of bandwidth I'm
burning away pointlessly.
