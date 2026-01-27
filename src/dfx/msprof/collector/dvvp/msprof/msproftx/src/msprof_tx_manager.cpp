/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msprof_tx_manager.h"
#include <cstdint>
#include <memory>
#include "osal.h"
#include "platform/platform.h"
#include "msprof_reporter.h"
#include "msprofiler_impl.h"
#include "utils.h"
#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "config/config.h"
#include "prof_report_api.h"

using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using namespace Analysis::Dvvp::ProfilerCommon;

namespace Msprof {
namespace MsprofTx {
constexpr uint32_t MARKEX_MODEL_ID = 0xFFFFFFFFU;
constexpr uint32_t MARKEX_TAG_ID = 11;
constexpr uint32_t MARKEX_MAX_CYCLE = 1000;

MsprofTxManager::MsprofTxManager() : isInit_(false), reporter_(nullptr), stampPool_(nullptr), categoryNameMap_({}),
    markExIndex_(0), rtProfilerTraceExFunc_(nullptr) {}

MsprofTxManager::~MsprofTxManager()
{
    reporter_.reset();
    stampPool_.reset();
}

int32_t MsprofTxManager::Init()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (reporter_ == nullptr) {
        MSPROF_LOGW("[Init] MsprofTxManager reporter not register, please check if register callback success.");
        return PROFILING_FAILED;
    }
    if (isInit_) {
        MSPROF_LOGW("[Init] MsprofTxManager already inited.");
        return PROFILING_SUCCESS;
    }

    MSVP_MAKE_SHARED0(stampPool_, ProfStampPool, return PROFILING_FAILED);
    auto ret = stampPool_->Init(CURRENT_STAMP_SIZE);
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[Init]init stamp pool failed, ret is %d", ret);
        MSPROF_INNER_ERROR("EK9999", "init stamp pool failed, ret is %d", ret);
        return PROFILING_FAILED;
    }

    ret = reporter_->Init();
    if (ret != PROFILING_SUCCESS) {
        MSPROF_LOGE("[Init]reporter init failed!");
        (void)stampPool_->UnInit();
        return PROFILING_FAILED;
    }

    isInit_ = true;
    return PROFILING_SUCCESS;
}

void MsprofTxManager::UnInit()
{
    std::lock_guard<std::mutex> lk(mtx_);
    if (isInit_) {
        (void)stampPool_->UnInit();
        (void)reporter_->UnInit();
        isInit_ = false;
        MSPROF_LOGI("[UnInit] TxManager unInit success.");
    }
}

/*!
 * get stamp pointer from memory pool
 * @return
 */
ACL_PROF_STAMP_PTR MsprofTxManager::CreateStamp() const
{
    if (!isInit_) {
        MSPROF_LOGE("[CreateStamp]MsprofTxManager is not inited yet");
        return nullptr;
    }

    return stampPool_->CreateStamp();
}

/*!
 *
 * @param stamp
 */
void MsprofTxManager::DestroyStamp(const ACL_PROF_STAMP_PTR stamp) const
{
    if (stamp == nullptr) {
        MSPROF_LOGE("[DestroyStamp]aclprofStamp is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
                           std::vector<std::string>({ "aclprofDestroyStamp", "stamp"}));
        return;
    }
    if (!isInit_) {
        MSPROF_LOGE("[DestroyStamp]MsprofTxManager is not inited yet");
        return;
    }
    stampPool_->DestroyStamp(stamp);
}

// save category and name relation
int32_t MsprofTxManager::SetCategoryName(uint32_t category, const std::string categoryName) const
{
    if (!isInit_) {
        MSPROF_LOGE("[SetCategoryName]MsprofTxManager is not inited yet");
        return PROFILING_FAILED;
    }
    MSPROF_LOGI("[SetCategoryName] category is %d, categoryName is %s", category, categoryName.c_str());
    const std::string msprofTxCategoryDict = "category_dict";

    std::string hashData = std::to_string(category) + HASH_DIC_DELIMITER + categoryName + "\n";
    return PROFILING_SUCCESS;
}

