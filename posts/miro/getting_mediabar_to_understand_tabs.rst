.. title: getting mediabar to understand tabs
.. slug: getting_mediabar_to_understand_tabs
.. date: 2007-09-26 16:09:04
.. tags: miro, work

I've been working on getting the Mediabar to be tab-friendly over the
last few days. Currently Mediabar re-discovers all the media on a page
every time a user goes to a new url (by clicking or entering something
new in the location bar) and when the user switches tabs. That's the
behavior that I'm working on fixing.

In order to fix it, I'm doing a minor redesign of how Mediabar works
internally. I've been hanging out on ``#xul`` and ``#extdev`` on
``irc.mozilla.org`` and picking up interesting tidbits of information.

After I fix this issue, there are a bunch of minor issues to fix and
then I think it'll be golden. I think it's going to take another few
days at least--probably more on the order of another week.
