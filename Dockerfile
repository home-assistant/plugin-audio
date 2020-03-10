ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG ALSA_VERSION
RUN \
    apk add --no-cache \
        eudev \
        socat \
        pulseaudio \
        pulseaudio-alsa \
    \
    && curl -L -s --retry 5 \
        "ftp://ftp.alsa-project.org/pub/lib/alsa-ucm-conf-${ALSA_VERSION}.tar.bz2" \
        | tar xvfj - -C /usr/share/alsa --strip-components=1 \
    \
    && curl -L -s --retry 5 \
        "ftp://ftp.alsa-project.org/pub/lib/alsa-topology-conf-${ALSA_VERSION}.tar.bz2" \
        | tar xvfj - -C /usr/share/alsa --strip-components=1

COPY rootfs /
