.. title: SPF and Exim in Debian
.. slug: spfexim
.. date: 2006-07-13 00:33:11
.. tags: computers, bluesock, debian

Turns out the 
`Debian packager doesn't enable SPF in the exim4-daemon-heavy package
<http://pkg-exim4.alioth.debian.org/README/README.Debian.html#id2454661>`_.
But it took me a couple of hours to figure that out.  I ended up
implementing SPF using the libmail-spf-query-perl package by adding
the following rule to my rcpt acl just before greylist stuff::

   accept
     message     = [SPF] $sender_host_address is not allowed to send mail \
                   from $sender_address_domain.
     log_message = SPF check failed.
     set acl_m9  = -ipv4=$sender_host_address \
                   -sender=$sender_address \
                   -helo=$sender_helo_name
     set acl_m9  = ${run{/usr/bin/spfquery $acl_m9}}
     condition   = ${if eq {$runrc}{0}{true}{false}}


The exit codes for spfquery are in the spfquery file (it's a Perl script)
and the code for "pass" is 0.  So (in theory) this will accept any
email that passes the SPF check.  Any email that fails the SPF check
will go through greylistd.  I think that does what I want it to do.

Incidentally, I found the above code (though I inverted the check) 
`here <http://www.tldp.org/HOWTO/Spam-Filtering-for-MX/exim-spf.html>`_
at `The Linux Documentation Project <http://www.tldp.org/>`_.
