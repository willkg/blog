.. title: Migration to Trac: How some small projects balloon into massive projects when you have good intentions and you're not paying attention
.. slug: migration_to_trac
.. date: 2012-01-30 22:20:01
.. tags: dev, mediagoblin, python

Since around July, I've been working on migrating MediaGoblin from
Redmine hosted on the Foocorp servers to Trac hosted on our server. The
project looked small enough initially, but then suffered from a series of
complications that turned the small project into a big project that
took about 6 months and involved writing about 5000 lines of code. 
Pretty nuts. I don't even want to estimate how many hours I spent on it.
Oy.

It wasn't a terrible project, though. Parts of it were educational.
I'd written scrapers in Java and Perl a long time ago, but hadn't written
anything with Python, lxml, and cssselect [1]_. I read through parts of
Trac and Trac's db schema. I also read through Trac plugin code.

The best part about it is that it's done now. This gives the GNU MediaGoblin
project more autonomy and also more flexibility for adjusting the project
to meet their specific needs. That's good stuff---time for cake!


.. [1] ``cssselect`` is amazing. Many thanks to Asheesh for telling me what
   I was doing was silly and to use cssselect since it's way easier to use.
   As a side note, Asheesh is teaching `Web scraping: Reliably and efficiently
   pull data from pages that don't expect it
   <https://us.pycon.org/2012/schedule/presentation/317/>`_ at 
   `PyCon 2012 <https://us.pycon.org/2012/>`_. If you get the advice I got,
   it'll be awesome.
