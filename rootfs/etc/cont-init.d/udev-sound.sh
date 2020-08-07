#!/usr/bin/with-contenv bashio
# ==============================================================================
# Start udev service
# ==============================================================================
udevd --daemon

bashio::log.info "Update udev subsystem sound"
if udevadm trigger --subsystem-match=sound; then
    udevadm settle || true
else
    bashio::log.warning "Triggering of sound udev rules fails!"
fi
