#!/usr/bin/with-contenv bashio
# ==============================================================================
# Check device information and adjust Pulse
# ==============================================================================
declare tsched

# shellcheck disable=SC2155
readonly ALSA_CARDS="$(aplay -l)"

# RaspberryPi
if [[ "${ALSA_CARDS}" =~ \[bcm2835.*?\] ]]; then
    bashio::log.info "Found RaspberryPi system"
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
