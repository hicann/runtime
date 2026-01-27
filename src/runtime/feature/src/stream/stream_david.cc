/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_david.hpp"
#include "stream_sqcq_manage.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "device.hpp"
#include "npu_driver.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "mmpa/mmpa_api.h"
#include "dvpp_grp.hpp"
#include "thread_local_container.hpp"
#include "task_res_da.hpp"
#include "task_submit.hpp"
#include "task_david.hpp"
#include "task_recycle.hpp"
#include "event_c.hpp"
#include "profiler_c.hpp"
#include "inner_thread_local.hpp"
#include "stream_c.hpp"
#include "stream_state_callback_manager.hpp"

namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtStreamCreate_AllocStreamSqCq);
TIMESTAMP_EXTERN(rtStreamCreate_AllocLogicCq);

DavidStream::DavidStream(Device * const dev, const uint32_t prio, const uint32_t stmFlags, DvppGrp * const dvppGrp)
    : Stream(dev, prio, stmFlags, dvppGrp)
{
}

DavidStream::~DavidStream()
{
    Runtime * const rt = Runtime::Instance();
    if (GetSubscribeFlag() != StreamSubscribeFlag::SUBSCRIBE_NONE) {
        (void)rt->UnSubscribeReport(this);
    }
    if (device_ != nullptr) {
        if ((device_->GetDevStatus() != RT_ERROR_NONE) && (this->GetBindFlag())) {
            RT_LOG(RT_LOG_WARNING, "Device fault and the model binds this stream, device_id=%u, stream_id=%d, "
                "can not delete.", device_->Id_(), streamId_);
            return;
        }
        (void)FreeExecutedTimesSvm();
        
        if (((flags_ & RT_STREAM_PERSISTENT) != 0U) && (sqRegVirtualAddr_ != 0U)) {
            (void)device_->Driver_()->UnmapSqRegVirtualAddrBySqid(
                static_cast<int32_t>(device_->Id_()), device_->DevGetTsId(), sqId_);
        }
        sqRegVirtualAddr_ = 0U;

        if ((!NeedDelSelfStream()) && (Device_()->GetTaskFactory() != nullptr)) {
            device_->GetTaskFactory()->FreeStreamRes(streamId_);
        }

        if (dvppGrp_ != nullptr) {
            (void)device_->Driver_()->StreamUnBindLogicCq(device_->Id_(), device_->DevGetTsId(),
                static_cast<uint32_t>(streamId_), dvppGrp_->getLogicCqId());
        } else {
            (void)device_->GetStreamSqCqManage()->FreeLogicCq(static_cast<uint32_t>(streamId_));
        }

        if (dvppRRTaskAddr_ != nullptr) {
            (void)device_->Driver_()->DevMemFree(dvppRRTaskAddr_, device_->Id_());
            dvppRRTaskAddr_ = nullptr;
        }

        if (cntNotifyId_ != MAX_UINT32_NUM) {
            const rtError_t error = device_->Driver_()->NotifyIdFree(
                static_cast<int32_t>(device_->Id_()), cntNotifyId_, device_->DevGetTsId(), 0U, true);
            if (error != RT_ERROR_NONE) {
                RT_LOG_INNER_MSG(RT_LOG_ERROR,
                    "NotifyIdFree failed, device_id=%u, stream_id=%d, notify_id=%u, retCode=%#x!",
                    device_->Id_(), streamId_, cntNotifyId_, static_cast<uint32_t>(error));
            }
        }
        FreeStreamId();

        if (GetMemContainOverflowAddr() != nullptr) {
            (void)device_->Driver_()->DevMemFree(GetMemContainOverflowAddr(), device_->Id_());
            SetMemContainOverflowAddr(nullptr);
        }

        for (void * const addr : devTilingTblAddr) {
            RT_LOG(RT_LOG_INFO, "Id=%u, devCopyMem=%p", device_->Id_(), addr);
            (void)device_->Driver_()->DevMemFree(addr, device_->Id_());
        }
        ReleaseStreamArgRes();
        devTilingTblAddr.clear();
        streamResId = RTS_INVALID_RES_ID;
        SetContext(nullptr);
        device_ = nullptr;
        models_.clear();
        dvppGrp_ = nullptr;
        cntNotifyId_ = MAX_UINT32_NUM;
    }
    ReleaseStreamTaskRes();
    DestroyArgRecycleList(static_cast<uint32_t>(argRecycleListSize_));
    DELETE_O(lastHalfRecord_);
    DELETE_A(taskPublicBuff_);
    latestModelId_ = MAX_INT32_NUM;
}

rtError_t DavidStream::CreateStreamArgRes()
{
    if (Runtime::Instance()->GetConnectUbFlag()) {
        argManage_ = new (std::nothrow) UbArgManage(this);
    } else {
        argManage_ = new (std::nothrow) PcieArgManage(this);
    }
    if (argManage_ == nullptr) {
        RT_LOG(RT_LOG_ERROR, "new DavidArgManage fail.");
        return RT_ERROR_CALLOC;
    }

    if ((flags_ & RT_STREAM_FAST_LAUNCH) == 0U) {
        RT_LOG(RT_LOG_INFO, "Non-fast_launch stream does not alloc args res, stream_id=%d, flags=0x%x",
            streamId_, flags_);
        return RT_ERROR_NONE;
    }

    isHasArgPool_ = argManage_->CreateArgRes();
    return RT_ERROR_NONE;
}

void DavidStream::ReleaseStreamArgRes()
{
    isHasArgPool_ = false;
    if (argManage_ != nullptr) {
        argManage_->ReleaseArgRes();
        DELETE_O(argManage_);
    }
}

rtError_t DavidStream::SubmitMaintenanceTask(const MtType type, bool isForceRecycle, int32_t targetStmId, 
    const uint32_t logicCqId, bool terminal)
{
    (void)terminal;
    (void)logicCqId;
    TaskInfo *tsk = nullptr;
    uint32_t pos = 0xFFFFU;
    rtError_t error = CheckTaskCanSend(this);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check send failed, target_stream_id=%d, retCode=%#x.", streamId_,
        targetStmId, static_cast<uint32_t>(error));
    StreamLock();
    error = AllocTaskInfo(&tsk, this, pos);
    ERROR_PROC_RETURN_MSG_INNER(error, StreamUnLock();, "Failed to alloc task, stream_id=%d, target_stream_id=%d,"
        " retCode=%#x.", streamId_, targetStmId, static_cast<uint32_t>(error));
    SaveTaskCommonInfo(tsk, this, pos);
    (void)MaintenanceTaskInit(tsk, type, static_cast<uint32_t>(targetStmId), isForceRecycle);
    tsk->isCqeNeedConcern = true;
    error = DavidSendTask(tsk, this);
    ERROR_PROC_RETURN_MSG_INNER(error, 
                                TaskUnInitProc(tsk);
                                TaskRollBack(this, pos);
                                StreamUnLock();,
                                "Failed to submit task, retCode=%#x, stream_id=%d, target_stream_id=%d, pos=%u.",
                                static_cast<uint32_t>(error), streamId_, targetStmId, pos);
    StreamUnLock();
    const bool isNeedStreamSync = (tsk->isNeedStreamSync == 0U) ? false : true;
    error = SubmitTaskPostProc(this, pos, isNeedStreamSync);
    ERROR_RETURN_MSG_INNER(error, " reclycle fail, stream_id=%d, target_stream_id=%d, retCode=%#x.",
        streamId_, targetStmId, static_cast<uint32_t>(error));
    return error;
}

