/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "notify_c.hpp"
#include "event.hpp"
#include "event_resource.hpp"
#include "notify_task.h"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "error_message_manage.hpp"
#include "stream_david.hpp"
#include "profiler_c.hpp"
#include "rt_log.h"
#include "ctrl_sq.hpp"

namespace cce {
namespace runtime {

namespace {
rtError_t SubmitNotifyWait(
    Notify* const inNotify, Stream* const streamIn, const uint32_t timeOut, const bool isEndGraphNotify)
{
    TaskInfo* waitTask = nullptr;
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", streamIn->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = streamIn;
    streamIn->StreamLock();
    const tsTaskType_t taskType = isEndGraphNotify ? TS_TASK_TYPE_ENDGRAPH_NOTIFY_WAIT : TS_TASK_TYPE_NOTIFY_WAIT;
    waitTask = streamIn->AllocTask(nullptr, taskType, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(waitTask == nullptr, error, streamIn->StreamUnLock();
                                     , "Failed to alloc task, stream_id=%d, retCode=%#x.", streamIn->Id_(),
                                     static_cast<uint32_t>(error));
    pos = waitTask->id;
    dstStm = waitTask->stream;
    std::function<void()> const errRecycle = [&waitTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(waitTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    ScopeGuard tskErrRecycle(errRecycle);
    error = isEndGraphNotify ? EndGraphNotifyWaitTaskInit(waitTask, inNotify->GetNotifyId(), timeOut, inNotify) :
                               NotifyWaitTaskInit(waitTask, inNotify->GetNotifyId(), timeOut, nullptr, inNotify);
    ERROR_RETURN(
        error, "Failed to initialize notify wait task, stream_id=%d, retCode=%#x", streamIn->Id_(),
        static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "stream_id=%d notify_id=%u.", streamIn->Id_(), inNotify->GetNotifyId());
    waitTask->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();

    error = DavidSendTask(waitTask, dstStm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to submit notify wait task, stream_id=%d, retCode=%#x", streamIn->Id_(),
        static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), waitTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(
        error, "Failed to recycle task, stream_id=%d, retCode=%#x.", streamIn->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}
} // namespace

rtError_t NtyWait(Notify* const inNotify, Stream* const streamIn, const uint32_t timeOut)
{
    return SubmitNotifyWait(inNotify, streamIn, timeOut, false);
}

rtError_t EndGraphNtyWait(Notify* const inNotify, Stream* const streamIn, const uint32_t timeOut)
{
    return SubmitNotifyWait(inNotify, streamIn, timeOut, true);
}

rtError_t NtyRecord(Notify* const inNotify, Stream* const streamIn)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(streamIn, RT_ERROR_STREAM_NULL, "Notify recording");
    TaskInfo* recordTask = nullptr;
    const int32_t streamId = streamIn->Id_();
    RT_LOG(RT_LOG_INFO, "notify_id=%u, device_id=%u.", inNotify->GetNotifyId(), streamIn->Device_()->Id_());

    uint64_t baseAddr = 0ULL;
    bool isIpc = false;
    if (inNotify->IsIpcNotify() && (inNotify->IsIpcCreator() == false)) {
        isIpc = true;
        baseAddr = inNotify->GetNotifyVaAddr();
    }
    SingleBitNotifyRecordInfo singleInfo = {isIpc, false, false, inNotify->IsPod(), MAX_UINT32_NUM, baseAddr, false};
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", streamIn->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = streamIn;
    std::function<void()> const errRecycle = [&recordTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(recordTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    streamIn->StreamLock();
    recordTask = streamIn->AllocTask(nullptr, TS_TASK_TYPE_NOTIFY_RECORD, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(recordTask == nullptr, error, streamIn->StreamUnLock();
                                     , "Failed to alloc task, stream_id=%d, retCode=%#x.", streamId,
                                     static_cast<uint32_t>(error));
    pos = recordTask->id;
    dstStm = recordTask->stream;
    error = NotifyRecordTaskInit(
        recordTask, inNotify->GetNotifyId(), static_cast<int32_t>(inNotify->GetDeviceId()), inNotify->GetPhyDevId(),
        &singleInfo, nullptr, static_cast<void*>(inNotify));
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN(error, "Failed to initialize notify record task, retCode=%#x", static_cast<uint32_t>(error));
    recordTask->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(recordTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit notify record task, retCode=%#x", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    RT_LOG(
        RT_LOG_INFO, "device_id=%u, stream_id=%d, pos=%u, notify_id=%u", streamIn->Device_()->Id_(), streamId, pos,
        inNotify->GetNotifyId());
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), recordTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t NtyReset(Notify* const inNotify, Stream* const streamIn)
{
    const int32_t streamId = streamIn->Id_();
    RT_LOG(
        RT_LOG_INFO, "device_id=%u, stream_id=%d, notify_id=%u, lastLocalId=%u, lastBaseAddr_=%#x.",
        streamIn->Device_()->Id_(), streamId, inNotify->GetNotifyId(), inNotify->GetLastLocalId(),
        inNotify->GetLastBaseAddr());

    if (inNotify->IsIpcNotify()) {
        RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1005, "IPC notify reset");
        return RT_ERROR_TASK_NOT_SUPPORT;
    }
    SingleBitNotifyRecordInfo singleInfo = {false,
                                            false,
                                            inNotify->GetLastIsPcie(),
                                            inNotify->IsPod(),
                                            inNotify->GetLastLocalId(),
                                            inNotify->GetLastBaseAddr(),
                                            true};

    if (streamIn->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        return streamIn->Device_()->GetCtrlSQ().SendNotifyResetV200Msg(
            inNotify->GetNotifyId(), &singleInfo, static_cast<void*>(inNotify));
    }

    TaskInfo* resetTask = nullptr;
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", streamIn->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = streamIn;
    std::function<void()> const errRecycle = [&resetTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(resetTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    streamIn->StreamLock();
    resetTask = streamIn->AllocTask(nullptr, TS_TASK_TYPE_NOTIFY_RECORD, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(resetTask == nullptr, error, streamIn->StreamUnLock();
                                     , "Failed to alloc task, device_id=%u, stream_id=%d, retCode=%#x.",
                                     streamIn->Device_()->Id_(), streamId, static_cast<uint32_t>(error));
    pos = resetTask->id;
    dstStm = resetTask->stream;
    error = NotifyResetTaskInit(resetTask, inNotify->GetNotifyId(), &singleInfo, static_cast<void*>(inNotify));
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN(error, "Failed to initialize notify reset task, retCode=%#x", static_cast<uint32_t>(error));
    resetTask->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(resetTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit notify reset task, retCode=%#x.", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), resetTask->taskSn);

    error = streamIn->Synchronize();
    ERROR_RETURN_MSG_INNER(
        error, "Failed to synchronize notify reset Task, device_id=%u, streamId=%d, retCode=%#x",
        streamIn->Device_()->Id_(), streamIn->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
