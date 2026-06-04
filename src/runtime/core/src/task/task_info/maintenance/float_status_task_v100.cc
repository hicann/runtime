/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "task_manager.h"
#include "stars_cond_isa_helper.hpp"

namespace cce {
namespace runtime {

static void ConstructSqeForNpuGetFloatStaTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsGetFloatStatusSqe &sqe = command->getFloatStatusSqe;
    NpuGetFloatStatusTaskInfo *npuGetFltSta = &taskInfo->u.npuGetFloatStatusTask;
    Stream *const stm = taskInfo->stream;
    (void)memset_s(&sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    sqe.debugFlag = npuGetFltSta->debugFlag ? 1U : 0U;
    ConstructGetFloatStatusInstr(
        RtPtrToValue<void *>(npuGetFltSta->outputAddrPtr),
        npuGetFltSta->outputSize, sqe);

    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe.sqeHeader.pre_p = 1U;
    sqe.sqeHeader.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe.sqeHeader.wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe.sqeHeader.reserved = 0U;
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.conds_sub_type = CONDS_SUB_TYPE_GET_FLOAT_STATUS;
    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;

    PrintSqe(command, "NpuGetFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "ConstructModelSqe finish, stream_id=%d, task_id=%u, debugFlag=%hhu",
           stm->Id_(), static_cast<uint32_t>(taskInfo->id), sqe.debugFlag);
}

static void ConstructSqeForNpuClrFloatStaTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsPhSqe *const sqe = &(command->phSqe);
    NpuClearFloatStatusTaskInfo *npuClrFltSta = &taskInfo->u.npuClrFloatStatusTask;
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->post_p = 0U;
    sqe->pre_p = 1U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS;

    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.debugStatusInfo.debugFlag = npuClrFltSta->debugFlag ? 1U : 0U;

    PrintSqe(command, "NpuClearFloatStatusTask");
    RT_LOG(RT_LOG_INFO, "stream_id=%d, task_id=%u, debug_flag=%d",
        taskInfo->stream->Id_(), static_cast<uint32_t>(taskInfo->id), npuClrFltSta->debugFlag);
}

static bool FloatStatusTaskRegister()
{
    TaskFuncSingle getFloatStatusFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForNpuGetFloatStaTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle clearFloatStatusFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForNpuClrFloatStaTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_NPU_GET_FLOAT_STATUS, getFloatStatusFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_NPU_CLEAR_FLOAT_STATUS, clearFloatStatusFuncs);
    }

    return true;
}

static bool g_floatStatusTaskRegister = FloatStatusTaskRegister();

} // namespace runtime
} // namespace cce
