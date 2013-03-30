#
# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.

DEVICE_PACKAGE_OVERLAYS := device/samsung/ypg1/overlay


# These are the hardware-specific configuration files
PRODUCT_COPY_FILES := \
    device/samsung/ypg1/prebuilt/etc/asound.conf:system/etc/asound.conf \
    device/samsung/ypg1/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/samsung/ypg1/prebuilt/etc/egl.cfg:system/lib/egl/egl.cfg

# Init files
PRODUCT_COPY_FILES += \
  device/samsung/ypg1/init.smdkc110.rc:root/init.smdkc110.rc \
  device/samsung/ypg1/lpm.rc:root/lpm.rc \
  device/samsung/ypg1/init.smdkc110.usb.rc:root/init.smdkc110.usb.rc\
  device/samsung/ypg1/init.smdkc110.usb.rc:recovery/root/usb.rc \
  device/samsung/ypg1/init.smdkc110.gps.rc:root/init.smdkc110.gps.rc \
  device/samsung/ypg1/ueventd.smdkc110.rc:root/ueventd.smdkc110.rc

# WiFi
PRODUCT_COPY_FILES += \
     device/samsung/ypg1/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Keylayout and Keychars
PRODUCT_COPY_FILES += \
     device/samsung/ypg1/prebuilt/usr/keylayout/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/qt602240_ts_input.kl:system/usr/keylayout/qt602240_ts_input.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/aries-keypad.kl:system/usr/keylayout/aries-keypad.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/melfas_touchkey.kl:system/usr/keylayout/melfas_touchkey.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
     device/samsung/ypg1/prebuilt/usr/keychars/s3c-keypad.kcm:system/usr/keychars/s3c-keypad.kcm \
     device/samsung/ypg1/prebuilt/usr/keychars/qt602240_ts_input.kcm:system/usr/keychars/qt602240_ts_input.kcm \
     device/samsung/ypg1/prebuilt/usr/keychars/sec_jack.kcm:system/usr/keychars/sec_jack.kcm \
     device/samsung/ypg1/prebuilt/usr/keychars/melfas-touchkey.kcm:system/usr/keychars/melfas-touchkey.kcm \
     device/samsung/ypg1/prebuilt/usr/keychars/aries-keypad.kcm:system/usr/keychars/aries-keypad.kcm \
     device/samsung/ypg1/prebuilt/usr/idc/qt602240_ts_input.idc:system/usr/idc/qt602240_ts_input.idc


# Generated kcm keymaps
PRODUCT_PACKAGES := \
    cypress-touchkey.kcm \
    s3c-keypad.kcm

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	hardware/samsung/exynos3/s5pc110/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry \
	device/samsung/ypg1/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
    libSEC_OMX_Core \
    libOMX.SEC.AVC.Decoder \
    libOMX.SEC.M4V.Decoder \
    libOMX.SEC.M4V.Encoder \
    libOMX.SEC.AVC.Encoder

# HW parts
PRODUCT_PACKAGES += \
    lights.s5pc110 \
    audio.primary.s5pc110 \
    audio.a2dp.default \
    audio_policy.s5pc110 \
    sensors.s5pc110 \
    camera.s5pc110 \
    overlay.s5pc110 \
    hwcomposer.s5pc110 \

# Kernel modules
PRODUCT_COPY_FILES += $(foreach module,\
	$(wildcard device/samsung/ypg1/modules/*.ko),\
	$(module):system/lib/modules/$(notdir $(module)))


# update utilities
PRODUCT_PACKAGES += \
	bml_over_mtd

# Libs
PRODUCT_PACKAGES += \
    libs3cjpeg \
    libaudioutils \
    libstagefrighthw \
    libcamera \
    libaudiohw_legacy

# apns config file
PRODUCT_COPY_FILES += \
    device/samsung/ypg1/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml


# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
       wifi.interface=eth0 \
       wifi.supplicant_scan_interval=20 \
       dalvik.vm.heapsize=32m

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
        ro.com.google.locationfeatures=1 \
        ro.com.google.networklocation=1

# enable repeatable keys in cwm
PRODUCT_PROPERTY_OVERRIDES += \
    ro.cwm.enable_key_repeat=true

# This is taken from the moto wingray, is it correct?
PRODUCT_CHARACTERISTICS := tablet

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false
# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Vold
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.switchablepair=/mnt/emmc,/mnt/sdcard

# Conversion files
PRODUCT_COPY_FILES += \
    device/samsung/ypg1/updater.sh:updater.sh

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/ypg1/ypg1-vendor.mk)
