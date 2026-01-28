/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "notify.hpp"

#include "device.hpp"
#include "osal.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "task_submit.hpp"
#include "ctrl_sq.hpp"

namespace cce {
namespace runtime {
Notify::Notify(const uint32_t devId, const uint32_t taskSchId)
    : NoCopy(), notifyid_(MAX_UINT32_NUM), phyId_(0U), isIpcNotify_(false),
      isIpcCreator_(false), driver_(nullptr), tsId_(taskSchId),
      deviceId_(devId), dieId_(0U), endGraphModel_(nullptr),
      lastLocalId_(MAX_UINT32_NUM), lastBaseAddr_(0UL), lastIsPcie_(false),
      notifyFlag_(0U), localDevId_(UINT32_MAX),
      srvId_(RT_NOTIFY_INVALID_SRV_ID), chipId_(0U), isPod_(false)
{
}

Notify::~Notify() noexcept
{
    if (dev_ != nullptr) {
        dev_->RemoveNotify(this);
    }
    endGraphModel_ = nullptr;
    if (driver_ == nullptr) {
        return;
    }

    if (isIpcNotify_) {
        if (isIpcCreator_) {
            (void)driver_->DestroyIpcNotify(ipcName_.c_str(), static_cast<int32_t>(deviceId_), notifyid_, tsId_);
            (void)driver_->NotifyIdFree(static_cast<int32_t>(deviceId_), notifyid_, tsId_, notifyFlag_);
        } else {
            (void)driver_->CloseIpcNotify(ipcName_.c_str(), static_cast<int32_t>(localDevId_), notifyid_, tsId_);
        }
    } else if (notifyid_ != MAX_UINT32_NUM) {
        (void)driver_->NotifyIdFree(static_cast<int32_t>(deviceId_), notifyid_, tsId_, notifyFlag_);
    } else {
        // no operation
    }

    driver_ = nullptr;
}

rtError_t Notify::FreeId()
{
    COND_PROC(driver_ == nullptr, return RT_ERROR_NOTIFY_NULL);
    COND_PROC(isIpcNotify_ || notifyid_ == MAX_UINT32_NUM, return RT_ERROR_NOTIFY_NOT_COMPLETE);
    COND_PROC(dev_ != nullptr, dev_->RemoveNotify(this));

    (void)driver_->NotifyIdFree(static_cast<int32_t>(deviceId_), notifyid_, tsId_, notifyFlag_); 
    notifyid_ = MAX_UINT32_NUM;
    return RT_ERROR_NONE;
}

rtError_t Notify::AllocId()
{
    COND_PROC((dev_ == nullptr || driver_ == nullptr), return RT_ERROR_NOTIFY_NULL);

    const rtError_t error = driver_->NotifyIdAlloc(static_cast<int32_t>(deviceId_), &notifyid_, dev_->DevGetTsId(), notifyFlag_);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "NotifyIdAlloc failed, device_id=%u, retCode=%#x!",
            deviceId_, static_cast<uint32_t>(error));

    dev_->RemoveNotify(this);
    dev_->PushNotify(this);
    return RT_ERROR_NONE;
}

rtError_t Notify::Setup()
{
    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
    Context * const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Device * const dev = curCtx->Device_();
    driver_ = dev->Driver_();

    rtError_t error = driver_->GetDevicePhyIdByIndex(deviceId_, &phyId_);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "GetPhyIdByLogicIndex failed, device_id=%u, phydevice_id=%u, retCode=%#x!",
            deviceId_, phyId_, static_cast<uint32_t>(error));
        return error;
    }
    uint32_t curNotifyId = 0U;
    RT_LOG(RT_LOG_INFO, "notify_flag=%u", notifyFlag_);
    error = driver_->NotifyIdAlloc(static_cast<int32_t>(deviceId_), &curNotifyId, dev->DevGetTsId(), notifyFlag_);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "NotifyIdAlloc failed, device_id=%u, retCode=%#x!",
            deviceId_, static_cast<uint32_t>(error));
        return error;
    }

    dev_ = dev;
    dev_->PushNotify(this);
    notifyid_ = curNotifyId;
    return RT_ERROR_NONE;
}

rtError_t Notify::ReAllocId() const
{
    Context * const curCtx = Runtime::Instance()->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    const rtError_t ret = driver_->ReAllocResourceId(deviceId_, dev->DevGetTsId(), 0U, notifyid_, DRV_NOTIFY_ID);
    ERROR_RETURN(ret, "NotifyId ReAlloc failed, notifyid=%u, device_id=%u, retCode=%d!", notifyid_, deviceId_, ret);
    return RT_ERROR_NONE;
}

