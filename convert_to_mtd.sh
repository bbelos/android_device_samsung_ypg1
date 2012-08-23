#!/tmp/busybox sh

export PATH="/tmp"

CUT="/tmp/busybox cut"
DATE="/tmp/busybox date"
DD="/tmp/busybox dd"
GREP="/tmp/busybox grep"
MOUNTPOINT="/tmp/busybox mountpoint"
MOUNT="/tmp/busybox mount"
REBOOT="/tmp/busybox reboot"
SED="/tmp/busybox sed"
TAR="/tmp/busybox tar"
UMOUNT="/tmp/busybox umount"

ERASE_IMAGE="/tmp/erase_image"
MKE4FS="/tmp/make_ext4fs"

# For sanity
return_true="return 0"
return_false="return 1"

log()
{
	echo "$@" >> /sdcard/convert.log
}

is_mounted()
{
	local path="$1"

	$MOUNTPOINT "$path" >/dev/null 2>/dev/null
	return $?
}

is_stl()
{
	local dev="/dev/block/$1"
	local data

	data=`$DD if=$dev bs=7 count=1 2>/dev/null`
	if test "$data" = "FSR_STL"; then
		$return_true
	fi
	$return_false
}

mtd_dev_for()
{
	local name="$1"
	local line
	local blkname
	local dev

	line=`$GREP \"$name\" /proc/mtd`
	if test -z "$line"; then
		log "No such MTD partition: $name"
		exit 1
	fi
	blkname=`echo $line | $CUT -d':' -f1`
	if test -z "$blkname"; then
		log "Error parsing /proc/mtd for $name"
		exit 1
	fi
	blkname=`echo $blkname | $SED 's/mtd/mtdblock/'`
	dev="/dev/block/$blkname"
	if test ! -e "$dev"; then
		log "Cannot find device $dev"
		exit 1
	fi
	echo $dev
}

fs_save()
{
	local name="$1"
	local dev="/dev/block/$2"
	local was_mounted

	if test ! is_stl $dev; then
		log "Cannot save $name: $dev not stl"
		exit 1
	fi

	if test is_mounted "/$name"; then
		was_mounted="yes"
	else
		was_mounted="no"
		$MOUNT -t rfs $dev "/$name"
	fi

	cd "/$name"
	$TAR -czf "/mnt/sdcard/$name.tar.gz" .
	cd /

	if test "$was_mounted" = "no"; then
		$UMOUNT "/$name"
	fi
}

fs_restore_yaffs2()
{
	local blkname="$1"
	local name="$2"
	local dev
	local was_mounted

	dev=`mtd_dev_for $blkname`

	if ! is_stl $dev; then
		log "Cannot restore $name: $dev not stl. Assuming restored."
		return
	fi
	if test ! -e /mnt/sdcard/$name.tar.gz; then
		log "Cannot restore $name: no backup found"
		exit 1
	fi
	if test is_mounted "/$name"; then
		was_mounted="yes"
	else
		was_mounted="no"
	fi

	$ERASE_IMAGE $dev
	$MOUNT -t yaffs2 $dev "/$name"
	cd "/$name"
	$TAR -zxf "/mnt/sdcard/$name.tar.gz"
	cd /

	if test "$was_mounted" = "no"; then
		$UMOUNT "/$name"
	fi
}

fs_restore_ext4()
{
	local blkname="$1"
	local name="$2"
	local dev
	local was_mounted

	dev="/dev/block/$blkname"

	if ! is_stl $dev; then
		log "Cannot restore $name: $dev not stl. Assuming restored."
		return
	fi
	if test ! -e /mnt/sdcard/$name.tar.gz; then
		log "Cannot restore $name: no backup found"
		exit 1
	fi
	if $MOUNTPONT "/$name"; then
		was_mounted="yes"
	else
		was_mounted="no"
	fi

	$MKE4FS -b 4096 -g 32768 -i 8192 -I 256 -a ERASE_IMAGE $dev
	$MOUNT -t ext4 $dev "/$name"
	cd "/$name"
	$TAR -zxf "/mnt/sdcard/$name.tar.gz"
	cd /

	if test "$was_mounted" = "no"; then
		$UMOUNT "/$name"
	fi
}

fs_format_yaffs2()
{
	local blkname="$1"
	local name="$2"
	local dev

	dev=`mtd_dev_for $blkname`

	if ! is_stl $dev; then
		log "Not formatting $name: $dev not stl. Assuming formatted."
		return
	fi

	$ERASE_IMAGE $dev
}

log "$0: start at `$DATE`"

if test -e "/proc/mtd"; then
	# Running on an MTD kernel
	log "mtd kernel detected"
	fs_restore_yaffs2 efs efs
	fs_restore_yaffs2 dbdatafs dbdata
	fs_restore_ext4   mmcblk0p1 data
	fs_format_yaffs2  cache cache
else
	# Running on a BML/STL kernel
	log "bml/stl kernel detected"
	fs_save efs    stl3
	fs_save dbdata stl10
	fs_save data   mmcblk0p1
	$REBOOT
fi

log "$0: end at `$DATE`"
