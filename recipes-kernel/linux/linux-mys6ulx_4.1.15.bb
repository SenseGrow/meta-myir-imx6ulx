# Copyright (C) 2013-2016 Freescale Semiconductor
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Linux Kernel for MYiR MYS6ULx board"
DESCRIPTION = "Linux Kernel provided and supported by Freescale with focus on \
i.MX Family Reference Boards. It includes support for many IPs such as GPU, VPU and IPU."

require recipes-kernel/linux/linux-imx.inc
require recipes-kernel/linux/linux-dtb.inc

DEPENDS += "lzop-native bc-native"

#SRCBRANCH = "imx_4.1.15_2.0.0_ga"
LOCALVERSION = "-1.2.0"
#SRCREV = "77f61547834c4f127b44b13e43c59133a35880dc"
SRCREV = "8d98da659f6572fb374fab26107a6eda87a96576"
# Add patches for gcc 6 compiler issue
#SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=git;branch=${SRCBRANCH} \
#           file://defconfig"
SRCBRANCH = "mys-imx6ulx"
SRC_URI = "git:///home/blackrose/mys-imx6ul/MYS-IMX6UL-Linux;protocol=file;branch=${SRCBRANCH} \
        file://defconfig"

DEFAULT_PREFERENCE = "1"

COMPATIBLE_MACHINE = "(mx6ull|mx6ul)"
