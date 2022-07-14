#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /usr/src/app/tmp/pids/server.pid

mkdir -p /usr/src/app/config/
touch /usr/src/app/config/master.key

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"