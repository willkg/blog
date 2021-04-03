.. title: Who uses my stuff?
.. slug: who_uses_my_stuff
.. date: 2017-02-24 11:00
.. tags: dev, python, mozilla, bleach, story

Summary
=======

I work on a lot of different things. Some are applications, are are libraries,
some I started, some other people started, etc. I have way more stuff to do than
I could possibly get done, so I try to spend my time on things "that matter".

For Open Source software that doesn't have an established community, this is
difficult.

This post is a wandering stream of consciousness covering my journey figuring
out who uses `Bleach <https://bleach.readthedocs.io/>`_.

.. TEASER_END


The journey
===========

I mostly write in Python, so the context of this problem is in the Python
universe. I have no idea whether there are similar problems in other universes.

One of the ways to determine things "that matter" is by who's using that thing.
For web apps, I can use some metrics infrastructure to get a feeling for who's
using my web app and how and prioritize accordingly.

For libraries, I haven't got a clue.

A while back, I could check `PyPI <https://pypi.python.org/>`_ and see how many
downloads the library had over the last day/month/all-time. That has problems,
but seemed like a good enough proxy for "popularity". If the number was really
low, the library probably wasn't used much. If it was really high, then it was
probably used. Lots of caveats, but probably good enough. That feature of PyPI
is gone now.

All my stuff is on GitHub and so is a lot of other stuff, so let's talk about
GitHub.

GitHub has stars. Why do people star anything? I don't star things. My peers
don't really star things. The people that have starred my libraries--I rarely
know who they are or can intuit why they might have starred my library. I can't
derive meaning from this.

Ditto for number of forks.

GitHub has code search. I can do searches for the text ``import bleach`` and see
how many repositories pop up. For example, the GitHub website says ``import
bleach`` has `4,346 results
<https://github.com/search?l=&q=%22import+bleach%22+language%3APython&ref=advsearch&type=Code&utf8=%E2%9C%93>`_.
That search picks up cases where ``import bleach`` is a substring of something
else, like ``from .bleachfield import BleachField``. In the case of bleachfield,
that's ok because bleachfield is a library that uses Bleach.

I wrote a script that uses the `GitHub API v3
<https://developer.github.com/v3/search/#search-code>`_ to do a code search and
for each repository capture the GitHub url, the number of stars, the datetime of
the last event and the full name of the repo. GitHub limits searches to 1000
results. You can change the sort order, but it's sorted by "best match" which
for "does this have the string or not" is kind of unhelpful. Thus it seems like
I'm stuck at viewing the first 1000 results, but it feels like an arbitrary set
of 1000 results.

I adjusted the script to dump the data to CSV. Sorting on stars is unhelpful.
Sorting on the datetime of the last event as a proxy for "is this project
active" is interesting, but it looks like there are only 3 months of events, so
any projects that haven't had an event in 3 months get none. Sorting on GitHub
users is interesting. I recognize a lot of them.

I gave up on that approach because I kept hitting the ratelimit. Using APIs with
ratelimits isn't good for exploring data.

I went back to the website and did these two searches:

First, `search for code that has "import bleach" and "bleach.clean" in files
that aren't named "test_basics.py"
<https://github.com/search?p=40&q=%22import+bleach%22+%22bleach.clean%22+language%3APython+in%3Afile+-filename%3Atest_basics.py&ref=searchresults&type=Code&utf8=%E2%9C%93>`_.

I excluded files named "test_basics.py" because there were a lot of instances of
projects copying Bleach into their repositories. Filtering that out is good.

Second, `search for code that has "bleach" in a requirements file. This catches
projects that use Bleach or use something that uses Bleach
<https://github.com/search?p=13&q=bleach+filename%3Arequirements&ref=searchresults&type=Code&utf8=%E2%9C%93>`_
(like ``pypi/readme_renderer``). John Whitlock thought of this one.

I paged through those results manually. I kept a list of users that I
recognized: Mozilla projects, pypa infrastructure, Fedora, edX, etc. Bleach is
used in a bunch of interesting places. I had no idea.

Bleach gets used a lot in classwork. I suspect classwork gets written, handed in
and that's it, so I'm not sure it helps to consider these "active users".

After a few hours, I can conclude Bleach is used. Beyond that, I don't know what
I can confidently conclude from what I've seen so far. Nor have I established
something I can measure month to month to see if use is growing or shrinking. Is
it more or less important than other projects I work on? Probably?

Possible ways to go from here:

1. git isn't used by all projects and GitHub isn't where all projects park
   things, so maybe check other repository hosts? Maybe other hosts have better
   searching mechanisms?

2. Maybe there's a system out there that's indexing projects in a way that's
   more useful than GitHub's search? Ohloh, which doesn't appear to exist
   anymore, used to track stacks for projects. That might have been helpful.

3. The world of Python packaging is changing. Maybe in the future it'll be
   possible to query who's using what?

4. Maybe Requires.io or some similar system that checks requirements and keeps
   them up to date keeps track of who uses what and makes it searchable?


**Update March 10th, 2017**

arcel pointed out that there's a site called `depsy <https://depsy.org>`_ that
tracks dependency usage for Python projects. The ultimate purpose is to better
direct funding for important projects used by data science work and citations,
but `here's Bleach on depsy <http://depsy.org/package/python/bleach>`_.

Additionally, Marcel noted that PyPI does have total download stats available
in the JSON API. `Here's Bleach JSON data <https://pypi.python.org/pypi/bleach/json>`_.
