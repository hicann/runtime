/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cinttypes>
#include "event_c.hpp"
#include "stars_david.hpp"
#include "task_david.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "stream_david.hpp"
#include "profiler_c.hpp"
#include "event_david.hpp"
#include "event_resource.hpp"
#include "common_task.h"
#include "event_state_callback_manager.hpp"
namespace cce {
namespace runtime {

rtError_t EvtRecord(Event* const evt, Stream* const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Event recording");
    rtError_t error = RT_ERROR_NONE;
    DavidEvent* davidEvt = static_cast<DavidEvent*>(evt);
    int32_t newEventId = davidEvt->EventId_();
    const bool oldHasReset = davidEvt->HasReset();
    const bool oldHasRecord = davidEvt->HasRecord();
    TaskInfo* tsk = nullptr;
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    stm->StreamLock();
    tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_DAVID_EVENT_RECORD, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(tsk == nullptr, error, stm->StreamUnLock();
                                     , "Failed to allocate task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = tsk->id;
    dstStm = tsk->stream;

    if (davidEvt->IsNewMode() || davidEvt->GetEventFlag() == RT_EVENT_DEFAULT) {
        error = davidEvt->AllocEventIdResource(dstStm, newEventId);
        ERROR_PROC_RETURN_MSG_INNER(error, TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                    , "Failed to allocate event id, deviceId=%u, tsId=%u, retCode=%#x.",
                                    davidEvt->Device_()->Id_(), davidEvt->Device_()->DevGetTsId(),
                                    static_cast<uint32_t>(error));
        davidEvt->SetEventId(newEventId);
    }

    (void)DavidEventRecordTaskInit(tsk, davidEvt, newEventId);
    SetSqPos(tsk, pos);
    tsk->stmArgPos = (static_cast<DavidStream*>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, davidEvt->SetRecord(oldHasRecord); davidEvt->SetHasReset(oldHasReset);
                                TaskUnInitProc(tsk); TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                , "Failed to submit record task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    EventStateCallbackManager::Instance().Notify(stm, evt, EventStatePeriod::EVENT_STATE_PERIOD_RECORD);
    return error;
}

rtError_t EvtRecordSoftwareMode(Event* const evt, Stream* const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Event recording");
    DavidEvent* davidEvt = static_cast<DavidEvent*>(evt);
    TaskInfo* tsk = nullptr;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    void* eventAddr = nullptr;
    int32_t newEventId = INVALID_EVENT_ID;
    Device* const dev = stm->Device_();
    error = dev->AllocExpandingPoolEvent(&eventAddr, &newEventId);
    ERROR_RETURN(
        error, "Failed to alloc address, deviceId=%u, tsId=%u, retCode=%#x", dev->Id_(), dev->DevGetTsId(),
        static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    stm->StreamLock();
    const bool hasTimestamp = IsTimestampRequired(davidEvt, stm);
    const uint32_t sqeNum = hasTimestamp ? 2U : 1U;
    tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_DAVID_EVENT_RECORD, error, sqeNum);
    COND_PROC_RETURN_ERROR_MSG_INNER(tsk == nullptr, error, dev->FreeExpandingPoolEvent(newEventId);
                                     stm->StreamUnLock();, "Failed to allocate task, stream_id=%d, retCode=%#x.",
                                                         stm->Id_(), static_cast<uint32_t>(error));
    pos = tsk->id;
    dstStm = tsk->stream;
    davidEvt->PublishSoftwareRecordResource(eventAddr, newEventId, dstStm->Id_(), tsk->id, 0U);

    (void)MemWriteValueTaskInit(tsk, eventAddr, 1UL);
    if (davidEvt->EventOwner_() == EventOwner::EVENT_INNER) {
        tsk->taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    }
    tsk->typeName = "EVENT_RECORD";
    tsk->type = (!dstStm->GetBindFlag()) ? TS_TASK_TYPE_MEM_WRITE_VALUE : TS_TASK_TYPE_CAPTURE_RECORD;
    MemWriteValueTaskInfo* memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->event = davidEvt;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    if (tsk->type == TS_TASK_TYPE_MEM_WRITE_VALUE) {
        tsk->needPostProc = true; // starsv2使用此属性判断任务结束后是否需要走uninit流程
        davidEvt->EventIdCountAdd(newEventId);
        memWriteValueTask->ownedEventId = newEventId;
        memWriteValueTask->hasTimestamp = hasTimestamp ? 1U : 0U;
        tsk->isCqeNeedConcern = hasTimestamp ? 1U : 0U;
    }

    tsk->stmArgPos = (static_cast<DavidStream*>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk); TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                , "Failed to submit record task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    davidEvt->SetRecord(true);
    RT_LOG(
        RT_LOG_INFO,
        "software-mode event task submit success, device_id=%u, src_stream_id=%d->dst_stream_id=%d, task_id=%hu, "
        "event_id=%d, task_pos=%u",
        dev->Id_(), stm->Id_(), dstStm->Id_(), tsk->id, newEventId, pos);
    return error;
}

rtError_t ProcStreamRecordTask(Stream* const stm, int32_t timeout)
{
    rtError_t error = CheckTaskCanSend(stm);
    COND_RETURN_ERROR_MSG_INNER(
        error != RT_ERROR_NONE, error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(),
        static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    TaskInfo* tsk = nullptr;
    stm->StreamLock();
    Event* lastHalfRecord = stm->GetLastHalfRecord();
    std::function<void()> const errRecycle = [&tsk, &stm, &pos]() {
        TaskUnInitProc(tsk);
        TaskRollBack(stm, pos);
        stm->StreamUnLock();
    };
    if (lastHalfRecord == nullptr) {
        lastHalfRecord = new (std::nothrow) DavidEvent(stm->Device_(), RT_EVENT_STREAM_MARK, stm->Context_(), false);
        stm->SetLastHalfRecord(lastHalfRecord);
        COND_PROC_RETURN_AND_MSG_ALLOC_FAILED(lastHalfRecord == nullptr, RT_ERROR_EVENT_NEW, stm->StreamUnLock();
                                              , sizeof(DavidEvent), "new");
    }
    tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_DAVID_EVENT_RECORD, error, 1U, UpdateTaskFlag::NOT_SUPPORT_AND_SKIP);
    COND_PROC_RETURN_ERROR_MSG_INNER(tsk == nullptr, error, stm->StreamUnLock();
                                     , "Failed to allocate task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = tsk->id;
    ScopeGuard tskErrRecycle(errRecycle);
    error = DavidEventRecordTaskInit(tsk, lastHalfRecord, lastHalfRecord->EventId_());
    ERROR_RETURN(
        error, "Failed to initialize event, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    DavidEventRecordTaskInfo* const eventRecordTsk = &(tsk->u.davidEventRecordTaskInfo);
    eventRecordTsk->timeout = timeout;
    tsk->isNeedStreamSync = true;
    tsk->isCqeNeedConcern = true;
    SetSqPos(tsk, pos);
    tsk->stmArgPos = (static_cast<DavidStream*>(stm))->GetArgPos();
    error = DavidSendTask(tsk, stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to send event task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    stm->StreamUnLock();
    error = SubmitTaskPostProc(stm, pos, true, timeout);
    if (error == RT_ERROR_STREAM_SYNC_TIMEOUT) {
        stm->SetNeedSyncFlag(true);
        return error;
    }
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t GetOrCreateCrossEventSharedInfo(
    const Device* source, uint32_t notifyId, bool isCountNotify, CrossEventSharedInfo& info, char* name, uint32_t len)
{
    const std::lock_guard<std::mutex> lock(info.mutex);
    if (info.shrId == UINT32_MAX) {
        uint32_t shrId = notifyId;
        info.name[0] = '\0';
        const IpcNotifyCreatePara createPara = {
            info.name,
            IPC_NOTIFY_NAME_BUFFER_LEN,
            static_cast<int32_t>(source->Id_()),
            source->DevGetTsId(),
            0U, // flag
            isCountNotify,
        };
        const rtError_t error = source->Driver_()->CreateIpcNotify(createPara, &shrId);
        ERROR_RETURN(
            error, "Failed to create cross-device event shared name, device_id=%u, notify_id=%u.", source->Id_(),
            notifyId);
        COND_RETURN_ERROR(
            info.name[0] == '\0', RT_ERROR_INVALID_VALUE,
            "Driver returned an empty shared name for a cross-device event, device_id=%u, notify_id=%u.", source->Id_(),
            notifyId);
        info.shrId = shrId;
    }
    const errno_t ret = strcpy_s(name, len, info.name);
    COND_RETURN_ERROR(
        ret != EOK, RT_ERROR_INVALID_VALUE, "Failed to copy cross-device event shared name, ret=%d.", ret);
    return RT_ERROR_NONE;
}

rtError_t DestroyCrossEventSharedInfo(const Device* source, CrossEventSharedInfo& info)
{
    const std::lock_guard<std::mutex> lock(info.mutex);
    if (info.shrId == UINT32_MAX) {
        return RT_ERROR_NONE;
    }
    const rtError_t error = source->Driver_()->DestroyIpcNotify(
        info.name, static_cast<int32_t>(source->Id_()), info.shrId, source->DevGetTsId());
    ERROR_RETURN(
        error, "Failed to destroy cross-device event shared name, device_id=%u, shrid=%u.", source->Id_(), info.shrId);
    info.shrId = UINT32_MAX;
    info.name[0] = '\0';
    return RT_ERROR_NONE;
}

static void ReleaseCrossEventWaitResource(TaskInfo* const task)
{
    auto& info = task->u.memWaitValueTask.crossDeviceWaitInfo;
    info.release = nullptr;
    Device* const target = task->stream->Device_();
    if (info.mapped) {
        (void)ReleaseCrossEventVa(info.shrId, target->Id_(), info.phyId, info.isCountNotify);
        (void)target->Driver_()->CloseIpcNotify(info.name, static_cast<int32_t>(target->Id_()), info.shrId, info.tsId);
    }
    info = {};
}

static rtError_t PrepareCrossEventWait(const Device* const target, CrossEventWaitInfo& info, uint64_t& addr)
{
    uint32_t isPod = 0U;
    uint32_t adcDieId = 0U;
    constexpr uint32_t flag = RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS;
    const IpcNotifyOpenPara open = {info.name, flag, target->Id_(), target->DevGetTsId(), info.isCountNotify};
    rtError_t error = target->Driver_()->OpenIpcNotify(open, &info.phyId, &info.shrId, &info.tsId, &isPod, &adcDieId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    ScopeGuard closeNotify([target, &info]() {
        (void)target->Driver_()->CloseIpcNotify(info.name, static_cast<int32_t>(target->Id_()), info.shrId, info.tsId);
    });
    COND_RETURN_WARN(
        isPod != 0U, RT_ERROR_FEATURE_NOT_SUPPORT, "Cross-server event resource mappings are not supported.");
    uint32_t localPhyId = 0U;
    error = target->Driver_()->GetDevicePhyIdByIndex(target->Id_(), &localPhyId);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    COND_RETURN_WARN(
        localPhyId == info.phyId, RT_ERROR_FEATURE_NOT_SUPPORT,
        "Cross-device event mapping requires different physical devices, device_id=%u.", target->Id_());
    error = GetCrossEventVa(info.shrId, target->Id_(), info.phyId, info.isCountNotify, addr);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    info.mapped = true;
    closeNotify.ReleaseGuard();
    return target->Driver_()->EnableP2PNotify(target->Id_(), info.phyId, flag);
}

rtError_t CheckEventBeforeWait(DavidEvent* const evt, const Stream* const stm, bool& needWait)
{
    COND_RETURN_WARN(
        evt->IsCapturing() || stm->IsCapturing(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Cross-device event waits are not supported in capture mode.");
    COND_RETURN_WARN(
        !evt->IsHardwareMode(), RT_ERROR_FEATURE_NOT_SUPPORT, "Cross-device software event waits are not supported.");

    int32_t eventId = INVALID_EVENT_ID;
    needWait = evt->WaitSendCheck(stm, eventId);
    if (!needWait) {
        RT_LOG(RT_LOG_INFO, "no need wait, return success, event_id=%d", eventId);
        return RT_ERROR_NONE;
    }

    COND_RETURN_AND_MSG_OUTER(
        ((evt->GetEventFlag() & (RT_EVENT_DDSYNC_NS | RT_EVENT_EXTERNAL)) == 0U) && !evt->HasRecord(),
        RT_ERROR_INVALID_VALUE, ErrorCode::EE1018, "Waiting for an event",
        "Waiting for this event requires a prior Record operation. "
        "Call aclrtRecordEvent on a stream before waiting for the event");
    COND_RETURN_ERROR(
        eventId == INVALID_EVENT_ID, RT_ERROR_INVALID_VALUE, "Cannot share an invalid event ID, device_id=%u.",
        evt->Device_()->Id_());

    const rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN(error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    COND_RETURN_WARN(
        stm->GetBindFlag() || stm->IsModelStream(), RT_ERROR_FEATURE_NOT_SUPPORT,
        "Cross-device event waits require an unbound target stream.");
    COND_RETURN_WARN(
        !stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_NOTIFY_USER_VA_MAPPING),
        RT_ERROR_FEATURE_NOT_SUPPORT, "The device does not support mapped notify resources.");
    return RT_ERROR_NONE;
}

rtError_t CrossEvtWait(DavidEvent* const evt, Stream* const stm)
{
    const bool isCountNotify = evt->IsCntNotify();
    CrossEventWaitInfo info{};
    rtError_t error = evt->GetCrossDeviceIpcName(info.name, IPC_NOTIFY_NAME_BUFFER_LEN);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    info.release = &ReleaseCrossEventWaitResource;
    info.isCountNotify = isCountNotify;
    stm->StreamLock();
    TaskInfo* const tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_MEM_WAIT_VALUE, error, MEM_WAIT_V2_SQE_NUM);
    if (tsk == nullptr) {
        stm->StreamUnLock();
        return error;
    }
    Stream* const target = tsk->stream;
    const uint32_t pos = tsk->id;
    ScopeGuard rollback([tsk, target, pos, stm]() {
        TaskUnInitProc(tsk);
        TaskRollBack(target, pos);
        stm->StreamUnLock();
    });
    tsk->type = TS_TASK_TYPE_MEM_WAIT_VALUE;
    const uint64_t waitValue = isCountNotify ? static_cast<uint64_t>(evt->CntValue()) : 1ULL;
    error = MemWaitValueTaskInit(tsk, nullptr, waitValue, MEM_WAIT_VALUE_TYPE_GEQ);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    evt->InsertWaitToMap(tsk);
    auto& waitInfo = tsk->u.memWaitValueTask;
    waitInfo.crossDeviceWaitInfo = info;
    waitInfo.event = evt;
    error = PrepareCrossEventWait(target->Device_(), waitInfo.crossDeviceWaitInfo, waitInfo.devAddr);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    tsk->typeName = "CROSS_DEVICE_EVENT_WAIT";
    tsk->needPostProc = true;
    waitInfo.awSize = isCountNotify ? RT_STARS_WRITE_VALUE_SIZE_TYPE_32BIT : RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    tsk->stmArgPos = static_cast<DavidStream*>(target)->GetArgPos();
    error = DavidSendTask(tsk, target);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    rollback.ReleaseGuard();
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(target->GetExposedStreamId(), tsk->taskSn);
    error = SubmitTaskPostProc(target, pos);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);
    EventStateCallbackManager::Instance().Notify(stm, evt, EventStatePeriod::EVENT_STATE_PERIOD_WAIT);
    return RT_ERROR_NONE;
}

rtError_t EvtWait(Event* const evt, Stream* const stm, const uint32_t timeout)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Waiting for an event");
    rtError_t error = RT_ERROR_NONE;
    Device* const dev = stm->Device_();
    DavidEvent* davidEvt = static_cast<DavidEvent*>(evt);
    int32_t eventId = INVALID_EVENT_ID;
    if (!davidEvt->WaitSendCheck(stm, eventId)) {
        RT_LOG(RT_LOG_INFO, "no need wait, return success, event_id=%d", eventId);
        return RT_ERROR_NONE;
    }

    if (((davidEvt->GetEventFlag() & (RT_EVENT_DDSYNC_NS | RT_EVENT_EXTERNAL)) == 0U) &&
        (!davidEvt->HasRecord() || (eventId == INVALID_EVENT_ID))) {
        if (!davidEvt->HasRecord()) {
            RT_LOG_OUTER_MSG_WITH_FUNC_DESC(
                ErrorCode::EE1018, "Waiting for an event",
                "Waiting for this event requires a prior Record operation. "
                "Call aclrtRecordEvent on a stream before waiting for the event");
        } else {
            RT_LOG(
                RT_LOG_ERROR,
                "Cannot submit event wait because the event ID is invalid, device_id=%u, stream_id=%d, flag=%" PRIu64
                ", "
                "model=%s.",
                dev->Id_(), stm->Id_(), davidEvt->GetEventFlag(), stm->IsModelStream() ? "yes" : "no");
        }
        return RT_ERROR_INVALID_VALUE;
    }
    error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    TaskInfo* tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    stm->StreamLock();
    tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_DAVID_EVENT_WAIT, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(tsk == nullptr, error, stm->StreamUnLock();
                                     , "Failed to allocate task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = tsk->id;
    dstStm = tsk->stream;
    DavidEventWaitTaskInit(tsk, davidEvt, eventId, timeout);
    DeviceSchedGate* gate = dev->GetSchedGate();
    const bool isGateEvent = (gate != nullptr) && (evt == gate->GateEvent());
    if (isGateEvent) {
        tsk->taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    }

    tsk->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk); TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                , "Failed to submit wait task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                static_cast<uint32_t>(error));
    if (isGateEvent) {
        dstStm->ResetSchedOperatorCount();
    }
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    EventStateCallbackManager::Instance().Notify(stm, evt, EventStatePeriod::EVENT_STATE_PERIOD_WAIT);
    return RT_ERROR_NONE;
}

rtError_t EvtWaitSoftwareMode(Event* const evt, Stream* const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Waiting for an event");
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    DavidEvent* davidEvt = static_cast<DavidEvent*>(evt);
    Device* const dev = stm->Device_();
    void* eventAddr = davidEvt->GetEventAddr();
    COND_RETURN_ERROR(
        eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL, "Event address is null, event_id=%d.",
        davidEvt->EventId_());

    TaskInfo* tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    stm->StreamLock();
    tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_MEM_WAIT_VALUE, error, MEM_WAIT_V2_SQE_NUM);
    COND_PROC_RETURN_ERROR_MSG_INNER(tsk == nullptr, error, stm->StreamUnLock();
                                     , "Failed to allocate task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = tsk->id;
    dstStm = tsk->stream;
    tsk->typeName = "EVENT_WAIT";
    tsk->type = (!dstStm->GetBindFlag()) ? TS_TASK_TYPE_MEM_WAIT_VALUE : TS_TASK_TYPE_CAPTURE_WAIT;
    error = MemWaitValueTaskInit(tsk, eventAddr, 1UL, 0U);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                , "Failed to initialize task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                static_cast<uint32_t>(error));
    if (davidEvt->EventOwner_() == EventOwner::EVENT_INNER) {
        tsk->taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    }
    MemWaitValueTaskInfo* memWaitValueTask = &tsk->u.memWaitValueTask;
    memWaitValueTask->event = davidEvt;
    memWaitValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;
    if (tsk->type == TS_TASK_TYPE_MEM_WAIT_VALUE) {
        tsk->needPostProc = true; // starsv2使用此属性判断任务结束后是否需要走uninit流程
        const int32_t eventId = davidEvt->EventId_();
        davidEvt->EventIdCountAdd(eventId);
        memWaitValueTask->ownedEventId = eventId;
    }

    tsk->stmArgPos = (static_cast<DavidStream*>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk); TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                , "Failed to submit wait task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    RT_LOG(
        RT_LOG_INFO,
        "capture wait task submit success, device_id=%u, src_stream_id=%d->dst_stream_id=%d, task_id=%hu, event_id=%d, "
        "task_pos=%u",
        dev->Id_(), stm->Id_(), dstStm->Id_(), tsk->id, davidEvt->EventId_(), pos);
    return RT_ERROR_NONE;
}

rtError_t EvtReset(Event* const evt, Stream* const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Event reset");
    TaskInfo* tsk = nullptr;
    DavidEvent* davidEvt = static_cast<DavidEvent*>(evt);
    const int32_t eventId = davidEvt->EventId_();
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    Stream* dstStm = stm;
    stm->StreamLock();
    tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_DAVID_EVENT_RESET, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(tsk == nullptr, error, stm->StreamUnLock();
                                     , "Failed to allocate task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = tsk->id;
    dstStm = tsk->stream;
    DavidEventResetTaskInit(tsk, davidEvt, eventId);
    tsk->stmArgPos = static_cast<DavidStream*>(dstStm)->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk); TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                , "Failed to submit reset task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), tsk->taskSn);
    davidEvt->SetHasReset(true);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t EvtResetSoftwareMode(Event* const evt, Stream* const stm)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(stm, RT_ERROR_STREAM_NULL, "Event reset");
    rtError_t error = CheckTaskCanSend(stm);
    ERROR_RETURN_MSG_INNER(
        error, "Failed to check stream, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));

    DavidEvent* davidEvt = static_cast<DavidEvent*>(evt);
    Device* const dev = stm->Device_();
    void* eventAddr = davidEvt->GetEventAddr();
    COND_RETURN_ERROR(
        eventAddr == nullptr, RT_ERROR_EVENT_RECORDER_NULL, "Event address is null, event_id=%d.",
        davidEvt->EventId_());

    TaskInfo* tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    Stream* dstStm = stm;
    stm->StreamLock();
    tsk = stm->AllocTask(nullptr, TS_TASK_TYPE_MEM_WRITE_VALUE, error);
    COND_PROC_RETURN_ERROR_MSG_INNER(tsk == nullptr, error, stm->StreamUnLock();
                                     , "Failed to allocate task, stream_id=%d, retCode=%#x.", stm->Id_(),
                                     static_cast<uint32_t>(error));
    pos = tsk->id;
    dstStm = tsk->stream;

    (void)MemWriteValueTaskInit(tsk, eventAddr, 0UL);
    tsk->typeName = "EVENT_RESET";
    tsk->type = TS_TASK_TYPE_MEM_WRITE_VALUE;
    if (davidEvt->EventOwner_() == EventOwner::EVENT_INNER) {
        tsk->taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    }
    MemWriteValueTaskInfo* memWriteValueTask = &tsk->u.memWriteValueTask;
    memWriteValueTask->event = davidEvt;
    memWriteValueTask->awSize = RT_STARS_WRITE_VALUE_SIZE_TYPE_8BIT;

    tsk->stmArgPos = (static_cast<DavidStream*>(dstStm))->GetArgPos();
    error = DavidSendTask(tsk, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, TaskUnInitProc(tsk); TaskRollBack(dstStm, pos); stm->StreamUnLock();
                                , "Failed to submit reset task, retCode=%#x.", static_cast<uint32_t>(error));
    stm->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->GetExposedStreamId(), tsk->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN(error, "Failed to recycle task, stream_id=%d, retCode=%#x.", stm->Id_(), static_cast<uint32_t>(error));
    RT_LOG(
        RT_LOG_INFO,
        "reset task submit success, device_id=%u, src_stream_id=%d->dst_stream_id=%d, task_id=%hu, event_id=%d, "
        "task_pos=%u",
        dev->Id_(), stm->Id_(), dstStm->Id_(), tsk->id, davidEvt->EventId_(), pos);
    return error;
}
} // namespace runtime
} // namespace cce
