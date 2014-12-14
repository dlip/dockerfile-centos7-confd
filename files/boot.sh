#!/bin/bash
set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD=$HOST_IP:4001

echo "[confd] booting container. ETCD: $ETCD"


# Run confd in the background to watch the upstream servers
#confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/nginx.toml &
#echo "[confd] listening for changes on etcd..."

exec /usr/bin/supervisord -c /etc/supervisord.conf
