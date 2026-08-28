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
#include "arch920x.hpp"
#include "arch920x/aic_aiv_sqe.h"
#include "arch920x/arch920x_sqe_utils.hpp"

namespace cce {
namespace runtime {

#if F_DESC("DavinciKernelTask")
static void ConfigArch920xAixTaskProfiling(const TaskInfo* taskInfo, rtDavidStarsSqeHeader_t* const header)
{
    if (Runtime::Instance()->GetTaskLevelProfFlag()) {
        header->reserved = taskInfo->enableProfiling;
    } else {
        header->reserved = 1U;
    }
}

static void ConstructArch920xSqeForHeadCommon(const TaskInfo* taskInfo, void* const sqe)
{
    const Stream* const stream = taskInfo->stream;
    // Performance-sensitive paths, internally controllable addresses
    // and security functions are not required for evaluation.
    RtArch920xStarsAicAivKernelSqe* davidSqe = static_cast<RtArch920xStarsAicAivKernelSqe*>(sqe);
    (void)memset_s(davidSqe, sizeof(RtArch920xStarsAicAivKernelSqe), 0, sizeof(RtArch920xStarsAicAivKernelSqe));
    davidSqe->header.wrCqe = stream->GetStarsWrCqeFlag();
    davidSqe->header.taskId = taskInfo->taskSn;
    ConfigArch920xAixTaskProfiling(taskInfo, &(davidSqe->header));
}

void ConfigArch920xOstEnable(const Kernel* kernel, RtArch920xStarsAicAivKernelSqe* const sqe)
{
    if ((sqe->header.preP == 0U) && (sqe->header.postP == 0U)) {
        sqe->ost = (kernel != nullptr) ? kernel->GetEarlyStartEnable() : 0U;
    }
    return;
}

void ConfigArch920xSqeHeaderTaskProfiling(rtDavidStarsSqeHeader_t* const header)
{
    if (Runtime::Instance()->GetTaskLevelProfFlag()) {
        header->reserved = 0U;
    } else {
        header->reserved = 1U;
    }

    return;
}

static void ConstructDavidCommonSqeForDavinciTask(TaskInfo* taskInfo, RtArch920xStarsAicAivKernelSqe* const sqe)
{
    Stream* const stm = taskInfo->stream;
    AicTaskInfo* aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    ConstructArch920xSqeForHeadCommon(taskInfo, sqe);
    ConstructCommonAicAivSqeWord(&(aicTaskInfo->comm), sqe, taskInfo, stm);

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

void GetDcachePrefetchCnt(const TaskInfo* taskInfo, RtArch920xStarsAicAivKernelSqe* const sqe)
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

static void ConstructDavidMixSqeForDavinciTask(TaskInfo* taskInfo, RtArch920xStarsAicAivKernelSqe* const sqe)
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
    ConfigArch920xOstEnable(aicTaskInfo->kernel, sqe);
    PrintDavidSqe(sqe, "MIX Task");
    return;
}

static void ConstructDavidAICoreSqeForDavinciTask(TaskInfo* taskInfo, RtArch920xStarsAicAivKernelSqe* const sqe)
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
    ConfigArch920xOstEnable(aicTaskInfo->kernel, sqe);
    PrintDavidSqe(sqe, "AICore Task");
    return;
}

static void ConstructDavidAivSqeForDavinciTask(TaskInfo* taskInfo, RtArch920xStarsAicAivKernelSqe* const sqe)
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
    ConfigArch920xOstEnable(aicTaskInfo->kernel, sqe);
    PrintDavidSqe(sqe, "AIV Task");
    return;
}

static void ConstructArch920xAicAivSqeForDavinciTask(
    TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    UNUSED(sqeInfo);
    RtArch920xStarsAicAivKernelSqe* davidSqe = static_cast<RtArch920xStarsAicAivKernelSqe*>(sqe);
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

static void SetStarsResultByErrorType(TaskInfo* taskInfo, const rtCqReport_t& logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) == 0U) {
        return;
    }
    Stream* const reportStream = GetReportStream(taskInfo->stream);
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC) {
        taskInfo->errorCode = GetStarsV2VectorErrorCode(logicCq);
        COND_PROC(
            CheckErrPrint(taskInfo->errorCode),
            STREAM_REPORT_ERR_MSG(
                reportStream, ERR_MODULE_TBE,
                "Vector Core kernel execution failed, retCode=%#x, nextTaskVld=%u, notifyAttached=%u.",
                taskInfo->errorCode, logicCq.nextTaskVld, logicCq.notifyAttached));
    } else if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        taskInfo->errorCode = GetStarsV2AicpuErrorCode(logicCq);
        COND_PROC(
            CheckErrPrint(taskInfo->errorCode),
            STREAM_REPORT_ERR_MSG(
                reportStream, ERR_MODULE_AICPU, "AI CPU kernel task execution failed, retCode=%#x.",
                taskInfo->errorCode));
    } else {
        taskInfo->errorCode = GetStarsV2AicoreErrorCode(logicCq);
        COND_PROC(
            CheckErrPrint(taskInfo->errorCode),
            STREAM_REPORT_ERR_MSG(
                reportStream, ERR_MODULE_TBE,
                "AI Core kernel task execution failed, retCode=%#x, nextTaskVld=%u, notifyAttached=%u.",
                taskInfo->errorCode, logicCq.nextTaskVld, logicCq.notifyAttached));
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
        .setStarsResultFunc = &SetStarsResultByErrorType,
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

    for (const auto chip : GetArch920xChips()) {
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICPU, aicpuFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AICORE, aicAivFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_KERNEL_AIVEC, aicAivFuncs);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_KERNEL_AICPU, &ConstructDavidAICpuSqeForDavinciTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_KERNEL_AICORE, &ConstructArch920xAicAivSqeForDavinciTask);
        RegDavidSqeFunc(chip, TS_TASK_TYPE_KERNEL_AIVEC, &ConstructArch920xAicAivSqeForDavinciTask);
        RegDavidSqeHeaderPostProcFunc(chip, &ConfigArch920xSqeHeaderTaskProfiling);
    }
    return true;
}

static bool g_davinciKernelTaskRegister = DavinciKernelTaskRegister();

#endif
} // namespace runtime
} // namespace cce
