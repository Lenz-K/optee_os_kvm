PLATFORM_FLAVOR ?= kvm

include core/arch/arm/cpu/cortex-armv8-0.mk
CFG_ARM64_core ?= y

ifeq ($(platform-debugger-arm),1)
# ARM debugger needs this
platform-cflags-debug-info = -gdwarf-2
platform-aflags-debug-info = -gdwarf-2
endif

$(call force,CFG_WITH_ARM_TRUSTED_FW,y)
$(call force,CFG_GIC,n)
$(call force,CFG_PL011,n)
$(call force,CFG_SECURE_TIME_SOURCE_CNTPCT,y)
ifeq ($(CFG_CORE_TPM_EVENT_LOG),y)
# NOTE: Below values for the TPM event log are implementation
# dependent and used mostly for debugging purposes.
# Care must be taken to properly configure them if used.
CFG_TPM_LOG_BASE_ADDR ?= 0x402c951
CFG_TPM_MAX_LOG_SIZE ?= 0x200
endif

ifeq ($(CFG_ARM64_core),y)
$(call force,CFG_WITH_LPAE,y)
else
$(call force,CFG_ARM32_core,y)
endif

CFG_WITH_STATS ?= y
CFG_ENABLE_EMBEDDED_TESTS ?= y

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
$(call force,CFG_DT,n)
CFG_DTB_MAX_SIZE ?= 0x100000

