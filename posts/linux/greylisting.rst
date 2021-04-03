.. title: Greylisting and whitehosts-list
.. slug: greylisting
.. date: 2006-03-14 12:54:28
.. tags: computers, bluesock, debian

Gah...  For some reason, I've got two whitehosts-list files on my
system.  One in /etc/greylist/ and the other in /var/lib/greylist/ .

It's also interesting to note that the greylistd doesn't look at
either file, the files are used by rules in the Exim configuration.
So when I added the gmail items (64.233) to whitehosts-list and 
then tried to check it with ``greylist check --grey ...`` I
was using the wrong checking tool.  Whoops!  30 minutes down the
drain!

Anyhow, once I discovered that whitehosts-list is in the Exim
configuration files (and I should have realized that because I put
it there) and not checked by greylistd, I discovered that the
Exim configuration files check both copies of whitehosts-list.
There's likely a good reason for that.  Probably even my fault to
begin with.  Something to look into when I have some spare cycles
and feel like pouring through Exim configuration, Debian policy
for directories and configuration files, and all the other pieces
in between.
