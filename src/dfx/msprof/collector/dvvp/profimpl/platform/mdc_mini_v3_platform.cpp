/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mdc_mini_v3_platform.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
PLATFORM_REGISTER(CHIP_MDC_MINI_V3, MdcMiniV3Platform);
MdcMiniV3Platform::MdcMiniV3Platform()
{
    const std::vector<PlatformFeature> unsupportFeature = {
        PLATFORM_TASK_AICPU,
        PLATFORM_TASK_BLOCK,
        PLATFORM_SYS_DEVICE_NIC,
        PLATFORM_TASK_AICORE_LPM,
        PLATFORM_TASK_DYNAMIC,
        PLATFORM_TASK_DELAY_DURATION,
    };
    for (PlatformFeature feature : unsupportFeature) {
        supportedFeature_.erase(feature);
    }
}
}
}
}