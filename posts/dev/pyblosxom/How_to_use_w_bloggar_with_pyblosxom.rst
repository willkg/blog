.. title: How to use w.bloggar with pyblosxom
.. slug: How_to_use_w_bloggar_with_pyblosxom
.. date: 2004-02-17 19:58:14
.. tags: python, dev, pyblosxom

I just finished making a bunch of code changes.  So if you go this route, you may
encounter problems.  Having said that, feel free to email me or the
pyblosxom-users mailing list with questions.  It should be noted I'm
posting this entry with w.bloggar right now.

* Make sure you have the latest CVS codebase
* Add the ``xmlrpc`` and ``xmlrpc_blogger`` plugins
* Read the top of xmlrpc.py and set up the right config.py parameters

The w.bloggar account settings should be as follows:

In the **Content Management System** section:

* Blog Tool: "Custom"

In the **API Server** tab:

* Host: the name of your server
* Page: the url of your blog with /RPC at the end (mine is /~willkg/blog/RPC)

In the **Custom** tab:

* Posts: "Blogger API"
* Categories: "Not supported"
* Templates: "Not Supported"
* Title Tags: (make both fields blank)
* Category Tags: (make both fields blank)

When you go to write a new entry, leave the title field blank and
do your entire post in the data section with the first line being
the title (just like blosxom entries).

One thing you should note is that pyblosxom will take the first
line and use that to generate the file name of the entry.  So if
the title of the entry is "How to use w.bloggar with pyblosxom",
the file name ends up being "How_to_use_w_bloggar_with_pyblosxom.txt"
which is a little annoying but whatever.

That seems to work for me.  Poke me if you have questions and I can update
this entry with the adjustments.
