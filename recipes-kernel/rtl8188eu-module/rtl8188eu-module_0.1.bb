SUMMARY = "wifi driver for RTL8188EU on MYS6ULx board"
LICENSE = "GPLv2"
PV = "0.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

inherit module

SRCREV = "cd53ae8cef873f88f05678a9e01aab81a2ea93fe"
SRC_URI = "git://github.com/MYiR-Dev/RTL8188eu-driver;protocol=https;branch=master"

S = "${WORKDIR}/git"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.