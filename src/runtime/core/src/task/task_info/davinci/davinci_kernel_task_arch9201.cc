/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "runtime_task_manager.h"
#include "davinci_kernel_task.h"
#include "aic_aiv_sqe_common.hpp"
#include "arch9201/aic_aiv_sqe.h"
#include "arch9201/arch9201_sqe_utils.hpp"

namespace cce {
namespace runtime {

#if F_DESC("DavinciKernelTask")
void ConstructArch9201SqeForHeadCommon(const TaskInfo* taskInfo, void* const sqe)
{
    const Stream* const stream = taskInfo->stream;
    // Performance-sensitive paths, internally controllable addresses
    // and security functions are not required for evaluation.
    RtArch9201StarsAicAivKernelSqe* davidSqe = static_cast<RtArch9201StarsAicAivKernelSqe*>(sqe);
    (void)memset_s(davidSqe, sizeof(RtArch9201StarsAicAivKernelSqe), 0, sizeof(RtArch9201StarsAicAivKernelSqe));
    davidSqe->header.wrCqe = stream->GetStarsWrCqeFlag();
    davidSqe->header.taskId = taskInfo->taskSn;
}

static void ConstructDavidCommonSqeForDavinciTask(TaskInfo* taskInfo, RtArch9201StarsAicAivKernelSqe* const sqe)
{
    Stream* const stm = taskInfo->stream;
    AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    ConstructArch9201SqeForHeadCommon(taskInfo, sqe);
    ConstructCommonAicAivSqeWord(&(aicTaskInfo->comm), sqe, taskInfo, stm);
    /* TODO: OST & logEn*/

    /* word 4*/
    sqe->aicMtePortArOstd = 0U;
    sqe->aicMtePortAwOstd = 0U;
    sqe->aivMtePortArOstd = 0U;
    sqe->aivMtePortAwOstd = 0U;

    /* word 5 */
    sqe->res3 = 0U;
    sqe->res4 = 0U;
    sqe->res5 = 0U;
    sqe->res6 = 0U;

    /* word 6-7 */
    sqe->aicNs = 0U;
    sqe->aivNs = 0U;
    sqe->getNxtTaskMode = 0U;
    sqe->res7 = 0U;
    sqe->res8 = 0U;
    sqe->res9 = 0U;
    return;
}

void GetDcachePrefetchCnt(const TaskInfo* taskInfo, RtArch9201StarsAicAivKernelSqe* const sqe)
{
    uint32_t argsSize = 0U;
    // 4KB, K=1024, aix args size can prefetch 4KB at most.
    constexpr uint32_t dcachePrefetchSizeMax = 4096U;
    constexpr uint32_t dcachePrefetchUnit = 64U;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    bool isAic = false;
    if ((taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) || (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC)) {
        const AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
        argsSize = aicTaskInfo->comm.argsSize;
        mixType = (aicTaskInfo->kernel != nullptr) ? aicTaskInfo->kernel->GetMixType() : static_cast<uint8_t>(NO_MIX);
        isAic = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE);
    } else {
        const FusionTaskInfo* fusionTaskInfo = &(taskInfo->u.fusionKernelTask);
        argsSize = fusionTaskInfo->argsSize;
        const Kernel* kernel = fusionTaskInfo->aicPart.kernel;
        mixType = (kernel != nullptr) ? kernel->GetMixType() : static_cast<uint8_t>(NO_MIX);
        isAic = (fusionTaskInfo->aicAivType == 0U);
    }

    const uint32_t userSizeCnt = argsSize / dcachePrefetchUnit;
    const uint32_t prefetchMaxSizeCnt = dcachePrefetchSizeMax / dcachePrefetchUnit;
    uint32_t dcachePrefetchCnt = (userSizeCnt > prefetchMaxSizeCnt) ? prefetchMaxSizeCnt : userSizeCnt;

    switch (mixType) {
        case MIX_AIC:
            sqe->aicDcachePrefetchCnt = dcachePrefetchCnt;
            break;
        case MIX_AIV:
            sqe->aivDcachePrefetchCnt = dcachePrefetchCnt;
            break;
        case MIX_AIC_AIV_MAIN_AIC:
        case MIX_AIC_AIV_MAIN_AIV:
            sqe->aicDcachePrefetchCnt = dcachePrefetchCnt;
            sqe->aivDcachePrefetchCnt = dcachePrefetchCnt;
            break;
        default:
            if (isAic) {
                sqe->aicDcachePrefetchCnt = dcachePrefetchCnt;
            } else {
                sqe->aivDcachePrefetchCnt = dcachePrefetchCnt;
            }
            break;
    }

