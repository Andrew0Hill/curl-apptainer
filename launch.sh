#!/bin/bash
set -e

# Start CURL Honestbroker DB
./CURL_Honestbroker/db/launch_curl_honestbroker_db.sh &

# Start CURL Honestbroker
./CURL_Honestbroker/app/launch_curl_honestbroker.sh &

# Start CURL Site
./CURL_Site/launch_curl_site.sh &

# Wait for apps
wait