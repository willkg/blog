.. title: Input: Moving to Django 1.8: retrospective (2015)
.. slug: input_django_1_8_upgrade
.. date: 2015-10-01 16:00
.. tags: mozilla, work, input, story, retrospective

Project
=======

:time: 1 year
:impact:
    * upgraded Input to Django 1.8
    * paved the road for AMO, MDN, and other Mozilla sites
    * wrapped up jingo, jingo-minify, and other playdough-era projects
    * built migration path from Tower to Puente and other l10n options


Summary
=======

Over the course of 2015, we've been reworking large parts of the Fjord
codebase to do the following:

1. ditch jingo and friends and other libraries that deviate from typical Django
   and aren't active projects
2. reduce complexity by moving closer to a "default/typical Django project"
3. upgrade to Django 1.8

This blog post covers many grueling details, including the order we did things,
the design decisions we made, and some anecdotes.


.. TEASER_END


.. contents::
      
Intro
=====

First, the history of this document
-----------------------------------

I'm writing this blog post both as a history of this project that I
can look back on at some point in the future and bask in the glorious
fact that I never have to do this again, but also as a guide to help other
projects that have to do similar work.

Because of the latter reason, I plan to update this guide over time
with fixes and comments from others.

History:

* 2015-09-17: Initial draft for comments.
* 2015-10-01: Initial publishing.
* 2015-11-17: Rewrote the Tower section to talk about Puente.

  
Second, thank yous
------------------

Ricky and I started the upgrade in April or May 2015. Ricky did a
lot of the research and other work through 2015q2. In 2015q3, I took
all the work he did and finished it up. If it weren't for him, it
would have taken me ages.

Ricky and Mike Cooper did a ton of code review. We made a lot of code
changes as we dropped less active libraries for better
alternatives. We upgraded libraries that had significant API
changes. We refactored a bunch of things to make them easier to use,
test, or just to clean up code. I removed a ton of code covering
features that were either never finished or were never used.

Rehan did the jingo-minify to django-pipeline work.

Mike Kelly worked out django-browserid support issues and did the work
on Pontoon, which I used as inspiration for figuring out how to do some
things.

Giorgos and everyone who worked on Sugardough helped me understand
some of the nuances between the old way of doing things and what we
should be doing now. Between discussions on IRC and the Sugardough
issue tracker, I learned a lot.

Thank you to everyone who read a draft of this, shook their head,
and sighed: Josh, Mike, Ricky (who experienced pain from the memories),
and Paul. It's possible other people read it but were too ashamed
to be associated. I salute them, too.

Also, thank you to the User Advocacy team who gave me the time to do
the work, Lonnen who manages me with an iron fist holding a soggy
waffle, and all the people who persevered through reading drafts of
this blog post.


Third, a big caveat
-------------------

This is a complex project with a ton of moving parts. We're upgrading
to Django 1.8, which has a lot of changes to the template system and
other things, too. We're dropping a bunch of libraries for a totally
new set of libraries that work differently and have different quirks
related to the development process, translation/l10n workflow, testing,
and other things besides. Plus, while doing all this, I'm seeing parts of
the codebase I haven't seen in a while for which I hold a deep-seated
shame.

While working through all of this, I had the following priorities:

1. Minimal downtime

   Input is a critical part of the Firefox development infrastructure
   so minimal downtime is important.

2. Small, discrete upgrade steps to ease implementation, review, and
   deployment

   Input is maintained by one full-time person (me) and a few
   part-time people who can come and go. Having small, discrete
   upgrade steps makes it easier to get the work implemented and
   reviewed. It also makes it easier to spot and fix problems caused
   by individual steps.

   This also suggests we should keep things the same where we can. If
   we don't have to change something, let's not.

3. Push as much off until later

   There are things we need to do *now* and we want to finish the
   Django 1.8 upgrade as quickly as possible. Everything else we
   should push off so that we can actually complete the Django 1.8
   upgrade and not get lost in the antediluvian labyrinth of
   yak-shaving.

   Having said that, we should fix bad stuff. If fixing it now makes
   the upgrade project easier, then we'll write up a bug, fix it, and
   put the fix in its own pull request. Otherwise, we'll write up a
   bug and do it later.


All decisions have trade-offs. Your priorities will be different, and
thus you'll decide differently on some of these things. I make no
claim that these decisions and this way of doing things should work
for everyone.


Where we started
================

Django 1.8 was released on April 1st, 2015. We started working after that.
We were using:

* Django 1.7
* jingo: Jinja2 renderer for Django
* jingo-minify: css and js minification and bundling
* Tower: extract, merge and gettext

