/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_AIX_C_HPP__
#define __CCE_RUNTIME_AIX_C_HPP__

#include "task_info.hpp"
#include "args/args_inner.h"

namespace cce {
namespace runtime {
    class Context;
    struct StarsArgLoaderResult;
    struct rtStreamLaunchKernelV2ExtendArgs_t {
        const rtArgsEx_t *argsInfo;
        const TaskCfg *taskCfg;
        void **argsArray;
        SimtArgsArray *simtArgsArray;
        SimtArgsHost *simtArgsHost;
        ArgsType argsType;
    };

    rtError_t StreamLaunchKernelV1(const void * const stubFunc, const uint32_t coreDim,
        const rtArgsEx_t *argsInfo,
        Stream *stm, const TaskCfg * const taskCfg,
        const bool isLaunchVec);
    rtError_t StreamLaunchKernelWithHandle(void * const progHandle, const uint64_t tilingKey, const uint32_t coreDim,
        const rtArgsEx_t *argsInfo, Stream *stm,
        const TaskCfg * const taskCfg = nullptr, const bool isLaunchVec = false);
    rtError_t StreamLaunchKernelV2(Kernel *kernel, const uint32_t coreDim, Stream *stm,
        const rtStreamLaunchKernelV2ExtendArgs_t *extendAgrs, const bool isLaunchVec = false);
    rtError_t UpdateTaskPrepare(const Context *ctx, TaskInfo *updateTask, const Kernel *kernel, const Stream *stm);
    rtError_t LaunchUpdateKernelSubmit(const Context *ctx, TaskInfo *updateTask, Stream *stm, const rtArgsEx_t *argsInfo,
        StarsArgLoaderResult &result);
    rtError_t UpdateDavidKernelTaskSubmit(TaskInfo * const updateTask, Stream * const stm, uint32_t sqeLen = 1U);
    rtError_t CheckAndGetTotalShareMemorySize(const Kernel * const kernel, uint32_t dynamicShareMemSize, uint32_t &simtDcuSmSize);

    rtError_t StreamLaunchSimtArgsArray(Kernel *kernel, const uint32_t coreDim, Stream *stm,
        SimtArgsArray *simtArgsArray, TaskCfg &taskCfg);
rtError_t StreamLaunchArgsArray(Kernel *kernel, const uint32_t coreDim, Stream *stm,
    void **argsArrayInfo, TaskCfg &taskCfg);


    rtError_t StreamLaunchSimtArgsHost(Kernel *kernel, const uint32_t coreDim, Stream *stm,
        SimtArgsHost *simtArgsHost, TaskCfg &taskCfg);

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_AIX_C_HPP__
