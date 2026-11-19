/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_RES_MANAGE_H
#define CCE_RUNTIME_CC_RES_MANAGE_H

#include <cstdint>
#include <memory>
#include <mutex>
#include <vector>
#include "base.hpp"
#include "utils/thread_pool.h"
#include "crypto/cc_crypto.h"
#include "crypto/cc_crypto_plugin.h"
#include "cc_task_queue.h"

namespace cce {
namespace runtime {

class Device;
class Stream;
class CCWorker;
class CCStreamResManage;

class CCResManage : public NoCopy {
public:
    explicit CCResManage(Device* device);
    ~CCResManage() override;

    rtError_t InitCcResource();
    void DestroyCcResource();

    rtError_t GetOrCreateStreamResource(Stream* stm, CCStreamResManage*& resource);
    void DestroyStreamResource(Stream* stm);
    rtError_t SubmitTask(const CCMemcpyTask& task);
    CCCryptoPlugin* Plugin() const { return plugin_.get(); }

private:
    rtError_t LoadKeyToAicpu();
    rtError_t InitWorkerPool(uint32_t workerCount, uint32_t sliceSize);
    rtError_t CreateWorker();
    void DestroyWorkerPool();
    void DestroyWorkerPoolLocked();

    uint32_t deviceId_;
    Device* device_{nullptr};
    CCrypto crypto_;                         // 公共密钥/加解密原语/密钥流接口（各加密模式共用）
    std::unique_ptr<CCCryptoPlugin> plugin_; // per-device 算法插件（路由元数据 + 分片回调钩子）
    std::vector<std::unique_ptr<CCWorker>> workers_; // 按需创建，最多 6 个 worker
    std::unique_ptr<CCMemcpyTaskQueue> taskQueue_;   // 1 个共享队列
    ThreadPool threadPool_;                          // 统一持有 worker 线程，执行 CCWorker::Run routine
    uint32_t maxWorkerCount_{0U};
    uint32_t workerSliceSize_{0U};
    std::mutex workerPoolMutex_;
    std::mutex streamResourceMutex_;
};
} // namespace runtime
} // namespace cce

#endif // CCE_RUNTIME_CC_RES_MANAGE_H
