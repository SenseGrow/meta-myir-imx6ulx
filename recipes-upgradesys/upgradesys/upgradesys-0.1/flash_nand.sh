#!/bin/sh
part_uboot=0
part_kernel=1
part_dtb=2
part_rootfs=3

mfg_path=/run/media/mmcblk0p1/mfg-images
uboot=${mfg_path}/u-boot-mys6ul-nand.imx
kernel=${mfg_path}/zImage
dtb=${mfg_path}/mys-imx6ul-14x14-evk-gpmi-weim.dtb
rootfs=${mfg_path}/core-image-base-mys6ul-20170402092307.rootfs.tar.bz2

echo "Flashing uboot"
flash_erase /dev/mtd${part_uboot} 0 0 && kobs-ng init -x -v ${uboot}

echo "Flashing kernel"
flash_erase /dev/mtd${part_kernel} 0 0 && nandwrite -p /dev/mtd${part_kernel} -p ${kernel}

echo "Flashing dtb"
flash_erase /dev/mtd${part_dtb} 0 0 && nandwrite -p /dev/mtd${part_dtb} -p ${dtb}

echo "Flashing kernel"
flash_erase /dev/mtd${part_rootfs} 0 0 \
 && ubiformat /dev/mtd${part_rootfs} \
 && ubiattach /dev/ubi_ctrl -m ${part_rootfs} \
 && ubimkvol /dev/ubi0 -Nrootfs -m \
 && mkdir -p /mnt/mtd${part_rootfs} \
 && mount -t ubifs ubi0:rootfs /mnt/mtd${part_rootfs} \
 && tar xvf ${rootfs} -C /mnt/mtd${part_rootfs} \
 && sync && sync && sync
umount /mnt/mtd${part_rootfs}
