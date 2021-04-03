.. title: Miro and GStreamer on gtkx11
.. slug: miro_and_gstreamer_on_gtkx11
.. date: 2008-04-25 21:04:06
.. tags: miro, work

GStreamer has a lot of momentum behind it now and a lot of work has gone
into it over the last year and it's really paying off. As such, Miro 1.5
(the next version) will be the first version of Miro which defaults to
the GStreamer renderer instead of the xine renderer. I'm excited about
this change and in the future we'll be able to drop support for xine
which is one less complexity to deal with.

If you're using the GStreamer renderer in Miro with either trunk or Miro
1.2.3 and discover any problems, let me know. It helps to write up a
bug, but if you're loathe to do that, comment here. Make sure you test
with totem-gstreamer or some other GStreamer movie player as well and
report those results--that helps us determine whether the problem lies
with Miro or possibly elsewhere.

There are probably going to be a few rough edges in the switch and I
could use any help I can get with them.
