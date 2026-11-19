/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cc_stream_res_manage.h"

#include "cc_task_queue.h"
#include "common/error_message_manage.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

CCStreamResManage::~CCStreamResManage() { Destroy(); }

rtError_t CCStreamResManage::Init(Device* device, uint32_t taskDescSize)
{
    COND_RETURN_ERROR(device == nullptr, RT_ERROR_DEVICE_NULL, "CC stream resource device is null.");
    device_ = device;

    rtError_t ret = CreateBarTaskQueue(&barQueue_, device_, CC_SLICE_DESC_SLOT_NUM, taskDescSize);
    COND_RETURN_ERROR_MSG_INNER(
        ret != RT_ERROR_NONE, ret, "CC stream resource create bar task queue failed, ret=%#x.", ret);

    ret = GetBarTaskQueueDevAddr(barQueue_, &queueDevAddr_);
    if (ret != RT_ERROR_NONE) {
        (void)FreeBarTaskQueue(barQueue_);
        barQueue_ = nullptr;
        return ret;
    }
    return RT_ERROR_NONE;
}

void CCStreamResManage::Destroy()
{
    if (barQueue_ != nullptr) {
        (void)FreeBarTaskQueue(barQueue_);
        barQueue_ = nullptr;
    }
    queueDevAddr_ = 0U;
    device_ = nullptr;
}

void CCStreamResManage::Reset() const
{
    if (barQueue_ != nullptr) {
        (void)ResetBarTaskQueue(barQueue_);
    }
}

BarTaskQueue* CCStreamResManage::BarQueue() const { return barQueue_; }

uint64_t CCStreamResManage::DeviceQueueAddr() const { return queueDevAddr_; }

std::mutex& CCStreamResManage::ProcessMutex() { return processMutex_; }

std::mutex& CCStreamResManage::MemSubmitMutex() { return memSubmitMutex_; }

} // namespace runtime
} // namespace cce
