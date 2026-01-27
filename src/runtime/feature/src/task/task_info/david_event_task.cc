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
#include "event_david.hpp"
#include "task_manager.h"
#include "stars.hpp"
#include "stars_david.hpp"
#include "task_david.hpp"
#include "device.hpp"
#include "task_info.h"
#include "error_code.h"

namespace cce {
namespace runtime {
#if F_DESC("DavidEventRecordTask")
rtError_t DavidEventRecordTaskInit(TaskInfo * const taskInfo, Event * const eventPtr, const int32_t newEventId)
{
    NULL_PTR_RETURN(eventPtr, RT_ERROR_INVALID_VALUE);
    DavidEventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_DAVID_EVENT_RECORD;
    taskInfo->typeName = "EVENT_RECORD";
    taskInfo->needPostProc = true;
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventPtr);
    eventRecordTaskInfo->event = evt;
    eventRecordTaskInfo->timestamp = 0ULL;
    eventRecordTaskInfo->eventId = newEventId;
    eventRecordTaskInfo->timeout = -1;
    eventRecordTaskInfo->isCountNotify = evt->IsCntNotify();

    if ((evt->GetEventFlag() & RT_EVENT_TIME_LINE) != 0U) {
        taskInfo->isCqeNeedConcern = stream->GetBindFlag() ? 0U : 1U; // only simply stream recycle cqe.
    }
    return RT_ERROR_NONE;
}

void DavidEventRecordTaskUnInit(TaskInfo * const taskInfo)
{
    DavidEventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventRecordTaskInfo->event);
    COND_RETURN_NORMAL(evt == nullptr, "event is null, device_id=%u", stream->Device_()->Id_());
    evt->RecordDavidEventComplete(taskInfo, UINT64_MAX);
    const rtError_t deviceStatus = stream->Device_()->GetDeviceStatus();
    const rtError_t streamAbortStatus = stream->GetAbortStatus();
    if ((deviceStatus == RT_ERROR_DEVICE_TASK_ABORT) || (streamAbortStatus == RT_ERROR_STREAM_ABORT)) {
        (void)evt->ClearRecordStatus();
    }
    DavidUpdateAndTryToDestroyEvent(
        taskInfo, &(eventRecordTaskInfo->event), DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP);

    eventRecordTaskInfo->eventId = INVALID_EVENT_ID;
    eventRecordTaskInfo->event = nullptr;
}

void SetStarsResultForDavidEventRecordTask(TaskInfo * const taskInfo, const rtLogicCqReport_t &logicCq)
{
    DavidEventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) {
        eventRecordTaskInfo->timestamp = logicCq.u1.timeStamp;
    } else {
        taskInfo->errorCode = logicCq.errorCode;
    }
}

void DoCompleteSuccessForDavidEventRecordTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    DavidEventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventRecordTaskInfo->event);
    COND_RETURN_VOID(eventRecordTaskInfo->event == nullptr, "event is nullptr");
    if (unlikely(taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(taskInfo->errorCode);
        RT_LOG(RT_LOG_ERROR, "device_id=%u, task_type=%d (%s), retCode=%#x, [%s].",
               devId, static_cast<int32_t>(taskInfo->type), taskInfo->typeName,
               taskInfo->errorCode, GetTsErrCodeDesc(taskInfo->errorCode));
        PrintErrorInfo(taskInfo, devId);
    } else {
        evt->RecordDavidEventComplete(taskInfo, eventRecordTaskInfo->timestamp);
    }
    DavidUpdateAndTryToDestroyEvent(
        taskInfo, &(eventRecordTaskInfo->event), DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP);
    eventRecordTaskInfo->eventId = INVALID_EVENT_ID;
    eventRecordTaskInfo->event = nullptr;
    // model or simple must try to free id and destroy event.
    RT_LOG(RT_LOG_INFO, "event_record: device_id=%u, stream_id=%d, task_id=%hu, sq_id=%u, event_id=%u, "
        "timestamp=%#" PRIx64, stream->Device_()->Id_(), stream->Id_(), taskInfo->id,
        stream->GetSqId(), eventRecordTaskInfo->eventId, eventRecordTaskInfo->timestamp);
}

