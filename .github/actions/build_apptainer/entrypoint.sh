#!/bin/bash
set -e

# This is a basic entrypoint script to identify an Apptainer definition file (*.def)
# and build an appropriately named container file (*.sif).

# Default working directory is the repository mount.
WORK_DIR="${1:-'/github/workspace'}"

# Move to the work directory.
cd "$WORK_DIR"

# Find all files which look like a .def file.
DEF_FILES=($(find . -regex '.*\.def'))

# If there are no files found, error out.
if [[ "${#DEF_FILES[@]}" -eq 0 ]]
then
    echo "No build files found!"
    exit 1
fi

# Iterate each file and build the container.
for DEF_FILE in "${DEF_FILES[@]}"
do
    # Get the enclosing directory for this file
    DEF_DIR=$(dirname "$DEF_FILE")
    # Get the basename of the file.
    DEF_FILE_NODIR=$(basename "$DEF_FILE")
    # Move into the enclosing directory and build .def file into a .sif container.
    echo "Building '${DEF_FILE}'..." && \
    cd "$DEF_DIR" && \
    apptainer build "${DEF_FILE_NODIR%.def}.sif" "$DEF_FILE_NODIR"
done