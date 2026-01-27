/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_SOC_DEFINE_HPP
#define CCE_RUNTIME_SOC_DEFINE_HPP

#include <cstdint>

namespace cce {
namespace runtime {

enum rtSocType_t : std::uint8_t {
    SOC_BEGIN = 0,
    SOC_ASCEND310,
    SOC_ASCEND910A,
    SOC_ASCEND910B,
    SOC_ASCEND910ProA,
    SOC_ASCEND910ProB,
    SOC_ASCEND910PremiumA,
    SOC_ASCEND610,
    SOC_ASCEND310P3,
    SOC_Hi3796CV300ES,
    SOC_Hi3796CV300CS,
    SOC_BS9SX1AA,
    SOC_ASCEND310P1,
    SOC_SD3403,
    SOC_ASCEND310B1,
    SOC_ASCEND320T,
    SOC_ASCEND910B1,
    SOC_ASCEND910B2,
    SOC_ASCEND910B3,
    SOC_ASCEND910B4,
    SOC_ASCEND610Lite,
    SOC_AS31XM1X,
    SOC_ASCEND035,
    SOC_ASCEND310B2,
    SOC_ASCEND310B3,
    SOC_ASCEND310B4,
    SOC_BS9SX1AB,
    SOC_BS9SX1AC,
    SOC_KP1636,
    SOC_ASCEND910B2C,
    SOC_ASCEND035A,
    SOC_ASCEND035B,
    SOC_ASCEND910_9599,
    SOC_ASCEND910B4_1,
    SOC_ASCEND910_5591,
    SOC_ASCEND310P5,
    SOC_ASCEND310P7,
    SOC_ASCEND910_9589,
    SOC_ASCEND910_958A,
    SOC_ASCEND910_958B,
    SOC_ASCEND910_957B,
    SOC_ASCEND910_957D,
    SOC_ASCEND910_950Z,
    SOC_MC62CM12A,
    SOC_ASCEND910_9579,
    SOC_ASCEND910_9591,
    SOC_ASCEND910_9592,
    SOC_ASCEND910_9581,
    SOC_ASCEND910_9582,
    SOC_ASCEND910_9584,
    SOC_ASCEND910_9587,
    SOC_ASCEND910_9588,
    SOC_ASCEND910_9572,
    SOC_ASCEND910_9575,
    SOC_ASCEND910_9576,
    SOC_ASCEND910_9574,
    SOC_ASCEND910_9577,
    SOC_ASCEND910_9578,
    SOC_ASCEND910_957C,
    SOC_ASCEND910_95A1,
    SOC_ASCEND910_95A2,
    SOC_ASCEND910_9595,
    SOC_ASCEND910_9596,
    SOC_ASCEND910_9585,
    SOC_ASCEND910_9586,
    SOC_ASCEND910_9583,
    SOC_ASCEND910_9571,
    SOC_ASCEND910_9573,
    SOC_ASCEND910_950X,
 	SOC_ASCEND910_950Y,
    SOC_KIRINX90,
    SOC_KIRIN9030,
    SOC_END,
};

typedef enum tagRtArchType {
    ARCH_BEGIN = 0,
    ARCH_V100 = ARCH_BEGIN,
    ARCH_V200 = 1,
    ARCH_V300 = 2,
    ARCH_C100 = 3, /* Ascend910 */
    ARCH_C220 = 4, /* Ascend910B & Ascend910_93 */
    ARCH_M100 = 5, /* Ascend310 */
    ARCH_M200 = 6, /* Ascend310P & Ascend610 */
    ARCH_M201 = 7, /* BS9SX1A */
    ARCH_T300 = 8, /* Tiny */
    ARCH_N350 = 9, /* Nano */
    ARCH_M300 = 10, /* Ascend310B & AS31XM1X */
    ARCH_M310 = 11, /* Ascend610Lite */
    ARCH_S200 = 12, /* Hi3796CV300ES & TsnsE */
    ARCH_S202 = 13, /* Hi3796CV300CS & OPTG & SD3403 &TsnsC */
    ARCH_M510 = 14, /* MC62CM12A */
    ARCH_L300 = 15, /* KirinX90 */
    ARCH_L311 = 16, /* Kirin9030 */
    ARCH_END,
} rtArchType_t;

typedef enum tagRtChipType {
    CHIP_BEGIN = 0,
    CHIP_MINI = CHIP_BEGIN,
    CHIP_CLOUD = 1,
    CHIP_ADC = 2,
    CHIP_LHISI = 3,
    CHIP_DC = 4,
    CHIP_910_B_93 = 5,
    CHIP_NO_DEVICE = 6,
    CHIP_MINI_V3 = 7,
    CHIP_5612 = 8, /* 1910b tiny */
    CHIP_NANO = 9,
    CHIP_1636 = 10,
    CHIP_AS31XM1 = 11,
    CHIP_610LITE = 12,
    CHIP_CLOUD_V3 = 13, // drive used, runtime not used
    CHIP_BS9SX1A = 14,  /* BS9SX1A */
    CHIP_DAVID = 15,
    CHIP_CLOUD_V5 = 16,
    CHIP_MC62CM12A = 17,  /* MC62CM12A */
    CHIP_X90 = 18,  /* KirinX90 */
    CHIP_9030 = 19,  /* Kirin9030 */
    CHIP_XPU = 20,
    CHIP_END
} rtChipType_t;

typedef enum tagRtDeviceCapabilityType {
    RT_SCHEDULE_SOFTWARE = 0, // Software Schedule
    RT_SCHEDULE_SOFTWARE_OPT,
    RT_SCHEDULE_HARDWARE, // HWTS Schedule
    RT_AICPU_BLOCKING_OP_NOT_SUPPORT,
    RT_AICPU_BLOCKING_OP_SUPPORT, // 1910/1980/51 ts support AICPU blocking operation
    RT_MODE_NO_FFTS, // no ffts
    RT_MODE_FFTS, // 81 get ffts work mode, ffts
    RT_MODE_FFTS_PLUS, // 81 get ffts work mode, ffts plus
    RT_DEV_CAP_SUPPORT, // Capability Support
    RT_DEV_CAP_NOT_SUPPORT, // Capability not support
} rtDeviceCapabilityType;

typedef enum tagRtVersion {
    VER_BEGIN = 0,
    VER_NA = VER_BEGIN,
    VER_ES = 1,
    VER_CS = 2,
    VER_SD3403 = 3,
    VER_LITE = 4,
    VER_310M1 = 5,
    VER_END = 6,
} rtVersion_t;

}
}
#endif // CCE_RUNTIME_SOC_DEFINE_HPP