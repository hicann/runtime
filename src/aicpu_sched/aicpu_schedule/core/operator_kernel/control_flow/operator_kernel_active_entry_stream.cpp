/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_active_entry_stream.h"

#include "aicpusd_status.h"
#include "aicpusd_monitor.h"
#include "aicpusd_profiler.h"
#include "aicpusd_msg_send.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_model_statistic.h"
#include "aicpusd_resource_manager.h"
#include "operator_kernel_common.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_ACTIVE_ENTRY_STREAM = "activeEntryStream";
}  // namespace

int32_t OperatorKernelActiveEntryStream::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const auto streamIdPtr = PtrToPtr<void, uint32_t>(ValueToPtr(static_cast<uintptr_t>(kernelTaskInfo.paraBase)));
    if (streamIdPtr == nullptr) {
        aicpusd_err("ModelActiveEntryStream kernelTaskInfo paramBase is null, modelId[%u], streamId[%u], taskId[%u]",
            taskContext.modelId, taskContext.streamId, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }
    return DoCompute(*streamIdPtr, taskContext);
}

int32_t OperatorKernelActiveEntryStream::DoCompute(const uint32_t streamId, const RunContext &taskContext) const
{
    aicpusd_info("Begin to active ModeId[%u] streamId[%u].", taskContext.modelId, streamId);
    uint32_t streamFlag = 0U;
    auto ret = ModelStreamManager::GetInstance().GetStreamFlag(streamId, streamFlag);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Model active stream[%u] is not found, modelId[%u], streamId[%u]", streamId, taskContext.modelId,
            taskContext.streamId);
        return ret;
    }

    const auto model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("Model active entry stream failed by no model found, modelId=%u, streamId=%u",
                    taskContext.modelId, streamId);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    if (((model->GetModelRetCode() != 0) && model->AbnormalEnabled()) ||
        model->GetNullDataFlag()) {
        aicpusd_run_info("Model no need active stream[%u]. modelId[%u], streamId[%u], modelRetCode=%d, nullFlag=%d",
                         streamId, taskContext.modelId, taskContext.streamId, model->GetModelRetCode(),
                         static_cast<int32_t>(model->GetNullDataFlag()));
        return SubmitEndGraph(taskContext.modelId);
    }

    AicpuSdModelStatistic::GetInstance().MarNNModelStartTime(taskContext.modelId);

    if ((streamFlag & AICPU_STREAM_INDEX) != 0U) {
        if (taskContext.executeInline) {
            aicpusd_info("ModelId[%u] switch to RunContext streamId from [%u] to [%u].", taskContext.modelId,
                taskContext.streamId, streamId);
            uint32_t *contextStreamId = const_cast<uint32_t *>(&taskContext.streamId);
            *contextStreamId = streamId;
            return AICPU_SCHEDULE_OK;
        } else {
            aicpusd_info("Other thread execute stream[%u].", streamId);
            AICPUSubEventInfo subEventInfo = {};
            subEventInfo.modelId = taskContext.modelId;
            subEventInfo.para.streamInfo.streamId = streamId;
            ret = OperatorKernelCommon::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo),
                static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_ACTIVE_STREAM);
            return ret;
        }
    } else {
        // call drv interface to write register.
        const uint32_t pid = static_cast<uint32_t>(AicpuDrvManager::GetInstance().GetHostPid());
        const uint32_t tsId = taskContext.modelTsId;
        g_aicpuProfiler.SetTsStreamId(streamId);
        AicpuSqeAdapter aicpuSqeAdapter(FeatureCtrl::GetTsMsgVersion());
        const uint32_t deviceId = AicpuDrvManager::GetInstance().GetDeviceId();
        aicpusd_info("Begin to active drv ts stream, tsId[%u], tsStreamId[%u], modelId[%u], streamId[%u], pid[%u],"
                     "devId[%u].", tsId, streamId, taskContext.modelId, taskContext.streamId, pid, deviceId);
        AicpuSqeAdapter::ActiveStreamInfo activateInfo(static_cast<uint16_t>(streamId), static_cast<uint8_t>(tsId),
                                                       g_aicpuProfiler.GetKernelTrack().procEventStart, deviceId,
                                                       taskContext.modelId);
        aicpuSqeAdapter.AicpuActiveStreamSetMsg(activateInfo);
        model->IncreaseActiveStreamNum();
    }
    AicpuMonitor::GetInstance().SetModelStartTime(taskContext.modelId);
    g_aicpuProfiler.SetActiveStream();
    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelActiveEntryStream::SubmitEndGraph(const uint32_t modelId) const
{
    aicpusd_info("Begin to submit EndGraph. modelId[%u].", modelId);
    AICPUSubEventInfo subEventInfo = {};
    subEventInfo.modelId = modelId;
    subEventInfo.para.endGraphInfo.result = 0;
    const int32_t ret = OperatorKernelCommon::SendAICPUSubEvent(PtrToPtr<AICPUSubEventInfo, char_t>(&subEventInfo),
        static_cast<uint32_t>(sizeof(AICPUSubEventInfo)), AICPU_SUB_EVENT_END_GRAPH);
    return ret;
}

REGISTER_OPERATOR_KERNEL(KERNEL_ACTIVE_ENTRY_STREAM, OperatorKernelActiveEntryStream);
}  // namespace AicpuSchedule