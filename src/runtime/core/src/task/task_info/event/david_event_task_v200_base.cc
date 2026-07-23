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
#include "event_david.hpp"
#include "event_task.h"
#include "runtime_task_manager.h"
#include "stars.hpp"
#include "stars_david.hpp"
#include "task_david.hpp"
#include "device.hpp"
#include "error_code.h"

namespace cce {
namespace runtime {
uint16_t GetSqeEventId(const rtStarsSqe_t* sqe) { return sqe->eventSqe.eventId; }

#if F_DESC("DavidEventRecordTask")
rtError_t DavidEventRecordTaskInit(TaskInfo* const taskInfo, Event* const eventPtr, const int32_t newEventId)
{
    NULL_PTR_RETURN(eventPtr, RT_ERROR_INVALID_VALUE);
    DavidEventRecordTaskInfo* eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream* const stream = taskInfo->stream;
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_DAVID_EVENT_RECORD;
    taskInfo->typeName = "EVENT_RECORD";
    taskInfo->needPostProc = true;
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventPtr);
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

void DavidEventRecordTaskUnInit(TaskInfo* const taskInfo)
{
    DavidEventRecordTaskInfo* eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream* const stream = taskInfo->stream;
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventRecordTaskInfo->event);
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

void SetStarsResultForDavidEventRecordTask(TaskInfo* const taskInfo, const rtLogicCqReport_t& logicCq)
{
    DavidEventRecordTaskInfo* eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) {
        eventRecordTaskInfo->timestamp = logicCq.u1.timeStamp;
    } else {
        taskInfo->errorCode = logicCq.errorCode;
    }
}

void DoCompleteSuccessForDavidEventRecordTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    UNUSED(devId);
    DavidEventRecordTaskInfo* eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream* const stream = taskInfo->stream;
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventRecordTaskInfo->event);
    COND_RETURN_VOID(eventRecordTaskInfo->event == nullptr, "event is nullptr");
    if (unlikely(taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        taskInfo->stream->SetErrCode(taskInfo->errorCode);
        RT_LOG(
            RT_LOG_ERROR, "device_id=%u, task_type=%d (%s), retCode=%#x, [%s].", devId,
            static_cast<int32_t>(taskInfo->type), taskInfo->typeName, taskInfo->errorCode,
            GetTsErrCodeDesc(taskInfo->errorCode));
        PrintErrorInfo(taskInfo, devId);
    } else {
        evt->RecordDavidEventComplete(taskInfo, eventRecordTaskInfo->timestamp);
    }
    DavidUpdateAndTryToDestroyEvent(
        taskInfo, &(eventRecordTaskInfo->event), DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP);
    eventRecordTaskInfo->eventId = INVALID_EVENT_ID;
    eventRecordTaskInfo->event = nullptr;
    // model or simple must try to free id and destroy event.
    RT_LOG(
        RT_LOG_INFO,
        "event_record: device_id=%u, stream_id=%d, task_id=%hu, sq_id=%u, event_id=%u, "
        "timestamp=%#" PRIx64,
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, stream->GetSqId(), eventRecordTaskInfo->eventId,
        eventRecordTaskInfo->timestamp);
}

static void ConstructDavidSqeForEventRecordTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    DavidEventRecordTaskInfo* eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
    Stream* const stream = taskInfo->stream;
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventRecordTaskInfo->event);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsNotifySqe* notifySqe = &(davidSqe->notifySqe);
    const rtDavidStarsSqeType evtSqeType =
        evt->IsEventWithoutWaitTask() ? RT_DAVID_SQE_TYPE_PLACE_HOLDER : RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    notifySqe->header.wrCqe = (taskInfo->isCqeNeedConcern == 1U) ? 1U : 0U; // 1: set wr_cqe
    if (Runtime::Instance()->GetConnectUbFlag() && (stream->Flags() & RT_STREAM_PERSISTENT) == 0U) {
        notifySqe->header.headUpdate = 1U;
    }
    notifySqe->header.type = static_cast<uint8_t>(evtSqeType);

    notifySqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    notifySqe->notifyId = static_cast<uint32_t>(eventRecordTaskInfo->eventId);
    notifySqe->cntFlag = eventRecordTaskInfo->isCountNotify;
    notifySqe->clrFlag = 0U;
    notifySqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_SINGLE_NOTIFY_RECORD;
    if ((eventRecordTaskInfo->isCountNotify == 1U) && (evtSqeType == RT_DAVID_SQE_TYPE_NOTIFY_RECORD)) {
        (void)stream->ApplyCntValue(notifySqe->cntValue);
        evt->SetCntValue(notifySqe->cntValue);
        eventRecordTaskInfo->countValue = notifySqe->cntValue;
        notifySqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_COUNT_NOTIFY_RECORD;
    }

    evt->InsertRecordResetToMap(taskInfo);
    DavidRecordTaskInfo latestRecord = {stream->Id_(), static_cast<uint32_t>(taskInfo->id)};
    evt->UpdateLatestRecord(latestRecord, DavidEventState_t::EVT_NOT_RECORDED, UINT64_MAX);

    PrintDavidSqe(davidSqe, "EventRecordTask");
    RT_LOG(
        RT_LOG_INFO,
        "event_record: device_id=%u, stream_id=%hu, task_id=%hu, task_sn=%u, sq_id=%u, event_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(), notifySqe->notifyId,
        notifySqe->cntFlag, notifySqe->clrFlag, notifySqe->waitModeBit, notifySqe->recordModeBit, notifySqe->bitmap,
        notifySqe->cntValue, GetNotifySubType(notifySqe->subType), notifySqe->timeout);
}
#endif

