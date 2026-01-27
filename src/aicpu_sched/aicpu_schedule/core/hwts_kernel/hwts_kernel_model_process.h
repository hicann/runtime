/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HWTS_KERNEL_MODEL_PROCESS_H
#define HWTS_KERNEL_MODEL_PROCESS_H

#include "hwts_kernel.h"


namespace AicpuSchedule {
class ConfigExtInfoTsKernel : public HwTsKernelHandler {
public:
    ConfigExtInfoTsKernel() = default;
    ~ConfigExtInfoTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class ModelConfigTsKernel : public HwTsKernelHandler {
public:
    ModelConfigTsKernel() = default;
    ~ModelConfigTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class ShapeConfigTsKernel : public HwTsKernelHandler {
public:
    ShapeConfigTsKernel() = default;
    ~ShapeConfigTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class EschedPriorityTsKernel : public HwTsKernelHandler {
public:
    EschedPriorityTsKernel() = default;
    ~EschedPriorityTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class CheckSupportedTsKernel : public HwTsKernelHandler {
public:
    CheckSupportedTsKernel() = default;
    ~CheckSupportedTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};

class ProcessDataExceptionTsKernel : public HwTsKernelHandler {
public:
    ProcessDataExceptionTsKernel() = default;
    ~ProcessDataExceptionTsKernel() override = default;
    int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) override;
};
}  // namespace AicpuSchedule
#endif  // HWTS_KERNEL_MODEL_PROCESS_H
