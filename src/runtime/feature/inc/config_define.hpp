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

#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif

constexpr uint32_t BANDWITH_KBS = 1024U;
constexpr uint32_t BANDWITH_MBS = 1024U * 1024U;

/* ----------------------------------------910_B_93---------------------------------------- */
/* --------platform---Asend910B4----- */
#define PLATFORMCONFIG_910_B_93             PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_NA)))
/* --------old platform---Asend910B4----- */
#define PLATFORMCONFIG_910_B_93_OLD         PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_NA)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_910_B_93 = 1000U;
constexpr uint32_t CUBEMSIZE_910_B_93 = 16U;
constexpr uint32_t CUBEKSIZE_910_B_93 = 16U;
constexpr uint32_t CUBENSIZE_910_B_93 = 16U;
#define FRAC_MKN_FP16_910_B_93            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_910_B_93            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_910_B_93         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_910_B_93        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
constexpr uint32_t L0ASIZE_910_B_93 = (64U * BANDWITH_KBS);
constexpr uint32_t L0BSIZE_910_B_93 = (64U * BANDWITH_KBS);
constexpr uint32_t L0CSIZE_910_B_93 = (256U * BANDWITH_KBS);
constexpr uint32_t L1SIZE_910_B_93 = (1024U * BANDWITH_KBS);
constexpr uint32_t L2SIZE_910_B_93 = (96U * BANDWITH_MBS);
constexpr uint32_t L2PAGENUMBER_910_B_93 = 64U;
constexpr uint32_t UBSIZE_910_B_93 = (256U * BANDWITH_KBS);
constexpr uint32_t BLOCKSIZE_910_B_93 = 32U;
constexpr uint32_t BANKSIZE_910_B_93 = (4U * BANDWITH_KBS);
constexpr uint32_t BANKNUM_910_B_93 = 64U;
constexpr uint32_t BANKGROUPNUM_910_B_93 = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_910_B_93 = 40U;
constexpr uint32_t L2BW_910_B_93 = 160U;
constexpr uint32_t L2READBW_910_B_93 = 80U;
constexpr uint32_t L2WRITEBW_910_B_93 = 80U;
constexpr uint32_t L1TOL0ABW_910_B_93 = 512U;
constexpr uint32_t L1TOL0BBW_910_B_93 = 256U;
constexpr uint32_t L0CTOUBBW_910_B_93 = 256U;
constexpr uint32_t UBTOL2_910_B_93 = 80U;
constexpr uint32_t UBTODDR_910_B_93 = 40U;
constexpr uint32_t UBTOL1_910_B_93 = 128U;
/* --------flowtable && compiler-------- */
constexpr uint32_t FLOWTABLESIZE_910_B_93 = (8U * BANDWITH_KBS);
constexpr uint32_t COMPILERSIZE_910_B_93 = (16U * BANDWITH_KBS);

/* ----------------------------------------910_B_93_910B---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_910B1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_910B2           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_910B3           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_910B4_1           PLAT_COMBINE((static_cast<uint32_t>(ARCH_C220)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN10)))

/* --------old platform-------- */
#define PLATFORMCONFIG_910B1_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_910B2_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_910B3_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_910B4_1_OLD       PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                    (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                    (static_cast<uint32_t>(RT_VER_BIN10)))

/* ----------------------------------------910_B_93_910B2C---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_910B2C           PLAT_COMBINE((static_cast<uint32_t>(ARCH_V100)), \
                                                       (static_cast<uint32_t>(CHIP_910_B_93)), \
                                                       (static_cast<uint32_t>(RT_VER_BIN8)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_910B = 1000U;
constexpr uint32_t CUBEMSIZE_910B = 16U;
constexpr uint32_t CUBEKSIZE_910B = 16U;
constexpr uint32_t CUBENSIZE_910B = 16U;
#define FRAC_MKN_FP16_910B            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_910B            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_910B         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_910B        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
constexpr uint32_t L0ASIZE_910B = (64U * BANDWITH_KBS);
constexpr uint32_t L0BSIZE_910B = (64U * BANDWITH_KBS);
constexpr uint32_t L0CSIZE_910B = (256U * BANDWITH_KBS);
constexpr uint32_t L1SIZE_910B = (1024U * BANDWITH_KBS);
constexpr uint32_t L2SIZE_910B = (192U * BANDWITH_MBS);
constexpr uint32_t L2SIZE_910B4_1 = (168U * BANDWITH_MBS);
constexpr uint32_t L2PAGENUMBER_910B = 64U;
constexpr uint32_t UBSIZE_910B = (256U * BANDWITH_KBS);
constexpr uint32_t BLOCKSIZE_910B = 32U;
constexpr uint32_t BANKSIZE_910B = (4U * BANDWITH_KBS);
constexpr uint32_t BANKNUM_910B = 64U;
constexpr uint32_t BANKGROUPNUM_910B = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_910B = 40U;
constexpr uint32_t L2BW_910B = 160U;
constexpr uint32_t L2READBW_910B = 80U;
constexpr uint32_t L2WRITEBW_910B = 80U;
constexpr uint32_t L1TOL0ABW_910B = 512U;
constexpr uint32_t L1TOL0BBW_910B = 256U;
constexpr uint32_t L0CTOUBBW_910B = 256U;
constexpr uint32_t UBTOL2_910B = 80U;
constexpr uint32_t UBTODDR_910B = 40U;
constexpr uint32_t UBTOL1_910B = 128U;
/* --------flowtable && compiler-------- */
constexpr uint32_t FLOWTABLESIZE_910B = (8U * BANDWITH_KBS);
constexpr uint32_t COMPILERSIZE_910B = (16U * BANDWITH_KBS);

typedef enum tagRtArchType {
    ARCH_BEGIN = 0,
    ARCH_V100 = ARCH_BEGIN,
    ARCH_V200 = 1,
    ARCH_V300 = 2,
    ARCH_C100 = 3,
    ARCH_C220 = 4,
    ARCH_M100 = 5,
    ARCH_M200 = 6,
    ARCH_M201 = 7,
    ARCH_T300 = 8,
    ARCH_N350 = 9,
    ARCH_M300 = 10,
    ARCH_M310 = 11,
    ARCH_S200 = 12,
    ARCH_S202 = 13,
    ARCH_M510 = 14,
    ARCH_L300 = 15,
    ARCH_L311 = 16,
    ARCH_END,
} rtArchType_t;

typedef enum tagRtChipType {
    CHIP_BEGIN = 0,
    CHIP_910_B_93 = 5,
    CHIP_NO_DEVICE = 6,
    CHIP_X90 = 18,
    CHIP_9030 = 19,
    CHIP_END
} rtChipType_t;

/* match rtChipType_t */
typedef enum tagRtPlatformType {
    PLATFORM_BEGIN = 0,
    PLATFORM_910_B_93,
    PLATFORM_910B1,
    PLATFORM_910B2,
    PLATFORM_910B3,
    PLATFORM_910B2C,
    PLATFORM_910B4_1,
    PLATFORM_END
} rtPlatformType_t;

#if defined(__cplusplus)
}
#endif
#endif  // __CCE_RUNTIME_CONFIG_DEFINE_HPP__
