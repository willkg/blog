.. title: Fix for vagrant keys permission issue
.. slug: vagrant-fix
.. date: 2012-01-11 20:11:38
.. tags: dev, work, mozilla, vagrant


Tim threw together a `vagrant setup for Kitsune
<https://github.com/readevalprint/kitsune-vagrant>`_ based on what
Alex did in November. I went to give it a try but I'm using vagrant
0.8.10 and it died.

Important part of the error message was::

    /var/lib/gems/1.8/gems/net-ssh-2.1.4/lib/net/ssh/key_factory.rb:38:in
    `read': Permission denied - /var/lib/gems/1.8/gems/vagrant-0.8.10/keys/vagrant
    (Errno::EACCES)

Issue is documented at `<https://github.com/mitchellh/vagrant/issues/235>`_.

My fix was to do this::

    saturn /var/lib/gems/1.8/gems/vagrant-0.8.10/keys> ls -al
    total 24
    drwxr-xr-x  2 root root 4096 Jan 11 20:00 .
    drwxr-xr-x 10 root root 4096 Jan 11 20:00 ..
    -rw-r--r--  1 root root  821 Jan 11 20:00 README.md
    -rw-------  1 root root 1675 Jan 11 20:00 vagrant
    -rw-r--r--  1 root root 1464 Jan 11 20:00 vagrant.ppk
    -rw-r--r--  1 root root  409 Jan 11 20:00 vagrant.pub
    saturn /var/lib/gems/1.8/gems/vagrant-0.8.10/keys> sudo chmod 644 vagrant
    saturn /var/lib/gems/1.8/gems/vagrant-0.8.10/keys> 

That fixed it for me. Figured I'd document it so that I could find it again
when I bumped into it again.
