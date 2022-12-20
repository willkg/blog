.. title: NormConf 2022 thoughts
.. slug: normconf_2022_thoughts
.. date: 2022-12-20 08:06:57 UTC-05:00
.. tags: dev, normconf

I went to NormConf 2022, but didn't attend the whole thing. It was entirely
online as a YouTube livestream for something like 14 hours split into three
sessions. It had a very active Slack instance.

I like doing post-conference write-ups because then I have some record of what
I was thinking at the time. Sometimes that's useful for other people. Often
it's helpful for me.

I'm data engineer adjacent. I work on a data pipeline for crash reporting, but
it's a streaming pipeline, entirely bespoke, and doesn't use any/many of the
tools in the data engineer toolkit. There's no ML. There's no NLP. I don't have
a data large-body-of-water. I'm not using SQL much. I'm not having Python
packaging problems. Because of that, I kind of skipped over the data engineer
related talks.

The conference was well done. Everyone did a great job. The Slack channels I
lurked in were hopping. The way they did questions worked really well.

These are my thoughts on the talks I watched.

.. TEASER_END


Lightning talks
===============

All the lightning talks are on YouTube now:

https://www.youtube.com/playlist?list=PLYXaKIsOZBstGUTXZXp2azDk8UJhpVVq3

The lightning talks are great (and short!) and worth watching. These were the
handful that I watched.


Everything is on fire and you should contribute
-----------------------------------------------

Randy Au

https://www.youtube.com/watch?v=-6sS3wVYpM8&list=PLYXaKIsOZBstGUTXZXp2azDk8UJhpVVq3&index=1

This lightning talk was one of the first things I saw of NormConf and
encapsulates my work world. "Write your code, do your best."


How to name files
-----------------

Jennifer Bryan

https://www.youtube.com/watch?v=ES1LTlnpLMk&list=PLYXaKIsOZBstGUTXZXp2azDk8UJhpVVq3&index=6

Nice talk covering filenames and the consequences of schemes (or lack of
schemes) on what you can do with them.


PyScript: Run Python in your HTML
---------------------------------

Sophia Yang

https://www.youtube.com/watch?v=Zbkkbnm07-0&list=PLYXaKIsOZBstGUTXZXp2azDk8UJhpVVq3&index=19

Intro to pyscript, what it is, and what it can be used for.


Hell is other people's bugs
---------------------------

TJ Murphy

https://www.youtube.com/watch?v=wymQT_03-H4&list=PLYXaKIsOZBstGUTXZXp2azDk8UJhpVVq3&index=25

Talks about the intricacies of writing good A/B tests.


Have you tried rubbing a hash on it?
------------------------------------

Izzy Miller

https://www.youtube.com/watch?v=exvqJNGPitY&list=PLYXaKIsOZBstGUTXZXp2azDk8UJhpVVq3&index=27

Talks about hashes, hash functions, etc.


Putting Git's commit hash in ``__version__``, two ways
------------------------------------------------------

Tom Baldwin

https://www.youtube.com/watch?v=dCswm8WXCJ8&list=PLYXaKIsOZBstGUTXZXp2azDk8UJhpVVq3&index=28

Talks about using
`python-versioneer <https://github.com/python-versioneer/python-versioneer>`__ and
`setuptools-scm <https://github.com/pypa/setuptools_scm>`__ for versions in Python
packages.


Talks
=====

All the talks are on YouTube now:

https://www.youtube.com/playlist?list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV

Talks are around 20 minutes each. It's interesting that the playlist is sorted
in reverse order from when the talk occurred in the schedule. I think I
remember some talks referring to earlier talks, but I don't think it's a big
deal. If it is a big deal to you, watch the talks in the playlist in reverse
order.


Five semesters of linear algebra and all I do is solve Python dependency problems
---------------------------------------------------------------------------------

Tim Hopper

https://www.youtube.com/watch?v=6flt_3yMNb0&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=30

This covers Tim's journey following his interests to eventually end up with
data science and machine learning. I like learning about peoples' journeys.


NLP tips and tricks
-------------------

Lynn Cherny

https://www.youtube.com/watch?v=Rs92i_xrBLo&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=27

I don't have any of the problems Lynn talks about because I don't do NLP
(natural language processin), but it was pretty interesting and fun to listen
to.


How small can I get that Docker container?
------------------------------------------

Matthijs Brouns

https://www.youtube.com/watch?v=kx-SeGbkNPU&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=26

I work on a set of services all of which are manipulated as Docker images. As
such, I've spent time learning how layers work and the consequences of that on
image sizes.

I hadn't heard of `Dive <https://github.com/wagoodman/dive>`__ before--that was
neat to learn about.


Geriatric data science: life after senior
-----------------------------------------

Luca Belli

https://www.youtube.com/watch?v=91EJzxnMRhE&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=24

I had no idea what this talk was going to be about from the title, so it was a
bit of a surprise for me. It talks about what happens after you get promoted
beyond "senior engineer", how the role changes, and how companies could do a
better job paving the path beyond just like they do with the equivalent
management track.

The Slack back channel was pretty interesting. I'm pretty sure `Will Larson's
Staff Engineer book
<https://www.amazon.com/Staff-Engineer-Leadership-beyond-management/dp/1736417916/>`__
and `Tanya Reilly's The Staff Engineer's Path
<https://www.amazon.com/Staff-Engineers-Path-Individual-Contributors/dp/1098118731/>`__
came up.

