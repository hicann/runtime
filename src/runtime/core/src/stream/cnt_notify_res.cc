/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cnt_notify_res.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {
CntNotifyRes::CntNotifyRes(Device* dev, const uint32_t tsId, const uint32_t notifyId)
    : notifyId_(notifyId), dev_(dev), tsId_(tsId)
{}

void CntNotifyRes::Acquire()
{
    // 调用者已持引用（refs_ >= 1），不会被并发 Release 回收
    (void)refs_.fetch_add(1U, std::memory_order_acq_rel);
}

void CntNotifyRes::Release()
{
    // 末位引用者（观察到 1→0）负责释放驱动资源并回收对象
    const uint32_t refsBefore = refs_.fetch_sub(1U, std::memory_order_acq_rel);
    if (refsBefore != 1U) {
        if (refsBefore == 0U) { // 迟到 Release（误用防御）：回补计数防下溢
            (void)refs_.fetch_add(1U, std::memory_order_relaxed);
        }
        return;
    }

    FreeNotifyId(); // 驱动资源只释放一次
    if (ownerGone_.load(std::memory_order_acquire)) {
        delete this;
    }
}

void CntNotifyRes::ReleaseOwner()
{
    ownerGone_.store(true, std::memory_order_release);
    Release();
}

void CntNotifyRes::FreeNotifyId()
{
    const uint32_t notifyId = notifyId_.load(std::memory_order_acquire);
    const rtError_t error = dev_->Driver_()->NotifyIdFree(static_cast<int32_t>(dev_->Id_()), notifyId, tsId_, 0U, true);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(
            RT_LOG_ERROR, "NotifyIdFree failed, notify_id=%u, retCode=%#x.", notifyId, static_cast<uint32_t>(error));
    }
}
} // namespace runtime
} // namespace cce
