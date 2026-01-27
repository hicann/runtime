/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_CONFIG_DEFINE_HPP__
#define __CCE_RUNTIME_CONFIG_DEFINE_HPP__

#if defined(__cplusplus)
extern "C" {
#endif

constexpr uint32_t BANDWITH_KBS = 1024U;
constexpr uint32_t BANDWITH_MBS = 1024U * 1024U;

/* ----------------------------------------CLOUD_V1---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_CLOUD)), \
                                                       (static_cast<uint32_t>(VER_NA)))
/* ---------------------------------------DC---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_DC               PLAT_COMBINE((static_cast<uint32_t>(ARCH_M200)), \
                                                    (static_cast<uint32_t>(CHIP_DC)), \
                                                    (static_cast<uint32_t>(VER_NA)))
/* --------old platform-------- */
#define PLATFORMCONFIG_DC_OLD           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), \
                                                    (static_cast<uint32_t>(CHIP_DC)), \
                                                    (static_cast<uint32_t>(VER_NA)))
/* ----------------------------------------CLOUD_V2---------------------------------------- */
/* --------platform---Asend910B4----- */
#define PLATFORMCONFIG_CLOUD_V2             PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_NA)))
/* --------old platform---Asend910B4----- */
#define PLATFORMCONFIG_CLOUD_V2_OLD         PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_NA)))

/* ----------------------------------------CLOUD_V2_910B---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_CLOUD_V2_910B2           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_CLOUD_V2_910B3           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_CLOUD_V2_910B4_1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN10)))

/* --------old platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B1_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_CLOUD_V2_910B2_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_CLOUD_V2_910B3_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_CLOUD_V2_910B4_1_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                    (static_cast<uint32_t>(RT_VER_BIN10)))

/* ----------------------------------------CLOUD_V2_910B2C---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B2C           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN8)))
/* ----------------------------------------DAVID_910_95---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_DAVID_910_9599        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN0)))

#define PLATFORMCONFIG_DAVID_910_9589        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN1)))

#define PLATFORMCONFIG_DAVID_910_958A        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN2)))

#define PLATFORMCONFIG_DAVID_910_958B        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN3)))

#define PLATFORMCONFIG_DAVID_910_957B        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN4)))

#define PLATFORMCONFIG_DAVID_910_957D        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN5)))

#define PLATFORMCONFIG_DAVID_910_950Z        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN6)))

#define PLATFORMCONFIG_DAVID_910_9579        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN7)))

#define PLATFORMCONFIG_ASCEND_910_5591           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_CLOUD_V5)), \
                                                       (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_DAVID_910_9591        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN11)))

#define PLATFORMCONFIG_DAVID_910_9592        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN12)))

#define PLATFORMCONFIG_DAVID_910_9581        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN13)))

#define PLATFORMCONFIG_DAVID_910_9582        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN14)))

#define PLATFORMCONFIG_DAVID_910_9584        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN15)))

#define PLATFORMCONFIG_DAVID_910_9587        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN16)))

#define PLATFORMCONFIG_DAVID_910_9588        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN17)))

#define PLATFORMCONFIG_DAVID_910_9572        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN18)))

#define PLATFORMCONFIG_DAVID_910_9575        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN19)))

#define PLATFORMCONFIG_DAVID_910_9576        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN20)))

#define PLATFORMCONFIG_DAVID_910_9574        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN21)))

#define PLATFORMCONFIG_DAVID_910_9577        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN22)))

#define PLATFORMCONFIG_DAVID_910_9578        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN23)))

#define PLATFORMCONFIG_DAVID_910_957C        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN24)))

#define PLATFORMCONFIG_DAVID_910_95A1        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN25)))
 
#define PLATFORMCONFIG_DAVID_910_95A2        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN26)))
 
#define PLATFORMCONFIG_DAVID_910_9595        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN27)))
 
#define PLATFORMCONFIG_DAVID_910_9596        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN28)))
 
#define PLATFORMCONFIG_DAVID_910_9585        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN29)))
 
#define PLATFORMCONFIG_DAVID_910_9586        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN30)))
 
#define PLATFORMCONFIG_DAVID_910_9583        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN31)))
 
#define PLATFORMCONFIG_DAVID_910_9571        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN32)))
 
#define PLATFORMCONFIG_DAVID_910_9573        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_DAVID)), \
                                                    (static_cast<uint32_t>(PG_VER_BIN33)))

#define PLATFORMCONFIG_DAVID_910_950X        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
 	                                                     (static_cast<uint32_t>(CHIP_DAVID)), \
 	                                                     (static_cast<uint32_t>(PG_VER_BIN34)))
 	 
#define PLATFORMCONFIG_DAVID_910_950Y        PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
 	                                                     (static_cast<uint32_t>(CHIP_DAVID)), \
 	                                                     (static_cast<uint32_t>(PG_VER_BIN35)))
#if defined(__cplusplus)
}
#endif
#endif  // __CCE_RUNTIME_CONFIG_DEFINE_HPP__
