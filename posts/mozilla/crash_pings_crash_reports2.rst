.. title: Crash pings (Telemetry) and crash reports (Socorro/Crash Stats): Part 2
.. slug: crash_pings_crash_reports2
.. date: 2019-07-03 15:00
.. tags: mozilla, work, socorro, telemetry, crash_reports, crash_pings
.. status: draft
.. type: text

Crash pings

* Opt-out data set. Because of this, we think it's more representative of what's
  going on in the world--at least as much as Telemetry data.
* It's a safe subset of crash annotations and the stack of the crashing process.
* Nothing symbolicates that stack or computes crash signatures, so it's hard
  to glean anything from this data right now.
* The data is located in the ``telemetry.crash`` data set. You can use Data Tools
  to access it like BigQuery, Redash, etc.


Crash reports

* Opt-in data set. The user has to explicitly send the crash report. Because
  of this, we think it's not representative of what's going on in the world
  and that there are a lot of crashes that go unreported.
* This data set is sampled--many incoming crash reports are rejected because
  this is category 4 data and we want to be holding as little as possible.
* This contains all of the crash annotations as well as a lot of information
  from the crashed process including process memory. This is category 4
  data!
* This doesn't contain ids that can connect crash reports to other data
  sets on an individual level. For example, there are no Telemetry
  client ids in this data set allowing you to tie crash report data
  to Telemetry data.
* Socorro symbolicates the stack and computes crash signatures, so we
  can look at Top Crasher reports and group crashes by signature.


===========  =============  ===============
Day          # crash pings  # crash reports
===========  =============  ===============
2020-09-22   2,125,677      88,167
2020-09-23   2,060,468      90,203
2020-09-24   2,036,839      89,072
2020-09-25   2,159,750      87,587
2020-09-26   1,501,101      65,025
2020-09-27   1,575,065      64,199
2020-09-28   2,185,548      93,169
===========  =============  ===============

