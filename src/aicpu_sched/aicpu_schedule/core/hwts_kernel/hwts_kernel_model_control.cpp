/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_model_control.h"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "aicpusd_monitor.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_model_err_process.h"
#include "hwts_kernel_common.h"

namespace AicpuSchedule {
namespace {
const std::string KERNEL_END_GRAPH = "endGraph";
const std::string RECORD_NOTIFY = "recordNotify";
const std::string ACTIVE_ENTRY_STREAM = "activeEntryStream";
const std::string MODEL_STOP = "AICPUModelStop";
const std::string MODEL_CLEAR_RESTART = "AICPUModelClearInputAndRestart";
}  // namespace

int32_t EndGraphTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_info("Begin to process ts kernel end graph");
    const auto modelIdPtr =
        PtrToPtr<void, uint32_t>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (modelIdPtr == nullptr) {
        aicpusd_err("ModelEndGraph taskInfo paramBase is null, kernelType[%u].",
                    tsKernelInfo.kernelType);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    const uint32_t modelId = *modelIdPtr;
    AicpuMonitor::GetInstance().SetModelEndTime(modelId);

    return HwTsKernelCommon::ProcessEndGraph(modelId);
}

int32_t RecordNotifyTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    const auto info =
        PtrToPtr<void, TsAicpuNotify>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (info == nullptr) {
        aicpusd_err("ModelRecord taskInfo paramBase is null, kernelType[%u].",
                    tsKernelInfo.kernelType);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    aicpusd_info("Begin to process ts notify[%u] event", info->notify_id);
    bool hasWait = false;
    uint32_t waitStreamId = INVALID_NUMBER;
    // if has wait, set hasWait true and set waitStreamId, or else save notify come.
    EventWaitManager::NotifyWaitManager().Event(static_cast<size_t>(info->notify_id), hasWait, waitStreamId);
    if (!hasWait) {
        aicpusd_info("End to process ts notify[%u] event, but no stream is waiting", info->notify_id);
        return AICPU_SCHEDULE_OK;
    }

    uint32_t modelId = 0U;
    auto ret = ModelStreamManager::GetInstance().GetStreamModelId(waitStreamId, modelId);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("ModelRecord[%u] need active stream[%u] but find modelId failed.",
                    info->notify_id, waitStreamId);
        return ret;
    }

    // use event to avoid pending ts response
    AICPUSubEventInfo aicpuSubEventInfo = {};
    aicpuSubEventInfo.modelId = modelId;
    aicpuSubEventInfo.para.streamInfo.streamId = waitStreamId;
    ret = AicpuMsgSend::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, const char_t>(&aicpuSubEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
        AICPU_SUB_EVENT_RECOVERY_STREAM,
        CP_DEFAULT_GROUP_ID,
        false);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to process ts notify[%u] event, ret[%d].", info->notify_id, ret);
        return ret;
    }

    aicpusd_info("End to process ts notify[%u] event, ret[%d]", info->notify_id, ret);
    return AICPU_SCHEDULE_OK;
}

int32_t ActiveEntryStreamTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    const auto streamIdPtr =
        PtrToPtr<void, uint32_t>(ValueToPtr(tsKernelInfo.kernelBase.cceKernel.paramBase));
    if (streamIdPtr == nullptr) {
        aicpusd_err("ModelActiveEntryStream taskInfo paramBase is null, kernelType[%u].",
                    tsKernelInfo.kernelType);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    aicpusd_info("Begin to process ts active stream[%u] event.", *streamIdPtr);
    uint32_t modelId = 0U;
    auto ret = ModelStreamManager::GetInstance().GetStreamModelId(*streamIdPtr, modelId);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("ActiveEntryStream need active stream[%u] but find modelId failed.", *streamIdPtr);
        return ret;
    }

    AICPUSubEventInfo aicpuSubEventInfo = {};
    aicpuSubEventInfo.modelId = modelId;
    aicpuSubEventInfo.para.streamInfo.streamId = *streamIdPtr;
    ret = AicpuMsgSend::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, const char_t>(&aicpuSubEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)),
        AICPU_SUB_EVENT_ACTIVE_STREAM,
        CP_DEFAULT_GROUP_ID,
        false);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Failed to process ts active stream[%u] event, ret[%d].", *streamIdPtr, ret);
        return ret;
    }
    aicpusd_info("End to process ts active stream[%u] event, ret[%d].", *streamIdPtr, ret);
    return AICPU_SCHEDULE_OK;
}

