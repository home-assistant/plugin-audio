#!/usr/bin/with-contenv bashio
# ==============================================================================
# Check device information and adjust Pulse
# ==============================================================================
declare tsched
readonly ALSA_CARDS="$(aplay -l)"

# RaspberryPi
if echo "${ALSA_CARDS}" | grep -q "\[bcm2835 ALSA\]"; then
    bashio::log.info "Found RaspberryPi system"
    tsched=false

# Odroid N2
elif echo "${ALSA_CARDS}" | grep -q "\[G12B-ODROID-N2\]"; then
    bashio::log.info "Found Odroid N2 system"
    tsched=false

else
    tsched=true
fi

# Generate config
bashio::var.json \
    tsched "^${tsched}" \
    | tempio \
        -template /usr/share/tempio/system.pa \
        -out /etc/pulse/system.pa
