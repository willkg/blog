.. title: conditionalhttp problems with IE 6
.. slug: conditionalproblems
.. date: 2005-06-23 14:09:01
.. tags: pyblosxom, dev, python

Joseph `pointed out a problem <http://article.gmane.org/gmane.comp.web.pyblosxom.user/1206>`_
where IE 6 won't display a cached page when it gets a 304 from the 
conditionalhttp plugin.  (The issue is at the bottom of the email.)

I did some poking around and discovered on Wednesday that this happens 
on his blog as well as on my blog with IE 6 on Windows XP.  On Thursday, 
I was no longer able to reproduce the problem on my site, but Joseph's
was still broken.  I don't know off hand what changed with my site, though
I did do an apt-get update Wednesday night.

Anyhow, the 304 response from my site (which seems to work fine now) is
(note the server line is wrapped)::

   HTTP/1.1 304 Not Modified
   Date: Thu, 23 Jun 2005 14:32:26 GMT
   Server: Apache/1.3.33 (Debian GNU/Linux) mod_python/2.7.10 Python/2.3.4 PHP/4.3.10-15 mod_ssl/2.8.22 OpenSSL/0.9.7d DAV/1.0.3
   ETag: "1119536230.43"
   Last-Modified: Thu, 23 Jun 2005 14:17:10 GMT
   Keep-Alive: timeout=15, max=100
   Connection: Keep-Alive
   Content-Type: text/html; charset=iso-8859-1


And from Joseph's site (which is still not working)::

   HTTP/1.1 304 Not Modified
   Date: Thu, 23 Jun 2005 14:37:15 GMT
   Server: Apache/2.0.46 (Red Hat)
   Connection: Keep-Alive
   Keep-Alive: timeout=5, max=100
   ETag: "1118428239.0"
   Vary: Accept-Encoding,User-Agent

   =bunch of funky non-printable characters here=


Looking at responses from other requests to Joseph's server leads
me to believe that pages are gzipped.  I'm not sure if that's part
of the issue or not.

My site: <a href="http://www.bluesock.org/~willkg/blog/">http://www.bluesock.org/~willg/blog/</a>

Joseph's site: <a href="http://reagle.org/joseph/blog/">http://reagle.org/joseph/blog/</a>


I'm running PyBlosxom 1.2.1 with the contributed plugins pack 1.2.2 with
conditionalhttp.  I think Joseph is as well.  I have no idea if this is
affecting anyone else--no one else has complained on the mailing lists or
anywhere else that I've checked.

Anyone have any ideas as to what might be happening?
