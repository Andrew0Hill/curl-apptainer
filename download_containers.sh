#!/bin/bash
# Downloads pre-built containers to the appropriate directories.

curl --output-dir CURL_Honestbroker/db --remote-name -L https://github.com/Andrew0Hill/curl-apptainer/releases/download/1.2.0/curl-honestbroker-db_1.2.0.sif && \
curl --output-dir CURL_Honestbroker/app --remote-name -L https://github.com/Andrew0Hill/curl-apptainer/releases/download/1.2.0/curl-honestbroker_1.2.0.sif && \
curl --output-dir CURL_Honestbroker/app --remote-name -L https://github.com/Andrew0Hill/curl-apptainer/releases/download/1.2.0/curl-site_1.2.0.sif
