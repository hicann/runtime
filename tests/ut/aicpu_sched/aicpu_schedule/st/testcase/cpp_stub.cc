/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_context.h"
#include "aicpu_pulse.h"
#include "common/aicpusd_context.h"
#include <string>
#include <map>
#include <vector>

namespace {
std::map<std::string, std::string> g_ctx;
thread_local aicpu::aicpuProfContext_t g_curProfCtx;
}

namespace aicpu {
status_t SetOpname(const std::string &opname)
{
    return AICPU_ERROR_NONE;
}

status_t InitTaskMonitorContext(uint32_t aicpuCoreCnt)
{
    return AICPU_ERROR_NONE;
}

status_t SetAicpuThreadIndex(uint32_t threadIndex)
{
    return AICPU_ERROR_NONE;
}

uint32_t GetAicpuThreadIndex()
{
    return 0;
}

status_t GetOpname(uint32_t threadIndex, std::string &opname)
{
    opname = "llt";
    return AICPU_ERROR_NONE;
}

const std::map<std::string, std::string> &GetAllThreadCtxInfo(aicpu::CtxType type, uint32_t threadIndex)
{
    return g_ctx;
}

status_t SetThreadLocalCtx(const std::string &key, const std::string &value)
{
    return AICPU_ERROR_NONE;
}

status_t GetThreadLocalCtx(const std::string &key, std::string &value)
{
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

status_t RegisterEventCallback(uint32_t eventId, uint32_t subeventId, std::function<void (void *)> func)
{
    return AICPU_ERROR_NONE;
}

status_t DoEventCallback(uint32_t eventId, uint32_t subeventId, void *param)
{
    return AICPU_ERROR_NONE;
}

status_t UnRegisterCallback(uint32_t eventId, uint32_t subeventId)
{
    return AICPU_ERROR_NONE;
}
}

typedef void (*PulseNotifyFunc)();

int32_t RegisterPulseNotifyFunc(const char *name, PulseNotifyFunc func)
{
    return 0;
}