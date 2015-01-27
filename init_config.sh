#!/bin/sh

set -e

echo "Configuring Logentries"

mkdir /etc/logentries/ -p
cat >/etc/logentries/tokens.conf <<EOF
docker.container:
    app: ${TOKEN}
EOF

chmod 640 /etc/logentries/tokens.conf
