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
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

void ConstructDavidSqeForStreamActiveTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    StreamActiveTaskInfo* const streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream* const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsFunctionCallSqe& fnCallSqe = davidSqe->fuctionCallSqe;

    fnCallSqe.header.type = RT_DAVID_SQE_TYPE_COND;
    fnCallSqe.condsSubType = CONDS_SUB_TYPE_STREAM_ACTIVE;

    fnCallSqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    fnCallSqe.sqeLength = 0U;
    fnCallSqe.csc = 1U;

    const uint64_t funcAddr = RtPtrToValue(streamActiveTask->funcCallSvmMem);
    const uint64_t funcCallSize = static_cast<uint64_t>(sizeof(RtStarsStreamActiveFc));

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), fnCallSqe);

    PrintDavidSqe(davidSqe, "StreamActiveTask");
    RT_LOG(
        RT_LOG_INFO, "StreamActiveTask, deviceId=%u, streamId=%d, taskId=%hu, activeStreamId=%u.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, streamActiveTask->activeStreamId);
}

void ConstructDavidSqeForOverflowSwitchSetTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe* const phSqe = &(davidSqe->phSqe);
    OverflowSwitchSetTaskInfo* const overflowSwiSet = &(taskInfo->u.overflowSwitchSetTask);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_SET_OVERFLOW_SWITCH;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    phSqe->u.streamOverflowSwitchInfo.streamId = static_cast<uint16_t>(overflowSwiSet->targetStm->Id_());
    phSqe->u.streamOverflowSwitchInfo.isSwitchOn = overflowSwiSet->switchFlag ? 1U : 0U;

    PrintDavidSqe(davidSqe, "OverflowSwitchSetTask");
    RT_LOG(
        RT_LOG_INFO,
        "OverflowSwitchSetTask target, device_id=%u, stream_id=%d, target_stream_id=%d, task_id=%hu,"
        "task_sn=%u, switch %s.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), overflowSwiSet->targetStm->Id_(), taskInfo->id,
        taskInfo->taskSn, overflowSwiSet->switchFlag ? "on" : "off");
}

void ConstructDavidSqeForStreamTagSetTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    StreamTagSetTaskInfo* const stmTagSetTsk = &(taskInfo->u.stmTagSetTask);
    RtDavidPlaceHolderSqe* const phSqe = &(davidSqe->phSqe);
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_SET_STREAM_GE_OP_TAG;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    phSqe->u.streamSetTagInfo.streamId = static_cast<uint16_t>(stmTagSetTsk->targetStm->Id_());
    phSqe->u.streamSetTagInfo.geOpTag = stmTagSetTsk->geOpTag;

    PrintDavidSqe(davidSqe, "StreamTagSetTask");
    RT_LOG(
        RT_LOG_INFO,
        "StreamTagSetTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, target_stream_id=%d, "
        "sqe_task_id=%u, geOpTag=%u.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn,
        stmTagSetTsk->targetStm->Id_(), phSqe->header.taskId, stmTagSetTsk->geOpTag);
}

void ConstructDavidSqeForCallbackLaunchTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidPlaceHolderSqe* const phSqe = &(davidSqe->phSqe);
    Stream* const stm = taskInfo->stream;
    phSqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    phSqe->header.preP = 1U;
    phSqe->taskType = TS_TASK_TYPE_HOSTFUNC_CALLBACK;
    phSqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    /* word4-5 */
    phSqe->u.callBackInfo.cbCqId = static_cast<uint16_t>(stm->GetCbRptCqid());
    phSqe->u.callBackInfo.cbGroupId = static_cast<uint16_t>(stm->GetCbGrpId());
    phSqe->u.callBackInfo.devId = static_cast<uint16_t>(stm->Device_()->Id_());
    phSqe->u.callBackInfo.streamId = static_cast<uint16_t>(stm->Id_());

    /* word6-7 */
    phSqe->u.callBackInfo.notifyId = static_cast<uint32_t>(taskInfo->u.callbackLaunchTask.eventId);
    phSqe->u.callBackInfo.taskId = taskInfo->id; //  send taskId callback cqe
    phSqe->u.callBackInfo.isBlock = taskInfo->u.callbackLaunchTask.isBlock;

    phSqe->u.callBackInfo.isOnline = stm->Device_()->Driver_()->GetRunMode() == RT_RUN_MODE_OFFLINE ? 0U : 1U;
    phSqe->u.callBackInfo.res0 = 0U;
    phSqe->u.callBackInfo.res1 = 0U;

    /* word8-11 */
    uint64_t addr = RtPtrToValue(taskInfo->u.callbackLaunchTask.callBackFunc);
    phSqe->u.callBackInfo.hostfuncAddrLow = static_cast<uint32_t>(addr);
    phSqe->u.callBackInfo.hostfuncAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue(taskInfo->u.callbackLaunchTask.fnData);
    phSqe->u.callBackInfo.fndataLow = static_cast<uint32_t>(addr);
    phSqe->u.callBackInfo.fndataHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    /* word12-13 */
    phSqe->u.callBackInfo.res2 = 0U;
    phSqe->u.callBackInfo.res3 = 0U;

    /* word14 */
    phSqe->u.callBackInfo.subTopicId = 0U;
    phSqe->u.callBackInfo.topicId = 26U;    // EVENT_TS_CALLBACK_MSG
    phSqe->u.callBackInfo.groupId = 11U;    // 11U, drv defined
    phSqe->u.callBackInfo.usrDataLen = 32U; // word 4 to word 11
    /* word15 */
    phSqe->u.callBackInfo.destPid = 0U;

    PrintDavidSqe(davidSqe, "CallbackLaunch");
    RT_LOG(
        RT_LOG_INFO, "CallbackLaunch, stream_id=%hu, task_id=%hu, notify_id=%hu, isBlock=%hu, pid=%u",
        phSqe->u.callBackInfo.streamId, taskInfo->id, phSqe->u.callBackInfo.notifyId, phSqe->u.callBackInfo.isBlock,
        phSqe->u.callBackInfo.destPid);
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
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_CREATE_STREAM, createStreamFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_STREAM_ACTIVE, streamActiveFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_ACTIVE_AICPU_STREAM, activeAicpuStreamFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_HOSTFUNC_CALLBACK, callbackLaunchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_OVERFLOW_SWITCH, overflowSwitchFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, streamTagFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_STREAM_MODE, streamModeFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK, sqLockUnlockFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_FLIP, flipFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_TASK_SQE_UPDATE, sqeUpdateFuncs);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_CREATE_STREAM, &ConstructDavidSqeBase);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_STREAM_ACTIVE, &ConstructDavidSqeForStreamActiveTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_ACTIVE_AICPU_STREAM, &ConstructDavidSqeBase);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_HOSTFUNC_CALLBACK, &ConstructDavidSqeForCallbackLaunchTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_SET_OVERFLOW_SWITCH, &ConstructDavidSqeForOverflowSwitchSetTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_SET_STREAM_GE_OP_TAG, &ConstructDavidSqeForStreamTagSetTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_SET_STREAM_MODE, &ConstructDavidSqeBase);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_SET_SQ_LOCK_UNLOCK, &ConstructDavidSqeBase);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_FLIP, &ConstructDavidSqeBase);
    }

    return true;
}

static bool g_streamTaskRegister = StreamTaskRegister();
} // namespace runtime
} // namespace cce
