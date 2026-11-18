/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_CNT_NOTIFY_RES_HPP
#define CCE_RUNTIME_CNT_NOTIFY_RES_HPP

#include <cstdint>
#include <atomic>

namespace cce {
namespace runtime {
class Device;

/* Stream 级计数通知资源的引用计数载体：Stream(owner) 与在途任务持引用，DavidEvent 仅存弱指针；
 * 末位 Release 负责 NotifyIdFree 并 delete this。无锁实现，Acquire/Release 仅允许已持引用者调用。 */
class CntNotifyRes {
public:
    CntNotifyRes(Device* dev, const uint32_t tsId, const uint32_t notifyId);

    void Acquire();
    void Release();
    void ReleaseOwner(); // owner（Stream）释放自身引用
    uint32_t GetNotifyId() const { return notifyId_.load(std::memory_order_acquire); }

private:
    void FreeNotifyId();                 // 由末位引用者调用
    std::atomic<uint32_t> refs_{0U};     // 引用计数
    std::atomic<bool> ownerGone_{false}; // owner(Stream) 是否已释放自身引用
    std::atomic<uint32_t> notifyId_;
    Device* const dev_;
    const uint32_t tsId_;
};
} // namespace runtime
} // namespace cce
#endif // CCE_RUNTIME_CNT_NOTIFY_RES_HPP
