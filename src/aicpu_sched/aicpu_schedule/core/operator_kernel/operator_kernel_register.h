/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_REGISTER_H
#define OPERATOR_KERNEL_REGISTER_H

#include <map>
#include <mutex>
#include <functional>
#include "operator_kernel.h"


namespace AicpuSchedule {
class AICPU_VISIBILITY OperatorKernelRegister {
public:
    OperatorKernelRegister() : kernelInstMap_() {};
    ~OperatorKernelRegister() = default;

    static OperatorKernelRegister &Instance();

    int32_t RunOperatorKernel(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext);
    int32_t CheckOperatorKernelSupported(const std::string &kernelName);

    class Registerar {
    public:
        Registerar(const std::string &type, const KernelCreatorFunc &fun);
        ~Registerar() = default;

        Registerar(const Registerar &) = delete;
        Registerar(Registerar &&) = delete;
        Registerar &operator=(const Registerar &) = delete;
        Registerar &operator=(Registerar &&) = delete;
    };

private:
    OperatorKernelRegister(const OperatorKernelRegister &) = delete;
    OperatorKernelRegister(OperatorKernelRegister &&) = delete;
    OperatorKernelRegister &operator=(const OperatorKernelRegister &) = delete;
    OperatorKernelRegister &operator=(OperatorKernelRegister &&) = delete;

    std::shared_ptr<OperatorKernel> GetOperatorKernel(const std::string &opType);
    void Register(const std::string &type, const KernelCreatorFunc &fun);

    std::mutex kernelInstMapMutex_;
    // To accelerate, each types of kernel only have one inst
    std::map<std::string, std::shared_ptr<OperatorKernel>> kernelInstMap_;
};

};  // namespace AicpuSchedule

#endif  // OPERATOR_KERNEL_REGISTER_H