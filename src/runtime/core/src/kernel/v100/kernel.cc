/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "kernel.hpp"
#include "program.hpp"
#include "stream.hpp"
#include "load_policy.hpp"
#include "task_info.hpp"
#include "stars_arg_manager.hpp"
#include "para_convertor.hpp"

namespace cce {
namespace runtime {

rtError_t GetPrefetchCnt(Kernel* const kernel)
{
    UNUSED(kernel);
    return RT_ERROR_NONE;
}

// aclGraph 更新加载：ARRAY 按 launch 同一入口展平，三形态恒走 LP_NO_MIX（与 mixOpt=0 强配对，错配
// 会把 FFTS context 写进 args 头部踩踏；capture 期为 LP_MIX+mixOpt=1，翻转安全，旧值配对释放）。
rtError_t LoadKernelArgs(
    Stream* stm, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& result, const Kernel* kernel,
    rtKernelArgsType argsType, void** argsArray)
{
    rtArgsEx_t convertedArgs = {};
    const rtArgsEx_t* flatArgs = argsInfo;
    if (argsType == RT_KERNEL_ARGS_ARRAY) {
        const rtError_t error = ConvertArgsArrayToArgsEx(convertedArgs, kernel, argsArray);
        ERROR_RETURN(
            error, "Failed to flatten the cached args array, retCode=%#x, stream_id=%d.", static_cast<uint32_t>(error),
            stm->Id_());
        flatArgs = &convertedArgs;
    }
    // 恒 LP_NO_MIX 的不变式（与 mixOpt=0 强配对）在唯一的加载落点处单源化
    return stm->LoadArgsInfo(flatArgs, false, &result, LoadPolicy::LP_NO_MIX);
}

rtError_t PostUpdateKernelParams(TaskInfo* taskInfo) { return WaitAsyncCopyComplete(taskInfo); }

void SetAicoreArgsSuperKernel(TaskInfo* taskInfo, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& result)
{
    if (result.handle != nullptr) {
        SetAicoreArgs(taskInfo, result.kerArgs, argsInfo->argsSize, result.handle);
        result.handle = nullptr;
    }
}

rtError_t CheckDynSizeValid(TaskInfo* const taskInfo, const Kernel* const kernel)
{
    UNUSED(taskInfo);
    UNUSED(kernel);
    return RT_ERROR_NONE;
}

void BackupTaskArgHandle(TaskInfo* taskInfo) { UNUSED(taskInfo); }

} // namespace runtime
} // namespace cce