// stamp message manage
int32_t MsprofTxManager::SetStampCategory(ACL_PROF_STAMP_PTR stamp, uint32_t category) const
{
    if (stamp == nullptr) {
        MSPROF_LOGE("aclprofStamp is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
                           std::vector<std::string>({ "aclprofSetStampCategory", "stamp"}));
        return PROFILING_FAILED;
    }

    stamp->txInfo.value.stampInfo.category = category;
    return PROFILING_SUCCESS;
}

int32_t MsprofTxManager::SetStampPayload(ACL_PROF_STAMP_PTR stamp, const int32_t type, const void *value) const
{
    if (stamp == nullptr) {
        MSPROF_LOGE("aclprofStamp is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
            std::vector<std::string>({ "aclprofSetStampPayload", "stamp"}));
        return PROFILING_FAILED;
    }
    if (value == nullptr) {
        MSPROF_LOGE("[SetStampPayload]value is nullptr");
        return PROFILING_FAILED;
    }

    stamp->txInfo.value.stampInfo.payloadType = type;

    return PROFILING_SUCCESS;
}

int32_t MsprofTxManager::SetStampTraceMessage(ACL_PROF_STAMP_PTR stamp, CONST_CHAR_PTR msg, uint32_t msgLen) const
{
    if (stamp == nullptr) {
        MSPROF_LOGE("[SetStampTraceMessage]aclprofStamp is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
            std::vector<std::string>({ "aclprofSetStampTraceMessage", "stamp"}));
        return PROFILING_FAILED;
    }

    static const int32_t MAX_MSG_LEN = 128;
    if (msgLen >= MAX_MSG_LEN) {
        MSPROF_LOGE("[SetStampTraceMessage]msg len(%u) is invalid, must less then 128 bytes", msgLen);
        std::string errorReason = "msg len should be less than" + std::to_string(MAX_MSG_LEN);
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
            std::vector<std::string>({ "aclprofSetStampTraceMessage", "stamp"}));
        return PROFILING_FAILED;
    }
    auto ret = strncpy_s(stamp->txInfo.value.stampInfo.message, MAX_MSG_LEN - 1, msg, msgLen);
    if (ret != EOK) {
        MSPROF_LOGE("[SetStampTraceMessage]strcpy_s message failed, ret is %d", ret);
        return PROFILING_FAILED;
    }
    stamp->txInfo.value.stampInfo.message[msgLen] = 0;
    MSPROF_LOGD("[SetStampTraceMessage]stamp set trace message:%s success.", stamp->txInfo.value.stampInfo.message);
    return PROFILING_SUCCESS;
}

// mark stamp
int32_t MsprofTxManager::Mark(ACL_PROF_STAMP_PTR stamp) const
{
    if (!isInit_) {
        MSPROF_LOGE("[Mark]MsprofTxManager is not inited yet");
        return PROFILING_FAILED;
    }
    if (stamp == nullptr) {
        MSPROF_LOGE("[Mark]aclprofStamp is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
            std::vector<std::string>({ "aclprofMark", "stamp"}));
        return PROFILING_FAILED;
    }

    stamp->txInfo.value.stampInfo.startTime = Platform::instance()->PlatformSysCycleTime();
    stamp->txInfo.value.stampInfo.endTime = stamp->txInfo.value.stampInfo.startTime;
    stamp->txInfo.value.stampInfo.eventType = static_cast<uint32_t>(EventType::MARK);
    return ReportStampData(stamp);
}