static void GetEventIdOrNotifyId(TaskInfo *taskInfo, int32_t &eventId, uint32_t &isCountNotify, uint32_t &countValue,
    uint32_t &notifyId)
{
    DavidEventRecordTaskInfo *eventRecordTaskInfo = nullptr;
    DavidEventWaitTaskInfo *eventWaitTaskInfo = nullptr;
    DavidEventResetTaskInfo *eventResetTaskInfo = nullptr;
    NotifyWaitTaskInfo* notifyWaitTask = nullptr;
    NotifyRecordTaskInfo *notifyRecord = nullptr;
    switch (taskInfo->type) {
        case TS_TASK_TYPE_DAVID_EVENT_RECORD:
            eventRecordTaskInfo = &(taskInfo->u.davidEventRecordTaskInfo);
            eventId = eventRecordTaskInfo->eventId;
            if (eventRecordTaskInfo->isCountNotify == 1U) {
                isCountNotify = 1U;
                countValue = eventRecordTaskInfo->countValue;
            }
            break;
        case TS_TASK_TYPE_DAVID_EVENT_WAIT:
            eventWaitTaskInfo = &(taskInfo->u.davidEventWaitTaskInfo);
            eventId = eventWaitTaskInfo->eventId;
            if (eventWaitTaskInfo->isCountNotify == 1U) {
                isCountNotify = 1U;
                countValue = eventWaitTaskInfo->countValue;
            }
            break;
        case TS_TASK_TYPE_DAVID_EVENT_RESET:
            eventResetTaskInfo = &(taskInfo->u.davidEventResetTaskInfo);
            eventId = eventResetTaskInfo->eventId;
            break;
        case TS_TASK_TYPE_NOTIFY_WAIT:
            notifyWaitTask = &(taskInfo->u.notifywaitTask);
            notifyId = notifyWaitTask->notifyId;
            break;
        case TS_TASK_TYPE_NOTIFY_RECORD:
            notifyRecord = &(taskInfo->u.notifyrecordTask);
            notifyId = notifyRecord->notifyId;
            break;

        default:
            break;
    }
}

void DavidStream::DebugDotPrintForModelStm()
{
    if (!GetBindFlag() || (taskResMang_ == nullptr)) {
        RT_LOG(RT_LOG_DEBUG, " device_id=%u, stream_id=%d.", device_->Id_(), Id_());
        return;
    }
    uint16_t head = 0U;
    uint16_t tail = 0U;
    (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetHeadTail(head, tail);
    RT_LOG(RT_LOG_INFO, "stream_id=%d, head=%hu, tail=%hu.", Id_(), head, tail);
    TaskInfo* nextTask = nullptr;
    for (uint32_t i = head; i < tail;) {
        nextTask = (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetTaskInfo(i);
        if (unlikely(nextTask == nullptr)) {
            i++;
            continue;
        }
        i = static_cast<uint32_t>(nextTask->id) + nextTask->sqeNum;
        int32_t eventId = INVALID_EVENT_ID;
        uint32_t notifyId = MAX_UINT32_NUM;
        uint32_t countValue = MAX_UINT32_NUM;
        uint32_t isCountNotify= 0U;
        GetEventIdOrNotifyId(nextTask, eventId, isCountNotify, countValue, notifyId);

        if (eventId != INVALID_EVENT_ID) {
            if (isCountNotify == 1U) {
                RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, event_id=%d, cnt_value=%u.",
                device_->Id_(), Id_(), nextTask->id, nextTask->typeName, eventId, countValue);
            } else {
                RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, event_id=%d.",
                device_->Id_(), Id_(), nextTask->id, nextTask->typeName, eventId);
            }
            continue;
        }

        if (notifyId != MAX_UINT32_NUM) {
            RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, notify_id=%u.",
                device_->Id_(), Id_(), nextTask->id, nextTask->typeName, notifyId);
            continue;
        }

        if ((nextTask->type == TS_TASK_TYPE_KERNEL_AICORE) || (nextTask->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
            std::string mixTypeName = "NO_MIX";
            const auto &aicTaskInfo = nextTask->u.aicTaskInfo;
            const uint8_t mixType = (aicTaskInfo.kernel != nullptr) ? aicTaskInfo.kernel->GetMixType() : 0U;
            if (mixType == MIX_AIC || mixType == MIX_AIC_AIV_MAIN_AIC) {
                (void)mixTypeName.assign("MIX_AIC");
            } else if (mixType == MIX_AIV || mixType == MIX_AIC_AIV_MAIN_AIV) {
                (void)mixTypeName.assign("MIX_AIV");
            } else {
                ;
            }

            RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s, mix_type=%s.",
                device_->Id_(), Id_(), nextTask->id, nextTask->typeName, mixTypeName.c_str());
            continue;
        }

        RT_LOG(RT_LOG_EVENT, "device_id=%u, stream_id=%d, task_id=%hu, task_type=%s.",
            device_->Id_(), Id_(), nextTask->id, nextTask->typeName);
    }
}

