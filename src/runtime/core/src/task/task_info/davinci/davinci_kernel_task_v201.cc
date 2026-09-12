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
#include "base_david.hpp"
#include "kernel.hpp"
#include "runtime_task_manager.h"
#include "davinci_kernel_task.h"

namespace cce {
namespace runtime {
#if F_DESC("DavinciKernelTask")

bool IsAicAivBiuPerfStreamSupported(const Stream* const stm)
{
    UNUSED(stm);
    return true;
}

static void UpdateDataDumpAICpuKernelCredit(TaskInfo* const taskInfo, RtDavidStarsAicpuKernelSqe* const aicpuKernelSqe)
{
    AicpuTaskInfo* aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    const uint8_t kernelFlag = aicpuTaskInfo->comm.kernelFlag;
    if ((kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        aicpuKernelSqe->kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
    }

    return;
}

void ConstructDavidAICpuSqeForDavinciTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    uint64_t sqBaseAddr = sqeInfo.sqBaseAddr;
    ConstructDavidAICpuSqeForDavinciTaskBase(taskInfo, davidSqe, sqBaseAddr);
    RtDavidStarsAicpuKernelSqe* const aicpuKernelSqe = &(davidSqe->aicpuSqe);

    // swap buffer use host pid
    aicpuKernelSqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
    UpdateDavidAICpuKernelSqeForDavinciTask(aicpuKernelSqe);

    // v201基准刻度较小，aicpu算子做永不超时，datadump在公共逻辑有遗漏，此处独立刷新
    UpdateDataDumpAICpuKernelCredit(taskInfo, aicpuKernelSqe);

    PrintDavidSqe(davidSqe, "AICpuTask");
    RT_LOG(
        RT_LOG_INFO, "type=%hu, topic_type=%hu, kernel_type=%u, dump_en=%u", aicpuKernelSqe->header.type,
        aicpuKernelSqe->topicType, aicpuKernelSqe->kernelType, aicpuKernelSqe->debugDumpEn);
    return;
}

void UpdateDavidAICoreSqeForDavinciTask(TaskInfo* taskInfo, RtDavidStarsAicAivKernelSqe* const sqe)
{
    AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const Kernel* kernel = aicTaskInfo->kernel;
    if ((kernel != nullptr) && (kernel->isStlKernel())) {
        sqe->aivSimtDcuSmSize = RT_SIMT_STL_UB_SIZE;
        sqe->stl = 1U;
    }
    sqe->piMix = 1U;
    return;
}

void UpdateDavidAICpuControlSqeForDavinciTask(RtDavidStarsAicpuControlSqe* const sqe)
{
    sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_SRC_PID;
    return;
}

void UpdateDavidAICpuKernelSqeForDavinciTask(RtDavidStarsAicpuKernelSqe* const sqe)
{
    sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_SRC_PID;
    return;
}

template <typename SqeType>
void ConfigSqeDieFriendly(SqeType* const sqe, const Stream* const stm)
{
    UNUSED(stm);
    sqe->dieFriendly = 0U;
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

    const auto& chips = GetV201Chips();
    for (const auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICPU, aicpuFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICORE, aicAivFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AIVEC, aicAivFuncs);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_KERNEL_AICPU, &ConstructDavidAICpuSqeForDavinciTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_KERNEL_AICORE, &ConstructDavidAicAivSqeForDavinciTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_KERNEL_AIVEC, &ConstructDavidAicAivSqeForDavinciTask);
    }

    return true;
}

static bool g_davinciKernelTaskRegister = DavinciKernelTaskRegister();
template void ConfigSqeDieFriendly<RtDavidStarsAicAivKernelSqe>(
    RtDavidStarsAicAivKernelSqe* const, const Stream* const);
#endif

} // namespace runtime
} // namespace cce
