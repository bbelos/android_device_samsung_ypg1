# Release name
PRODUCT_RELEASE_NAME := GalaxyPlayer4.0

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/ypg1/full_ypg1.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := YP-G1
PRODUCT_NAME := cm_ypg1
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := YP-G1
PROUDCT_MANUFACTURER := Samsung
