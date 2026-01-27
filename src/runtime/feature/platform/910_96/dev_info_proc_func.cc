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
namespace {
constexpr uint32_t BASE_AICPU_STREAM_ID = 1024U;
constexpr int32_t MAX_REPORT_TIMEOUT_CNT = 36;
}  // namespace

namespace cce {
namespace runtime {
static void MacroInitSolomon(rtSocType_t socType, RtMacroValue &value)
{
    UNUSED(socType);
    uint32_t rtsqDepth = 2049U;
    value.maxPersistTaskNum = 60000U;
    value.maxTaskNumPerStream = rtsqDepth - 35U;
    value.maxSinkTaskNum = 500000U;
    value.maxSupportTaskNum = 1000000U;
    value.pctraceFileLength = 4864U;
    value.pctraceFileHead = 128U;
    value.maxAllocStreamNum = 2016U;
    value.stubEventCount = 131072U;
    value.maxReportTimeoutCnt = MAX_REPORT_TIMEOUT_CNT;
    value.maxTaskNumPerHugeStream = 0U;
    value.maxAllocHugeStreamNum = 0U;
    value.maxModelNum = 2048U;
    value.rtsqDepth = rtsqDepth;
    value.baseAicpuStreamId = BASE_AICPU_STREAM_ID;
}

static DevDynInfoProcFunc CHIP_CLOUD_V5_PROC_FUNC = {
    .macroInitFunc = &MacroInitSolomon,
};

REGISTER_DEV_INFO_PROC_FUNC(CHIP_CLOUD_V5, CHIP_CLOUD_V5_PROC_FUNC);
}
}