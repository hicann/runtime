/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "notify.hpp"
#include "runtime_handle_guard.h"

#include "device.hpp"
#include "osal.hpp"
#include "runtime.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "inner_thread_local.hpp"
#include "notify_task.h"

namespace cce {
namespace runtime {
Notify::Notify(const uint32_t devId, const uint32_t taskSchId)
    : NoCopy(),
      notifyid_(MAX_UINT32_NUM),
      phyId_(0U),
      isIpcNotify_(false),
      isIpcCreator_(false),
      driver_(nullptr),
      tsId_(taskSchId),
      deviceId_(devId),
      dieId_(0U),
      adcDieId_(0U),
      endGraphModel_(nullptr),
      lastLocalId_(MAX_UINT32_NUM),
      lastBaseAddr_(0UL),
      lastIsPcie_(false),
      notifyFlag_(0U),
      localDevId_(UINT32_MAX),
      srvId_(RT_NOTIFY_INVALID_SRV_ID),
      chipId_(0U),
      isPod_(false)
{}

Notify::~Notify() noexcept
{
    ResetEmbeddedInnerHandle<Notify>(this);
    if (dev_ != nullptr) {
        dev_->RemoveNotify(this);
    }
    endGraphModel_ = nullptr;
    if (driver_ == nullptr) {
        return;
    }
    ReleaseDriverResourceOnDestroy();
}

void Notify::ReleaseDriverResourceOnDestroy()
{
    if (notifyid_ != MAX_UINT32_NUM) {
        (void)driver_->NotifyIdFree(static_cast<int32_t>(deviceId_), notifyid_, tsId_, notifyFlag_);
    }
    driver_ = nullptr;
}

rtError_t Notify::Setup()
{
    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN(runtime, RT_ERROR_INSTANCE_NULL);
    Context* const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Device* const dev = curCtx->Device_();
    driver_ = dev->Driver_();

    rtError_t error = driver_->GetDevicePhyIdByIndex(deviceId_, &phyId_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Failed to get phy id by logic index, device_id=%u, phydevice_id=%u, retCode=%#x.", deviceId_,
            phyId_, static_cast<uint32_t>(error));
        return error;
    }

    uint32_t curNotifyId = 0U;
    RT_LOG(RT_LOG_INFO, "notify_flag=%u", notifyFlag_);
    error = driver_->NotifyIdAlloc(static_cast<int32_t>(deviceId_), &curNotifyId, dev->DevGetTsId(), notifyFlag_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_WARNING, "Failed to allocate notify id, device_id=%u, retCode=%#x.", deviceId_,
            static_cast<uint32_t>(error));
        return error;
    }

    dev_ = dev;
    dev_->PushNotify(this);
    InitEmbeddedInnerHandle<Notify>(this);
    notifyid_ = curNotifyId;
    return RT_ERROR_NONE;
}

rtError_t Notify::Record(Stream* const streamIn)
{
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(streamIn, RT_ERROR_STREAM_NULL, "Notify recording");
    Device* const dev = streamIn->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* notifyTask = streamIn->AllocTask(&submitTask, TS_TASK_TYPE_NOTIFY_RECORD, errorReason);
    NULL_PTR_RETURN_MSG(notifyTask, errorReason);

    bool isIpc = false;
    if (lastLocalId_ != streamIn->Device_()->Id_()) {
        lastBaseAddr_ = 0UL;
        lastLocalId_ = MAX_UINT32_NUM;
        lastIsPcie_ = false;
    }

    RT_LOG(
        RT_LOG_INFO, "isIpc=%d, notify_id=%d, lastLocalId=%u, lastBaseAddr_=%#x, device_id=%u", isIpc, notifyid_,
        lastLocalId_, lastBaseAddr_, streamIn->Device_()->Id_());
    SingleBitNotifyRecordInfo singleInfo = {isIpc, false, lastIsPcie_, isPod_, lastLocalId_, lastBaseAddr_, false};
    rtError_t error = NotifyRecordTaskInit(
        notifyTask, notifyid_, static_cast<int32_t>(deviceId_), phyId_, &singleInfo, nullptr, static_cast<void*>(this));
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = dev->SubmitTask(notifyTask);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    RT_LOG(
        RT_LOG_INFO, "refresh, lastLocalId=%u, lastBaseAddr_=0x%llx, lastIsPcie=%s, device_id=%u", lastLocalId_,
        lastBaseAddr_, lastIsPcie_ ? "True" : "False", streamIn->Device_()->Id_());

    GET_THREAD_TASKID_AND_STREAMID(notifyTask, streamIn->Id_());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(notifyTask);
    return error;
}

rtError_t Notify::Wait(
    Stream* const streamIn, const uint32_t timeOut, const bool isEndGraphNotify, Model* const captureModel)
{
    Device* const dev = streamIn->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo* waitTask = streamIn->AllocTask(&submitTask, TS_TASK_TYPE_NOTIFY_WAIT, errorReason);
    NULL_PTR_RETURN_MSG(waitTask, errorReason);
    std::function<void()> const errRecycle = [&dev, &waitTask]() { (void)dev->GetTaskFactory()->Recycle(waitTask); };
    ScopeGuard waitTaskRecycle(errRecycle);

    rtError_t error = NotifyWaitTaskInit(waitTask, notifyid_, timeOut, nullptr, this);
    if (error != RT_ERROR_NONE) {
        return error;
    }

    waitTask->u.notifywaitTask.isEndGraphNotify = isEndGraphNotify;
    waitTask->u.notifywaitTask.captureModel = captureModel;
    error = AttachExternalEventsRes(waitTask, captureModel);
    ERROR_RETURN(
        error, "Failed to attach external events resources to graph end notify wait, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));

    error = dev->SubmitTask(waitTask);
    if (error != RT_ERROR_NONE) {
        return error;
    }
    waitTaskRecycle.ReleaseGuard();

    GET_THREAD_TASKID_AND_STREAMID(waitTask, streamIn->Id_());

    return RT_ERROR_NONE;
}

rtError_t Notify::ReAllocId() const { return RT_ERROR_NONE; }

rtError_t Notify::CheckIpcNotifyDevId() { return RT_ERROR_NONE; }
} // namespace runtime
} // namespace cce
