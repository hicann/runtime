/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "context.hpp"
#include "common_task.h"
#include "task_manager.h"
#include "task_info_v100.h"
#include "stub_task.hpp"

namespace cce {
namespace runtime {
#if F_DESC("StarsCommonTask")
void ConstructSqeForStarsCommonTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    StarsCommonTaskInfo *starsCommTask = &taskInfo->u.starsCommTask;

    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.task_id = taskInfo->id;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.reserved = 0U; // must restore default value
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.ie = RT_STARS_SQE_INT_DIR_NO;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.pre_p = RT_STARS_SQE_INT_DIR_NO;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.post_p =
        ((starsCommTask->flag & RT_KERNEL_DUMPFLAG) != 0U) ? RT_STARS_SQE_INT_DIR_TO_TSCPU : RT_STARS_SQE_INT_DIR_NO;
    starsCommTask->commonStarsSqe.commonSqe.sqeHeader.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();

    const errno_t error = memcpy_s(command, sizeof(rtStarsSqe_t), &starsCommTask->commonStarsSqe.commonSqe,
        sizeof(starsCommTask->commonStarsSqe.commonSqe));
    if (error != EOK) {
        command->commonSqe.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call memcpy_s to copy starsCommTask->commonStarsSqe.commonSqe,"
            " src=%p, dest=%p, dest_max=%zu, count=%zu, retCode=%#x.", &starsCommTask->commonStarsSqe.commonSqe, command,
            sizeof(rtStarsSqe_t), sizeof(starsCommTask->commonStarsSqe.commonSqe), error);
    }
    PrintSqe(command, "StarsCommonTask");
    RT_LOG(RT_LOG_INFO, "StarsCommonTask stream_id:%d,task_id:%hu", taskInfo->stream->Id_(), taskInfo->id);
}
#endif

#if F_DESC("WriteValueTask")
void ConstructSqeForWriteValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    WriteValueTaskInfo *writeValTsk = &taskInfo->u.writeValTask;
    RtStarsWriteValueSqe *evSqe = &(command->writeValueSqe);

    evSqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    evSqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;

    switch (writeValTsk->cqeFlag) {
        case TASK_WR_CQE_DEFAULT:
            evSqe->header.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
            break;
        case TASK_WR_CQE_NEVER:
            evSqe->header.wr_cqe = 0U;
            break;
        default:
            evSqe->header.wr_cqe = 1U;
            break;
    }

    evSqe->header.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    evSqe->header.task_id = taskInfo->id;
    evSqe->va = 1U;  // va only

    evSqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    evSqe->awsize = writeValTsk->awSize;
    evSqe->snoop = 0U;
    evSqe->awcache = 2U;  // 2U: 0010 Normal Non-cacheable Non-bufferable
    evSqe->awprot = 0U;

    evSqe->write_addr_low = static_cast<uint32_t>(writeValTsk->addr & MASK_32_BIT);
    evSqe->write_addr_high = static_cast<uint32_t>((writeValTsk->addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    evSqe->res3 = 0U;
    evSqe->res4 = 0U;
    evSqe->res5 = 0U;
    evSqe->res6 = 0U;
    evSqe->res7 = 0U;

    uint32_t *temp = RtPtrToPtr<uint32_t *, uint8_t*>(writeValTsk->value);
    evSqe->write_value_part0 = temp[0U];    // 0: part0
    evSqe->write_value_part1 = temp[1U];    // 1: part1
    evSqe->write_value_part2 = temp[2U];    // 2: part2
    evSqe->write_value_part3 = temp[3U];    // 3: part3
    evSqe->write_value_part4 = temp[4U];    // 4: part4
    evSqe->write_value_part5 = temp[5U];    // 5: part5
    evSqe->write_value_part6 = temp[6U];    // 6: part6
    evSqe->write_value_part7 = temp[7U];    // 7: part7

    PrintSqe(command, "WriteValueTask");
    RT_LOG(RT_LOG_DEBUG, "WriteValueTask streamId=%d, taskId=%hu, addr=%#." PRIx64, taskInfo->stream->Id_(),
        taskInfo->id, writeValTsk->addr);
}
#endif

#if F_DESC("CommonCmdTask")
static void ConstructSqeForStreamClearTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    Stream *const stm = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_COMMON_CMD;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.commonCmdInfo.cmdType = commonCmdTaskInfo->cmdType;
    sqe->u.commonCmdInfo.streamId = commonCmdTaskInfo->streamId;
    sqe->u.commonCmdInfo.step = commonCmdTaskInfo->step;
    PrintSqe(command, "StreamClearTask");
    RT_LOG(RT_LOG_INFO, "Send stream clear task succ,"
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, clear target stream_id=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, commonCmdTaskInfo->streamId);
}

static void ConstructSqeForNotifyResetTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    Stream *const stm = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->rt_streamID = static_cast<uint16_t>(stm->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_COMMON_CMD;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.commonCmdInfo.cmdType = commonCmdTaskInfo->cmdType;
    sqe->u.commonCmdInfo.notifyId = commonCmdTaskInfo->notifyId;
    PrintSqe(command, "NotifyResetTask");
    RT_LOG(RT_LOG_INFO, "Send NotifyReset task succ,"
        "sqe_type=%u, pre_p=%u, stream_id=%u, task_id=%u, task_type=%u, reset target notify_id=%u.",
        sqe->type, sqe->pre_p, sqe->rt_streamID, sqe->task_id, sqe->task_type, commonCmdTaskInfo->notifyId);
}

void ConstructSqeForCommonCmdTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    CommonCmdTaskInfo *commonCmdTaskInfo = &(taskInfo->u.commonCmdTask);
    if (commonCmdTaskInfo->cmdType == static_cast<uint16_t>(PhCmdType::CMD_STREAM_CLEAR)) {
        ConstructSqeForStreamClearTask(taskInfo, command);
    } else if (commonCmdTaskInfo->cmdType == static_cast<uint16_t>(PhCmdType::CMD_NOTIFY_RESET)) {
        ConstructSqeForNotifyResetTask(taskInfo, command);
    } else {
        // no operation
    }
}
#endif

static bool CommonTaskRegister()
{
    TaskFuncSingle starsCommonFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForStarsCommonTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StarsCommonTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStarsCommonTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle writeValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForWriteValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle commonCmdFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForCommonCmdTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_STARS_COMMON, starsCommonFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_WRITE_VALUE, writeValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_COMMON_CMD, commonCmdFuncs);
    }

    return true;
}

static bool g_commonTaskRegister = CommonTaskRegister();

}  // namespace runtime
}  // namespace cce
