PRODUCT_BRAND ?= projectelite

SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.elite.superuser

PRODUCT_BOOTANIMATION := vendor/common/prebuilt/common/bootanimation/bootanimation.zip 

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Enable ADB authentication and root
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    persist.sys.root_access=3 \
    persist.sys.usb.config=mtp
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.rommanager.developerid=projectelite \
    ro.com.android.dataroaming=false

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/common/CHANGELOG.mkdn:system/etc/CHANGELOG.txt

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

# Project Elite - specific init file
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/etc/init.pe.rc:root/init.pe.rc

# Project Elite kernel CPU support
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/etc/init.d/03elite:system/etc/init.d/03elite

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/common/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Terminal Emulator
PRODUCT_COPY_FILES +=  \
    vendor/common/proprietary/Term.apk:system/app/Term.apk \
    vendor/common/proprietary/lib/armeabi/libjackpal-androidterm4.so:system/lib/libjackpal-androidterm4.so

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

# This is PE!
PRODUCT_COPY_FILES += \
    vendor/common/config/permissions/com.pe.android.xml:system/etc/permissions/com.pe.android.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/common/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Required PE Packages
PRODUCT_PACKAGES += \
    Development \
    LatinIME \
    Superuser \
    su

# Optional PE packages
PRODUCT_PACKAGES += \
    VoicePlus \
    VideoEditor \
    VoiceDialer \
    SoundRecorder \
    Basic

PRODUCT_PACKAGES += \
    CellBroadcastReceiver

# Extra tools in Project Elite
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    ntfsfix \
    ntfs-3g

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

PRODUCT_PACKAGE_OVERLAYS += vendor/common/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/common/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0-RC0

VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.pe.version=$(VERSION)

