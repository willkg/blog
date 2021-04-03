.. title: PyBlosxom status: 04/01/2007
.. slug: status.04012007
.. date: 2007-04-01 18:04:56
.. tags: pyblosxom, dev, python

I saw Titus' `Strangling your code and growing your test harness: ... <http://ivory.idyll.org/blog/mar-07/strangling-your-code>`_
entry and
that's the process we've been using for adding a test system to PyBlosxom.
We're still on step 2 or 3, though.  We have unit tests for a portion of
the tools module in and working but that's it.  We need a setup/teardown
code for testing a request on a basic blog for *n* variations of
"basic blog".  Getting there....
