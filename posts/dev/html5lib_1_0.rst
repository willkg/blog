.. title: html5lib-python 1.0 released!: retrospective (2017)
.. slug: html5lib_1_0
.. date: 2017-12-08 12:00
.. tags: python, dev, bleach, mozilla, story, retrospective


Project
=======

:time: 3 months
:impact:
    * reduced technical debt and maintenance friction for html5lib which
      impacts a variety of projects like PyPI, pip, readme_renderer, Jupyter,
      TensorFlow
    * reduced security risks for Bleach


html5lib-python v1.0 released!
==============================

Yesterday, Sam released html5lib 1.0 [#]_! The `changes
<https://html5lib.readthedocs.io/en/latest/changes.html>`_ aren't wildly
interesting for users, but are important for the health of the project.

The more interesting part for me is how the release happened and experimenting
with interim maintainers to get projects going again. I'm going to spend the
rest of this post talking about that.

.. [#] Technically there was a 1.0 release followed by a 1.0.1 release because
   the 1.0 release had packaging issues.


The story of Bleach and html5lib
================================

I work on `Bleach <https://bleach.readthedocs.io/>`_ which is a Python library
for sanitizing and linkifying text from untrusted sources for safe usage in
HTML. It relies heavily on another library called `html5lib-python
<https://github.com/html5lib/html5lib-python/>`_. Most of the work that I do on
Bleach consists of figuring out how to make html5lib do what I need it to do.

Over the last few years, maintainers of the html5lib library have been working
towards a 1.0. Those well-meaning efforts got them into a versioning model which
had some unenthusing properties. I would often talk to people about how I was
having difficulties with Bleach and html5lib 0.99999999 (8 9s) and I'd have to
mentally count how many 9s I had said. It was goofy [#]_.

In an attempt to deal with the effects of the versioning, there's a parallel set
of versions that start with 1.0b. Because there are two sets of versions, it was
a total pain in the ass to correctly specify which versions of html5lib that
Bleach worked with.

While working on Bleach 2.0, I bumped into a few bugs and upstreamed a patch for
at least one of them. That patch sat in the PR queue for months. That's what got
me wondering--what's going on with html5lib?

I tracked down Sam and talked with her a bit on IRC. She seems to be the only
active maintainer. She was really busy with other things, html5lib doesn't pay,
there's a ton of stuff to do, she's burned out, and recently there have been
spats of negative comments in the issues and PRs. Generally the project had a
lot of stop energy.

Some time in August, I offered to step up as an interim maintainer and shepherd
html5lib to 1.0. The goals being:

1. land or close as many old PRs as possible
2. triage, fix, and close as many issues as possible
3. clean up testing and CI
4. clean up documentation
5. ship 1.0 which ends the versioning issues

.. [#] Many things in life are goofy.


Thoughts on being an interim maintainer
=======================================

I see a lot of open source projects that are in trouble in the sense that they
don't have a critical mass of people and energy. When the sole part-time
volunteer maintainer burns out, the project languishes. Then users show up,
complain, demand changes, and talk about how horrible the situation is and
everyone should be ashamed. It's tough--people are frustrated and then do a
bunch of things that make everything so much worse. How do projects escape the
raging inferno death spiral?

For a while now, I've been thinking about a model for open source projects
where someone else pops in as an interim maintainer for a short period of time
with specific goals, works to achieve those goals, and then steps down. Maybe
this alleviates users' frustrations? Maybe this gives the part-time volunteer
burned-out maintainer a breather? Maybe this can get the project moving again?
Maybe the temporary interim maintainer can make some of the hard decisions that
a regular long-term maintainer just can't?

I wondered if I should try that model out here. In the process of convincing
myself that stepping up as an interim maintainer was a good idea [#]_, I looked
at projects that rely on html5lib [#]_:

* `pip <https://pip.pypa.io/en/stable/>`_ vendors it
* `Bleach`_ relies upon it heavily,
  so anything that uses Bleach uses html5lib (jupyter, hypermark,
  readme_renderer, TensorFlow, ...)
* anything that uses readme_renderer like PyPI and tools around Python packages
* most web browsers (Firefox, Chrome, servo, etc) have it in their repositories
  because `web-platform-tests <https://github.com/w3c/web-platform-tests>`_ uses
  it

I talked with Sam and offered to step up with these goals in mind.

I started with cleaning up the milestones in GitHub. I decided the 0.9999999999
(10 9s) milestone was going to be 1.0. I bumped everything from the
0.9999999999 (10 9s) milestone to the 1.0 milestone. I went through all the
issues and PRs and threw any that piqued my interest in the 1.0 milestone
bucket.

Then I went through the issue tracker and triaged all the issues. I tried to
get steps to reproduce and any other data that would help resolve the issue. I
closed some issues I didn't think would ever get resolved.

* https://github.com/html5lib/html5lib-python/issues/295#issuecomment-333851735
* https://github.com/html5lib/html5lib-python/issues/315#issuecomment-347709140

I triaged all the pull requests. Some of them had been open for a long time. I
apologized to people who had spent their time to upstream a fix that sat around
for years. In some cases, the changes had bitrotted severely they had to be
re-done [#]_.

* https://github.com/html5lib/html5lib-python/pull/287#issuecomment-326636920
* https://github.com/html5lib/html5lib-python/pull/176#issuecomment-333861511

Then I plugged away at issues and pull requests for a couple of months landing
and fixing, and pushed anything out of the milestone that wasn't well-defined
or something we couldn't fix in a week.

At the end of all that, Sam released version 1.0 and here we are today!


.. [#] I have precious little free time, so this decision had sweeping
   consequences for my life, my work, and people around me.

.. [#] Recently, I discovered libraries.io--it's pretty amazing project. They
   have a `page for html5lib <https://libraries.io/pypi/html5lib>`_. I had
   written `a (mediocre) tool <https://github.com/willkg/whouses>`_ that does
   vaguely similar things.

.. [#] This is what happens on projects that don't have a critical mass of
   energy/people. It sucks for everyone involved.


Conclusion and more thoughts
============================

I finished up as interim maintainer for html5lib. I don't think I'm going to
continue actively as a maintainer. Yes, Bleach uses it, but I've got other
things I should be doing.

I think this was an interesting experiment. I also think it was a successful
experiment in regards to achieving my stated goals, but I don't know if it gave
the project much momentum to continue forward.

I'd love to see other examples of interim maintainers stepping up, achieving
specific goals, and then stepping down again. Does it bring in new people to the
community? Does it affect the raging inferno death spiral at all? What kinds of
projects would benefit from this the most? What kinds of projects wouldn't
benefit at all?
