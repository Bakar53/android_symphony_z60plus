#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/symphony/z60plus

# Enable project quotas and casefolding for emulated storage without sdcardfs - 
# SDCard replacement functionality
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Dynamic Partitions stuff
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

# Recovery Debug Tools
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    libhardware \
    libion_sprd

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.debug.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.debug.rc
