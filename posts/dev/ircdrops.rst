.. title: Handling connection reset issues with bitchx
.. slug: ircdrops
.. date: 2004-05-14 16:22:06
.. tags: software

I'm testing out bitchx at work on my other latop which I ignore in the
back of my monstrously large cube.  The problem is that I'll ignore
it for an hour and then go back to discover that I've had my
connection reset like 60 times and I can't see any of the conversation
at all.  

I think the problem is that the router between me and the Internet 
drops sessions that aren't passing data.  Telnet has an AYT kind of
thing to deal with this.  So I started looking for similar things in
IRC land (to which I'm pretty new) and discover nothing.  The problem
is that I don't know what they would call it and when I do a Google
search for the error message, I get everyone's IRC logs.

bitchx has a timer, though.  So I tossed an event in the timer to
whois thepresident (who doesn't exist) every 2 minutes.  That
seems to have solved the problem.

The better solution would be for there to be more people hanging out
on #pyblosxom thus creating more data going back and forth.
