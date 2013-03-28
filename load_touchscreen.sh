#!/system/xbin/busybox sh

# Detect USA model by looking at the buyer code, and pass that information
# to the touchscreen driver on load.

# Note we could avoid this script by reading the buyer code from the kernel
# like one of the sound modules does, but that is a nasty hack.

param="aries_usa=0"
bc=`cat /efs/buyer_code.dat`
if test "$bc" = "XAA"; then
	param="aries_usa=1"
fi
