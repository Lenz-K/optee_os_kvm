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

ROOTFS_GZ		?= $(BINARIES_PATH)/rootfs.cpio.gz
ROOTFS_UGZ		?= $(BINARIES_PATH)/rootfs.cpio.uboot

KERNEL_IMAGE		?= $(LINUX_PATH)/arch/arm64/boot/Image
KERNEL_IMAGEGZ		?= $(LINUX_PATH)/arch/arm64/boot/Image.gz
KERNEL_UIMAGE		?= $(BINARIES_PATH)/uImage

################################################################################
# Targets
################################################################################
TARGET_DEPS := buildroot optee-os
TARGET_CLEAN := buildroot-clean optee-os-clean

all: $(TARGET_DEPS)

clean: $(TARGET_CLEAN)

$(BINARIES_PATH):
	mkdir -p $@

include toolchain.mk

################################################################################
# OP-TEE
################################################################################
OPTEE_OS_COMMON_FLAGS += DEBUG=$(DEBUG) CFG_ARM_GICV3=$(GICV3)

optee-os: optee-os-common

optee-os-clean: optee-os-clean-common

