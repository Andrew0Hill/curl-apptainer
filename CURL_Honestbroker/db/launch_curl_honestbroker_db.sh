#!/bin/bash
# This script launches the CURL Honestbroker Postgres Database.

# Password for database.
DB_PASS="apptainer"

# Port to host database.
DB_PORT=5432

echo "Database credentials:"
echo "Port: $DB_PORT"
echo "Password: $DB_PASS"

# Username of the user owning the database.
CUR_USER=$(whoami)

# Postgres directory bindings.
PG_DATA_DIR="$(pwd)/pg_data_${CUR_USER}"
PG_VAR_RUN_DIR="$(pwd)/.pg_var_run_${CUR_USER}"

# Make directories if they don't exist.
mkdir -p "$PG_DATA_DIR"
mkdir -p "$PG_VAR_RUN_DIR"

# Launch the database container.
apptainer run \
	--bind "$PG_DATA_DIR:/var/lib/postgresql/data,$PG_VAR_RUN_DIR:/var/run" \
	--env "PGPORT=$DB_PORT,POSTGRES_INITDB_ARGS=--auth=scram-sha-256,POSTGRES_PASSWORD=$DB_PASS,HONESTBROKER_PASSWORD=$DB_PASS" \
	./curl-honestbroker-db_1.2.0.sif

