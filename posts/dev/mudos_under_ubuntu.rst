.. title: Mudos under Ubuntu
.. slug: mudos_under_ubuntu
.. date: 2007-01-02 16:10:33
.. tags: ubuntu, muds, dev

I installed `Mudos <http://www.mudos.org/>`_ on my laptop
which is running Ubuntu Edgy.  I had two problems compiling the
source for v22.2b14.

The first issue is this error when running ``make``:

.. code-block::

   make: *** No rule to make target `obj/malloc.o', needed by `driver'.  Stop.


The solution, bizarrely, is to just run ``make`` again.  I don't know what the
issue is, but discovered this in the depths of the mailing list archives.

The second issue I get when compiling is this error:

.. code-block::

   socket_efuns.c: In function 'get_socket_addres':
   socket_efuns.c:1198: error: invalid lvalue in unary '&'
   make: *** [obj/socket_efuns.o] Error 1


Doing this change fixes the issue:

.. code-block:: diff

   $ diff socket_efuns.c.orig socket_efuns.c
   1198c1198,1199
   <     addr_in = &amp;(local ? lpc_socks[fd].l_addr : lpc_socks[fd].r_addr);
   ---
   >     // addr_in = &amp;(local ? lpc_socks[fd].l_addr : lpc_socks[fd].r_addr);
   >     addr_in = local ? &amp;lpc_socks[fd].l_addr : &amp;lpc_socks[fd].r_addr;


After that, everything works wonderfully.
