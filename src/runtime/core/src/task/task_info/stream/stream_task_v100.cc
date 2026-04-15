/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_cond_isa_helper.hpp"
#include "task_manager.h"
#include "stream_sqcq_manage.hpp"
#include "stream_task.h"
#include "task_info_v100.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {

#if F_DESC("CreateStreamTask")
void SetResultForCreateStreamTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    Stream * const stream = taskInfo->stream;

    if ((stream->Flags() & RT_STREAM_PRIMARY_FIRST_DEFAULT) != 0U) {
        const uint32_t *const tsData = static_cast<const uint32_t *>(data);
        const uint32_t payLoad = *tsData;
        // for create stream task, payLoad(0~11 bit): error code, payLoad(12~31 bit): tsch build version
        const uint32_t tschVersion = static_cast<uint32_t>(payLoad >> 12U);
        Device *const devicePtr = stream->Device_();
        const Stream *const defaultStream = devicePtr->PrimaryStream_();
        COND_RETURN_VOID(defaultStream == nullptr, "default stream is NULL.");
        if (stream->Id_() == defaultStream->Id_()) {
            devicePtr->SetTschVersion(tschVersion);
        }
        RT_LOG(RT_LOG_DEBUG, "CreateStreamTask set result, payLoad=%u.", payLoad);
    }
}
#endif

#if F_DESC("SetSqLockUnlockTask")
// Construct the sq lock or unlock sqe.
void ConstructSqeForSetSqLockUnlockTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 0U;
    sqe->post_p = 0U;
    sqe->l2_lock = taskInfo->u.sqLockUnlockTask.sqLock;
    sqe->l2_unlock = taskInfo->u.sqLockUnlockTask.sqUnlock;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    PrintSqe(command, "SetSqLockUnlock");
    RT_LOG(RT_LOG_INFO, "send SetSqLockUnlock succ,"
        "sqe_type=%u,pre_p=%u,stream_id=%u,task_id=%u,task_type=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type);

    return;
}
#endif

#if F_DESC("StreamActiveTask")
void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    StreamActiveTaskInfo *streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream * const stream = taskInfo->stream;
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.conds_sub_type = CONDS_SUB_TYPE_STREAM_ACTIVE;

    const uint64_t funcAddr = RtPtrToValue<void *>(streamActiveTask->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "StreamActiveTask");
    RT_LOG(RT_LOG_INFO, "StreamActiveTask stream_id=%d,task_id=%hu,active_stream_id=%u.",
        stream->Id_(), taskInfo->id, streamActiveTask->activeStreamId);
}

#endif

#if F_DESC("OverflowSwitchSetTask")
void ConstructSqeForOverflowSwitchSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsPhSqe * const sqe = &(command->phSqe);
    OverflowSwitchSetTaskInfo *overflowSwiSet = &taskInfo->u.overflowSwitchSetTask;

    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.stream_overflow_switch_info.streamId = static_cast<uint16_t>(overflowSwiSet->targetStm->Id_());
    sqe->u.stream_overflow_switch_info.isSwitchOn = overflowSwiSet->switchFlag ? 1U : 0U;

    PrintSqe(command, "OverflowSwitchSetTask");
    const std::string switchFlag = overflowSwiSet->switchFlag ? "on" : "off";
    RT_LOG(RT_LOG_INFO, "OverflowSwitchSetTask target stream_id=%d switch %s",
        overflowSwiSet->targetStm->Id_(), switchFlag.c_str());
}
#endif

#if F_DESC("StreamTagSetTask")
void ConstructSqeForStreamTagSetTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    StreamTagSetTaskInfo *stmTagSetTsk = &taskInfo->u.stmTagSetTask;

    RtStarsPhSqe * const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_SET_STREAM_GE_OP_TAG;
    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    sqe->u.stream_set_tag_info.streamId = static_cast<uint16_t>(stmTagSetTsk->targetStm->Id_());
    sqe->u.stream_set_tag_info.geOpTag = stmTagSetTsk->geOpTag;

    PrintSqe(command, "StreamTagSetTask");
    RT_LOG(RT_LOG_INFO, "StreamTagSetTask target stream id=%d, sqe stream id =%hu, geOpTag=%u",
        stmTagSetTsk->targetStm->Id_(), sqe->rt_streamID, stmTagSetTsk->geOpTag);
}
#endif

}  // namespace runtime
}  // namespace cce
