/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "stars_cond_isa_helper.hpp"
#include "cond_op_stream_task.h"
#include "task_manager.h"
#include "aclgraph_cond_task.h"

namespace cce {
namespace runtime {

void ConstructDavidSqeForStreamLabelSwitchByIndexTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &fnCallSqe = davidSqe->fuctionCallSqe;
    StmLabelSwitchByIdxTaskInfo * const stmLblSwiByIdx = &(taskInfo->u.stmLabelSwitchIdxTask);
    fnCallSqe.header.type = RT_DAVID_SQE_TYPE_COND;
    fnCallSqe.condsSubType = CONDS_SUB_TYPE_LABEL_SWITCH_BY_INDEX;
    fnCallSqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    fnCallSqe.sqeLength = 0U;
    fnCallSqe.csc = 1U;

    const uint64_t funcAddr = RtPtrToValue(stmLblSwiByIdx->funcCallSvmMem);
    constexpr uint64_t funcCallSize = static_cast<uint64_t>(sizeof(rtStarsLabelSwitchByIndexFc_t));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), fnCallSqe);

    PrintDavidSqe(davidSqe, "StreamLabelSwitchByIndexTask");
    RT_LOG(RT_LOG_INFO, "StreamLabelSwitchByIndex, deviceId=%u, streamId=%d, taskId=%hu",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
}

void ConstructDavidSqeForStreamSwitchTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    UNUSED(sqeInfo);
    Stream * const stm = taskInfo->stream;
    StreamSwitchTaskInfo * const streamSwitchTask = &(taskInfo->u.streamswitchTask);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &fnCallSqe = davidSqe->fuctionCallSqe;

    fnCallSqe.header.type = RT_DAVID_SQE_TYPE_COND;
    if (streamSwitchTask->isCondEx) {
        fnCallSqe.condsSubType = CONDS_SUB_TYPE_STREAM_SWITCH_EX;
    } else {
        fnCallSqe.condsSubType = CONDS_SUB_TYPE_STREAM_SWITCH;
    }

    fnCallSqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    fnCallSqe.sqeLength = 0U;
    fnCallSqe.csc = 1U;

    const uint64_t funcAddr = RtPtrToValue(streamSwitchTask->funcCallSvmMem);

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (streamSwitchTask->funCallMemSize / 4UL), fnCallSqe);

    PrintDavidSqe(davidSqe, "StreamSwitchTask");
    RT_LOG(RT_LOG_INFO, "StreamSwitchTask, deviceId=%u, streamId=%d, taskId=%hu, trueStreamId=%u.",
        stm->Device_()->Id_(), stm->Id_(), taskInfo->id, streamSwitchTask->trueStreamId);
    return;
}

