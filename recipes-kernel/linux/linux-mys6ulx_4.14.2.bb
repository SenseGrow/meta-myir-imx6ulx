# Copyright (C) 2013-2016 Freescale Semiconductor
# Released under the MIT license (see COPYING.MIT for the terms)
#file://git/drivers/staging/iio/adc/
SUMMARY = "Linux Kernel for MYiR MYS6ULx board"
DESCRIPTION = "Linux Kernel provided and supported by Freescale with focus on \
i.MX Family Reference Boards. It includes support for many IPs such as GPU, VPU and IPU."

require recipes-kernel/linux/linux-imx.inc
#require recipes-kernel/linux/linux-dtb.inc

DEPENDS += "lzop-native bc-native"

LOCALVERSION = "-1.2.0"
SRCREV = "6b774eec1f9d3064e9b33634dfa99d5666d0a73a"
SRCBRANCH = "4.14-2.0.x-imx"
SRC_URI = "git://github.com/Freescale/linux-fslc.git;protocol=git;branch=${SRCBRANCH} \
        file://defconfig \
        file://git/arch/arm/boot/dts \
        file://git/net/wireless \
"

DEFAULT_PREFERENCE = "1"
