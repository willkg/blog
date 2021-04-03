.. title: Running Oracle 8i on WindowsXP
.. slug: oracleonxp
.. date: 2003-11-07 19:40:32
.. tags: software

I installed Oracle 8i (8.1.6) on Windows XP Professional and noticed
that it worked fine after I installed it, but after I rebooted the
OracleOraHome8TNSListener would come up fine but the OracleServicePORTDB 
(my oracle instance) service would try to come up, but wouldn't come
up fully.  Yeah--that's super vague.  In the XP Services applet, 
it would show up as *Starting* as opposed to *Started*.
There was an ORACLE and an ORADRIM process running, though.  So I was
puzzled.

Hunting through google search results wasn't helpful.  Finally found a 
post that mentioned Oracle 8i works fine under Windows XP Professional
but that you have to manually start the services.

So if you switch those services to *Manual* startup, and then 
write yourself a nice batch script like this:

.. code-block::

   net start oracleorahome8tnslistener
   net start oracleserviceportdb


(fill in your instance service name for the second one)--then it works
fine.