static bool CondOpStreamTaskRegister()
{
    TaskFuncSingle streamSwitchFuncs = {
        .toCommandFunc = &ToCommandBodyForStreamSwitchTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StreamSwitchTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStreamSwitchTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle streamSwitchNFuncs = {
        .toCommandFunc = &ToCommandBodyForStreamSwitchNTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle streamLabelSwitchByIndexFuncs = {
        .toCommandFunc = &ToCmdBodyForStreamLabelSwitchByIndexTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StreamLabelSwitchByIndexTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStreamLabelSwitchByIndexTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle streamLabelGotoFuncs = {
        .toCommandFunc = &ToCmdBodyForStreamLabelGotoTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_SWITCH, streamSwitchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_SWITCH_N, streamSwitchNFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, streamLabelSwitchByIndexFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_LABEL_GOTO, streamLabelGotoFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_STREAM_SWITCH, &ConstructDavidSqeForStreamSwitchTask);
    RegDavidSqeFunc(TS_TASK_TYPE_STREAM_SWITCH_N, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_STREAM_LABEL_SWITCH_BY_INDEX, &ConstructDavidSqeForStreamLabelSwitchByIndexTask);
    RegDavidSqeFunc(TS_TASK_TYPE_STREAM_LABEL_GOTO, &ConstructDavidSqeBase);
    return true;
}

static bool g_condOpStreamTaskRegister = CondOpStreamTaskRegister();

void Construct1stDavidSqeForCaptureConditionTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe)
{
    // 构造第1个David SQE：条件算子，判断条件变量值并跳转执行子模型
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;
    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.condsSubType = CONDS_SUB_TYPE_CAPTURE_MODEL_COND;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;
    uint64_t funcAddr = RtPtrToValue(condTaskInfo->funcCallSvmMem);
    ConstructFunctionCallInstr(funcAddr, (condTaskInfo->funCallMemSize / 4UL), sqe);
    PrintDavidSqe(davidSqe, "CaptureConditionTask[0]:CondFirst");
}

void Construct2ndDavidSqeForCaptureConditionTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe)
{
    // 构造第2个David SQE：NotifyWait，等待子模型执行完成的notify信号
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    RtDavidStarsNotifySqe &notifySqe = davidSqe->notifySqe;
    notifySqe.header.type = RT_DAVID_SQE_TYPE_NOTIFY_WAIT;
    notifySqe.kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    notifySqe.notifyId = condTaskInfo->notifyId;
    notifySqe.timeout = condTaskInfo->notifyTimeout;
    notifySqe.cntFlag = false;
    notifySqe.clrFlag = true;
    notifySqe.waitModeBit = 0U;
    notifySqe.recordModeBit = 0U;
    notifySqe.cntValue = 0U;
    notifySqe.subType = NOTIFY_SUB_TYPE_SINGLE_NOTIFY_WAIT;
    PrintDavidSqe(davidSqe, "CaptureConditionTask[1]:NotifyWait");
}

void Construct3rdDavidSqeForCaptureConditionTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe)
{
    // 构造第3个David SQE：JumpBack（仅while类型），条件成立时跳回循环起始位置重新执行
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;

    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    RtStarsCaptureWhileCondJumpBackFc fc = {};
    const uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsCaptureWhileCondJumpBackFc));
    ConstructCaptureConditionJumpBackFc(taskInfo, fc);

    rtError_t ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(condTaskInfo->jumpBackFuncCallSvmMem,
        condTaskInfo->jumpBackFunCallMemSize, &fc, funcCallSize, RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        sqe.header.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Failed to call MemCopySync to copy function call mem. dest=%p, dest_max=%lu, count=%lu, retCode=%#x.",
            condTaskInfo->jumpBackFuncCallSvmMem, condTaskInfo->jumpBackFunCallMemSize, funcCallSize,
            static_cast<uint32_t>(ret));
        return;
    }

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.condsSubType = CONDS_SUB_TYPE_CAPTURE_MODEL_COND_JUMPBACK;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.sqeLength = 0U;
    sqe.csc = 1U;
    const uint64_t funcAddr = RtPtrToValue(condTaskInfo->jumpBackFuncCallSvmMem);
    ConstructFunctionCallInstr(funcAddr, (condTaskInfo->jumpBackFunCallMemSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "CaptureConditionTaskJumpBackDavid");
    RT_LOG(RT_LOG_INFO, "CaptureConditionTaskJumpBackDavid, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn);
}

void ConstructDavidSqeForCaptureConditionTask(TaskInfo * const taskInfo, void *const sqe, const TaskSqeInfo &sqeInfo)
{
    UNUSED(sqeInfo);
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    constexpr uint8_t CONDITION_SQE_INDEX_1 = 1U;
    constexpr uint8_t CONDITION_SQE_INDEX_2 = 2U;

    Construct1stDavidSqeForCaptureConditionTask(taskInfo, &davidSqe[0]);
    Construct2ndDavidSqeForCaptureConditionTask(taskInfo, &davidSqe[CONDITION_SQE_INDEX_1]);

    CaptureConditionTaskInfo *condTaskInfo = &(taskInfo->u.captureConditionTask);
    if (condTaskInfo->condHandle->GetCondType() == RT_COND_TASK_TYPE_WHILE) {
        Construct3rdDavidSqeForCaptureConditionTask(taskInfo, &davidSqe[CONDITION_SQE_INDEX_2]);
    }
}

}  // namespace runtime
}  // namespace cce
