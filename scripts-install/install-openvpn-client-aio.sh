#!/bin/bash

## add tor and privoxy depending on torless build opt ##
if [[ ${BUILD_OPT} =~ "torless" ]]
then
    echo "$(date "+%d.%m.%Y %T") Skip torsocks and privoxy due to build option ${BUILD_OPT}" >> /build.info
else
    source /testdasi/scripts-install/install-tor.sh
fi

## Install PIA PF script ##
source /testdasi/scripts-install/install-pia-script.sh

## Make copy of static folder ##
mkdir -p /static-ubuntu
cp -rf /testdasi/scripts-debug /static-ubuntu/
cp -rf /testdasi/openvpn-client /static-ubuntu/

# Improve comptability with old versions #
rm -Rf /etc/openvpn
cp -n /static-ubuntu/openvpn-client/entrypoint.sh /
cp -n /static-ubuntu/openvpn-client/healthcheck.sh /

## chmod scripts ##
chmod +x /*.sh
chmod +x /static-ubuntu/scripts-debug/*.sh
chmod +x /static-ubuntu/openvpn-client/*.sh
chmod +x /static-ubuntu/openvpn-client/scripts-fix/*.sh