rtError_t DavidStream::TearDown(const bool terminal, bool flag)
{
    (void)terminal;
    Stream *exeStream = this;
    Device * const dev = device_;
    const int32_t stmId = streamId_;
    bool isForceRecycle = GetForceRecycleFlag(flag);
    uint16_t head = 0U;
    uint16_t tail = 0U;
    uint32_t tryWaitCnt = 0U;

    if (taskResMang_ == nullptr) {
        return RT_ERROR_NONE;
    }

    if ((flags_ & RT_STREAM_PERSISTENT) != 0U) {
        RecycleModelBindStreamAllTask(this, false);
        return RT_ERROR_NONE;
    }

    if (this->GetArgHandle() != nullptr) {
        this->ArgManagePtr()->RecycleDevLoader(this->GetArgHandle());
 	    this->SetArgHandle(nullptr);
 	}

    (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetHeadTail(head, tail);
    if (isForceRecycle) {
        exeStream = dev->PrimaryStream_();
        if (this == exeStream) {
            isForceRecycle = false;
        }
        isForceRecycle_ = isForceRecycle;
    }
    RT_LOG(RT_LOG_INFO, "stream_id=%d, sq_id=%u, head=%hu, tail=%hu, isForceRecycle=%d, flag=%d, failMode=%u.",
        stmId, sqId_, head, tail, isForceRecycle, flag, GetFailureMode());
    if (!((dynamic_cast<TaskResManageDavid *>(taskResMang_))->IsEmpty())) {
        NULL_PTR_RETURN_MSG(exeStream, RT_ERROR_STREAM_NULL);
        (void)static_cast<DavidStream *>(exeStream)->SubmitMaintenanceTask(MT_STREAM_RECYCLE_TASK, isForceRecycle, stmId);
    }

    while ((!((dynamic_cast<TaskResManageDavid *>(taskResMang_))->IsEmpty())) &&
        (device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_NORMAL))) {
        if (abortStatus_ == RT_ERROR_DEVICE_TASK_ABORT) {
            RT_LOG(RT_LOG_WARNING, "stream is abort, stream_id=%d, pendingNum=%d.", stmId, pendingNum_.Value());
            break;
        }
        StreamSyncLock();
        (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetHeadTail(head, tail);
        RT_LOG(RT_LOG_DEBUG, "recycling stream_id=%d, head=%hu, tail=%hu, isForceRecycle=%u.",
            stmId, head, tail, isForceRecycle);
        (void)TaskReclaimByStream(this, false);
        StreamSyncUnLock();
    }
    
    dev->DelStreamFromMessageQueue(this);
    while (isRecycleThreadProc_) {
        (void)mmSleep(1U);
        // Wait RecycleThread done in 10s
        if ((tryWaitCnt++) > 1500U) {
            RT_LOG(RT_LOG_ERROR, "stream_id=%d, RecycleThread process over 1s.", streamId_);
            break;
        }
    }
    if ((!isRecycleThreadProc_) && (argRecycleListHead_ != argRecycleListTail_)) {
        ProcArgRecycleList();
    }
    return RT_ERROR_NONE;
}

rtError_t DavidStream::SetupByFlagAndCheck(void)
{
    rtError_t error = RT_ERROR_NONE;
    error = CreateStreamTaskRes();
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_STREAM_NEW, "task res buffer failed");
    taskPublicBuffSize_ = GetSqDepth();
    taskPublicBuff_ = new (std::nothrow) uint32_t[taskPublicBuffSize_];
    COND_RETURN_ERROR_MSG_INNER(taskPublicBuff_ == nullptr, RT_ERROR_STREAM_NEW,
        "new task pubic buffer failed, size=%hu.", taskPublicBuffSize_);
    error = CreateArgRecycleList(static_cast<uint32_t>(taskPublicBuffSize_));
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, RT_ERROR_STREAM_NEW, "new args recycle list fail.");
    error = CreateStreamArgRes();
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "new args res manage fail.");

    error = CheckGroup();
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if ((flags_ & RT_STREAM_FORBIDDEN_DEFAULT) != 0U) {
        streamId_ = static_cast<int32_t>(MAX_INT32_NUM);
        RT_LOG(RT_LOG_DEBUG, "create a forbidden stream, stream_id=%u", streamId_);
        return RT_ERROR_NONE;
    }
    if ((flags_ & RT_STREAM_AICPU) != 0U) {
        error = Runtime::Instance()->AllocAiCpuStreamId(streamId_);
        ERROR_RETURN_MSG_INNER(error, "Failed to alloc aicpu stream id, retCode=%#x, stream_id=%d.",
            static_cast<uint32_t>(error), streamId_);
        return RT_ERROR_NONE; // AiCpuStream not participate in scheduling
    }

    if ((flags_ & RT_STREAM_OVERFLOW) != 0U) {
        SetOverflowSwitch(true);
    }
    error = device_->Driver_()->StreamIdAlloc(&streamId_, device_->Id_(), device_->DevGetTsId(), priority_);
    device_->GetStreamSqCqManage()->SetStreamIdToStream(static_cast<uint32_t>(streamId_), this);
    ERROR_RETURN(error, "Failed to alloc stream id, retCode=%#x.", static_cast<uint32_t>(error));
    RT_LOG(RT_LOG_DEBUG, "Alloc stream, stream_id=%d", streamId_);
    this->taskResMang_->streamId_ = streamId_;

    /**** alloc sq cq id *****/
    const auto stmSqCqManage = RtPtrToUnConstPtr<StreamSqCqManage *>(device_->GetStreamSqCqManage());
    error = stmSqCqManage->AllocDavidStreamSqCq(this, priority_, 0U, sqId_, cqId_, sqAddr_);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "[SqCqManage]Alloc sq cq fail, stream_id=%d, retCode=%#x.", streamId_,
            static_cast<uint32_t>(error));
        return error;
    }

    SetSatMode(device_->GetSatMode());
    RT_LOG(RT_LOG_DEBUG, "[StreamSetup]alloc sq cq success: stream_id=%d, sqId=%u, cqId=%u", streamId_, sqId_,
        cqId_);

    error = AllocLogicCq(true, true, stmSqCqManage);
    TIMESTAMP_END(rtStreamCreate_AllocLogicCq);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if ((flags_ & RT_STREAM_PERSISTENT) != 0U) {
        error = AllocExecutedTimesSvm();
        ERROR_RETURN_MSG_INNER(error, "Failed to alloc svm for executed times, retCode=%#x.", static_cast<uint32_t>(error));
        uint32_t addrLen = 0U;
        error = device_->Driver_()->GetSqRegVirtualAddrBySqid(static_cast<int32_t>(device_->Id_()),
                                                                device_->DevGetTsId(),
                                                                sqId_, &sqRegVirtualAddr_, &addrLen);
        ERROR_RETURN_MSG_INNER(error, "Fail to get sq reg virtual addr, deviceId=%u, sqId=%u.", device_->Id_(), sqId_);
        RT_LOG(RT_LOG_INFO, "Success to get sq=%u sq reg virtual addr length=%u.", sqId_, addrLen);
        error = SetSqRegVirtualAddrToDevice(sqRegVirtualAddr_);
        ERROR_RETURN_MSG_INNER(error, "Fail to copy sqid=%u virtual addr to device, retCode=%#x.", sqId_,
            static_cast<uint32_t>(error));
    }

    return RT_ERROR_NONE;
}

