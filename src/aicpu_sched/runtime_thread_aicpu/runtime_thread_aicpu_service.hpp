/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef RUNTIME_THREAD_AICPU_SERVICE_HPP
#define RUNTIME_THREAD_AICPU_SERVICE_HPP

#include <atomic>
#include <memory>
#include <mutex>
#include <string>
#include <thread>
#include <unordered_map>
#include <vector>

#include "aicpu_sched/runtime_thread_aicpu_plugin.h"
#include "runtime_thread_aicpu_so_manager.hpp"

namespace cce {
namespace runtime_thread_aicpu {

class RuntimeThreadAicpuService final {
public:
    explicit RuntimeThreadAicpuService(const RuntimeThreadAicpuRuntimeHooks& hooks);

    RuntimeThreadAicpuStatus PrepareKernel(
        const RuntimeThreadAicpuKernelRequest& request, RuntimeThreadAicpuPreparedKernel& preparedKernel);
    void ReleasePreparedKernel(uint64_t taskCookie);
    void StreamDestroyed(void* streamHandle);
    static uint32_t ExecutePreparedKernelEntry(void* cookieData);

private:
    struct KernelContext {
        std::string soName;
        std::string functionName;
        std::string opType;
        std::vector<uint8_t> args;
        uint64_t cpuParamHeadOffset = 0U;
        uint32_t blockDim = 0U;
        uint32_t deviceId = 0U;
        uint32_t streamId = 0U;
        uint32_t taskId = 0U;
    };

    struct EventEntry {
        void* eventHandle = nullptr;
        uint32_t eventId = 0U;
        uint32_t streamId = 0U;
    };

    RuntimeThreadAicpuStatus EnsureStarted(const RuntimeThreadAicpuKernelRequest& request);
    RuntimeThreadAicpuStatus AllocateCallbackChannel();
    void ReleaseCallbackChannel();
    RuntimeThreadAicpuStatus GetOrCreateEvent(void* streamHandle, uint32_t streamId, EventEntry& event);
    RuntimeThreadAicpuStatus CreateKernelContext(const RuntimeThreadAicpuKernelRequest& request, uint64_t& taskCookie);
    RuntimeThreadAicpuStatus ResolveKernelNames(
        const RuntimeThreadAicpuKernelRequest& request, KernelContext& context) const;
    bool SetReportedTaskId(uint64_t taskCookie, uint32_t taskId);
    uint32_t ExecutePreparedKernel(uint64_t taskCookie);
    uint32_t ExecuteKernel(KernelContext& context);
    void WorkerLoop();
    bool ProcessReports();
    uint32_t ProcessOneReport(const void* reportAddress);
    RuntimeThreadAicpuStatus FinishReport(const void* reportAddress, uint32_t executeResult);

    RuntimeThreadAicpuRuntimeHooks hooks_;
    std::mutex startMutex_;
    std::mutex resourceMutex_;
    std::mutex taskMutex_;
    std::thread worker_;
    std::atomic<bool> failed_{false};
    std::atomic<uint64_t> nextTaskCookie_{1U};
    bool started_ = false;
    uint32_t deviceId_ = 0U;
    uint32_t tsId_ = 0U;
    uint32_t groupId_ = 0U;
    uint32_t callbackSqId_ = 0U;
    uint32_t callbackCqId_ = 0U;
    std::unordered_map<void*, EventEntry> events_;
    std::unordered_map<uint64_t, std::unique_ptr<KernelContext>> kernelContexts_;
    SoManager soManager_;
};

void SetRuntimeThreadAicpuService(RuntimeThreadAicpuService* service);

} // namespace runtime_thread_aicpu
} // namespace cce

#endif
