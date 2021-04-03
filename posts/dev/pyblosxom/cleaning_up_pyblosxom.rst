.. title: Cleaning Up PyBlosxom Using Cheesecake
.. slug: cleaning_up_pyblosxom_using_cheesecake
.. date: 2006-08-15 12:00:00
.. tags: pyblosxom, dev, python

Cleaning Up PyBlosxom Using Cheesecake
======================================

Abstract
--------

This is a case study for using Cheesecake to improve an existing Python-based
project.


.. TEASER_END


Introduction: What I'm Doing and Why
------------------------------------

This article walks through my experience cleaning up PyBlosxom using
Cheesecake.

PyBlosxom started out a long time ago as a CGI script written in Python
that emulated Blosxom behavior.  Since then, the requirements for
PyBlosxom have changed.  In addition to being a CGI program,
PyBlosxom can be used as a component in a WSGI-based application,
PyBlosxom can be run concurrently, PyBlosxom is being used for non-blog
things.

As we've added new code and functionality to PyBlosxom, it's become
increasingly difficult to test everything and qualify the quality
of each PyBlosxom release.  It's difficult for other people to find
bugs, fix them, test them, and send in patches.  Portions of PyBlosxom
have suffered from bitrot and it's not clear what these portions do
in the grand scheme of things.

Additionally, PyBlosxom is being packaged by various Linux distributions
and the userbase is growing substantially.  It behooves us greatly
to fix our package so that it contains all the files that people
expect to see and that it allows people to more easily install
PyBlosxom regardless of whether they're installing it from their
distribution's repository or from a download from our site.

Bottom line is that PyBlosxom needs some cleaning up.  I need to
get a better feel for what PyBlosxom is missing.  I need a way
to qualify the quality of PyBlosxom when we apply new patches, add
new functionality, and do new releases.  It would be nice to have
a tool tell me which areas it thinks need some attention and possible
refactoring.

In "fixing" PyBlosxom, my goals are these:

* identify what's missing in the PyBlosxom package that would make
  it easier to package PyBlosxom for Linux distributions, install
  PyBlosxom under various circumstances, and improve the documentation
  so people can more easily participate with us to make PyBlosxom better
* identify places in PyBlosxom that could use refactoring to improve
  readability and code quality
* create a testing system that increases the confidence of quality for
  patches, refactoring, new functionality, and new releases
* reduce the amount of work it takes for someone new to find a problem,
  identify the part of PyBlosxom that's causing it, fix it, test it,
  and send a diff back to us

None of these goals are earth-shattering in the sense that they're not
unique to PyBlosxom, they are goals that any project should have.

The biggest problem I've had so far in trying to work this all out is
that every time I've started working on the project and breaking it
down into a series of tasks, I would get discouraged and quit.  I need
a tool to help me identify probable issues based on standards and act
as a roadmap for cleaning things up.

This article walks through how I got over the hump using Cheesecake and
the steps I went through in improving the PyBlosxom codebase.


Getting Started
---------------

I discovered Cheesecake in December of 2005 from the Daily Python-URL.
The goal of Cheesecake is to "rank Python packages based on various
empirical 'kwalitee' factors".  It uses a series of indexes that look
at specific facets of your package and score based on criteria ranging
from pylint code quality, to unit tests, to documentation.

Cheesecake uses the word "kwalitee" because "quality" is subjective
and some measures of quality are highly subjective things like coding
standards: how many spaces go here and there, what do function names
look like, ...  Regardless of whether you agree with all of the
opinions and assumptions that stand behind the resulting kwalitee
metric, it's a good roadmap to start with.

I opened up my browser and went to `<http://pycheesecake.org/>`_ and followed
the instructions to download it.  I grabbed Cheesecake 0.6.

I downloaded the latest PyBlosxom package from SourceForge.  Then I ran
Cheesecake on that package::

    % cheesecake_index --verbose -p pyblosxom-1.3.2.tar.gz


