.. title: Long strings in Python
.. slug: long_strings
.. date: 2008-09-06 10:59:05
.. tags: dev, miro, python

In Miro, we've got long strings that are displayed in the user interface.  I
think the code that defines these strings is messy and hard to parse.  For 
example:

.. code-block:: python

   def some_func():
       description = _("""\
   This is a really long description that has multiple sentences and a few \
   things that need to %(getfilledin)s and it goes on and on and on and on \
   and I'm not really sure what's the best way to format it so that it's happy \
   in editors and easier to parse.""") % {"getfilledin": blahblah}


PEP-8 doesn't address this, which is fine.  I was curious to see what other 
projects do.
