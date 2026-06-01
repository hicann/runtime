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
#include "task_info_v100.h"
#include "cond_op_stream_task.h"
#include "stars_cond_isa_helper.hpp"
#include "task_manager.h"

namespace cce {
namespace runtime {

#if F_DESC("StreamSwitchTask")
void ConstructSqeForStreamSwitchTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stm = taskInfo->stream;
    StreamSwitchTaskInfo* streamSwitchTask = &(taskInfo->u.streamswitchTask);
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    if (streamSwitchTask->isCondEx) {
        sqe.conds_sub_type = CONDS_SUB_TYPE_STREAM_SWITCH_EX;
    } else {
        sqe.conds_sub_type = CONDS_SUB_TYPE_STREAM_SWITCH;
    }

    const uint64_t funcAddr = RtPtrToValue(streamSwitchTask->funcCallSvmMem);

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (streamSwitchTask->funCallMemSize / 4UL), sqe);

    PrintSqe(command, "StreamSwitchTask");
    RT_LOG(RT_LOG_INFO, "StreamSwitchTask current stream_id=%d task_id=%hu true_stream_id_=%u.",
        stm->Id_(), taskInfo->id, streamSwitchTask->trueStreamId);

    return;
}
#endif

#if F_DESC("StreamLabelSwitchByIndexTask")
void ConstructSqeForStreamLabelSwitchByIndexTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    StmLabelSwitchByIdxTaskInfo *stmLblSwiByIdx = &taskInfo->u.stmLabelSwitchIdxTask;

    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.sqeHeader.pre_p = 1U;
    sqe.conds_sub_type = CONDS_SUB_TYPE_LABEL_SWITCH_BY_INDEX;

    const uint64_t funcAddr = RtPtrToValue(stmLblSwiByIdx->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(rtStarsLabelSwitchByIndexFc_t));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "StreamLabelSwitchByIndexTask");
}
#endif

static bool CondOpStreamTaskRegister()
{
    TaskFuncSingle streamSwitchFuncs = {
        .toCommandFunc = &ToCommandBodyForStreamSwitchTask,
        .toSqeFunc = &ConstructSqeForStreamSwitchTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StreamSwitchTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStreamSwitchTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle streamSwitchNFuncs = {
        .toCommandFunc = &ToCommandBodyForStreamSwitchNTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = nullptr,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle streamLabelSwitchByIndexFuncs = {
        .toCommandFunc = &ToCmdBodyForStreamLabelSwitchByIndexTask,
        .toSqeFunc = &ConstructSqeForStreamLabelSwitchByIndexTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StreamLabelSwitchByIndexTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStreamLabelSwitchByIndexTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle streamLabelGotoFuncs = {
        .toCommandFunc = &ToCmdBodyForStreamLabelGotoTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_SWITCH, streamSwitchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_SWITCH_N, streamSwitchNFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, streamLabelSwitchByIndexFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_LABEL_GOTO, streamLabelGotoFuncs);
    }

    return true;
}

static bool g_condOpStreamTaskRegister = CondOpStreamTaskRegister();

}  // namespace runtime
}  // namespace cce
