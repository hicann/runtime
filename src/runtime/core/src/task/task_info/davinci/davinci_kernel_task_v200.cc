/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "task_manager.h"
#include "davinci_kernel_task.h"

namespace cce {
namespace runtime {
#if F_DESC("DavinciKernelTask")

bool IsAicAivBiuPerfStreamSupported(const Stream *const stm)
{
    return !stm->GetBindFlag();
}

void ConstructDavidAICpuSqeForDavinciTask(TaskInfo *const taskInfo, void *const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t *davidSqe = static_cast<rtDavidSqe_t *>(sqe);
    uint64_t sqBaseAddr = sqeInfo.sqBaseAddr;
    ConstructDavidAICpuSqeForDavinciTaskBase(taskInfo, davidSqe, sqBaseAddr);

    RtDavidStarsAicpuKernelSqe *const aicpuKernelSqe = &(davidSqe->aicpuSqe);
    PrintDavidSqe(davidSqe, "AICpuTask");
    RT_LOG(RT_LOG_INFO, "topic_type=%hu, kernel_type=%u, dump_en=%u",
        aicpuKernelSqe->topicType, aicpuKernelSqe->kernelType, aicpuKernelSqe->debugDumpEn);
    return;
}

void UpdateDavidAICoreSqeForDavinciTask(TaskInfo *taskInfo, RtDavidStarsAicAivKernelSqe * const sqe)
{
    UNUSED(taskInfo);
    UNUSED(sqe);
    return;
}

void UpdateDavidAICpuKernelSqeForDavinciTask(RtDavidStarsAicpuKernelSqe * const sqe)
{
 	UNUSED(sqe);
    return;
}

void UpdateDavidAICpuControlSqeForDavinciTask(RtDavidStarsAicpuControlSqe * const sqe)
{
 	UNUSED(sqe);
    return;
}

void ConfigSqeDieFriendly(RtDavidStarsAicAivKernelSqe * const sqe, const Stream * const stm)
{
#ifndef CFG_DEV_PLATFORM_PC
    const uint8_t dieNum = stm->Device_()->GetDavidDieNum();
    if (dieNum <= 1U) {
        sqe->dieFriendly = 0U;
    }
#endif
    return;
}

static bool DavinciKernelTaskRegister()
{
    TaskFuncSingle aicAivFuncs = {
        .toCommandFunc = &ToCommandBodyForAicAivTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &StarsV2DoCompleteSuccessForDavinciTask,
        .taskUnInitFunc = &StarsV2DavinciTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForDavinciTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &StarsV2SetStarsResultForDavinciTask,
    };

    TaskFuncSingle aicpuFuncs = {
        .toCommandFunc = &ToCommandBodyForAicpuTask,
        .toSqeFunc = nullptr,
        .doCompleteSuccFunc = &StarsV2DoCompleteSuccessForDavinciTask,
        .taskUnInitFunc = &StarsV2DavinciTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForDavinciTask,
        .setResultFunc = nullptr,
        .setStarsResultFunc = &StarsV2SetStarsResultForDavinciTask,
    };

    const auto& chips = GetV200Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICPU, aicpuFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICORE, aicAivFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AIVEC, aicAivFuncs);
    }

    RegDavidSqeFunc(TS_TASK_TYPE_KERNEL_AICPU, &ConstructDavidAICpuSqeForDavinciTask);
    RegDavidSqeFunc(TS_TASK_TYPE_KERNEL_AICORE, &ConstructDavidAicAivSqeForDavinciTask);
    RegDavidSqeFunc(TS_TASK_TYPE_KERNEL_AIVEC, &ConstructDavidAicAivSqeForDavinciTask);

    return true;
}

static bool g_davinciKernelTaskRegister = DavinciKernelTaskRegister();

#endif

}  // namespace runtime
}  // namespace cce
