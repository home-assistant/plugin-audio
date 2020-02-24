#!/usr/bin/with-contenv bashio
# ==============================================================================
# Start udev service
# ==============================================================================
udevd --daemon

bashio::log.info "Update udev subsystem sounds"
udevadm trigger --subsystem-match=sound
udevadm settle
