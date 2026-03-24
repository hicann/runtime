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
static void InitLiteStreamInfo(RtMacroValue &value, fe::PlatFormInfos *platInfos)
{
    std::string normalNumStr;
    uint32_t normalNum = 0U;
    (void)platInfos->GetPlatformRes("SoCInfo", "normal_stream_num", normalNumStr);
    try {
        normalNum = static_cast<uint32_t>(std::stoi(normalNumStr));
    } catch (...) {
        RT_LOG(RT_LOG_EVENT, "normalNumStr[%s] is inValid.", normalNumStr.c_str());
    }

    std::string normalDepthStr;
    uint32_t normalDepth = 0U;
    (void)platInfos->GetPlatformRes("SoCInfo", "normal_stream_depth", normalDepthStr);
    try {
        normalDepth = static_cast<uint32_t>(std::stoi(normalDepthStr));
    } catch (...) {
        RT_LOG(RT_LOG_EVENT, "normalDepthStr[%s] is inValid.", normalDepthStr.c_str());
    }

    std::string hugeNumStr;
    uint32_t hugeNum = 0U;
    (void)platInfos->GetPlatformRes("SoCInfo", "huge_stream_num", hugeNumStr);
    try {
        hugeNum = static_cast<uint32_t>(std::stoi(hugeNumStr));
    } catch (...) {
        RT_LOG(RT_LOG_EVENT, "hugeNumStr[%s] is inValid.", hugeNumStr.c_str());
    }

    std::string hugeDepthStr;
    uint32_t hugeDepth = 0U;
    (void)platInfos->GetPlatformRes("SoCInfo", "huge_stream_depth", hugeDepthStr);
    try {
        hugeDepth = static_cast<uint32_t>(std::stoi(hugeDepthStr));
    } catch (...) {
        RT_LOG(RT_LOG_EVENT, "hugeDepthStr[%s] is inValid.", hugeDepthStr.c_str());
    }

    RT_LOG(RT_LOG_INFO, "normalNum:%u, normalDepth:%u, hugeNum:%u, hugeDepth:%u.",
        normalNum, normalDepth, hugeNum, hugeDepth);
    value.maxAllocStreamNum = (normalNum == 0U) ? value.maxAllocStreamNum : normalNum;
    value.maxTaskNumPerStream = (normalDepth == 0U) ? value.maxTaskNumPerStream : normalDepth;
    value.maxAllocHugeStreamNum = hugeNum; // huge stream can set zero
    value.maxTaskNumPerHugeStream = (hugeDepth == 0U) ? value.maxTaskNumPerHugeStream : hugeDepth;

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

    InitLiteStreamInfo(value, &platInfos);

    return;
}

static void MacroInit610Lite(rtSocType_t socType, RtMacroValue &value)
{
    value.stubEventCount = 512U;
    value.maxAllocStreamNum = 112U;
    value.maxPersistTaskNum = 32760U;
    value.maxTaskNumPerStream = 1024U;
    value.maxSinkTaskNum = 1000000U;
    value.maxSupportTaskNum = 2000000U;
    value.pctraceFileHead = 32U;
    value.pctraceFileLength = (4U * 1024U) + 6U;
    value.maxReportTimeoutCnt = MAX_REPORT_TIMEOUT_CNT_MDC;
    value.maxTaskNumPerHugeStream = 8192U;
    value.maxAllocHugeStreamNum = 16U;
    value.maxModelNum = 256U;
    value.baseAicpuStreamId = BASE_AICPU_STREAM_ID;
    ParseIniFile(socType, value);
    return;
}

static DevDynInfoProcFunc CHIP_610LITE_PROC_FUNC = {
    .macroInitFunc = &MacroInit610Lite,
};

REGISTER_DEV_INFO_PROC_FUNC(CHIP_610LITE, CHIP_610LITE_PROC_FUNC);
}
}