# CURL Apptainer
This repo contains files for building and running Apptainer-contained versions of the CURL applications (CURL Site and CURL Honestbroker)

# Prerequisites
To use this repository you will need:

1. Apptainer (`apptainer` or `singularity`) installed and configured on the target system.
2. The target machine must have port 5432 (Postgres default port) available, as the CURL Honestbroker DB will use this port.
3. (Optional) Internet access to GitHub.com is preferred (See [Setup - Preferred Method](#setup---preferred-method)) but is not required.
4. (Optional) The Make utility (`make`) can ease setup and cleanup, but is not required.

# Setup 

## Preferred Method
The preferred setup method involves using the provided script to download the built container images from the [Releases](https://github.com/Andrew0Hill/curl-apptainer/releases) page of this repository.

Run the `./download_containers.sh` script located in the repository root. This script will download the three required `.sif` containers from the GitHub releases page, and place them in the correct folder locations.

## Alternative Method
In environments where internet access is not available on the target machine, the following method can be used.

### Step 1 - Download Files
On a machine with internet access, download the following files:
1. On the repository page, click the green `<> Code` button, and then click `Download ZIP` to download a ZIP archive of the repository.
2. Navigate to the Releases page, and download all three `.sif` container files from the current release.

### Step 2 - Upload to Target Machine
Upload the ZIP archive, along with the three `.sif` files to the target system.

### Step 3 - Configure Files
Extract the ZIP archive to the desired location.

Inside the extracted folder, place each `.sif` file in the corresponding location.

| Container | Folder Location |
|------|----------------|
| `curl-honestbroker-db_1.2.0.sif` | `<repo_root>/CURL_Honestbroker/db/curl-honestbroker-db_1.2.0.sif` |
| `curl-honestbroker_1.2.0.sif`    | `<repo_root>/CURL_Honestbroker/app/curl-honestbroker_1.2.0.sif`   |
| `curl-site_1.2.0.sif`            | `<repo_root>/CURL_Site/curl-site_1.2.0.sif`                       |

> [!WARNING]
> Ensure that the file names on the target machine match **exactly** to those listed above (i.e. there are no prefixes or extra characters added from the bucket transfer or other process.)
>
> The launch scripts for each container will fail if the filenames are not correct.
>
> If the paths are not correct, `launch.sh` will fail partway through initialization, and require the manual removal of the bind mount folders created for each container (See [Troubleshooting](#troubleshooting)).

# Running the Containers

### Step 1: Run launch script
Use the `./launch.sh` script in the repository root to launch all three containers. 

>[!WARNING]
> The terminal used by `./launch.sh` needs to stay open to keep the containers running. If this terminal process exits or is killed, CURL will stop running.

### Step 2: Confirm browser access
Confirm that:

| Site | Address |
|-----|------|
| CURL Site | `localhost:8060` |
| CURL Honestbroker | `localhost:8050` |

are both accessible via the browser on the target machine.

# Troubleshooting
On first launch, each container will initialize a folder on the host machine which acts as a writable storage location for each container. Subsequent launches will check if this folder exists, and skip initialization if the folder is found.

| Directory |
|-----------|
| `<repo_root>/CURL_Honestbroker/app/honest_broker_<username>` |
| `<repo_root>/CURL_Honestbroker/db/pg_data_<username>` |
| `<repo_root>/CURL_Site/curl_site_<username>` |

where `<username>` is the value of `$(whoami)` (i.e. the name of the logged in user).

One common issue is that the system will fail to initialize on first launch (due to a missing container, incorrect path, etc), but future launches will assume that the system is already intiialized since the bind mount folders exist.

If `make` is available, you can run `make clean_data` to remove the bind mount folders for each container (make sure the containers are not running first) and force the next launch to re-run the initialization. You can also remove the three directories manually (i.e. `rm -rf`)

>[!CAUTION]
> If you have existing linkage results, job configs, etc that are not backed up, make sure to copy them **out** of the bind mount folders before running `make clean_data` to avoid the possibility of data loss.

