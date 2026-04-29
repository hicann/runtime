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
#include "stream_david.hpp"
#include "task_scheduler_error.h"
#include "task_manager.h"
#include "device_error_proc.hpp"

namespace cce {
namespace runtime {

#if F_DESC("DavinciMultipleTask")
void DavinciMultipleTaskUnInit(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo *davMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stm = taskInfo->stream;
    davMultiTaskInfo->multipleTaskInfo = nullptr;
    static_cast<DavidStream *>(stm)->ArgReleaseMultipleTask(taskInfo);
    ResetCmdList(taskInfo);
}
#endif

}  // namespace runtime
}  // namespace cce
