/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CPU_KERNEL_H
#define CPU_KERNEL_H

#include <cstdint>
#include <functional>
#include "cpu_context.h"

namespace aicpu {
class AICPU_VISIBILITY CpuKernel {
public:
    virtual uint32_t Compute(CpuKernelContext &ctx) = 0;

    virtual ~CpuKernel() {}
};

using KERNEL_CREATOR_FUN = std::function<std::shared_ptr<CpuKernel>(void)>;

AICPU_VISIBILITY bool RegistCpuKernel(const std::string &type, const KERNEL_CREATOR_FUN &fun);

template <typename T, typename... Args> static inline std::shared_ptr<T> MakeShared(Args &&... args)
{
    using T_NC = typename std::remove_const<T>::type;
    std::shared_ptr<T> ret(new (std::nothrow) T_NC(std::forward<Args>(args)...));
    return ret;
}

#define REGISTER_CPU_KERNEL(type, clazz) std::shared_ptr<CpuKernel> Creator_##type##_Kernel() \
    {                                                    \
        std::shared_ptr<clazz> ptr = nullptr;            \
        ptr = MakeShared<clazz>();                       \
        return ptr;                                      \
    }                                                    \
    bool g_##type##_Kernel_Creator __attribute__((unused)) = RegistCpuKernel(type, Creator_##type##_Kernel)
}
#endif // CPU_KERNEL_H
