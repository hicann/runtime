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
constexpr int32_t MAX_REPORT_TIMEOUT_CNT_MDC = 1;
constexpr uint32_t BASE_AICPU_STREAM_ID = 1024U;
}  // namespace

namespace cce {
namespace runtime {
static void MacroInitMC62CM12A(rtSocType_t socType, RtMacroValue &value)
{
    UNUSED(socType);
    value.rtsqDepth = 1024U;
    value.stubEventCount = 512U;
    value.maxAllocStreamNum = 159U;  // one is reserved for SDMA safety processing
    value.maxPersistTaskNum = 32760U;
    value.maxTaskNumPerStream = 4090U;
    value.maxSinkTaskNum = 1000000U;
    value.maxSupportTaskNum = 2000000U;
    value.pctraceFileHead = 32U;
    value.pctraceFileLength = (4U * 1024U) + 6U;
    value.maxReportTimeoutCnt = MAX_REPORT_TIMEOUT_CNT_MDC;
    value.maxTaskNumPerHugeStream = 0U;
    value.maxAllocHugeStreamNum = 0U;
    value.maxModelNum = 256U;
    value.baseAicpuStreamId = BASE_AICPU_STREAM_ID;
}

static DevDynInfoProcFunc CHIP_MC62CM12A_PROC_FUNC = {
    .macroInitFunc = &MacroInitMC62CM12A,
};

REGISTER_DEV_INFO_PROC_FUNC(CHIP_MC62CM12A, CHIP_MC62CM12A_PROC_FUNC);
}
}