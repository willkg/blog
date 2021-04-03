.. title: Handling media keys in GNOME with Python
.. slug: gnome_media_keys
.. date: 2010-01-25 14:11:17
.. tags: dev, python, work, miro, gnome

Spent a while figuring out how to get `Miro <http://getmiro.com/>`_
to handle media keys in Gnome.  My current understanding (and this could
be entirely wrong) is that as of 2.18, Gnome handles the multimedia keys.
In order for your application to respond to multimedia keys, you have to
connect to the signal through dbus.

My biggest problem is that my web searching revealed a lot of bugs, but
no documentation.  I did finally find 
`Handling multimedia keys in GNOME 2.18 <http://www.vimtips.org/12/>`_
and then worked out the rest.  I still have no clue where to find the
documentation for it.

Here's what I got working:

.. code-block:: python

   import logging
   import dbus

   from miro import app

   class MediaKeyHandler(object):
       def __init__(self, window):
           self.app = "Miro"
           self.bus = dbus.Bus(dbus.Bus.TYPE_SESSION)
           self.bus_object = self.bus.get_object(
               'org.gnome.SettingsDaemon', '/org/gnome/SettingsDaemon/MediaKeys')

           self.bus_object.GrabMediaPlayerKeys(
               self.app, 0, dbus_interface='org.gnome.SettingsDaemon.MediaKeys')

           self.bus_object.connect_to_signal(
               'MediaPlayerKeyPressed', self.handle_mediakey)

           window.connect("focus-in-event", self.on_window_focus)

       def handle_mediakey(self, application, *mmkeys):
           if application != self.app:
               return
           for key in mmkeys:
               if key == "Play":
                   app.widgetapp.on_play_clicked()
               elif key == "Stop":
                   app.widgetapp.on_stop_clicked()
               elif key == "Next":
                   app.widgetapp.on_forward_clicked()
               elif key == "Previous":
                   app.widgetapp.on_previous_clicked()

       def on_window_focus(self, window):
           self.bus_object.GrabMediaPlayerKeys(
               self.app, 0, dbus_interface='org.gnome.SettingsDaemon.MediaKeys')
           return False

   def get_media_key_handler(window):
       """
       Creates and returns a MediaKeyHandler or returns None if such a thing
       is not available on this platform.

       :param window: a Gtk.Window instance
       """
       try:
           return MediaKeyHandler(window)
       except dbus.DBusException:
           logging.exception("cannot load MediaKeyHandler")


If you see problems with this, let me know so I can ammend the code.

**Update:**

November 5th, 2010 - Fixed a bug in the code.

November 9th, 2010 - Tweaked the code to re-assert key handling on focus.
