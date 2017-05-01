
inherit core-image
IMAGE_INSTALL += "imx-kobs \
    bzip2 \
    xz \
    gzip \
    mtd-utils \
    mtd-utils-ubifs \
    upgradesys \
    rpm \
    udev-extraconf \
    udev-rules-imx"
disable_service() {
    rm ${IMAGE_ROOTFS}${sysconfdir}/rc5.d/S01networking
    rm ${IMAGE_ROOTFS}${sysconfdir}/rc5.d/S22ofono
    rm ${IMAGE_ROOTFS}${sysconfdir}/rc5.d/S64neard
    rm ${IMAGE_ROOTFS}${sysconfdir}/rc5.d/S99stop-bootlogd
}
ROOTFS_POSTUNINSTALL_COMMAND += "disable_service; "
IMAGE_FSTYPES = "ext4 "
