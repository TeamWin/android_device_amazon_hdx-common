BOARD_VENDOR := amazon

# headers
TARGET_SPECIFIC_HEADER_PATH := device/amazon/hdx-common/include

# Platform
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330
TARGET_BOOTLOADER_BOARD_NAME := MSM8974

# Bootloader
TARGET_NO_BOOTLOADER := true

# Architecture
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := krait

# Kernel -> use prebuilt kernel ...
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100

# Flags for Krait CPU
TARGET_GLOBAL_CFLAGS += -mfpu=neon-vfpv4 -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon-vfpv4 -mfloat-abi=softfp
# Flags
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE -DQCOM_BSP -DAMZ_HDX
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_QCOM_BSP := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
TARGET_QCOM_AUDIO_VARIANT := caf-hdx
TARGET_QCOM_DISPLAY_VARIANT := caf-hdx
TARGET_QCOM_MEDIA_VARIANT := caf-hdx

# Audio
AUDIO_FEATURE_DISABLED_SSR := true #MSM CAF
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_LEGACY_ALSA_AUDIO := false

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
#BLUETOOTH_HCI_USE_MCT := true
#BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/amazon/hdx-common/bluetooth

# chargers
BOARD_CHARGER_RES := device/amazon/hdx-common/charger

# Graphics
BOARD_EGL_CFG := device/amazon/hdx-common/egl.cfg
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_OVERLAY := true
TARGET_USES_ION := false # wrong caf tag ?!
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

# Power
#TARGET_POWERHAL_VARIANT := qcom
# Time services
#BOARD_USES_QC_TIME_SERVICES := true

# Webkit
ENABLE_WEBGL := true
TARGET_FORCE_CPU_UPLOAD := true

# Charging mode
BOARD_CHARGING_MODE_BOOTING_LPM := 
BOARD_BATTERY_DEVICE_NAME := "bq27x41"

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0xA00000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0xA00000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1308622848
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12549340160
BOARD_FLASH_BLOCK_SIZE := 131072

# ATH6KL WLAN
BOARD_HAS_QCOM_WLAN			:= true
BOARD_WLAN_DEVICE			:= qcwcn
WPA_SUPPLICANT_VERSION			:= VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER		:= NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB	:= lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             	:= NL80211
BOARD_HOSTAPD_PRIVATE_LIB 		:= lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_STA			:= "sta"
WIFI_DRIVER_FW_PATH_AP			:= "ap"
WIFI_DRIVER_FW_PATH_P2P			:= "p2p"
WIFI_DRIVER_FW_PATH_PARAM		:= "/sys/module/wlan/parameters/fwpath"
WIFI_DRIVER_MODULE_PATH 		:= "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME 		:= "wlan"
TARGET_USES_WCNSS_CTRL			:= true
#TARGET_USES_QCOM_WCNSS_QMI		:= true
#WIFI_BAND 				:= 802_11_ABG

# NFC
BOARD_HAVE_NFC := false

# Vold
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
BOARD_VOLD_MAX_PARTITIONS := 32
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# custom liblights (because we basically have none)
TARGET_PROVIDES_LIBLIGHT := true

# Temporary
USE_CAMERA_STUB := true

# CWM Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_USES_MMCUTILS := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB := device/amazon/hdx-common/rootdir/etc/fstab.qcom

# TWRP Recovery
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TARGET_USERIMAGES_USE_EXT4 := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_CUSTOM_BATTERY_PATH := /sys/class/power_supply/bq27x41

# hdx old bootloader dtb compatibility fix + bootloader signature exploit patch
# override bootimg to manually append propietary dtb extracted from 4.5.2 kernel
BOARD_CUSTOM_BOOTIMG_MK := device/amazon/hdx-common/mkboot.mk