I wish I had known a lot more about this when I was promoted beyond senior
engineer. I spent years floundering about trying to understand what was going
on particularly around what was "normal" and part of the role.

The takeaways are valuable for anyone who's looking to get promoted beyond
senior engineer.


A Game of Construction
----------------------

Helena Sarin

https://www.youtube.com/watch?v=n6FUXTDNKKQ&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=23

I didn't take any notes, but I thoroughly enjoyed the talk and will probably
watch it again some time. The puns were delightful.


Hack your way to a better API
-----------------------------

Zachary Blackwood

https://www.youtube.com/watch?v=6f4yYwsqQD8&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=22

This is a good talk for hacking things to get them to work. Namely anything
over HTTP is essentially an API. Anything in Python and JavaScript can be
monkeypatched to do what you need it to do. Documentation can be discovered in
lots of places including the source code as well as through your editor.

I kind of wish it had touched on the consequences for these hacks. How do you
maintain the hacks over time? How are the hacks fragile? How can you make them
less fragile?


What's the simplest possible thing that might work, and why didn't you try that first? 
--------------------------------------------------------------------------------------

Joel Grus

https://www.youtube.com/watch?v=MW9oVxjJHEw&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=21

This talk explores simplicity, problem solving, layers of abstraction, tools,
and thinking about problem solving. It's in the domain of ML, but I think it's
generally applicable to any kind of problem solving and worth 20 minutes to
watch.

Also, the slide into woodworking really clicked with me. I've watched most of
the videos he mentions and shows thumbnails of. Last year, I had switched to
woodworking with hand tools and have been learning about hand planes and
sharpening blades and joints and hand-sawing such. I'm currently making a
cabinet for my bathroom using hand tools. It's been educational.

Anyhow, his digression into creating jigs to create simplicity and paving the
way for simple choices allowed me to reframe a huge amount of work I've done
over the years on libraries, processes, documented conventions, and tooling:
making jigs that make future work for me and others simple. Just feeling
validated made this talk completely worthwhile to watch.

Also, omg--the slides! I won't say more because I don't want to spoil it.


Building an HTTPS Model API for Cheap: AWS, Docker, and the Normconf API
------------------------------------------------------------------------

Ben Labaschin

https://www.youtube.com/watch?v=DRGxjfLVrTA&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=12

The talk is about choosing "for cheap" along the axis of preferring "normy
software" over new things.

At work, we have a "New Tech Checklist" now which adds a bunch of friction
towards picking new things. As someone who has taken over many many projects
each of which is a unique snowflake in regards to tech stacks, new things are
often a drag and a huge time sink over the long term.

Our "New Tech Checklist" isn't quite "normy software", but it is a helpful way
to evaluate options in tech stack choices.

I liked this talk and it's in a friendly digestible framing to send to people
who might be new to these ideas.

One of the slides is "There's not enough time." I feel this viscerally.


The zen of tedium
-----------------

Brandon Rohrer

https://www.youtube.com/watch?v=p1beO_1a6xY&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=9

I thought this talk was going to be along the lines of choosing boring
technology a la `Dan McKinley <https://mcfunley.com/choose-boring-technology>`__
(my boss' boss). Instead, it's about something something doing things the hard
way and how that's not a moral failing or something like that.

I think "the hard way" in this context is "automating" vs. "doing it manually".
Maybe this is a talk about premature optimization via automation?

Maybe I missed something in the first part of the talk? I found it confusing.
It's definitely not about choosing boring technology. I ended up skipping out
about 2/3 of the way through.

I thought about not including this talk in my post-conference summary, but
figured I'd include it in case automating vs. manual is interesting to someone.


Data ethics: the non-sexy parts
-------------------------------

Roy Keyes

https://www.youtube.com/watch?v=s3a7oPsj8nE&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=24

This talk starts out with a high-level enumeration of general areas of ethics
in the world of data. I found that interesting. But then it took a hard-left
turn into talking about ethical issues that come up far more often, but aren't
discussed in the news. Those are pretty interesting.

It ends with:

    "Often the real world is very vague and frogs are slowly getting boiled.
    Often you don't realize that you're in an ethics situation until you're
    already in it and it's too late. So I think you need to ask yourself, if
    you're in a situation, if you're going to look back at what you did how
    would you judge yourself about that. It's particularly important for early
    career people who may not have encountered this stuff before and may not
    have heard anyone talk about it. You senior level people--this is a good
    thing to bring up to those earlier people."

    Roy Keyes


I'd have written a shorter solution but I didn't have the time
--------------------------------------------------------------

JD Long

https://www.youtube.com/watch?v=Pm9C-Cz4bXE&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=6

The first part is about how prompts matter and subtractive thinking is hard.
This is a segue into MVP and reductive thinking.

This appealed to me. I've spent the large part of the last 6 years deprecating
API endpoints, winding down projects, removing features, coalescing options,
etc. Also, MVPs, prototypes, project plans, abandoning projects before they
start, etc. Also, writing bug reports with minimal viable example, test cases,
etc. Seriously, this talk is my jam.


Don't do invisible work
-----------------------
    
Chris Albon

https://www.youtube.com/watch?v=HiF83i1OLOM&list=PLYXaKIsOZBsu3h2SSKEovRn7rGy7wkUAV&index=1

This talk is about tracking your work in some way so that you know what you did
later on down the line for evaluations, reviews, promotions, proving your
value, etc. It also captures invisible work that isn't amenable to being
tracked in easy to discover metrics (commits, bugs fixed, lines of code
removed, etc).

This talk also covers how to tell people about what you did which is equally
important.
