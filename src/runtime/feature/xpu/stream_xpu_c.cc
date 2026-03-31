/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream_xpu_c.hpp"
#include "stream_xpu.hpp"

namespace cce {
namespace runtime {
void XpuStreamLaunchKernelRecycle(DavidArgLoaderResult &result, TaskInfo *&recycleTask, Stream *stm)
{
    XpuStream *xpuStm = static_cast<XpuStream *>(stm);
    if (result.handle != nullptr) {
        if (xpuStm->ArgManagePtr() != nullptr) {
            xpuStm->ArgManagePtr()->RecycleDevLoader(result.handle);
        }
        result.handle = nullptr;
    }
    if (recycleTask != nullptr) {
        xpuStm->ArgReleaseSingleTask(recycleTask, false);
        recycleTask = nullptr;
    }
}

void XpuStreamLaunchKernelRecycleAicpu(DavidArgLoaderResult &result, TaskInfo *&recycleTask, Stream *stm)
{
    if ((recycleTask != nullptr) && (recycleTask->type == TS_TASK_TYPE_KERNEL_AICPU)) {
        DELETE_O(recycleTask->u.aicpuTaskInfo.kernel);
    }

    XpuStreamLaunchKernelRecycle(result, recycleTask, stm);
}

}  // namespace runtime
}  // namespace cce

