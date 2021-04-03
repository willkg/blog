.. title: firefox 3 and enclosures (recap)
.. slug: firefox_3_and_enclosures__recap_
.. date: 2008-05-17 13:03:43
.. tags: miro, work, dev

Back in December and January, I worked on some patches for Firefox 3 that
enhanced the feed preview page.  I wrote :doc:`a post about it
<firefox3_enclosures>` back then, but I'm updating that post with recent
screenshots and a better description of the work.  The previous post was mostly
about how great FOSS is.

The patches fell into two big features.  First, I added enclosure detection to
the FeedProcessor and then modified FeedWriter to show enclosures alongside the
entries.  This has two huge benefits: it allows you to easily tell if the feed
has enclosures and it allows you to see what they are, how big, what type of
media, ...

Second, I modified Firefox so that it allows you to associate video podcasts
with an application, audio podcasts with another application, and all other
kinds of feeds with a third application.  The benefit here is that you can send
media podcasts to an application that handles that well (*cough*Miro*cough*)
and regular news feeds to a different application that handles that well.

Screenshot of Firefox 2 feed preview page:

.. thumbnail:: /images/firefox2_enclosures.png

   Firefox 2 feed preview page

Screenshot of Firefox 3 feed preview page:

.. thumbnail:: /images/firefox3_enclosures.png

   Firefox 3b5 feed preview page

Of the two features, I hear the most comments about the first one mostly along
the lines of, "I'm so glad I don't have to view source to see the enclosures
anymore!"  The second feature isn't as immediately exciting.  The
implementation of distinguishing feeds is intentionally simple and there are a
lot of corner cases where it doesn't work very well.  Also, there aren't many
applications that can really take advantage of it.  I expect this second
feature to flourish as Firefox development continues and video/audio podcasting
evolves.
