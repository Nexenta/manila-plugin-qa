#!/bin/bash

if [[ "$1" == "stack" && "$2" == "install" ]]; then
    cd /home/ubuntu
    git clone -b $NS_CINDER_BRANCH https://github.com/Nexenta/manila.git
    cp -r manila/manila/volume/drivers/nexenta /opt/stack/manila/manila/volume/drivers
    cp manila/manila/exception.py /opt/stack/manila/manila/
    cp manila/manila/opts.py /opt/stack/manila/manila/
fi
