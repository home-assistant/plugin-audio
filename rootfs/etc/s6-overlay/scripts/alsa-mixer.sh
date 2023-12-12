#!/usr/bin/with-contenv bashio
# ==============================================================================
# Initial ALSA mixer adjustments 
# ==============================================================================

# Guard if no sound support found
if ! bashio::fs.directory_exists /dev/snd; then
    bashio::log.warning "Can't find sound device for ALSA mixer settings"
    bashio::exit.ok
fi

# Loop over all Controls
for control in /dev/snd/control*
do
    bashio::log.info "Adjust ALSA mixer settings for ${control}"
    soundconfig "${control}"
done
