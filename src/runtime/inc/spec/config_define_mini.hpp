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

/* ----------------------------------------MINI_5612(1910b tiny)---------------------------------------- */
/* --------platform-------- */
#define PLATFORMCONFIG_MINI_5612            PLAT_COMBINE((static_cast<uint32_t>(ARCH_T300)), \
                                                         (static_cast<uint32_t>(CHIP_ASCEND_031)), \
                                                         (static_cast<uint32_t>(VER_NA)))
}
}
#endif  // __CCE_RUNTIME_CONFIG_DEFINE_MINI_HPP__