rtError_t Notify::Record(Stream * const streamIn)
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);
    Device * const dev = streamIn->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *notifyTask = streamIn->AllocTask(&submitTask, TS_TASK_TYPE_NOTIFY_RECORD, errorReason);
    NULL_PTR_RETURN_MSG(notifyTask, errorReason);

    bool isIpc = false;
    if (isIpcNotify_) {
        isIpc = true;
    }

    if (lastLocalId_ != streamIn->Device_()->Id_()) {
        lastBaseAddr_ = 0UL;
        lastLocalId_ = MAX_UINT32_NUM;
        lastIsPcie_ = false;
    }

    RT_LOG(RT_LOG_INFO, "isIpc=%d, notify_id=%d, lastLocalId=%u, lastBaseAddr_=%#x, device_id=%u",
           isIpc, notifyid_, lastLocalId_, lastBaseAddr_, streamIn->Device_()->Id_());
    SingleBitNotifyRecordInfo singleInfo = {isIpc, false, lastIsPcie_, isPod_, lastLocalId_, lastBaseAddr_, false};
    rtError_t error = NotifyRecordTaskInit(notifyTask, notifyid_, static_cast<int32_t>(deviceId_),
        phyId_, &singleInfo, nullptr, static_cast<void *>(this));
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    error = dev->SubmitTask(notifyTask, (streamIn->Context_())->TaskGenCallback_());
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    RT_LOG(RT_LOG_INFO, "refreash, lastLocalId=%u, lastBaseAddr_=0x%llx, lastIsPcie=%s, device_id=%u",
           lastLocalId_, lastBaseAddr_, lastIsPcie_ ? "True" : "False", streamIn->Device_()->Id_());

    GET_THREAD_TASKID_AND_STREAMID(notifyTask, streamIn->Id_());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(notifyTask);
    return error;
}


rtError_t Notify::Reset(Stream * const streamIn) const
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);
    Device * const dev = streamIn->Device_();
    if (dev->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_CTRL_SQ)) {
        return dev->GetCtrlSQ().SendNotifyResetMsg(notifyid_);
    }
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *notifyTask = streamIn->AllocTask(&submitTask, TS_TASK_TYPE_COMMON_CMD, errorReason);
    NULL_PTR_RETURN_MSG(notifyTask, errorReason);

    CommonCmdTaskInfo cmdInfo;
    cmdInfo.notifyId = notifyid_;
    CommonCmdTaskInit(notifyTask, CMD_NOTIFY_RESET, &cmdInfo);

    auto error = dev->SubmitTask(notifyTask, (streamIn->Context_())->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE, "Failed to submit notify reset Task, retCode=%#x", error);

    error = streamIn->Synchronize();
    ERROR_RETURN_MSG_INNER(error, "Failed to synchronize notify reset Task, streamId=%d, retCode=%#x",
        streamIn->Id_(), static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
    
ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(notifyTask);
    return error;
}

rtError_t Notify::GetNotifyAddress(Stream * const streamIn, uint64_t &addr)
{
    rtError_t error;
    const rtChipType_t chipType = Runtime::Instance()->GetChipType();
    if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_NOTIFY_USER_VA_MAPPING)) {
        rtDevResInfo resInfo = {
            GetTsId(), RT_PROCESS_CP1, RT_RES_TYPE_STARS_NOTIFY_RECORD, notifyid_, 0U
        };
        uint64_t resAddr = 0U;
        uint32_t len = 0U;
        error = NpuDriver::GetDevResAddress(deviceId_, &resInfo, &resAddr, &len);
        addr = resAddr;
        return error;
    }
    TaskInfo notifyTask = {};
    InitByStream(&notifyTask, streamIn);
    bool isIpc = false;
    if (isIpcNotify_) {
        isIpc = true;
    }
    COND_RETURN_WITH_NOLOG((!isIpc), RT_ERROR_NOTIFY_TYPE);

    SingleBitNotifyRecordInfo singleInfo = {isIpc, false, false, isPod_, MAX_UINT32_NUM, 0UL, false};
    error = NotifyRecordTaskInit(&notifyTask, notifyid_, static_cast<int32_t>(deviceId_),
                                 phyId_, &singleInfo, nullptr, static_cast<void *>(this));
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), RT_ERROR_NOTIFY_NOT_COMPLETE);

    (void)GetIpcSqeWriteAddrForNotifyRecordTask(&notifyTask, addr);
    return RT_ERROR_NONE;
}

