/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "xpu_aicpu_c.hpp"

namespace cce {
namespace runtime {

rtError_t XpuLaunchKernel(const Kernel * const kernel, const uint32_t coreDim, const rtAicpuArgsEx_t * const argsInfo,
    Stream * const stm, const TaskCfg * const taskCfg)
{
    UNUSED(kernel);
    UNUSED(coreDim);
    UNUSED(argsInfo);
    UNUSED(stm);
    UNUSED(taskCfg);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

}  // namespace runtime
}  // namespace cce
