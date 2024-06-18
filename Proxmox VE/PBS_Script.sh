#!/bin/bash

# Define variables
HOSTNAME=$(hostname)
PXAR_FILE="${HOSTNAME}.pxar"
USER="<USERNAME>"
SERVER="<PBS_IP>"
DATASTORE="<DATASTORE>"
NAMESPACE="<NAMESPACE>"
export PBS_PASSWORD=<PASSWORD>

# Run the backup commandy