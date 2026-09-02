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
#include "task_info.hpp"

namespace cce {
namespace runtime {

void Stream::SingleStreamTerminateCapture() { SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_INVALIDATED); }

rtError_t Stream::AllocCascadeCaptureStream(Stream*& newCaptureStream, const Stream* const curCaptureStream)
{
    UNUSED(newCaptureStream);
    UNUSED(curCaptureStream);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void Stream::UpdateCascadeCaptureStreamInfo(Stream* newCaptureStream, Stream* curCaptureStream)
{
    UNUSED(newCaptureStream);
    UNUSED(curCaptureStream);
}

rtError_t Stream::AllocCaptureTaskWithLock(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo** task)
{
    UNUSED(taskType);
    UNUSED(sqeNum);
    UNUSED(task);
    return RT_ERROR_STREAM_CAPTURE_EXIT;
}

rtError_t Stream::AllocCaptureTaskWithoutLock(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo** task)
{
    UNUSED(taskType);
    UNUSED(sqeNum);
    UNUSED(task);
    return RT_ERROR_STREAM_CAPTURE_EXIT;
}

rtError_t Stream::AllocCaptureTask(tsTaskType_t taskType, uint32_t sqeNum, TaskInfo** task, bool isNeedLock)
{
    UNUSED(taskType);
    UNUSED(sqeNum);
    UNUSED(task);
    UNUSED(isNeedLock);
    return RT_ERROR_STREAM_CAPTURE_EXIT;
}

void Stream::EnterCapture(const Stream* const captureStream)
{
    UNUSED(captureStream);
    std::unique_lock<std::mutex> lk(captureLock_);
    UpdateCaptureStream(captureStream);
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
}

void Stream::ResetCaptureInfo()
{
    std::unique_lock<std::mutex> lk(captureLock_);
    UpdateCaptureStream(nullptr);
    SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_NONE);
}

void Stream::ExitCapture() { ResetCaptureInfo(); }

} // namespace runtime
} // namespace cce