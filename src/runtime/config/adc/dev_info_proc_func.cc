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
#include "platform/platform_info.h"
#include "soc_info.h"
namespace {
constexpr int32_t MAX_REPORT_TIMEOUT_CNT_MDC = 1;
constexpr uint32_t BASE_AICPU_STREAM_ID = 1024U;
}  // namespace

namespace cce {
namespace runtime {
static void InitMDCStreamInfo(RtMacroValue &value, fe::PlatFormInfos *platInfos)
{
    std::string taskNumStr;
    uint32_t taskNum = 0U;
    (void)platInfos->GetPlatformRes("SoCInfo", "task_num", taskNumStr);
    try {
        taskNum = static_cast<uint32_t>(std::stoi(taskNumStr));
    } catch (...) {
        RT_LOG(RT_LOG_EVENT, "taskNumStr[%s] is inValid.", taskNumStr.c_str());
    }

    RT_LOG(RT_LOG_INFO, "taskNum:%u.", taskNum);
    value.maxTaskNumPerStream = (taskNum == 0U) ? value.maxTaskNumPerStream : taskNum;
    return;
}

static void ParseIniFile(rtSocType_t socType, RtMacroValue &value)
{
    const std::string socVersion = GetSocVersionStrByType(socType);
    if (socVersion.empty()) {
        RT_LOG(RT_LOG_WARNING, "Get socversion failed.");
        return;
    }

    if (fe::PlatformInfoManager::Instance().InitializePlatformInfo() != 0U) {
        RT_LOG(RT_LOG_WARNING, "init failed.");
        return;
    }

    fe::OptionalInfos optInfos;
    fe::PlatFormInfos platInfos;
    if (fe::PlatformInfoManager::Instance().GetPlatformInfos(socVersion, platInfos, optInfos) != 0U) {
        RT_LOG(RT_LOG_WARNING, "Get infos failed.");
        return;
    }

    InitMDCStreamInfo(value, &platInfos);

    return;
}

static void MacroInitMdc(rtSocType_t socType, RtMacroValue &value)
{
    value.stubEventCount = 1024U;
    value.maxAllocStreamNum = 255U;      // one is reserved for SDMA safety processing
    value.maxPersistTaskNum = 32760U;
    value.maxTaskNumPerStream = 1018U;
    value.maxSinkTaskNum = 1000000U;
    value.maxSupportTaskNum = 2000000U;
    value.pctraceFileHead = 32U;
    value.pctraceFileLength = (4U * 1024U) + 6U;
    value.maxReportTimeoutCnt = MAX_REPORT_TIMEOUT_CNT_MDC;
    value.maxTaskNumPerHugeStream = 0U;
    value.maxAllocHugeStreamNum = 0U;
    value.maxModelNum = 256U;
    value.baseAicpuStreamId = BASE_AICPU_STREAM_ID;
    ParseIniFile(socType, value);
}

static DevDynInfoProcFunc CHIP_ADC_PROC_FUNC = {
    .macroInitFunc = &MacroInitMdc,
};

REGISTER_DEV_INFO_PROC_FUNC(CHIP_ADC, CHIP_ADC_PROC_FUNC);
}
}