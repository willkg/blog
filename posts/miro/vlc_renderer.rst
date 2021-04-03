.. title: VLC Renderer for Miro on gtk-x11
.. slug: vlc_renderer
.. date: 2009-07-16 17:24:28
.. tags: miro, work, python

I threw together a VLC renderer for Miro on gtk-x11 based on the VLC
renderer code we use for Miro on Windows. It took an hour or so to get
it working.

I'd love to toss it in into Miro, but it's got one major problem and one
minor one.

The major problem is that VLC handles mouse events rather than letting
them bubble up to Miro. When you double-click on the a video, VLC
handles the double-click and switches the video to fullscreen (or out of
fullscreen). It'd be better if Miro handled this--then it could show the
media item details bar. Also, VLC handles mouse movement. Miro needs to
handle this, too, so then it can show the item details bar.

The minor problem is that VLC doesn't have ``libvlc_video_track_count``
in versions prior to 1.0. I'm not sure how else to figure out if a media
file has video tracks in it. Because of this, the sniffer code is pretty
ham-fisted if you have earlier versions of VLC.

The code is at
`http://bluesock.org/~willg/download/vlcrenderer.py <http://bluesock.org/~willkg/download/vlcrenderer.py>`__
if you're interested in fiddling with it. There's documentation at the
top of the file that walks through installing and using it.

I'd love to get some help fixing it. Adding support for VLC and dropping
support for xine on gtk-x11 would make things a lot easier for us Miro
devs.
