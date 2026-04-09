/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "fusion_sqe.hpp"
#include "runtime.hpp"
#include "ccu_sqe.hpp"
#include "aic_aiv_sqe_common.hpp"

namespace cce {
namespace runtime {

static void ConstructCommonAicAivSubSqe(const TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe)
{
    RtDavidStarsAicAivKernelSqe* sqe = &(davidSqe->aicAivSqe);
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    Stream* const stm = taskInfo->stream;
    ConstructCommonAicAivSqePart(&(fusionKernelTask->aicPart), sqe, taskInfo, stm);
}

static void ConstructAicSubSqe(
    const TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    ConstructCommonAicAivSubSqe(taskInfo, sqeAddr);

    RtDavidStarsAicAivKernelSqe* sqe = &(sqeAddr->aicAivSqe);
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    Stream* const stm = taskInfo->stream;
    ConstructAicSqePart(&(fusionKernelTask->aicPart), sqe, addr, stm);

    PrintDavidSqe(sqeAddr, "FusionKernelTask-Aic");
}

static void ConstructAivSubSqe(
    const TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    ConstructCommonAicAivSubSqe(taskInfo, sqeAddr);
    RtDavidStarsAicAivKernelSqe* sqe = &(sqeAddr->aicAivSqe);
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    Stream* const stm = taskInfo->stream;
    ConstructAivSqePart(&(fusionKernelTask->aicPart), sqe, addr, stm);

    PrintDavidSqe(sqeAddr, "FusionKernelTask-Aiv");
}

static void SetMixStartPcAndParamForFusionKernel(const TaskInfo* taskInfo, rtDavidSqe_t* const davidSqe)
{
    RtDavidStarsAicAivKernelSqe* sqe = &(davidSqe->aicAivSqe);
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const uint64_t addr = RtPtrToValue(fusionKernelTask->args);
    ConstructMixSqePart(&(fusionKernelTask->aicPart), sqe, addr);
}

static void ConstructMixSubSqe(
    const TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint32_t idx, uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeAddr = &davidSqe[idx];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + idx;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    ConstructCommonAicAivSubSqe(taskInfo, sqeAddr);

    RtDavidStarsAicAivKernelSqe* sqe = &(sqeAddr->aicAivSqe);
    Stream* const stm = taskInfo->stream;
    const FusionTaskInfo* const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    const FusionTaskInfoAicPart* aicPart = &(fusionKernelTask->aicPart);
    uint8_t taskRation = 0U;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint8_t schemMode = aicPart->schemMode;
    const Kernel* kernel = aicPart->kernel;
    if (kernel != nullptr) {
        taskRation = static_cast<uint8_t>(kernel->GetTaskRation());
        mixType = kernel->GetMixType();
    }

    if ((mixType == static_cast<uint8_t>(MIX_AIC)) || (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC))) {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIC;
    } else {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIV;
    }

    SetMixStartPcAndParamForFusionKernel(taskInfo, sqeAddr);

    uint16_t curSchemMode = GetSchemMode(kernel, schemMode);
    sqe->schem = curSchemMode;
    if (curSchemMode == RT_SCHEM_MODE_BATCH) {
        const uint16_t sqeType = sqe->header.type;
        const uint16_t blockDim = sqe->header.blockDim;
        CheckBlockDim(stm, sqeType, blockDim);
    }
    sqe->ratio = 1U;
    if (sqe->mix == 1U) {
        sqe->ratio = taskRation;
        if ((sqe->header.type == RT_DAVID_SQE_TYPE_AIC) && (sqe->ratio == DEFAULT_TASK_RATION)) {
            sqe->loose = 0U;
        }
    }
    RT_LOG(
        RT_LOG_INFO,
        "sqeIndex=%u, mixType=%u, cfgInfo schemMode=%u, sqe_schem=%hu, ratio=%hhu, loose=%u, piMix=%u, "
        "aivSimtDcuSmSize=%u.",
        idx, mixType, schemMode, sqe->schem, sqe->ratio, sqe->loose, sqe->piMix, sqe->aivSimtDcuSmSize);

    PrintDavidSqe(sqeAddr, "FusionKernelTask-Mix");
}

static void UpdateHeaderForFusionKernel(
    const TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, const uint32_t sqeIndex, const uint64_t sqBaseAddr)
{
    rtDavidSqe_t* sqeHeadAddr = &davidSqe[0];
    rtDavidSqe_t* sqeAixAddr = &davidSqe[sqeIndex];
    if (sqBaseAddr != 0ULL) {
        sqeHeadAddr = GetSqPosAddr(sqBaseAddr, static_cast<uint32_t>(taskInfo->id));
        sqeAixAddr = GetSqPosAddr(sqBaseAddr, static_cast<uint32_t>(taskInfo->id) + sqeIndex);
    }
    rtDavidStarsCommonSqe_t* sqeHead = &(sqeHeadAddr->commonSqe);
    RtDavidStarsAicAivKernelSqe* sqeAix = &(sqeAixAddr->aicAivSqe);
    if ((sqeAix->featureFlag & SQE_BIZ_FLAG_DATADUMP) == 0U) {
        return;
    }
    sqeHead->sqeHeader.preP = sqeAix->header.preP;
    sqeHead->sqeHeader.postP = sqeAix->header.postP;
    PrintDavidSqe(sqeHeadAddr, "FusionKernelTask-FirstSqe");
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

    UpdateHeaderForFusionKernel(taskInfo, davidSqe, sqeIndex, sqBaseAddr);
    sqeIndex++;
}

void ConstructDavidSqeForFusionKernelTask(TaskInfo* const taskInfo, rtDavidSqe_t* const davidSqe, uint64_t sqBaseAddr)
{
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

} // namespace runtime
} // namespace cce
