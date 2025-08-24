#!/bin/bash

# This ensures additional critical packages are not autoremove by apt

apt -y update
apt -y install dnsutils
apt -y install sipcalc
apt -y install iproute2
apt -y autoclean
apt -y clean
rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*
