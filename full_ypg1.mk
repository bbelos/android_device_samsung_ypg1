#
# This file is the build configuration for a full Android
# build for ypg1 hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

PRODUCT_PACKAGES := \
	LiveWallpapersPicker

PRODUCT_PACKAGES += \
	Camera

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
# This is where we'd set a backup provider if we had one
#$(call inherit-product, device/sample/products/backup_overlay.mk)
$(call inherit-product, device/samsung/ypg1/device.mk)


# Screen density is actually considered a locale (since it is taken into account
# the the build-time selection of resources). The product definitions including
# this file must pay attention to the fact that the first entry in the final
# PRODUCT_LOCALES expansion must not be a density.
PRODUCT_LOCALES += hdpi

# Discard inherited values and use our own instead.
PRODUCT_DEVICE := YP-G1
PRODUCT_NAME := cm_ypg1
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := Galaxy Player 4.0
PROUDCT_MANUFACTURER := Samsung
PRODUCT_BOOTANIMATION := 480
