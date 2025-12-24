/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "capture_model.hpp"
#include "stub_task.hpp"
#include "event_task.h"
#include "thread_local_container.hpp"
namespace cce {
namespace runtime {
#if F_DESC("EventRecordTask")
rtError_t UpdateEventTimeLine(TaskInfo * const taskInfo, const Event *const eventPtr)
{
    const Runtime *const rtInstance = Runtime::Instance();
    COND_RETURN_WITH_NOLOG(!rtInstance->GetDisableThread() || rtInstance->ChipIsHaveStars(), RT_ERROR_NONE);
    NULL_PTR_RETURN(eventPtr, RT_ERROR_INVALID_VALUE);
    rtError_t error = RT_ERROR_NONE;
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
    Stream * const stm = taskInfo->stream;
    if (((eventPtr->GetEventFlag() & RT_EVENT_TIME_LINE) != 0U) &&
        (eventRecordTaskInfo->timelineBase == MAX_UINT64_NUM)) {
        error = stm->AcquireTimeline(eventRecordTaskInfo->timelineBase, eventRecordTaskInfo->timelineOffset);
        while ((error == RT_ERROR_DEVICE_LIMIT) &&
            (stm->Device_()->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL))) {
            uint32_t reclaimTaskId = 0U;
            stm->StreamSyncLock();
            (void)stm->Device_()->TaskReclaim(static_cast<uint32_t>(stm->Id_()), true, reclaimTaskId);
            stm->StreamSyncUnLock();
            error = stm->AcquireTimeline(eventRecordTaskInfo->timelineBase, eventRecordTaskInfo->timelineOffset);
        }
    }
    return error;
}

rtError_t EventRecordTaskInit(TaskInfo * const taskInfo, Event *const eventPtr,
                              const bool isNotifyRecordFlag, const int32_t newEventId)
{
    NULL_PTR_RETURN(eventPtr, RT_ERROR_INVALID_VALUE);
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_EVENT_RECORD;
    taskInfo->typeName = const_cast<char_t*>("EVENT_RECORD");
    taskInfo->needPostProc = true;
    eventRecordTaskInfo->event = eventPtr;
    eventRecordTaskInfo->timestamp = 0LU;
    eventRecordTaskInfo->eventid = newEventId;
    eventRecordTaskInfo->isNotifyRecord = isNotifyRecordFlag;
    eventRecordTaskInfo->waitCqId = 0U;
    eventRecordTaskInfo->timeout = -1;
    eventRecordTaskInfo->timelineBase = MAX_UINT64_NUM;
    eventRecordTaskInfo->timelineOffset = MAX_UINT32_NUM;
    eventPtr->EventIdCountAdd(newEventId);
    const uint8_t packageNum = Runtime::Instance()->GetDisableThread() ? 1U : 2U;
    taskInfo->pkgStat[RT_PACKAGE_TYPE_TASK_REPORT].packageReportNum = packageNum;
    if (!Runtime::Instance()->GetDisableThread()) {
        RecordTaskInfo latestRecord = {taskInfo->stream->Id_(), taskInfo->id, RECORDING};
        eventRecordTaskInfo->event->UpdateLatestRecord(latestRecord, newEventId);
    }
    const bool isTimeLine = (eventPtr->GetEventFlag() & RT_EVENT_TIME_LINE) != 0U;
    const bool isStreamSync = eventPtr->GetSyncFlag();
    if (stream->Device_()->IsStarsPlatform() && (isTimeLine || isStreamSync)) {
        taskInfo->isCqeNeedConcern = stream->GetBindFlag() ? 0U : 1U; // only simply stream recycle cqe.
    }
    return RT_ERROR_NONE;
}

void EventRecordTaskUnInit(TaskInfo * const taskInfo)
{
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;

    if (eventRecordTaskInfo->timelineBase != MAX_UINT64_NUM) {
        (void)stream->ReleaseTimeline(eventRecordTaskInfo->timelineBase, eventRecordTaskInfo->timelineOffset);
        eventRecordTaskInfo->timelineBase = MAX_UINT64_NUM;
        eventRecordTaskInfo->timelineOffset = MAX_UINT32_NUM;
    }
}

void SetResultForEventRecordTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);

    const auto *const tsData = static_cast<const uint32_t *>(data);
    eventRecordTaskInfo->timestamp = static_cast<uint64_t>(tsData[0]) |
        (static_cast<uint64_t>(tsData[1]) << 32U); // shift 32 bit
}

void SetStarsResultForEventRecordTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq)
{
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);

    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) {
        eventRecordTaskInfo->timestamp = logicCq.u1.timeStamp;
    } else {
        taskInfo->errorCode = logicCq.errorCode;
    }
}

void TaskTriggerEvent(TaskInfo * const taskInfo)
{
    // event lock
    MEMORY_FENCE();
    Event *event =  taskInfo->u.eventRecordTaskInfo.event;
    Notifier *notifier = event->FindFromNotifierMap(static_cast<uint32_t>(taskInfo->stream->Id_()), taskInfo->id);
    if (notifier != nullptr) {
        (void)notifier->Triger();
        RT_LOG(RT_LOG_INFO, "notifier trigger, device_id=%u, stream_id=%d, task_id=%hu.",
               taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
    }
}

void ToCommandBodyForEventRecordTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;

    command->u.eventRecordTask.eventID = static_cast<uint16_t>(eventRecordTaskInfo->eventid); // event_id = -1
    command->u.eventRecordTask.flag = RT_EVENT_DEFAULT; // default ?
    command->u.eventRecordTask.timelineBase = MAX_UINT64_NUM;
    command->u.eventRecordTask.offset = MAX_UINT32_NUM;
    command->u.eventRecordTask.threadId = MAX_UINT32_NUM;
    command->u.eventRecordTask.virAddr = MAX_UINT32_NUM;
    command->u.eventRecordTask.waitCqflag = static_cast<uint8_t>(eventRecordTaskInfo->waitCqflag);
    command->u.eventRecordTask.waitCqId = eventRecordTaskInfo->waitCqId;
    command->u.eventRecordTask.threadId = PidTidFetcher::GetCurrentTid();

    COND_RETURN_VOID(eventRecordTaskInfo->event == nullptr, "recorder is nullptr");

    if (Runtime::Instance()->GetDisableThread() &&
        ((eventRecordTaskInfo->event->GetEventFlag() & RT_EVENT_TIME_LINE) != 0U)) {
        command->u.eventRecordTask.flag |= 0x01U;
        command->u.eventRecordTask.timelineBase = eventRecordTaskInfo->timelineBase;
        command->u.eventRecordTask.offset = eventRecordTaskInfo->timelineOffset;
    }

    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    param.u.eventRecordParams = { eventRecordTaskInfo->eventid, static_cast<uint32_t>(eventRecordTaskInfo->waitCqflag),
        eventRecordTaskInfo->waitCqId, false, ((reinterpret_cast<uintptr_t>(eventRecordTaskInfo->event)) & 0xFFULL)};
    AtraceSubmitLog(TYPE_EVENT_RECORD, param);
    eventRecordTaskInfo->event->InsertRecordResetToMap(taskInfo);
    if (Runtime::Instance()->GetDisableThread()) {
        RecordTaskInfo latestRecord = {taskInfo->stream->Id_(), taskInfo->id, RECORDING};
        eventRecordTaskInfo->event->UpdateLatestRecord(latestRecord, eventRecordTaskInfo->eventid);
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, event_id=%d, flag=%#" PRIx64 ", Task_flag=%#x, "
           "timelineBase=%#" PRIx64 ", offset=%#x, waitCqflag=%u, waitCqId=%u",
           stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventRecordTaskInfo->eventid,
           eventRecordTaskInfo->event->GetEventFlag(), static_cast<uint32_t>(command->u.eventRecordTask.flag),
           command->u.eventRecordTask.timelineBase, command->u.eventRecordTask.offset,
           static_cast<uint32_t>(eventRecordTaskInfo->waitCqflag),
           static_cast<uint32_t>(eventRecordTaskInfo->waitCqId));
}

