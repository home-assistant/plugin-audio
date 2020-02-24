#!/usr/bin/with-contenv bashio
# ==============================================================================
# Make lib/pulse persist and init path
# ==============================================================================

# External
mkdir -p /data/external

# Internal
mkdir -p /data/internal
mkdir -p /data/internal/states

chowm -R pulse:pulse /data/internal
mount --bind /data/internal/states /var/lib/pulse
