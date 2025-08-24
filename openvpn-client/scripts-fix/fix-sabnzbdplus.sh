#!/bin/bash

SAB_PORT_A=${USENET_HTTP_PORT}
SAB_PORT_B=${USENET_HTTPS_PORT}
sed -i "s|_SAB_PORT_A_|$SAB_PORT_A|g" '/nftables.rules'
sed -i "s|_SAB_PORT_B_|$SAB_PORT_B|g" '/nftables.rules'
sed -i "s|:8080|:$SAB_PORT_A|g" '/app/launcher/index.html'

mkdir -p /config/sabnzbdplus \
    && cp --update=none /static-ubuntu/openvpn-client/etc/sabnzbdplus.ini /config/sabnzbdplus/ \
    && mkdir -p /data/sabnzbdplus/watch \
    && mkdir -p /data/sabnzbdplus/incomplete \
    && mkdir -p /data/sabnzbdplus/complete \
    && mkdir -p /data/sabnzbdplus/script
sed -i "s|port = 8080|port = $SAB_PORT_A|g" '/config/sabnzbdplus/sabnzbdplus.ini'
sed -i "s|https_port = 8090|https_port = $SAB_PORT_B|g" '/config/sabnzbdplus/sabnzbdplus.ini'
echo '[info] sabnzbdplus fixed.'
