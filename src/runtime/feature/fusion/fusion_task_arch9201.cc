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
#include "runtime_task_manager.h"
#include "aic_aiv_sqe_common.hpp"
#include "ccu_sqe.hpp"
#include "arch9201/aic_aiv_sqe.h"
#include "arch9201/arch9201_sqe_utils.hpp"

namespace cce {
namespace runtime {

static void ConstructArch9201SqeHeadForFusionTask(
    const TaskInfo* taskInfo, RtArch9201StarsAicAivKernelSqe* const davidSqe)
{
    const Stream* const stream = taskInfo->stream;
    (void)memset_s(davidSqe, sizeof(RtArch9201StarsAicAivKernelSqe), 0, sizeof(RtArch9201StarsAicAivKernelSqe));
    davidSqe->header.wrCqe = stream->GetStarsWrCqeFlag();
    davidSqe->header.taskId = taskInfo->taskSn;
    ConfigArch9201SqeHeaderTaskProfiling(&(davidSqe->header));
}

static void ConstructArch9201CommonSqeForFusionTask(const TaskInfo* taskInfo, RtArch9201StarsAicAivKernelSqe* const sqe)
{
    Stream* const stm = taskInfo->stream;
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const FusionTaskInfoAicPart* aicPart = &(fusionKernelTask->aicPart);
    ConstructArch9201SqeHeadForFusionTask(taskInfo, sqe);
    ConstructCommonAicAivSqeWord(aicPart, sqe, taskInfo, stm);

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

static void ConstructMixSubSqe(
    const TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    Stream* const stm = taskInfo->stream;
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const FusionTaskInfoAicPart* aicPart = &(fusionKernelTask->aicPart);

    RtArch9201StarsAicAivKernelSqe* sqe = static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(sqeAddr));
    ConstructArch9201CommonSqeForFusionTask(taskInfo, sqe);

    uint8_t taskRation = 0U;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    const Kernel* kernel = aicPart->kernel;
    if (kernel != nullptr) {
        taskRation = static_cast<uint8_t>(kernel->GetTaskRation());
        mixType = kernel->GetMixType();
    }

    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    ConstructMixSqePart(aicPart, sqe, mixType, addr, stm);

    sqe->ratio = 1U;
    if (sqe->mix == 1U) {
        sqe->ratio = taskRation;
        static const uint32_t defaultTaskRatio = Runtime::Instance()->GetCurChipProperties().defaultTaskRatio;
        if ((sqe->header.type == RT_DAVID_SQE_TYPE_AIC) && (sqe->ratio == defaultTaskRatio)) {
            sqe->loose = 0U;
        }
    }
    /* dcache preload cnt */
    GetDcachePrefetchCnt(taskInfo, sqe);
    ConfigArch9201OstEnable(aicPart->kernel, sqe);
    RT_LOG(
        RT_LOG_INFO,
        "sqeIndex=%u, mixType=%u, cfgInfo schemMode=%u, sqe_schem=%hu, ratio=%hhu, loose=%u, piMix=%u, "
        "aivSimtDcuSmSize=%u.",
        idx, mixType, aicPart->schemMode, sqe->schem, sqe->ratio, sqe->loose, sqe->piMix, sqe->aivSimtDcuSmSize);

    PrintDavidSqe(sqe, "FusionKernelTask-Mix");
}

static void ConstructAicSubSqe(
    const TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    RtArch9201StarsAicAivKernelSqe* sqe = static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(sqeAddr));
    ConstructArch9201CommonSqeForFusionTask(taskInfo, sqe);

    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    Stream* const stm = taskInfo->stream;
    ConstructAicSqePart(&(fusionKernelTask->aicPart), sqe, addr, stm);
    sqe->aicPreAllocateDisable = 0U;
    sqe->aivPreAllocateDisable = 1U;
    /* dcache preload cnt */
    GetDcachePrefetchCnt(taskInfo, sqe);
    ConfigArch9201OstEnable(fusionKernelTask->aicPart.kernel, sqe);
    PrintDavidSqe(sqe, "FusionKernelTask-Aic");
}

static void ConstructAivSubSqe(
    const TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    RtArch9201StarsAicAivKernelSqe* sqe = static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(sqeAddr));
    ConstructArch9201CommonSqeForFusionTask(taskInfo, sqe);

    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    Stream* const stm = taskInfo->stream;
    ConstructAivSqePart(&(fusionKernelTask->aicPart), sqe, addr, stm);
    sqe->aicPreAllocateDisable = 1U;
    sqe->aivPreAllocateDisable = 0U;
    /* dcache preload cnt */
    GetDcachePrefetchCnt(taskInfo, sqe);
    ConfigArch9201OstEnable(fusionKernelTask->aicPart.kernel, sqe);
    PrintDavidSqe(sqe, "FusionKernelTask-Aiv");
}

