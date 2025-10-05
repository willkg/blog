.. title: rob-bugson 1.0: or, How I Wrote a WebExtension
.. slug: rob_bugson_1.0
.. date: 2017-10-19 12:00
.. tags: mozilla, work, story

I work on Socorro and other projects that use GitHub for version control and
code review and use Mozilla's Bugzilla for bug tracking.

After creating a pull request in GitHub, I attach it to the related Bugzilla bug,
which is a contra-dance of clicking and copy-and-pasting. `Github tweaks for
Bugzilla
<https://addons.mozilla.org/en-US/firefox/addon/github-tweaks-for-bugzilla/>`_
simplified that by adding a link to the GitHub pull request page that I could
click on, edit, and then submit the resulting form. However, that's a legacy
addon and I use Firefox Nightly, and it doesn't look like anyone wrote a
WebExtension version of it, so I was out-of-luck.

Today, I had to bring my car in for service and was sitting around at the
dealership for a few hours. I figured instead of working on Socorro things, I'd
take a break and implement an attach-pr-to-bug WebExtension.

I've never written a WebExtension before. I had written a couple of addons years
ago using the SDK and then Jetpack (or something like that). My JavaScript is a
bit rusty, especially the ES6 stuff. I figured this would be a good way to learn
about WebExtensions.

It took me about 4 hours of puzzling through docs, writing code, and debugging,
and then I had something that worked. Along the way, I discovered exciting
things like:

* host permissions let you run content scripts in web pages
* content scripts can't access ``browser.tabs``--you need a background script
  for that
* you can pass messages from content scripts to background scripts
* seems like everything returns a promise, but async/await makes that a lot
  easier to work with
* the attachment page on Bugzilla isn't like the create-bug page and ignores
  query string params

The MDN docs for writing WebExtensions and the APIs involved are fantastic. The
WebExtension samples are also great--I started with them when I was getting my
bearings.

I created a new GitHub repository. I threw the code into a pull request, making
it easier for someone else to review it. Mike Cooper kindly skimmed it and
provided insightful comments. I fixed the issues he brought up.

TheOne helped me resurrect my AMO account, which I created in 2012 back when Gaia
apps were the thing.

I read through `Publishing your WebExtension
<https://developer.mozilla.org/en-US/Add-ons/WebExtensions/Publishing_your_WebExtension>`_,
generated a ``.zip``, and submitted a new addon.

About 10 minutes later, the addon had been reviewed and approved.

Now it's a thing, and you can `install rob-bugson
<https://addons.mozilla.org/en-US/firefox/addon/rob-bugson/>`_.
