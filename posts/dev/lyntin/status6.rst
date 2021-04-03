.. title: Lyntin status: 2/6/2003
.. slug: status6
.. date: 2003-02-03 21:01:57
.. tags: dev, lyntin, python

I'm in some kind of Lyntin development kick again.  I implemented all 
the changes I talked about in yesterday's email:

* removed ``#import`` and added ``#load`` and ``#unload``
* fixed ``addCommand`` so that it removes a command first (and its help file)
* changed the order of how modules get imported

Then on top of that, I wrote a testing module and started building tests
for various functionality.  It's not a great module, but it definitely
gives me the ability to programmatically regression test large portions
of Lyntin's functionality.  The issue now is that I have a lot of tests
to write, run, and then verify.  It's somewhat time consuming.  I don't
plan on releasing 3.2 until I get a significant number of tests done
and verified.

Additionally, I worked out how I want to handle the config stuff.  I still 
have to write it out and fill in the details.  I want to release 3.2 and 
get some other things cleaned up before I start on the config stuff.

So while the lyntin-devl list is deathly quiet, there's definitely 
stuff happening.
