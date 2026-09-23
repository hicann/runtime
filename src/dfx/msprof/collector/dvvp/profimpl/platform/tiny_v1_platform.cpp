/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tiny_v1_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
PLATFORM_REGISTER(CHIP_TINY_V1, TinyV1Platform);
TinyV1Platform::TinyV1Platform()
{
    const std::vector<PlatformFeature> unsupportFeature = {
        PLATFORM_TASK_AICPU,          PLATFORM_TASK_BLOCK,     PLATFORM_TASK_DYNAMIC,
        PLATFORM_TASK_DELAY_DURATION, PLATFORM_SYS_DEVICE_NIC, PLATFORM_TASK_AICORE_LPM,
    };
    for (PlatformFeature feature : unsupportFeature) {
        supportedFeature_.erase(feature);
    }
    supportedFeature_.insert(PLATFORM_ADPROF);
}
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
