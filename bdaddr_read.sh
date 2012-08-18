#!/tmp/busybox sh

CAT="/tmp/busybox cat"
CUT="/tmp/busybox cut"

# Convert factory bluetooth addr file to conventional form
addr=`$CAT /efs/imei/bt.txt | $CUT -d':' -f2`
echo "${addr:0:2}:${addr:2:2}:${addr:4:2}:${addr:6:2}:${addr:8:2}:${addr:10:2}" > /system/etc/bt_addr
