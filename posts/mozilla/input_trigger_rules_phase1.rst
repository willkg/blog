.. title: Input: Trigger rule project Phase 1
.. slug: input_trigger_rules_phase1
.. date: 2015-10-02 12:00
.. tags: mozilla, work, dev, python, input, story


Summary
=======

Last quarter, I finished up the suggester framework for Input. When a
user leaves feedback, registered suggester modules would look at the
feedback metadata and text and return suggested links. The suggested
links would then show up on the Thank You page. Users could then read
a bit about the link and click on it if it was appealing.

The first suggester I wrote does a search against SUMO kb articles to
see if any of the kb articles seemed relevant to the feedback. Users
frequently leave feedback about problems they're having that could be
known issues with known solutions or even problems Firefox solves with
features the user wasn't aware of. Because of this, it behooves us
greatly to guide these users to the solutions that make their Firefox
experience better. :doc:`I wrote a post about that <input_thankyou_phase1>`.

This project covers adding a new suggester that allows analyzers to
set up trigger rules for suggestions which is stored in the
database. When feedback matches the criteria for a trigger rule, then
the suggestion is shown.

I pushed out the last code changes on September 9th, 2015. On
September 25th, we created a trigger rule for feedback talking about
Norton's addon and suggested a link for a SUMO kb article that talks
about the problem. In the 5 days, 22 people saw the suggestion and
6 clicked on the link.

This blog post is a write-up for the `Trigger rule project phase 1
<https://wiki.mozilla.org/Firefox/Input/Trigger_suggester>`_.

.. TEASER_END


What are we trying to do here?
==============================

We need a system that lets us suggest links to users who are leaving
feedback with certain criteria. We need to be able to generate these
trigger rules quickly and we need to be able to analyze the success of
the suggested links.

There are a bunch of interesting use cases for this system:

* Identify video playback issues and solicit more information on
  specifics.
* Identify webcompat issues and suggest user fill out a webcompat
  form.
* Identify known hot-fix issue and send user to documentation on how
  to fix it.
* Identify users with issues about a specific feature and send them to
  a survey with specific questions about their issues.

We need an interface that shows all trigger rules, lets users create
new trigger rules, lets users edit existing trigger rules and lets
users test trigger rules without making them live.

* project page: https://wiki.mozilla.org/Firefox/Input/Trigger_suggester
* :bz:`1198758` [tracker] trigger suggester project


Reducing to a minimum viable thing
==================================

The rules engine
----------------

