/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capture_adapt.hpp"
#include "task_recycle.hpp"
#include "capture_model.hpp"
#include "event_c.hpp"
#include "model_c.hpp"
#include "event_david.hpp"
#include "stream_c.hpp"
#include "thread_local_container.hpp"

namespace cce {
namespace runtime {

bool StreamFlagIsSupportCapture(uint32_t flag)
{
    static constexpr uint32_t flags = RT_STREAM_AICPU | RT_STREAM_FORBIDDEN_DEFAULT | RT_STREAM_CP_PROCESS_USE
        | RT_STREAM_VECTOR_CORE_USE | RT_STREAM_PERSISTENT | RT_STREAM_ACSQ_LOCK;

    if ((flag & flags) != 0U) {
        return false;
    }
    return true;
}

uint32_t GetCaptureStreamFlag()
{
    return RT_STREAM_PERSISTENT;
}

rtError_t GetCaptureEventFromTask(const Device * const dev, uint32_t streamId, uint32_t pos, Event *&eventPtr, CaptureCntNotify &cntInfo)
{
    UNUSED(cntInfo);
    if (dev != nullptr) {
        TaskInfo *taskInfo = GetTaskInfo(dev, streamId, pos);
        COND_RETURN_ERROR((taskInfo == nullptr),
            RT_ERROR_TASK_NULL,
            "Get task failed, stream_id=%u, task_id=%u.", streamId, pos);
        COND_RETURN_ERROR(!((taskInfo->type == TS_TASK_TYPE_DAVID_EVENT_RECORD) || (taskInfo->type ==TS_TASK_TYPE_CAPTURE_RECORD)),
            RT_ERROR_STREAM_UNJOINED,
            "The last task type is not event record, stream_id=%u, task_id=%u.",
            streamId, pos);
        if (taskInfo->type == TS_TASK_TYPE_DAVID_EVENT_RECORD) {
            eventPtr = taskInfo->u.davidEventRecordTaskInfo.event;
        } else {
            eventPtr = taskInfo->u.memWriteValueTask.event;
        }
        return RT_ERROR_NONE;
    }
    return RT_ERROR_DEVICE_NULL;
}

rtError_t ResetCaptureEventsProc(const CaptureModel * const captureModel, Stream * const stm)
{
    rtError_t error;
    for (Event * const evt : captureModel->GetCaptureEvent()) {
        COND_RETURN_ERROR((!(evt->HasRecord())),
            RT_ERROR_CAPTURE_DEPENDENCY,
            "the capture event has not been recorded, stream_id=%d, event_id=%d.",
            stm->Id_(), evt->EventId_());

        if (GlobalContainer::IsEventHardMode()) {
 	        error = EvtReset(evt, stm);
 	    } else {
 	        error = EvtResetSoftwareMode(evt, stm);
        }

        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Capture stream reset event failed, stream_id=%d, error=%d.",
            stm->Id_(), error);
    }

    return RT_ERROR_NONE;
}

TaskInfo* GetStreamTaskInfo(const Device * const dev, uint16_t streamId, uint16_t pos)
{
    if (dev != nullptr) {
        return GetTaskInfo(dev, static_cast<uint32_t>(streamId), static_cast<uint32_t>(pos));
    }
    return nullptr;
}

rtError_t SendNopTask(const Context * const curCtx, Stream * const stm)
{
    UNUSED(curCtx);
    return StreamNopTask(stm);
}

bool TaskTypeIsSupportTaskGroup(const TaskInfo * const task)
{
    if ((task->type == TS_TASK_TYPE_KERNEL_AICORE) || (task->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
        return true;
    }

    /* 如果Fusion子任务不包括aic/aiv任务，不支持 */
    if (task->type == TS_TASK_TYPE_FUSION_KERNEL) {
        const FusionTaskInfo * const fusionTaskInfo = &(task->u.fusionKernelTask);
        if ((fusionTaskInfo->sqeSubType & (1U << RT_FUSION_AIC_BIT_MOVE)) != 0U) {
            return true;
        }
        RT_LOG(RT_LOG_ERROR, "Fusion subtask does not include the aicore task, sqeSubType=0x%x.",
            fusionTaskInfo->sqeSubType);
        return false;
    }
    return false;
}
} // namespace runtime
} // namespace cce