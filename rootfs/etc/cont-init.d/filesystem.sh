#!/usr/bin/with-contenv bashio
# ==============================================================================
# Initialize file system layout for /data
# ==============================================================================

mkdir -p /data/external
mkdir -p /data/states

# Cleanup / Migration
if bashio::fs.directory_exists /data/internal; then
    rm -rf /data/internal
fi
