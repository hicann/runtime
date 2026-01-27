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
}
}
#endif  // __CCE_RUNTIME_CONFIG_DEFINE_ADC_HPP__
