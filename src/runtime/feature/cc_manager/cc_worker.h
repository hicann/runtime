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
#include "task_queue/host_task_queue.h"
#include "base.hpp"
#include "cc_task_queue.h"

namespace cce {
namespace runtime {

class Device;
class Stream;
class CCStreamResManage;
class CCCryptoPlugin;

class CCWorker {
public:
    CCWorker() = default;
    ~CCWorker();

    rtError_t Init(
        uint32_t workerId, uint32_t sliceSize, CCMemcpyTaskQueue* taskQueue, Device* device, CCCryptoPlugin* plugin);
    // 调用方须先保证所属线程池中的 Run 已退出。
    void Destroy();

    void* GetHostCryptoBuf() const { return hostCryptoBuf_; }
    void* DeviceBuffer(const uint32_t sliceIdx) const;

    void Run();

private:
    rtError_t SetupTask(
        CCMemcpyTask& task, std::shared_ptr<Stream>& stream, CCStreamResManage*& resource, uint32_t& sliceNum);
    rtError_t ProcessSlices(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceNum, void* pluginTaskCtx) const;
    rtError_t RetireDoneH2DSlices(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t totalSlices, void* pluginTaskCtx,
        uint32_t& doneIdx, bool waitAll) const;
    rtError_t ProcessTask(CCMemcpyTask& task);
    rtError_t ProcessTaskImpl(CCMemcpyTask& task);
    void FailTask(const CCMemcpyTask& task, const rtError_t ret) const;
    rtError_t ProcessH2DSlice(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize,
        void* pluginTaskCtx = nullptr) const;
    rtError_t PublishD2HSlice(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize,
        void* pluginTaskCtx = nullptr) const;
    rtError_t WaitD2HSliceDone(const uint32_t streamId, BarTaskQueue* const barQueue, const uint32_t sliceIdx) const;
    rtError_t ProcessD2HSlice(
        CCMemcpyTask& task, CCStreamResManage* const resource, uint32_t sliceIdx, size_t offset, size_t sliceSize,
        uint32_t totalSlices, void* pluginTaskCtx = nullptr) const;
    rtError_t WaitH2DConsumed(const uint32_t streamId, BarTaskQueue* const barQueue, const uint32_t totalSlices) const;
    bool ShouldWorkerExit(const uint32_t streamId) const;

    uint32_t workerId_{0};
    uint32_t maxSliceSize_{0};
    uint64_t deadlineMs_{0};
    std::atomic<bool> cancelled_{false};
    Device* device_{nullptr};
    CCCryptoPlugin* plugin_{nullptr}; // per-device 算法插件（Init 时绑定，不持有；加解密原语由插件持有）
    void* hostCryptoBuf_{nullptr};     // Host buffer (for HostDmaMap/HostRegister and encrypt/decrypt)
    bool hostCryptoRegistered_{false}; // hostCryptoBuf 已登记（HostDmaMap 或 HostRegister 回退）
    void* deviceBuffers_[CC_BUFFER_SLOT_NUM]{nullptr, nullptr};

    CCMemcpyTaskQueue* taskQueue_{nullptr};
};

} // namespace runtime
} // namespace cce

#endif
