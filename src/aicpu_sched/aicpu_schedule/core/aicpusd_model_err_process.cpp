/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpusd_model_err_process.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_drv_manager.h"
#include "securec.h"
#include "ts_api.h"
#include "type_def.h"

namespace {
constexpr uint32_t ERRLOG_MAXNUM = 16U;
constexpr uint32_t ERRLOG_UNIT_MAXLEN = 256U;
constexpr uint32_t ERRLOG_TOTAL_MAXLEN = 4096U;
}

namespace AicpuSchedule {
AicpuModelErrProc::AicpuModelErrProc()
{
    for (uint32_t i = 0U; i < ERRLOG_TS_MAXNUM; i++) {
        buffBaseAddr_[i] = 0ULL;
        buffLen_[i] = 0U;
        isBuffValid_[i] = false;
    }
}

AicpuModelErrProc &AicpuModelErrProc::GetInstance()
{
    static AicpuModelErrProc instance;
    return instance;
}

void AicpuModelErrProc::ProcessLogBuffCfgMsg(const aicpu::AicpuConfigMsg &cfgInfo)
{
    const uint32_t tsId = cfgInfo.tsId;
    const aicpu::AicpuConfigMsgType msgType = static_cast<aicpu::AicpuConfigMsgType>(cfgInfo.msgType);
    aicpusd_info("Begin to ProcessLogBuffCfgMsg, tsId[%u], msgType[%u].",
                 tsId, msgType);

    if (tsId >= ERRLOG_TS_MAXNUM) {
        aicpusd_err("Invalid input tsId, tsId[%u].", tsId);
        return;
    }

    switch (msgType) {
        case aicpu::AicpuConfigMsgType::AICPU_CONFIG_MSG_TYPE_BUF_FREE:
            SetLogBuffInvalid(tsId);
            break;

        case aicpu::AicpuConfigMsgType::AICPU_CONFIG_MSG_TYPE_BUF_RESET:
            SetUnitLogEmpy(tsId, cfgInfo.offset);
            break;

        case aicpu::AicpuConfigMsgType::AICPU_CONFIG_MSG_TYPE_BUF_SET_ADDR:
            SetLogBuffAddr(tsId, cfgInfo.bufAddr, cfgInfo.bufLen);
            break;

        default:
            aicpusd_err("Invalid msgType of ProcessLogBuffCfgMsg, msgType[%d].", msgType);
            break;
    }

    return;
}

void AicpuModelErrProc::SetLogBuffInvalid(const uint32_t tsId)
{
    lockBuff_.Lock();
    const ScopeGuard lockGuard([&] () { lockBuff_.Unlock(); });

    isBuffValid_[tsId] = false;
    return;
}

void AicpuModelErrProc::SetUnitLogEmpy(const uint32_t tsId, const uint32_t offset)
{
    if ((offset >= ERRLOG_TOTAL_MAXLEN) || ((offset % ERRLOG_UNIT_MAXLEN) != 0U)) {
        aicpusd_err("Invalid input offset, offset[%u].", offset);
        return;
    }

    lockBuff_.Lock();
    const ScopeGuard lockGuard([&] () { lockBuff_.Unlock(); });

    if (!isBuffValid_[tsId]) {
        return;
    }

    char_t * const errType = PtrToPtr<void, char_t>(ValueToPtr(buffBaseAddr_[tsId] + offset));
    *errType = static_cast<char_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_NULL);

    return;
}

void AicpuModelErrProc::SetLogBuffAddr(const uint32_t tsId, const uint64_t buffAddr, const uint16_t buffLen)
{
    lockBuff_.Lock();
    const ScopeGuard lockGuard([&] () { lockBuff_.Unlock(); });

    buffBaseAddr_[tsId] = buffAddr;
    buffLen_[tsId] = buffLen;
    isBuffValid_[tsId] = true;

    return;
}

uint32_t AicpuModelErrProc::GetEmptLogOffset(const uint32_t tsId)
{
    if (!isBuffValid_[tsId]) {
        return UINT32_MAX;
    }

    for (uint32_t i = 0U; i < ERRLOG_MAXNUM; i++) {
        const uint32_t offset = i * ERRLOG_UNIT_MAXLEN;
        if (offset >= ERRLOG_TOTAL_MAXLEN) {
            return UINT32_MAX;
        } else if (CheckLogIsEmpt(tsId, offset)) {
            return offset;
        } else {
            (void)i;
        }
    }
    return UINT32_MAX;
}

