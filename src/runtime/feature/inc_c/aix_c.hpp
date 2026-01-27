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

namespace cce {
namespace runtime {
    typedef struct StreamLaunchKernelV2ExtendArgs {
        const rtArgsEx_t *argsInfo;
        const rtTaskCfgInfo_t *cfgInfo;
        const LaunchTaskCfgInfo_t *launchTaskCfg;
        const TaskCfg *taskCfg;
    } rtStreamLaunchKernelV2ExtendArgs_t;

    rtError_t StreamLaunchKernelV1(const void * const stubFunc, const uint32_t coreDim, const rtArgsEx_t *argsInfo,
        Stream *stm, const uint32_t flag, const rtTaskCfgInfo_t * const cfgInfo);
    rtError_t StreamLaunchKernelWithHandle(void * const progHandle, const uint64_t tilingKey, const uint32_t coreDim,
        const rtArgsEx_t *argsInfo, Stream *stm, const uint32_t flag, const rtTaskCfgInfo_t * const cfgInfo = nullptr);
    rtError_t StreamLaunchKernelV2(Kernel * const kernel, const uint32_t coreDim, Stream *stm,
        const rtStreamLaunchKernelV2ExtendArgs_t * const extendAgrs);
    rtError_t UpdateDavidKernelTaskSubmit(TaskInfo * const updateTask, Stream * const stm, uint32_t sqeLen = 1U);
    rtError_t ConstructStreamLaunchKernelV2ExtendArgs(const rtArgsEx_t *argsInfo,
        const rtTaskCfgInfo_t * const cfgInfo, const LaunchTaskCfgInfo_t * const launchTaskCfg,
        const TaskCfg * const taskCfg, rtStreamLaunchKernelV2ExtendArgs_t *extendArgs);

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_AIX_C_HPP__