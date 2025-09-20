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

#
# This file defines the packages, properties, and features
# to include in the product build.
#

# Path to the device-specific tree
LOCAL_PATH := device/itel/P13001L

#----------------------------------------------------------------------
# Inherited Products
#----------------------------------------------------------------------
# Inherit common product definitions
# Most specific first

# Base 64-bit-only product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Base AOSP product definitions
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# GSI keys for Verified Boot on developer GSI
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Emulated storage configuration (project quotas, casefolding)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Virtual A/B OTA configurations
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

#----------------------------------------------------------------------
# API Level & System Properties
#----------------------------------------------------------------------

# Device API level
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31

# Property to indicate recovery is in vendor_boot
PRODUCT_PROPERTY_OVERRIDES += ro.twrp.vendor_boot=true

#----------------------------------------------------------------------
# Dynamic & Virtual A/B Partitions
#----------------------------------------------------------------------

# Enable Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enable Virtual A/B
ENABLE_VIRTUAL_AB := true
AB_OTA_UPDATER := true

# List of partitions to include in A/B OTA updates
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    lk \
    odm \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

# Post-install configurations for A/B OTA

# Run mtk_plpath_utils on system
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Run checkpoint_gc on vendor
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Run otapreopt_script on system
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

#----------------------------------------------------------------------
# Product Packages (Main)
#----------------------------------------------------------------------

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd \
	android.hardware.keymaster@4.1 \
    android.hardware.security.keymint \
    cppreopts.sh \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

#----------------------------------------------------------------------
# Product Packages (Debug)
#----------------------------------------------------------------------

PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

#----------------------------------------------------------------------
# TWRP/Recovery Configuration
#----------------------------------------------------------------------
# These are modules needed by recovery, built as part of the main build

# Add Keymaster HAL to recovery modules
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.keymaster@4.1

# Relink Keymaster HAL library for recovery
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.1