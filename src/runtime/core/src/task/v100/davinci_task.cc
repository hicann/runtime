/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "davinci_multiple_task.h"
#include "davinci_kernel_task.h"
#include "stream.hpp"
#include "task_scheduler_error.h"
#include "task_manager.h"
#include "arg_loader.hpp"
#include "device_error_proc.hpp"

namespace cce {
namespace runtime {

std::mutex g_cmdListVecLock;

#if F_DESC("DavinciMultipleTask")
void DavinciMultipleTaskUnInit(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo *davMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stm = taskInfo->stream;
    const std::lock_guard<std::mutex> tskLock(g_cmdListVecLock);
    davMultiTaskInfo->multipleTaskInfo = nullptr;
    if (davMultiTaskInfo->argHandleVec != nullptr) {
        for (auto iter : *(davMultiTaskInfo->argHandleVec)) {
            if (iter != nullptr) {
                (void)stm->Device_()->ArgLoader_()->Release(iter);
            }
        }
        davMultiTaskInfo->argHandleVec->clear();
        delete davMultiTaskInfo->argHandleVec;
        davMultiTaskInfo->argHandleVec = nullptr;
    }

    ResetCmdList(taskInfo);
}
#endif

}  // namespace runtime
}  // namespace cce
