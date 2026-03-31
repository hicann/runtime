/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "context.hpp"
#include "inner_thread_local.hpp"
#include "xpu_device.hpp"
#include "xpu_context.hpp"

namespace cce {
namespace runtime {

rtError_t Runtime::PrimaryXpuContextRelease(const uint32_t devId)
{
    UNUSED(devId);
    const std::unique_lock<std::mutex> xpuSetDevLock(XpuSetDevMutex());
    Context *ctx = GetXpuCtxt();
    COND_RETURN_WARN((ctx == nullptr), RT_ERROR_NONE, "context is null");
    if (unlikely(!ContextManage::CheckContextIsValid(ctx, true))) {
        RT_LOG(RT_LOG_ERROR, "context is deleted.");
        return RT_ERROR_NONE;
    }
    ctx->SetContextForceReset(true);
    {
        const ContextProtect cp(ctx);
        (void)ctx->TearDown();
    }
    if (ContextManage::EraseContextFromSet(ctx) != RT_ERROR_CONTEXT_NULL) {
        if (ctx->ContextOutUse() == 0ULL) {
            delete ctx;
            ctx = nullptr;
        }
    }
    xpuDevice_ = nullptr;
    xpuCtxt_ = nullptr;
    InnerThreadLocalContainer::SetCurRef(nullptr);
    InnerThreadLocalContainer::SetCurCtx(nullptr);
    return RT_ERROR_NONE;
}

void Runtime::XpuDeviceRelease(Device *dev) const
{
    COND_RETURN_VOID(dev == nullptr, "ptr device is NULL!");
    dev->SetDeviceRelease();
    (void)dev->Stop();
    DELETE_O(dev)
}

Device *Runtime::XpuDeviceRetain(const uint32_t devId) const
{
    Device *dev = nullptr;
    rtError_t error = RT_ERROR_NONE;
    dev = new (std::nothrow) XpuDevice(devId);
    if (dev == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Xpu device is null, device_id=%u.", devId);
        return nullptr;
    }

    std::function<void()> const errRecycle = [&dev]() {
        DELETE_O(dev);
    };
    ScopeGuard tskErrRecycle(errRecycle);
    error = dev->Init();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to init device, device_id=%u.", devId);
        return nullptr;
    }

    error = dev->Start();
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to start device, device_id=%u.", devId);
        return nullptr;
    }
    tskErrRecycle.ReleaseGuard();
    return dev;
}

Context *Runtime::PrimaryXpuContextRetain(const uint32_t devId)
{
    Context *ctx = nullptr;
    rtError_t err = RT_ERROR_NONE;
    Device *dev = XpuDeviceRetain(devId);
    if (dev == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Xpu device is null, device_id=%u.", devId);
        return nullptr;
    }
    ctx = new (std::nothrow) XpuContext(dev, true);
    if (ctx == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Xpu ctx is null, device_id=%u.", devId);
        (void)dev->Stop();
        DELETE_O(dev);
        return nullptr;
    }
    err = ctx->Setup();
    if (err != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to setup context, device_id=%u.", devId);
        (void)ctx->TearDown();
        DELETE_O(ctx);
        return nullptr;
    }
    ContextManage::InsertContext(ctx);
    xpuDevice_ = dev;
    xpuCtxt_ = ctx;
    return ctx;
}

}  // namespace runtime
}  // namespace cce