int32_t MsprofTxManager::MarkEx(CONST_CHAR_PTR msg, size_t msgLen, aclrtStream stream)
{
    // check tx init status
    FUNRET_CHECK_EXPR_ACTION(!isInit_, return PROFILING_FAILED, "[MarkEx]MsprofTxManager is not inited yet.");
    // check if message invalid
    if (msg == nullptr || stream == nullptr || strlen(msg) != msgLen) {
        MSPROF_LOGE("[MarkEx]Invalid input param for markEx.");
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({"value", "param", "reason"}),
            std::vector<std::string>({"nullptr", "message", "Invalid input param for markEx"}));
        return PROFILING_FAILED;
    }
    FUNRET_CHECK_EXPR_ACTION(msgLen > static_cast<size_t>(MAX_MESSAGE_LEN - 1) || msgLen < 1, return PROFILING_FAILED,
        "[MarkEx]The length of input message should be in range of 1~%zu.", static_cast<size_t>(MAX_MESSAGE_LEN - 1));
    // create MsprofTxInfo info
    MsprofTxInfo info;
    info.infoType = 1;
    info.value.stampInfo.processId = static_cast<uint32_t>(OsalGetPid());
    info.value.stampInfo.threadId = static_cast<uint32_t>(OsalGetTid());
    info.value.stampInfo.eventType = static_cast<uint16_t>(EventType::MARK_EX);
    info.value.stampInfo.startTime = static_cast<uint64_t>(Utils::GetCPUCycleCounter());
    info.value.stampInfo.endTime = info.value.stampInfo.startTime;
    // rtProfilerTraceEx
    int32_t ret = MarkExPoint(stream, info);
    FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS,
        return PROFILING_FAILED, "[MarkEx]MarkExPoint failed, msgLen %zu.", msgLen);
    // copy message
    FUNRET_CHECK_EXPR_ACTION(memcpy_s(info.value.stampInfo.message, MAX_MESSAGE_LEN - 1, msg, msgLen) != EOK,
        return PROFILING_FAILED, "[MarkEx]Memcpy_s message failed, msgLen %zu.", msgLen);
    info.value.stampInfo.message[msgLen] = '\0';
    // report data
    ret = reporter_->Report(info);
    FUNRET_CHECK_EXPR_ACTION(ret != MSPROF_ERROR_NONE,
        return PROFILING_FAILED, "[ReportStampData]Report profiling data failed.");
    return PROFILING_SUCCESS;
}

int32_t MsprofTxManager::MarkExPoint(aclrtStream stream, MsprofTxInfo &info)
{
    FUNRET_CHECK_EXPR_ACTION(rtProfilerTraceExFunc_ == nullptr, return PROFILING_FAILED,
        "[MarkEx]Failed to call nullptr rtProfilerTraceEx.");
    uint64_t markId = GetTxEventId();
    const int32_t ret = rtProfilerTraceExFunc_(markId, MARKEX_MODEL_ID, MARKEX_TAG_ID,
        static_cast<void *>(stream));
    FUNRET_CHECK_EXPR_ACTION(ret != PROFILING_SUCCESS, return PROFILING_FAILED,
        "[MarkEx]Failed to call rtProfilerTraceEx, mark index: %u.", markId);
    info.value.stampInfo.markId = markId;
    MSPROF_LOGI("[MarkEx]Success to mark ex point in device, index: %u.", markId);
    return PROFILING_SUCCESS;
}

// stamp stack manage
int32_t MsprofTxManager::Push(ACL_PROF_STAMP_PTR stamp) const
{
    if (!isInit_) {
        MSPROF_LOGE("[Push]MsprofTxManager is not inited yet");
        return PROFILING_FAILED;
    }
    if (stamp == nullptr) {
        MSPROF_LOGE("[Push]aclprofStamp is nullptr");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
            std::vector<std::string>({ "aclprofPush", "stamp"}));
        return PROFILING_FAILED;
    }

    stamp->txInfo.value.stampInfo.startTime = Platform::instance()->PlatformSysCycleTime();
    return stampPool_->MsprofStampPush(stamp);
}

int32_t MsprofTxManager::Pop() const
{
    if (!isInit_) {
        MSPROF_LOGE("[Pop]MsprofTxManager is not inited yet");
        return PROFILING_FAILED;
    }
    auto stamp = stampPool_->MsprofStampPop();
    if (stamp == nullptr) {
        MSPROF_LOGE("[Pop]stampPool pop failed ,stamp is null!");
        return PROFILING_FAILED;
    }
    stamp->txInfo.value.stampInfo.endTime = Platform::instance()->PlatformSysCycleTime();
    stamp->txInfo.value.stampInfo.eventType = static_cast<uint32_t>(EventType::PUSH_OR_POP);
    return ReportStampData(stamp);
}

