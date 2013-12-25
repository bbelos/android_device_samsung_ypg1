#!/bin/sh

VENDOR=samsung
DEVICE=ypg1

BASE=../../../vendor/$VENDOR/$DEVICE/

mkdir -p $BASE
echo PRODUCT_COPY_FILES += \\ > \
    $BASE/$DEVICE-vendor-blobs.mk
echo "Pulling common files..."
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    adb pull /system/$FILE $BASE/$FILE
    echo vendor/$VENDOR/$DEVICE/$FILE:system/$FILE \\ >> \
	$BASE/$DEVICE-vendor-blobs.mk
done
echo >> $BASE/$DEVICE-vendor-blobs.mk

./setup-makefiles.sh
