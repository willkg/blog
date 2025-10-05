.. title: Switching from pyup to dependabot
.. slug: pyup_to_dependabot
.. date: 2020-01-14 12:00
.. tags: python, dev, paul-mclendahand, mozilla, story

Switching from pyup to dependabot
=================================

I maintain a bunch of Python-based projects including some major projects like
`Crash Stats <https://crash-stats.mozilla.org>`__, 
`Mozilla Symbols Server <https://symbols.mozilla.org/>`__, and
`Mozilla Location Services <https://location.services.mozilla.com/>`__.
To keep up with dependency updates, we used pyup to monitor
dependencies in those projects and create GitHub pull requests for
updates.

pyup was pretty nice. It would create a single pull request with many
dependency updates in it. I could then review the details, wait for CI to test
everything, make adjustments as necessary, and then land the pull request and
go do other things.

Starting in October 2019, pyup stopped doing monthly updates. A co-worker tried
to contact them to no avail. It's unclear what happened, but we couldn't
continue to wait.

Since my projects are all on GitHub, we had already switched to GitHub security
alerts. Given that, I decided it was time to switch from pyup to dependabot
(also owned by GitHub).


The process
===========

I had to do a bunch of projects, so I ended up with a process along these lines:

1. **Remove projects from pyup.**
   
   All my projects are either in ``mozilla`` or ``mozilla-services`` organizations
   on GitHub.

   We had a separate service account configure pyup, so I'm not able to make
   changes to pyup myself.

   I had to ask Greg to remove my projects from pyup.

   I wouldn't suggest proceeding until you've removed your project from pyup.
   Otherwise, it's possible you'll get PRs from pyup and dependabot for the
   same updates.

2. **Add dependabot configuration to repo.**

   Then I added the required dependabot configuration to my repository and
   removed the pyup configuration.

   I used these resources:

   * configuration documentation `<https://dependabot.com/docs/config-file/>`__.
   * configuration validator `<https://dependabot.com/docs/config-file/validator/>`__.

   I created a pull request with these changes, reviewed it, and landed it.

3. **Enable dependabot.**

   For some reason, I couldn't enable dependabot for my projects. I had to
   ask Greg who I think asked Hal to enable dependabot for my projects.

   Once this was done, then dependabot created a plethora of pull requests.


While there are Mozilla-specific bits in here, it's probably generally helpful.


Dealing with incoming pull requests
===================================

dependabot isn't as nice as pyup was. It can only update one dependency per PR.
That stinks for a bunch of reasons:

1. working through 30 PRs is extremely time consuming
2. every time you finish up work on one PR, it triggers dependabot to update
   the others and that triggers email notifications, CI builds, and a bunch of
   spam and resource usage
3. dependencies often depend on each other and need to get updated as a group

Since we hadn't been keeping up with Python dependencies, we ended up with between
20 and 60 pull requests to deal with per repository.

For Antenna, I rebased each PR, reviewed it, and merged it by hand. That took
a day to do. It sucked. I can't imagine doing this four times every month.

While working on PRs for Socorro, I hit a case where I needed to update
multiple dependencies at the same time. I decided to write a tool that combined
pull requests.

Thus was born `paul-mclendahand <https://github.com/willkg/paul-mclendahand>`__.
Using this tool, I can combine pull requests. Using paul-mclendahand, I worked
through 20 pull requests for Tecken in about an hour. This saves me tons of time!

My process goes like this:

1. create a new branch on my laptop based off of the main branch
2. list all open pull requests by running ``pmac listprs``
3. make a list of pull requests to combine into it
4. for each pull request, I:

   1. run ``pmac add PR``
   2. resolve any cherry-pick conflicts
   3. (optional) rebuild my project and run tests

5. push the new branch to GitHub
6. create a pull request
7. run ``pmac prmsg`` and copy-and-paste the output as the pull request
   description

I can then review the pull request. It has links to the other pull requests and
the data that dependabot puts together for each update. I can rebase, add
additional commits, etc.

When I'm done, I merge it and that's it!


Releasing paul-mclendahand v1.0.0
=================================

I released `paul-mclendahand <https://github.com/willkg/paul-mclendahand>`__ 1.0.0!

Install it with `pipx <https://pypi.org/project/pipx/>`__::

    pipx install paul-mclendahand

Install it with pip::

    pip install paul-mclendahand

It doesn't just combine pull requests from dependabot--it's general and can
work on any pull requests.

If you find any issues, please report them in `the issue tracker
<https://github.com/willkg/paul-mclendahand/issues>`__.

I hope this helps you!
