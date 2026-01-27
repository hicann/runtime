/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_CONFIG_DEFINE_MINI_HPP__
#define __CCE_RUNTIME_CONFIG_DEFINE_MINI_HPP__

#include "base.h"

namespace cce {
namespace runtime {

/* ----------------------------------------MINI_V2---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MINI_V2              PLAT_COMBINE((static_cast<uint32_t>(ARCH_M200)), \
                                                         (static_cast<uint32_t>(CHIP_ADC)), \
                                                        (static_cast<uint32_t>(VER_NA)))
/* --------old platform-------- */
#define PLATFORMCONFIG_MINI_V2_OLD          PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), \
                                                         (static_cast<uint32_t>(CHIP_ADC)), \
                                                         (static_cast<uint32_t>(VER_NA)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_MINI_V2 = 900U;
constexpr uint32_t CUBEMSIZE_MINI_V2 = 16U;
constexpr uint32_t CUBEKSIZE_MINI_V2 = 16U;
constexpr uint32_t CUBENSIZE_MINI_V2 = 16U;
#define FRAC_MKN_FP16_MINI_V2            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_MINI_V2            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_MINI_V2         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_MINI_V2        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
#define L0ASIZE_MINI_V2                    (64U * BANDWITH_KBS)
#define L0BSIZE_MINI_V2                    (64U * BANDWITH_KBS)
#define L0CSIZE_MINI_V2                    (256U * BANDWITH_KBS)
#define L1SIZE_MINI_V2                    (1024U * BANDWITH_KBS)
#define L2SIZE_MINI_V2                (8U * BANDWITH_MBS)
constexpr uint32_t L2PAGENUMBER_MINI_V2 = 64U;
#define UBSIZE_MINI_V2                    (256U * BANDWITH_KBS)
constexpr uint32_t BLOCKSIZE_MINI_V2 = 32U;
#define BANKSIZE_MINI_V2                (4U * BANDWITH_KBS)
constexpr uint32_t BANKNUM_MINI_V2 = 64U;
constexpr uint32_t BANKGROUPNUM_MINI_V2 = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_MINI_V2 = 20U;
constexpr uint32_t L2BW_MINI_V2 = 144U;
constexpr uint32_t L2READBW_MINI_V2 = 96U;
constexpr uint32_t L2WRITEBW_MINI_V2 = 48U;
constexpr uint32_t L1TOL0ABW_MINI_V2 = 512U;
constexpr uint32_t L1TOL0BBW_MINI_V2 = 256U;
constexpr uint32_t L0CTOUBBW_MINI_V2 = 128U;
constexpr uint32_t UBTOL2_MINI_V2 = 128U;
constexpr uint32_t UBTODDR_MINI_V2 = 20U;
constexpr uint32_t UBTOL1_MINI_V2 = 512U;
/* --------flowtable && compiler-------- */
#define FLOWTABLESIZE_MINI_V2            (8U * BANDWITH_KBS)
#define COMPILERSIZE_MINI_V2            (16U * BANDWITH_KBS)

/* ----------------------------------------MINI_V3---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MINI_V3              PLAT_COMBINE((static_cast<uint32_t>(ARCH_M300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_MINI_V3_BIN1         PLAT_COMBINE((static_cast<uint32_t>(ARCH_M300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_MINI_V3_BIN2         PLAT_COMBINE((static_cast<uint32_t>(ARCH_M300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_MINI_V3_BIN3         PLAT_COMBINE((static_cast<uint32_t>(ARCH_M300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_MINI_V3_BIN4         PLAT_COMBINE((static_cast<uint32_t>(ARCH_M300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN4)))

/* --------old platform-------- */
#define PLATFORMCONFIG_MINI_V3_OLD          PLAT_COMBINE((static_cast<uint32_t>(ARCH_V300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_MINI_V3_BIN1_OLD     PLAT_COMBINE((static_cast<uint32_t>(ARCH_V300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN1)))

#define PLATFORMCONFIG_MINI_V3_BIN2_OLD     PLAT_COMBINE((static_cast<uint32_t>(ARCH_V300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN2)))

#define PLATFORMCONFIG_MINI_V3_BIN3_OLD     PLAT_COMBINE((static_cast<uint32_t>(ARCH_V300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN3)))

#define PLATFORMCONFIG_MINI_V3_BIN4_OLD     PLAT_COMBINE((static_cast<uint32_t>(ARCH_V300)), \
                                                         (static_cast<uint32_t>(CHIP_MINI_V3)), \
                                                         (static_cast<uint32_t>(RT_VER_BIN4)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_MINI_V3 = 900U;
constexpr uint32_t CUBEMSIZE_MINI_V3 = 16U;
constexpr uint32_t CUBEKSIZE_MINI_V3 = 16U;
constexpr uint32_t CUBENSIZE_MINI_V3 = 16U;
#define FRAC_MKN_FP16_MINI_V3            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_MINI_V3            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_MINI_V3         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_MINI_V3        (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
#define L0ASIZE_MINI_V3                    (64U * BANDWITH_KBS)
#define L0BSIZE_MINI_V3                    (64U * BANDWITH_KBS)
#define L0CSIZE_MINI_V3                    (256U * BANDWITH_KBS)
#define L1SIZE_MINI_V3                    (1024U * BANDWITH_KBS)
#define L2SIZE_MINI_V3                (8U * BANDWITH_MBS)
constexpr uint32_t L2PAGENUMBER_MINI_V3 = 64U;
#define UBSIZE_MINI_V3                    (256U * BANDWITH_KBS)
constexpr uint32_t BLOCKSIZE_MINI_V3 = 32U;
#define BANKSIZE_MINI_V3                (4U * BANDWITH_KBS)
constexpr uint32_t BANKNUM_MINI_V3 = 64U;
constexpr uint32_t BANKGROUPNUM_MINI_V3 = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_MINI_V3 = 20U;
constexpr uint32_t L2BW_MINI_V3 = 144U;
constexpr uint32_t L2READBW_MINI_V3 = 96U;
constexpr uint32_t L2WRITEBW_MINI_V3 = 48U;
constexpr uint32_t L1TOL0ABW_MINI_V3 = 512U;
constexpr uint32_t L1TOL0BBW_MINI_V3 = 256U;
constexpr uint32_t L0CTOUBBW_MINI_V3 = 128U;
constexpr uint32_t UBTOL2_MINI_V3 = 128U;
constexpr uint32_t UBTODDR_MINI_V3 = 20U;
constexpr uint32_t UBTOL1_MINI_V3 = 512U;
/* --------flowtable && compiler-------- */
#define FLOWTABLESIZE_MINI_V3            (8U * BANDWITH_KBS)
#define COMPILERSIZE_MINI_V3            (16U * BANDWITH_KBS)

/* ----------------------------------------MINI_5612(1910b tiny)---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MINI_5612            PLAT_COMBINE((static_cast<uint32_t>(ARCH_T300)), \
                                                         (static_cast<uint32_t>(CHIP_5612)), \
                                                         (static_cast<uint32_t>(VER_NA)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_MINI_5612 = 900U;
constexpr uint32_t CUBEMSIZE_MINI_5612 = 16U;
constexpr uint32_t CUBEKSIZE_MINI_5612 = 16U;
constexpr uint32_t CUBENSIZE_MINI_5612 = 16U;
#define FRAC_MKN_FP16_MINI_5612            (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_MINI_5612            (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_MINI_5612       (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_MINI_5612       (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
#define L0ASIZE_MINI_5612                  (64U * BANDWITH_KBS)
#define L0BSIZE_MINI_5612                  (64U * BANDWITH_KBS)
#define L0CSIZE_MINI_5612                  (256U * BANDWITH_KBS)
#define L1SIZE_MINI_5612                   (1024U * BANDWITH_KBS)
#define L2SIZE_MINI_5612                   (8U * BANDWITH_MBS)
constexpr uint32_t L2PAGENUMBER_MINI_5612 = 64U;
#define UBSIZE_MINI_5612                   (256U * BANDWITH_KBS)
constexpr uint32_t BLOCKSIZE_MINI_5612 = 32U;
#define BANKSIZE_MINI_5612                 (4U * BANDWITH_KBS)
constexpr uint32_t BANKNUM_MINI_5612 = 64U;
constexpr uint32_t BANKGROUPNUM_MINI_5612 = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_MINI_5612 = 20U;
constexpr uint32_t L2BW_MINI_5612 = 144U;
constexpr uint32_t L2READBW_MINI_5612 = 96U;
constexpr uint32_t L2WRITEBW_MINI_5612 = 48U;
constexpr uint32_t L1TOL0ABW_MINI_5612 = 512U;
constexpr uint32_t L1TOL0BBW_MINI_5612 = 256U;
constexpr uint32_t L0CTOUBBW_MINI_5612 = 128U;
constexpr uint32_t UBTOL2_MINI_5612 = 128U;
constexpr uint32_t UBTODDR_MINI_5612 = 20U;
constexpr uint32_t UBTOL1_MINI_5612 = 512U;
/* --------flowtable && compiler-------- */
#define FLOWTABLESIZE_MINI_5612            (8U * BANDWITH_KBS)
#define COMPILERSIZE_MINI_5612             (16U * BANDWITH_KBS)
}
}
#endif  // __CCE_RUNTIME_CONFIG_DEFINE_MINI_HPP__