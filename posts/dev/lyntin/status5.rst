.. title: Brief Lyntin break (or was it?)
.. slug: status5
.. date: 2003-02-02 11:29:15
.. tags: dev, lyntin, python

Last week I took a break from Lyntin development and I'm probably
not going to do much this coming week either.  Having said that, I
made some minor changes last week including:

* moved the databuffer to the session class, ditched datagrep and
  datagreplines commands, and added a grep command (with context
  flag)
* removed the threadmanager
* gave some good thought to the config system

Then Josh implemented his default argument code for the argparser
which is extremely cool though I'm not entirely sure we should be
storing those kinds of things in the variable manager.
