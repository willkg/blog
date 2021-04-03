.. title: Anatomy of a class/function decorator and context manager
.. slug: anatomy-class-fun-deco
.. date: 2016-05-16 12:00
.. tags: dev, python

Over the weekend, I wanted to implement something that acted as both a class and
function decorator, but could also be used as a context manager. I needed this
flexibility for overriding configuration values making it easier to write tests.
I wanted to use it in the following ways:

1. as a function decorator:

   .. code:: python

      @config_override(DEBUG='False')
      def test_something():
          ...

2. as a class decorator that would decorate all methods that start with
   ``test_``:

   .. code:: python

      @config_override(DEBUG='False')
      class TestSomething:
          def test_something(self):
              ...

3. as a context manager that allowed for multiple layer of overriding:

   .. code:: python

      def test_something():
          with config_override(DEBUG='False'):
              with config_override(SOMETHING_ELSE='ou812'):
                  ...


This kind of need comes up periodically, but infrequently enough that I forget
how I wrote it the last time around.

This post walks through how I structured it.

.. TEASER_END

Some example bits
=================

First off, we're writing a thing that pushes and pops configuration layers on a
stack. When determining the current configuration value, the system will go
through the configuration layers top to bottom and thus configuration values in
the top-most layers override the configuration values in the bottom-most layers.

We'll use these two utility functions:

.. code:: python

   def push_config(cfg):
       """Pushes a configuration on the stack"""

   def pop_config():
       """Pops a configuration off the stack"""


I'm going to gloss over the implementation of both of these since they're specific
to my configuration use case but not general to the structure of the solution.


Function decorator
==================

Let's make a function that takes a configuration and returns a function
decorator:

.. code:: python

   from functools import wraps

   def push_config(cfg):
       """Pushes a configuration on the stack"""

   def pop_config():
       """Pops a configuration off the stack"""

   def config_override(**new_config):
       def config_override_decorator(fun):
           def _inner(*args, **kwargs):
               push_config(new_config)
               try:
                   return fun(*args, **kwargs)
               finally:
                   pop_config()
           return _inner
       return config_override_decorator


Example of usage:

.. code:: python

   @config_override(DEBUG=True)
   def test_something():
       """tests stuff"""
       # ...


That's pretty standard function decorator stuff.


Convert that to a class
=======================

I'm going to convert that to a class because it makes it a bit easier to turn it
into a class decorator and also a context manager.

Here's the class implementation:

.. code:: python

   from functools import wraps

   def push_config(cfg):
       """Pushes a configuration on the stack"""

   def pop_config():
       """Pops a configuration off the stack"""

   class ConfigOverride:
       def __init__(self, **new_config):
           self.config = new_config

       def __call__(self, fun):
           def _inner(*args, **kwargs):
               push_config(new_config)
               try:
                   return fun(*args, **kwargs)
               finally:
                   pop_config()
           return _inner

   # We do this to make it look more like a decorator
   config_override = ConfigOverride


Usage is the same:

.. code:: python

   @config_override(DEBUG=True)
   def test_something():
       """tests stuff"""
       # ...


Make it work as a class or function decorator
=============================================

Let's extend that so that it can decorate classes and functions:

.. code:: python

   from functools import wraps
   from inspect import isclass

   def push_config(cfg):
       """Pushes a configuration on the stack"""

   def pop_config():
       """Pops a configuration off the stack"""

   class ConfigOverride:
       def __init__(self, **new_config):
           self.config = new_config

       def decorate(self, fun):
           def _inner(*args, **kwargs):
               push_config(new_config)
               try:
                   return fun(*args, **kwargs)
               finally:
                   pop_config()
           return _inner

       def __call__(self, class_or_fun):
           if isclass(class_or_fun):
               # If class_or_fun is a class, we decorate each function
               # that has a name that starts with ``test_``.
               for attr in class_or_fun.__dict__.keys():
                   val = getattr(class_or_fun, attr)
                   if attr.startswith('test_') and callable(val):
                       setattr(class_or_fun, attr, self.decorate(val))
               return class_or_fun
           else:
               return self.decorate(class_or_fun)

   # We do this to make it look more like a decorator
   config_override = ConfigOverride


Now we can use it as a class decorator:

.. code:: python

   @config_override(DEBUG=True)
   class TestSomething:
       def __init__(self):
           """Initialize the test class"""
           # This is not decorated
           # ...

       def test_something(self):
           """Test something"""
           # This is decorated
           # ...

And it still works as a function decorator, too.


Make it work as a context manager
=================================

It's sometimes handy to make it work as a context manager, too. That way you can
have a single test that uses different configuration options.

Let's add in the context manager ``__enter__`` and ``__exit__`` methods:

.. code:: python

   from functools import wraps
   from inspect import isclass

   def push_config(cfg):
       """Pushes a configuration on the stack"""

   def pop_config():
       """Pops a configuration off the stack"""

   class ConfigOverride:
       def __init__(self, **new_config):
           self.config = new_config

       def __enter__(self):
           self.push_config(self.config)

       def __exit__(self, exc_type, exc_value, traceback):
           self.pop_config()

       def decorate(self, fun):
           def _inner(*args, **kwargs):
               push_config(new_config)
               try:
                   return fun(*args, **kwargs)
               finally:
                   pop_config()
           return _inner

       def __call__(self, class_or_fun):
           if isclass(class_or_fun):
               # If class_or_fun is a class, we decorate each function
               # that has a name that starts with ``test_``.
               for attr in class_or_fun.__dict__.keys():
                   val = getattr(class_or_fun, attr)
                   if attr.startswith('test_') and callable(val):
                       setattr(class_or_fun, attr, self.decorate(val))
               return class_or_fun
           else:
               return self.decorate(class_or_fun)

   # We do this to make it look more like a decorator
   config_override = ConfigOverride


This can be used as a context manger this way:

.. code:: python

   def test_something():
       with config_override(DEBUG=True):
          # ...


Plus you can do all the things at the same time:

.. code:: python

   @config_override(DEBUG=True)
   class TestSomething:
       def __init__(self):
           """Initializes test class"""
           # Not decorated

       @config_override(HOST='localhost')
       def test_something(self):
           """Tests something"""
           # Decorated with DEBUG=True and HOST='localhost'

           with config_override(API_KEY='ou812'):
               # Overrides are DEBUG=True, HOST='localhost' and
               # API_KEY='ou812'
               # ...

           with config_override(HOST='example.com', API_KEY='ou812'):
               # Overrides are DEBUG=True, HOST='example.com' and
               # API_KEY='ou812'
               # ...


There are other ways to structure the same thing. Instead of using a class, I
could have put the whole thing in one big function, but I claim that's less
generally readable.

And that's how I wrote a thing that acts as a function decorator, a class
decorator and a context manager.
