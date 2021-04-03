.. title: pytest-wholenodeid addon: v0.2 released!
.. slug: pytest_wholenodeid_v0_2
.. date: 2015-08-26 16:00
.. tags: dev, pytest, python, work

What is it?
===========

`pytest-wholenodeid <https://pypi.python.org/pypi/pytest-wholenodeid>`_
is a pytest addon that shows the whole node id on failure rather than
just the domain part. This makes it a lot easier to copy and paste
the entire node id and re-run the test.


v0.2 released!
==============

I wrote it in an hour today to make it easier to deal with test failures.
Then I figured I'd turn it into a real project so friends could use it.
Now you can use it, too!

I originally released v0.1 (the first release) and then noticed on PyPI
that the description was a mess, so I fixed that and released v0.2.

To install::

    pip install pytest-wholenodeid

It runs automatically. If you want to disable it temporarily, pass the
``--nowholeid`` argument to pytest.

More details on exactly what it does on the PyPI page.

If you use it and find issues, write up an issue in the `issue tracker
<https://github.com/willkg/pytest-wholenodeid>`_.
