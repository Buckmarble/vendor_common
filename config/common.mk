PRODUCT_BRAND ?= darkslide

SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.darkslide.superuser

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/common/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_BOOTANIMATION := vendor/common/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip
endif


PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=darkslide

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/common/CHANGELOG.mkdn:system/etc/CHANGELOG.txt

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/common/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/common/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# init.d support
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/common/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

#DS-specific init file
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/etc/init.local.rc:root/init.ds.rc

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/common/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/common/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/common/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is DS!
PRODUCT_COPY_FILES += \
    vendor/common/config/permissions/com.darkslide.android.xml:system/etc/permissions/com.darkslide.android.xml

# T-Mobile theme engine
#include vendor/common/config/themes_common.mk

# Required packages
PRODUCT_PACKAGES += \
    Development \
    LatinIME \
    BluetoothExt

# Optional packages
PRODUCT_PACKAGES += \
    VoiceDialer \
    SoundRecorder \
    Basic \
    libemoji

PRODUCT_PACKAGES += \
    Launcher3 \
    audio_effects.conf

PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

PRODUCT_PACKAGES += \
    procmem \
    procrank \
    Superuser \
    su

# Terminal Emulator
PRODUCT_COPY_FILES +=  \
    vendor/common/proprietary/Term.apk:system/app/Term.apk \
    vendor/common/proprietary/lib/armeabi/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=1


PRODUCT_PACKAGE_OVERLAYS += vendor/common/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/common/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0-RC0

PRODUCT_PROPERTY_OVERRIDES += \
  ro.ds.version=1 \
  ro.modversion=0 \


