.. title: Input: Dashboards for Everyone v1
.. slug: input_d4e
.. date: 2014-10-06 12:00
.. tags: mozilla, work, input


Summary
=======

In 2014q3, I created the `Dashboards for Everyone <https://wiki.mozilla.org/Firefox/Input/Dashboards_for_Everyone>`_
project. This blog post covers what the project is, what's out there
now, some examples of usage and the future.

`Input <https://input.mozilla.org/>`_ collects sentiment data on
Mozilla products. Currently, this data can be seen on the front page
dashboard. This dashboard sucks for a variety of reasons amongst which
is that it's a slog of data that isn't particularly informative.

Further, it's pretty clear that the greater Mozillaverse has different
informational needs. Some people are interested in issues with
products in specific locales. Some people are interested in today's
hot topic. Some people are interested in comparing the first week
after release of one version of a product with another. Etc.

Given that, we have two paths:

1. Create dashboards that live on Input catering to all these needs.
2. Create an API that allows people to create their own dashboards
   and host them wherever.

These two paths aren't mutually exclusive. However, I want to put
effort into the second one first for the following reasons:

1. It enables people to individually and collectively solve their own
   informational problems.
2. It enables people to solve informational problems as problems crop
   up rather than wait for Input developers to have time to write up a
   dashboard.
3. As people are solving their informational problems, we'll learn a
   lot more about what informational problems exist which will guide
   how we build dashboards that live on Input.

The Dashboards for Everyone project aims to create the infrastructure
for enabling people to write their own dashboards using Input data.


Version 1
=========

Over the course of the quarter we put enough of the bits in place that building
your own dashboard is a viable thing now.

First, we wrote and honed an `API for getting feedback data <http://fjord.readthedocs.org/en/latest/api.html#getting-product-feedback-get-api-v1-feedback>`_.

Then we wrote a bunch of proof-of-concept dashboards that use this data.

I threw together these two dashboards which are defined in Github gists
and "hosted" on bl.ocks.org:

* Happy feedback: http://bl.ocks.org/willkg/c4d5a272f86ae4510750
* Happy vs. Sad broken down by locale for Firefox OS: http://bl.ocks.org/willkg/e6013b21ec16d5e8192a

Ian Kronquist (Input intern for summer 2014) wrote this one:

* Happitude comparison: http://bl.ocks.org/iankronquist/90f68ed445f804e63cdb

Those are examples of fetching and manipulating the data into a chart. They're
not very informative. We used them to help flesh out the API and their current
purpose is as examples for using the API to do things.

However, we've built some real things that use the data and are "in
production" now:

* I use the Input API for the Response Breakdown graphs on the
  `Input Health Dashboard <http://people.mozilla.org/~wkahngreene/input-dashboard/>`_.
  That helps me figure out whether we've just pushed out bugs preventing
  people from leaving feedback. That uses a d3-based charting library
  I've been toying with to help me flesh out possible data transform
  needs. It also uses a library that lets me defined the charts in HTML
  attributes and they get "auto-charted" without me having to write
  JavaScript.

* Cheng used the Input API to build the Hello dashboard for tracking
  Hello feedback.

* I then reused most of his ideas and some of his code to produce a
  `Firefox for Android trends <http://people.mozilla.org/~wkahngreene/fennec_trends/>`_
  dashboard. That's still got some issues namely that the tokenizing
  isn't very good and thus there's enough noise in the words lists
  that it doesn't bring real trending issues into starker relief.

That's where we're at. Now I need to tell people about it so that you
know these possibilities exist.

Do you have informational needs for the data on Input?

Can the API help you solve your specific needs?

Are there important things missing that you need to have implemented
in order to solve your needs?

If you use the Input API to build your own dashboards and you run into problems,
`write up a bug <https://bugzilla.mozilla.org/enter_bug.cgi?product=Input&rep_platform=all&op_sys=all>`_.


Version 2 and future
====================

Bugs, conversations and seeing other peoples' dashboards will inform us as to
how we need to grow the API going forward. That will set the priorities for
the next version.

Also, I have a few ideas I've been mulling over:

1. Build an index of charts: If there are a sufficient number of interesting
   charts out there, then we should build an index of them on Input.

2. Build tokenizing into the Input API: If you look at the JavaScript code
   for my Firefox for Android Trends chart, a good portion of it deals with
   tokenizing. If tokenizing is a common thing people are doing to build
   charts, then we should pull that tokenizing in-house.

3. Build an auto-charter or chart widget library: Right now you have to do
   all the charting by hand. It'd be really nice to be able to throw
   dashboards together using chart "widgets" and possibly define the
   dashboard entirely in HTML. I've been toying with this with the Input
   Health Dashboard. I'm curious to find out if there's a need for throwing
   dashboards together quickly to follow certain issues (e.g. e10s, Hello, ...).

   The Metrics team produces some really great looking dashboards that
   use `MetricsGraphics.js <https://github.com/mozilla/metrics-graphics>`_.
   Maybe we could build a shim on top of that letting people more
   easily use that library with Input data?


Thanks
======

I really want to thank Matt Grimes for coordinating d3 training, Cheng Wang
for giving me some compelling code to reuse and Mike Cooper for helping me
debug code whose mystery was only exceeded by its brokenness.


Thoughts, comments, etc
=======================

I'm using the fruits of this labor now, so at a bare minimum, it solved some of
my problems.

Can it help you solve yours?
