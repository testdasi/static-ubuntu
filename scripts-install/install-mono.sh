#!/bin/bash

## Based on official instruction at https://www.mono-project.com/download/stable/#download-lin-ubuntu ##
apt-get -y update \
  && apt-get -y install gnupg ca-certificates \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
  && apt-get -y update
apt-get -y install mono-complete

## Clean up ##
apt-get -y autoremove \
    && apt-get -y autoclean \
    && apt-get -y clean \
    && rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*