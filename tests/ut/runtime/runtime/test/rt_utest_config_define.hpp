/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_UTEST_CONFIG_DEFINE_HPP
#define RT_UTEST_CONFIG_DEFINE_HPP

#include "stdint.h"

typedef enum tagRtArchType {
    ARCH_BEGIN = 0,
    ARCH_V100 = ARCH_BEGIN,
    ARCH_V200 = 1,
    ARCH_V300 = 2,
    ARCH_C100 = 3,  /* Ascend910 */
    ARCH_C220 = 4,  /* Ascend910B & Ascend910_93 */
    ARCH_M100 = 5,  /* Ascend310 */
    ARCH_M200 = 6,  /* Ascend310P & Ascend610 */
    ARCH_M201 = 7,  /* BS9SX1A */
    ARCH_T300 = 8,  /* Tiny */
    ARCH_N350 = 9,  /* Nano */
    ARCH_M300 = 10, /* Ascend310B & AS31XM1X */
    ARCH_M310 = 11, /* Ascend610Lite */
    ARCH_S200 = 12, /* Hi3796CV300ES & TsnsE */
    ARCH_S202 = 13, /* Hi3796CV300CS & OPTG & SD3403 &TsnsC */
    ARCH_M510 = 14, /* MC62CM12A */
    ARCH_L300 = 15, /* KirinX90 */
    ARCH_L311 = 16, /* Kirin9030 */
    ARCH_L510 = 17, /* KirinDev0000 */
    ARCH_L516 = 18, /* KirinDev0001 & KirinDev0002 & KirinDev0003 */
    ARCH_END,
} rtArchType_t;

/* ----------------------------------------BS9SX1A---------------------------------------- */
#define PLATFORMCONFIG_BS9SX1A \
    PLAT_COMBINE((static_cast<uint32_t>(ARCH_M201)), (static_cast<uint32_t>(CHIP_ADC)), (static_cast<uint32_t>(VER_CS)))
/* --------old platform-------- */
#define PLATFORMCONFIG_BS9SX1A_OLD \
    PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), (static_cast<uint32_t>(CHIP_ADC)), (static_cast<uint32_t>(VER_CS)))

/* ----------------------------------------AS31XM1X---------------------------------------- */
#define PLATFORMCONFIG_AS31XM1X \
    PLAT_COMBINE(               \
        (static_cast<uint32_t>(ARCH_M300)), (static_cast<uint32_t>(CHIP_AS31XM1)), (static_cast<uint32_t>(VER_NA)))
/* --------old platform-------- */
#define PLATFORMCONFIG_AS31XM1X_OLD \
    PLAT_COMBINE(                   \
        (static_cast<uint32_t>(ARCH_V300)), (static_cast<uint32_t>(CHIP_ADC)), (static_cast<uint32_t>(VER_310M1)))

/* ----------------------------------------Lite---------------------------------------- */
#define PLATFORMCONFIG_ADC_LITE \
    PLAT_COMBINE(               \
        (static_cast<uint32_t>(ARCH_M310)), (static_cast<uint32_t>(CHIP_610LITE)), (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_ADC_LITE_OLD \
    PLAT_COMBINE(                   \
        (static_cast<uint32_t>(ARCH_V200)), (static_cast<uint32_t>(CHIP_ADC)), (static_cast<uint32_t>(VER_LITE)))

/* ----------------------------------------MC62CM12A---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MC62CM12A \
    PLAT_COMBINE(                \
        (static_cast<uint32_t>(ARCH_M510)), (static_cast<uint32_t>(CHIP_MC62CM12A)), (static_cast<uint32_t>(VER_NA)))

/* ----------------------------------------MC32DM11A---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MC32DM11A \
    PLAT_COMBINE(                \
        (static_cast<uint32_t>(ARCH_M510)), (static_cast<uint32_t>(CHIP_MC32DM11A)), (static_cast<uint32_t>(VER_NA)))

/* ----------------------------------------CLOUD_V1---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V1 \
    PLAT_COMBINE(               \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_CLOUD)), (static_cast<uint32_t>(VER_NA)))
/* ---------------------------------------DC---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_DC \
    PLAT_COMBINE((static_cast<uint32_t>(ARCH_M200)), (static_cast<uint32_t>(CHIP_DC)), (static_cast<uint32_t>(VER_NA)))
/* --------old platform-------- */
#define PLATFORMCONFIG_DC_OLD \
    PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), (static_cast<uint32_t>(CHIP_DC)), (static_cast<uint32_t>(VER_NA)))
/* ----------------------------------------CLOUD_V2---------------------------------------- */
/* --------platform---Asend910B4----- */
#define PLATFORMCONFIG_CLOUD_V2                                                     \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_C220)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_NA)))
/* --------old platform---Asend910B4----- */
#define PLATFORMCONFIG_CLOUD_V2_OLD                                                 \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_NA)))