rtError_t DavidStream::Setup()
{
    rtError_t error = SetupByFlagAndCheck();
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    SetMaxTaskId(true);
    ClearFlowCtrlFlag();

    error = EschedManage(true);
    COND_RETURN_WITH_NOLOG(error != RT_ERROR_NONE, error);

    RT_LOG(RT_LOG_INFO, "stream setup end, stream_id=%d, sq_id=%u, cq_id=%u, device_id=%u, isHasArgPool_=%d, flag=%u.",
           streamId_, sqId_, cqId_, device_->Id_(), isHasArgPool_, flags_);
    StreamStateCallbackManager::Instance().Notify(this, true);
    return RT_ERROR_NONE;
}

rtError_t DavidStream::AddTaskToList(const TaskInfo * const tsk)
{
    if (tsk->needPostProc == true) {
        const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
        const uint32_t tail = (publicQueueTail_ + 1U) % taskPublicBuffSize_;
        COND_RETURN_WARN(publicQueueHead_ == tail,
            RT_ERROR_STREAM_FULL, "task public buff full, stream_id=%d, task_id=%hu, head=%u, tail=%u",
            streamId_, tsk->id, publicQueueHead_, publicQueueTail_);
        taskPublicBuff_[publicQueueTail_ % taskPublicBuffSize_] = tsk->id;
        publicQueueTail_ = tail;
        RT_LOG(RT_LOG_INFO, "public task, stream_id=%d, task_id=%hu, task_type=%d (%s), head=%u, "
            "tail=%u", streamId_, tsk->id, static_cast<int32_t>(tsk->type), tsk->typeName,
            publicQueueHead_, publicQueueTail_);
    }

    return RT_ERROR_NONE;
}

rtError_t DavidStream::StarsAddTaskToStream(TaskInfo * const tsk, const uint32_t sendSqeNum)
{
    NULL_PTR_RETURN_MSG(tsk, RT_ERROR_TASK_NULL);
    if (!GetBindFlag()) {
        const rtError_t ret = AddTaskToList(tsk);
        if (ret != RT_ERROR_NONE) {
            return ret;
        }
    } else {
        const rtError_t ret = PackingTaskGroup(tsk, static_cast<uint16_t>(streamId_));
        COND_PROC_RETURN_ERROR(ret != RT_ERROR_NONE, ret, SetTaskGroupErrCode(ret),
            "pack task group failed, stream_id=%d, task_id=%hu.", streamId_, tsk->id);
        if ((this->Model_()!= nullptr) && (tsk->type != TS_TASK_TYPE_MODEL_MAINTAINCE)) {
            this->Model_()->SetKernelTaskId(tsk->taskSn, streamId_);
        }
    }
    RT_LOG(RT_LOG_INFO, "%s stream, stream_id=%d, task_id=%hu, task_sn=%u, type=%d(%s), "
        "sqe_num=%u, device_id=%u", GetBindFlag() ? "model" : "single-operator", streamId_, tsk->id,
        tsk->taskSn, static_cast<int32_t>(tsk->type), tsk->typeName, sendSqeNum, tsk->stream->Device_()->Id_());
    SetLastTaskId(static_cast<uint32_t>(tsk->id));
    if ((tsk->isNeedStreamSync != 0U) || (tsk->isCqeNeedConcern != 0U) ||
        ((tsk->type == TS_TASK_TYPE_MEMCPY) && (tsk->u.memcpyAsyncTaskInfo.isConcernedRecycle))) {
        tsk->stream->latestConcernedTaskId.Set(tsk->id);
    }
    return RT_ERROR_NONE;
}

bool DavidStream::IsCntNotifyReachThreshold(void)
{
    const std::lock_guard<std::mutex> notifyLock(cntNotifyInfoLock_);
    if ((cntNotifyId_ != MAX_UINT32_NUM) && (recordVersion_.Value() >= COUNT_NOTIFY_STATIC_THRESHOLD)) {
        return true;
    }
    return false;
}

rtError_t DavidStream::ApplyCntValue(uint32_t &cntValue)
{
    if (cntNotifyId_ == MAX_UINT32_NUM) {
        return RT_ERROR_INVALID_VALUE;
    }
    recordVersion_.Add(1U);
    cntValue = recordVersion_.Value();
    return RT_ERROR_NONE;
}

rtError_t DavidStream::ApplyCntNotifyId(int32_t &newEventId)
{
    const auto deviceId = device_->Id_();
    const auto tsId = device_->DevGetTsId();
    auto driver = device_->Driver_();
    const std::lock_guard<std::mutex> notifyLock(cntNotifyInfoLock_);
    if (unlikely(cntNotifyId_ == MAX_UINT32_NUM)) {
        const rtError_t error = driver->NotifyIdAlloc(static_cast<int32_t>(deviceId), &cntNotifyId_, tsId, 0U, true);
        if (error != RT_ERROR_NONE) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR, "alloc count notify failed, device_id=%u, retCode=%#x!",
                deviceId, static_cast<uint32_t>(error));
            return error;
        }
        recordVersion_.Set(0);
    }
    newEventId = static_cast<int32_t>(cntNotifyId_);
    return RT_ERROR_NONE;
}

void DavidStream::GetCntNotifyId(int32_t &newEventId)
{
    if (unlikely(cntNotifyId_ == MAX_UINT32_NUM)) {
        newEventId = MAX_INT32_NUM;
    } else {
        newEventId = static_cast<int32_t>(cntNotifyId_);
    }
}

uint32_t DavidStream::GetCurSqPos() const
{
    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    return static_cast<uint32_t>(taskRes->GetTaskPosTail());
}

rtError_t DavidStream::StarsGetPublicTaskHead(TaskInfo *workTask, const bool isTaskBind, const uint16_t tailTaskId,
    uint16_t * const delTaskId)
{
    (void)workTask;
    (void)isTaskBind;
    NULL_PTR_RETURN_MSG(delTaskId, RT_ERROR_TASK_NULL);
    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    const uint32_t taskResTail = taskRes->GetTaskPosTail();
    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (publicQueueHead_ != publicQueueTail_) {
        const uint32_t fixTaskPos= taskPublicBuff_[publicQueueHead_];
        const uint16_t relTaskPos = static_cast<uint16_t>(fixTaskPos & 0xFFFFU);
        if (tailTaskId < taskResTail) {
            if (tailTaskId >= relTaskPos || relTaskPos > taskResTail) {
                *delTaskId = relTaskPos;
                return RT_ERROR_NONE;
            }
            RT_LOG(RT_LOG_DEBUG, "relTask is not executed in scenario 1, stream_id=%d, tailTaskId=%u, relTaskPos=%u, "
                   "publicHead=%u, publicTail=%u, taskResTail=%u.", streamId_, tailTaskId, relTaskPos,
                   publicQueueHead_, publicQueueTail_, taskResTail);
            return RT_ERROR_STREAM_INVALID;
        } else if (tailTaskId > taskResTail) {
            if (relTaskPos <= tailTaskId && relTaskPos > taskResTail) {
                *delTaskId = relTaskPos;
                return RT_ERROR_NONE;
            }
            RT_LOG(RT_LOG_DEBUG, "relTask is not executed in scenario 2, stream_id=%d, tailTaskId=%u, relTaskPos=%u, "
                "publicHead=%u, publicTail=%u, taskResTail=%u.", streamId_, tailTaskId, relTaskPos,
                publicQueueHead_, publicQueueTail_, taskResTail);
            return RT_ERROR_STREAM_INVALID;
        } else {
            // no operation
        }

        RT_LOG(RT_LOG_ERROR, "tailTaskId[%u] == taskResTail[%u] is invalid, stream_id=%d, publicHead=%u, publicTail=%u, "
            "taskResTail=%u.", tailTaskId, taskResTail, streamId_, publicQueueHead_, publicQueueTail_, taskResTail);
        return RT_ERROR_INVALID_VALUE;
    } else {
        // no operation
    }
    RT_LOG(RT_LOG_DEBUG, "public task list null, stream_id=%d, tailTaskId=%u, publicHead=%u, publicTail=%u, taskResTail=%u",
        streamId_, static_cast<uint32_t>(tailTaskId), publicQueueHead_, publicQueueTail_, taskResTail);
    return RT_ERROR_STREAM_EMPTY;
}