rtError_t Notify::RevisedWait(Stream * const streamIn, const uint32_t timeout)
{
    Device * const dev = streamIn->Device_();

    TaskInfo submitWaitTask = {};
    TaskInfo submitResetTask = {};
    TaskInfo *resetTask = nullptr;
    TaskInfo *waitTask = nullptr;
    rtError_t errorReason;

    waitTask = streamIn->AllocTask(&submitWaitTask, TS_TASK_TYPE_STREAM_WAIT_EVENT, errorReason);
    NULL_PTR_RETURN_MSG(waitTask, errorReason);

    const uint32_t eventId = RT_NOTIFY_GET_EVENT_ID(notifyid_);
    rtError_t error = EventWaitTaskInit(waitTask, nullptr, static_cast<int32_t>(eventId), timeout, 1U);
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE_WAIT, "Failed to init event wait task, notifyid=%u, "
                                                    "retCode=%#x!", notifyid_, static_cast<uint32_t>(error));

    error = dev->SubmitTask(waitTask, (streamIn->Context_())->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE_WAIT, "Failed to submit event wait task, retCode=%#x!",
                         static_cast<uint32_t>(error));

    resetTask = streamIn->AllocTask(&submitResetTask, TS_TASK_TYPE_EVENT_RESET, errorReason);
    NULL_PTR_RETURN_MSG(resetTask, errorReason);

    error = EventResetTaskInit(resetTask, nullptr, true, static_cast<int32_t>(eventId));
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE_RESET, "Failed to init event reset task, notifyid=%u, "
                                                     "retCode=%#x!", notifyid_, static_cast<uint32_t>(error));

    error = dev->SubmitTask(resetTask, (streamIn->Context_())->TaskGenCallback_());
    ERROR_GOTO_MSG_INNER(error, ERROR_RECYCLE_RESET, "Failed to submit event reset task, retCode=%#x!",
                         static_cast<uint32_t>(error));

    return RT_ERROR_NONE;
ERROR_RECYCLE_RESET:
    (void)dev->GetTaskFactory()->Recycle(resetTask);
    return error;
ERROR_RECYCLE_WAIT:
    (void)dev->GetTaskFactory()->Recycle(waitTask);
    return error;
}

rtError_t Notify::Wait(Stream * const streamIn, const uint32_t timeOut, const bool isEndGraphNotify, Model* const captureModel)
{
    if ((notifyid_ >> RT_NOTIFY_REVISED_OFFSET) > 0U) {
        return RevisedWait(streamIn, timeOut);
    }

    Device * const dev = streamIn->Device_();
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *waitTask = streamIn->AllocTask(&submitTask, TS_TASK_TYPE_NOTIFY_WAIT, errorReason);
    NULL_PTR_RETURN_MSG(waitTask, errorReason);

    rtError_t error = NotifyWaitTaskInit(waitTask, notifyid_, timeOut, nullptr, this);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    waitTask->u.notifywaitTask.isEndGraphNotify = isEndGraphNotify;
    waitTask->u.notifywaitTask.captureModel = captureModel;

    error = dev->SubmitTask(waitTask, (streamIn->Context_())->TaskGenCallback_());
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(waitTask, streamIn->Id_());

    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)dev->GetTaskFactory()->Recycle(waitTask);
    return error;
}

rtError_t Notify::SetName(const char_t * const nameIn)
{
    (void)name_.assign(nameIn);

    return RT_ERROR_NONE;
}

rtError_t Notify::CreateIpcNotify(char_t * const ipcNotifyName, const uint32_t len)
{
    COND_RETURN_ERROR_MSG_INNER(isIpcNotify_, RT_ERROR_NOTIFY_TYPE,
        "Create ipc notify failed, ipc notify flag can not be true");
    NULL_PTR_RETURN_MSG(driver_, RT_ERROR_DRV_NULL);
    uint32_t curNotifyId = notifyid_;

    rtError_t error = driver_->CreateIpcNotify(ipcNotifyName, len, static_cast<int32_t>(deviceId_),
                                               &curNotifyId, tsId_, notifyFlag_);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    if (curNotifyId != notifyid_) {
        error = driver_->NotifyIdFree(static_cast<int32_t>(deviceId_), notifyid_, tsId_, notifyFlag_);
        if (error != RT_ERROR_NONE) {
            (void)driver_->DestroyIpcNotify(ipcNotifyName, static_cast<int32_t>(deviceId_), curNotifyId, tsId_);
            return error;
        }
        notifyid_ = curNotifyId;
    }

    isIpcCreator_ = true;
    isIpcNotify_ = true;
    (void)ipcName_.assign(ipcNotifyName);

    RT_LOG(RT_LOG_INFO, "name=%s notify_id=%u", ipcNotifyName, notifyid_);
    return RT_ERROR_NONE;
}

