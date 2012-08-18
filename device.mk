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


PRODUCT_INSTALL_PACKAGES := \
	vendor/google/gapps-20120317

DEVICE_PACKAGE_OVERLAYS := device/samsung/ypg1/overlay


# These are the hardware-specific configuration files
PRODUCT_COPY_FILES := \
    device/samsung/ypg1/prebuilt/etc/asound.conf:system/etc/asound.conf \
    device/samsung/ypg1/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/samsung/ypg1/prebuilt/etc/egl.cfg:system/lib/egl/egl.cfg

PRODUCT_PACKAGES += \
    audio.primary.s5pc110 \
    libaudiohw_legacy \
    audio.a2dp.default \
    Torch \
    libaudioutils

# Init files
PRODUCT_COPY_FILES += \
  device/samsung/ypg1/ueventd.victory.rc:root/ueventd.victory.rc \
  device/samsung/ypg1/lpm.rc:root/lpm.rc \
  device/samsung/ypg1/init.victory.rc:root/init.victory.rc

# WiFi
PRODUCT_COPY_FILES += \
     device/samsung/ypg1/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Keylayout and Keychars
PRODUCT_COPY_FILES += \
     device/samsung/ypg1/prebuilt/usr/keylayout/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/aries-keypad.kl:system/usr/keylayout/aries-keypad.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/melfas_touchkey.kl:system/usr/keylayout/melfas_touchkey.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
     device/samsung/ypg1/prebuilt/usr/keylayout/Broadcom_Bluetooth_HID.kl:system/usr/keylayout/Broadcom_Bluetooth_HID.kl \
     device/samsung/ypg1/prebuilt/usr/keychars/Broadcom_Bluetooth_HID.kcm.bin:system/usr/keychars/Broadcom_Bluetooth_HID.kcm.bin \
     device/samsung/ypg1/prebuilt/usr/keychars/s3c-keypad.kcm.bin:system/usr/keychars/s3c-keypad.kcm.bin \
     device/samsung/ypg1/prebuilt/usr/keychars/melfas_touchkey.kcm.bin:system/usr/keychars/melfas_touchkey.kcm.bin \
     device/samsung/ypg1/prebuilt/usr/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
     device/samsung/ypg1/prebuilt/usr/keychars/aries-keypad.kcm.bin:system/usr/keychars/aries-keypad.kcm.bin \
     device/samsung/ypg1/prebuilt/usr/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
     device/samsung/ypg1/prebuilt/usr/idc/qt602240_ts_input.idc:system/usr/idc/qt602240_ts_input.idc


# Generated kcm keymaps
PRODUCT_PACKAGES := \
    cypress-touchkey.kcm \
    s3c-keypad.kcm

## Audio
#PRODUCT_COPY_FILES += \
#        device/samsung/ypg1/audio/liba2dp.so:out/target/product/ypg1/obj/lib/liba2dp.so \
#        device/samsung/ypg1/audio/liba2dp.so:system/lib/liba2dp.so \
#        device/samsung/ypg1/audio/libasound.so:system/lib/libasound.so \
#        device/samsung/ypg1/audio/libaudio.so:system/lib/libaudio.so \
#        device/samsung/ypg1/audio/libaudiohw_op.so:system/lib/libaudiohw_op.so \
#        device/samsung/ypg1/audio/libaudiohw_sf.so:system/lib/libaudiohw_sf.so \
#        device/samsung/ypg1/audio/liblvvefs.so:system/lib/liblvvefs.so \
#        device/samsung/ypg1/audio/lib_Samsung_Sound_Booster_Handphone.so:system/lib/lib_Samsung_Sound_Booster_Handphone.so \
#        device/samsung/ypg1/audio/lib_Samsung_Resampler.so:system/lib/lib_Samsung_Resampler.so \
#        device/samsung/ypg1/audio/libsamsungSoundbooster.so:system/lib/libsamsungSoundbooster.so \
#        device/samsung/ypg1/audio/libsec-ril.so:system/lib/libsec-ril.so \
#        device/samsung/ypg1/audio/libsecril-client.so:system/lib/libsecril-client.so

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	device/samsung/ypg1/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry \
	device/samsung/ypg1/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
    libSEC_OMX_Core.s5pc110 \
    libOMX.SEC.AVC.Decoder.s5pc110 \
    libOMX.SEC.M4V.Decoder.s5pc110 \
    libOMX.SEC.M4V.Encoder.s5pc110 \
    libOMX.SEC.AVC.Encoder.s5pc110

# Libs
PRODUCT_PACKAGES += \
    sensors.s5pc110 \
    libstagefrighthw \
    libcamera \
    camera.s5pc110 \
    overlay.s5pc110 \
    audio.primary.s5pc110 \
    hwcomposer.s5pc110

# update utilities
PRODUCT_PACKAGES += \
	flash_kernel

# Camera
PRODUCT_PACKAGES += \
    libs3cjpeg
# tvout 
PRODUCT_PACKAGES += \
	tvouthack
# apns config file
PRODUCT_COPY_FILES += \
        device/samsung/ypg1/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

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

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# Device-specific packages
	PRODUCT_PACKAGES += \
	EpicParts

# Telephony property for CDMA
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.vc_call_vol_steps=15 \
    ro.telephony.default_network=4 \
    ro.com.google.clientidbase=android-sprint-us \
    ro.cdma.home.operator.numeric=310120 \
    ro.cdma.home.operator.alpha=Sprint \
    net.cdma.pppd.authtype=require-pap \
    net.cdma.pppd.user=user[SPACE]SprintNextel \
    net.cdma.datalinkinterface=/dev/ttyCDMA0 \
    net.interfaces.defaultroute=cdma \
    net.cdma.ppp.interface=ppp0 \
    net.connectivity.type=CDMA1 \
    mobiledata.interfaces=ppp0,uwbr0 \
    ro.ril.samsung_cdma=true

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

# We are using a prebuilt kernel for now, to ease building. This will be changed later.
PRODUCT_COPY_FILES += \
    device/samsung/ypg1/kernel-ypg1-cm9.bin:kernel \
    device/samsung/ypg1/recovery.bin:recovery.bin

# Install scripts
PRODUCT_COPY_FILES += \
    device/samsung/ypg1/convert_to_mtd.sh:convert_to_mtd.sh \
    device/samsung/ypg1/bdaddr_read.sh:bdaddr_read.sh

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/ypg1/ypg1-vendor.mk)
