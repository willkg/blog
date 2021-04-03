.. title: endash and emdash in Sphinx
.. slug: emdash_in_sphinx
.. date: 2010-02-06 11:41:12
.. tags: python, dev

PyBlosxom uses `Sphinx <http://sphinx.pocoo.org/>`_ for documentation
now.  I was having problems with using ``--`` for em-dash and it not
showing up like an em-dash in the HTML output.

The `docutils FAQ <http://docutils.sourceforge.net/FAQ.html>`_
says to use the actual unicode character for emdash.  I don't really
want to do that because I'm not sure about what happens when the source
files are opened up by a non-unicode-friendly text editor.

Turns out that doesn't matter because Sphinx allows ``--`` for en-dash and
``---`` for em-dash.  Is this something that should get added to the Sphinx
documentation?