bool AicpuModelErrProc::CheckLogIsEmpt(const uint32_t tsId, const uint32_t offset) const
{
    if (offset >= ERRLOG_TOTAL_MAXLEN) {
        return false;
    }
    const char_t * const errType = PtrToPtr<void, char_t>(ValueToPtr(buffBaseAddr_[tsId] + offset));
    if ((*errType) == static_cast<char_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_NULL)) {
        return true;
    }
    return false;
}

uint32_t AicpuModelErrProc::AddErrLog(const aicpu::AicoreErrMsgInfo &errLog, const uint32_t tsId, uint32_t &offset)
{
    lockBuff_.Lock();
    const ScopeGuard lockGuard([&]() { lockBuff_.Unlock(); });

    offset = GetEmptLogOffset(tsId);
    if (offset == UINT32_MAX) {
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    char_t * const baseAddr = PtrToPtr<void, char_t>(ValueToPtr(buffBaseAddr_[tsId]));
    char_t * const wrAddr = baseAddr + offset;
    const errno_t eRet = memcpy_s(wrAddr, ERRLOG_UNIT_MAXLEN, &errLog, sizeof(aicpu::AicoreErrMsgInfo));
    if (eRet != EOK) {
        aicpusd_err("Failed to memcpy AicpuModelErrProc, ret[%d].", eRet);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }

    return AICPU_SCHEDULE_OK;
}

uint32_t AicpuModelErrProc::AddErrLog(const aicpu::AicpuErrMsgInfo &errLog, const uint32_t tsId, uint32_t &offset)
{
    lockBuff_.Lock();
    const ScopeGuard lockGuard([&]() { lockBuff_.Unlock(); });

    offset = GetEmptLogOffset(tsId);
    if (offset == UINT32_MAX) {
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }
    char_t * const baseAddr = PtrToPtr<void, char_t>(ValueToPtr(buffBaseAddr_[tsId]));
    char_t * const wrAddr = baseAddr + offset;

    const errno_t eRet = memcpy_s(wrAddr, ERRLOG_UNIT_MAXLEN, &errLog, sizeof(aicpu::AicpuErrMsgInfo));
    if (eRet != EOK) {
        aicpusd_err("Failed to memcpy AicpuModelErrProc, ret[%d].", eRet);
        return AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR;
    }

    return AICPU_SCHEDULE_OK;
}

void AicpuModelErrProc::RecordAicoreOpErrLog(const AicpuSqeAdapter::AicpuTaskReportInfo &info, 
                                             AicpuSqeAdapter &aicpuSqeAdapter)
{
    if (static_cast<int32_t>(info.result_code) == AICPU_SCHEDULE_OK) {
        return;
    }

    aicpusd_err("Aicpu start report aic/aiv result to ts. modelId=%hu, streamId=%hu, taskId=%hu, ret=%hu",
                info.model_id, info.stream_id, info.task_id, info.result_code);

    const auto model = AicpuModelManager::GetInstance().GetModel(static_cast<uint32_t>(info.model_id));
    if (model == nullptr) {
        aicpusd_err("Model[%u] is not found.", static_cast<uint32_t>(info.model_id));
        return;
    }

    const uint32_t tsId = model->GetModelTsId();
    if (tsId >= ERRLOG_TS_MAXNUM) {
        aicpusd_err("Invalid input tsId, tsId[%u].", tsId);
        return;
    }

    aicpu::AicoreErrMsgInfo aicLogInfo = {};
    aicLogInfo.errType = static_cast<uint8_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_AICORE);
    aicLogInfo.version = static_cast<uint8_t>(ModelErrRptVer::LOG_ERROR_VERSION_1);
    aicLogInfo.errorCode  = info.result_code;
    aicLogInfo.modelId  = static_cast<uint32_t>(info.model_id);
    aicLogInfo.taskId   = info.task_id;
    aicLogInfo.streamId = info.stream_id;
    aicLogInfo.transactionId = 0UL;

    uint32_t offset = UINT32_MAX;
    const uint32_t ret = AddErrLog(aicLogInfo, tsId, offset);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_warn("Failed to add AicoreErrLog, offset[%u], ret[%d].", offset, ret);
        return;
    }

    ErrLogRptInfo reportInfo = {};
    reportInfo.offset   = offset;
    reportInfo.errCode  = info.result_code;
    reportInfo.streamId = info.stream_id;
    reportInfo.taskId   = info.task_id;
    reportInfo.modelId  = static_cast<uint32_t>(info.model_id);
    reportInfo.tsId = tsId;
    if (ReportErrLog(reportInfo, &aicpuSqeAdapter) != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to report AicoreErrLog, offset[%u].", offset);
        SetUnitLogEmpy(tsId, offset);
    }

    return;
}

