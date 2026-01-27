/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HWTS_KERNEL_MODEL_CONTROL_H
#define HWTS_KERNEL_MODEL_CONTROL_H

#include "hwts_kernel.h"
#include "aicpu_sched/common/aicpu_task_struct.h"

namespace AicpuSchedule {
class EndGraphTsKernel : public HwTsKernelHandler {
public:
    EndGraphTsKernel() = default;
    ~EndGraphTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class RecordNotifyTsKernel : public HwTsKernelHandler {
public:
    RecordNotifyTsKernel() = default;
    ~RecordNotifyTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class ActiveEntryStreamTsKernel : public HwTsKernelHandler {
public:
    ActiveEntryStreamTsKernel() = default;
    ~ActiveEntryStreamTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class ModelStopTsKernel : public HwTsKernelHandler {
public:
    ModelStopTsKernel() = default;
    ~ModelStopTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class ModelClearAndRestartTsKernel : public HwTsKernelHandler {
public:
    ModelClearAndRestartTsKernel() = default;
    ~ModelClearAndRestartTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};
}  // namespace AicpuSchedule
#endif  // HWTS_KERNEL_MODEL_CONTROL_H
