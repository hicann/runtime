/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "arch920x.hpp"
#include "base.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "task_scheduler_error.h"

namespace cce {
namespace runtime {

union rtUbDmaErrorCode_t {
    struct {
        uint32_t res0 : 8;
        uint32_t dieId0 : 2;
        uint32_t dieId1 : 2;
        uint32_t res1 : 4;
        uint32_t functionId0 : 7;
        uint32_t res2 : 1;
        uint32_t functionId1 : 7;
        uint32_t res3 : 1;
    } bits;
    uint32_t value;
};

struct UbDmaCqeJettyDetail {
    uint8_t dieId;
    uint8_t functionId;
    const TaskJettyStatus* info;
};

static std::string GetUbDmaSubStatusDesc(const uint8_t status, const uint8_t subStatus)
{
    static const std::unordered_map<uint8_t, std::unordered_map<uint8_t, std::string>> ubDmaSubStatusErrors = {
        {0x2U,
         {{1U, "local length error!"},
          {2U, "local access error!"},
          {3U, "remote response length error!"},
          {4U, "local data poison!"}}},
        {0x3U, {{1U, "remote unsupported request!"}, {2U, "remote access abort!"}, {4U, "remote data poison!"}}}};
    const auto statusIt = ubDmaSubStatusErrors.find(status);
    if (statusIt == ubDmaSubStatusErrors.end()) {
        return "(reserved)";
    }

    const auto subStatusIt = statusIt->second.find(subStatus);
    if (subStatusIt == statusIt->second.end()) {
        return "(reserved)";
    }
    return "(" + subStatusIt->second + ")";
}

static std::string GetUbDmaStatusDesc(const uint8_t status, const uint8_t subStatus, const uint32_t index)
{
    const auto& ubDmaTaskErrors = GetUbDmaTaskErrorMap();
    const auto statusIt = ubDmaTaskErrors.find(status);
    const std::string statusDesc = (statusIt != ubDmaTaskErrors.end()) ? statusIt->second : "reserved";
    const std::string subStatusDesc = GetUbDmaSubStatusDesc(status, subStatus);
    return RtFmtMsg(
        "status%u=0x%x(%s), sub_status%u=0x%x%s", index, static_cast<uint32_t>(status), statusDesc.c_str(), index,
        static_cast<uint32_t>(subStatus), subStatusDesc.c_str());
}

static std::string GetUbDmaCqeDetailItem(const UbDmaCqeJettyDetail& jettyDetail, uint8_t index)
{
    const auto idxStr = std::to_string(index);
    std::string detail = "dieId" + idxStr + "=" + std::to_string(jettyDetail.dieId);
    detail += ", functionId" + idxStr + "=" + std::to_string(jettyDetail.functionId);
    detail += ", jettyId" + idxStr + "=" + std::to_string(jettyDetail.info->jettyId);
    detail += ", " + GetUbDmaStatusDesc(jettyDetail.info->status, jettyDetail.info->subStatus, index);
    return detail;
}

static void ParseAndPrintUbDmaCqeDetail(TaskInfo* taskInfo, const rtCqReport_t& logicCq)
{
    uint8_t jettyCnt = 1U;
    if (taskInfo->type == TS_TASK_TYPE_UB_DB_SEND) {
        jettyCnt = taskInfo->u.ubSendTask.dbNum;
    }
    if (jettyCnt > UBDMA_CQE_JETTY_INFO_NUM) {
        jettyCnt = UBDMA_CQE_JETTY_INFO_NUM;
    }

    rtUbDmaErrorCode_t errorCode = {};
    errorCode.value = logicCq.errorCode;
    const UbDmaCqeJettyDetail jettyDetails[UBDMA_CQE_JETTY_INFO_NUM] = {
        {
            static_cast<uint8_t>(errorCode.bits.dieId0),
            static_cast<uint8_t>(errorCode.bits.functionId0),
            &logicCq.u1.info[0U],
        },
        {
            static_cast<uint8_t>(errorCode.bits.dieId1),
            static_cast<uint8_t>(errorCode.bits.functionId1),
            &logicCq.u1.info[1U],
        },
    };

    std::string detail;
    for (uint8_t i = 0U; i < jettyCnt; i++) {
        if (!detail.empty()) {
            detail += ",";
        }
        detail += GetUbDmaCqeDetailItem(jettyDetails[i], i);
    }

    RT_LOG(RT_LOG_ERROR, "ubdma cqe detailed error info: %s.", detail.c_str());
}

static void SetResultForUbDmaTask(TaskInfo* taskInfo, const rtCqReport_t& logicCq)
{
    SetUbDmaErrorCode(taskInfo, logicCq);
    if (((logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) || (taskInfo->errorCode == TS_ERROR_TASK_SW_STATUS_ERROR)) {
        return;
    }
    ParseAndPrintUbDmaCqeDetail(taskInfo, logicCq);
}

static bool UbDmaTaskRegister()
{
    TaskFuncSingle ubDbFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForUbDbSendTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForUbDmaDbModeTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForUbDbSendTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetResultForUbDmaTask,
    };
    TaskFuncSingle directSendFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructDavidSqeForUbDirectSendTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForUbDmaDirectWqeModeTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForUbDirectSendTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetResultForUbDmaTask,
    };

    for (const auto chip : GetArch920xChips()) {
        RegTaskFunc(chip, TS_TASK_TYPE_UB_DB_SEND, ubDbFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_DIRECT_SEND, directSendFuncs);
    }

    return true;
}

static bool g_ubDmaTaskRegister = UbDmaTaskRegister();

} // namespace runtime
} // namespace cce
