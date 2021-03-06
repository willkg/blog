.. title: Apache not serving static files correctly?
.. slug: apache_enablesendfile
.. date: 2006-11-15 23:35:44
.. tags: computers, bluesock, debian

I innocently did an ``apt-get dist-upgrade`` today and suddenly
Apache wouldn't serve any static files, but anything generated by
CGI scripts worked super!  Apache would send the headers for static
files complete with a Content-Length correctly but wouldn't send
any data in the HTTP response (even for an HTTP 200).

I spent hours trying to figure out what was going on under the assumption
that I did a bad upgrade.  I skimmed documentation, made sure my conf
files were ok, did dozens of Google searches and then finally gave up
and walked away for a couple of hours.

Long story short I finally hit gold with the right mantra of search
terms and bumped into the
`EnableSendFile diretive <http://httpd.apache.org/docs/2.2/mod/core.html#enablesendfile>`_.
I added:

.. code-block::

   EnableSendFile Off


to my Apache conf file and it works fine now.

I mention it in case someone else does a dist-upgrade with Debian testing on
or around November 15th, 2006 and discovers themselves in the same boat.