void ConstructDavidSqeForEventRecordTask(TaskInfo * const taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    DavidEventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream * const stream = taskInfo->stream;
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventRecordTaskInfo->event);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsNotifySqe *sqe = &(command->notifySqe);
    const rtDavidStarsSqeType evtSqeType = evt->IsEventWithoutWaitTask() ?
        RT_DAVID_SQE_TYPE_PLACE_HOLDER : RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    sqe->header.wrCqe = (taskInfo->isCqeNeedConcern == 1U) ? 1U : 0U; // 1: set wr_cqe
    sqe->header.type = static_cast<uint8_t>(evtSqeType);

    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->notifyId = static_cast<uint32_t>(eventRecordTaskInfo->eventId);
    sqe->cntFlag = eventRecordTaskInfo->isCountNotify;
    sqe->clrFlag = 0U;
    sqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_SINGLE_NOTIFY_RECORD;
    if ((eventRecordTaskInfo->isCountNotify == 1U) && (evtSqeType == RT_DAVID_SQE_TYPE_NOTIFY_RECORD)) {
        (void)stream->ApplyCntValue(sqe->cntValue);
        evt->SetCntValue(sqe->cntValue);
        eventRecordTaskInfo->countValue = sqe->cntValue;
        sqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_COUNT_NOTIFY_RECORD;
    }

    evt->InsertRecordResetToMap(taskInfo);
    DavidRecordTaskInfo latestRecord = {stream->Id_(), static_cast<uint32_t>(taskInfo->id)};
    evt->UpdateLatestRecord(latestRecord, DavidEventState_t::EVT_NOT_RECORDED, UINT64_MAX);

    PrintDavidSqe(command, "EventRecordTask");
    RT_LOG(RT_LOG_INFO, "event_record: device_id=%u, stream_id=%hu, task_id=%hu, task_sn=%u, sq_id=%u, event_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(),
        sqe->notifyId, sqe->cntFlag, sqe->clrFlag, sqe->waitModeBit, sqe->recordModeBit, sqe->bitmap, sqe->cntValue,
        GetNotifySubType(sqe->subType), sqe->timeout);
}
#endif

#if F_DESC("DavidEventWaitTask")
void DavidEventWaitTaskInit(TaskInfo * const taskInfo, Event * const eventPtr, const int32_t eventIndex,
    const uint32_t timeout)
{
    DavidEventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_DAVID_EVENT_WAIT;
    taskInfo->typeName = "EVENT_WAIT";
    taskInfo->needPostProc = true;
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventPtr);
    eventWaitTaskInfo->event = evt;
    eventWaitTaskInfo->eventId = eventIndex;
    eventWaitTaskInfo->timeout = timeout;
    eventWaitTaskInfo->isCountNotify = evt->IsCntNotify();
    eventWaitTaskInfo->countValue = evt->CntValue();
}

void DavidEventWaitTaskUnInit(TaskInfo * const taskInfo)
{
    DavidEventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    Stream * const stream = taskInfo->stream;
    COND_RETURN_NORMAL(eventWaitTaskInfo->event == nullptr, "event is null, device_id=%u", stream->Device_()->Id_());
    RT_LOG(RT_LOG_INFO, "event_wait: device_id=%u, stream_id=%d, task_id=%hu, event_id=%u, sq_id=%u",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventWaitTaskInfo->eventId, stream->GetSqId());

    DavidUpdateAndTryToDestroyEvent(taskInfo, &(eventWaitTaskInfo->event), DavidTaskMapType::TASK_MAP_TYPE_WAIT_MAP);
    eventWaitTaskInfo->eventId = INVALID_EVENT_ID;
    eventWaitTaskInfo->event = nullptr;
}

void PrintErrorInfoForDavidEventWaitTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    const int32_t streamId = taskInfo->stream->Id_();
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    if (taskInfo->errorCode == TS_ERROR_AICPU_TIMEOUT) {
        RT_LOG_OUTER_MSG(RT_AICPU_TIMEOUT_ERROR, "Aicpu execute fail, device_id=%u, stream_id=%d", devId, streamId);
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU_TIMEOUT,
            "Task execute failed, device_id=%u, stream_id=%d, task_pos=%hu, flip_num=%hu, task_type=%d(%s).",
            devId, streamId, taskInfo->id, taskInfo->flipNum, static_cast<int32_t>(taskInfo->type), taskInfo->typeName);
    } else {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_HCCL,
            "Task execute failed, device_id=%u, stream_id=%d, task_pos=%hu, flip_num=%hu, task_type=%d(%s).",
            devId, streamId, taskInfo->id, taskInfo->flipNum, static_cast<int32_t>(taskInfo->type), taskInfo->typeName);
    }
}

void DoCompleteSuccessForDavidEventWaitTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    DavidEventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    Stream * const stream = taskInfo->stream;
    COND_RETURN_NORMAL(eventWaitTaskInfo->event == nullptr, "event wait, device_id=%u", stream->Device_()->Id_());
    const uint32_t errorCode = taskInfo->errorCode;
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

void ConstructDavidSqeForEventWaitTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stream = taskInfo->stream;
    DavidEventWaitTaskInfo *eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventWaitTaskInfo->event);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsNotifySqe * const evSqe = &(command->notifySqe);

    evSqe->header.wrCqe = stream->GetStarsWrCqeFlag();

    evSqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_WAIT;
    evSqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    evSqe->notifyId = static_cast<uint16_t>(eventWaitTaskInfo->eventId);
    evSqe->clrFlag = 0U;
    evSqe->cntFlag = 0U;
    evSqe->cntValue =  0U;
    evSqe->waitModeBit = 0U;
    evSqe->recordModeBit = 0U;
    evSqe->timeout = eventWaitTaskInfo->timeout;
    evSqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_SINGLE_NOTIFY_WAIT;

    if (eventWaitTaskInfo->isCountNotify == 1U) {
        evSqe->cntFlag = 1U;
        evSqe->cntValue = eventWaitTaskInfo->countValue;
        evSqe->waitModeBit = WAIT_BIGGER_OR_EQUAL_MODE ; // greater && equal
        evSqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_COUNT_NOTIFY_WAIT;
    }
    evt->InsertWaitToMap(taskInfo);
    PrintDavidSqe(command, "EventWaitTask");
    RT_LOG(RT_LOG_INFO, "event_wait: device_id=%u, stream_id=%d, task_id=%u, task_sn=%u, sq_id=%u, event_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(),
        evSqe->notifyId, evSqe->cntFlag, evSqe->clrFlag, evSqe->waitModeBit, evSqe->recordModeBit, evSqe->bitmap,
        evSqe->cntValue, GetNotifySubType(evSqe->subType), evSqe->timeout);
}
#endif

#if F_DESC("DavidEventResetTask")
void DavidEventResetTaskInit(TaskInfo * const taskInfo, Event * const eventPtr, const int32_t eventIndex)
{
    DavidEventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_DAVID_EVENT_RESET;
    taskInfo->typeName = "EVENT_RESET";
    taskInfo->needPostProc = true;
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventPtr);
    eventResetTaskInfo->eventId = eventIndex;
    eventResetTaskInfo->event = evt;
    eventResetTaskInfo->isCountNotify = evt->IsCntNotify();
    return;
}

