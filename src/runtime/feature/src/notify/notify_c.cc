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
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "error_message_manage.hpp"
#include "stream_david.hpp"
#include "profiler_c.hpp"

namespace cce {
namespace runtime {

rtError_t NtyWait(Notify * const inNotify, Stream * const streamIn, const uint32_t timeOut)
{
    TaskInfo *waitTask = nullptr;
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = streamIn;
    streamIn->StreamLock();
    error = AllocTaskInfoForCapture(&waitTask, streamIn, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, streamIn->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&waitTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(waitTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    SaveTaskCommonInfo(waitTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = NotifyWaitTaskInit(waitTask, inNotify->GetNotifyId(), timeOut, nullptr, inNotify);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d NotifyWaitTask init failed, retCode=%#x",
        streamIn->Id_(), static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "stream_id=%d notify_id=%u.", streamIn->Id_(), inNotify->GetNotifyId());
    waitTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(waitTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d NotifyWaitTask submit failed, retCode=%#x",
        streamIn->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), waitTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t NtyRecord(Notify * const inNotify, Stream * const streamIn)
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);
    TaskInfo *recordTask = nullptr;
    const int32_t streamId = streamIn->Id_();
    RT_LOG(RT_LOG_INFO, "notify_id=%u, lastLocalId=%u, lastBaseAddr_=%#x, device_id=%u.",
           inNotify->GetNotifyId(), inNotify->GetLastLocalId(), inNotify->GetLastBaseAddr(), streamIn->Device_()->Id_());

    bool isIpc = false;
    if (inNotify->IsIpcNotify() && (inNotify->IsIpcCreator() == false)) {
        isIpc = true;
    }
    SingleBitNotifyRecordInfo singleInfo = {isIpc, false, inNotify->GetLastIsPcie(), inNotify->IsPod(),
                                            inNotify->GetLastLocalId(), inNotify->GetLastBaseAddr(), false};
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = streamIn;
    std::function<void()> const errRecycle = [&recordTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(recordTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    streamIn->StreamLock();
    error = AllocTaskInfoForCapture(&recordTask, streamIn, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, streamIn->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(recordTask, dstStm, pos);
    error = NotifyRecordTaskInit(recordTask, inNotify->GetNotifyId(),
        static_cast<int32_t>(inNotify->GetDeviceId()), inNotify->GetPhyDevId(), &singleInfo,
        nullptr, static_cast<void *>(inNotify));
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN_MSG_INNER(error, "NotifyRecordTask init failed, retCode=%#x", static_cast<uint32_t>(error));
    recordTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(recordTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "NotifyRecordTask submit failed, retCode=%#x", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, pos=%u, notify_id=%u",
        streamIn->Device_()->Id_(), streamId, pos, inNotify->GetNotifyId());
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), recordTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", streamId, static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t NtyReset(Notify * const inNotify, Stream * const streamIn)
{
    const int32_t streamId = streamIn->Id_();
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, notify_id=%u, lastLocalId=%u, lastBaseAddr_=%#x.",
        streamIn->Device_()->Id_(), streamId, inNotify->GetNotifyId(), inNotify->GetLastLocalId(),
        inNotify->GetLastBaseAddr());

    if (inNotify->IsIpcNotify()) {
        RT_LOG(RT_LOG_ERROR, "device_id=%u, stream_id=%d, notify_id=%u, ipc_notify_name=%s, "
            "ipc notify reset task is not supported.", streamIn->Device_()->Id_(), streamId, inNotify->GetNotifyId(),
            inNotify->GetIpcName().c_str());
        return RT_ERROR_TASK_NOT_SUPPORT;
    }
    TaskInfo *resetTask = nullptr;
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(error, "device_id=%u, stream_id=%d check failed, retCode=%#x.",
        streamIn->Device_()->Id_(), streamId, static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = streamIn;
    std::function<void()> const errRecycle = [&resetTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(resetTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    streamIn->StreamLock();
    error = AllocTaskInfoForCapture(&resetTask, streamIn, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, streamIn->StreamUnLock();, 
        "Failed to alloc task, device_id=%u, stream_id=%d, retCode=%#x.",
        streamIn->Device_()->Id_(), streamId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(resetTask, dstStm, pos);
    SingleBitNotifyRecordInfo singleInfo = {false, false, inNotify->GetLastIsPcie(), inNotify->IsPod(),
                                            inNotify->GetLastLocalId(), inNotify->GetLastBaseAddr(), true};
    error = NotifyResetTaskInit(resetTask, inNotify->GetNotifyId(), &singleInfo, static_cast<void *>(inNotify));
    ScopeGuard tskErrRecycle(errRecycle);
    ERROR_RETURN_MSG_INNER(error, "NotifyResetTask init failed, retCode=%#x", static_cast<uint32_t>(error));
    resetTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(resetTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "NotifyResetTask submit failed, retCode=%#x", static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), resetTask->taskSn);

    error = streamIn->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize notify reset Task, device_id=%u, streamId=%d, retCode=%#x",
        streamIn->Device_()->Id_(), streamIn->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce