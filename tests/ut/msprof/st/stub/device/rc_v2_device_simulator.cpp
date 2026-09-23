/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rc_v2_device_simulator.h"

namespace Cann {
namespace Dvvp {
namespace Test {
namespace {
constexpr int64_t RC_V2_AICORE_NUM = 16;
constexpr int64_t RC_V2_VECTOR_CORE_NUM = 16;
constexpr int64_t RC_V2_AICPU_NUM = 8;
constexpr int64_t PLATFORM_VERSION_SHIFT = 8;
} // namespace

int32_t RcV2DeviceSimulator::GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t* value)
{
#ifndef BUILD_PROFILING_OPEN_PROJECT
    if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
        *value = static_cast<int64_t>(StPlatformType::RC_V2_TYPE) << PLATFORM_VERSION_SHIFT;
        return 0;
    }
#endif
    if (SetCoreNumValue(moduleType, infoType, value, RC_V2_AICORE_NUM, RC_V2_VECTOR_CORE_NUM, RC_V2_AICPU_NUM)) {
        return 0;
    }
    return 0;
}
} // namespace Test
} // namespace Dvvp
} // namespace Cann
