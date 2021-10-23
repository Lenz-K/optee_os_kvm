/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (c) 2014, Linaro Limited
 */

#ifndef PLATFORM_CONFIG_H
#define PLATFORM_CONFIG_H

#include <mm/generic_ram_layout.h>
#include <stdint.h>

/* Make stacks aligned to data cache line length */
#define STACK_ALIGNMENT		64


#define GIC_BASE		0x08000000
#define UART0_BASE		0x09000000
#define UART1_BASE		0x09040000

#define IT_UART1		40

#define CONSOLE_UART_BASE	UART1_BASE
#define IT_CONSOLE_UART		IT_UART1

#define GICD_OFFSET		0
#define GICC_OFFSET		0x10000

#ifdef GIC_BASE
#define GICD_BASE		(GIC_BASE + GICD_OFFSET)
#define GICC_BASE		(GIC_BASE + GICC_OFFSET)
#endif

#ifndef UART_BAUDRATE
#define UART_BAUDRATE		115200
#endif
#ifndef CONSOLE_BAUDRATE
#define CONSOLE_BAUDRATE	UART_BAUDRATE
#endif

/* For virtual platforms where there isn't a clock */
#ifndef CONSOLE_UART_CLK_IN_HZ
#define CONSOLE_UART_CLK_IN_HZ	1
#endif

#endif /*PLATFORM_CONFIG_H*/
