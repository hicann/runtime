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

namespace cce {
namespace runtime {

rtError_t GetPrefetchCnt(Kernel * const kernel)
{
    UNUSED(kernel);
    return RT_ERROR_NONE;
}

rtError_t LoadKernelArgs(Stream* stm, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& result)
{
    return stm->LoadArgsInfo(argsInfo, false, &result, LoadPolicy::LP_NO_MIX);
}

rtError_t PostUpdateKernelParams(TaskInfo* taskInfo)
{
    return WaitAsyncCopyComplete(taskInfo);
}

void SetAicoreArgsSuperKernel(TaskInfo* taskInfo, const rtArgsEx_t* argsInfo, StarsArgLoaderResult& result)
{
    if (result.handle != nullptr) {
        SetAicoreArgs(taskInfo, result.kerArgs, argsInfo->argsSize, result.handle);
        result.handle = nullptr;
    }
}

rtError_t CheckDynSizeValid(TaskInfo* taskInfo, const Kernel * const kernel)
{
    UNUSED(taskInfo);
    UNUSED(kernel);
    return RT_ERROR_NONE;
}

void BackupTaskArgHandle(TaskInfo* taskInfo)
{
    UNUSED(taskInfo);
}

}  // namespace runtime
}  // namespace cce
