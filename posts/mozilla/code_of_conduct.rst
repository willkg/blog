.. title: Code of conduct: supporting in projects
.. slug: code_of_conduct
.. date: 2019-03-29 18:00
.. tags: mozilla, work, python

CODE_OF_CONDUCT.md
==================

This week, Mozilla added PRs to all the repositories that Mozilla has on GitHub
that aren't forks, Servo, or Rust. The PRs add a ``CODE_OF_CONDUCT.md`` file and
also include some instructions on what projects can do with it. This standardizes
inclusion of the code of conduct text in all projects.

I'm a proponent of codes of conduct. I think they're really important. When I
was working on `Bleach <https://bleach.readthedocs.io/>`_ with Greg, we added
code of conduct text in September of 2017. We spent a bunch of time thinking
about how to do that effectively and all the places that users might encounter
Bleach.

I spent some time this week trying to figure out how to do what we did with
Bleach in the context of the Mozilla standard. This blog post covers those
thoughts.

This blog post covers Python-centric projects. Hopefully, some of this applies
to other project types, too.


What we did in Bleach in 2017 and why
=====================================

In September of 2017, Greg and I spent some time thinking about all the places the
code of conduct text needs to show up and how to implement the text to cover as
many of those as possible for Bleach.

`PR #314 <https://github.com/mozilla/bleach/pull/314/>`_ added two things:

* a ``CODE_OF_CONDUCT.rst`` file
* a copy of the text to the README

In doing this, the code of conduct shows up in the following places:

* the contents of the repository at https://github.com/mozilla/bleach
* the rendered README text also at https://github.com/mozilla/bleach
* the docs at https://bleach.readthedocs.io/
* the PyPI page at https://pypi.org/project/bleach
* in the source tarball of all releases
* on the "new issue" page in GitHub [1]_

In this way, users could discover Bleach in a variety of different ways and it's
very likely they'll see the code of conduct text before they interact with the
Bleach community.

.. [1] It no longer shows up on the "new issue" page in GitHub. I don't know
   when that changed.


The Mozilla standard
====================

The Mozilla standard applies to all repositories in Mozilla spaces on GitHub and
is covered `in the Repository Requirements wiki page
<https://wiki.mozilla.org/GitHub/Repository_Requirements>`_.

It explicitly requires that you add a ``CODE_OF_CONDUCT.md`` file with the
specified text in it to the root of the repository.

This makes sure that all repositories for Mozilla things have a code of conduct
specified and also simplifies the work they need to do to enforce the
requirement and update the text over time.

This week, a bot added PRs to all repositories that didn't have this file.
Going forward, the bot will continue to notify repositories that are missing
the file and will update the file's text if it ever gets updated.


How to work with the Mozilla standard
=====================================

Let's go back and talk about Bleach. We added a file and a blurb to the
README and that covered the following places:

* the contents of the repository at https://github.com/mozilla/bleach
* the rendered README text also at https://github.com/mozilla/bleach
* the docs at https://bleach.readthedocs.io/
* the PyPI page at https://pypi.org/project/bleach
* in the source tarball of all releases

With the new standard, we only get this:

* the contents of the repository at https://github.com/mozilla/bleach
* (maybe) in the source tarball of all releases

In order to make sure the file is in the source tarball, you have to make sure
it gets added. The bot doesn't make any changes to fix this. You can use
`check-manifest <https://pypi.org/project/check-manifest/>`_ to help make sure
that's working. You might have to adjust your ``MANIFEST.in`` file or something
else in your build pipeline--hence the maybe.

Because the Mozilla standard suggests they may change the text of the
``CODE_OF_CONDUCT.md`` file, it's a terrible idea to copy the contents of the
file around your repository because that's a maintenance nightmare--so that idea
is out.

It's hard to include ``.md`` files in reStructuredText contexts. You can't just
add this to the long description of the ``setup.py`` file and you can't include
it in a Sphinx project [2]_.

Greg and I chatted about this a bit and I think the best solution is to add minimal
text that points to the ``CODE_OF_CONDUCT.md`` in GitHub to the README. Something
like this::

    Code of Conduct
    ===============

    This project and repository is governed by Mozilla's code of conduct and
    etiquette guidelines. For more details please see the `CODE_OF_CONDUCT.md
    file <https://github.com/mozilla/bleach/blob/master/CODE_OF_CONDUCT.md>`_.


In Bleach, the long description set in ``setup.py`` includes the README::

    def get_long_desc():
        desc = codecs.open('README.rst', encoding='utf-8').read()
        desc += '\n\n'
        desc += codecs.open('CHANGES', encoding='utf-8').read()
        return desc

    ...

    setup(
        name='bleach',
        version=get_version(),
        description='An easy safe-list-based HTML-sanitizing tool.',
        long_description=get_long_desc(),
        ...
 

In Bleach, the ``index.rst`` of the docs also includes the README::

    .. include:: ../README.rst

    Contents
    ========

    .. toctree::
       :maxdepth: 2
    
       clean
       linkify
       goals
       dev
       changes
    
    
    Indices and tables
    ==================
    
    * :ref:`genindex`
    * :ref:`search`
    

In this way, the README continues to have text about the code of conduct and the
link goes to the file which is maintained by the bot. The README is included in
the long description of ``setup.py`` so this code of conduct text shows up on
the PyPI page. The README is included in the Sphinx docs so the code of conduct
text shows up on the front page of the project documentation.

So now we've got code of conduct text pointing to the ``CODE_OF_CONDUCT.md``
file in all these places:

* the contents of the repository at https://github.com/mozilla/bleach
* the rendered README text also at https://github.com/mozilla/bleach
* the docs at https://bleach.readthedocs.io/
* the PyPI page at https://pypi.org/project/bleach
* in the source tarball of all releases

Plus the text will get updated automatically by the bot as changes are made.

Excellent!

.. [2] You can have Markdown files in a Sphinx project. It's fragile and finicky
       and requires a specific version of Commonmark. I think this avenue is not
       worth it. If I had to do this again, I'd be more inclined to run the
       Markdown file through pandoc and then include the result.


Future possibilities
====================

GitHub has a Community Insights page for each project. `This is the one for
Bleach <https://github.com/mozilla/bleach/community>`_. There's a section for
"Code of conduct", but you only get a green checkmark if and only if you use one
of GitHub's pre-approved code of conduct files.

There's a discussion about that `in their forums <https://github.community/t5/How-to-use-Git-and-GitHub/Code-of-Conduct-is-present-in-repo-but-Insights-gt-Community-tab/m-p/15496?advanced=false&collapse_discussion=true&q=CODE_OF_CONDUCT.rst&search_type=thread>`_.

Is this checklist helpful to people? Does it mean something to have all these
items checked off? Is there someone checking for this sort of thing? If so, then
maybe we should get the Mozilla text approved?


Hope this helps!
================

I hope to roll this out for the projects I maintain on Monday.

I hope this helps you!
