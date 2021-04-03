.. title: status of Miro 1.1.1 builds for Ubuntu
.. slug: status_of_miro_1_1_1_builds_for_ubuntu
.. date: 2008-01-24 00:22:07
.. tags: miro, work, ubuntu

I put out Gutsy, Feisty and Dapper builds for i386 for Miro 1.1.1 on
Tuesday when we did the Miro 1.1.1 release. But... I'm using new scripts
and I goofed up the miro-data package. I didn't have time to figure out
the problem, so I attempted to back out the Gutsy amd64 packages and in
the process screwed up something else.

I thought I had it all working by Tuesday night, but there were a couple
of users that were still experiencing "size mismatch" errors on the
miro-data package. So I took some time today to figure out how to deal
with the miro-data package I was building, roll up a set of Miro 1.1.1-3
packages for Gutsy i386 and amd64 and push everything out.

Theoretically there should be good Gutsy i386 and amd64 packages for
Miro 1.1.1 in addition to the Feisty and Dapper i386 packages I rolled
out Tuesday.

Sorry for the delays. I think things are straightened out now. If you're
still having problems feel free to leave a comment below and/or find me
on IRC or by email.
