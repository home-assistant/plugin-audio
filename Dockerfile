ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    pulseaudio \
    pulseaudio-alsa

COPY overlay /

WORKDIR /data
CMD [""]
