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
    if (dev != nullptr) {
        TaskInfo *taskInfo = GetTaskInfo(dev, streamId, pos);
        COND_RETURN_ERROR((taskInfo == nullptr),
            RT_ERROR_TASK_NULL,
            "Get task failed, stream_id=%u, task_id=%u.", streamId, pos);
        COND_RETURN_ERROR((taskInfo->type != TS_TASK_TYPE_DAVID_EVENT_RECORD),
            RT_ERROR_STREAM_UNJOINED,
            "The last task type is not event record, stream_id=%u, task_id=%u.",
            streamId, pos);
        eventPtr = taskInfo->u.davidEventRecordTaskInfo.event;
        cntInfo.cntValue = taskInfo->u.davidEventRecordTaskInfo.countValue;
        cntInfo.eventId = taskInfo->u.davidEventRecordTaskInfo.eventId;
        return RT_ERROR_NONE;
    }
    return RT_ERROR_DEVICE_NULL;
}

bool IsCaptureEventWaitNonOp(const Stream * const stm, Event * const evt)
{
    bool isNonOp = false;
    int32_t eventId = INVALID_EVENT_ID;
    Event * const captureEvt = evt->GetCaptureEvent();

    if (captureEvt == nullptr) {
        isNonOp = (!(evt->WaitSendCheck(stm, eventId)));
    } else {  // 如果event是newmode的话，先下wait返回成功
        isNonOp = ((evt->IsNewMode()) && ((!captureEvt->HasRecord()) || (captureEvt->EventId_() == INVALID_EVENT_ID)));
    }

    if (isNonOp) {
        RT_LOG(RT_LOG_INFO, "No-op wait, stream_id=%d, event_id=%d.",
            stm->Id_(), ((captureEvt != nullptr) ? captureEvt->EventId_() : evt->EventId_()));
    }
    return isNonOp;
}

rtError_t ResetCaptureEventsProc(const CaptureModel * const captureModel, Stream * const stm)
{
    rtError_t error;
    Event *event = nullptr;
    bool flag = false;
    for (Event * const evt : captureModel->GetCaptureEvent()) {
        COND_RETURN_ERROR((!(evt->HasRecord())),
            RT_ERROR_CAPTURE_DEPENDENCY,
            "the capture event has not been recorded, stream_id=%d, event_id=%d.",
            stm->Id_(), evt->EventId_());

        /* capture event的flag为RT_EVENT_WITH_FLAG或RT_EVENT_DEFAULT */
        if (evt->GetEventFlag() == RT_EVENT_DEFAULT) {
            event = evt;
            flag = true;
            continue;
        }

        error = EvtReset(evt, stm);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Capture stream reset event failed, stream_id=%d, error=%d.",
            stm->Id_(), error);
    }

    if (flag) {
        int32_t eventId = MAX_INT32_NUM;
        for (Stream * const stream : captureModel->StreamList_()) {
            stream->GetCntNotifyId(eventId);
            if (eventId != MAX_INT32_NUM) {
                event->SetEventId(eventId);
                error = EvtReset(event, stm);
                COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
                "Capture stream reset event failed, capture_stream_id=%d, error=%d.", stream->Id_(), error);
            }
        }
    }

    return RT_ERROR_NONE;
}

bool IsCaptureWaitExist(const Event * const evt, CaptureCntNotify cntInfo)
{
    if (!evt->IsCaptureStreamWaited()) {
        return false;
    }
    /* capture event flag为RT_EVENT_DEFAULT或是RT_EVENT_DDSYNC_NS，仅RT_EVENT_DEFAULT场景需要判断 */
    if (evt->GetEventFlag() != RT_EVENT_DEFAULT) {
        return true;
    }

    DavidEvent *event = RtPtrToPtr<DavidEvent *>(RtPtrToUnConstPtr<Event *>(evt));
    return event->IsEventIdAndCntValueExist(cntInfo.eventId, cntInfo.cntValue);
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