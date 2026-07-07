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
#include "cond_c.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "capture_model.hpp"

namespace cce {
namespace runtime {

void Stream::SingleStreamTerminateCapture()
{
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_INVALIDATED);
    Stream *curCaptureStream = GetCaptureStream();
    if (curCaptureStream != nullptr) {
        CaptureModel *captureModel = static_cast<CaptureModel *>(curCaptureStream->Model_());
        if (captureModel != nullptr) {
            captureModel->TerminateCapture();
        }
    }
}

rtError_t Stream::AllocCascadeCaptureStream(Stream *&newCaptureStream, const Stream * const curCaptureStream)
{
    Context * const ctx = Context_();
    const rtError_t error = ctx->AllocCascadeCaptureStream(this, curCaptureStream->Model_(),
                                                     &newCaptureStream);
    if ((error != RT_ERROR_NONE) || (newCaptureStream == nullptr)) {
        SingleStreamTerminateCapture();
        RT_LOG(RT_LOG_ERROR, "alloc capture stream failed, device_id=%u, original stream_id=%d.",
            device_->Id_(), Id_());
        return error;
    }
    if (curCaptureStream->Model_() != nullptr) {
        CaptureModel *captureModel = static_cast<CaptureModel *>(curCaptureStream->Model_());
        auto &addStreamMap = captureModel->GetAddStreamMap();
        auto it = addStreamMap.find(this);
        if (it != addStreamMap.end()) {
            captureModel->SetAddStreamMap(this, newCaptureStream);
        }
    }
    return RT_ERROR_NONE;
}

void Stream::UpdateCascadeCaptureStreamInfo(Stream *newCaptureStream, Stream *curCaptureStream)
{        
    curCaptureStream->CancelLastLevelCaptureStream();
    newCaptureStream->MarkOrigCaptureStream(curCaptureStream->IsOrigCaptureStream());
    newCaptureStream->UpdateCurrentTaskGroup(curCaptureStream->GetCurrentTaskGroup());
    newCaptureStream->SetParentCaptureStream(curCaptureStream);
    curCaptureStream->ResetTaskGroup();
    CaptureModel *captureModel = static_cast<CaptureModel *>(curCaptureStream->Model_());
    if (captureModel != nullptr) {
        captureModel->ReplaceTaskGroupStreamId(
            static_cast<uint16_t>(curCaptureStream->Id_()),
            static_cast<uint16_t>(newCaptureStream->Id_()));
        captureModel->InsertSingleOperStmIdAndCaptureStmId(Id_(), newCaptureStream->Id_());
    }
    UpdateCaptureStream(newCaptureStream);
}

rtError_t Stream::AllocCaptureTaskWithLock(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo **task)
{
    std::unique_lock<std::mutex> lk(captureLock_);
    return AllocCaptureTaskWithoutLock(taskType, sqeNum, task);
}

rtError_t Stream::AllocCaptureTaskWithoutLock(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo **task)
{
    Stream *curCaptureStream = GetCaptureStream();
    if (curCaptureStream == nullptr) {
        /* stm exit capture mode */
        return RT_ERROR_STREAM_CAPTURE_EXIT;
    }

    COND_PROC_RETURN_ERROR(IsTaskGroupBreak(), RT_ERROR_STREAM_TASKGRP_INTR,
        SetTaskGroupErrCode(RT_ERROR_STREAM_TASKGRP_INTR), "the task group interrupted.");

    if ((curCaptureStream->GetCaptureSqeNum() + CAPTURE_TASK_RESERVED_NUM +
         device_->GetDevProperties().expandStreamRsvTaskNum) >=
         curCaptureStream->GetSqDepth()) {
        Stream *newCaptureStream = nullptr;
        Context * const ctx = Context_();
        if (ctx == nullptr) {
            SingleStreamTerminateCapture();
            RT_LOG(RT_LOG_ERROR, "context is null, device_id=%u, original stream_id=%d.",
                device_->Id_(), Id_());
            return RT_ERROR_CONTEXT_NULL;
        }
        rtError_t error = AllocCascadeCaptureStream(newCaptureStream, curCaptureStream);
        COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);
        error = CondStreamActive(newCaptureStream, curCaptureStream);
        if (error != RT_ERROR_NONE) {
            ctx->FreeCascadeCaptureStream(newCaptureStream);
            SingleStreamTerminateCapture();
            RT_LOG(RT_LOG_ERROR, "stream active failed, device_id=%u, original stream_id=%d.", device_->Id_(), Id_());
            return error;
        }
        UpdateCascadeCaptureStreamInfo(newCaptureStream, curCaptureStream);
        curCaptureStream = newCaptureStream;
    }
    rtError_t errCode = RT_ERROR_TASK_NEW;
    if (curCaptureStream->taskResMang_ == nullptr) {
        *task = device_->GetTaskFactory()->Alloc(curCaptureStream, taskType, errCode);
    }
    if (*task != nullptr) {
        curCaptureStream->AddCaptureSqeNum(sqeNum);
        (*task)->stream = curCaptureStream;
        Runtime::Instance()->AllocTaskSn((*task)->taskSn); // 只有A5用了这个字段，其他形态的分配了不用
    } else {
        SingleStreamTerminateCapture();
        return errCode;
    }

    RT_LOG(RT_LOG_INFO,
        "Alloc task in capture stream successfully, device id=%u, origin stream_id=%d, capture stream_id=%d, "
        "task sequence id=%u.", device_->Id_(), Id_(), curCaptureStream->Id_(), (*task)->modelSeqId);
    return RT_ERROR_NONE;
}

rtError_t Stream::AllocCaptureTask(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo **task, bool isNeedLock)
{
    if (isNeedLock) {
        return AllocCaptureTaskWithLock(taskType, sqeNum, task);
    } else {
        return AllocCaptureTaskWithoutLock(taskType, sqeNum, task);
    }
}

void Stream::EnterCapture(const Stream * const captureStream)
{
    /* enter capture status */
    CaptureModel *captureMdl = RtPtrToPtr<CaptureModel *>(captureStream->Model_());
    if (captureMdl != nullptr) {
        captureMdl->EnterCaptureNotify(Id_(), captureStream->Id_());
    }

    std::unique_lock<std::mutex> lk(captureLock_);
    UpdateCaptureStream(captureStream);
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);

    if (captureStream->IsOrigCaptureStream()) {
        captureMdl->SetModelCacheOpInfoSwitch(GetStreamCacheOpInfoOriginSwitch());
    } else {
        SetStreamCacheOpInfoSwitch(captureMdl->GetModelCacheOpInfoSwitch());
    }

    return;
}

void Stream::ResetCaptureInfo()
{
    /* exit capture status */
    std::unique_lock<std::mutex> lk(captureLock_);
    UpdateCaptureStream(nullptr);
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);

    return;
}

void Stream::ExitCapture()
{
    /* exit capture status */
    Stream *captureStream = GetCaptureStream();
    if (captureStream != nullptr) {
        CaptureModel *captureMdl = dynamic_cast<CaptureModel *>(captureStream->Model_());
        if (captureMdl != nullptr) {
            captureMdl->ExitCaptureNotify();
            captureMdl->SetModelCacheOpInfoSwitch(0);
        }
    }

    ResetCaptureInfo();
    return;
}


} // namespace runtime
} // namespace cce
