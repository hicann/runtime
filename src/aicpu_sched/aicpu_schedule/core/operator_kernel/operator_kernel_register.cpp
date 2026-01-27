/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_register.h"

#include "aicpusd_status.h"
#include "aicpusd_model_err_process.h"


namespace AicpuSchedule {
OperatorKernelRegister &OperatorKernelRegister::Instance()
{
    static OperatorKernelRegister instance;
    return instance;
}

int32_t OperatorKernelRegister::RunOperatorKernel(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    const auto kernelName = PtrToPtr<const void, const char_t>(ValueToPtr(kernelTaskInfo.kernelName));
    if (kernelName == nullptr) {
        aicpusd_err("The name of kernel is nullptr.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    std::shared_ptr<OperatorKernel> kernel = GetOperatorKernel(kernelName);
    if (kernel == nullptr) {
        aicpusd_err("Can not find aicpu operator kernel, kernelName=%s", kernelName);
        return AICPU_SCHEDULE_ERROR_NOT_FOUND_LOGICAL_TASK;
    }

    aicpusd_info("Begin to process kernelName[%s] modelId[%u] streamId[%u].", kernelName, taskContext.modelId,
        taskContext.streamId);
    const int32_t ret = kernel->Compute(kernelTaskInfo, taskContext);
    if (ret != AICPU_SCHEDULE_OK) {
        aicpusd_err("Operator kernel compute error, ret=%d, kernelName=%s", ret, kernelName);
    }
    aicpusd_info("End to process kernelName[%s] modelId[%u] streamId[%u] result[%d].",
                 kernelName, taskContext.modelId, taskContext.streamId, ret);

    return ret;
}

int32_t OperatorKernelRegister::CheckOperatorKernelSupported(const std::string &kernelName)
{
    std::shared_ptr<OperatorKernel> kernel = GetOperatorKernel(kernelName);
    if (kernel == nullptr) {
        aicpusd_warn("Finish to process, kernel[%s] is not supported.", kernelName.c_str());
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    aicpusd_info("Finish to process, kernel[%s] supported", kernelName.c_str());
    return AICPU_SCHEDULE_OK;
}

std::shared_ptr<OperatorKernel> OperatorKernelRegister::GetOperatorKernel(const std::string &opType)
{
    std::map<std::string, std::shared_ptr<OperatorKernel>>::const_iterator iter = kernelInstMap_.find(opType);
    if (iter != kernelInstMap_.end()) {
        return iter->second;
    }
    aicpusd_warn("The kernel[%s] is not registered", opType.c_str());
    return std::shared_ptr<OperatorKernel>(nullptr);
}

OperatorKernelRegister::Registerar::Registerar(const std::string &type, const KernelCreatorFunc &func)
{
    OperatorKernelRegister::Instance().Register(type, func);
}

void OperatorKernelRegister::Register(const std::string &type, const KernelCreatorFunc &func)
{
    std::unique_lock<std::mutex> lock(kernelInstMapMutex_);
    std::map<std::string, std::shared_ptr<OperatorKernel>>::const_iterator iter = kernelInstMap_.find(type);
    if (iter != kernelInstMap_.end()) {
        aicpusd_run_warn("Register[%s] creator already exist.", type.c_str());
        return;
    }

    kernelInstMap_[type] = func();
    aicpusd_debug("Kernel[%s] register successfully.", type.c_str());
    return;
}

}  // namespace AicpuSchedule