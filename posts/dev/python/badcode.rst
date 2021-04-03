.. title: Bad code: Part 1
.. slug: badcode
.. date: 2008-09-30 13:20:29
.. tags: dev, python

If you're writing code like this:

.. code:: python

    try:
       foo = somevar.getBlah()["xyz"].split(".")[-1].decode("ascii", "replace")
    except:
       pass


Please stop! You're killing the rain forest!
