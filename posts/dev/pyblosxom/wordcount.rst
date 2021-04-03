.. title: Another PyBlosxom plugin example
.. slug: wordcount
.. date: 2003-03-13 21:22:57
.. tags: python, dev, pyblosxom

This plugin registers with the prepareChain and for each entry
it adds a ``$wc`` metadata variable.  The wordcount is sort of an
expensive process since it requires the data of the entry to 
be populated and we only populate that on-demand.  Thus we
need to populate the ``$wc`` variable on-demand as well.

...

The effects of this is that I can add a ``$wc`` variable to my ``story.html``
template file and you see a wc: thing on all of my entries.

This plugin and the entry that describes this plugin were written, tested,
and documented in 15 minutes.

**Updates:**

3/19/2003 Moved code to `</~willkg/dev/pyblosxom/>`_.

4/8/2003 Updated plugin to new architecture.
