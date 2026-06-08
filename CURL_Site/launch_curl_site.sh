#!/bin/bash
# This script launches the CURL Site Application.

# Username of the user owning the database.
CUR_USER=$(whoami)

# CURL Site directory bindings.
CURL_SITE_DATA_DIR="$(pwd)/curl_site_$CUR_USER"

# Copy files if directory doesn't exist.
if [[ ! -d $CURL_SITE_DATA_DIR ]]
then
    echo "[CURL-Site] Running first time setup..."
    # Make directories if they don't exist.
    mkdir  "$CURL_SITE_DATA_DIR"

    # If we bind mount /curl-site, we will overwrite the existing files (which need to exist) inside container.
    # First, we need to copy the files from the internal volume to an external location.
    apptainer exec --bind "$CURL_SITE_DATA_DIR:/curl-site-tmp-export" \
		   ./curl-site_1.2.0.sif \
    		   bash -c 'cp /curl-site/* /curl-site-tmp-export'
fi

# Move into directory
cd $CURL_SITE_DATA_DIR

# Launch CURL Site.
apptainer run --bind "$CURL_SITE_DATA_DIR:/curl-site" ./curl-site_1.2.0.sif
