/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_async_event.h"
#include "aicpu_context.h"
#include "aicpu_pulse.h"

namespace {
    thread_local std::map<std::string, std::string> g_threadLocalCtx;
    thread_local aicpu::aicpuProfContext_t g_curProfCtx;
}

namespace aicpu {
status_t aicpuSetContext(aicpuContext_t *ctx)
{
    return AICPU_ERROR_NONE;
}

status_t aicpuGetContext(aicpuContext_t *ctx)
{
    ctx->deviceId = 0;
    return AICPU_ERROR_NONE;
}

status_t aicpuSetProfContext(const aicpuProfContext_t &ctx)
{
    return AICPU_ERROR_NONE;
}

const aicpuProfContext_t &aicpuGetProfContext()
{
    return g_curProfCtx;
}

void DoSetThreadLocalCtx(const std::string &key, const std::string &value)
{
    g_threadLocalCtx[key] = value;
}

status_t SetThreadLocalCtx(const std::string &key, const std::string &value)
{
    if (key.empty()) {
        return AICPU_ERROR_FAILED;
    }
    try {
        DoSetThreadLocalCtx(key, value);
    } catch (std::exception &e) {
        return AICPU_ERROR_FAILED;
    }
    return AICPU_ERROR_NONE;
}


status_t GetThreadLocalCtx(const std::string &key, std::string &value)
{
    if (key.empty()) {
        return AICPU_ERROR_FAILED;
    }
    auto iter = g_threadLocalCtx.find(key);
    if (iter != g_threadLocalCtx.end()) {
        value = iter->second;
        return AICPU_ERROR_NONE;
    }
    return AICPU_ERROR_FAILED;
}

status_t SetOpname(const std::string &opname)
{
    return AICPU_ERROR_NONE;
}

status_t SetTaskAndStreamId(uint64_t taskId, uint32_t streamId)
{
    return AICPU_ERROR_NONE;
}

status_t SetAicpuRunMode(uint32_t runMode)
{
    return AICPU_ERROR_NONE;
}

void SetCustAicpuSdFlag(const bool isCustAicpuSdFlag)
{
    (void)isCustAicpuSdFlag;
}

bool IsCustAicpuSd()
{
    return false;
}

status_t GetAicpuRunMode(uint32_t &runMode)
{
    runMode = aicpu::AicpuRunMode::THREAD_MODE;
    return AICPU_ERROR_NONE;
}

AsyncEventManager::AsyncEventManager() {}

AsyncEventManager::~AsyncEventManager() {}

AsyncEventManager &AsyncEventManager::GetInstance()
{
    static AsyncEventManager asyncEventManager;
    return asyncEventManager;
}

void AsyncEventManager::Register(const NotifyFunc &notify)
{
    return;
}

void AsyncEventManager::NotifyWait(void *notifyParam, const uint32_t paramLen)
{
    return;
}

bool AsyncEventManager::RegEventCb(const uint32_t eventId, const uint32_t subEventId,
                                   const EventProcessCallBack &cb, const int32_t times)
{
    return true;
}

void AsyncEventManager::ProcessEvent(const uint32_t eventId, const uint32_t subEventId, void *param)
{
    return;
}

bool AsyncEventManager::RegOpEventCb(const uint32_t eventId, const uint32_t subEventId, const EventProcessCallBack &cb)
const {
    (void)eventId;
    (void)subEventId;
    (void)cb;
    return true;
}

void AsyncEventManager::UnregOpEventCb(const uint32_t eventId, const uint32_t subEventId) const
{
    (void)eventId;
    (void)subEventId;
}

void AsyncEventManager::ProcessOpEvent(const uint32_t eventId, const uint32_t subEventId, void * const param) const
{
    (void)eventId;
    (void)subEventId;
    (void)param;
}

uint32_t GetUniqueVfId()
{
    return 0U;
}

void SetUniqueVfId(const uint32_t uniqueVfId)
{
    (void)uniqueVfId;
}
}  // namespace aicpu

typedef void (*PulseNotifyFunc)();

int32_t RegisterPulseNotifyFunc(const char *name, PulseNotifyFunc func)
{
    return 0;
}