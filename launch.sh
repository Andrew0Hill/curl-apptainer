#!/bin/bash
set -e

# Start CURL Honestbroker DB
(cd ./CURL_Honestbroker/db && ./launch_curl_honestbroker_db.sh) &

# Start CURL Honestbroker
(cd ./CURL_Honestbroker/app && ./launch_curl_honestbroker.sh) &

# Start CURL Site
(cd ./CURL_Site && ./launch_curl_site.sh) &

# Wait for apps
wait