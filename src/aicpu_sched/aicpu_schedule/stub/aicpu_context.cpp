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

#include <vector>
#include <memory>
#include <mutex>
#include <thread>

#include "aicpusd_status.h"

namespace {
    // current thread context
    thread_local aicpu::aicpuContext_t g_curCtx;
    // current thread prof context
    thread_local aicpu::aicpuProfContext_t g_curProfCtx;
    // task moniter context
    thread_local uint32_t g_threadIndex = UINT32_MAX;
    // aicpu run mode
    uint32_t g_runMode = aicpu::AicpuRunMode::THREAD_MODE;
    // cpu mode
    bool g_cpuMode = false;
    bool g_isCustAicpuSd = false;
}

namespace aicpu {
__attribute__((visibility("default"))) status_t aicpuSetContext(aicpuContext_t *ctx)
{
    aicpusd_info("Aicpu set ctx in stub func[%s].", __func__);
    g_curCtx = *ctx;
    return AICPU_ERROR_NONE;
}

__attribute__((visibility("default"))) status_t aicpuGetContext(aicpuContext_t *ctx)
{
    aicpusd_info("Aicpu get ctx in stub func[%s].", __func__);
    *ctx = g_curCtx;
    return AICPU_ERROR_NONE;
}

status_t aicpuSetProfContext(const aicpuProfContext_t &ctx)
{
    aicpusd_info("Aicpu set prof ctx in stub func[%s].", __func__);
    g_curProfCtx = ctx;
    return AICPU_ERROR_NONE;
}

const aicpuProfContext_t &aicpuGetProfContext()
{
    aicpusd_info("Aicpu get prof ctx in stub func[%s].", __func__);
    return g_curProfCtx;
}

status_t InitTaskMonitorContext(uint32_t aicpuCoreCnt)
{
    (void)aicpuCoreCnt;
    aicpusd_info("Init task monitor in stub func[%s].", __func__);
    return AICPU_ERROR_NONE;
}

status_t SetAicpuThreadIndex(uint32_t threadIndex)
{
    aicpusd_info("Aicpu set thread index in stub func[%s].", __func__);
    g_threadIndex = threadIndex;
    return AICPU_ERROR_NONE;
}

uint32_t GetAicpuThreadIndex()
{
    aicpusd_info("Aicpu get thread index in stub func[%s].", __func__);
    return g_threadIndex;
}


status_t SetOpname(const std::string &opname)
{
    (void)opname;
    aicpusd_info("Set opname in stub func[%s].", __func__);
    return AICPU_ERROR_NONE;
}


status_t GetOpname(uint32_t threadIndex, std::string &opname)
{
    (void)threadIndex;
    (void)opname;
    aicpusd_info("Get opname in stub func[%s].", __func__);
    return AICPU_ERROR_NONE;
}

status_t SetTaskAndStreamId(uint64_t taskId, uint32_t streamId)
{
    (void)taskId;
    (void)streamId;
    aicpusd_info("Set task and streamId in stub func[%s].", __func__);
    return AICPU_ERROR_NONE;
}

status_t SetAicpuRunMode(uint32_t runMode)
{
    aicpusd_info("Set aicpu run mode in stub func[%s].", __func__);
    g_runMode = runMode;
    return AICPU_ERROR_NONE;
}

status_t GetAicpuRunMode(uint32_t &runMode)
{
    aicpusd_info("Get aicpu run mode in stub func[%s].", __func__);
    runMode = g_runMode;
    return AICPU_ERROR_NONE;
}

status_t SetThreadLocalCtx(const std::string &key, const std::string &value)
{
    (void)key;
    (void)value;
    aicpusd_info("Set thread local ctx in stub func[%s].", __func__);
    return AICPU_ERROR_NONE;
}

status_t GetThreadLocalCtx(const std::string &key, std::string &value)
{
    (void)key;
    (void)value;
    aicpusd_info("Get thread local ctx in stub func[%s].", __func__);
    return AICPU_ERROR_NONE;
}

uint32_t GetUniqueVfId()
{
    aicpusd_info("Get unique vf id in stub func[%s].", __func__);
    return 0U;
}

void SetUniqueVfId(const uint32_t uniqueVfId)
{
    aicpusd_info("Set unique vfid in stub func[%s].", __func__);
    (void)uniqueVfId;
}

void SetCustAicpuSdFlag(const bool isCustAicpuSdFlag)
{
    aicpusd_info("Set cust aicpusd flag in stub func[%s].", __func__);
    g_isCustAicpuSd = isCustAicpuSdFlag;
}

bool IsCustAicpuSd()
{
    aicpusd_info("Get cust aicpusd flag in stub func[%s].", __func__);
    return g_isCustAicpuSd;
}
}  // namespace aicpu

namespace AicpuSchedule {
void SetCpuMode(bool cpuMode)
{
    aicpusd_info("Set cpu mode in stub func[%s].", __func__);
    g_cpuMode = cpuMode;
}

bool GetCpuMode()
{
    aicpusd_info("Get cpu mode in stub func[%s].", __func__);
    return g_cpuMode;
}
} // namespace AicpuSchedule

void ClearPulseNotifyFunc()
{
    aicpusd_info("call ClearPulseNotifyFunc stub func[%s].", __func__);
}
