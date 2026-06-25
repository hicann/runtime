/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "runtime.hpp"
#include "stars_david.hpp"
#include "error_code.h"
#include "fusion_task.h"
#include "task_manager.h"

namespace cce {
namespace runtime {

void ConstructAicpuSubSqe(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
                          uint32_t aicpuIndex, uint32_t taskIdx, uint64_t sqBaseAddr)
{
    ConstructAicpuSubSqeBase(taskInfo, davidSqe, sqeIndex, aicpuIndex, taskIdx, sqBaseAddr);
    rtDavidSqe_t *sqeAddr = &davidSqe[sqeIndex];
    FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    rtFunsionTaskInfo_t * const fusionKernelInfo =
        RtPtrToPtr<rtFunsionTaskInfo_t *>(RtPtrToUnConstPtr<void *>(fusionKernelTask->fusionKernelInfo));

    const char *desc = (fusionKernelInfo->subTask[taskIdx].type == RT_FUSION_AICPU) ?
        "FusionKernelTask-Aicpu" : "FusionKernelTask-Hcom_cpu";
    PrintDavidSqe(sqeAddr, desc);

    sqeIndex++;
    return;
}

static bool FusionKernelTaskRegister()
{
    TaskFuncSingle funcs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &DoCompleteSuccessForFusionKernelTask,
        .taskUnInitFunc = &FusionKernelTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForFusionKernelTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &SetStarsResultForFusionKernelTask,
    };

    const auto &chips = GetV200Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_FUSION_KERNEL, funcs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_FUSION_KERNEL, &ConstructDavidSqeForFusionKernelTask);
    return true;
}

static bool g_fusionKernelTaskRegister = FusionKernelTaskRegister();

}  // namespace runtime
}  // namespace cce
