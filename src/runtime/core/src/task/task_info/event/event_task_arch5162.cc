/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "event_task.h"
#include "task_info_v100.h"
#include "notify_task.h"
#include "event.hpp"
#include "stream.hpp"
#include "stars.hpp"
#include "runtime_task_manager.h"

namespace cce {
namespace runtime {

constexpr uint32_t WR_NOTIFY_RECORD_VALUE = 0x80001U;
constexpr uint32_t WR_EVENT_RECORD_VALUE = 0x800FFU;
constexpr uint32_t WR_EVENT_RESET_VALUE = 0x80000U;

uint16_t GetSqeEventId(const rtStarsSqe_t* sqe) { return sqe->notifySqe.notify_id; }

#if F_DESC("NotifyRecordTask")
void ConstructSqeForNotifyRecordTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    Stream* const stm = taskInfo->stream;
    RtStarsWriteValueSqe* sqe = &(command->writeValueSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.taskId = taskInfo->id;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());

    /* word2-15 */
    sqe->subType = RT_SQE_SUBTYPE_NOTIFY_ID;
    sqe->notifyId = taskInfo->u.notifyrecordTask.notifyId;
    sqe->awsize = 2U;
    sqe->awprot = 2U;
    sqe->writeValuePart[0] = WR_NOTIFY_RECORD_VALUE;
    PrintSqe(command, "Notify Record Task");
    RT_LOG(RT_LOG_INFO, "NotifyRecordTask stream_id=%d task_id=%hu.", taskInfo->stream->Id_(), taskInfo->id);
}
#endif

#if F_DESC("NotifyWaitTask")
static void ConstructSqeForNotifyWaitTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    NotifyWaitTaskInfo* notifyWaitTask = &(taskInfo->u.notifywaitTask);
    Stream* const stm = taskInfo->stream;
    RtStarsNotifySqe* const sqe = &(command->notifySqe);
    sqe->header.type = RT_STARS_SQE_TYPE_NOTIFY_WAIT;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.taskId = taskInfo->id;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->notify_id = static_cast<uint16_t>(notifyWaitTask->notifyId);
    sqe->timeoutEn = notifyWaitTask->timeout > 0 ? 1U : 0U;

    PrintSqe(command, "Notify Wait Task");
    RT_LOG(RT_LOG_INFO, "NotifyWaitTask stream_id=%d task_id=%hu.", taskInfo->stream->Id_(), taskInfo->id);
}
#endif

#if F_DESC("EventRecordTask")
static void ConstructSqeForEventRecordTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    EventRecordTaskInfo* eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    Stream* const stm = taskInfo->stream;
    const uint16_t wrCqe =
        (((eventRecordTaskInfo->event->GetEventFlag() & RT_EVENT_TIME_LINE) != 0U) ||
                 static_cast<bool>((taskInfo->isCqeNeedConcern)) ?
             1U :
             0U);
    if (eventRecordTaskInfo->event->IsEventWithoutWaitTask()) {
        RtStarsWriteValueSqe* sqe = &(command->writeValueSqe);
        sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
        sqe->header.wrCqe = wrCqe;
        sqe->header.taskId = taskInfo->id;
        sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    } else {
        RtStarsWriteValueSqe* sqe = &(command->writeValueSqe);
        sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
        sqe->header.wrCqe = wrCqe;
        sqe->header.taskId = taskInfo->id;
        sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
        sqe->notifyId = static_cast<uint16_t>(eventRecordTaskInfo->eventid);
        sqe->subType = RT_SQE_SUBTYPE_NOTIFY_ID;
        sqe->awsize = 2U;
        sqe->awprot = 2U;
        sqe->writeValuePart[0] = WR_EVENT_RECORD_VALUE;
    }

    eventRecordTaskInfo->event->InsertRecordResetToMap(taskInfo);
    RecordTaskInfo latestRecord = {taskInfo->stream->Id_(), taskInfo->id, RECORDING};
    eventRecordTaskInfo->event->UpdateLatestRecord(latestRecord, eventRecordTaskInfo->eventid);

    PrintSqe(command, "Event Record Task");
    RT_LOG(RT_LOG_INFO, "EventRecordTask stream_id=%d task_id=%hu.", taskInfo->stream->Id_(), taskInfo->id);
}
#endif

#if F_DESC("EventResetTask")
static void ConstructSqeForEventResetTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    EventResetTaskInfo* eventResetTaskInfo = &(taskInfo->u.eventResetTaskInfo);
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    Stream* const stm = taskInfo->stream;
    RtStarsWriteValueSqe* const sqe = &(command->writeValueSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.taskId = taskInfo->id;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());

    /* word2-15 */
    sqe->subType = RT_SQE_SUBTYPE_NOTIFY_ID;
    sqe->notifyId = static_cast<uint16_t>(eventResetTaskInfo->eventid);
    sqe->awsize = 2U;
    sqe->awprot = 2U;
    sqe->writeValuePart[0] = WR_EVENT_RESET_VALUE;

    if (eventResetTaskInfo->event != nullptr) {
        eventResetTaskInfo->event->InsertRecordResetToMap(taskInfo);
    }
    PrintSqe(command, "Event Reset Task");
    RT_LOG(RT_LOG_INFO, "EventResetTask stream_id=%d task_id=%hu.", taskInfo->stream->Id_(), taskInfo->id);
}
#endif

#if F_DESC("EventWaitTask")
static void ConstructSqeForEventWaitTask(TaskInfo* taskInfo, rtStarsSqe_t* const command)
{
    EventWaitTaskInfo* eventWaitTaskInfo = &(taskInfo->u.eventWaitTaskInfo);
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    Stream* const stm = taskInfo->stream;
    RtStarsNotifySqe* const sqe = &(command->notifySqe);
    sqe->header.type = RT_STARS_SQE_TYPE_NOTIFY_WAIT;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.taskId = taskInfo->id;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->notify_id = static_cast<uint16_t>(eventWaitTaskInfo->eventId);
    sqe->timeoutEn = eventWaitTaskInfo->timeout > 0 ? 1U : 0U;

    if (eventWaitTaskInfo->event != nullptr) {
        eventWaitTaskInfo->event->InsertWaitToMap(taskInfo);
    }
    PrintSqe(command, "Event Wait Task");
    RT_LOG(RT_LOG_INFO, "EventWaitTask stream_id=%d task_id=%hu.", taskInfo->stream->Id_(), taskInfo->id);
}
#endif

static bool EventTaskRegister()
{
    TaskFuncSingle eventWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForEventWaitTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForEventWaitTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForEventWaitTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultForEventWaitTask,
    };
    TaskFuncSingle eventRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForEventRecordTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForEventRecordTask,
        .taskUnInitFunc = &EventRecordTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultForEventRecordTask,
    };
    TaskFuncSingle eventResetFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForEventResetTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForEventResetTask,
        .taskUnInitFunc = &EventResetTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle notifyWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForNotifyWaitTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForNotifyWaitTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForNotifyWaitTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle notifyRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForNotifyRecordTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForNotifyRecordTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_STREAM_WAIT_EVENT, eventWaitFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_EVENT_RECORD, eventRecordFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_EVENT_RESET, eventResetFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_NOTIFY_WAIT, notifyWaitFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_NOTIFY_RECORD, notifyRecordFuncs);

    return true;
}

static bool g_eventTaskRegister = EventTaskRegister();

} // namespace runtime
} // namespace cce
