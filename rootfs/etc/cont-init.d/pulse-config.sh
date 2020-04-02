#!/usr/bin/with-contenv bashio
# ==============================================================================
# Check device information and adjust Pulse
# ==============================================================================
ALSA_CARDS="$(aplay -l)"

# BCM2835
if echo "${ALSA_CARDS}" | grep "[bcm2835 ALSA]"; then
    bashio::log.info "Found BCM2835 card"

    sed -i "s/module-udev-detect/module-udev-detect tsched=0/" /etc/pulse/system.pa
fi
