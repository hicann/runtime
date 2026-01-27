/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "platform.h"
#include "errno/error_code.h"
#include "ai_drv_dev_api.h"
#include "platform/platform.h"
#include "logger/msprof_dlog.h"
#include "config_manager.h"

namespace Analysis {
namespace Dvvp {
namespace Common {
namespace Platform {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;

const std::string ASCEND_HAL_LIB = "libascend_hal.so";
constexpr uint32_t SUPPORT_ADPROF_VERSION = 0x72316;   // driver supported version 0x72316

bool Platform::CheckIfSupportAdprof(uint32_t deviceId) const
{
    if (deviceId == DEFAULT_HOST_ID) {
        return false;
    }

    if (DrvGetApiVersion() < SUPPORT_ADPROF_VERSION || GetPlatformType() == CHIP_MINI) {
        MSPROF_LOGI("Current version not support driver channel.");
        return false;
    }
    constexpr uint32_t vmngNormalNoneSplitMode = 0;
    uint32_t mode = 0;
    int32_t ret = ascendHalAdaptor_.DrvGetDeviceSplitMode(deviceId, &mode);
    if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Call drvGetDeviceSplitMode failed, return:%d.", ret);
        return false;
    }
    if ((GetPlatformType() == CHIP_DC || GetPlatformType() == CHIP_CLOUD) && mode != vmngNormalNoneSplitMode) {
        MSPROF_LOGI("This chip not support driver channel in split mode.");
        return false;
    }

    return true;
}
}
}
}
}