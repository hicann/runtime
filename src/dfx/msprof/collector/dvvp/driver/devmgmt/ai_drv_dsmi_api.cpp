/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ai_drv_dsmi_api.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "config_manager.h"
namespace Analysis {
namespace Dvvp {
namespace Driver {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;

int32_t DrvGetAicoreInfo(int32_t deviceId, int64_t &freq)
{
    if (deviceId < 0) {
        return PROFILING_FAILED;
    }
    return static_cast<int32_t>(halGetDeviceInfo(static_cast<uint32_t>(deviceId),
        static_cast<int32_t>(MODULE_TYPE_AICORE), static_cast<int32_t>(INFO_TYPE_FREQUE), &freq));
}

std::string DrvGeAicFrq(int32_t deviceId)
{
    const std::string defAicFrq = ConfigManager::instance()->GetAicDefFrequency();
    if (deviceId < 0) {
        return defAicFrq;
    }

#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        return defAicFrq;
    }
#endif // BUILD_OPEN_PROJECT
    int64_t freq = 0;
    int32_t ret = DrvGetAicoreInfo(deviceId, freq);
    if (ret != PROFILING_SUCCESS || freq == 0) {
        MSPROF_LOGW("Failed to get aic frequency, deviceId=%d, ret=%d", deviceId, ret);
        return defAicFrq;
    }

    MSPROF_LOGI("Cube Core current frequency %" PRId64 ".", freq);
    return std::to_string(freq);
}

std::string DrvGeAivFrq(int32_t deviceId)
{
    const std::string defAivFrq = ConfigManager::instance()->GetAicDefFrequency();
    if (deviceId < 0) {
        return defAivFrq;
    }
#ifndef BUILD_OPEN_PROJECT
    if (ConfigManager::instance()->GetPlatformType() == PlatformType::MINI_TYPE) {
        return defAivFrq;
    }
#endif // BUILD_OPEN_PROJECT
    int64_t freq = 0;
    const int32_t ret = static_cast<int32_t>(halGetDeviceInfo(static_cast<uint32_t>(deviceId),
        static_cast<int32_t>(MODULE_TYPE_VECTOR_CORE), static_cast<int32_t>(INFO_TYPE_FREQUE), &freq));
    if (ret != DRV_ERROR_NONE || freq == 0) {
        MSPROF_LOGW("Failed to get aiv frequency, deviceId=%d, ret=%d", deviceId, ret);
        return defAivFrq;
    }

    MSPROF_LOGI("Vector Core current frequency %" PRId64 ".", freq);
    return std::to_string(freq);
}
}  // namespace Driver
}  // namespace Dvvp
}  // namespace Analysis
