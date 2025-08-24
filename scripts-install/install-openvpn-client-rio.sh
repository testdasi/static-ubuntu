#!/bin/bash

## add onion pack depending on torless build opt ##
if [[ ${BUILD_OPT} =~ "torless" ]]
then
    echo "$(date "+%d.%m.%Y %T") Skip onion pack due to build option ${BUILD_OPT}" >> /build.info
else
    echo "$(date "+%d.%m.%Y %T") Adding onion pack due to build option ${BUILD_OPT}" >> /build.info
    source /testdasi/scripts-install/install-tor.sh
fi

## Ensure critical packages are not autoremove
source /testdasi/scripts-install/install-openvpn-client-final.sh

## Make copy of static folder ##
mkdir -p /static-ubuntu
cp -rf /testdasi/scripts-debug /static-ubuntu/
cp -rf /testdasi/openvpn-client /static-ubuntu/

## dups various executables ##
# dup mono binary #
cp /usr/bin/mono /usr/bin/mono-sonarr \
    && chmod +x /usr/bin/mono-sonarr

# dup python3 binary #
cp /usr/bin/python3 /usr/bin/python3-launcher \
    && chmod +x /usr/bin/python3-launcher
cp /usr/bin/python3 /usr/bin/python3-nzbhydra2 \
    && chmod +x /usr/bin/python3-nzbhydra2

## chmod scripts ##
chmod +x /app/radarr/Radarr
chmod +x /app/prowlarr/Prowlarr
chmod +x /*.sh
chmod +x /static-ubuntu/scripts-debug/*.sh
chmod +x /static-ubuntu/openvpn-client/*.sh
chmod +x /static-ubuntu/openvpn-client/scripts-fix/*.sh