rtError_t DavidStream::DavidUpdatePublicQueue()
{
    const std::lock_guard<std::mutex> stmLock(publicTaskMutex_);
    if (publicQueueHead_ != publicQueueTail_) {
        const uint32_t fixTaskPos= taskPublicBuff_[publicQueueHead_];
        const uint16_t relTaskPos = static_cast<uint16_t>(fixTaskPos & 0xFFFFU);
        publicQueueHead_ = ((publicQueueHead_ + 1U) % taskPublicBuffSize_);
        finishTaskId_ = relTaskPos;
        RT_LOG(RT_LOG_DEBUG, "public task list update, stream_id=%d, finishTaskId_=%u, head=%u, tail=%u",
            streamId_, finishTaskId_, publicQueueHead_, publicQueueTail_);
        return RT_ERROR_NONE;
    } else {
        RT_LOG(RT_LOG_DEBUG, "public task list null, stream_id=%d, head=%u, tail=%u",
            streamId_, publicQueueHead_, publicQueueTail_);
        return RT_ERROR_STREAM_EMPTY;
    }
}

rtError_t DavidStream::CreateStreamTaskRes(void)
{
    taskResMang_ = new (std::nothrow) TaskResManageDavid();
    if (taskResMang_ == nullptr) {
        RT_LOG(RT_LOG_WARNING, "new TaskResManage fail.");
        return RT_ERROR_MEMORY_ALLOCATION;
    }

    const bool flag = taskResMang_->CreateTaskRes(this);
    if (!flag) {
        RT_LOG(RT_LOG_WARNING, "CreateTaskRes fail.");
        delete taskResMang_;
        taskResMang_ = nullptr;
        return RT_ERROR_STREAM_INVALID;
    }

    RT_LOG(RT_LOG_INFO, "STREAM TaskRes Setup. flags_=0x%x.", flags_);
    return RT_ERROR_NONE;
}

void DavidStream::StarsShowPublicQueueDfxInfo(void)
{
    if (publicQueueHead_ == publicQueueTail_) {
        return;
    }

    const uint32_t headStart = (publicQueueHead_ + taskPublicBuffSize_ - SHOW_DFX_INFO_TASK_NUM) % taskPublicBuffSize_;
    const uint32_t tailStart = (publicQueueTail_ + taskPublicBuffSize_ - SHOW_DFX_INFO_TASK_NUM) % taskPublicBuffSize_;

    uint32_t headIndex[SHOW_DFX_INFO_TASK_NUM] = {0};
    uint32_t tailIndex[SHOW_DFX_INFO_TASK_NUM] = {0};

    for (uint32_t i = 0; i < SHOW_DFX_INFO_TASK_NUM; i++) {
        headIndex[i] = (headStart + i) % taskPublicBuffSize_;
        tailIndex[i] = (tailStart + i) % taskPublicBuffSize_;
    }

    RT_LOG(RT_LOG_EVENT, "public head info, headStart=%u, public_pos_id::%u, %u, %u, %u, %u, %u.",
        headStart, taskPublicBuff_[headIndex[0U]], taskPublicBuff_[headIndex[1U]],
        taskPublicBuff_[headIndex[2U]], taskPublicBuff_[headIndex[3U]],
        taskPublicBuff_[headIndex[4U]], taskPublicBuff_[headIndex[5U]]);

    RT_LOG(RT_LOG_EVENT, "public tail info, tailStart=%u, public_pos_id::%u, %u, %u, %u, %u, %u.",
        tailIndex, taskPublicBuff_[tailIndex[0U]], taskPublicBuff_[tailIndex[1U]],
        taskPublicBuff_[tailIndex[2U]], taskPublicBuff_[tailIndex[3U]],
        taskPublicBuff_[tailIndex[4U]], taskPublicBuff_[tailIndex[5U]]);
}

void DavidStream::StarsShowStmDfxInfo(void)
{
    if (taskResMang_ != nullptr) {
        taskResMang_->ShowDfxInfo();
    }
}

