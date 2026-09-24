/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aclgraph_cond_task.h"
#include "runtime_task_manager.h"
#include "stars_cond_isa_helper.hpp"

namespace cce {
namespace runtime {

static void Construct1stSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t* sqe)
{
    // 构造第1个SQE：条件算子，判断条件变量值并跳转执行子模型
    CaptureConditionTaskInfo* condTaskInfo = &(taskInfo->u.captureConditionTask);
    Stream* stm = taskInfo->stream;

    RtStarsFunctionCallSqe& sqe0 = sqe->fuctionCallSqe;
    sqe0.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe0.csc = 1U;
    sqe0.sqeHeader.l1_lock = 0U;
    sqe0.sqeHeader.l1_unlock = 0U;
    sqe0.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe0.sqeHeader.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe0.sqeHeader.block_dim = 0U;
    sqe0.sqeHeader.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe0.sqeHeader.task_id = taskInfo->id;
    sqe0.conds_sub_type = CONDS_SUB_TYPE_CAPTURE_MODEL_COND;
    const uint64_t funcAddr = RtPtrToValue(condTaskInfo->funcCallSvmMem);
    ConstructFunctionCallInstr(funcAddr, (condTaskInfo->funCallMemSize / 4UL), sqe0);
    PrintSqe(sqe, "CaptureConditionTask[0]:CondFirst");
}

void Construct2ndSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t* sqe)
{
    // 构造第2个SQE：NotifyWait，等待子模型执行完成的notify信号
    CaptureConditionTaskInfo* condTaskInfo = &(taskInfo->u.captureConditionTask);
    Stream* stm = taskInfo->stream;

    RtStarsNotifySqe& notifySqe = sqe->notifySqe;
    (void)memset_s(sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    notifySqe.header.type = RT_STARS_SQE_TYPE_NOTIFY_WAIT;
    notifySqe.kernel_credit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    notifySqe.header.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    notifySqe.header.task_id = taskInfo->id;
    notifySqe.notify_id = condTaskInfo->notifyId;
    notifySqe.timeout = condTaskInfo->notifyTimeout;
    PrintSqe(sqe, "CaptureConditionTask[1]:NotifyWait");
}

static void Construct3rdSqeForCaptureConditionTask(TaskInfo* taskInfo, rtStarsSqe_t* sqe)
{
    // 构造第3个SQE：JumpBack（仅while类型），条件成立时跳回循环起始位置重新执行
    Stream* const stm = taskInfo->stream;
    CaptureConditionTaskInfo* condTaskInfo = &(taskInfo->u.captureConditionTask);
    RtStarsCaptureWhileCondJumpBackFc fc = {};
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsCaptureWhileCondJumpBackFc));
    ConstructCaptureConditionJumpBackFc(taskInfo, fc);

    RtStarsFunctionCallSqe& sqe2 = sqe->fuctionCallSqe;
    const rtError_t ret = stm->Device_()->Driver_()->MemCopySync(
        condTaskInfo->jumpBackFuncCallSvmMem, condTaskInfo->jumpBackFunCallMemSize, &fc, funcCallSize,
        RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }

    sqe2.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe2.csc = 1U;
    sqe2.sqeHeader.l1_lock = 0U;
    sqe2.sqeHeader.l1_unlock = 0U;
    sqe2.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe2.sqeHeader.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe2.sqeHeader.block_dim = 0U;
    sqe2.sqeHeader.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe2.sqeHeader.task_id = taskInfo->id;
    sqe2.conds_sub_type = CONDS_SUB_TYPE_CAPTURE_MODEL_COND_JUMPBACK;
    const uint64_t funcAddr = RtPtrToValue(condTaskInfo->jumpBackFuncCallSvmMem);
    ConstructFunctionCallInstr(funcAddr, (condTaskInfo->jumpBackFunCallMemSize / 4UL), sqe2);
    PrintSqe(sqe, "Construct3rdSqeForCaptureConditionTask");
    RT_LOG(
        RT_LOG_INFO, "Construct3rdSqeForCaptureConditionTask current stream_id=%d task_id=%hu.", stm->Id_(),
        taskInfo->id);
}

static void ConstructSqeForCaptureConditionTask(TaskInfo* taskInfo, void* const sqeBuffer, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    rtStarsSqe_t* const command = static_cast<rtStarsSqe_t*>(sqeBuffer);

    Construct1stSqeForCaptureConditionTask(taskInfo, &command[0]);
    Construct2ndSqeForCaptureConditionTask(taskInfo, &command[1]);

    CaptureConditionTaskInfo* condTaskInfo = &(taskInfo->u.captureConditionTask);
    if (condTaskInfo->condHandle->GetCondType() == RT_COND_TASK_TYPE_WHILE) {
        Construct3rdSqeForCaptureConditionTask(taskInfo, &command[2]);
    }
}

static bool AclgraphCondTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForCaptureConditionTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &CaptureConditionTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_CONDITION, funcs);
    }

    return true;
}

static bool g_aclgraphCondTaskRegister = AclgraphCondTaskRegister();

} // namespace runtime
} // namespace cce
