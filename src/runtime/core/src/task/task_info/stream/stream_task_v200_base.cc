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
#include "stars_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_david.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {

void ConstructDavidSqeForStreamActiveTask(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    StreamActiveTaskInfo * const streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream * const stream = taskInfo->stream;
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.condsSubType = CONDS_SUB_TYPE_STREAM_ACTIVE;

    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;

    const uint64_t funcAddr = RtPtrToValue(streamActiveTask->funcCallSvmMem);
    const uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "StreamActiveTask");
    RT_LOG(RT_LOG_INFO, "StreamActiveTask, deviceId=%u, streamId=%d, taskId=%hu, activeStreamId=%u.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, streamActiveTask->activeStreamId);
}

void ConstructDavidSqeForOverflowSwitchSetTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    OverflowSwitchSetTaskInfo * const overflowSwiSet = &(taskInfo->u.overflowSwitchSetTask);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.streamOverflowSwitchInfo.streamId = static_cast<uint16_t>(overflowSwiSet->targetStm->Id_());
    sqe->u.streamOverflowSwitchInfo.isSwitchOn = overflowSwiSet->switchFlag ? 1U : 0U;

    PrintDavidSqe(davidSqe, "OverflowSwitchSetTask");
    RT_LOG(RT_LOG_INFO, "OverflowSwitchSetTask target, device_id=%u, stream_id=%d, target_stream_id=%d, task_id=%hu,"
        "task_sn=%u, switch %s.", taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), overflowSwiSet->targetStm->Id_(),
        taskInfo->id, taskInfo->taskSn, overflowSwiSet->switchFlag ? "on" : "off");
}

void ConstructDavidSqeForStreamTagSetTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    StreamTagSetTaskInfo * const stmTagSetTsk = &(taskInfo->u.stmTagSetTask);
    RtDavidPlaceHolderSqe * const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_SET_STREAM_GE_OP_TAG;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    sqe->u.streamSetTagInfo.streamId = static_cast<uint16_t>(stmTagSetTsk->targetStm->Id_());
    sqe->u.streamSetTagInfo.geOpTag = stmTagSetTsk->geOpTag;

    PrintDavidSqe(davidSqe, "StreamTagSetTask");
    RT_LOG(RT_LOG_INFO, "StreamTagSetTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, target_stream_id=%d, "
        "sqe_stream_id=%hu, geOpTag=%u.", taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->taskSn, stmTagSetTsk->targetStm->Id_(), sqe->header.rtStreamId,
        stmTagSetTsk->geOpTag);
}

}  // namespace runtime
}  // namespace cce
