#!/bin/bash

PRIVOXY_PORT=${TOR_HTTP_PORT}
sed -i "s|_PRIVOXY_PORT_|$PRIVOXY_PORT|g" '/nftables.rules'

mkdir -p /config/privoxy \
    && cp --update=none /static-ubuntu/openvpn-client/etc/privoxy /config/privoxy/config
sed -i "s|listen-address 0\.0\.0\.0:8118|listen-address 0\.0\.0\.0:$PRIVOXY_PORT|g" '/config/privoxy/config'
sed -i "s|forward-socks5t \/ localhost:9050|forward-socks5t \/ localhost:$TORSOCKS_PORT|g" '/config/privoxy/config'
echo '[info] privoxy fixed.'
