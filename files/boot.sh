#!/bin/bash
set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export ETCD_IP=${ETCD_IP:-172.17.42.1}

CONFD_NODE=${CONFD_NODE:-$ETCD_IP:$ETCD_PORT}
CONFD_INTERVAL=${CONFD_INTERVAL:-10}

CONFD_CMD="confd"
CONFD_CMD=$([ -z "$CONFD_BACKEND" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -backend=\"$CONFD_BACKEND\"")
CONFD_CMD=$([ -z "$CONFD_CLIENT_CA_KEYS" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -client-ca-keys=\"$CONFD_CLIENT_CA_KEYS\"")
CONFD_CMD=$([ -z "$CONFD_CLIENT_CERT" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -client-cert=\"$CONFD_CLIENT_CERT\"")
CONFD_CMD=$([ -z "$CONFD_CLIENT_KEY" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -client-key=\"$CONFD_CLIENT_KEY\"")
CONFD_CMD=$([ -z "$CONFD_DEBUG" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -debug=$CONFD_DEBUG")
CONFD_CMD=$([ -z "$CONFD_ETCD_SCHEME" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -scheme=\"$CONFD_ETCD_SCHEME\"")
CONFD_CMD=$([ -z "$CONFD_INTERVAL" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -interval=$CONFD_INTERVAL")
CONFD_CMD=$([ -z "$CONFD_NODE" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -node=$CONFD_NODE")
CONFD_CMD=$([ -z "$CONFD_PREFIX" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -prefix=\"$CONFD_PREFIX\"")
CONFD_CMD=$([ -z "$CONFD_SRV_DOMAIN" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -srv-domain=\"$CONFD_SRV_DOMAIN\"")
CONFD_CMD=$([ -z "$CONFD_VERBOSE" ] && echo "$CONFD_CMD" || echo "$CONFD_CMD -verbose=$CONFD_VERBOSE")

export CONFD_CMD=$CONFD_CMD

echo "[confd] booting container. ETCD: $CONFD_NODE"
echo "[confd] booting container. CONFD_CMD: $CONFD_CMD"


# Run confd in the background to watch the upstream servers
#confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/nginx.toml &
#echo "[confd] listening for changes on etcd..."

exec /usr/bin/supervisord -c /etc/supervisord.conf
