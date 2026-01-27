/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "op_analyzer_base.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {
using namespace analysis::dvvp::common::error;
static const uint32_t MHZ_CONVERT_GHZ = 1000; // 1000: mhz to ghz, syscnt * (1 / ghz) = ns
static const std::string DEFAULT_FREQ = "50"; // default freq in chip v4, not using when api version >= 0x071905

int32_t OpAnalyzerBase::InitFrequency(uint32_t deviceId)
{
    std::string freq = Analysis::Dvvp::Common::Platform::Platform::instance()->PlatformGetDeviceOscFreq(
        deviceId, DEFAULT_FREQ);
    frequency_ = std::stod(freq) / MHZ_CONVERT_GHZ;
    if (frequency_ <= 0) {
        MSPROF_LOGE("Failed to init Op analyzer freqency: %f ghz, get freq %s mhz.", frequency_, freq.c_str());
        return PROFILING_FAILED;
    } else {
        MSPROF_EVENT("Success to init Op analyzer frequency: %f.", frequency_);
        return PROFILING_SUCCESS;
    }
}
}
}
}
