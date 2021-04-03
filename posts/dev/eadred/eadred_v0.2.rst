.. title: Django Eadred v0.2 released! Django app for generating sample data.
.. slug: eadred_v0.2
.. date: 2013-02-16 14:07
.. tags: eadred, django, python, dev


Django Eadred gives you some scaffolding for generating sample data
to make it easier for new contributors to get up and running quickly,
bootstrapping required database data, and generating large amounts
of random data for testing graphs and things like that.

For v0.2, I added some helper methods for generating names, email
addresses, sentences and paragraphs. It's definitely the case that
these helpers won't handle all use cases, but I think they'll help
specific ones.

There are no backwards-compatability problems with v0.1.

To update, do::

    pip install -U eadred

* docs: `django-eadred.readthedocs.org <http://django-eadred.readthedocs.org/en/latest/>`_
* pypi: http://pypi.python.org/pypi/eadred/0.2
* github: https://github.com/willkg/django-eadred
