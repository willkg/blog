.. title: Using register allocation algorithms for determining table layout
.. slug: wedding_tablelayout
.. date: 2007-06-12 14:43:07
.. tags: fun, life

S and I decided to assign tables for our guests during the wedding
reception.  There were a bunch of good reasons for doing this which
I'm not going to go into here.  However, assigning 100 or so guests to
10 or so tables while maximizing "goodness" and minimizing "badness"
isn't trivial to do on paper by hand.  At some point during wedding
planning, I decided we could do table layout with a modified register
allocation algorithm.  This is a quick summary of translating register
allocation into table layout along with some commentary on how this
works nicely and also where it doesn't quite work.

.. TEASER_END

Register allocation is typically done using graph-coloring with some additional
bits that turn the NP-complete graph-coloring algorithm into a linear-time one
that results in a good approximation.  Andrew Appel talks about register
allocation in his book on compilers entitled `Modern Compiler Implementation in
ML <http://www.amazon.com/exec/obidos/ASIN/0521582741/>`_ in chapter 11.  It
involves a graph of nodes representing temps connected by edges that represent
interference between the temps.  There's also a list of move-related nodes and
nodes related by move-edges are coalesced if possible leading the connected
temps to be colored with the same register.

In table layout, there are groups of people who can't sit at the same table
with other groups of people.  This could be due to family issues, differences
in politics, past history, ...  Additionally, there are groups of people you
want to sit at the same table with other groups if possible.

Let's do some substitution.  We'll substitute registers for tables, 
edges representing people who can't sit at the same table as interference,
edges representing people who would be good sitting together as move-related,
and temps as people and we have mapped the register allocation problem
into a table layout problem.

I'm not going to go into the details of register allocation--Appel talks
about the George and Appel algorithm from "Iterated register coalescing" 
(1996) for 25 pages and it'd be hard to summarize that into a blog entry.

There are a few things that don't translate well from register allocation
to table layout like spilling.  In register allocation if you can't get 
it to work you spill a temp into memory and then start over.  I suppose 
you could uninvite particularly ornery people, that's one possible mapping 
for spilled temps.  Another possibility is that you look for the 
least-worst pairing and remove that edge from the graph.  A third 
possibility is to break up a larger table into two smaller tables giving 
you an extra color to work with.

Speaking of tables, there's one big difference between tables and 
registers: a register can be assigned to an unlimited number of temps 
so long as they don't interfere with one another.  A table has a limited 
number of seats.  So if you were to use a register allocation algorithm, 
you have the additional constraint that a limited number of people can 
be assigned to each table.  If the register allocation implementation 
that you use is deterministic, this constraint could cause your situation 
to be unsolvable without backtracking.  It would be a good idea to introduce 
a random element that causes assignments to occur in different orders 
between iterations.

The move-related edges (which represent people who should be sitting 
together) could be prioritized and that priority could be used for
selecting moves to coalesce.  For example, you might want to keep couples
together and perhaps families, too.  Perhaps you want to put all the
children at a single table that you can put close to the bathroom.

Theoretically, this sounds like it would work pretty well for many
cases, at a minimum returning a layout that can be tinkered with.  We
never used this method--by the time I had finished grad school, S
was already past most of the table layout issues.

It's possible the constraint on people per table handicaps the register
allocation algorithm to such a degree that it would be better to use a 
more general purpose constraint satisfaction problem solver instead.
This requires further study.
