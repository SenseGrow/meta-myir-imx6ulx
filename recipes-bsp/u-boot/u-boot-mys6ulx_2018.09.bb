# Copyright (C) 2013-2016 Freescale Semiconductor

DESCRIPTION = "U-Boot provided by Freescale && MYiR focus on MYS6ULx board."
require recipes-bsp/u-boot/u-boot.inc

PROVIDES += "u-boot"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRCBRANCH = "2018.09+fslc"
SRCREV = "7cc38fda11ea92f5d91571215c3022b2d4ed7faf"
SRC_URI = "git://github.com/Freescale/u-boot-fslc.git;protocol=git;branch=${SRCBRANCH} \
        file://git/configs \
	file://git/include/configs \
        file://git/board/myir"


S = "${WORKDIR}/git"

inherit fsl-u-boot-localversion

LOCALVERSION ?= "-${SRCBRANCH}"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(mx6|mx6ul|mx6ull|mx7)"
