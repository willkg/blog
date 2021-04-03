.. title: Proposal: LDAP password resets as a unit of measure
.. slug: ldap_pwd_resets_as_a_unit_of_measure
.. date: 2013-05-18
.. tags: mozilla, work

Backstory
=========

Every 3 months, we at Mozilla have to reset our LDAP passwords. The
system helpfully sends the first reminder 2 weeks before your password
expires, then the second reminder 1 week before your password expires
and the last reminder 2 days before your password expires.

Sometimes time passes by faster than you know and you end up with
a `Locked out of LDAP account
<https://badges.mozilla.org/en-US/badges/badge/Locked-out-of-LDAP-account>`_.

The 3 month LDAP password reset is such a large part of our lives that
I propose it become a standard unit of measure for elapsed time.


Usage
=====

Used in casual conversation:

.. code::

   Pat: Hi!

   Jordan: Hi!

   Pat: I haven't seen you before. How long have you been at
   Mozilla?

   Jordan: I've been here for 6 LDAP password resets.

   Pat: Oh, weird. I've been here for 7. Good to meet you!
   Would you like a banana?

   Jordan: Would I ever!


Used in casual conversation on IRC:

.. code::

   <patbot> anyone use less?
   <corycory> i only use sass. it's the best.
   * riledupriley has quit (Quit: riledupriley)
   <patbot> :(
   <hugbot> (patbot)
   * r1cky has joined #casualconversationexample
   <r1cky> morning!
   <nigelb> r1cky: hai!
   <nigelb> Ah, it's nearly mfbt.
   <mtjordan> sure. been using it for 3 ldap password resets.
   <mtjordan> patbot: why do you ask?


Used in Bugzilla comments:

.. code::

   Jordan [:jordan]  1 day ago       Comment 0 [reply] [-]
   
   Readonly mode causes the site to ISE.


.. code::

   Pat [:pat]  1 day ago             Comment 1 [reply] [-]

   I looked into it. Turns out we haven't used readonly
   mode in at least 4 LDAP password resets.

   I think we just need to add a fake authentication
   module. Easy peasy.


Used when joining a new group:

.. code::

   From: Pat
   To: some-group@mozilla.org
   Subject: Welcome Jordan to some-group!

   Hi all!

   I'd like to welcome Jordan to some-group! Jordan brings
   expertise that is invaluable. I'm excited! Yay!

   Jordan: Tell us about yourself!

   Pat


.. code::

   From: Jordan
   To: some-group@mozilla.org
   Subject: Re: Welcome Jordan to some-group!

   Hi!

   I'm excited to join some-group! Hopefully I bring something
   useful to the table.

   I've been at Mozilla for 7 LDAP password resets, I like
   top-posting and I make a mean cold brew coffee.

   Looking forward to my first meeting!

   Jordan


   On Blah blah blah at blah blah blah, Pat wrote:
   > Hi all!
   >
   > I'd like to welcome Jordan to some-group! Jordan brings
   > expertise that is invaluable. I'm excited! Yay!
   >
   > Jordan: Tell us about yourself!
   >
   > Pat


Used in an email to everyone@ about departing:

.. code::

   Dear everyone!

   It is with sadness that I tell you I'm leaving as of next
   Friday. As you know, I've been with Mozilla for 32 LDAP
   password resets and frankly, I'm totally out of usable
   Sherlock Holmes story titles, so I'm off to new challenges.

   I will miss you all.


**Update:** Potch suggested just using "LDAPs". Used in a sentence:
"I've been here for 6 LDAPs." I like that.
