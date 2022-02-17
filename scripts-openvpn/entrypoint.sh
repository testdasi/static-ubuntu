#!/bin/bash

## Only run process if ovpn config found ##
if [[ -f "/config/openvpn/openvpn.ovpn" ]]
then
    echo '[info] OpenVPN config file detected. Continue...'
    
    # Disable health check #
    echo ''
    echo '[info] Disabling healthcheck while openvpn is connecting...'
    touch /config/healthcheck-disable
    echo '[info] Healthcheck disabled'
    
    # Initilise apps #
    echo ''
    echo '[info] Initialisation started...'
    source /static-ubuntu/scripts-openvpn/initialise.sh
    echo '[info] Initialisation complete'

    # Run stubby and use it to check external ISP IP #
    echo ''
    echo "[info] Run stubby in background on port $DNS_PORT"
    stubby -g -C /config/stubby/stubby.yml
    ipnaked=$(dig +short myip.opendns.com @208.67.222.222)
    echo "[warn] Your ISP public IP is $ipnaked"

    # nftables #
    echo ''
    echo '[info] Setting up nftables rules...'
    source /static-ubuntu/scripts-openvpn/nftables.sh
    echo '[info] All rules created'

    # OpenVPN #
    echo ''
    echo "[info] Setting up OpenVPN tunnel..."
    source /static-ubuntu/scripts-openvpn/openvpn.sh
    echo '[info] Tunnel created'

    # Enable health check #
    echo ''
    echo '[info] Enabling healthcheck...'
    rm -f /config/healthcheck-disable
    echo '[info] Healthcheck enabled'
    
    # Run apps #
    echo ''
    echo "[info] Runing apps..."
    touch /config/healthcheck-no-error
    source /static-ubuntu/scripts-openvpn/healthcheck.sh
    rm -f /config/healthcheck-no-error
    echo "[info] All done"

    ### Periodically checking IP ###
    sleep_time=3600
    echo ''
    while true
    do
        iphiden=$(dig +short myip.opendns.com @208.67.222.222)
        echo "[info] Your VPN public IP is $iphiden"
        sleep $sleep_time
    done
else
    echo '[CRITICAL] Config file not found, quitting...'
fi
