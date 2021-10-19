PLATFORM_FLAVOR ?= kvm

include core/arch/arm/cpu/cortex-armv8-0.mk

$(call force,CFG_TEE_CORE_NB_CORE,8)
$(call force,CFG_GENERIC_BOOT,y)
$(call force,CFG_PL011,y)
$(call force,CFG_PM_STUBS,y)
$(call force,CFG_SECURE_TIME_SOURCE_CNTPCT,y)
$(call force,CFG_WITH_ARM_TRUSTED_FW,n)
$(call force,CFG_WITH_LPAE,y)

ta-targets = ta_arm64

CFG_NUM_THREADS ?= 8
CFG_CRYPTO_WITH_CE ?= y
CFG_WITH_STACK_CANARIES ?= y
CFG_CONSOLE_UART ?= 1
CFG_DRAM_SIZE_GB ?= 1

# From QEMU v8:
CFG_ARM64_core ?= y

CFG_TEE_CORE_NB_CORE = 4
# [0e00.0000 0e0f.ffff] is reserved to early boot
CFG_TZDRAM_START ?= 0x0e100000
CFG_TZDRAM_SIZE  ?= 0x00f00000
# SHM chosen arbitrary, in a way that it does not interfere
# with initial location of linux kernel, dtb and initrd.
CFG_SHMEM_START ?= 0x42000000
CFG_SHMEM_SIZE  ?= 0x00200000
# When Secure Data Path is enable, last MByte of TZDRAM is SDP test memory.
CFG_TEE_SDP_MEM_SIZE ?= 0x00400000
$(call force,CFG_DT,y)
CFG_DTB_MAX_SIZE ?= 0x100000

$(call force,CFG_GIC,y)

