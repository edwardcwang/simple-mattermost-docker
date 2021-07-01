#!/bin/bash
set -ex
set -euo pipefail

# Refresh settings
(cd /opt/mattermost/config && ./build-config-json)

# Run mattermost
cd /opt/mattermost
./bin/mattermost
