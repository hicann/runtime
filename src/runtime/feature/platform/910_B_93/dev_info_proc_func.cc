/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dev_info.h"
#include "dev_info_manage.h"
#include "npu_driver.hpp"
namespace {
constexpr int32_t MAX_REPORT_TIMEOUT_CNT_STARS = 360;
constexpr uint32_t BASE_AICPU_STREAM_ID_V2 = 2048U;  // for A2/A3, aicpu stream id range [2048, 3072).
constexpr uint32_t BASE_AICPU_STREAM_ID_V2_MAX_STREAM = 32U * 1024U;
}  // namespace

namespace cce {
namespace runtime {
static void MacroInit910B(rtSocType_t socType, RtMacroValue &value)
{
    UNUSED(socType);
    uint32_t rtsqDepth = 4096U;

    const bool isSupportDevMem = NpuDriver::CheckIsSupportFeature(0U, FEATURE_TRSDRV_SQ_DEVICE_MEM_PRIORITY);
    if (isSupportDevMem) {
        rtsqDepth = 2048U;
    }

    value.maxPersistTaskNum = 60000U;
    value.maxTaskNumPerStream = rtsqDepth - 35U;
    value.maxSinkTaskNum = 64 * 1024 * 1024U;
    value.maxSupportTaskNum = 64 * 1024 * 1024U;
    value.pctraceFileLength = 4864U;
    value.pctraceFileHead = 128U;
    value.maxAllocStreamNum = 32 * 1024U;
    value.stubEventCount = 65536U;
    value.maxReportTimeoutCnt = MAX_REPORT_TIMEOUT_CNT_STARS;
    value.maxTaskNumPerHugeStream = 0U;
    value.maxAllocHugeStreamNum = 0U;
    value.maxModelNum = 2048U;
    value.rtsqDepth = rtsqDepth;
    value.baseAicpuStreamId = BASE_AICPU_STREAM_ID_V2;
    if (NpuDriver::CheckIsSupportFeature(0U, FEATURE_TRSDRV_SQ_SUPPORT_DYNAMIC_BIND)) {
        value.baseAicpuStreamId = BASE_AICPU_STREAM_ID_V2_MAX_STREAM;
    }
}

static DevDynInfoProcFunc CHIP_910B_PROC_FUNC = {
    .macroInitFunc = &MacroInit910B,
};

REGISTER_DEV_INFO_PROC_FUNC(CHIP_910_B_93, CHIP_910B_PROC_FUNC);
}  // namespace runtime
}  // namespace cce