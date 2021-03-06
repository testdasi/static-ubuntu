#!/bin/bash

## Install dependencies ##
apt -y update
mkdir -p /etc/init.d.disabled

## torsocks ##
apt -y install torsocks
mv /etc/init.d/tor /etc/init.d.disabled/ \
    && rm -Rf /etc/tor/*
TOR_VERSION=$(tor --version | cut -d' ' -f 3 | cut -c'1-7')
echo "$(date "+%d.%m.%Y %T") Added torsocks version ${TOR_VERSION}" >> /build.info

## privoxy ##
apt -y install privoxy
mv /etc/init.d/privoxy /etc/init.d.disabled/ \
    && rm -Rf /etc/privoxy/*
PRIVOXY_VERSION=$(privoxy --version | cut -d' ' -f 3)
echo "$(date "+%d.%m.%Y %T") Added privoxy version ${PRIVOXY_VERSION}" >> /build.info

## Clean up ##
apt -y autoremove \
    && apt -y autoclean \
    && apt -y clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
