.. title: pyblosxom api
.. slug: api
.. date: 2003-01-15 14:13:22
.. tags: python, dev, pyblosxom

Yesterday I slam-dunked some code to form some infrastructure for plugin
modules--I figured I've done this for Lyntin and Stringbean, might as
well go for the hat trick! The code allows us to build a set of callback
chains and such to let people extend the functionality of pyblosxom
without having to re-write pyblosxom internals. Blah blah standard
plugin stuff.

At some point, I'll write a tutorial to use it beyond the brief
documentation I left in the ``api`` module. Until then, I leave the
following excerpt for how it all ties together using the ``pycalendar``
module as an example.

.. code-block:: python

   """
   This is my fancy pyfortune module.  Basically what it's going to do
   is call /usr/local/bin/fortune and populate the fortune variable
   with the resulting string.
   """
   import commands
   from libs import api, tools
   
   class PyFortune:
       def __init__(self):
           self._fortune = None
   
       def getFortune(self, args):
           entry_dict = args[0]
           text_string = args[1]
           if self._fortune == None:
               self._fortune = commands.getoutput("/usr/games/fortune")
   
           return (entry_dict, tools.parse({"fortune": self._fortune}, text_string))
   
   def initialize():
       api.parseitem.register(PyFortune().getFortune)

*Figure 1: libs/plugins/pyfortune.py*

Mmm... It occurs to me that this doesn't use the ``api`` module at all.
On the other hand, it's pretty neat looking, so I'll leave it for now.
At some point someone is going to have to remind me to write an ``api``
usage example.

Have a dynamically generated fortune:

...

This fortune has been removed because it turns out that dynamically
generated text causes RSS feeds to think this is a new entry every time.
Thus, no fortune for you!
