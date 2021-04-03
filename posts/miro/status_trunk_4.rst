.. title: status trunk (4)
.. slug: status_trunk_4
.. date: 2008-08-08 10:35:03
.. tags: miro, work

Things are progressing. I landed the last of the menu handling changes,
Ben did a bunch of Mac OSX tweaks and Windows tweaks, there's been work
on playing videos, Ben re-worked how we deal with resizing thumbnails so
it no longer uses imagemagick and no longer generates lots of files in
the icon-cache, and there have been a lot of bug fixes as well.

On Tuesday, a bunch of us got together in Worcester for the Miro Summit
and worked out some things including the plan going forward. From that
discussion, Nick wrote up a list of must-have features that need to be
re-implemented before we want to get functional testing going. This list
is likely to change, but here it is generally speaking:

* Preference window
* Chrome Search
* search tab
* within channel search and save
* search all for search engines
* fullscreen playback
* ff / rw / seeking
* hook up volume control to playback renderer
* download tab: Pause all, resume all, cancel all -- Top bar display,
  download / upload rate -- External Downloads section in main view
* channel details view

From that list, Chris Webber is working on a patch for channel details
view which I think is close to done. I think I'm going to tackle
Preferences next. I'm not sure what other items are spoken for. I'm also
not sure how much time it will take to tackle all of these--maybe a
month?

That brings me to my next two points:

First, I know it's taking us a long time to get things done, but it'd be
faster if we/I didn't have to answer issues along the lines of "are you
done yet?" and "i tested xyz nightly and the following things don't
work...".

I really appreciate the fact that you all are eager to help out with
Miro development and I really apologize for the frustration that comes
with not being able to do anything and having to wait around for a
while. We're working as hard as we can, but it's just going to take
time. I'm in this weird position where I want to maximize the time I'm
spending doing the work and minimize the time I'm spending talking about
it and managing it, but I don't want to leave you in the dark about
where we are. It's a tough thing to balance especially where I'm trying
to minimize the time I spend thinking about balancing. ;)

Oddly, I bumped into `this post on 43
Folders <http://www.43folders.com/2008/08/05/bad-correspondent>`__ which
I think is pretty relevant here.

The second thing is that we've had a lot of help from Chris Webber over
the last few months. He's been working in his spare time to come up to
speed with the new widget code and help re-implement functionality. His
efforts are fantastic, the quality of his work is solid, and he's
absolutely making a big dent in our ability to finish the work faster.
You can see the efforts of his work
`here <https://develop.participatoryculture.org/trac/democracy/search?q=chris&noquickjump=1&changeset=on>`__--I
refer to him in the checkin comments as "Chris", "Christopher" and
"Chris Webber". Thank you Chris!

That's it for this update!
