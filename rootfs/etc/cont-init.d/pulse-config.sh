#!/usr/bin/with-contenv bashio
# ==============================================================================
# Check device information and adjust Pulse
# ==============================================================================
ALSA_CARDS="$(aplay -l)"

# RaspberryPi
if echo "${ALSA_CARDS}" | grep -q "\[bcm2835 ALSA\]"; then
    bashio::log.info "Found RaspberryPi system"

    sed -i "s/module-udev-detect/module-udev-detect tsched=0/" /etc/pulse/system.pa
# Odroid N2
elif echo "${ALSA_CARDS}" | grep -q "\[G12B-ODROID-N2\]"; then
    bashio::log.info "Found Odroid N2 system"

    sed -i "s/module-udev-detect/module-udev-detect tsched=0/" /etc/pulse/system.pa
fi
