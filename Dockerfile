ARG BUILD_FROM
FROM ${BUILD_FROM}

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

ARG ALSA_VERSION
ARG PULSE_VERSION

COPY patches /usr/src/patches
RUN \
    set -x \
    && apk add --no-cache \
        eudev \
        libintl \
        libltdl \
        alsa-utils \
        alsa-lib \
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
    && curl -L -s --retry 5 \
        "ftp://ftp.alsa-project.org/pub/lib/alsa-ucm-conf-${ALSA_VERSION}.tar.bz2" \
        | tar xvfj - -C /usr/share/alsa --strip-components=1 \
    \
    && curl -L -s --retry 5 \
        "ftp://ftp.alsa-project.org/pub/lib/alsa-topology-conf-${ALSA_VERSION}.tar.bz2" \
        | tar xvfj - -C /usr/share/alsa --strip-components=1 \
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
        -Dbluez5=true \
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
        -Dudevrulesdir=/usr/lib/udev/rules.d \
        . output \
    && ninja -C output \
    && ninja -C output install \
    \
    && apk del .build-deps \
    && rm -rf \
        /usr/src/pulseaudio \
        /usr/src/patches

COPY rootfs /
