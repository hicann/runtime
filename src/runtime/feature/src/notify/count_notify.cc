/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "count_notify.hpp"
#include "device.hpp"
#include "osal.hpp"
#include "runtime.hpp"
#include "api.hpp"
#include "task.hpp"
#include "error_message_manage.hpp"
#include "thread_local_container.hpp"
#include "inner_thread_local.hpp"
#include "task_submit.hpp"
#include "task_david.hpp"
#include "stream_david.hpp"
#include "profiler_c.hpp"

namespace cce {
namespace runtime {
CountNotify::CountNotify(const uint32_t devId, const uint32_t taskSchId)
    : NoCopy(), tsId_(taskSchId), deviceId_(devId)
{
}

CountNotify::~CountNotify() noexcept
{
    if (driver_ == nullptr) {
        return;
    }
    if (notifyid_ != MAX_UINT32_NUM) {
        (void)driver_->NotifyIdFree(static_cast<int32_t>(deviceId_), notifyid_, tsId_, notifyFlag_, true);
    } else {
        // no operation
    }

    driver_ = nullptr;
}

rtError_t CountNotify::Setup()
{
    Runtime* runtime = Runtime::Instance();
    NULL_PTR_RETURN_MSG(runtime, RT_ERROR_INSTANCE_NULL);
    Context * const curCtx = runtime->CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(curCtx, RT_ERROR_CONTEXT_NULL);
    Device * const dev = curCtx->Device_();
    driver_ = dev->Driver_();

    rtError_t error = driver_->GetDevicePhyIdByIndex(deviceId_, &phyId_);
    ERROR_RETURN_MSG_INNER(error, "GetPhyIdByLogicIndex failed, device_id=%u, phydevice_id=%u, retCode=%#x!",
            deviceId_, phyId_, static_cast<uint32_t>(error));

    uint32_t curNotifyId = 0U;
    RT_LOG(RT_LOG_INFO, "notify_flag=%u", notifyFlag_);
    error = driver_->NotifyIdAlloc(static_cast<int32_t>(deviceId_), &curNotifyId, dev->DevGetTsId(), notifyFlag_, true);
    ERROR_RETURN_MSG_INNER(error, "count NotifyIdAlloc failed, device_id=%u, retCode=%#x!",
        deviceId_, static_cast<uint32_t>(error));

    notifyid_ = curNotifyId;
    return RT_ERROR_NONE;
}

rtError_t CountNotify::Record(Stream * const streamIn, const rtCntNtyRecordInfo_t * const info)
{
    NULL_PTR_RETURN_MSG(streamIn, RT_ERROR_STREAM_NULL);
    TaskInfo *recordTask = nullptr;
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.", streamIn->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    rtCntNtyRecordInfo_t cntInfo = {info->mode, info->value};
    Stream *dstStm = streamIn;
    streamIn->StreamLock();
    error = AllocTaskInfoForCapture(&recordTask, streamIn, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, streamIn->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    std::function<void()> const errRecycle = [&recordTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(recordTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    SaveTaskCommonInfo(recordTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = NotifyRecordTaskInit(recordTask, notifyid_, static_cast<int32_t>(deviceId_),
        phyId_, nullptr, &cntInfo, static_cast<void *>(this), true);
    ERROR_RETURN_MSG_INNER(error, "CntNotifyRecordTask init failed, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    recordTask->stmArgPos = (static_cast<DavidStream *>(dstStm))->GetArgPos();
    error = DavidSendTask(recordTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "CntNotifyRecordTask submit failed, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), recordTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

rtError_t CountNotify::GetCntNotifyAddress(uint64_t &addr, rtNotifyType_t regType)
{
    UNUSED(regType);
    rtDevResInfo resInfo = {
        tsId_, RT_PROCESS_CP1, RT_RES_TYPE_STARS_CNT_NOTIFY_RECORD, notifyid_, 0U
    };
    uint64_t resAddr = 0U;
    uint32_t len = 0U;
    const rtError_t error = NpuDriver::GetDevResAddress(deviceId_, &resInfo, &resAddr, &len);
    addr = resAddr;
    return error;
}

rtError_t CountNotify::Wait(Stream * const streamIn, const rtCntNtyWaitInfo_t * const info)
{
    TaskInfo *waitTask = nullptr;
    CountNotifyWaitInfo cntNtfyInfo = {info->mode, info->value, info->isClear};
    rtError_t error = CheckTaskCanSend(streamIn);
    ERROR_RETURN_MSG_INNER(error, "stream_id=%d check failed, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    uint32_t pos = 0xFFFFU;
    Stream *dstStm = streamIn;
    std::function<void()> const errRecycle = [&waitTask, &streamIn, &pos, &dstStm]() {
        TaskUnInitProc(waitTask);
        TaskRollBack(dstStm, pos);
        streamIn->StreamUnLock();
    };
    streamIn->StreamLock();
    error = AllocTaskInfoForCapture(&waitTask, streamIn, pos, dstStm);
    ERROR_PROC_RETURN_MSG_INNER(error, streamIn->StreamUnLock();, "Failed to alloc task, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    SaveTaskCommonInfo(waitTask, dstStm, pos);
    ScopeGuard tskErrRecycle(errRecycle);
    error = NotifyWaitTaskInit(waitTask, notifyid_, info->timeout,
                                         &cntNtfyInfo, static_cast<void *>(this), true);
    ERROR_RETURN_MSG_INNER(error, "CntNotifyWaitTask init failed, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    waitTask->stmArgPos = static_cast<DavidStream *>(dstStm)->GetArgPos();
    error = DavidSendTask(waitTask, dstStm);
    ERROR_RETURN_MSG_INNER(error, "CntNotifyWaitTask submit failed, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    tskErrRecycle.ReleaseGuard();
    streamIn->StreamUnLock();
    SET_THREAD_TASKID_AND_STREAMID(dstStm->Id_(), waitTask->taskSn);
    error = SubmitTaskPostProc(dstStm, pos);
    ERROR_RETURN_MSG_INNER(error, "recycle fail, stream_id=%d, retCode=%#x.",
        streamIn->Id_(), static_cast<uint32_t>(error));
    return RT_ERROR_NONE;
}

}  // namespace runtime
}  // namespace cce