dataferret/logentries
=====================

![Latest tag](https://img.shields.io/github/tag/dataferret/docker-logentries.svg?style=flat)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

This container looks for an environment variable LOG_FILES on any container
that wishes to have its logs exported to logentries.  Multiple logentries can be run,
each with their own LOG_FILTERS that capture specific LOG_FILES.

The output stream to Logentries is json formatted and includes container_image and container_name.

        {
          "log": "Jan 27 06:59:17 mybot syslog-ng[25]: syslog-ng starting up; version='3.5.3'\n",
          "stream": "stdout",
          "container_id": "fd8a4a82c60b",
          "container_name": "mybot",
          "container_image": "dataferret/bot"
        }

### Usage

Just start the container and bind it to the docker socket.

LOG_FILES and LOG_FILTERS support comma delimited names.

        docker run -it --name botlogger \
            -e LOG_FILTERS=Bots,Robots \
            -e TOKEN=aab98765-1234-123a-98ff-1a2b345a67bc \
            -v /var/run/docker.sock:/tmp/docker.sock \
            -v /var/lib/docker/containers:/var/lib/docker/containers \
            dataferret/logentries

Whether you create this container first or the ones being logged doesn't really
matter since it'll reconfigure itself on docker events. For containers to be logged

        docker run -d -e LOG_FILES=Bots,Web nginx:latest


### Raison d'Etre

Primarily, if one sets up an interactive docker host where an occasional

        docker run -it --rm ubuntu bash

is used, it tends to leak secrets and other things into the logs. While normally
this isn't much of an issue since containers and their logs are shortlived on the
docker host, it becomes an issue when logs are exported and archived.

Setting up individual loggers for each service is typically the best from a security
standpoint - given that you can mask sensitive information. But that's overkill for most
uses. This container sits somewhere in the middle of being slightly automagical, but
not too overzealous on shipping everything.


### Notes

The container tails the standard docker logs.  It will keep a position log of the tail
as a file within the /var/lib/docker/container/*/ encoded based on a partial TOKEN and
the LOG_FILTER combination.  This should allow for multiple logentries containers to
overlap each other and watch the same containers.


Special thanks to [jwilder/docker-gen](https://github.com/jwilder/docker-gen) and
[gregory90/fluent-logentries](https://github.com/gregory90/docker-fluent-logentries)
for giving me the idea.

### License

MIT