uint32_t DavidStream::GetPendingNum() const 
{
    if (likely(taskResMang_ != nullptr)) {
        return (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetPendingNum();
    }
    return 0U;
}

rtError_t DavidStream::SubmitRecordTask(int32_t timeout)
{
    const rtError_t error = ProcStreamRecordTask(this, timeout);
    ERROR_RETURN_MSG_INNER(error, "Failed to submit record task, device_id=%u, stream_id=%d.", device_->Id_(), streamId_);
    return RT_ERROR_NONE;
}

rtError_t DavidStream::PrintStmDfxAndCheckDevice(
    uint64_t &beginCnt, uint64_t &endCnt, uint16_t &checkCount, uint32_t tryCount)
{
    constexpr uint16_t perDetectTimes = 1000U;
    if ((tryCount % perDetectTimes) == 0) {
        if (device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)) {
            RT_LOG(RT_LOG_ERROR, "device running down, device_id=%u, stream_id=%d", device_->Id_(), Id_());
            StarsShowStmDfxInfo();
            return RT_ERROR_DRV_ERR;
        } else {
            StarsStmDfxCheck(beginCnt, endCnt, checkCount);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t DavidStream::QueryWaitTask(bool &isWaitFlag, const uint32_t taskId)
{
    if (device_ == nullptr) {
        RT_LOG(RT_LOG_WARNING, "device is null, stream_id=%d", streamId_);
        return RT_ERROR_NONE;
    }
    NULL_PTR_RETURN_MSG_OUTER(taskResMang_, RT_ERROR_INVALID_VALUE);
    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    uint16_t sqHead = 0U;
    const uint16_t sqTail = taskRes->GetTaskPosTail();
    const rtError_t error = GetDrvSqHead(this, sqHead);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x",
        static_cast<uint32_t>(error));

    if (sqHead < sqTail) {
        if (sqHead > taskId || taskId > sqTail) {
            isWaitFlag = true;
        }
    } else if (sqHead > sqTail) {
        if (taskId >= sqTail && taskId < sqHead) {
            isWaitFlag = true;
        }
    } else {
        isWaitFlag = true;
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, isWaitFlag=%d, stream_id=%u, head=%u, tail=%u, pos=%u.",
        device_->Id_(), isWaitFlag, streamId_, sqHead, sqTail, taskId);
    return RT_ERROR_NONE;
}

rtError_t DavidStream::GetLastTaskIdFromRtsq(uint32_t &lastTaskId)
{
    UNUSED(lastTaskId);
    return RT_ERROR_NONE;
}

uint32_t DavidStream::StarsGetMaxTryCount() const
{
#ifndef CFG_DEV_PLATFORM_PC
    if (this->GetPendingNum() == 0U) {
        return 0U;
    }
    return RT_QUERY_TIMES_THRESHOLD;
#else
    return RT_QUERY_TIMES_THRESHOLD_STARS;
#endif
}

rtError_t DavidStream::JudgeTaskFinish(uint16_t taskPos, bool &isFinished)
{
    COND_RETURN_WARN(device_ == nullptr, RT_ERROR_NONE, "device is null, stream_id=%d", streamId_);
    NULL_PTR_RETURN_MSG_OUTER(taskResMang_, RT_ERROR_INVALID_VALUE);
    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    uint16_t sqHead = 0U;
    const uint32_t sqId = sqId_;
    const uint32_t tsId = device_->DevGetTsId();
    const uint16_t sqTail = taskRes->GetTaskPosTail();
    const rtError_t error = device_->Driver_()->GetSqHead(device_->Id_(), tsId, sqId, sqHead);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "Query sq head failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    if (sqHead < sqTail) {
        if (sqHead > taskPos || taskPos > sqTail) {
            isFinished = true;
        } else {
            isFinished = false;
        }
    } else if (sqHead > sqTail) {
        if (taskPos >= sqHead || taskPos < sqTail) {
            isFinished = false;
        } else {
            isFinished = true;
        }
    } else {
        isFinished = true;
    }
    RT_LOG(RT_LOG_INFO, "device_id=%u, is_finished=%u, stream_id=%d, head=%u, tail=%u, pos=%u",
        device_->Id_(), isFinished, streamId_, sqHead, sqTail, taskPos);
    return RT_ERROR_NONE;
}

rtError_t DavidStream::JudgeHeadTailPos(rtEventStatus_t * const status, uint16_t eventPos)
{
    bool isFinished = false;
    const rtError_t error = JudgeTaskFinish(eventPos, isFinished);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "query task status failed, retCode=%#x.",
        static_cast<uint32_t>(error));

    if (isFinished) {
        *status = RT_EVENT_RECORDED;
    } else {
        *status = RT_EVENT_INIT;
    }

    RT_LOG(RT_LOG_INFO, "device_id=%u, status=%d, stream_id=%d, pos=%u",
        device_->Id_(), *status, streamId_, eventPos);
    return RT_ERROR_NONE;
}

void DavidStream::ResetDavidStreamConstruct()
{
    publicQueueHead_ = 0U;
    publicQueueTail_ = 0U;
    recordVersion_.Set(0);
    finishTaskId_ = MAX_UINT32_NUM;
    SetTaskIdFlipNum(0);
    SetRecycleFlag(false);
    SetLimitFlag(false);
    SetRecycleEndTaskId(MAX_UINT16_NUM);
    isNeedRecvCqe_ = false;
    SetNeedSyncFlag(false);
    syncTimeout_ = -1;
    isForceRecycle_ = false;
    errCode_ = 0U;
    drvErr_ = 0U;
    failureMode_ = GetMode();
    SetLastTaskId(MAX_UINT32_NUM);
    errorMsg_.clear();
    latestConcernedTaskId.Set(MAX_UINT16_NUM);
    SetExecuteEndTaskId(static_cast<uint16_t>(MAX_UINT16_NUM));
    if (taskResMang_ != nullptr) {
        (dynamic_cast<TaskResManageDavid *>(taskResMang_))->ResetTaskRes();
    }
}

