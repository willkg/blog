======
README
======

This is my blog. It's built with Nikola now, but in the past it was built with
some PHP journal system I don't recall the name of, the PyBlosxom, then
Douglas.


Set up server
=============

?

Install post-receive-hook::

    $ cp post-receive-hook .git/hooks/post-receive


Blog
====

Clean and set up environment:

::

    $ make clean
    $ make buildvenv

Write posts in ``posts/``.

Create a new post:

::

    $ ./venv/bin/nikola new_post -t "Some Title" posts/some/path.rst

As you're writing, you can have nikola re-compile live:

::

    $ make draft


How to
======

How to do drafts
----------------

Add to header::

    .. status: draft


How to do a teaser
------------------

Add::

    .. TEASER_END

to the end of the teaser section.


How to link to another post
---------------------------

Do::

    Take a look at :doc:`my other post <creating-a-theme>` about theme creating.


How to do an update
-------------------

In reST posts, do::

    Changes to this blog post
    =========================

    **Update Month Day, Year:** Text here


In HTML posts, do::

    <p>
      <b>Update Month Day, Year:</b> Text here
    </p>


Markup
------

bz::

    :bz:`BUGID`


sphinx_roles: https://plugins.getnikola.com/v7/sphinx_roles/

::

    :pep:
    :abbr:
    :command:
    :kbd:
    :program:
    :regexp:
    :file:

    .. seealso::


figures:

::

    .. thumbnail:: /images/foo.png

       Description.


graphviz: https://plugins.getnikola.com/v7/graphviz/

::

    .. graphviz::

       dot stuff here


emoji: https://plugins.getnikola.com/v7/emoji/

::

    :emoji:`EMOJI`

FIXME: Emojis won't work until we install them


code blocks:

::

    .. code:: python
       :number-lines:

       print("Our virtues and our failings are inseparable")
