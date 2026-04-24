/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "event.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "capture_model.hpp"
#include "stub_task.hpp"
#include "thread_local_container.hpp"

namespace cce {
namespace runtime {

#if F_DESC("EventRecordTask")
void SetResultForEventRecordTask(TaskInfo * const taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    EventRecordTaskInfo *eventRecordTaskInfo = &(taskInfo->u.eventRecordTaskInfo);

    const auto *const tsData = static_cast<const uint32_t *>(data);
    eventRecordTaskInfo->timestamp = static_cast<uint64_t>(tsData[0]) |
        (static_cast<uint64_t>(tsData[1]) << 32U); // shift 32 bit
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
#endif
}  // namespace runtime
}  // namespace cce
