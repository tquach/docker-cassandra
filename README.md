Cassandra in Docker
===

This repository provides everything you need to run Cassandra in Docker, and is tuned for fast
container startup.

The following differences are made from the original Spotify fork:

- Cassandra version packaged is [2.0.11](https://git1-us-west.apache.org/repos/asf?p=cassandra.git;a=blob_plain;f=CHANGES.txt;hb=refs/tags/cassandra-2.0.11).
- The CASSANDRA_DC environment was added in the [cassandra-base/Dockerfile](https://github.com/tquach/docker-cassandra/commit/4c14cd76c96b525601dec43f017984aa06407efc) in order to use PropertyFileSnitch option.

Why?
---
While naive Cassandra images take around 30 seconds to start, our containers take only a few seconds.
Optimizations include:

* Disabling vnodes. We don't use them at Spotify, and Cassandra starts much faster without them
  (~10 sec).
* Disabling something called "waiting for gossip to settle down" because there is no gossip in a
  one-node cluster (another ~10 sec).

In the box
---
* **spotify/cassandra**

  This is probably the image you want, it runs a one-node Cassandra cluster.
  Built from the `cassandra` directory.

* **spotify/cassandra:cluster**

  Runs a Cassandra cluster. Expects `CASSANDRA_SEEDS` and `CASSANDRA_TOKEN` env variables to be set.
  If `CASSANDRA_SEEDS` is not set, node acts as its own seed. If `CASSANDRA_TOKEN` is not set, the
  container will not run. Built from the `cassandra-cluster` directory.

* **spotify/cassandra:base**

  The base image with an unconfigured Cassandra installation. You probably don't want to use this
  directly. Built from the `cassandra-base` directory.

Endpoint Snitches
---
Switch to use a PropertyFileSnitch by specifying an environment variable with the DC name in the cassandra-base/Dockerfile. 

Currently it is set to:
```
ENV CASSANDRA_DC Cassandra
```

Notes
---
Things are still under heavy development:
* Only Cassandra 2.0 with almost-generic config (miles away from what we actually run Cassandra
  with) is supported so far.
* There's nothing to help you with tokens and stuff.
