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

void MstxDataHandler::ReportData()
{
    if (mstxDataBuf_.GetUsedSize() == 0) {
        return;
    }
    MsprofTxInfo info;
    for (;;) {
        if (!mstxDataBuf_.TryPop(info)) {
            break;
        }
        MsprofTxManager::instance()->ReportData(info);
    }
}

int MstxDataHandler::SaveMarkData(const char* msg, uint64_t mstxEventId, uint64_t domainNameHash)
{
    MsprofTxInfo info;
    info.infoType = 1; // 0: tx , 1: tx_ex
    info.value.stampInfo.eventType = static_cast<uint16_t>(EventType::MARK);
    info.value.stampInfo.processId = processId_;
    info.value.stampInfo.threadId = static_cast<uint32_t>(OsalGetTid());
    info.value.stampInfo.startTime = Platform::instance()->PlatformSysCycleTime();
    info.value.stampInfo.endTime = info.value.stampInfo.startTime;
    info.value.stampInfo.markId = mstxEventId;
    info.value.stampInfo.domain = domainNameHash;
    if (memcpy_s(info.value.stampInfo.message, MAX_MESSAGE_LEN - 1, msg, strlen(msg)) != EOK) {
        MSPROF_LOGE("memcpy message [%s] failed", msg);
        return PROFILING_FAILED;
    }
    info.value.stampInfo.message[strlen(msg)] = '\0';
    if (!mstxDataBuf_.TryPush(std::move(info))) {
        MSPROF_LOGE("try push mstx data failed, event id %lu", mstxEventId);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int MstxDataHandler::SaveRangeData(const char* msg, uint64_t mstxEventId, MstxDataType type, uint64_t domainNameHash)
{
    if (type == MstxDataType::DATA_RANGE_START) {
        MsprofTxInfo info;
        info.infoType = 1; // 0: tx , 1: tx_ex
        info.value.stampInfo.eventType = static_cast<uint16_t>(EventType::START_OR_STOP);
        info.value.stampInfo.processId = processId_;
        info.value.stampInfo.threadId = static_cast<uint32_t>(OsalGetTid());
        info.value.stampInfo.startTime = Platform::instance()->PlatformSysCycleTime();
        info.value.stampInfo.markId = mstxEventId;
        info.value.stampInfo.domain = domainNameHash;
        if (memcpy_s(info.value.stampInfo.message, MAX_MESSAGE_LEN - 1, msg, strlen(msg)) != EOK) {
            MSPROF_LOGE("memcpy message [%s] failed", msg);
            return PROFILING_FAILED;
        }
        info.value.stampInfo.message[strlen(msg)] = '\0';
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
        iter->second.value.stampInfo.endTime = Platform::instance()->PlatformSysCycleTime();
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