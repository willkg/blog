.. title: Status 09/08/2007
.. slug: status.09082007
.. date: 2007-09-08 08:49:06
.. tags: content, hardware, pyblosxom, dev

I ordered a Seagate Barracuda Ultra ATA/100 drive from Amazon.com the
other day and it arrived today. I opened it up to discover it's a PATA
drive. However, I thought I ordered an ATA drive and not a PATA
drive.... Long story short after an hour of researching and finally
calling up a friend who does hardware work, I discovered that "they"
renamed ATA to PATA so that it won't be confused with SATA. No one sent
me the memo.

I was at Tag's Hardware in Porter Square (Cambridge, MA, USA) to buy
Poly-acrylic for some shelves I'm putting up and they're selling decent
bookshelves for $20.00. We bought one--it's pretty sturdy and it folds
up for moving/storage/whatever. They probably have more left if you're
in the area and interested.

I've been working through PyBlosxom stuff. I updated the web-site to use
PyBlosxom 2.0-dev (in trunk). We worked through entry caching plans on
the mailing list and implemented most of them. We've also been
discussing and working through template variable syntax and semantics.
I've been adding new unit tests and using tests to help work out the
design issues. The testing framework has made it so much easier to do
development work.

I've been writing a todo-list-tracking application in Django. I'm
hitting a point where it's half-implemented, but I'm thinking I may
switch back to Pylons because it's Paste-friendly and easier to deal
with.

Bunch more stuff, but it'll be in separate entries.
