#!/bin/bash

if [[ "$1" == "stack" && "$2" == "install" ]]; then
    cd /home/ubuntu
    rm -rf manila
    git clone -b $NS_CINDER_BRANCH https://github.com/Nexenta/manila.git
    printf '\n\nclass NexentaException(ManilaException):\n    message = _("Exception due to Nexenta failure.")\n' >> /opt/stack/manila/manila/exception.py
    sed -i '/manila.share.drivers.netapp.options.netapp_provisioning_opts,/a\
    manila.share.drivers.nexenta.options.NEXENTA_CONNECTION_OPTS,\
    manila.share.drivers.nexenta.options.NEXENTA_NFS_OPTS,\
    manila.share.drivers.nexenta.options.NEXENTA_DATASET_OPTS,' /opt/stack/manila/manila/opts.py
    cp -r manila/manila/share/drivers/nexenta /opt/stack/manila/manila/share/drivers
fi
