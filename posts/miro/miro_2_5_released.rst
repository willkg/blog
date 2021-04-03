.. title: Miro 2.5 released!
.. slug: miro_2_5_released
.. date: 2009-07-23 18:58:57
.. tags: miro, work

We released Miro 2.5 today. It's a great release and a big step for
Miro. My favorite features are:

* audio playback that doesn't suck
* handling for torrents that have folders and multiple files in them
* video/audio tabs instead of new/single
* totally redone database layer

The last feature is a big deal--we rewrote the entire storage layer for
Miro to do it. Miro went from a pickled Python object database to a
relational database. With the new database system, you can do things
like this:

.. code-block:: shell

   willg@mercury:~/.miro$ sqlite3 sqlitedb
   SQLite version 3.6.10
   Enter ".help" for instructions
   Enter SQL statements terminated with a ";"
   sqlite> select count(*) from feed;
   23
   sqlite> select origUrl from feed;
   dtv:manualFeed
   dtv:singleFeed
   dtv:search
   dtv:searchDownloads
   dtv:directoryfeed
   http://www.fileden.com/files/2008/5/14/1911312/timostrailers.rss
   http://feeds.feedburner.com/Gitcasts
   http://www.youtube.com/rss/user/googletechtalks/videos.rss
   http://feeds.feedburner.com/Screencastersheathenxorg
   http://www.whitehouse.gov/rss/speeches.xml
   http://www.hd-trailers.net/blog/feed/
   http://pycon.blip.tv/rss
   http://feeds.feedburner.com/CSS-Tricks-Screencasts
   http://www.g4tv.com/xplay/podcasts/6/XPlay_Daily_Video_Podcast.xml
   http://feeds.theonion.com/OnionNewsNetwork
   http://www.npr.org/rss/podcast.php?id=35
   http://feeds2.feedburner.com/YourWorldIn5-itunes
   http://g4tv.com/cinematech/podcasts/8/G4_TV_Cinematech_Video_Podcast.xml
   https://fedorahosted.org/releases/f/e/fedoratv/fedora-tv.xml
   http://openmeetings.org/archives/ovc2009-sessions-mirofeed.rss
   http://ubuntudevelopers.blip.tv/rss
   http://makezine.com/blog/archive/make_podcast/index.xml
   http://www.podshow.com/feeds/gbtv.xml
   sqlite>

This is the first big step in making Miro more hackable and more
accessible to projects like Coherence, Elisa, and others. It'll also
make it a lot easier to debug database problems in the future.

**Note:** After you've upgraded to Miro 2.5, Miro will upgrade your
database to the new structure on the first startup. This takes a long
time depending on how big your database is. Just let Miro hang out and
do its thing. The epic fail here is that there's no ui indication that
Miro has started and is upgrading the database. I'm hoping we'll fix
that soon.

I hope you're happy with the improvements in Miro 2.5. We're not resting
there--work has already begun on Miro 2.6.
