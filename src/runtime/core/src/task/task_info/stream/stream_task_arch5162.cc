/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_sqcq_manage.hpp"
#include "stream_task.h"
#include "task_info_v100.h"
#include "stub_task.hpp"
#include "runtime_task_manager.h"
#include "arg_loader/arg_loader.hpp"

namespace cce {
namespace runtime {

#if F_DESC("StreamActiveTask")
void ConstructSqeForStreamActiveTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    StreamActiveTaskInfo* streamActiveTask = &(taskInfo->u.streamactiveTask);
    Stream* const stm = taskInfo->stream;
    RtStarsPhSqe* const sqe = (RtStarsPhSqe*)&(command->phSqe);

    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.l1Lock = 0U;
    sqe->header.l1UnLock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.rdConds = 0U;
    sqe->header.res1 = 0U;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_CONDS_STREAM_ACTIVE;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;

    sqe->u.streamActiveInfo.activeStreamId = streamActiveTask->activeStreamId;
    PrintSqe(command, "StreamActiveTask");
    RT_LOG(
        RT_LOG_INFO,
        "StreamActiveTask streamId=%d, taskId=%hu, activeStreamId=%u, type=%u, sqeSubType=%" PRIu16 ", preP=%u.",
        stm->Id_(), taskInfo->id, streamActiveTask->activeStreamId, static_cast<unsigned int>(sqe->header.type),
        sqe->header.u.sqeSubType, static_cast<unsigned int>(sqe->header.preP));
    return;
}

rtError_t StreamActiveTaskInit(TaskInfo* taskInfo, const Stream* const stm)
{
    StreamActiveTaskInfo* streamActiveTask = &(taskInfo->u.streamactiveTask);
    TaskCommonInfoInit(taskInfo);
    taskInfo->type = TS_TASK_TYPE_STREAM_ACTIVE;
    taskInfo->typeName = "STREAM_ACTIVE";
    streamActiveTask->activeStreamId = static_cast<uint32_t>(stm->Id_());
    streamActiveTask->activeStream = const_cast<Stream*>(stm);
    streamActiveTask->activeStreamSqId = 0U;
    streamActiveTask->funcCallSvmMem = nullptr;
    streamActiveTask->baseFuncCallSvmMem = nullptr;
    streamActiveTask->dfxPtr = nullptr;
    streamActiveTask->funCallMemSize = 0UL;
    return RT_ERROR_NONE;
}

#endif

#if F_DESC("CallbackLaunchTask")
void ConstructSqeForCallbackLaunchTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    uint32_t pid = 0U;
    RtStarsPhSqe* const sqe = &(command->phSqe);
    Stream* stm = taskInfo->stream;
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));

    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = 1U; // callback need write cqe
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.taskId = taskInfo->id;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_CALLBACK;

    sqe->u.callBackInfo.cbCqId = static_cast<uint16_t>(stm->GetCbRptCqid());
    sqe->u.callBackInfo.cbGroupId = static_cast<uint16_t>(stm->GetCbGrpId());
    sqe->u.callBackInfo.devId = static_cast<uint16_t>(stm->Device_()->Id_());
    sqe->u.callBackInfo.streamId = static_cast<uint16_t>(stm->Id_());
    sqe->u.callBackInfo.eventId = static_cast<uint16_t>(taskInfo->u.callbackLaunchTask.eventId);
    sqe->u.callBackInfo.isBlock = taskInfo->u.callbackLaunchTask.isBlock;
    sqe->u.callBackInfo.taskId = taskInfo->id; //  send taskId callback cqe

    uint64_t addr = RtPtrToValue<rtCallback_t>(taskInfo->u.callbackLaunchTask.callBackFunc);
    sqe->u.callBackInfo.hostfuncAddrLow = static_cast<uint32_t>(addr);
    sqe->u.callBackInfo.hostfuncAddrHigh = static_cast<uint32_t>(addr >> UINT32_BIT_NUM);

    addr = RtPtrToValue<void*>(taskInfo->u.callbackLaunchTask.fnData);
    sqe->u.callBackInfo.fndataLow = static_cast<uint32_t>(addr);
    sqe->u.callBackInfo.fndataHigh = static_cast<uint32_t>(addr >> UINT32_BIT_NUM);

    sqe->u.callBackInfo.groupId = 11U; // 11U, drv defined
    sqe->u.callBackInfo.destPid = pid;

    PrintSqe(command, "CallbackLaunch");
    RT_LOG(
        RT_LOG_INFO,
        "type=%d, wrCqe=%d, rtStreamId=%hu, taskId=%hu, sqeSubType=%hu, preP=%d, postP=%d, "
        "cbCqId=%hu, cbGroupId=%hu, devId=%hu, streamId=%hu, eventId=%hu, isBlock=%hu, cbTaskId=%hu, "
        "hostfuncAddrLow=%u, hostfuncAddrHigh=%u, fndataLow=%u, fndataHigh=%u, groupId=%u, destPid=%u",
        sqe->header.type, sqe->header.wrCqe, sqe->header.rtStreamId, sqe->header.taskId, sqe->header.u.sqeSubType,
        sqe->header.preP, sqe->header.postP, sqe->u.callBackInfo.cbCqId, sqe->u.callBackInfo.cbGroupId,
        sqe->u.callBackInfo.devId, sqe->u.callBackInfo.streamId, sqe->u.callBackInfo.eventId,
        sqe->u.callBackInfo.isBlock, sqe->u.callBackInfo.taskId, sqe->u.callBackInfo.hostfuncAddrLow,
        sqe->u.callBackInfo.hostfuncAddrHigh, sqe->u.callBackInfo.fndataLow, sqe->u.callBackInfo.fndataHigh,
        sqe->u.callBackInfo.groupId, sqe->u.callBackInfo.destPid);
}
#endif

static bool StreamTaskRegister()
{
    TaskFuncSingle streamActiveFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForStreamActiveTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = nullptr,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    TaskFuncSingle callbackLaunchFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForCallbackLaunchTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_STREAM_ACTIVE, streamActiveFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_HOSTFUNC_CALLBACK, callbackLaunchFuncs);

    return true;
}

static bool g_streamTaskRegister = StreamTaskRegister();

} // namespace runtime
} // namespace cce
