.. title: verify_installation for pyblosxom
.. slug: verifyinstallation
.. date: 2004-03-09 20:04:06
.. tags: python, dev, pyblosxom

A couple of weeks ago, I checked in code to help out PyBlosxom 
installation and configuration.  I made changes to pyblosxom.cgi so 
that you could run it from the prompt:

.. code-block:: shell

   ./pyblosxom.cgi


It tells you your Python version, OS name, and then proceeds to verify
your config properties (did you specify a valid datadir?  does it
exist?...) and then initializes all your plugins and executes
``verify_installation(request)`` on every plugin you have
installed that has the function.

As a plugin developer, you should add a ``verify_installation`` function
to your plugin module.  Something like this (taken from pycategories):

.. code-block:: python

   def verify_installation(request):
       config = request.getConfiguration()

       if not config.has_key("category_flavour"):
           print "missing optional config property 'category_flavour' which allows "
           print "you to specify the flavour for the category link.  refer to "
           print "pycategory plugin documentation for more details."
       return 1


Basically this gives you (the plugin developer) the opportunity to
walk the user through configuring your highly complex, quantum-charged,
turbo plugin in small baby steps without having to hunt for where
their logs might be.

So check the things you need to check, print out error messages 
(informative ones), and then return a ``1`` if the 
plugin is configured correctly or a ``0`` if it's not
configured correctly.

This is not a substitute for reading the installation instructions.  But
it should be a really easy way to catch a lot of potential problems
without involving the web server's error logs and debugging information
being sent to a web-browser and things of that nature.
