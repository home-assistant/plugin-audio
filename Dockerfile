ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    eudev \
    pulseaudio \
    pulseaudio-alsa

COPY rootfs /
