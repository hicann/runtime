/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_H
#define OPERATOR_KERNEL_H

#include <memory>
#include <string>
#include <functional>
#include "operator_kernel_context.h"

namespace AicpuSchedule {
class AICPU_VISIBILITY OperatorKernel {
public:
    virtual int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) = 0;
    virtual ~OperatorKernel() {}
};

using KernelCreatorFunc = std::function<std::shared_ptr<OperatorKernel>(void)>;

AICPU_VISIBILITY bool RegistOperatorKernel(const std::string &type, const KernelCreatorFunc &fun);

template <typename T, typename... Args>
static inline std::shared_ptr<T> MakeShared(Args &&...args)
{
    using T_NC = typename std::remove_const<T>::type;
    std::shared_ptr<T> ret(new (std::nothrow) T_NC(std::forward<Args>(args)...));
    return ret;
}

#define REGISTER_OPERATOR_KERNEL(type, clazz)                 \
    std::shared_ptr<OperatorKernel> Creator_##type##_Kernel() \
    {                                                         \
        std::shared_ptr<clazz> ptr = nullptr;                 \
        ptr = MakeShared<clazz>();                            \
        return ptr;                                           \
    }                                                         \
    bool g_##type##_Kernel_Creator __attribute__((unused)) = RegistOperatorKernel(type, Creator_##type##_Kernel)

}  // namespace AicpuSchedule

#endif  // OPERATOR_KERNEL_H