void TryToFreeEventIdAndDestroyEvent(Event **eventPtr, int32_t freeId, bool isNeedDestroy, bool isCaptureDestroy)
{
    COND_RETURN_VOID(*eventPtr == nullptr, "event is nullptr");
    bool canEventbeDelete = false;
    if ((!GlobalContainer::IsEventHardMode()) && (isCaptureDestroy) && ((*eventPtr)->IsNewMode())) {
        canEventbeDelete = true;
    } else {
        canEventbeDelete = (*eventPtr)->TryFreeEventIdAndCheckCanBeDelete(freeId, isNeedDestroy);
    }

    if (canEventbeDelete) {
        if ((*eventPtr)->IsCapturing()) {
            CaptureModel * const mdl = (*eventPtr)->GetCaptureModel();
            mdl->DeleteSingleOperEvent(*eventPtr);
            (*eventPtr)->SetCaptureEvent(nullptr);
        }
        if ((*eventPtr)->Device_() != nullptr) {
            (*eventPtr)->Device_()->RemoveEvent(*eventPtr);
        }
        delete *eventPtr;
        (*eventPtr) = nullptr;
    }
}

rtError_t DestroyEventSync(Event *evt)
{
    RT_LOG(RT_LOG_INFO, "event destroy synchronize event_id=%d, isDestroySync_=%u.",
        evt->EventId_(), evt->GetDestroySync());
    const rtError_t error = evt->WaitForBusy();
    COND_PROC_RETURN_ERROR((error != RT_ERROR_NONE), error, ,
        "destroy synchronize failed, event_id=%d", evt->EventId_());
    if (evt->Device_() != nullptr) {
        evt->Device_()->RemoveEvent(evt);
    }
    delete evt;
    return RT_ERROR_NONE;
}

void DoCompleteSuccessForEventRecordTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;

    COND_RETURN_VOID(eventRecordTaskInfo->event == nullptr, "event is nullptr");
    uint64_t timeline = MAX_UINT64_NUM;
    if (eventRecordTaskInfo->timelineBase != MAX_UINT64_NUM) {
        timeline = stream->GetTimelineValue(eventRecordTaskInfo->timelineBase, eventRecordTaskInfo->timelineOffset);
        (void)stream->ReleaseTimeline(eventRecordTaskInfo->timelineBase, eventRecordTaskInfo->timelineOffset);
    }
    stream->EraseEventTask(taskInfo);
    eventRecordTaskInfo->timelineBase = MAX_UINT64_NUM;
    eventRecordTaskInfo->timelineOffset = MAX_UINT32_NUM;
    eventRecordTaskInfo->event->RecordComplete(taskInfo, eventRecordTaskInfo->timestamp,
                                               timeline);
    // model or simple must try to free id and destroy event.
    RT_LOG(RT_LOG_INFO, "event_record: device_id=%u, stream_id=%d, task_id=%hu, sq_id=%u, event_id=%d, "
        "timeline=%#" PRIx64 ", timestamp=%#" PRIx64, devId, stream->Id_(), taskInfo->id,
        stream->GetSqId(), eventRecordTaskInfo->eventid, timeline, eventRecordTaskInfo->timestamp);
    TryToFreeEventIdAndDestroyEvent(&(eventRecordTaskInfo->event), eventRecordTaskInfo->eventid, false);

    const rtError_t error = stream->Device_()->GetDeviceStatus();
    if ((error == RT_ERROR_DEVICE_TASK_ABORT) || (error == RT_ERROR_STREAM_ABORT)) {
        COND_RETURN_VOID_WARN(eventRecordTaskInfo->event == nullptr, "event is nullptr");
        (void)eventRecordTaskInfo->event->ClearRecordStatus();
    }
}

void ConstructSqeForEventRecordTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsEventSqe *sqe = &(command->eventSqe);
    sqe->header.type = eventRecordTaskInfo->event->IsEventWithoutWaitTask() ?
            RT_STARS_SQE_TYPE_PLACE_HOLDER : RT_STARS_SQE_TYPE_EVENT_RECORD;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = (((eventRecordTaskInfo->event->GetEventFlag() & RT_EVENT_TIME_LINE) != 0U) ||
            static_cast<bool>((taskInfo->isCqeNeedConcern)) ? 1U : 0U); // 1: set wr_cqe
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    uint16_t streamId = static_cast<uint16_t>(stream->Id_());
    if (eventRecordTaskInfo->waitCqflag && (!stream->IsSeparateSendAndRecycle())) {
        streamId |= RT_SYNC_TASK_FLAG;
    }

    sqe->header.rt_stream_id = streamId;
    sqe->eventId = static_cast<uint16_t>(eventRecordTaskInfo->eventid);
    sqe->header.task_id = taskInfo->id;

    sqe->res2 = 0U;
    sqe->res3 = 0U;

    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    param.u.eventRecordParams = { eventRecordTaskInfo->eventid, static_cast<uint32_t>(eventRecordTaskInfo->waitCqflag),
        eventRecordTaskInfo->waitCqId, false,
        ((reinterpret_cast<uintptr_t>(eventRecordTaskInfo->event)) & 0xFFULL)};

    AtraceSubmitLog(TYPE_EVENT_RECORD, param);
    eventRecordTaskInfo->event->InsertRecordResetToMap(taskInfo);
    if (Runtime::Instance()->GetDisableThread()) {
        RecordTaskInfo latestRecord = {taskInfo->stream->Id_(), taskInfo->id, RECORDING};
        eventRecordTaskInfo->event->UpdateLatestRecord(latestRecord, eventRecordTaskInfo->eventid);
    }
    RT_LOG(RT_LOG_INFO, "event_record: device_id=%u, stream_id=%d, task_id=%hu, event_id=%u, sq_id=%u.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventRecordTaskInfo->eventid, stream->GetSqId());
    PrintSqe(command, "EventRecordTask");
}
#endif

#if F_DESC("EventResetTask")
rtError_t EventResetTaskInit(TaskInfo * const taskInfo, Event *const eventPtr,
                             const bool isNotifyFlag, const int32_t eventIndex)
{
    EventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.eventResetTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_EVENT_RESET;
    taskInfo->typeName = const_cast<char_t*>("EVENT_RESET");
    taskInfo->needPostProc = true;
    eventResetTaskInfo->isNotify = isNotifyFlag;
    eventResetTaskInfo->eventid = eventIndex;
    eventResetTaskInfo->event = eventPtr;
    return RT_ERROR_NONE;
}

void EventResetTaskUnInit(TaskInfo * const taskInfo)
{
    EventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.eventResetTaskInfo);

    eventResetTaskInfo->eventid = INVALID_EVENT_ID;
    eventResetTaskInfo->event = nullptr;
    return;
}

void ToCommandBodyForEventResetTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    EventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.eventResetTaskInfo);
    Stream * const stream = taskInfo->stream;

    command->u.eventResetTask.eventID = static_cast<uint16_t>(eventResetTaskInfo->eventid);
    command->u.eventResetTask.isNotify = eventResetTaskInfo->isNotify;
    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    uintptr_t eventLowEightAddr = 0;
    if (eventResetTaskInfo->event != nullptr) {
        eventLowEightAddr = (reinterpret_cast<uintptr_t>(eventResetTaskInfo->event)) & 0xFFULL;
    }
    param.u.eventResetParams = {
        eventResetTaskInfo->eventid, static_cast<uint16_t>(eventResetTaskInfo->isNotify), eventLowEightAddr};
    AtraceSubmitLog(TYPE_EVENT_RESET, param);

    COND_RETURN_NORMAL(eventResetTaskInfo->event == nullptr, "notify event, device_id=%u", stream->Device_()->Id_());
    eventResetTaskInfo->event->InsertRecordResetToMap(taskInfo);
    RT_LOG(RT_LOG_INFO, "event_reset: device_id=%u, stream_id=%d, task_id=%hu, event_id=%d.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventResetTaskInfo->eventid);
}

void DoCompleteSuccessForEventResetTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    EventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.eventResetTaskInfo);
    Stream * const stream = taskInfo->stream;

    COND_RETURN_NORMAL(eventResetTaskInfo->event == nullptr, "notify event, device_id=%u", stream->Device_()->Id_());
    eventResetTaskInfo->event->DeleteRecordResetFromMap(taskInfo);
    RT_LOG(RT_LOG_INFO, "event_reset: device_id=%u, stream_id=%d, task_id=%hu, event_id=%d, sq_id=%u,",
        devId, stream->Id_(), taskInfo->id, eventResetTaskInfo->eventid, stream->GetSqId());
    TryToFreeEventIdAndDestroyEvent(&(eventResetTaskInfo->event), eventResetTaskInfo->eventid, false);
}

void ConstructSqeForEventResetTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    EventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.eventResetTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsWriteValueSqe *evSqe = &(command->writeValueSqe);
    evSqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    evSqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.wr_cqe = stream->GetStarsWrCqeFlag();

    evSqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    evSqe->header.task_id = taskInfo->id;
    evSqe->va = 0U;

    evSqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    evSqe->awsize = 0U;
    evSqe->snoop = 0U;
    evSqe->awcache = 0U;
    evSqe->awprot = 0U;

    evSqe->res3 = 0U;
    evSqe->res4 = 0U;
    evSqe->res5 = 0U;
    evSqe->res6 = 0U;
    evSqe->res7 = static_cast<uint32_t>(eventResetTaskInfo->eventid);
    evSqe->sub_type = RT_STARS_WRITE_VALUE_SUB_TYPE_EVENT_RESET;

    evSqe->write_value_part0 = 0U;
    evSqe->write_value_part1 = 0U;
    evSqe->write_value_part2 = 0U;
    evSqe->write_value_part3 = 0U;
    evSqe->write_value_part4 = 0U;
    evSqe->write_value_part5 = 0U;
    evSqe->write_value_part6 = 0U;
    evSqe->write_value_part7 = 0U;

    const uint64_t eventTableId =
        static_cast<uint64_t>(eventResetTaskInfo->eventid) / STARS_EVENT_NUM_OF_SINGLE_TABLE;

    /* same as eventid % STARS_EVENT_NUM_OF_SINGLE_TABLE */
    const uint64_t eventNum = (static_cast<uint64_t>(eventResetTaskInfo->eventid)) & 0xFFFUL;
    uint64_t base = static_cast<uint64_t>(taskInfo->stream->Device_()->GetDevProperties().eventBase);
    if (taskInfo->stream->Device_()->GetDevProperties().starsResourceAddrCalculateMethod == 
        StarsResourceAddrCalculateMethod::STARS_RESOURCE_ADDR_CALCULATE_BY_DEVICE_INFO) {
        const uint64_t chipAddr = taskInfo->stream->Device_()->GetChipAddr();
        const uint64_t chipOffset = taskInfo->stream->Device_()->GetChipOffset();
        const uint64_t dieOffset  = taskInfo->stream->Device_()->GetDieOffset();
        base = base + static_cast<uint64_t>(
            (chipOffset * static_cast<uint64_t>(stream->Device_()->GetPhyChipId())) +
            (dieOffset * static_cast<uint64_t>(stream->Device_()->GetPhyDieId())) + chipAddr);
    }
    const uint64_t addr = base + (eventTableId * STARS_EVENT_TABLE_OFFSET) + (eventNum * STARS_EVENT_OFFSET);
    evSqe->write_addr_low = static_cast<uint32_t>(addr & MASK_32_BIT);
    evSqe->write_addr_high = static_cast<uint32_t>((addr >> UINT32_BIT_NUM) & MASK_17_BIT);

    COND_RETURN_VOID(eventResetTaskInfo->event == nullptr, "event is nullptr");
    eventResetTaskInfo->event->InsertRecordResetToMap(taskInfo);

    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    param.u.eventResetParams = {eventResetTaskInfo->eventid,
        static_cast<uint16_t>(eventResetTaskInfo->isNotify),
        ((reinterpret_cast<uintptr_t>(eventResetTaskInfo->event)) & 0xFFULL)};
    AtraceSubmitLog(TYPE_EVENT_RESET, param);
    RT_LOG(RT_LOG_INFO, "event_reset: device_id=%u, stream_id=%d, task_id=%hu, sq_id=%u, event_id=%d, base=0x%llx.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, stream->GetSqId(), eventResetTaskInfo->eventid, base);
}