int32_t ModelStopTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_run_info("Begin to process ts kernel ModelStop event.");
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    const auto cfg = PtrToPtr<void, ReDeployConfig>(ValueToPtr(kernel.paramBase));
    const uint32_t modelIdNum = cfg->modelIdNum;
    const uint32_t *const modelIds = PtrToPtr<void, uint32_t>(ValueToPtr(cfg->modelIdsAddr));
    if ((modelIdNum != 0U) && (modelIds == nullptr)) {
        aicpusd_err("TsKernelModelStop modelIds is null");
        return AICPU_SCHEDULE_FAIL;
    }

    for (uint32_t i = 0U; i < modelIdNum; ++i) {
        const int32_t ret = AicpuScheduleInterface::GetInstance().Stop(modelIds[i]);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Stop model[%u] failed, ret[%d].", modelIds[i], ret);
            return AICPU_SCHEDULE_FAIL;
        }
        aicpusd_info("Stop model[%u] success", modelIds[i]);
    }

    aicpusd_run_info("Finish to process ts kernel ModelStop event, [%u] model had been processed.", modelIdNum);
    return AICPU_SCHEDULE_OK;
}

int32_t ModelClearAndRestartTsKernel::Compute(const aicpu::HwtsTsKernel &tsKernelInfo)
{
    aicpusd_run_info("Begin to process ts kernel ModelClearInputAndRestart event.");
    const aicpu::HwtsCceKernel &kernel = tsKernelInfo.kernelBase.cceKernel;
    const auto cfg = PtrToPtr<void, ReDeployConfig>(ValueToPtr(kernel.paramBase));
    const uint32_t modelIdNum = cfg->modelIdNum;
    const uint32_t *const modelIds = PtrToPtr<void, uint32_t>(ValueToPtr(cfg->modelIdsAddr));
    if ((modelIdNum != 0U) && (modelIds == nullptr)) {
        aicpusd_err("TsKernelModelClearInputAndRestart modelIds is null");
        return AICPU_SCHEDULE_FAIL;
    }

    for (uint32_t i = 0U; i < modelIdNum; ++i) {
        int32_t ret = AicpuScheduleInterface::GetInstance().ClearInput(modelIds[i]);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("ClearInput model[%u] failed, ret[%d].", modelIds[i], ret);
            return AICPU_SCHEDULE_FAIL;
        }
        aicpusd_info("ClearInput model[%u] success", modelIds[i]);

        ret = AicpuScheduleInterface::GetInstance().Restart(modelIds[i]);
        if (ret != AICPU_SCHEDULE_OK) {
            aicpusd_err("Restart model[%u] failed, ret[%d].", modelIds[i], ret);
            return AICPU_SCHEDULE_FAIL;
        }
        aicpusd_info("Restart model[%u] success", modelIds[i]);
    }

    aicpusd_run_info("Finish to process ts kernel ModelClearInputAndRestart event, [%u] model had been processed.",
        modelIdNum);
    return AICPU_SCHEDULE_OK;
}

REGISTER_HWTS_KERNEL(KERNEL_END_GRAPH, EndGraphTsKernel);
REGISTER_HWTS_KERNEL(RECORD_NOTIFY, RecordNotifyTsKernel);
REGISTER_HWTS_KERNEL(ACTIVE_ENTRY_STREAM, ActiveEntryStreamTsKernel);
REGISTER_HWTS_KERNEL(MODEL_STOP, ModelStopTsKernel);
REGISTER_HWTS_KERNEL(MODEL_CLEAR_RESTART, ModelClearAndRestartTsKernel);
}  // namespace AicpuSchedule