rtError_t Notify::GetAddrOffset(uint64_t * const devAddrOffset)
{
    NULL_PTR_RETURN_MSG(driver_, RT_ERROR_DRV_NULL);
    return driver_->NotifyGetAddrOffset(static_cast<int32_t>(deviceId_), notifyid_, devAddrOffset, tsId_);
}

rtError_t Notify::CheckIpcNotifyDevId()
{
    if (isIpcNotify_) {
        Runtime *runtime = Runtime::Instance();
        NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
        Context *const curCtx = runtime->CurrentContext();
        CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
        Device *dev = curCtx->Device_();
        NULL_PTR_RETURN_MSG(dev, RT_ERROR_DEVICE_NULL);
        RT_LOG(RT_LOG_INFO, "name=%s, device_id=%u, ctx_device_id=%u", ipcName_.c_str(), deviceId_, dev->Id_());
        
        // deviceId_: notify create param, drv deviceId; dev->Id_: from ctx, drv deviceId 
        if (deviceId_ != dev->Id_()) {
            RT_LOG(RT_LOG_ERROR, "ipc notify can not notify wait, name=%s, device_id=%u, ctx_device_id=%u",
                ipcName_.c_str(), deviceId_, dev->Id_());
            return RT_ERROR_INVALID_VALUE;
        }
    }
    return RT_ERROR_NONE;
}

rtError_t Notify::OpenIpcNotify(const char_t * const ipcNotifyName, uint32_t flag)
{
    COND_RETURN_ERROR_MSG_INNER(isIpcNotify_, RT_ERROR_NOTIFY_TYPE,
        "Open ipc notify failed, flag can not be true, name is %s.",
        (ipcNotifyName == nullptr) ? "(null)" : ipcNotifyName);

    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
    Context * const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);

    Device *dev = curCtx->Device_();
    if (driver_ == nullptr) {
        driver_ = dev->Driver_();
    }

    uint32_t curTsId = 0U;
    uint32_t curNotifyId = 0U;
    localDevId_ = dev->Id_();
    uint32_t isPod = 0U;

    IpcNotifyOpenPara openPara = {ipcNotifyName, flag, localDevId_, dev->DevGetTsId()};
    rtError_t error = driver_->OpenIpcNotify(openPara, &phyId_, &curNotifyId, &curTsId, &isPod);
    ERROR_RETURN_MSG_INNER(error, "Failed to OpenIpcNotify, retCode=%#x!", static_cast<uint32_t>(error));

    isIpcNotify_ = true;
    (void)ipcName_.assign(ipcNotifyName);
    notifyid_ = curNotifyId;
    tsId_ = curTsId;

    if (isPod == 0U) {
        isPod_ = false;
        int64_t val;
        error = driver_->GetDevInfo(localDevId_, MODULE_TYPE_SYSTEM, INFO_TYPE_SERVER_ID, &val);
        if (error != RT_ERROR_NONE) {
            val = RT_NOTIFY_INVALID_SRV_ID;
        }
        srvId_ = static_cast<uint32_t>(val);
        if (NpuDriver::CheckIsSupportFeature(localDevId_, FEATURE_DMS_QUERY_CHIP_DIE_ID)) {
            RT_LOG(RT_LOG_INFO, "name=%s phyId=%u", ipcNotifyName, phyId_);
            return RT_ERROR_NONE;
        }
        error = driver_->GetDeviceIndexByPhyId(phyId_, &deviceId_);
        ERROR_RETURN_MSG_INNER(error, "Failed to get devId, retCode=%#x, PhyId=%u",
            static_cast<uint32_t>(error), phyId_);
        RT_LOG(RT_LOG_INFO, "name=%s phyId=%u deviceId=%u", ipcNotifyName, phyId_, deviceId_);
    } else {
        error = driver_->ParseSDID(phyId_, &srvId_, &chipId_, &dieId_, &deviceId_);
        ERROR_RETURN_MSG_INNER(error, "phyId=%u", phyId_);
        RT_LOG(RT_LOG_INFO, "sdid=0x%x, srvid=%u, chipId=%u, dieId=%u, deviceId_=%u",
            phyId_, srvId_, chipId_, dieId_, deviceId_);
        isPod_ = true;
    }
    COND_RETURN_ERROR(((isPod_ == true) && (srvId_ > RT_NOTIFY_MAX_SRV_ID)), RT_ERROR_INVALID_VALUE,
        "phyId_=0x%x, srvid=%u, chipId=%u, dieId=%u,",
        phyId_, srvId_, chipId_, dieId_);
    return error;
}
}
}
