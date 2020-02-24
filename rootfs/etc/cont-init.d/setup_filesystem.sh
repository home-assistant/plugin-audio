#!/usr/bin/with-contenv bashio
# ==============================================================================
# Make lib/pulse persist and init path
# ==============================================================================

# External
if [ ! -d /data/external ]; then
    mkdir -p /data/external
fi

# Internal
if [ ! -d /data/internal ]; then
    mkdir -p /data/internal
    mkdir -p /data/internal/states
    chown -R pulse:pulse /data/internal
fi

# Mount persistant data
mount --bind /data/internal/states /var/lib/pulse