static void UpdateArch9201HeaderForFusionKernel(
    const TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, const uint32_t sqeIndex, const uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeHeadAddr = &davidSqe[0];
    rtDavidSqe_t* sqeAixAddr = &davidSqe[sqeIndex];
    if (sqBaseAddr != 0ULL) {
        sqeHeadAddr = GetSqPosAddr(sqBaseAddr, static_cast<uint32_t>(taskInfo->id));
        sqeAixAddr = GetSqPosAddr(sqBaseAddr, static_cast<uint32_t>(taskInfo->id) + sqeIndex);
    }
    rtDavidStarsCommonSqe_t* sqeHead = &(sqeHeadAddr->commonSqe);
    RtArch9201StarsAicAivKernelSqe* sqeAix =
        static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(sqeAixAddr));
    if ((sqeAix->featureFlag & SQE_BIZ_FLAG_DATADUMP) != 0U) {
        sqeHead->sqeHeader.preP = sqeAix->header.preP;
        sqeHead->sqeHeader.postP = sqeAix->header.postP;
        RT_LOG(RT_LOG_DEBUG, "preP=%u, postP=%u", sqeHead->sqeHeader.preP, sqeHead->sqeHeader.postP);
    }

    if ((sqeHead->sqeHeader.preP == 0U) && (sqeHead->sqeHeader.postP == 0U) && (sqeAix->ost == 1U)) {
        RtArch9201StarsAicAivKernelSqe* const firstSqe =
            static_cast<RtArch9201StarsAicAivKernelSqe*>(static_cast<void*>(sqeHeadAddr));
        firstSqe->ost = 1U;
        RT_LOG(RT_LOG_DEBUG, "ost=%u", firstSqe->ost);
    }
    return;
}

static void ConstructAicAivSubSqe(
    const TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint32_t& sqeIndex, const uint64_t sqBaseAddr)
{
    const FusionTaskInfoAicPart* aicPart = &(taskInfo->u.fusionKernelTask.aicPart);
    const uint8_t mixType = (aicPart->kernel != nullptr) ? aicPart->kernel->GetMixType() : static_cast<uint8_t>(NO_MIX);
    if (mixType != static_cast<uint8_t>(NO_MIX)) {
        ConstructMixSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
    } else {
        if (taskInfo->u.fusionKernelTask.aicAivType == 0) {
            ConstructAicSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
        } else {
            ConstructAivSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
        }
    }
    RT_LOG(
        RT_LOG_INFO, "sqeIndex=%u, mixType=%hhu, aicAivType=%hhu.", sqeIndex, mixType,
        taskInfo->u.fusionKernelTask.aicAivType);

    UpdateArch9201HeaderForFusionKernel(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
    sqeIndex++;
}

void ConstructArch9201SqeForFusionKernelTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
{
    rtDavidSqe_t* const davidSqe = static_cast<rtDavidSqe_t*>(sqe);
    uint64_t sqBaseAddr = sqeInfo.sqBaseAddr;
    rtError_t error = RT_ERROR_NONE;
    FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    rtFunsionTaskInfo_t* const fusionKernelInfo = static_cast<rtFunsionTaskInfo_t*>(fusionKernelTask->fusionKernelInfo);
    uint32_t aicpuIndex = 0U;
    uint32_t sqeIndex = 0U;

    for (uint32_t idx = 0U; idx < fusionKernelInfo->subTaskNum; idx++) {
        switch (fusionKernelInfo->subTask[idx].type) {
            case RT_FUSION_AICORE:
                ConstructAicAivSubSqe(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
                break;
            case RT_FUSION_AICPU:
            case RT_FUSION_HCOM_CPU:
                ConstructAicpuSubSqe(taskInfo, davidSqe, sqeIndex, aicpuIndex, idx, sqBaseAddr);
                aicpuIndex++;
                break;
            case RT_FUSION_CCU:
                error = ConstructCcuSubSqe(taskInfo, davidSqe, sqeIndex, idx, sqBaseAddr);
                break;
            default:
                break;
        }
        if (error != RT_ERROR_NONE) {
            davidSqe->commonSqe.sqeHeader.type = RT_DAVID_SQE_TYPE_INVALID;
            RT_LOG(RT_LOG_ERROR, "Fusion kernel sqe proc failed, ret=%#x.", error);
        }
    }
    RT_LOG(
        RT_LOG_INFO, "FusionTask, device_id=%u, stream_id=%d, task_id=%hu, task_sn=%u, sub_type=%hhu.",
        taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id, taskInfo->taskSn,
        fusionKernelTask->sqeSubType);
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

    RegTaskFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_FUSION_KERNEL, funcs);
    RegDavidSqeFunc(CHIP_CLOUD_V5, TS_TASK_TYPE_FUSION_KERNEL, &ConstructArch9201SqeForFusionKernelTask);
    return true;
}

static bool g_fusionKernelTaskRegister = FusionKernelTaskRegister();

} // namespace runtime
} // namespace cce
