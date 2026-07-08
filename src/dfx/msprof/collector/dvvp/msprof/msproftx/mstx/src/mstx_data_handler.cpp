/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mstx_data_handler.h"
#include "msprof_dlog.h"
#include "errno/error_code.h"
#include "utils/utils.h"
#include "config/config.h"
#include "osal.h"
#include "mstx_domain_mgr.h"
#include "platform/platform.h"

using namespace analysis::dvvp;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::common::config;
using namespace Analysis::Dvvp::MsprofErrMgr;
using namespace Analysis::Dvvp::Common::Platform;

namespace Collector {
namespace Dvvp {
namespace Mstx {
MstxDataHandler::MstxDataHandler()
{
    Init();
}

MstxDataHandler::~MstxDataHandler()
{
    Uninit();
}

void MstxDataHandler::Init()
{
    mstxDataBuf_.Init(RING_BUFFER_DEFAULT_CAPACITY, "mstx_data_buf");
    init_.store(true);
    processId_ = static_cast<uint32_t>(OsalGetPid());
}

void MstxDataHandler::Uninit()
{
    Stop();
    if (init_.load()) {
        mstxDataBuf_.UnInit();
        tmpMstxRangeData_.clear();
        init_.store(false);
    }
}

int MstxDataHandler::Start(const std::string &mstxDomainInclude, const std::string &mstxDomainExclude)
{
    if (start_.load()) {
        return PROFILING_SUCCESS;
    }
    MstxDomainMgr::instance()->SetMstxDomainsEnabled(mstxDomainInclude, mstxDomainExclude);
    Thread::SetThreadName(analysis::dvvp::common::config::MSVP_MSTX_DATA_HANDLE_THREAD_NAME);
    analysis::dvvp::common::thread::Thread::Start();
    start_.store(true);
    return PROFILING_SUCCESS;
}

int MstxDataHandler::Stop()
{
    if (!start_.load()) {
        return PROFILING_SUCCESS;
    }
    start_.store(false);
    analysis::dvvp::common::thread::Thread::Stop();
    Flush();
    return PROFILING_SUCCESS;
}

void MstxDataHandler::Run(const struct error_message::Context &errorContext)
{
    MsprofErrorManager::instance()->SetErrorContext(errorContext);
    MSPROF_LOGI("mstx data handler thread start");
    for (;;) {
        if (!start_.load()) {
            break;
        }
        ReportData();
        Utils::UsleepInterupt(SLEEP_INTEVAL_US);
    }
    MSPROF_LOGI("mstx data handler thread stop");
}

void MstxDataHandler::Flush()
{
    ReportData();
}

std::vector<MsprofTxInfo> MstxDataHandler::SplitMstxInfo(const MstxInfo &info)
{
    std::vector<MsprofTxInfo> splitInfos;
    const size_t maxStrValid = MAX_MESSAGE_LEN - 1;  // -1 for '\0'
    size_t totalRawLen = info.message.size();

    uint32_t segIdx = 0;  // segment index starts from 0
    size_t offset = 0;
    while (offset < totalRawLen) {
        MsprofTxInfo splitInfo{};
        splitInfo.infoType = 1;
        splitInfo.res0 = segIdx;
        splitInfo.value.stampInfo.threadId = info.threadId;
        splitInfo.value.stampInfo.eventType = info.eventType;
        splitInfo.value.stampInfo.startTime = info.startTime;
        splitInfo.value.stampInfo.endTime = info.endTime;
        splitInfo.value.stampInfo.markId = info.markId;
        splitInfo.value.stampInfo.domain = info.domain;

        size_t takeLen = std::min(maxStrValid, totalRawLen - offset);
        std::string segContent = info.message.substr(offset, takeLen);
        if (memcpy_s(splitInfo.value.stampInfo.message, maxStrValid, segContent.c_str(), segContent.size()) != EOK) {
            MSPROF_LOGE("memcpy_s failed for message %s", info.message.c_str());
            // If memcpy_s fails, skip this segment and continue with the next one
            offset += takeLen;
            segIdx++;
            continue;
        }
        splitInfos.emplace_back(splitInfo);
        offset += takeLen;
        segIdx++;
    }
    return splitInfos;
}

void MstxDataHandler::ReportData()
{
    if (mstxDataBuf_.GetUsedSize() == 0) {
        return;
    }
    MstxInfo info;
    for (;;) {
        if (!mstxDataBuf_.TryPop(info)) {
            break;
        }
        auto splitInfos = SplitMstxInfo(info);
        for (auto &splitInfo : splitInfos) {
            MsprofTxManager::instance()->ReportData(splitInfo);
        }
    }
}

int MstxDataHandler::SaveMarkData(const char* msg, uint64_t mstxEventId, uint64_t domainNameHash)
{
    MstxInfo info;
    info.threadId = static_cast<uint32_t>(OsalGetTid());
    info.eventType = static_cast<uint32_t>(EventType::MARK);
    info.startTime = Platform::instance()->PlatformSysCycleTime();
    info.endTime = info.startTime;
    info.markId = mstxEventId;
    info.domain = domainNameHash;
    info.message = std::string(msg);

    if (!mstxDataBuf_.TryPush(std::move(info))) {
        MSPROF_LOGE("try push mstx data failed, event id %lu", mstxEventId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int MstxDataHandler::SaveRangeData(const char* msg, uint64_t mstxEventId, MstxDataType type, uint64_t domainNameHash)
{
    if (type == MstxDataType::DATA_RANGE_START) {
        MstxInfo info;
        info.threadId = static_cast<uint32_t>(OsalGetTid());
        info.eventType = static_cast<uint32_t>(EventType::START_OR_STOP);
        info.startTime = Platform::instance()->PlatformSysCycleTime();
        info.markId = mstxEventId;
        info.domain = domainNameHash;
        info.message = std::string(msg);
        std::lock_guard<std::mutex> lock(tmpRangeDataMutex_);
        tmpMstxRangeData_.insert({mstxEventId, std::move(info)});
        return PROFILING_SUCCESS;
    } else {
        std::lock_guard<std::mutex> lock(tmpRangeDataMutex_);
        auto iter = tmpMstxRangeData_.find(mstxEventId);
        if (iter == tmpMstxRangeData_.end()) {
            MSPROF_LOGE("mstx range end event [%lu] not found", mstxEventId);
            return PROFILING_FAILED;
        }
        iter->second.endTime = Platform::instance()->PlatformSysCycleTime();
        if (!mstxDataBuf_.TryPush(std::move(iter->second))) {
            MSPROF_LOGE("try push mstx data failed, event id %lu", mstxEventId);
            return PROFILING_FAILED;
        }
        tmpMstxRangeData_.erase(iter);
        return PROFILING_SUCCESS;
    }
}

int MstxDataHandler::SaveMstxData(const char* msg, uint64_t mstxEventId, MstxDataType type, uint64_t domainNameHash)
{
    return type == MstxDataType::DATA_MARK ? SaveMarkData(msg, mstxEventId, domainNameHash) :
        SaveRangeData(msg, mstxEventId, type, domainNameHash);
}

bool MstxDataHandler::IsStart()
{
    return start_.load();
}
}
}
}