#!/tmp/busybox sh
#
# Universal Updater Script for Samsung Galaxy S Phones
# (c) 2011 by Teamhacksung
# GSM version
#

set -x
export PATH=/:/sbin:/system/xbin:/system/bin:/tmp:$PATH

# check if we're running on a bml or mtd device
if /tmp/busybox test -e /dev/block/bml7 || [ $(grep mtdblock2 /proc/partitions | awk '{ print $3 }') -lt 395264 ]; then
# we're running on a bml device or using an older mtd partition layout

check_mount() {
    local MOUNT_POINT=`/tmp/busybox readlink $1`
    if ! /tmp/busybox test -n "$MOUNT_POINT" ; then
        # readlink does not work on older recoveries for some reason
        # doesn't matter since the path is already correct in that case
        /tmp/busybox echo "Using non-readlink mount point $1"
        MOUNT_POINT=$1
    fi
    if ! /tmp/busybox grep -q $MOUNT_POINT /proc/mounts ; then
        /tmp/busybox mkdir -p $MOUNT_POINT
        /tmp/busybox umount -l $2
        if ! /tmp/busybox mount -t $3 $2 $MOUNT_POINT ; then
            /tmp/busybox echo "Cannot mount $1 ($MOUNT_POINT)."
            exit 1
        fi
    fi
}

set_log() {
    rm -rf $1
    exec >> $1 2>&1
}

fix_package_location() {
    local PACKAGE_LOCATION=$1
    # Remove leading /mnt
    PACKAGE_LOCATION=${PACKAGE_LOCATION#/mnt}
    # Convert to modern sdcard path
    PACKAGE_LOCATION=`echo $PACKAGE_LOCATION | /tmp/busybox sed -e "s|^/sdcard|/storage/sdcard0|"`
    PACKAGE_LOCATION=`echo $PACKAGE_LOCATION | /tmp/busybox sed -e "s|^/emmc|/storage/sdcard1|"`
    echo $PACKAGE_LOCATION
}

    # make sure sdcard is mounted
    check_mount /mnt/sdcard dev/block/mmcblk0p1 vfat

    # everything is logged into /mnt/sdcard/cyanogenmod_bml.log
    set_log /mnt/sdcard/cyanogenmod_bml.log

    # make sure efs is mounted
    check_mount /efs /dev/block/stl3 rfs

    # create a backup of efs
    if /tmp/busybox test -e /mnt/sdcard/backup/efs ; then
        /tmp/busybox mv /mnt/sdcard/backup/efs /mnt/sdcard/backup/efs-$$
    fi
    /tmp/busybox rm -rf /mnt/sdcard/backup/efs
    
    /tmp/busybox mkdir -p /mnt/sdcard/backup/efs
    /tmp/busybox cp -R /efs/ /mnt/sdcard/backup

    # write the package path to sdcard cyanogenmod.cfg
    if /tmp/busybox test -n "$UPDATE_PACKAGE" ; then
        /tmp/busybox echo `fix_package_location $UPDATE_PACKAGE` > /sdcard/cyanogenmod.cfg
    fi

    # Scorch any ROM Manager settings to require the user to reflash recovery
    /tmp/busybox rm -f /mnt/sdcard/clockworkmod/.settings

    # write decoy recovery to recovery partition
    /tmp/flash_image recovery /tmp/recovery.bin
    if [ "$?" != "0" ] ; then
        exit 8
    fi

    /tmp/busybox sync

    # write new kernel to boot partition
    /tmp/flash_image boot /tmp/boot.img
    if [ "$?" != "0" ] ; then
        exit 3
    fi

    /tmp/busybox sync

    /tmp/busybox reboot now
    exit 9
elif /tmp/busybox test -e /dev/block/mtdblock0 ; then
# we're running on a mtd device

    # make sure sdcard is mounted
    check_mount /sdcard dev/block/mmcblk0p1 vfat

    # remove old log
    rm -rf /sdcard/cyanogenmod_mtd.log

    # everything is logged into /sdcard/cyanogenmod.log
    set_log /sdcard/cyanogenmod_mtd.log

    # if a cyanogenmod.cfg exists, then this is a first time install
    # let's format the volumes and restore efs
    if ! /tmp/busybox test -e /sdcard/cyanogenmod.cfg ; then
        exit 0
    fi
	
    # remove the cyanogenmod.cfg to prevent this from looping
    /tmp/busybox rm -f /sdcard/cyanogenmod.cfg

    # unmount, format and mount system
    /tmp/busybox umount -l /system
    /tmp/erase_image system
    /tmp/busybox mount -t yaffs2 /dev/block/mtdblock2 /system

    # unmount and format cache
    /tmp/busybox umount -l /cache
    /tmp/erase_image cache

    # unmount and format data
    /tmp/busybox umount /data
    /tmp/make_ext4fs -b 4096 -g 32768 -i 8192 -I 256 -a /data /dev/block/mmcblk0p2

    # unmount and format datadata
    /tmp/busybox umount -l /datadata
    /tmp/erase_image dbdatafs

    # restore efs backup
    if /tmp/busybox test -e /sdcard/backup/efs/serial.info ; then
        /tmp/busybox umount -l /efs
        /tmp/erase_image efs
        /tmp/busybox mkdir -p /efs

        if ! /tmp/busybox grep -q /efs /proc/mounts ; then
            if ! /tmp/busybox mount -t yaffs2 /dev/block/mtdblock4 /efs ; then
                /tmp/busybox echo "Cannot mount efs."
                exit 6
            fi
        fi

        /tmp/busybox cp -R /sdcard/backup/efs /
        /tmp/busybox umount -l /efs
    else
        /tmp/busybox echo "Cannot restore efs."
        exit 7
    fi

    # flash boot image
    /tmp/bml_over_mtd.sh boot 72 reservoir 2004 /tmp/boot.img

    exit 0
fi

