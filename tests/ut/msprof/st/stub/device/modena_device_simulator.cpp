/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "modena_device_simulator.h"

namespace Cann {
namespace Dvvp {
namespace Test {
int32_t ModenaDeviceSimulator::GetDeviceInfo(int32_t moduleType, int32_t infoType, int64_t *value)
{
#ifndef BUILD_PROFILING_OPEN_PROJECT
    if (moduleType == MODULE_TYPE_SYSTEM && infoType == INFO_TYPE_VERSION) {
        *value = static_cast<int64_t>(StPlatformType::CHIP_5162A) << 8;
    }
#endif

    if (SetCoreNumValue(moduleType, infoType, value, 18, 18, 8)) {
        return 0;
    }

    return 0;
}
}
}
}
