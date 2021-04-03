.. title: How to resize a virtual disk
.. slug: resizingwindowsvdi
.. date: 2009-01-02 11:51:56
.. tags: dev, software

I use `VirtualBox OSE <http://www.virtualbox.org/>`_ for virtualizing
test environments for `Miro <http://getmiro.com/>`_ development.
I built a Windows XP vm a year ago and when I did it, I put it on a virtual
disk that was 8 GB which turned out to be waaaay too small for my needs.
It's non-trivial to build a Windows build environment for Miro so I really
wanted to clone the partition to a new virtual disk that was a lot bigger,
then resize the partition rather than create a new virtual disk and reinstall
and set everything back up.

I pretty much did that this morning in a couple of hours.

First thing I did was download the LiveCD of `Clonezilla <http://clonezilla.org/>`_
(version 1.2.1-23) and the LiveCD of `GParted <http://gparted.sourceforge.net/>`_
(version 0.4.1-2).

Second thing I did was create a 25 GB virtual disk in VirtualBox.

Then I attached the new virtual disk to the winxp vm that I had.  Thus it should
show up as hdb.

I booted into the Clonezilla LiveCD, cloned the old virtual disk to the new one
keeping the partition sizes the same and making sure to copy over the MBR, too.

I switched around the virtual disks attached to my winxp vm and booted into the
new virtual disk--worked great!

I booted into the GParted LiveCD, launched qtparted and grew the NTFS partition
so that it used the whole virtual disk.

Then I booted into the new virtual disk.  It did an NTFS disk check on startup
which I thought might indicate the process didn't work right.  Disk check passed,
Windows XP booted and everything worked as well as I expected it to.
