.. title: Register allocation...  DONE!
.. slug: regalloc
.. date: 2007-04-17 00:17:41
.. tags: content, life, music

My compilers class is using the Appel book Modern Compiler
Implementation in ML. Chapters 1 through 12 have a programming exercise
that walks you through building a compiler in ML for a language called
Tiger targetting the MIPS processor. It's pretty neat--Tiger has some
funky things in it that make some of the pieces non-trivial.

After a week of programming straight (i.e. I get up in the morning, eat
something, put on sweat pants, work on the compiler... go to bed) we got
register allocation working using graph coloring. It does spills and
coalescing but not coalescing of spills--that'd be really cool.

I'm really psyched! I think all we have left is some minor bits here and
there and then it's done and we'll have a compiler for Tiger. I'm
tossing around adding a random number generator to the runtime.c file so
that I can implement a Dwarven name generator using Markov chains.

A friend of mine gave me his new album `Digital Analog Heart and
Soul <http://cdbaby.com/cd/carbonlifer>`__ a couple of weeks ago. I had
it ripped on my hard drive and so that's what I listened to for the last
7 days of register allocator programming. The song The Fall is pretty
cool--he's done it in concerts a lot.

Now I need to get back to my research project....