This gives me a baseline of where I'm starting from.  Cheesecake produces the
following output::

    unpack .................................  25  (package unpacked successfully)
    unpack_dir .............................  15  (unpack directory is pyblosxom-1.3.2 as expected)
    setup.py ...............................  25  (setup.py found)
    install ................................  50  (package installed in /tmp/cheesecakegitECA/tmp_install_pyblosxom-1.3.2)
    generated_files ........................   0  (0 .pyc and 0 .pyo files found)
    ---------------------------------------------
    INSTALLABILITY INDEX (ABSOLUTE) ........ 115
    INSTALLABILITY INDEX (RELATIVE) ........ 100  (115 out of a maximum of 115 points is 100%)
    
    [required_files] Package doesn't have file: faq/faq.html/faq.txt.
    [required_files] Package doesn't have file: news/news.html/news.txt.
    [required_files] Package doesn't have file: thanks/thanks.html/thanks.txt.
    [required_files] Package has critical file: license/license.html/license.txt/copying/copying.html/copying.txt.
    [required_files] Package has important file: announce/announce.html/announce.txt/changelog/changelog.html/changelog.txt/changes/changes.html/changes.txt.
    [required_files] Package doesn't have file: authors/authors.html/authors.txt.
    [required_files] Package has important file: install/install.html/install.txt.
    [required_files] Package doesn't have file: todo/todo.html/todo.txt.
    [required_files] Package has critical file: readme/readme.html/readme.txt.
    [required_files] Package doesn't have critical directory: test/tests.
    [required_files] Package has critical directory: doc/docs.
    [required_files] Package doesn't have directory: demo/example/examples.
    required_files ......................... 130  (4 files and 1 required directories found)
    docstrings .............................  65  (found 165/254=64.96% objects with docstrings)
    [formatted_docstrings] 42.52% formatted docstrings found, which is > 25% and is worth 10p.
    formatted_docstrings ...................  10  (found 108/254=42.52% objects with formatted docstrings)
    ---------------------------------------------
    DOCUMENTATION INDEX (ABSOLUTE) ......... 205
    DOCUMENTATION INDEX (RELATIVE) .........  59  (205 out of a maximum of 350 points is 59%)

    [pylint] Score is 7.62/10, which is 76% of maximum 50 points = 39.
    pylint .................................  39  (pylint score was 7.62 out of 10)
    unit_tested ............................   0  (don't have unit tests)
    ---------------------------------------------
    CODE KWALITEE INDEX (ABSOLUTE) .........  39
    CODE KWALITEE INDEX (RELATIVE) .........  49  (39 out of a maximum of 80 points is 49%)


    =============================================
    OVERALL CHEESECAKE INDEX (ABSOLUTE) .... 359
    OVERALL CHEESECAKE INDEX (RELATIVE) ....  65  (359 out of a maximum of 545 points is 65%)


I skim through the output and notice the following things:

* The PyBlosxom package is good.
* PyBlosxom has 4 files and 1 required directory.  I'm not sure what it's
  looking for or why those things are required--something to look into.
* There's a good chunk of PyBlosxom code that doesn't have docstrings--I
  should look into this.
* pylint says the average is 7.62 out of 10.  I'm not sure what that means,
  so I should look into that and what pylint doesn't like about the code.
* Overall, PyBlosxom has 359 points out of 545 which is 65%.  That's better than I
  thought it would do, but it doesn't mean a whole lot because I don't
  know what's being measured.

The first thing I do is go look at the `Cheesecake web-site <http://pycheesecake.org/>`_
to read the documentation to better understand the scores Cheesecake just gave
PyBlosxom.

From this, I decide that I need to:

* adjust the project directory structure
* create the required files that should be there but aren't
* make some adjustments to the project packaging to account for the
  new files and directories
* run pylint and fix the easy things that need fixing
* go through the code and add documentation where it's lacking
* add testing infrastructure and tests
* integrate PyBlosxom with the Cheeseshop
* run pylint and refactor things that definitely need refactoring

That looks like a lot of work, though I suspect that spending a few
days on PyBlosxom will yield a marked improvement.  At a minimum,
I feel a lot better about things because I have a list of things
to work on and tools to measure my progress.


Project Directory Structure and Required Files
----------------------------------------------

Cheesecake's verbose output explains what required files and directories it's
looking for and which ones PyBlosxom has.

::

    [required_files] Package doesn't have file: faq/faq.html/faq.txt.
    [required_files] Package doesn't have file: news/news.html/news.txt.
    [required_files] Package doesn't have file: thanks/thanks.html/thanks.txt.
    [required_files] Package has critical file: license/license.html/license.txt/copying/copying.html/copying.txt.
    [required_files] Package has important file: announce/announce.html/announce.txt/changelog/changelog.html/changelog.txt/changes/changes.html/changes.txt.
    [required_files] Package doesn't have file: authors/authors.html/authors.txt.
    [req uired_files] Package has important file: install/install.html/install.txt.
    [required_files] Package doesn't have file: todo/todo.html/todo.txt.
    [required_files] Package has critical file: readme/readme.html/readme.txt.


PyBlosxom has CHANGELOG, INSTALL, LICENSE, and README but doesn't have NEWS,
TODO, AUTHORS, FAQ and THANKS.

::

    [required_files] Package doesn't have critical directory: test/tests.
    [required_files] Package has critical directory: doc/docs.
    [required_files] Package doesn't have directory: demo/example/examples.


PyBlosxom has ``docs/`` but doesn't have ``test/`` or ``demo/``.

I don't know why these files and directories are required.  I read
through the Cheesecake wiki and it had a link to the book
`Art of Unix Programming <http://www.faqs.org/docs/artu/>`_.
In it there's `a listing <http://www.faqs.org/docs/artu/ch19s02.html#distpractice>`_
of which files should be there and what information they hold.

Adding a ``NEWS`` document might be interesting. I think it'd just be a rehash
of the ``CHANGELOG`` document, though, so I think I'll skip it.

Adding a ``TODO`` document would be useful--people keep asking what PyBlosxom
needs and we don't have a centralized ``TODO`` list anywhere. My only problem
with this is that the ``TODO`` list changes over time and if someone has an old
version of PyBlosxom, they'll have an old ``TODO`` list, too. At the top of the
``TODO`` file, I'll want some language making it very clear where to find the
most recent TODO list and also that it should be checked BEFORE doing anything.

We should add an ``AUTHORS`` document and also a ``THANKS`` document. PyBlosxom
doesn't adequately show appreciation for the many contributors that have helped
out over the years.

We might want to add a FAQ document at some point, but it's not something I feel
the need to do now.

Looking at directories, we need a ``tests/`` directory, but I'm not sure a
``demo/`` directory makes sense.

From that I do the following things:

* I add a ``TODO`` file
* I add an ``AUTHORS`` file that covers both the main developers of the project
* I add a ``THANKS`` file which lists anyone that's helped over the years
* I add a ``tests/`` directory which for now is empty

At the top of the ``TODO`` file I have the following English:

::

    This is a really high-level todo list.  Nothing here is written
    in stone--this is mostly just a collection of thoughts.  As such, not
    everything in here will make sense to implement.  Each item really
    needs fleshing out before decisions on implementation should be made.

    Before launching into anything, check the SVN repository which has
    the latest version of this TODO list.

    If you're inspired by any of these tasks, let us know on the
    pyblosxom-devel mailing list.

    If there are items not mentioned here, let us know on the
    pyblosxom-devel mailing list.


Hopefully, that will prevent the issues I'm concerned with regarding the ``TODO``
file.

That covers it for files and directories.


Project Packaging
-----------------

The PyBlosxom package is pretty good.  I am curious about ez_setup.py and
using `setuptools <http://peak.telecommunity.com/DevCenter/setuptools>`_ as well.
That's a task I'll defer until later, though.

I make sure that the files and directories I just added are represented in 
the ``MANIFEST.in`` and ``setup.py`` files.  Other than that, there's nothing I 
need to do here.


Code "Kwalitee"
---------------

Cheesecake says this about PyBlosxom's code "kwalitee":

::

    [pylint] Score is 7.62/10, which is 76% of maximum 50 points = 39.
    pylint .................................  39  (pylint score was 7.62 out of 10)


I go to `pylint <http://www.logilab.org/projects/pylint>`_ for documentation on how
pylint works so that I can better understand what it's checking for and how
to run it separately from Cheesecake.

I wrote a shell script to automate running pylint and dumping the output
in a readable form.

::

    #!/bin/bash
    pylint --html=y Pyblosxom > output.html


I run pylint and notice that issues are broken up into serveral categories
and types.  I go through the codebase and fix the following issues immediately:

* Missing required attribute ``__revision__``
* More than one statement on a single line
* Unused argument "..."
* Redefining built-in "..."
* Operator not followed by a space
* Unused variable "..."
* ``__init__`` method from base class "..." is not called
* Access to undefined member "..."
* Redefining name "..." from outer scope
* Reimport "..."
* Bad indentation

Some of those are really bad and some are just cosmetic, but easily fixed.

After working through those, I run pylint again and start working on missing
docstrings.  While doing this, I discover that some of the existing documentation
is wrong or just plain lacking.

pylint complains a lot about naming schemes, most particularly that we use camel
case for method names. However, PyBlosxom does have a document on our web-site
that describes our code conventions and this is a standard that we've had for a
few years. While it doesn't follow `PEP-8 Style Guide for Python Code
<http://www.python.org/dev/peps/pep-0008/>`_ exactly, it's pretty close; close
enough that it's not worth changing today.

Having said that, we do have a bunch of functions that don't follow PyBlosxom
coding style conventions. I'm not sure what to do with them since it's possible
people use them in their plugins and changing these names would not be backwards
compatible. I'll have to think about what to do and whether it's worth doing.

In the process of fixing issues pointed out by pylint, I discover a few cases 
of code that refers to variables that don't exist or aren't initialized at that 
point, a few cases where the code is just wrong, and a few cases where we're
doing magic things in very cleverly written lines of code that would be better
spelled out in more readable code.

There's only so far I can go with fixing the code, though.  There are spots
that pylint suggest should be refactored, but I don't dare touch them until
I can test to make sure my changes haven't adversely affected anything.


Documentation
-------------

Wari did a round of documentation a couple of years ago and since then things
have been ok for the most part.  We standardized on `Epydoc <http://epydoc.sourceforge.net/>`_
for docstring markup and we build out-of-line documentation of PyBlosxom
every time we do a new release.

Cheesecake says this about PyBlosxom's documentation:

::

    docstrings .............................  65  (found 165/254=64.96% objects with docstrings)
    [formatted_docstrings] 42.52% formatted docstrings found, which is > 25% and is worth 10p.
    formatted_docstrings ...................  10  (found 108/254=42.52% objects with formatted docstrings)


That's a lot lower than I thought it should be so this is something I
decide to spend a couple of days on fixing.

First thing I do is check the Epydoc web-site and I notice that Epydoc is now at
version 3.0 Alpha 2 (April 2006). I check out the `What's new
<http://epydoc.sourceforge.net/whatsnew.html>`_ page and notice there are a lot
of really interesting features, but most of them have to do with Epydoc output.

Additionally, I decide to take a look at alternative systems to figure out whether
I should switch to a different system for code documentation.

I look at the following alternatives that `Epydoc lists as related projects
<http://epydoc.sourceforge.net/relatedprojects.html>`_:

* `PyDoc <http://lfw.org/python/pydoc.html>`_
* `HappyDoc <http://happydoc.sourceforge.net/>`_
* `Docutils <http://docutils.sourceforge.net/>`_
* `Pythondoc <http://starship.python.net/crew/danilo/pythondoc/>`_
* `Doxygen <http://www.stack.nl/~dimitri/doxygen/>`_

There are others that I've never heard of.  I decide that Epydoc is decent and 
does what I need it to do.  I don't see a compelling reason to switch systems 
at this juncture.

I spend a couple of days going through the docstrings for classes, methods, and 
functions updating ones that seem to have gotten old, clarifying ones that 
need clarification, and adding new ones where we didn't previously have any.

In the process of doing this, I discover a function that's not used in PyBlosxom
and doesn't seem to do anything interesting.  I send an email to the pyblosxom-devel
mailing list to see if anyone else knows why it's there.  I'll wait until I have 
more information before I figure out whether to remove it or not.

The other thing I discover while fixing documentation is that there are a number
of methods and functions that have interesting side-effects that seem to lie
outside of what their documented behavior should be.  I toss a few FIXMEs
into the code and keep these in mind for when I work on unit testing and
refactoring.

I don't fix all the documentation nor do I make sure that everything
is documented.  All I want to do at this point is spend a couple of days to
make it better and get a better understanding of what state it's currently in.
After a couple of days it's a marked improvement on what we had before.

However that's not the end of the documentation story since that only covers API
documentation.  I've been working on a PyBlosxom manual for about a year now.  I 
chose to write it in `Docbook <http://www.docbook.org/>`_ partially because I wanted 
to learn docbook and partially because there are a variety of export options 
(PDF, HTML, ...).  I'm not sure I'd do that again, though.  Writing in XML (I'm 
using vim) is kind of a pain in the ass and playing with XSSL to get the output 
right took a long time.  I think if I did it again, I'd do it using 
`docutils and reST <http://docutils.sourceforge.net/>`_.

Anyhow, documentation like manuals and things of that nature should be in the
``doc/`` or ``docs/`` directory.  PyBlosxom has one of these already and in
it are all the docbook XML files.  I'm not sure if that's useful to anyone
(probably not).  It would probably be a good idea to move the ``docs/`` directory
to something like ``docsrc/`` and then the PyBlosxom package would contain a 
docs directory with a "compiled" version of the manual.


Testing
-------

Cheesecake says this about PyBlosxom's test stuff:

::

    unit_tested ............................   0  (don't have unit tests)


and it's right on.  PyBlosxom currently employs manual testing and frequently this takes
the shape of anecdotal testing (i.e. "such and such works for me").

In PyBlosxom's case, this is bad for all the obvious reasons the main ones being that we
have no way to regression test changes and we don't really have an idea of what is and what
isn't working in a given release.  For small projects that's probably fine, but PyBlosxom
is beyond the point of being too complex for informal manual testing.

The only unit testing I've done in Python involved writing my own framework with functionality
very very loosely based on `Junit <http://www.junit.org/>`_.  I think I'd rather use a pre-existing
testing framework rather than roll my own.

I check the Cheesecake website and find this page 
`<http://pycheesecake.org/wiki/PythonTestingToolsTaxonomy>`_ which covers a
very very large number of testing tools for Python.  I also notice there's a page linking to
articles on Agile Testing at `<http://pycheesecake.org/wiki/AgileTestingArticlesAndTutorials>`_.
That's somewhat overwhelming, so I look at what testing systems Cheesecake itself uses 
and notice that it uses some
`doctests <http://docs.python.org/lib/module-doctest.html>`_ and also
`nose <http://somethingaboutorange.com/mrl/projects/nose/>`_.

I look into both of these and notice that the nose page links to 
`an introduction to using nose <http://ivory.idyll.org/articles/nose-intro.html>`_.  I read through
that and then skim the nose code in Cheesecake and decide that doctests and nose are the way I
want to go.

First thing I do is create a ``tests/`` directory under the pyblosxom package.  In that directory
I create the following subdirectories:

* ``unit/``
* ``functional/``
* ``data/``

In order to test PyBlosxom I need to set up some blog data.  All that data will go in the 
``data/`` directory probably as a bunch of ``.tar`` files.  I'll use that for the
functional tests.

I start writing unit tests for the ``tools`` module since that's the easiest one to do
and it's a good place to cut my teeth on figuring out how nose works.  It's really fast
and in the process of testing things, I adjust the documentation for the functions
in the ``tools`` module.

Writing tests and watching them pass makes me feel pretty good about the existing code.

I suspect this will require a few more days of work, but I'm going to defer finishing it
for now so that I can finish up this case study.


Cheeseshop
----------

The `Python Cheese Shop <http://www.python.org/pypi>`_ is, in their words, a repository for
Python software.  PyBlosxom is listed (`<http://cheeseshop.python.org/pypi/pyblosxom/>`_), but 
the listing is way out of date.

I notice that Wari is listed as the package maintainer--that's fine, except it might be
difficult to get the package updated.

I check `The Tutorial <http://wiki.python.org/moin/CheeseShopTutorial>`_ to read up on how
to update the existing submission.  This takes a bit of time to figure out.  I have an
account (I used it to register Lyntin), but I haven't used it in years, so I don't
remember any of the details.

At any rate, I update the entry and make a note to run:

::

    python setup.py register


after the next release.


Conclusion
----------

I still have a lot of work to do refactoring, writing additional tests, fixing documentation,
and improving the overall quality of PyBlosxom.  However, the few days of work that I've
spent on PyBlosxom so far (perhaps 20 hours total) has been very productive.  I think
that PyBlosxom has improved a lot and I have a good roadmap on what still needs work.