#endif

#if F_DESC("RemoteEventWaitTask")
rtError_t RemoteEventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventRec,
                                  const int32_t srcDeviceId, const int32_t eventIndex)
{
    RemoteEventWaitTaskInfo *remoteEventWaitTaskInfo = &(taskInfo->u.remoteEventWaitTaskInfo);
    Stream * const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_REMOTE_EVENT_WAIT;
    taskInfo->typeName = const_cast<char_t*>("REMOTE_EVENT_WAIT");
    remoteEventWaitTaskInfo->channelType = static_cast<uint8_t>(UINT8_MAX);
    remoteEventWaitTaskInfo->srcMailboxPa = 0LU;
    remoteEventWaitTaskInfo->srcDoorbellPa = 0LU;
    remoteEventWaitTaskInfo->dstDoorbellPa = 0LU;
    remoteEventWaitTaskInfo->event = eventRec;
    remoteEventWaitTaskInfo->eventId = eventIndex;
    remoteEventWaitTaskInfo->srcDevId = srcDeviceId;
    remoteEventWaitTaskInfo->dstDevId = static_cast<int32_t>(stream->Device_()->Id_());
    // Event is record on source device, and wait on destination device.
    // But for event query message in the processing of RemoteEventWait,
    // the "source device" is destination of message, "destination device"
    // is source of message.

    return RT_ERROR_NONE;
}

void RemoteEventWaitTaskUnInit(TaskInfo * const taskInfo)
{
    RemoteEventWaitTaskInfo *remoteEventWaitTaskInfo = &(taskInfo->u.remoteEventWaitTaskInfo);

    remoteEventWaitTaskInfo->channelType = static_cast<uint8_t>(UINT8_MAX);
    remoteEventWaitTaskInfo->srcMailboxPa = 0LU;
    remoteEventWaitTaskInfo->srcDoorbellPa = 0LU;
    remoteEventWaitTaskInfo->dstDoorbellPa = 0LU;
    remoteEventWaitTaskInfo->event = nullptr;

    return;
}

void ToCommandBodyForRemoteEventWaitTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    RemoteEventWaitTaskInfo *remoteEventWaitTaskInfo = &(taskInfo->u.remoteEventWaitTaskInfo);
    COND_LOG(remoteEventWaitTaskInfo->srcMailboxPa == 0U, "srcMailboxPa_ = 0");
    COND_LOG(remoteEventWaitTaskInfo->srcDoorbellPa == 0U, "srcDoorbellPa_ = 0");
    COND_LOG(remoteEventWaitTaskInfo->dstDoorbellPa == 0U, "dstDoorbellPa_ = 0");
    command->u.remoteEventWaitTask.srcMailboxPa = remoteEventWaitTaskInfo->srcMailboxPa;
    command->u.remoteEventWaitTask.srcDoorbellPa = remoteEventWaitTaskInfo->srcDoorbellPa;
    command->u.remoteEventWaitTask.dstDoorbellPa = remoteEventWaitTaskInfo->dstDoorbellPa;
    command->u.remoteEventWaitTask.srcEventId = static_cast<uint16_t>(remoteEventWaitTaskInfo->eventId);
    command->u.remoteEventWaitTask.srcDeviceId = static_cast<uint16_t>(remoteEventWaitTaskInfo->srcDevId);
    command->u.remoteEventWaitTask.dstDeviceId = static_cast<uint16_t>(remoteEventWaitTaskInfo->dstDevId);
    command->u.remoteEventWaitTask.channelType = remoteEventWaitTaskInfo->channelType;
    if (remoteEventWaitTaskInfo->event != nullptr) {
        remoteEventWaitTaskInfo->event->InsertWaitToMap(taskInfo);
    }
}

void DoCompleteSuccessForRemoteEventWaitTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    RemoteEventWaitTaskInfo *remoteEventWaitTaskInfo = &(taskInfo->u.remoteEventWaitTaskInfo);
    Stream * const stream = taskInfo->stream;
    COND_RETURN_VOID(remoteEventWaitTaskInfo->event == nullptr,
                     "event is nullptr, device_id=%u", stream->Device_()->Id_());
    remoteEventWaitTaskInfo->event->DeleteWaitFromMap(taskInfo);
    TryToFreeEventIdAndDestroyEvent(&(remoteEventWaitTaskInfo->event), remoteEventWaitTaskInfo->eventId, false);
}
#endif

#if F_DESC("EventWaitTask")
rtError_t EventWaitTaskInit(TaskInfo * const taskInfo, Event *const eventRec, const int32_t eventIndex,
                            const uint32_t timeout, const uint8_t waitFlag)
{
    EventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.eventWaitTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_STREAM_WAIT_EVENT;
    taskInfo->typeName = const_cast<char_t*>("EVENT_WAIT");
    eventWaitTaskInfo->event = eventRec;
    eventWaitTaskInfo->eventId = eventIndex;
    eventWaitTaskInfo->timeout = timeout;
    eventWaitTaskInfo->eventWaitFlag = waitFlag;

    return RT_ERROR_NONE;
}

void ToCommandBodyForEventWaitTask(TaskInfo * const taskInfo, rtCommand_t *const command)
{
    EventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.eventWaitTaskInfo);
    Stream * const stream = taskInfo->stream;

    command->u.streamWaitEventTask.eventID = static_cast<uint16_t>(eventWaitTaskInfo->eventId);
    command->u.streamWaitEventTask.nextStreamIdx = static_cast<uint16_t>(UINT16_MAX);
    command->u.streamWaitEventTask.timeout = eventWaitTaskInfo->timeout;
    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    uintptr_t eventLowEightAddr = 0;
    if (eventWaitTaskInfo->event != nullptr) {
        eventLowEightAddr = (reinterpret_cast<uintptr_t>(eventWaitTaskInfo->event)) & 0xFFULL;
    }
    param.u.eventWaitParams = {eventWaitTaskInfo->eventId, false, eventLowEightAddr};
    AtraceSubmitLog(TYPE_EVENT_WAIT, param);
    COND_RETURN_NORMAL(eventWaitTaskInfo->event == nullptr, "notify event, device_id=%u", stream->Device_()->Id_());
    eventWaitTaskInfo->event->InsertWaitToMap(taskInfo);
    if (!eventWaitTaskInfo->event->IsNotify()) {
        command->u.streamWaitEventTask.isNotify = 0U;
    } else {
        command->u.streamWaitEventTask.isNotify = 1U;
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, event_id=%d",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventWaitTaskInfo->eventId);
}

void DoCompleteSuccessForEventWaitTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    EventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.eventWaitTaskInfo);
    Stream * const stream = taskInfo->stream;
    const uint32_t errorCode = taskInfo->errorCode;
    COND_RETURN_NORMAL(eventWaitTaskInfo->event == nullptr, "notify event, device_id=%u", stream->Device_()->Id_());
    eventWaitTaskInfo->event->DeleteWaitFromMap(taskInfo);
    RT_LOG(RT_LOG_INFO, "event_wait: device_id=%u, stream_id=%d, task_id=%hu, event_id=%u, sq_id=%u",
        devId, stream->Id_(), taskInfo->id, eventWaitTaskInfo->eventId, stream->GetSqId());
    TryToFreeEventIdAndDestroyEvent(&(eventWaitTaskInfo->event), eventWaitTaskInfo->eventId, false);
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        if (errorCode == TS_ERROR_END_OF_SEQUENCE) {
            RT_LOG(RT_LOG_INFO, "end of seq for aicpu normal.");
            stream->SetErrCode(errorCode);
        } else {
            RT_LOG(RT_LOG_ERROR, "event wait error, retCode=%#x, [%s].",
                errorCode, GetTsErrCodeDesc(errorCode));
            stream->SetErrCode(errorCode);
            PrintErrorInfo(taskInfo, devId);
        }
    }
}

void ConstructSqeForEventWaitTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    EventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.eventWaitTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsEventSqe *evSqe = &(command->eventSqe);
    evSqe->header.type = RT_STARS_SQE_TYPE_EVENT_WAIT;
    evSqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    RT_LOG(RT_LOG_INFO, "timeout_=%u.", eventWaitTaskInfo->timeout);
    evSqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    evSqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    evSqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;

    evSqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    evSqe->eventId = static_cast<uint16_t>(eventWaitTaskInfo->eventId);
    evSqe->header.task_id = taskInfo->id;

    evSqe->res2 = 0U;
    evSqe->res3 = 0U;
    evSqe->timeout = eventWaitTaskInfo->timeout;
    uintptr_t eventLowEightAddr = 0;
    if (eventWaitTaskInfo->event != nullptr) {
        eventWaitTaskInfo->event->InsertWaitToMap(taskInfo);
        eventLowEightAddr = (reinterpret_cast<uintptr_t>(eventWaitTaskInfo->event)) & 0xFFULL;
    }

    PrintSqe(command, "EventWaitTask");
    AtraceParams param = { stream->Device_()->Id_(), static_cast<uint32_t>(stream->Id_()), taskInfo->id,
        GetCurrentTid(), stream->Device_()->GetAtraceHandle(), {}};
    param.u.eventWaitParams = { eventWaitTaskInfo->eventId, false, eventLowEightAddr};
    AtraceSubmitLog(TYPE_EVENT_WAIT, param);
    RT_LOG(RT_LOG_INFO, "event_wait: device_id=%u, stream_id=%d, task_id=%hu, event_id=%d, sq_id=%u, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventWaitTaskInfo->eventId, stream->GetSqId(),
        eventWaitTaskInfo->timeout);
}

void PrintErrorInfoForEventWaitTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    const int32_t streamId = taskInfo->stream->Id_();

    EventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.eventWaitTaskInfo);
    if (eventWaitTaskInfo->eventWaitFlag == 1U) { // notify wait
        taskInfo->type = TS_TASK_TYPE_NOTIFY_WAIT;
        taskInfo->typeName = const_cast<char_t*>("NOTIFY_WAIT");
    }

    Stream * const reportStream = GetReportStream(taskInfo->stream);
    uint64_t flag = MAX_UINT64_NUM;
    const Event * const event = eventWaitTaskInfo->event;
    if (event != nullptr) {
        flag = event->GetEventFlag();
    }

    if (taskInfo->errorCode == TS_ERROR_AICPU_TIMEOUT) {
        RT_LOG_OUTER_MSG(RT_AICPU_TIMEOUT_ERROR, "Aicpu execute fail, "
            "device_id=%u, stream_id=%d", devId, streamId);
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU_TIMEOUT, "Task execute failed, "
            "device_id=%u, stream_id=%d, %s=%hu, flip_num=%hu, task_type=%d(%s), event_flag=%#" PRIx64 ". ",
            devId, streamId, TaskIdDesc(), taskInfo->id, taskInfo->flipNum,
            static_cast<int32_t>(taskInfo->type), taskInfo->typeName, flag);
    } else {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL, "Task execute failed, "
            "device_id=%u, stream_id=%d, %s=%hu, flip_num=%hu, task_type=%d(%s), event_flag=%#" PRIx64 ". ",
            devId, streamId, TaskIdDesc(), taskInfo->id, taskInfo->flipNum,
            static_cast<int32_t>(taskInfo->type), taskInfo->typeName, flag);
    }
}

void SetStarsResultForEventWaitTask(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    taskInfo->errorCode = logicCq.errorCode;
}
#endif
}  // namespace runtime
}  // namespace cce
