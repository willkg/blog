.. title: status (5)
.. slug: status_5
.. date: 2008-08-15 15:32:16
.. tags: miro, work

Progress went well this week. We've been working on the missing
functionality, fixing bugs, removing dead code, cleaning up existing
code, and generally progressing on Miro 2.0 development.

Last week, I wrote up the list of must-have features before Miro is
ready for testing. We finished the following items:

* diagnostics dialog.
* open_file needs to be implemented in the OSX Application class for
  "show" and other things to work.
* fullscreen playback
* hook up volume control to playback renderer
* Make playback take over the whole window on GTK
* search tab
* show/hide details - needs to be fixed on OSX
* download tab: pause all, resume all
* download tab: Top bar display, download / upload rate

And fixed a bunch of bugs. Ben did some optimization work on OSX, too.
Some of those are new items added to the list in the last week. Some of
them are smaller chunks of existing items.

We have the following list of things to do still:

* Preference window
* Chrome Search
* within channel search and save
* ff / rw / seeking
* download tab: External Downloads section in main view
* show/hide details - Needs seeders and leechers info for torrents
* Channel Settings
* overlay playback controls on OSX (including fullscreen button)

You can follow the progress `on the
timeline <https://develop.participatoryculture.org/trac/democracy/timeline>`__.
