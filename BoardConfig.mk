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

#----------------------------------------------------------------------
# Device Basics & Identification
#----------------------------------------------------------------------

# Path to the device-specific tree
DEVICE_PATH := device/itel/P13001L

# Assertions used in OTA updates to ensure the update is for the correct device
TARGET_OTA_ASSERT_DEVICE := P13001L,itel-P13001L,P13001L-GL

#----------------------------------------------------------------------
# Architecture
#----------------------------------------------------------------------

# Main Architecture (64-bit)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

# Secondary Architecture (32-bit)
# Used for 32-bit applications (compatibility)
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# Enable 64-bit build configuration
TARGET_IS_64_BIT := true
TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true

#----------------------------------------------------------------------
# Platform & Bootloader
#----------------------------------------------------------------------

# Board Platform
TARGET_BOARD_PLATFORM := common

# MediaTek SoC Flags
BOARD_USES_MTK_HARDWARE := true
BOARD_HAS_MTK_HARDWARE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mgvi_t_64_armv82
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

#----------------------------------------------------------------------
# Kernel
#----------------------------------------------------------------------

# Kernel Architecture
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# Disable building the kernel from source
# This implies we are using a prebuilt kernel
TARGET_NO_KERNEL := true

# Path to the prebuilt Device Tree Blob (DTB)
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb

# Device has a separate /dtbo partition
BOARD_KERNEL_SEPARATED_DTBO := true

#----------------------------------------------------------------------
# Boot Image
#----------------------------------------------------------------------

# Boot Image Header Version
BOARD_BOOT_HEADER_VERSION := 4

# Kernel command line arguments
BOARD_VENDOR_CMDLINE := bootopt=64S3,32N2,64N2

# Memory layout and offsets for the boot image
BOARD_KERNEL_BASE := 0x3fff8000
BOARD_PAGE_SIZE := 4096
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x26f08000
BOARD_TAGS_OFFSET := 0x07c88000
BOARD_DTB_OFFSET := 0x07c88000

# Arguments passed to the mkbootimg tool
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(BOARD_VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# Use LZ4 compression for the ramdisk
BOARD_RAMDISK_USE_LZ4 := true

#----------------------------------------------------------------------
# Android Verified Boot (AVB)
#----------------------------------------------------------------------

# Enable AVB 2.0
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)

# Flags for vbmeta image creation
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# AVB settings for the recovery/vendor_boot image
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

#----------------------------------------------------------------------
# Partitions & Filesystem
#----------------------------------------------------------------------

# Partition Sizes
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_SIZE := 9663676416

# Dynamic Partitions (Super)
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_PARTITION_LIST := system product vendor vendor_dlkm odm odm_dlkm
BOARD_MAIN_SIZE := 9642704896

# Filesystem Types
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Enable support for both ext4 and f2fs on userdata
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Staging paths for partition contents
TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_ODM := odm

# vendor_dlkm (Dynamic Loadable Kernel Modules)
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# odm_dlkm (Dynamic Loadable Kernel Modules)
BOARD_USES_ODM_DLKMIMAGE := true
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm

# Metadata Partition
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

# System-as-root
BOARD_SUPPRESS_SECURE_ERASE := true

# Size of a flash erase block
BOARD_FLASH_BLOCK_SIZE := 262144

#----------------------------------------------------------------------
# Recovery
#----------------------------------------------------------------------

# This device does not have a dedicated recovery partition.
# Recovery is part of the vendor_boot image.
TARGET_NO_RECOVERY := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Specify the UI pixel format
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Use 64-bit e2fsprogs for large filesystems
BOARD_HAS_LARGE_FILESYSTEM := true

# Device uses power/volume keys for navigation
BOARD_HAS_NO_SELECT_BUTTON := true

# Emulate SDCARD on the /data partition
RECOVERY_SDCARD_ON_DATA := true

#----------------------------------------------------------------------
# System Features
#----------------------------------------------------------------------

# Offline Charging Mode
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true

# Treble / VNDK
BOARD_VNDK_VERSION := current

# USB (MTP)
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.usb0/lun.%d/file

# Enable logd daemon
TARGET_USES_LOGD := true

# Path to additional system.prop file
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Screen Density (DPI)
TARGET_SCREEN_DENSITY := 480

#----------------------------------------------------------------------
# TWRP Configuration
#----------------------------------------------------------------------

# TWRP: Theme, Resolution, & Display
TW_THEME := portrait_hdpi
TARGET_SCREEN_WIDTH := 1200
TARGET_SCREEN_HEIGHT := 1920
TW_FRAMERATE := 60
TW_NO_SCREEN_BLANK := true

# TWRP: Status Bar
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CLOCK_POS := 360

# TWRP: Brightness
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 100

# TWRP: Language & Version
TW_DEFAULT_LANGUAGE := en
TW_EXTRA_LANGUAGES := true
TW_DEVICE_VERSION := R

# TWRP: Included Tools & Features
TW_INCLUDE_FASTBOOTD := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_LPTOOLS := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true
TW_HAS_MTP := true

# TWRP: Debugging
TWRP_INCLUDE_LOGCAT := true

# TWRP: Exclusions
TW_EXCLUDE_APEX := true
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_BACKUP_EXCLUSIONS := /data/fonts/files

# TWRP: Misc Flags
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone28/temp
TARGET_USES_MKE2FS := true

#----------------------------------------------------------------------
# Build Hacks & Workarounds
#----------------------------------------------------------------------

# Allow building with duplicate rules
BUILD_BROKEN_DUP_RULES := true

# Allow building with missing dependencies
ALLOW_MISSING_DEPENDENCIES := true

# # Crypto
# TW_INCLUDE_CRYPTO := true
# TW_INCLUDE_CRYPTO_FBE := true
# TW_INCLUDE_FBE_METADATA_DECRYPT := true
# TW_USE_FSCRYPT_POLICY := 2

# # Hack
# PLATFORM_SECURITY_PATCH := 2025-01-05
# PLATFORM_VERSION := 14
# PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
# VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
# BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
