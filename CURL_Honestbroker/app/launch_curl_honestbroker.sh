#!/bin/bash
# This script launches the CURL HonestBroker Application.

# Username of the user owning the database.
CUR_USER=$(whoami)

# CURL HonestBroker directory bindings.
HONEST_BROKER_DATA_DIR="$(pwd)/honest_broker_$CUR_USER"

# Copy files if directory doesn't exist.
if [[ ! -d $HONEST_BROKER_DATA_DIR ]]
then
    echo "[CURL-Honest-Broker] Running first time setup..."
    # Make directories if they don't exist.
    mkdir  "$HONEST_BROKER_DATA_DIR"

    # If we bind mount /curl-honestbroker, we will overwrite the existing files (which need to exist) inside container.
    # First, we need to copy the files from the internal volume to an external location.
    apptainer exec --bind "$HONEST_BROKER_DATA_DIR:/curl-honestbroker-tmp-export" \
                   curl-honestbroker_1.2.0.sif \
                   bash -c 'cp -r /curl-honestbroker/* /curl-honestbroker-tmp-export/'

    echo "CURL Honest Broker data directory created at '$HONEST_BROKER_DATA_DIR'."
fi

# Launch Honest Broker
apptainer run --bind "$HONEST_BROKER_DATA_DIR:/curl-honestbroker" \
    curl-honestbroker_1.2.0.sif
