ARG BUILD_FROM=ghcr.io/home-assistant/base:3.23-2026.03.1
FROM ${BUILD_FROM}

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

ARG PULSE_VERSION="17.0"

RUN \
    --mount=type=bind,source=./patches/,target=/usr/src/patches \
    set -x \
    && apk add --no-cache \
        eudev \
        eudev-libs \
        libintl \
        libltdl \
        alsa-utils \
        alsa-lib \
        alsa-plugins-pulse \
        alsa-topology-conf \
        alsa-ucm-conf \
        dbus-libs \
        tdb-libs \
        bluez-libs \
        libsndfile \
        speexdsp \
        openssl \
        fftw \
        soxr \
        sbc \
    && apk add --no-cache --virtual .build-deps \
        meson \
        build-base \
        tdb-dev \
        alsa-lib-dev \
        dbus-dev \
        glib-dev \
        libsndfile-dev \
        soxr-dev \
        fftw-dev \
        bluez-dev \
        openssl-dev \
        speexdsp-dev \
        eudev-dev \
        sbc-dev \
        libtool \
        git \
        m4 \
        patch \
    \
    && git clone -b v${PULSE_VERSION} --depth 1 \
        https://github.com/pulseaudio/pulseaudio /usr/src/pulseaudio \
    && cd /usr/src/pulseaudio \
    && for i in /usr/src/patches/*.patch; do \
        patch -d /usr/src/pulseaudio -p 1 < "${i}"; done \
    && meson \
        --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --optimization=3 \
        --buildtype=plain \
        -Datomic-arm-linux-helpers=true \
        -Datomic-arm-memory-barrier=false \
        -Dgcov=false \
        -Dman=false \
        -Dtests=false \
        -Dsystem_user=root \
        -Dsystem_group=root \
        -Daccess_group=root \
        -Ddatabase=tdb \
        -Dalsa=enabled \
        -Dasyncns=disabled \
        -Davahi=disabled \
        -Dbluez5=enabled \
        -Ddbus=enabled \
        -Dfftw=enabled \
        -Dglib=enabled \
        -Dgsettings=disabled \
        -Dgtk=disabled \
        -Dhal-compat=false \
        -Dipv6=false \
        -Djack=disabled \
        -Dlirc=disabled \
        -Dopenssl=enabled \
        -Dorc=disabled \
        -Dsamplerate=disabled \
        -Dsoxr=enabled \
        -Dspeex=enabled \
        -Dsystemd=disabled \
        -Dudev=enabled \
        -Dx11=disabled \
        -Ddoxygen=false \
        -Dudevrulesdir=/usr/lib/udev/rules.d \
        . output \
    && ninja -C output \
    && ninja -C output install \
    \
    && apk del .build-deps \
    && rm -rf \
        /usr/src/pulseaudio

COPY rootfs /

LABEL \
    io.hass.type="audio" \
    org.opencontainers.image.title="Home Assistant Audio Plugin" \
    org.opencontainers.image.description="Home Assistant Supervisor plugin for Audio" \
    org.opencontainers.image.authors="The Home Assistant Authors" \
    org.opencontainers.image.url="https://www.home-assistant.io/" \
    org.opencontainers.image.documentation="https://www.home-assistant.io/docs/" \
    org.opencontainers.image.licenses="Apache License 2.0"
