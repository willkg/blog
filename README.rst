======
README
======

Set up server
=============

?

Install post-receive-hook::

    $ cp post-receive-hook .git/hooks/post-receive


Set up environment
==================

::

    $ mkvirtualenv --python=/usr/bin/python3 blog
    $ pip install -r requirements.txt


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


Process
=======

1. write blog post in ``posts/``
2. run::

     nikola auto -b

3. edit and recheck blog post
