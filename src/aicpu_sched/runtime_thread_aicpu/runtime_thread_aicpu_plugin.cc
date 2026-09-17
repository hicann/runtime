/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime_thread_aicpu_service.hpp"

#include <mutex>
#include <new>

#include "aicpu_sched/aicpu_schedule/common/aicpusd_status.h"

namespace cce {
namespace runtime_thread_aicpu {
namespace {

std::mutex g_serviceMutex;
RuntimeThreadAicpuService* g_pluginService = nullptr;

RuntimeThreadAicpuStatus PrepareKernel(
    const RuntimeThreadAicpuKernelRequest* const request, RuntimeThreadAicpuPreparedKernel* const preparedKernel)
{
    if ((g_pluginService == nullptr) || (request == nullptr) || (preparedKernel == nullptr)) {
        aicpusd_err(
            "Prepare RuntimeThreadAicpu kernel failed because plugin input is invalid, service_valid=%u, "
            "request_valid=%u, prepared_kernel_valid=%u.",
            static_cast<uint32_t>(g_pluginService != nullptr), static_cast<uint32_t>(request != nullptr),
            static_cast<uint32_t>(preparedKernel != nullptr));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }
    return g_pluginService->PrepareKernel(*request, *preparedKernel);
}

void ReleasePreparedKernel(const uint64_t taskCookie)
{
    if (g_pluginService != nullptr) {
        g_pluginService->ReleasePreparedKernel(taskCookie);
    }
}

void StreamDestroyed(void* const streamHandle)
{
    if (g_pluginService != nullptr) {
        g_pluginService->StreamDestroyed(streamHandle);
    }
}

const RuntimeThreadAicpuPluginApi PLUGIN_API = {
    .structSize = sizeof(RuntimeThreadAicpuPluginApi),
    .prepareKernel = &PrepareKernel,
    .releasePreparedKernel = &ReleasePreparedKernel,
    .streamDestroyed = &StreamDestroyed,
};

} // namespace
} // namespace runtime_thread_aicpu
} // namespace cce

extern "C" RuntimeThreadAicpuStatus RuntimeThreadAicpuGetPluginApi(
    const RuntimeThreadAicpuRuntimeHooks* const hooks, const RuntimeThreadAicpuPluginApi** const pluginApi)
{
    if ((hooks == nullptr) || (pluginApi == nullptr) || (hooks->structSize < sizeof(RuntimeThreadAicpuRuntimeHooks))) {
        aicpusd_err(
            "Get RuntimeThreadAicpu plugin API failed, hooks_valid=%u, plugin_api_valid=%u, hooks_size=%u, "
            "expected_size=%zu.",
            static_cast<uint32_t>(hooks != nullptr), static_cast<uint32_t>(pluginApi != nullptr),
            (hooks == nullptr) ? 0U : hooks->structSize, sizeof(RuntimeThreadAicpuRuntimeHooks));
        return RuntimeThreadAicpuStatus::INVALID_PARAM;
    }

    std::lock_guard<std::mutex> lock(cce::runtime_thread_aicpu::g_serviceMutex);
    if (cce::runtime_thread_aicpu::g_pluginService == nullptr) {
        cce::runtime_thread_aicpu::g_pluginService =
            new (std::nothrow) cce::runtime_thread_aicpu::RuntimeThreadAicpuService(*hooks);
        if (cce::runtime_thread_aicpu::g_pluginService == nullptr) {
            aicpusd_err("Create RuntimeThreadAicpu service failed because memory allocation failed.");
            return RuntimeThreadAicpuStatus::NO_MEMORY;
        }
        cce::runtime_thread_aicpu::SetRuntimeThreadAicpuService(cce::runtime_thread_aicpu::g_pluginService);
    }
    *pluginApi = &cce::runtime_thread_aicpu::PLUGIN_API;
    return RuntimeThreadAicpuStatus::OK;
}
