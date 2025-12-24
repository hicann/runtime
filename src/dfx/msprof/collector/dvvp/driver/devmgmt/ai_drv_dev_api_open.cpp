/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ai_drv_dev_api.h"
#include <set>
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "ascend_hal.h"
#include "config_manager.h"

namespace analysis {
namespace dvvp {
namespace driver {
using namespace analysis::dvvp::common::error;
using namespace Analysis::Dvvp::Common::Config;

int32_t DrvGetAivNum(uint32_t deviceId, int64_t &aivNum)
{
    const std::set<PlatformType> unsupportTypeSet{PlatformType::CLOUD_TYPE, PlatformType::DC_TYPE};
    auto type = ConfigManager::instance()->GetPlatformType();
    if (unsupportTypeSet.find(type) != unsupportTypeSet.cend()) {
        aivNum = 0;
        MSPROF_LOGI("Driver doesn't support DrvGetAivNum by halGetDeviceInfo interface");
        return PROFILING_SUCCESS;
    }
    drvError_t ret = halGetDeviceInfo(deviceId, static_cast<int32_t>(MODULE_TYPE_VECTOR_CORE),
    static_cast<int32_t>(INFO_TYPE_CORE_NUM), &aivNum);
    if (ret == DRV_ERROR_NOT_SUPPORT) {
        MSPROF_LOGW("Driver doesn't support DrvGetAivNum by halGetDeviceInfo interface, "
            "deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        return PROFILING_SUCCESS;
    } else if (ret != DRV_ERROR_NONE) {
        MSPROF_LOGE("Failed to DrvGetAivNum, deviceId=%u, ret=%d", deviceId, static_cast<int32_t>(ret));
        MSPROF_CALL_ERROR("EK9999", "Failed to DrvGetAivNum, deviceId=%u, ret=%d",
            deviceId, static_cast<int32_t>(ret));
        return PROFILING_FAILED;
    }

    MSPROF_LOGI("Succeeded to DrvGetAivNum, deviceId=%u, aivNum=%lld", deviceId, aivNum);
    return PROFILING_SUCCESS;
}
}  // namespace driver
}  // namespace dvvp
}  // namespace analysis
