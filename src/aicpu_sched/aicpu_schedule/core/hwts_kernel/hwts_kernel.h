/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HWTS_KERNEL_H
#define HWTS_KERNEL_H

#include <functional>
#include <memory>
#include <sstream>
#include <string>

#include "aicpusd_common.h"
#include "aicpusd_info.h"
#include "aicpusd_status.h"

#include "aicpu_event_struct.h"

namespace AicpuSchedule {
class AICPU_VISIBILITY HwTsKernelHandler {
public:
    virtual int32_t Compute(const aicpu::HwtsTsKernel &tsKernelInfo) = 0;
    virtual ~HwTsKernelHandler() = default;
};

using HwTsKernelCreatorFunc = std::function<std::shared_ptr<HwTsKernelHandler>(void)>;

AICPU_VISIBILITY bool RegisterHwTsKernel(const std::string &kernelType, const HwTsKernelCreatorFunc &func);

template <typename T, typename... Args>
inline std::shared_ptr<T> MakeHwTsKernelShared(Args &&...args)
{
    using T_NC = typename std::remove_const<T>::type;
    return std::make_shared<T_NC>(std::forward<Args>(args)...);
}

template<typename T>
class CreatorFunction {
public:
    std::shared_ptr<HwTsKernelHandler> operator()() const {
        return MakeHwTsKernelShared<T>();
    }
};

#define REGISTER_HWTS_KERNEL(kernelType, clazz)                      \
    bool g_##kernelType##_TsKernel_Creator __attribute__((unused)) = \
        RegisterHwTsKernel((kernelType), (CreatorFunction<clazz>()))

}  // namespace AicpuSchedule

#endif  // HWTS_KERNEL_H