.. title: Python Miro Community year in review and fund drive 2011
.. slug: call_for_funding_2011
.. date: 2011-02-18 14:15:08
.. tags: pmc, dev, miro, mirocommunity, python

**Year in review**

First off, let's talk about the year in review. I started Python Miro
Community (`Python Miro Community <http://python.mirocommunity.org/>`__)
a little over a year ago. In that time, Python Miro Community has grown
to around 550 videos spanning the last few years, several local user
groups, and a lot of conferences. Google Analytics says the site
averages 150 unique visitors every day since I added Google Analytics.
People end up at Python Miro Community from sites like Reddit and
StackOverlfow and also searches at various search sites.

At this point, if you haven't visited the site or don't know what I'm
talking about, please go take a look now.

http://python.mirocommunity.org/

This site has been been immensely useful to me. My knowledge of Python
and what's going on in the greater Python community has grown leaps and
bounds from watching videos I've discovered through Python Miro
Community. Site usage statistics suggest that I'm not the only one.

Given that I spend 10-20 hours per month working on this site and that
it's come this far, I think it's been a success.

The future looks good. If I continue putting in the effort that I'm
putting in now, the site will continue to grow and will continue to
become more useful to people as the corpus of video increases.

However, Miro Community (`Miro Community <http://mirocommunity.org/>`__)
is switching to a tiered service model at which point my free ride ends
and I think with some funding, we could improve this site to be a lot
better than it is currently. So let's talk about funding.

**Call for funding**

I haven't had to pay anything for Participatory Culture Foundation
(http://pculture.org/) to host PMC for the last year. This is in part
because they've been ramping up the service to a point where it's
commercially useful. This is also in part because I work for
Participatory Culture Foundation and so they've let me slide. Going
forward, the service level that PMC uses will cost $75 per month ($900 a
year).

Carl and I have been talking about this site as the last mile for
conference video. Conferences often have an A/V crew that spends a ton
of time recording conference sessions, doing a lot of production and
post-production work and then post the video somewhere on the Internet.
There's conference video in a bunch of different places, it's often
missing metadata that makes it discoverable (is that a word?), and a few
months after the conference is over, the video doesn't get much play
time. There are a bunch of things Carl and I want to do to improve this
situation:

#. **Integrate `Universal
   Subtitles <http://universalsubtitles.org/>`__ into Python Miro
   Community.**

   This allows the community to transcribe and translate videos using
   their browser. I doubt this will cause all videos to be translated,
   but I bet the more popular/useful ones will be. That could be huge!
   Further, since we'd be using Universal Subtitles, the subtitling
   widget would be available wherever the video is embedded--it won't be
   PMC-specific. This would do a lot towards making these videos
   accessible to a much larger audience.

#. **For videos that have transcriptions, use the transcriptions as part
   of the video search corpus.**

   This would make it easier to find videos that talk about specific
   things that aren't covered in the description and tags. Further, we
   could provide the moment in time in the video where those terms were
   brought up.

#. **Implement an API in Miro Community upstream that allows us to
   automate data validation.**

   Data validation so far has been a total pain in the ass because it
   has to be done by hand. With 550 videos, that's not feasible unless I
   spend a lot of time on it. An API would allow me to write scripts to
   automate the data validation and make the site data better.

   For example, the media file urls are out of date for a lot of the
   video right now. I wrote a script to validate them, but I only have
   access to the last 30 items in any of the RSS feeds. Thus I can't
   validate items in larger RSS feeds.

Additionally, I want to work on building playlists that connect videos
between conferences. A playlist of David Beazley's GIL talks would be
really interesting. A playlist of Django-related videos allowing someone
to come up to speed with Django would be really helpful. A playlist of
advanced Python topics could take someone familiar with Python and bump
them up to a pro.

I really can't do this without funding, though.

Ultimately, I'd love to raise $3000 which would go towards paying for
the Miro Community service and also fund work on some/many/all of the
above projects. I had talked about this a little in `my last status
report <http://bluesock.org/~willkg/blog/pmc/status_20110122.html>`__
but I hadn't figured out how it was going to work.

In the next few days, I'm going to set up a Pledgie project and update
the templates on Python Miro Community so that every page has the
Pledgie project badge at the top. At that point, I encourage everyone to
check out the site and if they like what they're seeing, to pledge $5.
Anyone who donates gets their name on the Donors list that will probably
be on the About page.

Also, if there are companies that are interested in sponsoring Python
Miro Community for a year, I'd be really interesting in talking to you.
