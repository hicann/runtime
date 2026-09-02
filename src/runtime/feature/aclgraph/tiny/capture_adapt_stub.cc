/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "capture_adapt.hpp"
#include "event.hpp"
#include "capture_model.hpp"

namespace cce {
namespace runtime {

bool StreamFlagIsSupportCapture(uint32_t flag)
{
    UNUSED(flag);
    return true;
}

uint32_t GetCaptureStreamFlag() { return RT_STREAM_DEFAULT; }

rtError_t GetCaptureEventFromTask(
    const Device* const dev, uint32_t streamId, uint32_t pos, Event*& eventPtr, CaptureCntNotify& cntInfo)
{
    UNUSED(dev);
    UNUSED(streamId);
    UNUSED(pos);
    UNUSED(eventPtr);
    UNUSED(cntInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ResetCaptureEventsProc(const CaptureModel* const captureModel, Stream* const stm)
{
    UNUSED(captureModel);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SendNopTask(const Context* const curCtx, Stream* const stm)
{
    UNUSED(curCtx);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

bool TaskTypeIsSupportTaskGroup(const TaskInfo* const task)
{
    UNUSED(task);
    return false;
}

TaskInfo* GetStreamTaskInfo(const Device* const dev, uint16_t streamId, uint16_t pos)
{
    UNUSED(dev);
    UNUSED(streamId);
    UNUSED(pos);
    return nullptr;
}

} // namespace runtime
} // namespace cce