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
#include <cerrno>
#include <map>
#include "errno/error_code.h"
#include "config_manager.h"
namespace Analysis {
namespace Dvvp {
namespace Driver {
using namespace Analysis::Dvvp::Common::Config;
using namespace analysis::dvvp::common::error;

int32_t DrvGetAicoreInfo(int32_t deviceId, int64_t &freq)
{
    if (deviceId < 0) {
        return PROFILING_FAILED;
    }
    MSPROF_LOGD("DrvGetAicoreInfo Freq %u", freq);
    return PROFILING_SUCCESS;
}

std::string DrvGeAicFrq(int32_t deviceId)
{
    MSPROF_LOGD("DrvGeAicFrq devId %d", deviceId);
    const std::string defAicFrq = Analysis::Dvvp::Common::Config::ConfigManager::instance()->GetAicDefFrequency();
    return defAicFrq;
}
}}}
