/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_CONFIG_HPP__
#define __CCE_RUNTIME_CONFIG_HPP__

#include <string>
#include <mutex>
#include "base.hpp"
#include "driver/ascend_hal.h"
#include "runtime/config.h"
#include "runtime/mem.h"

#ifndef CDQ_VECTOR_CAST
namespace cce {
namespace runtime {

// 1000: Init value. The composition of this version is (1000 major + 10 minor).
//       For example, RUNTIME 9.2 would be represented by 9020.
// 1001: runtime support 64k label and not support old label api.
constexpr uint32_t RUNTIME_PUBLIC_VERSION = 1001U;

struct HardWareConfig {
    uint32_t platformConfig; /* PlatformInfo */
    rtAiCoreSpec_t aiCoreSpec;               /* AiCoreSpec */
    rtAiCoreMemorySize_t aiCoreMemorySize;   /* AiCoreMemorySize */
    rtAiCoreMemoryRates_t aiCoreMemoryRates; /* AiCoreMemoryRates */
    rtMemoryConfig_t memoryConfig;           /* MemoryConfig */
};

// runtime config management
class Config {
public:
    Config();
    virtual ~Config();
    rtPlatformType_t GetPlatformTypeByConfig(uint32_t platformConfig) const;
    rtError_t InitHardwareInfo() const;
    rtError_t GetAiCoreSpec(const rtPlatformType_t platformType,
                            rtAiCoreSpec_t * const aiCoreSpec) const;
    rtError_t GetAiCoreMemorySizes(const rtPlatformType_t platformType,
                                   rtAiCoreMemorySize_t * const aiCoreMemorySize) const;
    rtError_t GetAiCoreMemoryRates(const rtPlatformType_t platformType,
                                   rtAiCoreMemoryRates_t * const aiCoreMemoryRates) const;
    rtError_t GetMemoryConfig(const rtPlatformType_t platformType,
                              rtMemoryConfig_t * const memoryConfig) const;
    rtError_t SetAiCoreMemSizes(const rtPlatformType_t platformType,
                                const rtAiCoreMemorySize_t * const aiCoreMemorySize) const;
private:
    static void InitHardwareInfoCloudV2();
    static void InitHardwareInfo910B();
    static HardWareConfig hardWareConfig_[PLATFORM_END];
};
}
}
#endif
#endif  // __CCE_RUNTIME_CONFIG_HPP__
