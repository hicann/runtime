/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "ipc_event.hpp"
namespace cce {
namespace runtime {
IpcEvent::IpcEvent(Device *device, uint64_t eventFlag, Context *ctx)
    : Event(device, eventFlag, ctx, false ,true), device_(device), eventFlag_(eventFlag), context_(ctx),
      ipcHandlePa_(nullptr), ipcHandleVa_(nullptr), currentDeviceMem_(nullptr),currentHostMem_(nullptr),
      deviceMemPa_(nullptr), hostMemPa_(nullptr), ipcHandle_(0U), deviceMemSize_(0U),
      totalTaskCnt_(0U), isNeedDestroy_(false), mapFlag_(0U), eventStatus_(INIT)
{}

IpcEvent::~IpcEvent() noexcept
{
}

rtError_t IpcEvent::Setup()
{
    return RT_ERROR_NONE;
}

rtError_t IpcEvent::IpcEventRecord(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_NONE;
}

rtError_t IpcEvent::IpcEventWait(Stream * const stm)
{
    UNUSED(stm);
    return RT_ERROR_NONE;
}

rtError_t IpcEvent::IpcEventQuery(rtEventStatus_t * const status)
{
    UNUSED(status);
    return RT_ERROR_NONE;
}

rtError_t IpcEvent::IpcEventSync(int32_t timeout)
{
    UNUSED(timeout);
    return RT_ERROR_NONE;
}

bool IpcEvent::TryFreeEventIdAndCheckCanBeDelete(const int32_t id, bool isNeedDestroy)
{
    UNUSED(id);
    UNUSED(isNeedDestroy);
    return true;
}

rtError_t IpcEvent::ReleaseDrvResource()
{
    return RT_ERROR_NONE;
}
} 
}