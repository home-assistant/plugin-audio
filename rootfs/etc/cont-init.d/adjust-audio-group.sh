#!/usr/bin/with-contenv bashio
# ==============================================================================
# Adjust host audio group with gid inside container
# ==============================================================================
if [ ! -d /dev/snd ]; then
    bashio:log.warning "The host have no audio support!"
    bashio::exit.ok
fi

# Get GID data
HOST_AUDIO_GID="$(grep "^audio" /host/group | cut -d':' -f 3)"
LOCAL_AUDIO_GID="$(grep "^audio" /etc/group | cut -d':' -f 3)"

# Need processing?
bashio::log.info "Host GID: ${HOST_AUDIO_GID} - Local GID: ${LOCAL_AUDIO_GID}"
if [ "${HOST_AUDIO_GID}" == "${LOCAL_AUDIO_GID}" ]; then
    bashio::exit.ok
fi

# Make sure the new GID is unique
if grep ":${HOST_AUDIO_GID}:"; then
    bashio::log.warning "Fix GID permission"
    GROUP_NAME=$(grep ":${HOST_AUDIO_GID}:" /etc/group | cut -d':' -f 0)
    addgroup pulse "${GROUP_NAME}"
else
    bashio::log.info "Update local GID for audio"
    sed -i "s/audio:x:${LOCAL_AUDIO_GID}:/audio:x:${HOST_AUDIO_GID}:/g" /etc/group
fi
