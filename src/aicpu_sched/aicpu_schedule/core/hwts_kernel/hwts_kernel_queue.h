/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HWTS_KERNEL_QUEUE_H
#define HWTS_KERNEL_QUEUE_H

#include "hwts_kernel.h"


namespace AicpuSchedule {
class CreateQueueTsKernel : public HwTsKernelHandler {
public:
    CreateQueueTsKernel() = default;
    ~CreateQueueTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;

private:
    int32_t CreateGrp() const;
    int32_t SubscribeEvent(const uint32_t deviceId, const uint32_t queueId) const;
    int32_t Resubscribe(const uint32_t deviceId, const uint32_t queueId) const;
    int32_t ResubscribeF2NF(const uint32_t deviceId, const uint32_t queueId) const;
    int32_t DoQueueSubscrible(const QueueAttr &queAttr, uint32_t *queueId) const;
};

class DestroyQueueTsKernel : public HwTsKernelHandler {
public:
    DestroyQueueTsKernel() = default;
    ~DestroyQueueTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};
}  // namespace AicpuSchedule
#endif  // HWTS_KERNEL_QUEUE_H
