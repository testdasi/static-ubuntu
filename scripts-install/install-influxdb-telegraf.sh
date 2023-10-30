#!/bin/bash

## Install dependencies ##
apt -y update \
    && apt -y install gnupg gnupg1 gnupg2 dirmngr ca-certificates apt-transport-https software-properties-common

## Install telegraf + influxdb from repo ##
curl -sOL "https://repos.influxdata.com/influxdb.key"
apt-key add influxdb.key
echo "deb https://repos.influxdata.com/ubuntu focal stable" | tee /etc/apt/sources.list.d/influxdb.list
curl -sOL "https://repos.influxdata.com/influxdata-archive_compat.key"
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | tee /etc/apt/sources.list.d/influxdata.list
apt -y update \
    && apt -y install telegraf influxdb
rm -rf /etc/telegraf
rm -rf /etc/influxdb
INFLUXDB_VERSION=$(influxd version | cut -d' ' -f 2 | cut -d'v' -f 2)
TELEGRAF_VERSION=$(telegraf version | cut -d' ' -f 2)
echo "$(date "+%d.%m.%Y %T") Added InfluxDB version ${INFLUXDB_VERSION}" >> /build.info
echo "$(date "+%d.%m.%Y %T") Added Telegraf version ${TELEGRAF_VERSION}" >> /build.info

## Clean up ##
apt -y autoremove \
    && apt -y autoclean \
    && apt -y clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
