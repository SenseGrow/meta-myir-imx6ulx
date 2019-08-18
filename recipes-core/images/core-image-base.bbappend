IMAGE_INSTALL += "imx-kobs \
    tslib-calibrate \
    tslib-conf \
    tslib-tests \
    bzip2 \
    gzip \
    canutils \
    dosfstools \
    mtd-utils \
    mtd-utils-ubifs \
    tar \
    net-tools \
    ethtool \
    evtest \
    i2c-tools \
    iperf3 \
    iproute2 \
    iputils \
    udev-extraconf \
    rpm \
    openssh \
    openssl \
    v4l-utils \
    ${@oe.utils.conditional("MACHINE", "mys6ull14x14", "rtl8188eu-driver", "", d)} \
    alsa-utils \
    ppp \
    ppp-quectel \
    hostapd \
    myir-rc-local"
