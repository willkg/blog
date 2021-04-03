.. title: greylisting and gmail
.. slug: greygoogle
.. date: 2006-03-11 18:28:54
.. tags: computers, bluesock, debian

I have greylistd installed (on Debian with exim) and noticed last 
monday (March 6th) that Google has something like 26 outgoing SMTP 
servers for gmail.  That doesn't work well with greylistd, though.  
So I added "64.233" to the whitehosts list.  Not sure if that's 
the right thing to do or not, though.  I'm not wildly excited about 
adding items to the whitehosts list.
