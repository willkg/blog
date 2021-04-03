.. title: Tags
.. slug: tags
.. date: 2009-06-04 21:42:06
.. tags: blog, pyblosxom, dev, python

I spent a few hours throwing together a new tags plugin that makes use
of the new commandline features of code in PyBlosxom trunk (which will
be PyBlosxom 1.5). Then I spent a while adding tags to all my entries.

I'm still mulling over my choice of tags, but I imagine I'll hone it
into a set I'm happy with over time.

Also, I used ``::`` as a tag separator, but I think I'd recommend
something that doesn't require a shift key to enter. Perhaps ;; or //.

Tag information is stored in two dicts that are pickled and thrown in a
file. It seems to be pretty fast to load for my blog (~500 entries). I
picked pickle because it was easy, but if it turns out to be a problem,
I'd be game for other storage formats.

I've been waiting for tags support before I did more blogging. Now that
I've got tags support, I plan to move my work blog here. That'll make
things easier and get me off WordPress.
