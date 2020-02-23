#!/usr/bin/with-contenv bashio
# ==============================================================================
# Adjust host audio group with gid inside container
# ==============================================================================
HOST_AUDIO_GID=$(grep "^audio" /etc/group_host | cut -d':' -f 3)
LOCAL_AUDIO_GID=$(grep "^audio" /etc/group | cut -d':' -f 3)

# Need processing?
bashio::log.info "Host GUID: ${HOST_AUDIO_GID} - Local GUID: ${LOCAL_AUDIO_GID}"
if [ "${HOST_AUDIO_GID}" == "${LOCAL_AUDIO_GID}" ];
    bashio::exit.ok
fi

# Make sure the new GID is unique
if grep ":${HOST_AUDIO_GID}:"; then
    bashio::log.warning "Fix group id permission"
    GROUP_NAME=$(grep ":${HOST_AUDIO_GID}:" /etc/group | cut -d':' -f 0)
    addgroup pulse ${GROUP_NAME}
else
    bashio::log.info "Update local gid for audio"
    sed -i "s/audio:x:${LOCAL_AUDIO_GID}:/audio:x:${HOST_AUDIO_GID}:/g" /etc/group
fi