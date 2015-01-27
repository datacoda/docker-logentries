#!/bin/sh
exec docker-gen -watch -notify "sv reload td-agent" /app/td-agent.tmpl /etc/td-agent/td-agent.conf