#
# Copyright (C) 2025 The Android Open Source Project
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

#----------------------------------------------------------------------
# Inherited Makefiles
#----------------------------------------------------------------------

# Inherit the common TWRP product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit the device-specific product configuration
$(call inherit-product, device/itel/P13001L/device.mk)

#----------------------------------------------------------------------
# Product & Device Information
#----------------------------------------------------------------------
# These variables define the product's identity

# The device codename
PRODUCT_DEVICE := P13001L

# The name of this build target (e.g., twrp_P13001L)
PRODUCT_NAME := twrp_P13001L

# The consumer-facing brand
PRODUCT_BRAND := Itel

# The consumer-facing model name
PRODUCT_MODEL := itel VistaTab 30 Pro

# The hardware manufacturer
PRODUCT_MANUFACTURER := ITEL

# GMS (Google Mobile Services) client ID
PRODUCT_GMS_CLIENTID_BASE := android-itel

#----------------------------------------------------------------------
# Build Property Overrides
#----------------------------------------------------------------------
# Set build-time properties to match the stock build

# Override the build description
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="P13001L-GL-user 12 UP1A.231005.007 1728750305 release-keys"

# Set the build fingerprint to match stock
BUILD_FINGERPRINT := Itel/P13001L-GL/itel-P13001L:14/UP1A.231005.007/1728750305:user/release-keys