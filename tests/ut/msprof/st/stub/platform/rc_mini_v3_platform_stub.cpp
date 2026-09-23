/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rc_mini_v3_platform_stub.h"
#include "rc_hidden_cli_args.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
constexpr char RC_MINI_V3_STUB_DEVICE_OSC_FREQ[] = "48";
constexpr char RC_MINI_V3_STUB_AIC_FREQ[] = "1250";

PLATFORM_REGISTER(static_cast<PlatformTypeEnum>(11), RcMiniV3PlatformStub);
RcMiniV3PlatformStub::RcMiniV3PlatformStub()
{
    const std::vector<PlatformFeature> unsupportFeature = {
        PLATFORM_TASK_AICPU,          PLATFORM_TASK_BLOCK,     PLATFORM_TASK_DYNAMIC,
        PLATFORM_TASK_DELAY_DURATION, PLATFORM_SYS_DEVICE_NIC, PLATFORM_TASK_AICORE_LPM,
    };
    for (PlatformFeature feature : unsupportFeature) {
        supportedFeature_.erase(feature);
    }
    // 扩展形态能力
    supportedFeature_.insert(PLATFORM_AICORE_EXCT_DEFAULT);
    supportedFeature_.insert(PLATFORM_SYS_DEVICE_LLC_EXT);
}

std::string RcMiniV3PlatformStub::GetDeviceOscDefaultFreq() { return RC_MINI_V3_STUB_DEVICE_OSC_FREQ; }

std::string RcMiniV3PlatformStub::GetAicDefaultFreq() { return RC_MINI_V3_STUB_AIC_FREQ; }

std::vector<std::string> RcMiniV3PlatformStub::GetHiddenCliArgs() const { return RcMiniV3HiddenCliArgs(); }
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