#if F_DESC("DavidEventWaitTask")
void DavidEventWaitTaskInit(
    TaskInfo* const taskInfo, Event* const eventPtr, const int32_t eventIndex, const uint32_t timeout)
{
    DavidEventWaitTaskInfo* eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_DAVID_EVENT_WAIT;
    taskInfo->typeName = "EVENT_WAIT";
    taskInfo->needPostProc = true;
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventPtr);
    eventWaitTaskInfo->event = evt;
    eventWaitTaskInfo->eventId = eventIndex;
    eventWaitTaskInfo->timeout = timeout;
    eventWaitTaskInfo->isCountNotify = evt->IsCntNotify();
    eventWaitTaskInfo->countValue = evt->CntValue();
}

void DavidEventWaitTaskUnInit(TaskInfo* const taskInfo)
{
    DavidEventWaitTaskInfo* eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    Stream* const stream = taskInfo->stream;
    COND_RETURN_NORMAL(eventWaitTaskInfo->event == nullptr, "event is null, device_id=%u", stream->Device_()->Id_());
    RT_LOG(
        RT_LOG_INFO, "event_wait: device_id=%u, stream_id=%d, task_id=%hu, event_id=%u, sq_id=%u",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventWaitTaskInfo->eventId, stream->GetSqId());

    DavidUpdateAndTryToDestroyEvent(taskInfo, &(eventWaitTaskInfo->event), DavidTaskMapType::TASK_MAP_TYPE_WAIT_MAP);
    eventWaitTaskInfo->eventId = INVALID_EVENT_ID;
    eventWaitTaskInfo->event = nullptr;
}

void PrintErrorInfoForDavidEventWaitTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    const int32_t streamId = taskInfo->stream->Id_();
    Stream* const reportStream = GetReportStream(taskInfo->stream);
    if (taskInfo->errorCode == TS_ERROR_AICPU_TIMEOUT) {
        const std::string errMsg = "The AI CPU operator that times out is on device " + std::to_string(devId) +
                                   " stream " + std::to_string(streamId) + " task " + std::to_string(taskInfo->id) +
                                   ".";
        RT_LOG_OUTER_MSG(RT_AICPU_TIMEOUT_ERROR, "%s", errMsg.c_str());
        STREAM_REPORT_ERR_MSG(
            reportStream, ERR_MODULE_AICPU_TIMEOUT,
            "The task execution failed, device_id=%u, stream_id=%d, task_pos=%hu, flip_num=%hu, task_type=%d(%s).",
            devId, streamId, taskInfo->id, taskInfo->flipNum, static_cast<int32_t>(taskInfo->type), taskInfo->typeName);
    } else {
        STREAM_REPORT_ERR_MSG(
            reportStream, ERR_MODULE_HCCL,
            "The task execution failed, device_id=%u, stream_id=%d, task_pos=%hu, flip_num=%hu, task_type=%d(%s).",
            devId, streamId, taskInfo->id, taskInfo->flipNum, static_cast<int32_t>(taskInfo->type), taskInfo->typeName);
    }
}

void DoCompleteSuccessForDavidEventWaitTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    DavidEventWaitTaskInfo* eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    Stream* const stream = taskInfo->stream;
    COND_RETURN_NORMAL(eventWaitTaskInfo->event == nullptr, "event wait, device_id=%u", stream->Device_()->Id_());
    const uint32_t errorCode = taskInfo->errorCode;
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        if (errorCode == TS_ERROR_END_OF_SEQUENCE) {
            RT_LOG(RT_LOG_INFO, "end of seq for aicpu normal.");
            stream->SetErrCode(errorCode);
        } else {
            RT_LOG(RT_LOG_ERROR, "event wait error, retCode=%#x, [%s].", errorCode, GetTsErrCodeDesc(errorCode));
            stream->SetErrCode(errorCode);
            PrintErrorInfo(taskInfo, devId);
        }
    }
}

static void ConstructDavidSqeForEventWaitTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    Stream* const stream = taskInfo->stream;
    DavidEventWaitTaskInfo* eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventWaitTaskInfo->event);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsNotifySqe* const notifySqe = &(davidSqe->notifySqe);

    notifySqe->header.wrCqe = stream->GetStarsWrCqeFlag();

    notifySqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_WAIT;
    notifySqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    notifySqe->notifyId = static_cast<uint16_t>(eventWaitTaskInfo->eventId);
    notifySqe->clrFlag = 0U;
    notifySqe->cntFlag = 0U;
    notifySqe->cntValue = 0U;
    notifySqe->waitModeBit = 0U;
    notifySqe->recordModeBit = 0U;
    notifySqe->timeout = eventWaitTaskInfo->timeout;
    notifySqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_SINGLE_NOTIFY_WAIT;

    if (eventWaitTaskInfo->isCountNotify == 1U) {
        notifySqe->cntFlag = 1U;
        notifySqe->cntValue = eventWaitTaskInfo->countValue;
        notifySqe->waitModeBit = WAIT_BIGGER_OR_EQUAL_MODE; // greater && equal
        notifySqe->subType = NOTIFY_SUB_TYPE_EVENT_USE_COUNT_NOTIFY_WAIT;
    }
    evt->InsertWaitToMap(taskInfo);
    PrintDavidSqe(davidSqe, "EventWaitTask");
    RT_LOG(
        RT_LOG_INFO,
        "event_wait: device_id=%u, stream_id=%d, task_id=%u, task_sn=%u, sq_id=%u, event_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(), notifySqe->notifyId,
        notifySqe->cntFlag, notifySqe->clrFlag, notifySqe->waitModeBit, notifySqe->recordModeBit, notifySqe->bitmap,
        notifySqe->cntValue, GetNotifySubType(notifySqe->subType), notifySqe->timeout);
}
#endif

#if F_DESC("DavidEventResetTask")
void DavidEventResetTaskInit(TaskInfo* const taskInfo, Event* const eventPtr, const int32_t eventIndex)
{
    DavidEventResetTaskInfo* eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_DAVID_EVENT_RESET;
    taskInfo->typeName = "EVENT_RESET";
    taskInfo->needPostProc = true;
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventPtr);
    eventResetTaskInfo->eventId = eventIndex;
    eventResetTaskInfo->event = evt;
    eventResetTaskInfo->isCountNotify = evt->IsCntNotify();
    return;
}

void DavidEventResetTaskUnInit(TaskInfo* const taskInfo)
{
    DavidEventResetTaskInfo* eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    Stream* const stream = taskInfo->stream;
    COND_RETURN_NORMAL(eventResetTaskInfo->event == nullptr, "event is null, device_id=%u", stream->Device_()->Id_());
    RT_LOG(
        RT_LOG_INFO, "event_reset: device_id=%u, stream_id=%d, task_id=%hu, event_id=%d, sq_id=%u,",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, eventResetTaskInfo->eventId, stream->GetSqId());
    DavidUpdateAndTryToDestroyEvent(
        taskInfo, &(eventResetTaskInfo->event), DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP);
    eventResetTaskInfo->eventId = INVALID_EVENT_ID;
    eventResetTaskInfo->event = nullptr;
    return;
}

void DoCompleteSuccessForDavidEventResetTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    DavidEventResetTaskInfo* eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    Stream* const stream = taskInfo->stream;

    COND_RETURN_NORMAL(eventResetTaskInfo->event == nullptr, "notify event, device_id=%u", stream->Device_()->Id_());
    DoCompleteSuccess(taskInfo, devId);
}

