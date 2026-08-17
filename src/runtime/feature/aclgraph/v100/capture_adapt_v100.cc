/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "capture_adapt.hpp"
#include "task_info.hpp"
#include "capture_model.hpp"
#include "thread_local_container.hpp"
#include "error_message_manage.hpp"
#include "context.hpp"
#include "task.hpp"

namespace cce {
namespace runtime {

bool StreamFlagIsSupportCapture(uint32_t flag)
{
    static constexpr uint32_t flags[]{
        RT_STREAM_AICPU, RT_STREAM_FORBIDDEN_DEFAULT, RT_STREAM_CP_PROCESS_USE, RT_STREAM_VECTOR_CORE_USE};

    for (const uint32_t elem : flags) {
        if ((flag & elem) == elem) {
            return false;
        }
    }

    return true;
}

uint32_t GetCaptureStreamFlag() { return RT_STREAM_DEFAULT; }

rtError_t GetCaptureEventFromTask(
    const Device* const dev, uint32_t streamId, uint32_t pos, Event*& eventPtr, CaptureCntNotify& cntInfo)
{
    UNUSED(cntInfo);
    if (dev != nullptr) {
        const TaskInfo* const task =
            dev->GetTaskFactory()->GetTask(static_cast<int32_t>(streamId), static_cast<uint16_t>(pos));
        COND_RETURN_ERROR(
            (task == nullptr), RT_ERROR_TASK_NULL, "Get task failed, stream_id=%u, task_id=%u.", streamId, pos);
        COND_RETURN_AND_MSG_OUTER(
            !((task->type == TS_TASK_TYPE_EVENT_RECORD) || (task->type == TS_TASK_TYPE_CAPTURE_RECORD)),
            RT_ERROR_STREAM_UNJOINED, ErrorCode::EE1017, "Capture model validity check", "capture model",
            RtFmtMsg(
                "In the cross-stream capture scenario, the last task (task_id=%u) on the sub stream (stream_id=%u) is "
                "not an event record task. Call aclrtRecordEvent on the sub stream to deliver an event record task",
                pos, streamId));
        if (task->type == TS_TASK_TYPE_EVENT_RECORD) {
            eventPtr = task->u.eventRecordTaskInfo.event;
        } else {
            eventPtr = task->u.memWriteValueTask.event;
        }
        return RT_ERROR_NONE;
    }
    return RT_ERROR_DEVICE_NULL;
}

rtError_t ResetCaptureEventsProc(const CaptureModel* const captureModel, Stream* const stm)
{
    for (Event* const evt : captureModel->GetCaptureEvent()) {
        COND_RETURN_ERROR_MSG_INNER(
            (!(evt->HasRecord())), RT_ERROR_CAPTURE_DEPENDENCY,
            "The capture event has not been recorded, stream_id=%d, event_id=%d.", stm->Id_(), evt->EventId_());
        const rtError_t error = evt->Reset(stm);
        COND_RETURN_ERROR(
            (error != RT_ERROR_NONE), error, "Capture stream reset event failed, stream_id=%d, error=%d.", stm->Id_(),
            error);
    }
    return RT_ERROR_NONE;
}

rtError_t SendNopTask(const Context* const curCtx, Stream* const stm) { return curCtx->NopTask(stm); }

bool TaskTypeIsSupportTaskGroup(const TaskInfo* const task)
{
    return ((task->type == TS_TASK_TYPE_KERNEL_AICORE) || (task->type == TS_TASK_TYPE_KERNEL_AIVEC));
}
} // namespace runtime
} // namespace cce
