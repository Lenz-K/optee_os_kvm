################################################################################
# Following variables defines how the NS_USER (Non Secure User - Client
# Application), NS_KERNEL (Non Secure Kernel), S_KERNEL (Secure Kernel) and
# S_USER (Secure User - TA) are compiled
################################################################################
COMPILE_NS_USER ?= 64
override COMPILE_NS_KERNEL := 64
COMPILE_S_USER ?= 64
COMPILE_S_KERNEL ?= 64

################################################################################
# If you change this, you MUST run `make arm-tf-clean` first before rebuilding
################################################################################
TF_A_TRUSTED_BOARD_BOOT ?= n

OPTEE_OS_PLATFORM = kvm

########################################################################################
# If you change this, you MUST run `make arm-tf-clean optee-os-clean` before rebuilding
########################################################################################
XEN_BOOT ?= n

include common.mk

DEBUG ?= 1

# Option to use U-Boot in the boot flow instead of EDK2
UBOOT ?= n

# Option to build with GICV3 enabled
GICV3 ?= n

################################################################################
# Paths to git projects and various binaries
################################################################################
BINARIES_PATH		?= $(ROOT)/out/bin
MODULE_OUTPUT		?= $(ROOT)/out/kernel_modules
MKIMAGE_PATH		?= $(UBOOT_PATH)/tools

ROOTFS_GZ		?= $(BINARIES_PATH)/rootfs.cpio.gz
ROOTFS_UGZ		?= $(BINARIES_PATH)/rootfs.cpio.uboot

KERNEL_IMAGE		?= $(LINUX_PATH)/arch/arm64/boot/Image
KERNEL_IMAGEGZ		?= $(LINUX_PATH)/arch/arm64/boot/Image.gz
KERNEL_UIMAGE		?= $(BINARIES_PATH)/uImage

# Load and entry addresses
KERNEL_ENTRY		?= 0x40400000
KERNEL_LOADADDR		?= 0x40400000
ROOTFS_ENTRY		?= 0x44000000
ROOTFS_LOADADDR		?= 0x44000000

ifeq ($(UBOOT),y)
BL33_BIN		?= $(UBOOT_BIN)
BL33_DEPS		?= u-boot
else
BL33_BIN		?= $(EDK2_BIN)
BL33_DEPS		?= edk2
endif

################################################################################
# Targets
################################################################################
TARGET_DEPS := buildroot linux optee-os
TARGET_CLEAN := buildroot-clean linux-clean optee-os-clean check-clean

TARGET_DEPS 		+= $(BL33_DEPS)

all: $(TARGET_DEPS)

clean: $(TARGET_CLEAN)

$(BINARIES_PATH):
	mkdir -p $@

include toolchain.mk

################################################################################
# Linux kernel
################################################################################
LINUX_DEFCONFIG_COMMON_ARCH := arm64
LINUX_DEFCONFIG_COMMON_FILES := \
		$(LINUX_PATH)/arch/arm64/configs/defconfig \
		$(CURDIR)/kconfigs/qemu.conf

linux-defconfig: $(LINUX_PATH)/.config

LINUX_COMMON_FLAGS += ARCH=arm64 Image scripts_gdb

linux: linux-common
	mkdir -p $(BINARIES_PATH)
	ln -sf $(LINUX_PATH)/arch/arm64/boot/Image $(BINARIES_PATH)

linux-modules: linux
	$(MAKE) -C $(LINUX_PATH) $(LINUX_COMMON_FLAGS) modules
	$(MAKE) -C $(LINUX_PATH) $(LINUX_COMMON_FLAGS) INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=$(MODULE_OUTPUT) modules_install

linux-defconfig-clean: linux-defconfig-clean-common

LINUX_CLEAN_COMMON_FLAGS += ARCH=arm64

linux-clean: linux-clean-common

LINUX_CLEANER_COMMON_FLAGS += ARCH=arm64

linux-cleaner: linux-cleaner-common

################################################################################
# OP-TEE
################################################################################
OPTEE_OS_COMMON_FLAGS += DEBUG=$(DEBUG) CFG_ARM_GICV3=$(GICV3)

optee-os: optee-os-common

optee-os-clean: optee-os-clean-common

################################################################################
# mkimage - create images to be loaded by U-Boot
################################################################################
# Without the objcopy, the uImage will be 10x bigger.
$(KERNEL_UIMAGE): u-boot linux | $(BINARIES_PATH)
	${AARCH64_CROSS_COMPILE}objcopy -O binary \
					-R .note \
					-R .comment \
					-S $(LINUX_PATH)/vmlinux \
					$(BINARIES_PATH)/linux.bin
	$(MKIMAGE_PATH)/mkimage -A arm64 \
				-O linux \
				-T kernel \
				-C none \
				-a $(KERNEL_LOADADDR) \
				-e $(KERNEL_ENTRY) \
				-n "Linux kernel" \
				-d $(BINARIES_PATH)/linux.bin $(KERNEL_UIMAGE)

$(ROOTFS_UGZ): u-boot buildroot | $(BINARIES_PATH)
	ln -sf $(ROOT)/out-br/images/rootfs.cpio.gz $(BINARIES_PATH)
	$(MKIMAGE_PATH)/mkimage -A arm64 \
				-T ramdisk \
				-C gzip \
				-a $(ROOTFS_LOADADDR) \
				-e $(ROOTFS_ENTRY) \
				-n "Root file system" \
				-d $(ROOTFS_GZ) $(ROOTFS_UGZ)

