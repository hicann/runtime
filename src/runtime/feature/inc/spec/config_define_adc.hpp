/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_CONFIG_DEFINE_ADC_HPP__
#define __CCE_RUNTIME_CONFIG_DEFINE_ADC_HPP__

#include "base.h"

namespace cce {
namespace runtime {
/* ----------------------------------------BS9SX1A---------------------------------------- */
#define PLATFORMCONFIG_BS9SX1A              PLAT_COMBINE((static_cast<uint32_t>(ARCH_M201)), \
                                                         (static_cast<uint32_t>(CHIP_ADC)), \
                                                         (static_cast<uint32_t>(VER_CS)))
/* --------old platform-------- */
#define PLATFORMCONFIG_BS9SX1A_OLD          PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), \
                                                         (static_cast<uint32_t>(CHIP_ADC)), \
                                                         (static_cast<uint32_t>(VER_CS)))

/* ----------------------------------------AS31XM1X---------------------------------------- */
#define PLATFORMCONFIG_AS31XM1X             PLAT_COMBINE((static_cast<uint32_t>(ARCH_M300)), \
                                                        (static_cast<uint32_t>(CHIP_AS31XM1)), \
                                                        (static_cast<uint32_t>(VER_NA)))
/* --------old platform-------- */
#define PLATFORMCONFIG_AS31XM1X_OLD         PLAT_COMBINE((static_cast<uint32_t>(ARCH_V300)), \
                                                        (static_cast<uint32_t>(CHIP_ADC)), \
                                                        (static_cast<uint32_t>(VER_310M1)))

constexpr uint32_t CUBEFREQ_ADC_BS9SX1A = 1230U;

/* ----------------------------------------Lite---------------------------------------- */
#define PLATFORMCONFIG_ADC_LITE             PLAT_COMBINE((static_cast<uint32_t>(ARCH_M310)), \
                                                         (static_cast<uint32_t>(CHIP_610LITE)), \
                                                         (static_cast<uint32_t>(VER_NA)))

#define PLATFORMCONFIG_ADC_LITE_OLD         PLAT_COMBINE((static_cast<uint32_t>(ARCH_V200)), \
                                                        (static_cast<uint32_t>(CHIP_ADC)), \
                                                        (static_cast<uint32_t>(VER_LITE)))

/* ----------------------------------------MC62CM12A---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MC62CM12A           PLAT_COMBINE((static_cast<uint32_t>(ARCH_M510)), \
                                                            (static_cast<uint32_t>(CHIP_MC62CM12A)), \
                                                            (static_cast<uint32_t>(VER_NA)))

/* --------aiCoreInfo-------- */
constexpr uint32_t CUBEFREQ_ADC_LITE        = 1250U;
constexpr uint32_t CUBEMSIZE_ADC_LITE       = 16U;
constexpr uint32_t CUBEKSIZE_ADC_LITE       = 16U;
constexpr uint32_t CUBENSIZE_ADC_LITE       = 16U;
#define FRAC_MKN_FP16_ADC_LITE              (RT_CUBE_MKN_FP16_16_16_16)
#define FRAC_MKN_INT8_ADC_LITE              (RT_CUBE_MKN_INT8_16_32_16)
#define FRAC_VMUL_MKN_FP16_ADC_LITE         (RT_VEC_VMUL_MKN_FP16_1_16_16)
#define FRAC_VMUL_MKN_INT8_ADC_LITE         (RT_VEC_VMUL_MKN_INT8_1_32_16)
/* --------MemoryPara(/Bytes)-------- */
#define L0ASIZE_ADC_LITE                    (64U * BANDWITH_KBS)
#define L0BSIZE_ADC_LITE                    (64U * BANDWITH_KBS)
#define L0CSIZE_ADC_LITE                    (128U * BANDWITH_KBS)
#define L1SIZE_ADC_LITE                     (1024U * BANDWITH_KBS)
#define L2SIZE_ADC_LITE                     (8U * BANDWITH_MBS)
#define UBSIZE_ADC_LITE                     (256U * BANDWITH_KBS)
#define BANKSIZE_ADC_LITE                   (4U * BANDWITH_KBS)
constexpr uint32_t L2PAGENUMBER_ADC_LITE    = 64U;
constexpr uint32_t BLOCKSIZE_ADC_LITE       = 32U;
constexpr uint32_t BANKNUM_ADC_LITE         = 64U;
constexpr uint32_t BANKGROUPNUM_ADC_LITE    = 16U;
/* --------bandwith-------- */
constexpr uint32_t DDRBW_ADC_LITE           = 20U;
constexpr uint32_t L2BW_ADC_LITE            = 144U;
constexpr uint32_t L2READBW_ADC_LITE        = 96U;
constexpr uint32_t L2WRITEBW_ADC_LITE       = 48U;
constexpr uint32_t L1TOL0ABW_ADC_LITE       = 512U;
constexpr uint32_t L1TOL0BBW_ADC_LITE       = 256U;
constexpr uint32_t L0CTOUBBW_ADC_LITE       = 128U;
constexpr uint32_t UBTOL2_ADC_LITE          = 128U;
constexpr uint32_t UBTODDR_ADC_LITE         = 20U;
constexpr uint32_t UBTOL1_ADC_LITE          = 128U;
/* --------flowtable && compiler-------- */
#define FLOWTABLESIZE_ADC_LITE              (8U * BANDWITH_KBS)
#define COMPILERSIZE_ADC_LITE               (16U * BANDWITH_KBS)

}
}
#endif  // __CCE_RUNTIME_CONFIG_DEFINE_ADC_HPP__
