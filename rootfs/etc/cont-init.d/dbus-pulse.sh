#!/usr/bin/with-contenv bashio
# ==============================================================================
# Start udev service
# ==============================================================================
bashio::log.info "Adjust dbus permission for PulseAudio"

if ! cp /etc/dbus-1/system.d/pulseaudio-system.conf /host/dbus-1/; then
    bashio::log.warning "Can't update PulseAudio profile"
fi
