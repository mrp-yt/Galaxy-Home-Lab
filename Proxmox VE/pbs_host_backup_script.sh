#!/bin/bash

# Define variables
HOSTNAME=$(hostname)
PXAR_FILE="${HOSTNAME}.pxar"
USER="<USERNAME>"
SERVER="<PBS_IP>"
DATASTORE="<DATASTORE>"
NAMESPACE="<NAMESPACE>"
export PBS_PASSWORD=<PASSWORD>

proxmox-backup-client backup ${PXAR_FILE}:/ --repository ${USER}@pbs@${SERVER}:${DATASTORE} --ns ${NAMESPACE} --exclude /mnt