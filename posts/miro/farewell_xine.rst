.. title: Farewell, xine
.. slug: farewell_xine
.. date: 2009-12-01 14:49:22
.. tags: miro, work

I've been talking about removing the xine renderer for 6 months now. I
don't do this lightly--generally we want to add features, not remove
them. However, we're a *really* small team of developers working on
Miro and one of the things I'm focusing on for the Miro 2.6 development
cycle is to reduce and simplify wherever we can so that we can focus on
the work ahead of us. Also, the gstreamer folks are doing a fantastic
job and that project is really coming along. I feel very confident that
switching to gstreamer is a good move.

Today is the day I did the deed. As of
`c1c6f33 <https://git.participatoryculture.org/miro/commit/?id=c1c6f3329829a48f9fe776337c107006f73cb49f>`__,
the gtk-x11 platform of Miro no longer uses the xine renderer. This
checkin removes all the xine code from the codebase.

A while back, I threw together a :doc:`VLC renderer <vlc_renderer>`
that mostly works. Other renderers can be built in the same way--the
infrastructure is there for anyone to create new renderers and ship them
as separate packages.

Even though this is a good move, I do realize it leaves some people out
in the cold. If you are interested in championing the xine renderer and
starting a project to build and maintain it, let me know and I'll do
what I can to help out.
