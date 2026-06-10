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
    echo "Building '${DEF_FILE}'..." && apptainer build "${DEF_FILE%.def}.sif" "$DEF_FILE"
done