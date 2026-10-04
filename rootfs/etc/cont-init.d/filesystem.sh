#!/usr/bin/with-contenv bashio
# ==============================================================================
# Initialize file system layout for /data
# ==============================================================================

mkdir -p /data/external
mkdir -p /data/states

# User overrides for daemon.conf (e.g. sample rate / format), read by
# PulseAudio as drop-ins from /etc/pulse/daemon.conf.d/*.conf
mkdir -p /data/daemon.conf.d
rm -rf /etc/pulse/daemon.conf.d
ln -s /data/daemon.conf.d /etc/pulse/daemon.conf.d

# Cleanup / Migration
if bashio::fs.directory_exists /data/internal; then
    rm -rf /data/internal
fi
