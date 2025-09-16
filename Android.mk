LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),P13001L)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
