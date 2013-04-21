# Samsung YP-G1 compile definitions.

BOARD_PROVIDES_BOOTMODE := true

BOARD_USES_UBOOT := false
BOARD_USES_UBOOT_MULTIIMAGE := false

# Set this up here so that BoardVendorConfig.mk can override it
BOARD_USES_GENERIC_AUDIO := false

BOARD_USES_LIBSECRIL_STUB := true

# Use the non-open-source parts, if they exist
-include vendor/samsung/ypg1/BoardConfigVendor.mk

# Processor optimizations
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true

TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

TARGET_BOARD_PLATFORM := s5pc110
TARGET_BOARD_PLATFORM_GPU := POWERVR_SGX540_120
TARGET_BOOTLOADER_BOARD_NAME := s5pc110

TARGET_PROVIDES_INIT := true
TARGET_RECOVERY_INITRC := device/samsung/ypg1/recovery.rc

# Provide our own libaudio
TARGET_PROVIDES_LIBAUDIO := true

# Releasetools
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := ./device/samsung/ypg1/releasetools/ypg1_ota_from_target_files
TARGET_RELEASETOOL_IMG_FROM_TARGET_SCRIPT := ./device/samsung/ypg1/releasetools/ypg1_img_from_target_files

# Camera defines
USE_CAMERA_STUB := false
ifeq ($(USE_CAMERA_STUB),false)
BOARD_SECOND_CAMERA_DEVICE := true
BOARD_CAMERA_LIBRARIES := libcamera
endif
ICS_CAMERA_BLOB := true

# OpenGL stuff
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/samsung/ypg1/prebuilt/etc/egl.cfg
BOARD_USE_SKIA_LCDTEXT := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

# Video Devices
BOARD_USES_OVERLAY := true
BOARD_V4L2_DEVICE := /dev/video1
BOARD_CAMERA_DEVICE := /dev/video0
BOARD_SECOND_CAMERA_DEVICE := /dev/video2

# XXX
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 268435456

# Max image/partition sizes
# XXX: check and fix
BOARD_BOOTIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00280000)
BOARD_RECOVERYIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00500000)
BOARD_SYSTEMIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x07500000)
BOARD_USERDATAIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x04ac0000)
# The size of a block that can be marked bad.
BOARD_FLASH_BLOCK_SIZE := 131072

# Kernel defines
BOARD_NAND_PAGE_SIZE := 4096
BOARD_NAND_SPARE_SIZE := 128
BOARD_KERNEL_BASE := 0x32000000
BOARD_KERNEL_CMDLINE := console=ttyFIQ0,115200 init=/init
BOARD_KERNEL_PAGESIZE := 4096

# hwcomposer: custom vsync ioctl
BOARD_CUSTOM_VSYNC_IOCTL := true

# TARGET_DISABLE_TRIPLE_BUFFERING can be used to disable triple buffering
# on per target basis. On crespo it is possible to do so in theory
# to save memory, however, there are currently some limitations in the
# OpenGL ES driver that in conjunction with disable triple-buffering
# would hurt performance significantly (see b/6016711)
TARGET_DISABLE_TRIPLE_BUFFERING := false

BOARD_ALLOW_EGL_HIBERNATION := true

# Define kernel config for inline building
TARGET_KERNEL_CONFIG := cyanogenmod_palladio_defconfig
TARGET_KERNEL_SOURCE := kernel/samsung/palladio/

# Fallback
TARGET_PREBUILT_KERNEL := device/samsung/ypg1/kernel

# WIFI defines
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
BOARD_WLAN_DEVICE := bcm4329
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/dhd.ko"
WIFI_DRIVER_FW_STA_PATH := "/system/etc/wifi/bcm4329_sta.bin"
WIFI_DRIVER_FW_AP_PATH := "/system/etc/wifi/bcm4329_aps.bin"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/wifi/bcm4329_sta.bin nvram_path=/system/etc/wifi/nvram_net.txt"
WIFI_DRIVER_MODULE_NAME := "dhd"

# Vold
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/s3c-usbgadget/gadget/lun%d/file"

# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CUSTOM_GRAPHICS := ../../../device/samsung/ypg1/recovery/graphics.c
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USES_BML_OVER_MTD := true
BOARD_CUSTOM_RECOVERY_KEYMAPPING:= ../../device/samsung/ypg1/recovery/recovery_keys.c
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/ypg1/shbootimg.mk
TARGET_OTA_ASSERT_DEVICE := YP-G1,ypg1

BOARD_USE_LEGACY_TOUCHSCREEN := true

# FM Radio
BOARD_HAVE_FM_RADIO := true
BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO
BOARD_FM_DEVICE := si4709