Django 1.8 is an LTS release. Up to now, we've been upgrading Fjord to
the latest Django every 6 months. Now that Django has migrations and
Jinja support, I think continuing to upgrade every 6 months is too
much work and not enough value. My thinking is that we'd do this
massive overhaul to upgrade to Django 1.8, fix some infrastructure, and
reduce some of the things that make Fjord a special-snowflake and then
let it hang out on Django 1.8 for the next couple of years.

The bug that tracked Django 1.8 upgrade work was `bug 1146686
<https://bugzilla.mozilla.org/show_bug.cgi?id=1146686>`_.


Upgrading all the libraries
===========================

We did a pass to upgrade all the libraries we could. For some libraries,
later versions added support for Django 1.8 that we needed. For other
libraries, they fixed bugs and did some other things that I figured
could make things easier later on.

Fjord has a decent test suite which makes it easier to upgrade things
with confidence. However, several of the libraries had non-trivial API
changes, and that took time to work through.

We also set Fjord up with `requires.io <https://requires.io/>`_ so we
don't fall so miserably behind again.


Switching from jingo-minify to django-pipeline
==============================================

This was pretty straightforward. In doing this, we also started using
npm-lockdown, too.


Ditching Tower
==============

.. Note::

   After I did the Django 1.8 upgrade for Fjord, Rob and I spent some time with
   everything and created a new library called `Puente
   <https://puente.readthedocs.org/>`_. Puente replaces Tower. Further, future
   development of Puente is focused on phasing Puente out for more vanilla
   Django, Jinja2, and Babel practices and libraries.

   If you're using Tower, I highly encourage you to replace it with Puente. I
   even wrote a nice `Migrating from Tower
   <http://puente.readthedocs.org/en/latest/migratingfromtower.html>`_ guide.

   If you decide to go with Puente, it might help to skim this section for
   context, but that's it.


Tower is pretty tied to Jingo. Further, I'm pretty sure it doesn't
work with Django 1.8. It's not used in Sugardough and has definitely
fallen out of favor in the Mozilla webdev universe. Because of that,
we wanted to stop using it.

Tower does the following:

* provides ``extract`` and ``merge`` commands for extracting and
  merging strings for translation
* supports extracting strings from Jinja templates and Python files
  using Babel
* allows for multiple domains which get individual ``.pot`` files
* allows developers to add msgctxt to strings
* augments gettext to collapse whitespace in all msgid strings

Fjord doesn't use msgctxt, so we didn't use this feature of Tower. Further,
Django has ``p`` gettext functions which add msgctxt, which probably
didn't exist when Tower was first created.

Fjord only has one ``.pot`` file, so we renamed that from ``messages.pot`` to
``django.pot`` to match how Django does things. This required us to change the
domain name in the settings file. Fjord uses Verbatim to localize strings, so we
had to rename the ``.pot`` file and all the ``.po`` files in SVN. This was
relatively easy to do. We talked with Matjaž to coordinate it.

We don't want our msgid strings to change because that creates a ton of work for
translators, so we needed to maintain the whitespace collapsing things. Django
has a ``makemessages`` command that sort of does what Tower's ``extract`` and
``merge`` commands do, but it doesn't work on Jinja2 templates, and it doesn't
collapse whitespace in msgid strings.

django-jinja overrides Django's ``makemessages`` command to support Jinja2
templates and also strip whitespace from the beginning and ending of msgid
strings. We could switch to that and monkeypatch the code to collapse whitespace
in msgid strings.

We decided we wanted to drop Tower as a small step before we switch to
django-jinja, so we copied the ``extract`` and ``merge`` commands and the gettext
code into Fjord as a stopgap so we could drop Tower.


Switching from jingo to django-jinja
====================================

django-jinja works with Django 1.7 and 1.8; however, the settings are
completely different, and possibly other things are as well. I decided not
to do the jingo -> django-jinja as a separate step and instead do it
along with the Django 1.7 -> 1.8 upgrade.


.jinja vs. jinja2/
------------------

