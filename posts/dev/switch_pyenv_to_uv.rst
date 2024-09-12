.. title: Switching from pyenv to uv
.. slug: switch_pyenv_to_uv
.. date: 2024-09-12 11:00:00 UTC-05:00
.. tags: python, dev, pyenv, uv
.. type: text

Premise
=======

The `0.4.0 release of uv <https://astral.sh/blog/uv-unified-python-packaging>`__
does everything I currently do with pip, pyenv, pipx, pip-tools, and
pipdeptree. Because of that, I'm in the process of switching to uv.

This blog post covers switching from pyenv to uv.


History
=======

* 2024-08-29: Initial writing.
* 2024-09-12: Minor updates and publishing.


Start state
===========

I'm running Ubuntu Linux 24.04. I have pyenv installed using the
`the automatic installer <https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer>`__.
pyenv is located in ``$HOME/.pyenv/bin/``.

I have the following Pythons installed with pyenv:

.. code-block:: shell

   $ pyenv versions
     system
     3.7.17
     3.8.19
     3.9.19
   * 3.10.14 (set by /home/willkg/mozilla/everett/.python-version)
     3.11.9
     3.12.3

I'm not sure why I have 3.7 still installed. I don't think I use that for
anything.

My default version is 3.10.14 for some reason. I'm not sure why I haven't
updated that to 3.12, yet.

In my 3.10.14, I have the following Python packages installed:

.. code-block:: shell

   $ pip freeze
   appdirs==1.4.4
   argcomplete==3.1.1
   attrs==22.2.0
   cffi==1.15.1
   click==8.1.3
   colorama==0.4.6
   diskcache==5.4.0
   distlib==0.3.8
   distro==1.8.0
   filelock==3.14.0
   glean-parser==6.1.1
   glean-sdk==50.1.4
   Jinja2==3.1.2
   jsonschema==4.17.3
   MarkupSafe==2.0.1
   MozPhab==1.5.1
   packaging==24.0
   pathspec==0.11.0
   pbr==6.0.0
   pipx==1.5.0
   platformdirs==4.2.1
   pycparser==2.21
   pyrsistent==0.19.3
   python-hglib==2.6.2
   PyYAML==6.0
   sentry-sdk==1.16.0
   stevedore==5.2.0
   tomli==2.0.1
   userpath==1.8.0
   virtualenv==20.26.2
   virtualenv-clone==0.5.7
   virtualenvwrapper==6.1.0
   yamllint==1.29.0

That probably means I installed the following in the Python 3.10.14 Python
environment:

* MozPhab
* pipx
* virtualenvwrapper

Maybe I installed some other things for some reason lost in the sands of time.

Then I had a whole bunch of things installed with pipx.

I have many open source projects all of which have a ``.python-version`` file
listing the Python versions the project uses.

I think that covers the start state.


Steps
=====

First, I made a list of things I had.

* I listed all the versions of Python I have installed so I know what I need
  to reinstall with uv.

  .. code-block:: 

     $ pyenv versions

* I listed all the packages I have installed in my 3.10.14 environment (the
  default one).

  .. code-block::

     $ pip freeze

* I listed all the packages I installed with pipx.

  .. code-block::

     $ pipx list


I uninstalled all the packages I installed with pipx.

.. code-block:: shell

   $ pipx uninstall PACKAGE


Then I uninstalled pyenv and everything it uses. I followed the
`pyenv uninstall instructions <https://github.com/pyenv/pyenv?tab=readme-ov-file#uninstalling-pyenv>`__:

.. code-block:: shell

   $ rm -rf $(pyenv root)


Then I removed the bits in my shell that add to the ``PATH`` and set up pyenv
and virtualenvwrapper.

Then I started a new shell that didn't have all the pyenv and virtualenvwrapper
stuff in it.

Then I installed uv using the
`uv standalone installer <https://docs.astral.sh/uv/getting-started/installation/#standalone-installer>`__.

Then I ran ``uv --version`` to make sure it was installed.

Then I
`installed the shell autocompletion <https://docs.astral.sh/uv/getting-started/installation/#shell-autocompletion>`__.

.. note::

   I have a dotfiles thing and separate out bashrc changes by what changes
   them. You can see my home-grown thing that works for me here:

   https://github.com/willkg/dotfiles

   These instructions are specific to my home-grown dotfiles thing.


.. code-block:: shell

   $ echo 'eval "$(uv generate-shell-completion bash)"' >> ~/dotfiles/bash.d/20-uv.bash


Then I started a new shell to pick up those changes.

Then I installed Python versions:

.. code-block:: shell

   $ uv python install 3.8 3.9 3.10 3.11 3.12
   Searching for Python versions matching: Python 3.10
   Searching for Python versions matching: Python 3.11
   Searching for Python versions matching: Python 3.12
   Searching for Python versions matching: Python 3.8
   Searching for Python versions matching: Python 3.9
   Installed 5 versions in 8.14s
    + cpython-3.8.19-linux-x86_64-gnu
    + cpython-3.9.19-linux-x86_64-gnu
    + cpython-3.10.14-linux-x86_64-gnu
    + cpython-3.11.9-linux-x86_64-gnu
    + cpython-3.12.5-linux-x86_64-gnu


When I type "python", I want it to be a Python managed by uv. Also, I like
having "pythonX.Y" symlinks, so I created a ``uv-sync`` script which creates
symlinks to uv-managed Python versions:

https://github.com/willkg/dotfiles/blob/main/dotfiles/bin/uv-sync

Then I installed all my tools using ``uv tool install``.

.. code-block:: shell

   $ uv tool install PACKAGE


For ``tox``, I had to install the ``tox-uv`` package in the ``tox``
environment:

.. code-block:: shell

   $ uv tool install --with tox-uv tox


Now I've got everything I do mostly working.


So what does that give me?
==========================

I installed uv and I can upgrade uv using ``uv self update``.

Python interpreters are managed using ``uv python``. I can create symlinks to
interpreters using ``uv-sync`` script. Adding new interpreters and removing old
ones is pretty straight-forward.

When I type ``python``, it opens up a Python shell with the latest uv-managed
Python version. I can type ``pythonX.Y`` and get specific shells.

I can use tools written in Python and manage them with ``uv tool`` including
ones where I want to install them in an "editable" mode.

I can write scripts that require dependencies and it's a lot easier to run them
now.

I can create and manage virtual environments with ``uv venv``.


Next steps
==========

Delete all the ``.python-version`` files I've got.

Update documentation for my projects and add a ``uv tool install PACKAGE``
option to installation instructions.

Probably discover some additional things to add to this doc.