uint32_t DavidStream::GetDelayRecycleTaskSqeNum(void) const
{
    if (taskResMang_ != nullptr) {
        return (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetTaskPosTail();
    }
    return 0UL;
}

rtError_t DavidStream::ResClear(uint64_t timeout)
{
    const uint64_t startTime = ClockGetTimeUs();
    uint64_t timeCost = 0ULL;
    uint64_t tryCount = 0ULL;
    constexpr uint64_t perDetectTimes = 1000ULL;
    if (taskResMang_ != nullptr) {
        while ((dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetPendingNum() > 0U) {
            COND_RETURN_ERROR((device_->GetDevRunningState() == static_cast<uint32_t>(DEV_RUNNING_DOWN)), RT_ERROR_DRV_ERR,
                "device_id=%u is down, clear stream_id=%u", device_->Id_(), streamId_);
            isForceRecycle_ = true;
            SetNeedRecvCqeFlag(false);
            RT_LOG(RT_LOG_INFO, "stream_id=%d, pendingNum=%d, forcerecycle.", streamId_,
                (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetPendingNum());
            StreamSyncLock();
            if (IsSeparateSendAndRecycle()) {
                StreamRecycleLock();
                RecycleTaskBySqHeadForRecyleThread(this);
                StreamRecycleUnlock();
            } else {
                (void)TaskReclaimByStream(this, false);
            }
            StreamSyncUnLock();
            timeCost = ClockGetTimeIntervalUs(startTime);
            tryCount++;
            if(timeout > 0ULL && tryCount % perDetectTimes == 0ULL) {
                COND_RETURN_ERROR((timeCost >= timeout), RT_ERROR_WAIT_TIMEOUT,
                    "TaskReclaimByStream timeout, device_id=%u, stream_id=%d, time=%llu us", 
                    device_->Id_(), streamId_, timeCost);
                (void)mmSleep(1U);
            }
        }
    }
    StreamRecycleLock();
    ResetDavidStreamConstruct();
    StreamRecycleUnlock();
    return RT_ERROR_NONE;
}

void DavidStream::ModelTaskClean()
{
    RecycleModelBindStreamAllTask(this, true);
    isModelComplete = false;
}

rtError_t DavidStream::ModelAbortById(uint32_t modelId)
{
    rtError_t error;
    const mmTimespec beginTime = mmGetTickCount();
    uint32_t result = static_cast<uint32_t>(RT_ERROR_NONE);
    uint64_t count;
    do {
        error = TaskAbortByType(result, OP_ABORT_MODEL, modelId);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Failed to abort model, model_id=%d, retCode=%#x.",
            modelId, static_cast<uint32_t>(error));
        if (result == TS_SUCCESS) {
            break;
        }

        COND_RETURN_ERROR((result == TS_ERROR_ILLEGAL_PARAM) || (result == TS_APP_EXIT_UNFINISHED) ||
            (result == TS_ERROR_ABORT_UNFINISHED), RT_ERROR_TSFW_ILLEGAL_PARAM,
            "Ts param invalid or abort exit unfinished, model_id=%d, result=%u.", modelId, result);

        count = GetTimeInterval(beginTime);
        COND_RETURN_ERROR((count >= static_cast<uint64_t>(RT_ABORT_STREAM_TIMEOUT)), RT_ERROR_WAIT_TIMEOUT,
            "Abort query timeout, device_id=%u, model_id=%d, time=%lums", device_->Id_(), modelId, count);
        (void)mmSleep(1U);
    } while (result == TS_ERROR_APP_QUEUE_FULL);

    // RT_ABORT_STREAM_TIMEOUT
    uint32_t status;
    while (true) {
        error = QueryAbortStatusByType(status, APP_ABORT_STS_QUERY_BY_MODELID, modelId);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "abort query fail, retCode=%#x.",
            static_cast<uint32_t>(error));
        if ((status == DAVID_ABORT_TERMINATE_SUCC) || (status == DAVID_ABORT_STOP_FINISH)) {
            break;
        }
        COND_RETURN_ERROR((status == DAVID_ABORT_TERMINATE_FAIL), RT_ERROR_TSFW_ILLEGAL_PARAM,
            "Device desc status invalid, device_id=%u, model_id=%d, status=%u.", device_->Id_(), modelId, status);

        count = GetTimeInterval(beginTime);
        COND_RETURN_ERROR((count >= static_cast<uint64_t>(RT_ABORT_MODEL_TIMEOUT)), RT_ERROR_WAIT_TIMEOUT,
            "Abort query timeout, device_id=%u, model_id=%d, time=%lums", device_->Id_(), modelId, count);
        (void)mmSleep(5U);
    }

    COND_RETURN_ERROR((status == DAVID_ABORT_STOP_FINISH), RT_ERROR_TSFW_TASK_ABORT_STOP,
        "Model abort stop before post process, model_id=%d.", modelId);

    return error;
}

rtError_t DavidStream::StreamRecoverAbort()
{
    rtError_t error;
    const mmTimespec beginTime = mmGetTickCount();
    uint32_t result = static_cast<uint32_t>(RT_ERROR_NONE);
    uint64_t count;
    do {
        error = RecoverAbortByType(OP_RECOVER_STREAM, sqId_, result);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "Failed to recover stream, stream_id=%d, sq_id=%d, "
            "retCode=%#x.", streamId_, sqId_, static_cast<uint32_t>(error));
        if (result == TS_SUCCESS) {
            break;
        }
        COND_RETURN_ERROR((result == TS_ERROR_ILLEGAL_PARAM) || (result == TS_APP_EXIT_UNFINISHED),
            RT_ERROR_TSFW_ILLEGAL_PARAM, "Tsfw param invalid or app exit unfinished, device_id=%u, "
            "stream_id=%d, sq_id=%d, result=%u.", device_->Id_(), streamId_, sqId_, result);

        count = GetTimeInterval(beginTime);
        COND_RETURN_ERROR((count >= static_cast<uint64_t>(RT_ABORT_STREAM_TIMEOUT)), RT_ERROR_WAIT_TIMEOUT,
            "Abort query timeout, device_id=%u, stream_id=%d, time=%lums", device_->Id_(), streamId_, count);
        (void)mmSleep(1U);
    } while (result == TS_ERROR_APP_QUEUE_FULL);

    uint32_t status;
    do {
        error = QueryRecoverStatusByType(status, RECOVER_STS_QUERY_BY_SQID, sqId_);
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "abort query fail, retCode=%#x.",
            static_cast<uint32_t>(error));
        if (status == RECOVER_SUCC) {
            break;
        }
        COND_RETURN_ERROR((status == TS_ERROR_ILLEGAL_PARAM), RT_ERROR_TSFW_ILLEGAL_PARAM,
            "Tsfw param invalid or app exit unfinished, device_id=%u, stream_id=%d, sq_id=%d, status=%u.",
            device_->Id_(), streamId_, sqId_, status);
        count = GetTimeInterval(beginTime);
        COND_RETURN_ERROR((count >= static_cast<uint64_t>(RT_ABORT_STREAM_TIMEOUT)), RT_ERROR_WAIT_TIMEOUT,
            "Abort query timeout, device_id=%u, stream_id=%d, time=%lums", device_->Id_(), streamId_, count);
        (void)mmSleep(5U);
    } while (true);

    if (status == RECOVER_SUCC) {
        error = device_->Driver_()->ResetSqCq(device_->Id_(), device_->DevGetTsId(), sqId_, Flags());
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ResetSqCq fail, retCode=%#x.", error);
        error = device_->Driver_()->ResetLogicCq(device_->Id_(), device_->DevGetTsId(), GetLogicalCqId(), Flags());
        COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "ResetLogicCq fail, retCode=%#x.", error);
    }

    return error;
}

rtError_t DavidStream::StreamTaskClean()
{
    const uint32_t devId = device_->Id_();
    Driver * const devDrv = device_->Driver_();
    const uint32_t tsId = device_->DevGetTsId();
    bool enable = true;
    rtError_t error = devDrv->GetSqEnable(devId, tsId, sqId_, enable);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error,
        "Get sq enable status fail, device_id=%u, ts_id=%d, stream_id=%d, sq_id=%d", devId, tsId, streamId_, sqId_);
    COND_RETURN_ERROR((enable != false), RT_ERROR_STREAM_INVALID,
        "Sq must be disable when clean task, device_id=%u, ts_id=%d, stream_id=%d, sq_id=%d",
        devId, tsId, streamId_, sqId_);
    ModelTaskClean();
    // set tail 0
    error = device_->Driver_()->SetSqTail(device_->Id_(), device_->DevGetTsId(), sqId_, 0U);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "SetSqTail fail, retCode=%#x.", static_cast<uint32_t>(error));
    error = device_->Driver_()->SetSqHead(device_->Id_(), device_->DevGetTsId(), sqId_, 0U);
    COND_RETURN_ERROR((error != RT_ERROR_NONE), error, "SetSqHead fail, retCode=%#x.", static_cast<uint32_t>(error));
    return error;
}

