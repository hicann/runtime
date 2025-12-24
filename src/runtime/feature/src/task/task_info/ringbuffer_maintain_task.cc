/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "ringbuffer_maintain_task.h"

namespace cce {
namespace runtime {

#if F_DESC("RingBufferMaintainTask")

rtError_t RingBufferMaintainTaskInit(TaskInfo *taskInfo, const void *const addr, const bool delFlag, const uint32_t len)
{
    if (addr == nullptr) {
        return RT_ERROR_DRV_MEMORY;
    }

    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "DEVICE_RINGBUFFER_CONTROL";
    taskInfo->type = TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL;

    RingBufferMaintainTaskInfo *ringBufMtTsk = &taskInfo->u.ringBufMtTask;
    ringBufMtTsk->deviceRingBufferAddr = RtPtrToUnConstPtr<void *, const void *>(addr);
    ringBufMtTsk->deleteFlag = delFlag;
    ringBufMtTsk->bufferLen = len;
    RT_LOG(RT_LOG_DEBUG, "Success to create device ringbuffer task");
    return RT_ERROR_NONE;
}

void ToCmdBodyForRingBufferMaintainTask(TaskInfo* taskInfo, rtCommand_t *const command)
{
    RingBufferMaintainTaskInfo *ringBufMtTsk = &taskInfo->u.ringBufMtTask;
    uint64_t offset = 0UL;

    command->u.ringBufferToDeviceTask.ringBufferPhyAddr = 0UL;
    if (ringBufMtTsk->deleteFlag) {
        command->u.ringBufferToDeviceTask.ringBufferOffset = 0UL;
        command->u.ringBufferToDeviceTask.totalLen = 0U;
        command->u.ringBufferToDeviceTask.ringBufferDelFlag = RINGBUFFER_NEED_DEL;
        return;
    }

    const rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToValue<void *>(ringBufMtTsk->deviceRingBufferAddr), &offset);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "RingBufferMaintainTask address error=%d", error);

    RT_LOG(RT_LOG_INFO, "RingBufferMaintainTask offset=%#" PRIx64, offset);

    command->u.ringBufferToDeviceTask.ringBufferOffset = offset;
    command->u.ringBufferToDeviceTask.totalLen = ringBufMtTsk->bufferLen;
    command->u.ringBufferToDeviceTask.ringBufferDelFlag = 0U;
}

void ConstructSqeForRingBufferMaintainTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    uint64_t offset = 0UL;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    RingBufferMaintainTaskInfo *ringBufMtTsk = &taskInfo->u.ringBufMtTask;

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.ring_buffer_control_info.ringbuffer_phyAddr = 0UL;
    if (ringBufMtTsk->deleteFlag) {
        sqe->u.ring_buffer_control_info.ringbuffer_offset = 0UL;
        sqe->u.ring_buffer_control_info.total_len = 0U;
        sqe->u.ring_buffer_control_info.ringbuffer_del_flag = RINGBUFFER_NEED_DEL;
        PrintSqe(command, "RingBufferMaintain");
        RT_LOG(RT_LOG_INFO, "RingBufferMaintainTask stream_id:%d, task_id:%hu", taskInfo->stream->Id_(), taskInfo->id);
        return;
    }

    const rtError_t error = taskInfo->stream->Device_()->Driver_()->MemAddressTranslate(
        static_cast<int32_t>(taskInfo->stream->Device_()->Id_()),
        RtPtrToValue<void *>(ringBufMtTsk->deviceRingBufferAddr), &offset);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "profTask address error=%d", error);

    sqe->u.ring_buffer_control_info.ringbuffer_offset = offset;
    sqe->u.ring_buffer_control_info.total_len = ringBufMtTsk->bufferLen;
    sqe->u.ring_buffer_control_info.ringbuffer_del_flag = 0U;

    PrintSqe(command, "RingBufferMaintain");
    RT_LOG(RT_LOG_INFO, "RingBufferMaintainTask stream_id=%d, task_id=%u, offset=%#" PRIx64,
        taskInfo->stream->Id_(), static_cast<uint32_t>(taskInfo->id), offset);
}

#endif

}  // namespace runtime
}  // namespace cce