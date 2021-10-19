#ifndef PLATFORM_CONFIG_H
#define PLATFORM_CONFIG_H

/* Make stacks aligned to data cache line length */
#define STACK_ALIGNMENT             64

/* 8250 UART */
#define CONSOLE_UART_BASE   0xcafebabe /* UART0 */
#define CONSOLE_BAUDRATE    115200

/* Optional: when used with CFG_WITH_PAGER, defines the device SRAM */
#define TZSRAM_BASE         0x3F000000
#define TZSRAM_SIZE         (200 * 1024)

/* Mandatory main secure RAM usually DDR */
#define TZDRAM_BASE         0x60000000
#define TZDRAM_SIZE         (32 * 1024 * 1024)

/* Mandatory TEE RAM location and core load address */
#define TEE_RAM_START               TZDRAM_BASE
#define TEE_RAM_PH_SIZE             TEE_RAM_VA_SIZE
#define TEE_RAM_VA_SIZE             (4 * 1024 * 1024)
#define TEE_LOAD_ADDR               (TZDRAM_BASE + 0x20000)

/* Mandatory TA RAM (external less secure RAM) */
#define TA_RAM_START                (TZDRAM_BASE + TEE_RAM_VA_SIZE)
#define TA_RAM_SIZE         (TZDRAM_SIZE - TEE_RAM_VA_SIZE)

/* Mandatory: for static SHM, need a hardcoded physical address */
#define TEE_SHMEM_START             0x08000000
#define TEE_SHMEM_SIZE              (4 * 1024 * 1024)

/* From QEMU v8: */
/* For virtual platforms where there isn't a clock */
#ifndef CONSOLE_UART_CLK_IN_HZ
#define CONSOLE_UART_CLK_IN_HZ	1
#endif

#endif /* PLATFORM_CONFIG_H */

