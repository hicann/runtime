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
#include "stream_task.h"
#include "task_manager.h"

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
        "sqe_task_id=%u, geOpTag=%u.", taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, taskInfo->taskSn, stmTagSetTsk->targetStm->Id_(), sqe->header.taskId,
        stmTagSetTsk->geOpTag);
}

void ConstructDavidSqeForCallbackLaunchTask(TaskInfo * const taskInfo, rtDavidSqe_t *const command,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidPlaceHolderSqe *const sqe = &(command->phSqe);
    Stream * const stm = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->header.preP = 1U;
    sqe->taskType = TS_TASK_TYPE_HOSTFUNC_CALLBACK;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    /* word4-5 */
    sqe->u.callBackInfo.cbCqId = static_cast<uint16_t>(stm->GetCbRptCqid());
    sqe->u.callBackInfo.cbGroupId = static_cast<uint16_t>(stm->GetCbGrpId());
    sqe->u.callBackInfo.devId = static_cast<uint16_t>(stm->Device_()->Id_());
    sqe->u.callBackInfo.streamId = static_cast<uint16_t>(stm->Id_());

    /* word6-7 */
    sqe->u.callBackInfo.notifyId = static_cast<uint32_t>(taskInfo->u.callbackLaunchTask.eventId);
    sqe->u.callBackInfo.taskId = taskInfo->id;  //  send taskId callback cqe
    sqe->u.callBackInfo.isBlock = taskInfo->u.callbackLaunchTask.isBlock;

    sqe->u.callBackInfo.isOnline = stm->Device_()->Driver_()->GetRunMode() == RT_RUN_MODE_OFFLINE ? 0U : 1U;
    sqe->u.callBackInfo.res0 = 0U;
    sqe->u.callBackInfo.res1 = 0U;

    /* word8-11 */
    uint64_t addr = RtPtrToValue(taskInfo->u.callbackLaunchTask.callBackFunc);
    sqe->u.callBackInfo.hostfuncAddrLow = static_cast<uint32_t>(addr);
    sqe->u.callBackInfo.hostfuncAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue(taskInfo->u.callbackLaunchTask.fnData);
    sqe->u.callBackInfo.fndataLow = static_cast<uint32_t>(addr);
    sqe->u.callBackInfo.fndataHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    /* word12-13 */
    sqe->u.callBackInfo.res2 = 0U;
    sqe->u.callBackInfo.res3 = 0U;

    /* word14 */
    sqe->u.callBackInfo.subTopicId = 0U;
    sqe->u.callBackInfo.topicId = 26U;     // EVENT_TS_CALLBACK_MSG
    sqe->u.callBackInfo.groupId = 11U;     // 11U, drv defined
    sqe->u.callBackInfo.usrDataLen = 32U; // word 4 to word 11
    /* word15 */
    sqe->u.callBackInfo.destPid = 0U;

    PrintDavidSqe(command, "CallbackLaunch");
    RT_LOG(RT_LOG_INFO, "CallbackLaunch, stream_id=%hu, task_id=%hu, notify_id=%hu, isBlock=%hu, pid=%u",
        sqe->u.callBackInfo.streamId, taskInfo->id, sqe->u.callBackInfo.notifyId, sqe->u.callBackInfo.isBlock,
        sqe->u.callBackInfo.destPid);
}

static bool StreamTaskRegister()
{
    TaskFuncSingle createStreamFuncs = {
        .toCommandFunc = &ToCommandBodyForCreateStreamTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle streamActiveFuncs = {
        .toCommandFunc = &ToCommandBodyForStreamActiveTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &StreamActiveTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForStreamActiveTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle activeAicpuStreamFuncs = {
        .toCommandFunc = &ToCmdBodyForActiveAicpuStreamTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle callbackLaunchFuncs = {
        .toCommandFunc = &ToCmdBodyForCallbackLaunchTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle overflowSwitchFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle streamTagFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle streamModeFuncs = {
        .toCommandFunc = &ToCmdBodyForSetStreamModeTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle sqLockUnlockFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle flipFuncs = {
        .toCommandFunc = &ToCmdBodyForFlipTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle sqeUpdateFuncs = {
        .toCommandFunc = &ToCommandBodyForSqeUpdateTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (auto chip : chips) {
        (void)RegTaskFunc(chip, TS_TASK_TYPE_CREATE_STREAM, createStreamFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_STREAM_ACTIVE, streamActiveFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_ACTIVE_AICPU_STREAM, activeAicpuStreamFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_HOSTFUNC_CALLBACK, callbackLaunchFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_SET_OVERFLOW_SWITCH, overflowSwitchFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, streamTagFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_SET_STREAM_MODE, streamModeFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK, sqLockUnlockFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_FLIP, flipFuncs);
        (void)RegTaskFunc(chip, TS_TASK_TYPE_TASK_SQE_UPDATE, sqeUpdateFuncs);
    }

    (void)RegDavidSqeFunc(TS_TASK_TYPE_CREATE_STREAM, &ConstructDavidSqeBase);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_STREAM_ACTIVE, &ConstructDavidSqeForStreamActiveTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_ACTIVE_AICPU_STREAM, &ConstructDavidSqeBase);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_HOSTFUNC_CALLBACK, &ConstructDavidSqeForCallbackLaunchTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_SET_OVERFLOW_SWITCH, &ConstructDavidSqeForOverflowSwitchSetTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, &ConstructDavidSqeForStreamTagSetTask);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_SET_STREAM_MODE, &ConstructDavidSqeBase);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK, &ConstructDavidSqeBase);
    (void)RegDavidSqeFunc(TS_TASK_TYPE_FLIP, &ConstructDavidSqeBase);
    return true;
}

static bool g_streamTaskRegister = StreamTaskRegister();
}  // namespace runtime
}  // namespace cce