Fjord kept all the Jinja and Django templates in the ``templates/``
directory. I never liked this. It forced me to remember which files
had which syntax. django-jinja suggests you use the ``.jinja`` extension
for Jinja files. A conversation in the Sugardough project issue
tracker came to the same conclusion with the compelling reason being
that it's easier for editors to be in the right mode if the file
extension was ``.jinja`` [#]_.

Ricky, Mike, and I talked about it and decided to move the Jinja
templates to a ``jinja2/`` directory instead of changing the file
extension. There were three big reasons for this:

1. Django and Jinja do template overriding by filename. In order to
   override a file, you have to have the same filename, which would
   prevent us from overriding a file and using a different template
   language.

   For example, if a library has a ``libname/foo.html`` template
   that's a Django template and we want to override it with a Jinja
   template so that we can extend our base template, then we need our
   template to be named ``libname/foo.html``.

2. It's a lot of work to change the names of all the template files,
   and we'd also have to go through and update all the
   ``{% extends xyz %}`` and ``{% include xyz %}`` tags. That's a lot
   of work to do, then test, then review. Ugh.

3. We preferred to name files after what they render to, and the
   editors we use don't have problems with associating the correct
   syntax highlighting with this.

4. We thought it was less surprising to have Jinja templates in
   ``jinja2/`` than to have all templates mixed in ``templates/``.

Given all that, we decided to move the Jinja2 templates to a ``jinja2/``
directory and keep the filenames the same.

.. [#] https://github.com/mozilla/sugardough/issues/76


filters, functions and helpers.py
---------------------------------

Fjord defines a few Jinja filters and functions that we need in our
templates. jingo would automatically load all the ``helpers.py`` files
in the installed apps (yay for recursive imports!).

django-jinja doesn't do that. Instead, django-jinja relies on Django
loading all the files in the ``templatetags/`` directory for installed
apps [#]_.

I moved ``helpers.py`` to ``templatetags/jinja_helpers.py`` and then
did the minor code changes so filters and functions were correctly
registered with django-jinja. This was straightforward.

jingo also comes with a bunch of filters and functions that we use in
our templates. I read through the code, and for the ones that Fjord
uses, I either copied it into the Fjord codebase or switched to an
alternative.

* switched the jingo ``{{ csrf() }}`` function to the ``{% csrf_token %}`` tag,
  which comes from Django
* switched the jingo ``|nl2br`` filter to the ``|linebreaks`` filter, which
  comes from Django
* ditched the jingo ``|ifeq`` filter because it reads weird anyhow

Note that we can't switch to django-jinja's ``url`` function because
ours does locale-aware reversing.

.. [#] http://niwinz.github.io/django-jinja/#_registring_filters_in_a_django_way


django-browserid
----------------

django-browserid 1.0 supports Django 1.8 and Jinja loaders other than jingo.
However, there's nothing in the docs that tells you how to do it (I should
fix that).

The functions we need are all in ``django_browserid.helpers``. They're
good as is. We just need to register them as global functions in
django-jinja.

I did that by adding this to the django-jinja section of the
``TEMPLATES`` setting:

.. code:: python

    'globals': {
        'browserid_info': 'django_browserid.helpers.browserid_info',
        'browserid_login': 'django_browserid.helpers.browserid_login',
        'browserid_logout': 'django_browserid.helpers.browserid_logout'
    }


gettext, extract and merge
--------------------------

.. Note::

   If you switch to Puente, then this section is irrelevant and you can skip it.


This is a tough problem. We have a few pre-existing requirements that
make things difficult:

1. Fjord (through Tower) collapsed whitespace in msgid strings in
   extraction and gettext.

2. Fjord uses Jinja2 templates

3. We can't change the msgid strings when upgrading to Django 1.8


At this point, Fjord has its own ``extract`` and ``merge`` commands, which
are derived from Tower, but cleaned up a bit.

Django has a ``makemessages`` command which **only** looks at Django
templates. Further, it doesn't collapse whitespace in msgid
strings. Thus, we can't use that.

django-jinja overrides Django's ``makemessages`` command to look at
Django and Jinja templates by tweaking some regular expressions. It
strips whitespace at the beginning and end of msgid strings because
that's what the Jinja gettext functions do. However, it doesn't
collapse whitespace in the middle of strings [#]_.

We'll continue using our gettext functions, which collapse whitespace
in msgid strings.

It probably makes sense to switch to django-jinja's ``makemessages``
and tweak it to collapse whitespace instead of just stripping it. I
looked at it a bit and decided it was easier to get ``extract`` and
``merge`` working with django-jinja, and that seemed like a smaller set
of changes. We'll do this as a stopgap. I wrote up a bug to look into
switching to django-jinja's ``makemessages`` later.

.. [#] http://niwinz.github.io/django-jinja/#_i18n_support


checking templates rendered and context in tests with Jinja templates
---------------------------------------------------------------------

Fjord had a bunch of tests where it checks the context and the template
used to render. For example:

.. code:: python

  def test_foo(self):
      response = self.client.get('/')

      self.assertTemplateUsed(response, 'app/foo.html')
      assert resp.context['title'] == 'something'


That doesn't work with Jinja templates with Django 1.8 and django-jinja [#]_.

I tossed around a couple of possibilities:

1. rewrite tests that check context and templates used to render

2. write our own render shortcut like we do with reverse and other
   things

3. when running tests, monkeypatch ``django.shortcuts.render`` to
   "capture" this information and stash it in the response so we can
   check it for Django and Jinja templates

I ended up going with number 3 because I could monkeypatch it only in
the test situation where we need that information, and I could do it
for everything that uses ``django.shortcuts.render``--not just the
Fjord code.

I also wrote a ``template_used`` function that's like
``assertTemplateUsed``, but it uses the new information, has a shorter
name, and isn't tied to Django's TestCase. Plus, to check whether a
template wasn't used, I can just toss in a ``not``.

.. [#] https://code.djangoproject.com/ticket/24622

       
undefined
---------

With jingo, we were using ``jinja2.Undefined`` [#]_ for variables that weren't
defined in the context. That increases the likelihood of bugs in templates
because it quietly "fails" and prints nothing.

We should switch to ``jinja2.StrictUndefined`` [#]_, but we don't *need*
to do that now, so I created a bug to do it later.

In the meantime, we need to set it correctly in the options::

    'undefined': 'jinja2.Undefined',



.. [#] http://jinja.pocoo.org/docs/dev/api/#jinja2.Undefined
.. [#] http://jinja.pocoo.org/docs/dev/api/#jinja2.StrictUndefined


final TEMPLATES
---------------

Our final ``TEMPLATES`` setting is like this:

.. code:: python
  
    _CONTEXT_PROCESSORS = [
        'django.contrib.auth.context_processors.auth',
        'django.contrib.messages.context_processors.messages',
        'django.core.context_processors.request',
        'session_csrf.context_processor',
        'fjord.base.context_processors.globals',
        'fjord.base.context_processors.i18n',
    ]
    
    TEMPLATES = [
        {
            'BACKEND': 'django_jinja.backend.Jinja2',
            'DIRS': [],
            'APP_DIRS': True,
            'OPTIONS': {
                # Use jinja2/ for jinja templates
                'app_dirname': 'jinja2',
                # Don't figure out which template loader to use based on
                # file extension
                'match_extension': '',
                'newstyle_gettext': True,
                'context_processors': _CONTEXT_PROCESSORS,
                'undefined': 'jinja2.Undefined',
                'extensions': [
                    'jinja2.ext.do',
                    'jinja2.ext.loopcontrols',
                    'jinja2.ext.with_',
                    'jinja2.ext.autoescape',
                    'django_jinja.builtins.extensions.CsrfExtension',
                    'django_jinja.builtins.extensions.StaticFilesExtension',
                    'django_jinja.builtins.extensions.DjangoFiltersExtension',
                    'fjord.base.l10n.MozInternationalizationExtension',
                    'pipeline.templatetags.ext.PipelineExtension',
                ],
                'globals': {
                    'browserid_info': 'django_browserid.helpers.browserid_info',
                    'browserid_login': 'django_browserid.helpers.browserid_login',
                    'browserid_logout': 'django_browserid.helpers.browserid_logout'
                }
            }
        },
        {
            'BACKEND': 'django.template.backends.django.DjangoTemplates',
            'DIRS': [],
            'APP_DIRS': True,
            'OPTIONS': {
                'debug': DEBUG,
                'context_processors': _CONTEXT_PROCESSORS,
            }
        },
    ]
    

upgrading to Django 1.8
=======================

django-grappelli
----------------

Fjord uses django-grappelli to make the admin interface easier to use.

django-grappelli versions are tied to Django versions [#]_. I upgraded to 2.7.1,
which is the most current version that works with Django 1.8.

.. [#] http://django-grappelli.readthedocs.org/en/latest/#versions


management commands
-------------------

Fjord doesn't use django-cronjobs like other Mozilla sites do. Instead, we
implement our commands as regular Django management commands.

Before Django 1.8, the command system used optparse for argument parsing. You'd
provide an ``option_list`` class member which added the things you wanted
to parse arguments-wise.

Django 1.8 uses argparse. There's now an ``add_arguments`` method which
you use to add arguments for parsing.

Specifying arguments using the ``option_list`` continues to work in
Django 1.8. If you want to stick with that, then you'll need to add
parsing for positional parameters, and they won't show up in the
``args`` anymore. [#]_

Some of the commands in Fjord worked fine with the new system, but a
couple of them didn't. I decided that instead of just going through
and testing them all to see if there were other differences, I'd
rewrite the argument handling and test them all, since it was pretty
easy to do.

.. [#] https://docs.djangoproject.com/en/1.8/howto/custom-management-commands/#accepting-optional-arguments


Conclusion
==========

We worked on this over the course of 4 months. There were some
significant infrastructure changes we had to do. There was a
non-trivial amount of technical debt we had to pay off and code we
needed to clean up. Switching from jingo to django-jinja was tricky
because I had to do deep dives into many curiosities. I've written
down my experiences in this blog post, so maybe that'll save you time.

There aren't enough people working on Input to make this work go by
quickly. The implement -> review/test -> fix issues process takes more
time than if we had 2 full-time developers. Projects like this without
a critical mass of people working on them are hard to get through.

If you see problems in this post, please let me know.
