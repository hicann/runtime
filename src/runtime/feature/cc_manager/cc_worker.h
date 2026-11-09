/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_WORKER_H
#define CCE_RUNTIME_CC_WORKER_H

#include <atomic>
#include <cstdint>
#include <memory>
#include "base.hpp"
#include "cc_task_queue.h"
#include "osal.hpp"

namespace cce {
namespace runtime {

class Device;
class Stream;
class CCStreamResManage;
class CCrypto;

class CCWorker : public ThreadRunnable {
public:
    CCWorker() = default;
    ~CCWorker() override;

    rtError_t Init(
        uint32_t workerId, uint32_t sliceSize, CCMemcpyTaskQueue* taskQueue, Device* device, CCrypto* crypto);
    void Destroy();

    void* GetHostCryptoBuf() const { return hostCryptoBuf_; }
    void* DeviceBuffer(const uint32_t sliceIdx) const;

    void Run(const void* param) override;

private:
    void WorkerLoop();
    rtError_t SetupTask(
        CCMemcpyTask& task, std::shared_ptr<Stream>& stream, CCStreamResManage*& resource, uint32_t& sliceNum);
    rtError_t ProcessSlices(CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceNum);
    rtError_t ProcessTask(CCMemcpyTask& task);
    rtError_t ProcessH2DSlice(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize);
    rtError_t PublishD2HSlice(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize);
    rtError_t WaitD2HSliceCompleted(const uint32_t streamId, const CCSliceQueue* sliceQueue, uint8_t expectedTail);
    rtError_t ProcessD2HSlice(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize);
    rtError_t WaitH2DConsumed(const uint32_t streamId, CCSliceQueue* sliceQueue);
    bool ShouldWorkerExit(const uint32_t streamId);

    uint32_t workerId_{0};
    uint32_t maxSliceSize_{0};
    uint64_t deadlineMs_{0};
    std::atomic<bool> cancelled_{false};
    Device* device_{nullptr};
    Thread* thread_{nullptr};
    CCrypto* crypto_{nullptr};
    void* hostCryptoBuf_{nullptr}; // Host buffer (for HostDmaMap and encrypt/decrypt)
    bool hostCryptoDmaMapped_{false};
    void* deviceBuffers_[CC_BUFFER_SLOT_NUM]{nullptr, nullptr};

    CCMemcpyTaskQueue* taskQueue_{nullptr};
};

} // namespace runtime
} // namespace cce

#endif
