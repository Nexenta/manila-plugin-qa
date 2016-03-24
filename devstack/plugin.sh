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
    sed -i 'identity]/a\
    alt_tenant_name = alt_demo\
    alt_password = secretadmin\
    alt_username = alt_demo\
    tenant_name = demo\
    password = nova\
    username = demo', /opt/stack/tempest/etc/tempest.conf
    sed -i 'share]/a\
    multitenancy_enabled = False\
    enable_protocols = nfs\
    enable_ip_rules_for_protocols = nfs\
    capability_storage_protocol = NFS', /opt/stack/tempest/etc/tempest.conf
    cp -r manila/manila/share/drivers/nexenta /opt/stack/manila/manila/share/drivers
fi