Writing rules engines is hard. You can get a feel for the hardness by
looking at all the different systems you use for search: search
engines, search in bug systems, search in email clients, search in
music applications, etc. Some have very complicated forms that let you
string together a series of clauses with ANDs and ORs and express a
variety of different searches. Some have a complicated search syntax
that's a mish-mash of English, algebra, set-theory and wishful
thinking. Some are very sophisticated and you spend gobs of time
tinkering with the various knobs to express the search you need
to. Some are clunky and you spend gobs of time trying to coerce the
system through hacky shenanigans into expressing a search it's clearly
not meant for [#]_. It's a tough problem.

To build a rules engine that solves all the possible use cases will
take forever. I claim we can build a simple-ish engine that solves 80%
of our important use cases and it'll be good enough for
now. Ultimately, we want a rules engine that takes less than two weeks
to design and implement, covers the use cases that have the most
impact and is easy to use and reason about for the people building
rules.

All of this is further complicated by the user interface. Since rules
will be created by people and there are consequences for building
rules incorrectly, we needed an interface that is easy to use and
easy to verify correctness with.

The use cases suggest we need the engine to look at the following
feedback metadata:

* locale
* product
* product version
* existence of keywords/phrases in the feedback description
* whether or not there is a url

We want rules to apply to multiple things so we don't have to create a
rule for every variation of the situation. For locale, product, product
version and keywords, we want to OR each possibility. For example, "feedback
where product='Firefox' OR product='Firefox for Android'".

Version is a little harder since we want to be able to group versions
rather than have to specify each one. For example, we want to design
rules that apply to all 41 versions rather than 41.0.1, 41.0.2,
41.0.3, 41.1, etc.

Keywords and phrases is a tough one because we want to cover all the
possible ways a user could express the thing, but we're hampered by
the fact that we have to do the matching in Python code. We can't do a
db lookup--takes too long. We can't do an Elasticsearch query--takes
too long plus the feedback probably isn't in Elasticsearch, yet.

I decided to fudge this one and put the keywords and phrases into a
regular expression that's case-insensitive and unicode-aware. That
should cover most use cases, though it will probably be awkward. It
won't cover misspellings which we see often in feedback and it won't
cover matching variations of phrases (e.g. "quick fox" and "quick
brown fox") unless we explicitly list all the variations. Those are
big limitations, but after looking at the data and use cases, I
decided to push them off because I think we get a lot of value out of
what we can express with regular expression matches.

URL checking will be pretty basic for now and have three values:

1. I don't care if the feedback has a url or not
2. the feedback has a url
3. the feedback does not have a url

At some point we might want to add domain matching so we can better
catch webcompat issues. I'm pushing that off for now.
   
I spent some time fiddling with things and decided the easiest engine
to build would look at locale, product, product version, existence of
keywords/phrases and url as clauses ANDed together.

Example rule 1::

  locales = en-US
  products = Firefox
  keywords = rc4

This matches feedback where:

1. the locale is ``en-US``
2. AND the product is ``Firefox``
3. AND the keyword ``rc4`` is in the description

Example rule 2::

  locales = es,pt
  products = Firefox,Firefox for Android
  keywords = word1,word2,word3,"this is a phrase"

This matches feedback where:

1. the locale is either ``es`` OR ``pt``
2. AND the product is either ``Firefox`` OR ``Firefox for Android``
3. AND either ``word1``, ``word2``, ``word3`` or ``this is a phrase``
   show up in the description

This system won't handle the following situations:

1. "this but not that" in a clause
2. misspellings in the feedback description
3. product/version pairs

The first two can't be handled by this system at all.

The third item can be handled by splitting the trigger rule into
multiple rules of smaller scope.

I talked this over with the User Advocacy group and we agreed that
this system is worth building and that it's useful enough for a
first pass.

.. [#] And you wonder whether it was actually meant to successfully
       search anything at all.


The interface for creating, editing and testing rules
-----------------------------------------------------

Creating and editing should be easy to implement; it's a basic CRUD
interface with a view that lists existing rules with links to edit
them and a link to create new rules. That should be straight-forward.

The thing I spent a lot of time thinking about was figuring out how to
test rules. I think there are two ways to test a given rule:

1. See if the rule matches a specific feedback.

2. See what existing recent feedback the rule matches.

I think if I implement the second one, then that might be
sufficient. Otherwise I have to figure out a way to specify the
feedback to match in a way that doesn't require analyzers to add fake
feedback to Input. Seems overly tricky.
   

Throwing it all together
========================

The infrastructure for suggesters and redirectors already exists, so
we just have to implement a new suggester and a new redirector for the
trigger rule suggester. Then we need to implement some forms one of
which allows us to test trigger rules against existing feedback. Since
this is only available to analyzers, I'm going to cut some UI/UX
corners around "prettiness"; usable is important, but pretty is not.

The list page looks like this:

.. thumbnail:: /images/input_trigger_list.png

   Trigger rule listing.
   
The testing looks like this:

.. thumbnail:: /images/input_trigger_test.png

   Trigger rule creating and testing.

For testing rules, I wanted:

1. users to see the matched feedback while editing the rule
2. need to be able to test rules without saving them

A modal overlay would break requirement 1. I could have matched
feedback open up in a new tab, but that makes it hard to see the
matched feedback and the trigger rule at the same time--you'd have to
go back and forth. I could put the matched feedback above or below the
trigger rule, but I think that's kind of the same as putting it in a
new tab--you'd be flipping back and forth a lot. I settled on putting
it on the right side. That seems good enough for now. I'll have the
analyzers test it out and see whether it works for them or whether
it's clunky.


Possible future work
====================

There are a bunch of things that I didn't implement. Some of them I
waffled over whether they should be part of the initial
implementation. Others I knew shouldn't be part of the initial
implementation because there was no compelling need for them. We'll
see how it gets used and what new use cases come up and figure out how
to augment the initial implementation going forward. Software is a
malleable thing.

* Supporting "this, but not that" clauses would probably be useful.

* It might also be helpful to be able to search with the analyzer
  search and then when you've got a search you like, turn that into a
  trigger rule. There are some huge technical issues with that, but
  nonetheless, it'd be a really great flow to support.

* Event flow is stored in Google Analytics. It'd be great to pull that
  data out and display it alongside the trigger rule in the list view
  page so that analyzers could see how many people saw the suggestion
  and how many people clicked on the link.

* Maybe it's helpful to have a report view for trigger rules that
  shows the number of people that saw the suggestion and the number of
  people that clicked over time.

* Links consist of a title and a description. Users only click on
  links that are attractive to them. For some use cases, we really
  want users to click on the link--perhaps there's some problem out
  there that we really need more information on. Changing the system
  so that we can iterate on making the title and description better
  would help here.

* Each suggestion is displayed with an icon. Suggestions are not all
  equal. There might be suggestions we really want users to click on
  for really important reasons. Perhaps the user is using a version of
  Firefox that they should upgrade because it has known security
  issues. Perhaps the user is leaving feedback on a problem we
  desperately need more help with. It'd be helpful to be able to
  specify which icon is displayed with the suggestion.

* Maybe it's helpful to show suggestions only some percent of the
  time? Maybe it's helpful to have two variations of a suggestion and
  show one 50% of the time and the other the other 50% of the time? Do
  we need to bake in A/B type testing into the system?

* Maybe it's helpful to have start and end dates for suggestions
  allowing us to do "campaigns"?


Conclusion
==========

Took a while to build this, but I think the impact of this feature
will be pretty high. The point at which someone has left feedback is a
magical touch point after which it's difficult to communicate with that
person. The trigger rule suggester gives us a way to help users who
are having problems as well as a way for us to solicit help on
problems that are difficult and complex. That's a big deal.
