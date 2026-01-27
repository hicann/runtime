/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_AICPU_C_HPP__
#define __CCE_RUNTIME_AICPU_C_HPP__

#include "task_info.hpp"

namespace cce {
namespace runtime {

    rtError_t StreamLaunchKernelEx(const void * const args, const uint32_t argsSize, const uint32_t flags,
        Stream * const stm);
    rtError_t StreamLaunchCpuKernel(const rtKernelLaunchNames_t * const launchNames, const uint32_t coreDim,
        const rtArgsEx_t * const argsInfo, Stream * const stm, const uint32_t flag);
    rtError_t StreamLaunchCpuKernelExWithArgs(const uint32_t coreDim, const rtAicpuArgsEx_t * const argsInfo,
        const TaskCfg * const taskCfg, Stream * const stm, const uint32_t flag, const uint32_t kernelType,
        const Kernel * const kernel, const size_t cpuParamHeadOffset = 0U);

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_AICPU_C_HPP__