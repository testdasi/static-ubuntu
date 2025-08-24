#!/bin/bash

DNS_PORT=${DNS_SERVER_PORT}
# DoT port is fixed due to TLS protocol
DOT_PORT=853
sed -i "s|_DNS_PORT_|$DNS_PORT|g" '/nftables.rules'

mkdir -p /config/stubby \
    && cp --update=none /static-ubuntu/openvpn-client/etc/stubby.yml /config/stubby/
sed -i "s|  - 0\.0\.0\.0\@53|  - 0\.0\.0\.0\@$DNS_PORT|g" '/config/stubby/stubby.yml'
echo '[info] stubby fixed.'
