/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "hwts_kernel_register.h"

#include "aicpusd_status.h"
#include "aicpusd_model_err_process.h"

namespace AicpuSchedule {
HwTsKernelRegister &HwTsKernelRegister::Instance()
{
    static HwTsKernelRegister instance;
    return instance;
}

int32_t HwTsKernelRegister::RunTsKernelTaskProcess(const aicpu::HwtsTsKernel &tsKernelInfo, const std::string &kernelName)
{
    std::shared_ptr<HwTsKernelHandler> kernel = GetTsKernelTaskProcess(kernelName);
    if (kernel == nullptr) {
        aicpusd_err("Can not find aicpu hwts kernel, kernelName=%s", kernelName.c_str());
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_LOGICAL_TASK;
    }

    aicpusd_info("Begin to process kernelName[%s].", kernelName.c_str());
    const int32_t ret = kernel->Compute(tsKernelInfo);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("hwts kernel compute error, ret=%d, kernelName=%s", ret, kernelName.c_str());
    }
    aicpusd_info("End to process kernelName[%s] result[%d].", kernelName.c_str(), ret);

    return ret;
}

int32_t HwTsKernelRegister::CheckTsKernelSupported(const std::string &kernelName)
{
    std::shared_ptr<HwTsKernelHandler> kernel = GetTsKernelTaskProcess(kernelName);
    if (kernel == nullptr) {
        aicpusd_warn("check hwts kernel[%s] is not supported.", kernelName.c_str());
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    aicpusd_info("check hwts process kernel[%s] supported", kernelName.c_str());
    return AICPU_SCHEDULE_OK;
}

std::shared_ptr<HwTsKernelHandler> HwTsKernelRegister::GetTsKernelTaskProcess(const std::string &opType)
{
    std::map<std::string, std::shared_ptr<HwTsKernelHandler>>::iterator iter = tsKernelInstMap_.find(opType);
    if (iter != tsKernelInstMap_.end()) {
        return iter->second;
    }
    aicpusd_warn("The kernel[%s] is not registered", opType.c_str());
    return std::shared_ptr<HwTsKernelHandler>(nullptr);
}

HwTsKernelRegister::Registerar::Registerar(
    const std::string &kernelType, const HwTsKernelCreatorFunc &func)
{
    HwTsKernelRegister::Instance().Register(kernelType, func);
}

void HwTsKernelRegister::Register(
    const std::string &kernelType, const HwTsKernelCreatorFunc &func)
{
    std::unique_lock<std::mutex> lock(hwtsKernelMapMutex_);
    std::map<std::string, std::shared_ptr<HwTsKernelHandler>>::iterator iter =
        tsKernelInstMap_.find(kernelType);
    if (iter != tsKernelInstMap_.end()) {
        aicpusd_run_warn("Hwts Kernel[%s] creator already exist.", kernelType.c_str());
        return;
    }

    tsKernelInstMap_[kernelType] = func();
    aicpusd_info("Hwts Kernel[%s] register successfully.", kernelType.c_str());

    return;
}

}  // namespace AicpuSchedule