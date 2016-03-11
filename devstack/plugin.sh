#!/bin/bash

if [[ "$1" == "stack" && "$2" == "install" ]]; then
    cd /home/ubuntu
    rm -rf manila
    git clone -b $NS_CINDER_BRANCH https://github.com/Nexenta/manila.git
    cp -r manila/manila/share/drivers/nexenta /opt/stack/manila/manila/share/drivers
    cp manila/manila/exception.py /opt/stack/manila/manila/
    cp manila/manila/opts.py /opt/stack/manila/manila/
fi
