#
# This package used for upgrade system for MYiR MYS6ULx board
#

SUMMARY = "Erasing and Flashing NAND script"
SECTION = "upgradesys"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://flash_nand.sh"

S = "${WORKDIR}"

do_install() {
	     install -d ${D}${bindir}
	     install -m 0777 flash_nand.sh ${D}${bindir}
}
