.. title: Java and Will
.. slug: javanotes
.. date: 2004-03-31 16:56:48
.. tags: content, java, dev

I've never really liked Java much. After using Java for 5 or 6 years in
various projects, I can count the number of times I've been working on
something in Java and thought to myself, "Gosh--I'm really psyched I'm
doing this in Java" on one hand. I dislike it a lot less than C++, but
I'm not sure that really counts for much. I'm ok with the language
semantics--it's the API that really gets me.

Anyhow, the Javahut story in `this
article <http://www.linuxworld.com/story/44251_p.htm>`__ is pretty much
what I'm thinking when I'm dealing with Java. To quote the passage:

Imagine if the Perl cafe and Javahut were across the street from each
other. You walk into Javahut, and ask to sit down. "I'm sorry," says the
person at the door. I'm not actually the hostess, I'm a Factory class
that can give you a hostess if you tell me what type of seat you want."
You say you want a non-smoking seat, and the person calls over a
NonSmokingSeatHostess. The hostess takes you to your seat, and asks if
you'll want breakfast, lunch, or dinner. You say lunch, and she beckons
a LunchWaitress. The LunchWaitress takes your order, brings over your
food, but there's no plates to put it on because you forgot to get a
CutleryFactory and invoke getPlates, so the Waitress throws a null
pointer exception and you get thrown out of the place. Dusting yourself
off, you walk across the street to the Perl cafe. The person at the door
asks what kind of seat you want, what you want to eat, and how you want
to pay. They sit you at your seat, bring over your food, collect the
money, and leave you to eat in peace. Sure, it's not the most elegant
dining experience you ever had, but you got your food with a minimum of
pain. -- James Turner

That sums up my feelings on the whole Java thing.

The bigger problem (and I think this is inherent in the Java community)
is that there are all these Java developers who think in terms of
massive object hierarchies and comprehensive APIs for every project. It
takes forever to write the infrastructure that expose all the bits of
data and functionality so that you can write the program to solve the
problem.

Blech.
