#!/tmp/busybox sh

exec >& /sdcard/convert.debug
set -x

export PATH="/tmp"

CUT="/tmp/busybox cut"
DATE="/tmp/busybox date"
DD="/tmp/busybox dd"
GREP="/tmp/busybox grep"
MKDIR="/tmp/busybox mkdir"
MOUNTPOINT="/tmp/busybox mountpoint"
MOUNT="/tmp/busybox mount"
REBOOT="/tmp/busybox reboot"
RM="/tmp/busybox rm"
SED="/tmp/busybox sed"
SYNC="/tmp/busybox sync"
TAR="/tmp/busybox tar"
TOUCH="/tmp/busybox touch"
UMOUNT="/tmp/busybox umount"

BOOTMODE="/tmp/bootmode"
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

mtd_dev_for()
{
	local name="$1"
	local line
	local mtdname
	local dev

	line=`$GREP \"$name\" /proc/mtd`
	if test -z "$line"; then
		log "No such MTD partition: $name"
		exit 1
	fi
	mtdname=`echo $line | $CUT -d':' -f1`
	if test -z "$mtdname"; then
		log "Error parsing /proc/mtd for $name"
		exit 1
	fi
	mtdname=`echo $mtdname | $SED 's/mtd/mtdblock/'`
	dev="/dev/block/$mtdname"
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

	if is_mounted "/$name"; then
		was_mounted="yes"
	else
		was_mounted="no"
		$MKDIR -p "/$name"
		$MOUNT -t rfs -o ro $dev "/$name"
		if test $? -ne 0; then
			$MOUNT -t ext4 -o ro $dev "/$name"
		fi
		if test $? -ne 0; then
			log "Cannot mount $dev on $name: tried rfs and ext4"
			exit 1
		fi
	fi

	cd "/$name"
	$TAR -c -v -f "/sdcard/$name.tar" .
	if test $? -ne 0; then
		log "Cannot save $name: tar failed"
		exit 1
	fi
	cd /

	if test "$was_mounted" = "no"; then
		$UMOUNT "/$name"
	fi
}

fs_restore_yaffs2()
{
	local name="$1"
	local mtdname="$2"
	local dev
	local was_mounted

	dev=`mtd_dev_for $mtdname`

	if test ! -e /sdcard/$name.tar; then
		log "Cannot restore $name: no backup found"
		exit 1
	fi
	if is_mounted "/$name"; then
		was_mounted="yes"
		$UMOUNT "/$name"
	else
		was_mounted="no"
		$MKDIR -p "/$name"
	fi

	$ERASE_IMAGE $mtdname
	$MOUNT -t yaffs2 $dev "/$name"
	if test $? -ne 0; then
		log "Cannot restore $name: mount failed"
		exit 1
	fi
	cd "/$name"
	$TAR -x -v -f "/sdcard/$name.tar"
	if test $? -ne 0; then
		log "Cannot restore $name: tar failed"
		exit 1
	fi
	cd /

	if test "$was_mounted" = "no"; then
		$UMOUNT "/$name"
	fi
}

fs_restore_ext4()
{
	local name="$1"
	local blkname="$2"
	local dev
	local was_mounted

	dev="/dev/block/$blkname"

	if test ! -e /sdcard/$name.tar; then
		log "Cannot restore $name: no backup found"
		exit 1
	fi
	if is_mounted "/$name"; then
		was_mounted="yes"
		$UMOUNT "/$name"
	else
		was_mounted="no"
	fi

	$MKE4FS -b 4096 -g 32768 -i 8192 -I 256 -a ERASE_IMAGE $dev
	$MOUNT -t ext4 $dev "/$name"
	cd "/$name"
	$TAR -xf "/sdcard/$name.tar"
	if test $? -ne 0; then
		log "Cannot restore $name: tar failed"
		exit 1
	fi
	cd /

	if test "$was_mounted" = "no"; then
		$UMOUNT "/$name"
	fi
}

fs_format_yaffs2()
{
	local name="$1"
	local mtdname="$2"

	$ERASE_IMAGE $mtdname
}

if ! is_mounted "/sdcard"; then
	log "Cannot convert: sdcard not mounted"
	exit 1
fi

log "$0: start at `$DATE`"

if test -e "/proc/mtd"; then
	# Running on an MTD kernel
	log "mtd kernel detected"
	if test -e /sdcard/.convert_to_mtd; then
		log "Restoring filesystems"
		fs_restore_yaffs2 efs    efs
		fs_restore_yaffs2 dbdata dbdatafs
		fs_restore_ext4   data   mmcblk0p2
		fs_format_yaffs2  cache  cache
		$RM -f /sdcard/.convert_to_mtd
	else
		log "Not restoring filesystems"
	fi
else
	# Running on a BML/STL kernel
	log "bml/stl kernel detected"
	$TOUCH /sdcard/.convert_to_mtd
	fs_save efs    stl3
	fs_save dbdata stl10
	fs_save data   mmcblk0p2

	$BOOTMODE set recovery
	$SYNC
	$REBOOT
fi

log "$0: end at `$DATE`"
