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
#include "task_manager.h"
#include "device_error_info.hpp"

namespace cce {
namespace runtime {

#if F_DESC("RingBufferMaintainTask")
static void ConstructDavidSqeForRingBufferMaintainTask(TaskInfo * const taskInfo, void *const sqe,
    const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe *const phSqe = &(davidSqe->phSqe);
    RingBufferMaintainTaskInfo * const ringBufMtTsk = &(taskInfo->u.ringBufMtTask);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->res1 = taskInfo->stream->Device_()->GetTsLogToHostFlag();
    phSqe->taskType = TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    phSqe->u.ringBufferControlInfo.ringbufferPhyAddr = 0UL;
    if (ringBufMtTsk->deleteFlag) {
        phSqe->u.ringBufferControlInfo.ringbufferOffset = 0UL;
        phSqe->u.ringBufferControlInfo.totalLen = 0U;
        phSqe->u.ringBufferControlInfo.ringbufferDelFlag = RINGBUFFER_NEED_DEL;
        PrintDavidSqe(davidSqe, "RingBufferMaintain");
        RT_LOG(RT_LOG_INFO, "RingBufferMaintainTask, device_id=%u, stream_id=%d, task_id=%hu",
            taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
        return;
    }

    const uint64_t offset = RtPtrToValue(ringBufMtTsk->deviceRingBufferAddr);
    phSqe->u.ringBufferControlInfo.ringbufferOffset = offset;
    phSqe->u.ringBufferControlInfo.totalLen = ringBufMtTsk->bufferLen;
    phSqe->u.ringBufferControlInfo.ringbufferDelFlag = 0U;
    phSqe->u.ringBufferControlInfo.elementSize = RINGBUFFER_EXT_ONE_ELEMENT_LENGTH_ON_DAVID;

    PrintDavidSqe(davidSqe, "RingBufferCreate");
    RT_LOG(RT_LOG_INFO, "RingBufferCreate, device_id=%u, stream_id=%d, task_id=%hu,"
        " offset=%#" PRIx64 ", elementSize=%u.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, offset,
        phSqe->u.ringBufferControlInfo.elementSize);
}

#endif

static bool RingBufferMaintainTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = &ToCmdBodyForRingBufferMaintainTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto &chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_DEVICE_RINGBUFFER_CONTROL, &ConstructDavidSqeForRingBufferMaintainTask);
    return true;
}

static bool g_ringBufferMaintainTaskRegister = RingBufferMaintainTaskRegister();

}  // namespace runtime
}  // namespace cce