/* ----------------------------------------CLOUD_V2_910B---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B1                                               \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_C220)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_CLOUD_V2_910B2                                               \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_C220)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_CLOUD_V2_910B3                                               \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_C220)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_CLOUD_V2_910B4_1                                             \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_C220)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN10)))

/* --------old platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B1_OLD                                           \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_CLOUD_V2_910B2_OLD                                           \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_CLOUD_V2_910B3_OLD                                           \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_CLOUD_V2_910B4_1_OLD                                         \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN10)))

/* ----------------------------------------CLOUD_V2_910B2C---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_CLOUD_V2_910B2C                                              \
    PLAT_COMBINE(                                                                   \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_910_B_93)), \
        (static_cast<uint32_t>(RT_VER_BIN8)))
/* ----------------------------------------DAVID_950---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_DAVID_950PR_9599 \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN0)))

#define PLATFORMCONFIG_DAVID_950PR_9589 \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN1)))

#define PLATFORMCONFIG_DAVID_950PR_958A \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN2)))

#define PLATFORMCONFIG_DAVID_950PR_958B \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN3)))

#define PLATFORMCONFIG_DAVID_950PR_957B \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN4)))

#define PLATFORMCONFIG_DAVID_950PR_957D \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN5)))

#define PLATFORMCONFIG_DAVID_950PR_950Z \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN6)))

#define PLATFORMCONFIG_DAVID_950PR_9579 \
    PLAT_COMBINE(                       \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), (static_cast<uint32_t>(PG_VER_BIN7)))

#define PLATFORMCONFIG_ASCEND_910_5591 \
    PLAT_COMBINE(                      \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_CLOUD_V5)), (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_DAVID_950DT_9591                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN11)))

#define PLATFORMCONFIG_DAVID_950DT_9592                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN12)))

#define PLATFORMCONFIG_DAVID_950DT_9581                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN13)))

#define PLATFORMCONFIG_DAVID_950DT_9582                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN14)))

#define PLATFORMCONFIG_DAVID_950DT_9584                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN15)))

#define PLATFORMCONFIG_DAVID_950DT_9587                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN16)))

#define PLATFORMCONFIG_DAVID_950DT_9588                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN17)))

#define PLATFORMCONFIG_DAVID_950DT_9572                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN18)))

#define PLATFORMCONFIG_DAVID_950DT_9575                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN19)))

#define PLATFORMCONFIG_DAVID_950DT_9576                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN20)))

#define PLATFORMCONFIG_DAVID_950DT_9574                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN21)))

#define PLATFORMCONFIG_DAVID_950DT_9577                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN22)))

#define PLATFORMCONFIG_DAVID_950DT_9578                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN23)))

#define PLATFORMCONFIG_DAVID_950PR_957C                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN24)))

#define PLATFORMCONFIG_DAVID_950DT_95A1                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN25)))

#define PLATFORMCONFIG_DAVID_950DT_95A2                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN26)))

#define PLATFORMCONFIG_DAVID_950DT_9595                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN27)))

#define PLATFORMCONFIG_DAVID_950DT_9596                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN28)))

#define PLATFORMCONFIG_DAVID_950DT_9585                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN29)))

#define PLATFORMCONFIG_DAVID_950DT_9586                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN30)))

#define PLATFORMCONFIG_DAVID_950DT_9583                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN31)))

#define PLATFORMCONFIG_DAVID_950DT_9571                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN32)))

#define PLATFORMCONFIG_DAVID_950DT_9573                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN33)))

#define PLATFORMCONFIG_DAVID_950DT_950X                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN34)))

#define PLATFORMCONFIG_DAVID_950DT_950Y                                          \
    PLAT_COMBINE(                                                                \
        (static_cast<uint32_t>(ARCH_V100)), (static_cast<uint32_t>(CHIP_DAVID)), \
        (static_cast<uint32_t>(PG_VER_BIN35)))

/* ----------------------------------------MINI_V2---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MINI_V2 \
    PLAT_COMBINE((static_cast<uint32_t>(ARCH_M200)), (static_cast<uint32_t>(CHIP_ADC)), (static_cast<uint32_t>(VER_NA)))
/* --------old platform-------- */
#define PLATFORMCONFIG_MINI_V2_OLD \
    PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), (static_cast<uint32_t>(CHIP_ADC)), (static_cast<uint32_t>(VER_NA)))

/* ----------------------------------------MINI_V3---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MINI_V3 \
    PLAT_COMBINE(              \
        (static_cast<uint32_t>(ARCH_M300)), (static_cast<uint32_t>(CHIP_MINI_V3)), (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_MINI_V3_BIN1                                                \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_M300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_MINI_V3_BIN2                                                \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_M300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_MINI_V3_BIN3                                                \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_M300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_MINI_V3_BIN4                                                \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_M300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN4)))

/* --------old platform-------- */
#define PLATFORMCONFIG_MINI_V3_OLD \
    PLAT_COMBINE(                  \
        (static_cast<uint32_t>(ARCH_V300)), (static_cast<uint32_t>(CHIP_MINI_V3)), (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_MINI_V3_BIN1_OLD                                            \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_V300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_MINI_V3_BIN2_OLD                                            \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_V300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_MINI_V3_BIN3_OLD                                            \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_V300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_MINI_V3_BIN4_OLD                                            \
    PLAT_COMBINE(                                                                  \
        (static_cast<uint32_t>(ARCH_V300)), (static_cast<uint32_t>(CHIP_MINI_V3)), \
        (static_cast<uint32_t>(RT_VER_BIN4)))

/* ----------------------------------------MINI_5612(1910b tiny)---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MINI_5612 \
    PLAT_COMBINE(                \
        (static_cast<uint32_t>(ARCH_T300)), (static_cast<uint32_t>(CHIP_ASCEND_031)), (static_cast<uint32_t>(VER_NA)))

#endif