bool DavidStream::IsWaitFinish(const uint32_t finishedTaskId, const uint32_t submittedTaskId)
{
    UNUSED(finishedTaskId);
    uint16_t head = 0U;
    uint16_t tail = 0U;
    RtPtrToPtr<TaskResManageDavid *>(taskResMang_)->GetHeadTail(head, tail);
    const bool flip = (head < tail) ? false : true;
    const bool flag1 = (!flip) && (!((submittedTaskId >= head) && (submittedTaskId < tail)));
    const bool flag2 = flip && ((submittedTaskId >= tail) && (submittedTaskId < head));
    return (flag1 || flag2 || (head == tail));
}

rtError_t DavidStream::GetAbortStatus() const {
    return abortStatus_;
}

bool DavidStream::AddArgToRecycleList(TaskInfo * const tsk)
{
    if (argRecycleList_ == nullptr) {
        return false;
    }

    const std::unique_lock<std::mutex> lk(argRecycleListMutex_);
    if (((argRecycleListTail_ + 1U) % argRecycleListSize_) == argRecycleListHead_) {
        RT_LOG(RT_LOG_DEBUG, "arg handle list is full, head=%hu, tail=%hu", argRecycleListHead_, argRecycleListTail_);
        return false;
    }

    RecycleArgs *recycleArgs = *(argRecycleList_ + argRecycleListTail_);
    if ((tsk->type == TS_TASK_TYPE_KERNEL_AICORE) || (tsk->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
        recycleArgs->argHandle = tsk->u.aicTaskInfo.comm.argHandle;
        tsk->u.aicTaskInfo.comm.argHandle = nullptr;
    } else if (tsk->type == TS_TASK_TYPE_KERNEL_AICPU) {
        recycleArgs->argHandle = tsk->u.aicpuTaskInfo.comm.argHandle;
        tsk->u.aicpuTaskInfo.comm.argHandle = nullptr;
    } else if (tsk->type == TS_TASK_TYPE_FUSION_KERNEL) {
        recycleArgs->argHandle = tsk->u.fusionKernelTask.argHandle;
        tsk->u.fusionKernelTask.argHandle = nullptr;
    } else {
        // no operation
    }
    argRecycleListTail_ = (argRecycleListTail_ + 1U) % argRecycleListSize_;
    return true;
}

void DavidStream::ProcArgRecycleList(void)
{
    RecycleArgs *recycleArgs = GetNextRecycleArg();
    while (recycleArgs != nullptr) {
        if (recycleArgs->argHandle != nullptr) {
            if (argManage_ != nullptr) {
                argManage_->RecycleDevLoader(recycleArgs->argHandle);
            }
            recycleArgs->argHandle = nullptr;
        }
        recycleArgs = GetNextRecycleArg();
    }
}

void DavidStream::ArgReleaseSingleTask(TaskInfo * const taskInfo, bool freeStmPool)
{
    if (freeStmPool) {
        if (argManage_ != nullptr) {
            (void)argManage_->RecycleStmArgPos(taskInfo->id, taskInfo->stmArgPos);
        }
        taskInfo->stmArgPos = UINT32_MAX;
    }
    if (IsDavinciTask(taskInfo)) {
        auto commDavinciInfo = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) ? &(taskInfo->u.aicpuTaskInfo.comm) :
            &(taskInfo->u.aicTaskInfo.comm);

        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
            this->SetArgHandle(commDavinciInfo->argHandle);
        } else {
            if (argManage_ != nullptr) {
                argManage_->RecycleDevLoader(commDavinciInfo->argHandle);
            }
        }

        commDavinciInfo->argHandle = nullptr;
    } else if (IsFusionKernelTask(taskInfo)) {
        FusionTaskInfo *fusionKernelTask = &(taskInfo->u.fusionKernelTask);
        if (argManage_ != nullptr) {
            argManage_->RecycleDevLoader(fusionKernelTask->argHandle);
        }
        fusionKernelTask->argHandle = nullptr;
    } else{
        // no operation
    }
}

void DavidStream::ArgReleaseStmPool(TaskInfo * const taskInfo)
{
    if (argManage_ != nullptr) {
        (void)argManage_->RecycleStmArgPos(taskInfo->id, taskInfo->stmArgPos);
    }
    taskInfo->stmArgPos = UINT32_MAX;
}

void DavidStream::ArgReleaseMultipleTask(TaskInfo * const taskInfo)
{
    DavinciMultiTaskInfo *davMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    if (davMultiTaskInfo->argHandleVec != nullptr) {
        for (auto iter : *(davMultiTaskInfo->argHandleVec)) {
            if (argManage_ != nullptr) {
                argManage_->RecycleDevLoader(iter);
            }
        }
        davMultiTaskInfo->argHandleVec->clear();
        delete davMultiTaskInfo->argHandleVec;
        davMultiTaskInfo->argHandleVec = nullptr;
    }
}

uint32_t DavidStream::GetArgPos()
{
    if (argManage_ != nullptr) {
        return argManage_->GetStmArgPos();
    }
    return UINT32_MAX;
}


bool DavidStream::IsSeparateSendAndRecycle()
{
    return false;
}

bool DavidStream::IsTaskExcuted(const uint32_t executeEndTaskid, const uint32_t taskId)
{
    return IsWaitFinish(executeEndTaskid, taskId);
}

rtError_t DavidStream::GetTaskIdByPos(const uint16_t pos, uint32_t &taskId)
{
    COND_RETURN_DEBUG(taskResMang_ == nullptr, RT_ERROR_NONE, "taskResMang_ is null");

    TaskInfo *taskInfo = (dynamic_cast<TaskResManageDavid *>(taskResMang_))->GetTaskInfo(pos);
    COND_RETURN_WARN(taskInfo == nullptr, RT_ERROR_INVALID_VALUE, "taskInfo is null, pos=%u", pos);

    taskId = taskInfo->id;
    return RT_ERROR_NONE;
}

uint32_t DavidStream::GetTaskPosHead() const
{
    COND_RETURN_DEBUG(taskResMang_ == nullptr, RT_ERROR_NONE, "taskResMang_ is null");

    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    return static_cast<uint32_t>(taskRes->GetTaskPosHead());
}

uint32_t DavidStream::GetTaskPosTail() const
{
    COND_RETURN_DEBUG(taskResMang_ == nullptr, RT_ERROR_NONE, "taskResMang_ is null");

    TaskResManageDavid *taskRes = RtPtrToPtr<TaskResManageDavid *>(taskResMang_);
    return static_cast<uint32_t>(taskRes->GetTaskPosTail());
}

}  // namespace runtime
}  // namespace cce