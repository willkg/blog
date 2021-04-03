.. title: Switching to South
.. slug: switching_to_south
.. date: 2013-09-11
.. tags: south, python, dev, django


tl;dr
=====

We just landed the bits that switch us from Schematic---the migration system
we were using---to South. This is my account of that journey in case it
helps others.


Context
=======

`Kitsune <https://github.com/mozilla/kitsune>`_ is the Django project
that runs `Mozilla Support <https://support.mozilla.org/>`_. The project
was started many years ago. For as long as I've worked on Kitsune, we
used a migration system called
`Schematic <https://github.com/jbalogh/schematic>`_.

Schematic has the nicety of being very very raw. You can do anything:
raw SQL, raw shell, raw Python, raw fish---whatevs. This was nice because
we could write whatever we wanted.

Schematic is a total pain in the ass because it hasn't been touched in
2 years, doesn't work well with recent versions of MySQL or MariaDB and
makes it really difficult to write migrations that continue to work
over time. Further, there's no way to do backwards migrations in Schematic
even if you wanted to. We were constantly getting bit by these issues.


The switch
==========

Switching from Schematic to South turned out to be pretty easy. I did it
Monday afternoon. I essentially followed these steps:

1. Added South as a dependency for our Django project.

2. Initialized South migrations for all the apps we use in Kitsune which
   was a whole bunch of::

       $ ./manage.py schemamigration <appname> --initial


3. Wrote a last Schematic migration that adds all the South bookkeeping
   which entailed dumping the output of this to a file::

       $ mysqldump <database> south_migrationhistory

   and then editing that file by hand.

   That creates the ``south_migrationhistory`` table and populates it with
   the bookkeeping for the initial commits for the apps initialized in
   step 2.

4. Added ``./manage.py migrate`` to our deploy script.

5. Do a happy dance!

The relevant commits for Kitsune are here:

* `fa412aa2 [bug 911831] Add initial South migrations <https://github.com/mozilla/kitsune/commit/fa412aa2c029bb8cfefb600b3fa7f393819e1602>`_
* `0884893b [bug 911831] Update deployment script with South <https://github.com/mozilla/kitsune/commit/0884893b6d7bd66841874a862cc162a85a543bfb>`_
* `cde04df1 [bug 911831] Update db and migration docs for South <https://github.com/mozilla/kitsune/commit/cde04df1f12fe7f6452353f4854f62b7623888d4>`_
* `609144f2 Quell south logging during tests <https://github.com/mozilla/kitsune/commit/609144f25238c7d16a56e8735f9633a11f5162da>`_

That's pretty much it.


**Update: September 11, 2013**
    This was with Django 1.4.7 and South 0.8.2. If you're using different
    versions, you may experience different things.

**Update: September 13, 2013**
    In Schematic, one thing we would do after creating new models is add
    a content type and the permissions.

    This walks through setting that up automatically with South and
    post_migrate:

    http://devwithpassion.com/felipe/south-django-permissions/