void DavidEventResetTaskUnInit(TaskInfo * const taskInfo)
{
    DavidEventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    Stream * const stream = taskInfo->stream;
    COND_RETURN_NORMAL(eventResetTaskInfo->event == nullptr, "event is null, device_id=%u",
        stream->Device_()->Id_());
    RT_LOG(RT_LOG_INFO, "event_reset: device_id=%u, stream_id=%d, task_id=%hu, event_id=%d, sq_id=%u,",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventResetTaskInfo->eventId, stream->GetSqId());
    DavidUpdateAndTryToDestroyEvent(
        taskInfo, &(eventResetTaskInfo->event), DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP);
    eventResetTaskInfo->eventId = INVALID_EVENT_ID;
    eventResetTaskInfo->event = nullptr;
    return;
}

void DoCompleteSuccessForDavidEventResetTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    DavidEventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    Stream * const stream = taskInfo->stream;

    COND_RETURN_NORMAL(eventResetTaskInfo->event == nullptr, "notify event, device_id=%u", stream->Device_()->Id_());
    DoCompleteSuccess(taskInfo, devId);
}

void ConstructDavidSqeForEventResetTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stream = taskInfo->stream;
    DavidEventResetTaskInfo *eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    DavidEvent *evt = dynamic_cast<DavidEvent *>(eventResetTaskInfo->event);
    RtDavidStarsNotifySqe * const evSqe = &(command->notifySqe);
    evSqe->header.wrCqe = stream->GetStarsWrCqeFlag();

    evSqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    evSqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    evSqe->notifyId = static_cast<uint16_t>(eventResetTaskInfo->eventId);
    evSqe->clrFlag = 1U;  // reset will clear bits
    evSqe->cntValue =  0U;
    evSqe->waitModeBit = 0U;
    evSqe->recordModeBit = 0U;
    evSqe->cntFlag = eventResetTaskInfo->isCountNotify;
    const rtDavidNotifySubType subType = (eventResetTaskInfo->isCountNotify == 1U) ?
        NOTIFY_SUB_TYPE_EVENT_RESET_USE_COUNT_NOTIFY : NOTIFY_SUB_TYPE_EVENT_RESET_USE_SINGLE_NOTIFY;
    evSqe->subType = static_cast<uint16_t>(subType);

    evt->InsertRecordResetToMap(taskInfo);
    PrintDavidSqe(command, "EventResetTask");
    RT_LOG(RT_LOG_INFO, "event_reset: device_id=%u, stream_id=%d, task_id=%u, task_sn=%u, sq_id=%u, event_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(),
        evSqe->notifyId, evSqe->cntFlag, evSqe->clrFlag, evSqe->waitModeBit, evSqe->recordModeBit, evSqe->bitmap,
        evSqe->cntValue, GetNotifySubType(evSqe->subType), evSqe->timeout);
}

void DavidUpdateAndTryToDestroyEvent(TaskInfo *taskInfo, Event **eventPtr, DavidTaskMapType taskMapType)
{
    COND_RETURN_VOID(*eventPtr == nullptr, "event is nullptr");
    bool canEventbeDelete = false;
    if (taskMapType == DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP) {
        canEventbeDelete = (dynamic_cast<DavidEvent *>(*eventPtr))->DavidUpdateRecordMapAndDestroyEvent(taskInfo);
    } else if (taskMapType == DavidTaskMapType::TASK_MAP_TYPE_WAIT_MAP) {
        canEventbeDelete = (dynamic_cast<DavidEvent *>(*eventPtr))->DavidUpdateWaitMapAndDestroyEvent(taskInfo);
    } else {
        // no op
    }
    if (canEventbeDelete) {
        if ((*eventPtr)->IsCapturing()) {
            CaptureModel * const mdl = (*eventPtr)->GetCaptureModel();
            mdl->DeleteSingleOperEvent(*eventPtr);
            (*eventPtr)->SetCaptureEvent(nullptr);
        }
        delete *eventPtr;
        (*eventPtr) = nullptr;
    }
}
#endif
}  // namespace runtime
}  // namespace cce