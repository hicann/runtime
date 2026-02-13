/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "event_c.hpp"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "stream_david.hpp"
#include "profiler_c.hpp"
#include "event_david.hpp"
namespace cce {
namespace runtime {

rtError_t EvtRecord(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    rtError_t error = RT_ERROR_NONE;
    DavidEvent *davidEvt = static_cast<DavidEvent *>(evt);
    int32_t newEventId = davidEvt->EventId_();
    const bool oldHasReset = davidEvt->HasReset();
    const bool oldHasRecord = davidEvt->HasRecord();
    TaskInfo *tsk = nullptr;
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&tsk, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));

    if (davidEvt->IsNewMode() || davidEvt->GetEventFlag() == RT_EVENT_DEFAULT) {
        (void)davidEvt->AllocEventIdResource(dstStm, newEventId);
        davidEvt->SetEventId(newEventId);
    }

    SaveTaskCommonInfo(tsk, dstStm, pos);
    (void)DavidEventRecordTaskInit(tsk, davidEvt, newEventId);
    SetSqPos(tsk, pos);
    tsk->stmArgPos = (static_cast<DavidStream *>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
        davidEvt->SetRecord(oldHasRecord);
        davidEvt->SetHasReset(oldHasReset);
        TaskUnInitProc(tsk);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();,
        "Failed to submit record task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    return error;
}

rtError_t EvtRecordSoftwareMode(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    DavidEvent *davidEvt = static_cast<DavidEvent *>(evt);
    TaskInfo *tsk = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    void *eventAddr = nullptr;
    int32_t newEventId = INVALID_EVENT_ID;
    Device * const dev = stm->Device_();
    error = dev->AllocExpandingPoolEvent(&eventAddr, &newEventId);
    ERROR_RETURN_MSG_INNER(error, "capture addr error, deviceId=%u, tsId=%u, retCode=%#x",
        dev->Id_(), dev->DevGetTsId(), static_cast<uint32_t>(error));
    davidEvt->SetEventAddr(eventAddr);
    davidEvt->SetEventId(newEventId);
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&tsk, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, 
        "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));

    SaveTaskCommonInfo(tsk, dstStm, pos);
    (void)MemWriteValueTaskInit(tsk, eventAddr, 1UL);
    tsk->typeName = "EVENT_RECORD";
    tsk->type = TS_TASK_TYPE_CAPTURE_RECORD;
    MemWriteValueTaskInfo *memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->event = davidEvt;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;

    tsk->stmArgPos = (static_cast<DavidStream *>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
        TaskUnInitProc(tsk);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();,
        "Failed to submit record task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    davidEvt->SetRecord(true);
    RT_LOG(RT_LOG_INFO, "capture event task submit success, device_id=%u, src_stream_id=%d->dst_stream_id=%d, task_id=%hu, event_id=%d, task_pos=%u",
        dev->Id_(), stm->Id_(), dstStm->Id_(), tsk->id, newEventId, pos);
    return error;
}

rtError_t ProcStreamRecordTask(Stream * const stm, int32_t timeout)
{
    rtError_t error = CheckTaskCanSend(stm);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "stream_id=%d check failed, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    TaskInfo *tsk = nullptr;
    stm->StreamLock();
    Event *lastHalfRecord = stm->GetLastHalfRecord();
    std::function<void()> const errRecycle = [&lastHalfRecord, &tsk, &stm, &pos]() {
        TaskUnInitProc(tsk);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    if (lastHalfRecord == nullptr) {
        lastHalfRecord = new (std::nothrow) DavidEvent(stm->Device_(), RT_EVENT_STREAM_MARK, stm->Context_(), false);
        stm->SetLastHalfRecord(lastHalfRecord);
        COND_PROC_RETURN_ERROR_MSG_INNER((lastHalfRecord == nullptr),
                                         RT_ERROR_EVENT_NEW,
                                         stm->StreamUnLock();,
                                         "Failed to alloc event, stream_id=%d.", stm->Id_());
    }
    error = AllocTaskInfo(&tsk, stm, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    ScopeGuard tskErrRecycle(errRecycle);
    SaveTaskCommonInfo(tsk, stm, pos);
    error = DavidEventRecordTaskInit(tsk, lastHalfRecord, lastHalfRecord->EventId_());
    ERROR_RETURN_MSG_INNER(error, "event init fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    DavidEventRecordTaskInfo * const eventRecordTsk = &(tsk->u.davidEventRecordTaskInfo);
    eventRecordTsk->timeout = timeout;
    tsk->isNeedStreamSync = true;
    tsk->isCqeNeedConcern = true;
    SetSqPos(tsk, pos);
    tsk->stmArgPos = (static_cast<DavidStream *>(stm))->GetArgPos();
    error = DavidSendTask(tsk, stm);
    ERROR_RETURN_MSG_INNER(error, "event task send fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    error = SubmitTaskPostProc(stm, pos, true, timeout);
    if (error == RT_ERROR_STREAM_SYNC_TIMEOUT) {
        stm->SetNeedSyncFlag(true);
        return error;
    }
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t EvtWait(Event * const evt, Stream * const stm, const uint32_t timeout)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    rtError_t error = RT_ERROR_NONE;
    Device * const dev = stm->Device_();
    DavidEvent *davidEvt = static_cast<DavidEvent *>(evt);
    int32_t eventId = INVALID_EVENT_ID;
    if (!davidEvt->WaitSendCheck(stm, eventId)) {
        RT_LOG(RT_LOG_INFO, "no need wait, return success, event_id=%d", eventId);
        return RT_ERROR_NONE;
    }

    if (((davidEvt->GetEventFlag() & (RT_EVENT_DDSYNC_NS | RT_EVENT_EXTERNAL)) == 0U) &&
        (!davidEvt->HasRecord() || (eventId == INVALID_EVENT_ID))) {
        RT_LOG(RT_LOG_ERROR, "Cannot submit event wait before event record, device_id=%u, stream_id=%d, flag=%u, "
            "model=%s.", dev->Id_(), stm->Id_(), davidEvt->GetEventFlag(), stm->GetModelNum() != 0 ? "yes" : "no");
        return RT_ERROR_INVALID_VALUE;
    }
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&tsk, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, dstStm, pos);
    DavidEventWaitTaskInit(tsk, davidEvt, eventId, timeout);

    tsk->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk);
                                       TaskRollBack(dstStm, pos);
                                       stm->StreamUnLock();,
                                       "Failed to submit wait task, stream_id=%d, retCode=%#x.",
                                       stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t EvtWaitSoftwareMode(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    DavidEvent *davidEvt = static_cast<DavidEvent *>(evt);
    Device * const dev = stm->Device_();
    void *eventAddr = davidEvt->GetEventAddr();
    COND_RETURN_ERROR_MSG_INNER(eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL,
 	    "eventAddr is null, event_id=%d.", davidEvt->EventId_());

    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&tsk, stm, pos, dstStm, MEM_WAIT_V2_SQE_NUM);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, 
        "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, dstStm, pos, MEM_WAIT_V2_SQE_NUM);
    tsk->typeName = "EVENT_WAIT";
    tsk->type = TS_TASK_TYPE_CAPTURE_WAIT;
    error = MemWaitValueTaskInit(tsk, eventAddr, 1UL, 0U);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, 
        "Task init failed, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    MemWaitValueTaskInfo *memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;

    tsk->stmArgPos = (static_cast<DavidStream *>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
        TaskUnInitProc(tsk);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();,
        "Failed to submit wait task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "capture wait task submit success, device_id=%u, src_stream_id=%d->dst_stream_id=%d, task_id=%hu, event_id=%d, task_pos=%u",
        dev->Id_(), stm->Id_(), dstStm->Id_(), tsk->id, davidEvt->EventId_(), pos);
    return RT_ERROR_NONE;
}

rtError_t EvtReset(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    TaskInfo *tsk = nullptr;
    DavidEvent *davidEvt = static_cast<DavidEvent *>(evt);
    const int32_t eventId = davidEvt->EventId_();
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&tsk, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, dstStm, pos);
    DavidEventResetTaskInit(tsk, davidEvt, eventId);
    tsk->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
                                TaskUnInitProc(tsk);
                                TaskRollBack(dstStm, pos);
                                stm->StreamUnLock();,
                                "Failed to submit reset task, stream_id=%d, retCode=%#x.",
                                stm->Id_(), static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), tsk->taskSn);
    davidEvt->SetHasReset(true);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t EvtResetSoftwareMode(Event * const evt, Stream * const stm)
{
    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    DavidEvent *davidEvt = static_cast<DavidEvent *>(evt);
    Device * const dev = stm->Device_();
    void *eventAddr = davidEvt->GetEventAddr();
    COND_RETURN_ERROR_MSG_INNER(eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL,
 	    "eventAddr is null, event_id=%d.", davidEvt->EventId_());

    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = stm;
    stm->StreamLock();
    error = AllocTaskInfoForCapture(&tsk, stm, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, stm->StreamUnLock();, 
        "Failed to alloc task, stream_id=%d, retCode=%#x.",
        stm->Id_(), static_cast<uint32_t>(error));

    SaveTaskCommonInfo(tsk, dstStm, pos);
    (void)MemWriteValueTaskInit(tsk, eventAddr, 0UL);
    tsk->typeName = "EVENT_RESET";
    tsk->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    MemWriteValueTaskInfo *memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;

    tsk->stmArgPos = (static_cast<DavidStream *>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error,
        TaskUnInitProc(tsk);
        TaskRollBack(dstStm, pos);
        stm->StreamUnLock();,
        "Failed to submit reset task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_INFO, "reset task submit success, device_id=%u, src_stream_id=%d->dst_stream_id=%d, task_id=%hu, event_id=%d, task_pos=%u",
        dev->Id_(), stm->Id_(), dstStm->Id_(), tsk->id, davidEvt->EventId_(), pos);
    return error;
}
}  // namespace runtime
}  // namespace cce