void AicpuModelErrProc::RecordAicpuOpErrLog(const RunContext &taskContext, const AicpuTaskInfo &kernelTaskInfo,
                                            const uint32_t resultCode)
{
    const auto kernelName = PtrToPtr<const void, const char_t>(ValueToPtr(kernelTaskInfo.kernelName));
    aicpusd_err("Aicpu report aicpu error to ts. modelId=%u, streamId=%u, taskId=%u, kernelType=%u, ret=%u,"
                "kernelName=%s", taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID,
                kernelTaskInfo.kernelType, resultCode, kernelName);

    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Model[%u] is not found.", taskContext.modelId);
        return;
    }

    const uint32_t tsId = model->GetModelTsId();
    if (tsId >= ERRLOG_TS_MAXNUM) {
        aicpusd_err("Invalid input tsId, tsId[%u].", tsId);
        return;
    }

    aicpu::AicpuErrMsgInfo cpuLogInfo = {};
    cpuLogInfo.errType = static_cast<uint8_t>(aicpu::AicpuErrMsgType::ERR_MSG_TYPE_AICPU);
    cpuLogInfo.version = static_cast<uint8_t>(ModelErrRptVer::LOG_ERROR_VERSION_1);
    cpuLogInfo.errorCode = resultCode;
    cpuLogInfo.modelId = taskContext.modelId;
    cpuLogInfo.streamId = taskContext.streamId;
    cpuLogInfo.transactionId = 0UL;
    const auto kernelNameLen = strnlen(kernelName, (sizeof(cpuLogInfo.opName) - 1UL));
    if (memcpy_s(cpuLogInfo.opName, sizeof(cpuLogInfo.opName), kernelName, kernelNameLen) != EOK) {
        aicpusd_err("Failed to memcpy opName, len[%u].", kernelNameLen);
        return;
    }

    const std::string errDesc("AICPU Stream Ops ERROR");
    if (memcpy_s(cpuLogInfo.errDesc, sizeof(cpuLogInfo.errDesc), errDesc.c_str(), errDesc.length()) != EOK) {
        aicpusd_err("Failed to memcpy errDesc, len[%u].", errDesc.length());
        return;
    }

    uint32_t offset = UINT32_MAX;
    const uint32_t ret = AddErrLog(cpuLogInfo, tsId, offset);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_warn("Failed to add AicpuModelErrProc, offset[%u], ret[%d].", offset, ret);
        return;
    }

    ErrLogRptInfo reportInfo = {};
    reportInfo.offset = offset;
    reportInfo.errCode = resultCode;
    reportInfo.streamId = model->GetReportStmId();
    reportInfo.taskId = kernelTaskInfo.taskID;
    reportInfo.modelId = taskContext.modelId;
    reportInfo.tsId = tsId;
    if (ReportErrLog(reportInfo) != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to report AicpuErrLog, offset[%u].", offset);
        SetUnitLogEmpy(tsId, offset);
    }
    return;
}

uint32_t AicpuModelErrProc::ReportErrLog(const ErrLogRptInfo &reportInfo, AicpuSqeAdapter *aicpuSqeAdapterPtr) const
{
    aicpusd_info("Begin to report log, tsId[%u], modelId[%u], streamId[%u], taskId[%u], offset[%u].",
                 reportInfo.tsId, reportInfo.modelId, reportInfo.streamId, reportInfo.taskId, reportInfo.offset);
    AicpuSqeAdapter::ErrMsgRspInfo errMsgRspInfo(reportInfo.offset, reportInfo.errCode, reportInfo.streamId, 
                                                 reportInfo.taskId, reportInfo.modelId, reportInfo.tsId);
    AicpuSqeAdapter aicpuSqeAdapter(FeatureCtrl::GetTsMsgVersion());
    if (aicpuSqeAdapterPtr == nullptr) {
        aicpuSqeAdapterPtr = &aicpuSqeAdapter;
    }
    const int32_t ret = aicpuSqeAdapterPtr->ErrorMsgResponseToTs(errMsgRspInfo);
    aicpusd_info("Finished to send logmsg report information, ret[%d].", ret);
    return ret;
}
} // namespace AicpuSchedule
