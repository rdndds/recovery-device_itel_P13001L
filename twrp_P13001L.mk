# Configure twrp config common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Device specific configs
$(call inherit-product, device/itel/P13001L/device.mk)

# Device identifier
PRODUCT_DEVICE := P13001L
PRODUCT_NAME := twrp_P13001L
PRODUCT_BRAND := Itel
PRODUCT_MODEL := itel VistaTab 30 Pro
PRODUCT_MANUFACTURER := ITEL

PRODUCT_GMS_CLIENTID_BASE := android-itel
