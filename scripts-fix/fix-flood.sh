#!/bin/bash

FLOOD_IP=${SERVER_IP}
FLOOD_PORT=${TORRENT_GUI_PORT}
sed -i "s|_FLOOD_PORT_|$FLOOD_PORT|g" '/nftables.rules'
sed -i "s|:3000|:$FLOOD_PORT|g" '/app/launcher/index.html'

mkdir -p /config/flood/db \
    && cp -n /static-ubuntu/etc/flood.db /config/flood/db/users.db
echo '[info] flood fixed.'
