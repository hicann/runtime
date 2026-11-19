/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CC_STREAM_RES_MANAGE_H
#define CCE_RUNTIME_CC_STREAM_RES_MANAGE_H

#include <cstdint>
#include <mutex>

#include "task_queue/host_task_queue.h"
#include "base.hpp"

namespace cce {
namespace runtime {

class Device;

class CCStreamResManage {
public:
    CCStreamResManage() = default;
    ~CCStreamResManage();

    rtError_t Init(Device* device, uint32_t taskDescSize);

    void Destroy();

    void Reset() const;

    BarTaskQueue* BarQueue() const;

    uint64_t DeviceQueueAddr() const;

    std::mutex& ProcessMutex();

    std::mutex& MemSubmitMutex();

private:
    Device* device_{nullptr};
    BarTaskQueue* barQueue_{nullptr}; // Init 创建，Destroy 释放
    uint64_t queueDevAddr_{0U};       // 环设备侧地址（Init 时缓存，AICPU 参数用）
    std::mutex processMutex_;         // 同流任务处理大锁
    std::mutex memSubmitMutex_; // 在替换的3个Task外加一把大锁，防止三段提交被多线程交叉插入
};

} // namespace runtime
} // namespace cce

#endif
