.. title: Django Eadred v0.1 released! Django app for generating sample data.
.. slug: eadred_v0.1
.. date: 2012-10-16 12:00
.. tags: eadred, django, python, dev


I work on a few projects that had a need for generating sample data to
make it easier for new contributors to get up and running quickly with
little effort. These projects are fairly data-driven---they're kind of
useless without data.

To satisfy that need, we wrote an app in `richard
<https://github.com/willkg/richard>`_ to generate sample data across
all the other apps in the project. Then I rewrote it for `input
<https://github.com/mozilla/fjord>`_.

Then we had a hankering for it in SUMO, plus I thought it made sense
to turn it into its own app. So I spun it out into its own project.

Thus `django-eadred <https://github.com/willkg/django-eadred>`_ was
born.

Generally, it allows you to define a ``sampledata.py`` module with a
``generate_sampledata`` function that takes command line options to
generate sample data for any app you want to generate sample data for.

You can use it to define different ways of generating sample data
specified by the command line.

You can use it to generate random data, non-random data, initial data,
data for contributors, sample data for large data sets, fixture data,
etc.

Check out `django-eadred.readthedocs.org
<http://django-eadred.readthedocs.org/en/latest/>`_ for use cases,
documentation and project details.
