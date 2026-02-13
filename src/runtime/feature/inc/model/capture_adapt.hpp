/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_CAPTURE_ADAPT_HPP__
#define __CCE_RUNTIME_CAPTURE_ADAPT_HPP__
#include "runtime/base.h"
#include "device.hpp"
#include "event.hpp"
#include "stream.hpp"
namespace cce {
namespace runtime {
struct CaptureCntNotify {
    int32_t eventId;
    uint32_t cntValue;
};

bool StreamFlagIsSupportCapture(uint32_t flag);
uint32_t GetCaptureStreamFlag();
rtError_t GetCaptureEventFromTask(const Device * const dev, uint32_t streamId, uint32_t pos, Event *&eventPtr, CaptureCntNotify &cntInfo);
rtError_t ResetCaptureEventsProc(const CaptureModel * const captureModel, Stream * const stm);
TaskInfo* GetStreamTaskInfo(const Device * const dev, uint16_t streamId, uint16_t pos);
rtError_t SendNopTask(const Context * const curCtx, Stream * const stm);
bool TaskTypeIsSupportTaskGroup(const TaskInfo * const task);

}  // namespace runtime
}  // namespace cce
#endif