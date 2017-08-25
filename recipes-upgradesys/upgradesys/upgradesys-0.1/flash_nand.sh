#!/bin/sh
part_uboot=0
part_kernel=1
part_dtb=2
part_rootfs=3

echo heartbeat > /sys/class/leds/user/trigger

mfg_path=/run/media/mmcblk0p1/mfg-images
if [ -f ${mfg_path}/Manifest ]
then
    . ${mfg_path}/Manifest
else
    echo "Can not find file ${mfg_path}Manifest"
    echo 0 > /sys/class/leds/user/brightness
    exit 1
fi
uboot=${mfg_path}/${ubootfile}
kernel=${mfg_path}/${kernelfile}
dtb=${mfg_path}/${dtbfile}
rootfs=${mfg_path}/${rootfsfile}

echo "Update file list:"
echo "uboot file: ${uboot}"
echo "kernel file: ${kernel}"
echo "dtb file: ${dtb}"
echo "rootfs file: ${rootfs}"

if [ -d $mfg_path ] && [ -s $uboot ] && [ -s $kernel ] && [ -s $dtb ] && [ -s $rootfs ]
then
    echo "prepare files are okay"
else
    echo 0 > /sys/class/leds/user/brightness
    echo "file or directory not exist"
    exit 1
fi

echo "Flashing uboot"
flash_erase /dev/mtd${part_uboot} 0 0 && kobs-ng init -x -v ${uboot}
if [ $? -eq 0 ]
then
    echo "Flash uboot okay"
else
    echo "Flash uboot failed"
    echo 0 > /sys/class/leds/user/brightness
    exit 1
fi

echo "Flashing kernel"
flash_erase /dev/mtd${part_kernel} 0 0 && nandwrite -p /dev/mtd${part_kernel} -p ${kernel}
if [ $? -eq 0 ]
then
    echo "Flash kernel okay"
else
    echo "Flash kernel failed"
    echo 0 > /sys/class/leds/user/brightness
    exit
fi
echo "Flashing dtb"
flash_erase /dev/mtd${part_dtb} 0 0 && nandwrite -p /dev/mtd${part_dtb} -p ${dtb}
if [ $? -eq 0 ]
then
    echo "Flash dtb file okay"
else
    echo "Flash dtb file failed"
    echo 0 > /sys/class/leds/user/brightness
    exit
fi

echo "Flashing kernel"
flash_erase /dev/mtd${part_rootfs} 0 0
if [ $? -ne 0 ]
then
    echo "erase /dev/mtd${part_rootfs} fail"
    echo 0 > /sys/class/leds/user/brightness
    exit
fi

ubiformat /dev/mtd${part_rootfs}
if [ $? -ne 0 ]
then
    echo "format /dev/mtd${part_rootfs} fail"
    echo 0 > /sys/class/leds/user/brightness
    exit
fi

ubiattach /dev/ubi_ctrl -m ${part_rootfs}
if [ $? -ne 0 ]
then
    echo "attach /dev/mtd${part_rootfs} fail"
    echo 0 > /sys/class/leds/user/brightness
    exit
fi

ubimkvol /dev/ubi0 -Nrootfs -m
if [ $? -ne 0 ]
then
    echo "make volume /dev/mtd${part_rootfs} fail"
    echo 0 > /sys/class/leds/user/brightness
    exit
fi

mkdir -p /run/media/mtd${part_rootfs} \
 && mount -t ubifs ubi0:rootfs /run/media/mtd${part_rootfs}
if [ $? -ne 0 ]
then
    echo "mount /dev/mtd${part_rootfs} fail"
    echo 0 > /sys/class/leds/user/brightness
    exit
fi

tar xvf ${rootfs} -C /run/media/mtd${part_rootfs}
if [ $? -eq 0 ]
then
    echo "Flash filesystem okay"
    sync && sync && sync
    echo none > /sys/class/leds/user/trigger
    echo 1 > /sys/class/leds/user/brightness
else
    echo "Flash filesystem failed"
    echo 0 > /sys/class/leds/user/brightness
    umount /run/media/mtd${part_rootfs}
    exit
fi
umount /run/media/mtd${part_rootfs}
echo "Programming success"
echo "You need reboot the board"
