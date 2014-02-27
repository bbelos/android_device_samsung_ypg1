# Release name
PRODUCT_RELEASE_NAME := Galaxy Player 4.0

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/ypg1/full_ypg1.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := ypg1
PRODUCT_NAME := cm_ypg1
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := YP-G1
PROUDCT_MANUFACTURER := Samsung

#Set build fingerprint / ID / Prduct Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=YP-G1 TARGET_DEVICE=YP-G1 BUILD_FINGERPRINT=samsung/YP-G1/YP-G1:2.3.6/GINGERBREAD/XXKPQ:user/release-keys PRIVATE_BUILD_DESC="YP-G1-user 2.3.6 GINGERBREAD XXKPQ release-keys"

