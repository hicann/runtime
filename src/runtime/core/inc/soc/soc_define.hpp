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
    CHIP_ASCEND_031 = 8, /* 1910b tiny */
    CHIP_NANO = 9,
    CHIP_RESERVED = 10,
    CHIP_AS31XM1 = 11,
    CHIP_610LITE = 12,
    CHIP_CLOUD_V3 = 13, // drive used, runtime not used
    CHIP_BS9SX1A = 14,  /* BS9SX1A */
    CHIP_DAVID = 15,
    CHIP_CLOUD_V5 = 16,
    CHIP_MC62CM12A = 17,  /* MC62CM12A */
    CHIP_MC32DM11A = 18,  /* MC32DM11A */
    CHIP_ASCEND_350 = 19, /* Ascend350 */
    CHIP_5162A = 20,
    CHIP_XPU,             /* XPU，无驱动值，但是有task处理，值不需要固定，无ini配置文件 */
    CHIP_END,             /* 常规芯片类型结束边界（运行时涉及芯片，除 XPU 外，和驱动定义的值一致） */

    /* 扩展芯片类型段（值大于 CHIP_END，仅用于离线编译，运行时不使用） */
    CHIP_EXT_BEGIN = 200, /* 扩展芯片类型起始边界 */
    CHIP_X90 = CHIP_EXT_BEGIN,       /* KirinX90 */
    CHIP_9030,      /* Kirin9030 */
    CHIP_EXT_END    /* 扩展芯片类型结束边界 */
} rtChipType_t;

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