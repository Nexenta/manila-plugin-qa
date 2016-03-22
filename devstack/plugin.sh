#!/bin/bash

if [[ "$1" == "stack" && "$2" == "install" ]]; then
    cd /home/ubuntu
    git clone -b $NS_CINDER_BRANCH https://github.com/Nexenta/manila.git
    cp -r manila/manila/volume/drivers/nexenta /opt/stack/manila/manila/volume/drivers
    printf '\n\nclass NexentaException(ManilaException):\n    message = _("Exception due to Nexenta failure.")\n' >> /opt/stack/manila/manila/exception.py
    sed -i '/manila.share.drivers.netapp.options.netapp_provisioning_opts,/a\
    manila.share.drivers.nexenta.options.NEXENTA_CONNECTION_OPTS,\
    manila.share.drivers.nexenta.options.NEXENTA_NFS_OPTS,\
    manila.share.drivers.nexenta.options.NEXENTA_DATASET_OPTS,' /opt/stack/manila/manila/opts.py
fi