static void ConstructDavidSqeForEventResetTask(TaskInfo* taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    UNUSED(sqeInfo);
    Stream* const stream = taskInfo->stream;
    DavidEventResetTaskInfo* eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    DavidEvent* evt = dynamic_cast<DavidEvent*>(eventResetTaskInfo->event);
    RtDavidStarsNotifySqe* const notifySqe = &(davidSqe->notifySqe);
    notifySqe->header.wrCqe = stream->GetStarsWrCqeFlag();

    notifySqe->header.type = RT_DAVID_SQE_TYPE_NOTIFY_RECORD;
    notifySqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    notifySqe->notifyId = static_cast<uint16_t>(eventResetTaskInfo->eventId);
    notifySqe->clrFlag = 1U; // reset will clear bits
    notifySqe->cntValue = 0U;
    notifySqe->waitModeBit = 0U;
    notifySqe->recordModeBit = 0U;
    notifySqe->cntFlag = eventResetTaskInfo->isCountNotify;
    const rtDavidNotifySubType subType = (eventResetTaskInfo->isCountNotify == 1U) ?
                                             NOTIFY_SUB_TYPE_EVENT_RESET_USE_COUNT_NOTIFY :
                                             NOTIFY_SUB_TYPE_EVENT_RESET_USE_SINGLE_NOTIFY;
    notifySqe->subType = static_cast<uint16_t>(subType);

    evt->InsertRecordResetToMap(taskInfo);
    PrintDavidSqe(davidSqe, "EventResetTask");
    RT_LOG(
        RT_LOG_INFO,
        "event_reset: device_id=%u, stream_id=%d, task_id=%u, task_sn=%u, sq_id=%u, event_id=%u, "
        "cntFlag=%u, clrFlag=%u, waitModeBit=%u, recordModeBit=%u, bitmap=%u, cntValue=%u, subType=%s, timeout=%us.",
        stream->Device_()->Id_(), stream->Id_(), taskInfo->id, taskInfo->taskSn, stream->GetSqId(), notifySqe->notifyId,
        notifySqe->cntFlag, notifySqe->clrFlag, notifySqe->waitModeBit, notifySqe->recordModeBit, notifySqe->bitmap,
        notifySqe->cntValue, GetNotifySubType(notifySqe->subType), notifySqe->timeout);
}

void DavidUpdateAndTryToDestroyEvent(TaskInfo* taskInfo, Event** eventPtr, DavidTaskMapType taskMapType)
{
    COND_RETURN_VOID(*eventPtr == nullptr, "event is nullptr");
    bool canEventbeDelete = false;
    if (taskMapType == DavidTaskMapType::TASK_MAP_TYPE_RECORD_RESET_MAP) {
        canEventbeDelete = (dynamic_cast<DavidEvent*>(*eventPtr))->DavidUpdateRecordMapAndDestroyEvent(taskInfo);
    } else if (taskMapType == DavidTaskMapType::TASK_MAP_TYPE_WAIT_MAP) {
        canEventbeDelete = (dynamic_cast<DavidEvent*>(*eventPtr))->DavidUpdateWaitMapAndDestroyEvent(taskInfo);
    } else {
        // no op
    }
    if (canEventbeDelete) {
        if ((*eventPtr)->IsCapturing()) {
            CaptureModel* const mdl = (*eventPtr)->GetCaptureModel();
            mdl->DeleteSingleOperEvent(*eventPtr);
            (*eventPtr)->SetCaptureEvent(nullptr);
        }
        delete *eventPtr;
        (*eventPtr) = nullptr;
    }
}
#endif

static bool EventTaskRegister()
{
    TaskFuncSingle remoteEventWaitFuncs = {
        .toCommandFunc = &ToCommandBodyForRemoteEventWaitTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };
    TaskFuncSingle davidEventRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForDavidEventRecordTask,
        .taskUnInitFunc = &DavidEventRecordTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForDavidEventRecordTask,
    };
    TaskFuncSingle davidEventWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForDavidEventWaitTask,
        .taskUnInitFunc = &DavidEventWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForDavidEventWaitTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForEventWaitTask,
    };
    TaskFuncSingle davidEventResetFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForDavidEventResetTask,
        .taskUnInitFunc = &DavidEventResetTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultCommonForDavid,
    };

    const auto& chips = GetDavidChips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_REMOTE_EVENT_WAIT, remoteEventWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_DAVID_EVENT_RECORD, davidEventRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_DAVID_EVENT_WAIT, davidEventWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_DAVID_EVENT_RESET, davidEventResetFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_REMOTE_EVENT_WAIT, &ConstructDavidSqeBase);
    RegDavidSqeFunc(TS_TASK_TYPE_DAVID_EVENT_RECORD, &ConstructDavidSqeForEventRecordTask);
    RegDavidSqeFunc(TS_TASK_TYPE_DAVID_EVENT_WAIT, &ConstructDavidSqeForEventWaitTask);
    RegDavidSqeFunc(TS_TASK_TYPE_DAVID_EVENT_RESET, &ConstructDavidSqeForEventResetTask);
    return true;
}

static bool g_eventTaskRegister = EventTaskRegister();
} // namespace runtime
} // namespace cce
