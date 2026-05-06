/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
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
#include "stars_david.hpp"
#include "ringbuffer_maintain_task.h"
#include "device_error_inner_data.hpp"

namespace cce {
namespace runtime {

#if F_DESC("RingBufferMaintainTask")
void ConstructDavidSqeForRingBufferMaintainTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    RingBufferMaintainTaskInfo * const ringBufMtTsk = &(taskInfo->u.ringBufMtTask);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->res1 = taskInfo->stream->Device_()->GetTsLogToHostFlag();
    sqe->taskType = TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.ringBufferControlInfo.ringbufferPhyAddr = 0UL;
    if (ringBufMtTsk->deleteFlag) {
        sqe->u.ringBufferControlInfo.ringbufferOffset = 0UL;
        sqe->u.ringBufferControlInfo.totalLen = 0U;
        sqe->u.ringBufferControlInfo.ringbufferDelFlag = RINGBUFFER_NEED_DEL;
        PrintDavidSqe(davidSqe, "RingBufferMaintain");
        RT_LOG(RT_LOG_INFO, "RingBufferMaintainTask, device_id=%u, stream_id=%d, task_id=%hu",
            taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
        return;
    }

    uint64_t offset = RtPtrToValue(ringBufMtTsk->deviceRingBufferAddr);
    sqe->u.ringBufferControlInfo.ringbufferOffset = offset;
    sqe->u.ringBufferControlInfo.totalLen = ringBufMtTsk->bufferLen;
    sqe->u.ringBufferControlInfo.ringbufferDelFlag = 0U;
    sqe->u.ringBufferControlInfo.elementSize = RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID;

    PrintDavidSqe(davidSqe, "RingBufferCreate");
    RT_LOG(RT_LOG_INFO, "RingBufferCreate, device_id=%u, stream_id=%d, task_id=%hu,"
        " offset=%#" PRIx64 ", elementSize=%u.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, offset,
        sqe->u.ringBufferControlInfo.elementSize);
}

#endif

}  // namespace runtime
}  // namespace cce
