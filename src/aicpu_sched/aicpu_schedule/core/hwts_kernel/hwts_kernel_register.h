/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HWTS_KERNEL_REGISTER_H
#define HWTS_KERNEL_REGISTER_H

#include <map>
#include <mutex>
#include "hwts_kernel.h"


namespace AicpuSchedule {
class AICPU_VISIBILITY HwTsKernelRegister {
public:
    HwTsKernelRegister() : hwtsKernelMapMutex_(), tsKernelInstMap_({}) {};
    ~HwTsKernelRegister() = default;

    static HwTsKernelRegister &Instance();

    int32_t RunTsKernelTaskProcess(const aicpu::HwtsTsKernel &tsKernelInfo, const std::string &kernelName);
    int32_t CheckTsKernelSupported(const std::string &kernelName);

    class Registerar {
    public:
        Registerar(const std::string &kernelType, const HwTsKernelCreatorFunc &func);
        ~Registerar() = default;

        Registerar(const Registerar &) = delete;
        Registerar(Registerar &&) = delete;
        Registerar &operator=(const Registerar &) = delete;
        Registerar &operator=(Registerar &&) = delete;
    };

private:
    HwTsKernelRegister(const HwTsKernelRegister &) = delete;
    HwTsKernelRegister(HwTsKernelRegister &&) = delete;
    HwTsKernelRegister &operator=(const HwTsKernelRegister &) = delete;
    HwTsKernelRegister &operator=(HwTsKernelRegister &&) = delete;

    void Register(const std::string &kernelType, const HwTsKernelCreatorFunc &func);
    std::shared_ptr<HwTsKernelHandler> GetTsKernelTaskProcess(const std::string &opType);

    std::mutex hwtsKernelMapMutex_;
    // To accelerate, each types of kernel only have one inst
    std::map<std::string, std::shared_ptr<HwTsKernelHandler>> tsKernelInstMap_;
};

};  // namespace AicpuSchedule

#endif  // HWTS_KERNEL_REGISTER_H