// stamp map manage
int MsprofTxManager::RangeStart(ACL_PROF_STAMP_PTR stamp, uint32_t *rangeId) const
{
    if (!isInit_) {
        MSPROF_LOGE("[RangeStart]MsprofTxManager is not inited yet");
        return PROFILING_FAILED;
    }
    if (stamp == nullptr) {
        MSPROF_LOGE("[RangeStart] stamp pointer is nullptr!");
        MSPROF_INPUT_ERROR("EK0006", std::vector<std::string>({ "api", "param"}),
            std::vector<std::string>({ "aclprofRangeStart", "stamp"}));
        return PROFILING_FAILED;
    }
    auto &stampInfo = stamp->txInfo.value.stampInfo;
    stampInfo.startTime = Platform::instance()->PlatformSysCycleTime();
    *rangeId = stampPool_->GetIdByStamp(stamp);
    MSPROF_LOGD("[RangeStart] save stamp success, rangeId is %u", *rangeId);
    return PROFILING_SUCCESS;
}

int32_t MsprofTxManager::RangeStop(uint32_t rangeId) const
{
    if (!isInit_) {
        MSPROF_LOGE("[RangeStop]MsprofTxManager is not inited yet");
        return PROFILING_FAILED;
    }
    auto stamp = stampPool_->GetStampById(rangeId);
    if (stamp == nullptr) {
        MSPROF_LOGE("[RangeStop] Get stamp by rangeId failed, rangeId is %u!", rangeId);
        std::string errorReason = "Get stamp by rangeId failed, this rangeId was not set in profAclRangeStart";
        MSPROF_INPUT_ERROR("EK0001", std::vector<std::string>({ "value", "param", "reason" }),
                           std::vector<std::string>({ std::to_string(rangeId), "rangeId", errorReason }));
        return PROFILING_FAILED;
    }
    stamp->txInfo.value.stampInfo.endTime = Platform::instance()->PlatformSysCycleTime();
    stamp->txInfo.value.stampInfo.eventType = static_cast<uint32_t>(EventType::START_OR_STOP);
    return ReportStampData(stamp);
}

int32_t MsprofTxManager::ReportStampData(MsprofStampInstance *stamp) const
{
    stamp->txInfo.value.stampInfo.threadId = static_cast<uint32_t>(OsalGetTid());
    if (reporter_->Report(stamp->txInfo) != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("[ReportStampData] report profiling data failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t MsprofTxManager::ReportData(MsprofTxInfo &info) const
{
    if (reporter_->Report(info) != MSPROF_ERROR_NONE) {
        MSPROF_LOGE("[ReportData] report profiling data failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

void MsprofTxManager::RegisterRuntimeTxCallback(const ProfMarkExCallback func)
{
    rtProfilerTraceExFunc_ = func;
    MSPROF_LOGI("[MsprofTxManager]Register rtProfilerTraceEx function.");
}

void MsprofTxManager::RegisterReporterCallback(const ProfAdditionalBufPushCallback func)
{
    if (reporter_ == nullptr) {
        MSVP_MAKE_SHARED0(reporter_, MsprofTxReporter, return);
    }
    reporter_->SetReporterCallback(func);
    MSPROF_LOGI("[MsprofTxManager]Register MsprofReportAdditional function.");
}

int32_t MsprofTxManager::LaunchDeviceTxTask(uint64_t indexId, VOID_PTR stm)
{
    FUNRET_CHECK_EXPR_ACTION(rtProfilerTraceExFunc_ == nullptr, return PROFILING_FAILED,
        "[MarkEx]Failed to call nullptr rtProfilerTraceEx.");
    return rtProfilerTraceExFunc_(indexId, MARKEX_MODEL_ID, MARKEX_TAG_ID, stm);
}

uint64_t MsprofTxManager::GetTxEventId()
{
    return ++txEventId_;
}
}
}
