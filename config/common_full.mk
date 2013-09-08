# Inherit common stuff
$(call inherit-product, vendor/common/config/common.mk)

# Bring in all video files
$(call inherit-product, frameworks/base/data/videos/VideoPackage2.mk)

# Include additional audio files
include vendor/common/config/audio.mk

# Optional packages
PRODUCT_PACKAGES += \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam \
    SunBeam