    RT_LOG(
        RT_LOG_DEBUG, "get dcache prefetch cnt success, dcachePrefetchCnt=%u, taskType=%u, mixType=%hhu, isAic=%u",
        dcachePrefetchCnt, taskInfo->type, mixType, isAic);
    return;
}

static void ConstructDavidMixSqeForDavinciTask(TaskInfo* taskInfo, RtArch9201StarsAicAivKernelSqe* const sqe)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, sqe);
    ConstructMixSqeCommonForDavinciTask(taskInfo, sqe);

    AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint8_t mixType =
        (aicTaskInfo->kernel != nullptr) ? aicTaskInfo->kernel->GetMixType() : static_cast<uint8_t>(NO_MIX);
    switch (mixType) {
        case MIX_AIC:
            sqe->aicPreAllocateDisable = 0U;
            sqe->aivPreAllocateDisable = 1U;
            break;
        case MIX_AIV:
            sqe->aicPreAllocateDisable = 1U;
            sqe->aivPreAllocateDisable = 0U;
            break;
        case MIX_AIC_AIV_MAIN_AIC:
        case MIX_AIC_AIV_MAIN_AIV:
            sqe->aicPreAllocateDisable = 0U;
            sqe->aivPreAllocateDisable = 0U;
            break;
        default:
            break;
    }
    /* dcache preload cnt*/
    GetDcachePrefetchCnt(taskInfo, sqe);

    PrintDavidSqe(sqe, "MIX Task");
    return;
}

static void ConstructDavidAICoreSqeForDavinciTask(TaskInfo* taskInfo, RtArch9201StarsAicAivKernelSqe* const sqe)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, sqe);
    AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args) + aicTaskInfo->simtParamOffset;
    Stream* const stm = taskInfo->stream;
    ConstructAicSqePart(aicTaskInfo, sqe, addr, stm);
    sqe->aicPreAllocateDisable = 0U;
    sqe->aivPreAllocateDisable = 1U;
    /* dcache preload cnt */
    GetDcachePrefetchCnt(taskInfo, sqe);

    PrintDavidSqe(sqe, "AICore Task");
    return;
}

static void ConstructDavidAivSqeForDavinciTask(TaskInfo* taskInfo, RtArch9201StarsAicAivKernelSqe* const sqe)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, sqe);
    AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args) + aicTaskInfo->simtParamOffset;
    Stream* const stm = taskInfo->stream;
    ConstructAivSqePart(aicTaskInfo, sqe, addr, stm);
    sqe->aicPreAllocateDisable = 1U;
    sqe->aivPreAllocateDisable = 0U;
    /* dcache preload cnt */
    GetDcachePrefetchCnt(taskInfo, sqe);

    PrintDavidSqe(sqe, "AIV Task");
    return;
}

static void ConstructArch9201AicAivSqeForDavinciTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    RtArch9201StarsAicAivKernelSqe* davidSqe = static_cast<RtArch9201StarsAicAivKernelSqe*>(sqe);
    AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint8_t mixType =
        (aicTaskInfo->kernel != nullptr) ? aicTaskInfo->kernel->GetMixType() : static_cast<uint8_t>(NO_MIX);
    if (mixType != NO_MIX) {
        ConstructDavidMixSqeForDavinciTask(taskInfo, davidSqe);
    } else {
        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) {
            ConstructDavidAICoreSqeForDavinciTask(taskInfo, davidSqe);
        } else {
            ConstructDavidAivSqeForDavinciTask(taskInfo, davidSqe);
        }
    }
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

    RegTaskFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_KERNEL_AICPU, aicpuFuncs);
    RegTaskFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_KERNEL_AICORE, aicAivFuncs);
    RegTaskFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_KERNEL_AIVEC, aicAivFuncs);
    RegDavidSqeFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_KERNEL_AICPU, &ConstructDavidAICpuSqeForDavinciTask);
    RegDavidSqeFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_KERNEL_AICORE, &ConstructArch9201AicAivSqeForDavinciTask);
    RegDavidSqeFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_KERNEL_AIVEC, &ConstructArch9201AicAivSqeForDavinciTask);

    return true;
}

static bool g_davinciKernelTaskRegister = DavinciKernelTaskRegister();

#endif
} // namespace runtime
} // namespace cce