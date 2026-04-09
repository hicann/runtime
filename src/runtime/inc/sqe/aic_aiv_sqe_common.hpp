/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_AIC_AIV_SQE_COMMON_HPP__
#define __CCE_RUNTIME_AIC_AIV_SQE_COMMON_HPP__

#include "runtime.hpp"
#include "stars_david.hpp"
#include "task_execute_time.h"

namespace cce {
namespace runtime {

inline uint16_t GetSchemMode(const Kernel * const kernel, uint8_t schemMode)
{
    if (schemMode == RT_SCHEM_MODE_END) {
        if (kernel != nullptr) {
            return static_cast<uint16_t>(kernel->GetSchedMode());
        } else {
            return static_cast<uint16_t>(RT_SCHEM_MODE_NORMAL);
        }
    }
    return static_cast<uint16_t>(schemMode);
}

inline void CheckBlockDim(const Stream *const stm, const uint16_t sqeType, const uint16_t blockDim)
{
    rtDevResLimitType_t coreType = RT_DEV_RES_TYPE_MAX;
    if (sqeType == RT_DAVID_SQE_TYPE_AIC) {
        coreType = RT_DEV_RES_CUBE_CORE;
    } else if (sqeType == RT_DAVID_SQE_TYPE_AIV) {
        coreType = RT_DEV_RES_VECTOR_CORE;
    } else {
        return;
    }

    const uint32_t coreNum = stm->Device_()->GetResInitValue(coreType);
    COND_RETURN_VOID_WARN(blockDim > coreNum,
        "blockDim exceeds coreNum, drv deviceId=%u, coreType=%d, blockDim=%hu, coreNum=%u",
        stm->Device_()->Id_(),
        coreType,
        blockDim,
        coreNum);
}

inline void ConfigDieFriendly(const TaskInfo *const taskInfo, RtDavidStarsAicAivKernelSqe * const sqe,
    const Stream * const stm)
{
    sqe->dieFriendly = 1U;
#ifndef CFG_DEV_PLATFORM_PC
    const uint8_t dieNum = stm->Device_()->GetDavidDieNum();
    if (dieNum <= 1U) {
        sqe->dieFriendly = 0U;
    }
#else
    UNUSED(stm);
#endif

    const bool aicTask = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) || (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC);
    uint16_t blkDim = 0U;
    uint16_t groupDim = 0U;
    uint16_t groupBlockDim = 0U;
    if (aicTask) {
        blkDim = taskInfo->u.aicTaskInfo.comm.dim;
        groupDim = taskInfo->u.aicTaskInfo.groupDim;
        groupBlockDim = taskInfo->u.aicTaskInfo.groupBlockDim;
    } else {
        blkDim = taskInfo->u.fusionKernelTask.aicPart.dim;
        groupDim = taskInfo->u.fusionKernelTask.aicPart.groupDim;
        groupBlockDim = taskInfo->u.fusionKernelTask.aicPart.groupBlockDim;
    }

    if (groupDim != 0U) {
        sqe->groupDim = groupDim;
        sqe->groupBlockdim = groupBlockDim;
        sqe->header.blockDim = groupDim * groupBlockDim;
        return;
    }

    sqe->groupDim = static_cast<uint16_t>(sqe->header.blockDim <= 1U ? 1U : 2U);
    const uint16_t value = static_cast<uint16_t>(blkDim / sqe->groupDim);
    sqe->groupBlockdim = (static_cast<uint16_t>(sqe->header.blockDim % sqe->groupDim) == 0U) ? value : (value + 1U);
}

template<typename T>
inline void ConstructAivSqePart(const T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe, uint64_t addr,
    const Stream *const stm)
{
    const uint64_t funcAddr = kernelInfo->funcAddr;
    uint8_t schemMode = kernelInfo->schemMode;
    const Kernel *kernel = kernelInfo->kernel;
    uint32_t prefetchCnt1 = 0U;
    if (kernel != nullptr) {
        prefetchCnt1 = kernel->PrefetchCnt1_();
    }
    sqe->header.type = RT_DAVID_SQE_TYPE_AIV;
    sqe->aicPmg = 0U;
    sqe->aicPartId = 0U;
    sqe->piMix = 0U;
    sqe->aicQos = 0U;
    sqe->aicWrrRd = 0U;
    sqe->aicWrrWr = 0U;
    sqe->aicIcachePrefetchCnt = 0U;
    sqe->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
    sqe->aivPmg = 0U;
    sqe->aivPartId = kernelInfo->partId;
    sqe->res4 = 0U;
    sqe->aivQos = kernelInfo->qos;
    sqe->aivWrrRd = RT_DAVID_AIV_WRR_RD;
    sqe->aivWrrWr = RT_DAVID_AIV_WRR_WR;
    uint16_t curSchemMode = GetSchemMode(kernel, schemMode);
    sqe->schem = curSchemMode;
    if (curSchemMode == RT_SCHEM_MODE_BATCH) {
        const uint16_t sqeType = sqe->header.type;
        const uint16_t blockDim = sqe->header.blockDim;
        CheckBlockDim(stm, sqeType, blockDim);
    }
    sqe->ratio = 1U;
    sqe->aicStartPcLow = 0U;
    sqe->aivStartPcLow = static_cast<uint32_t>(funcAddr);
    sqe->aicStartPcHigh = 0U;
    sqe->aivStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);
    sqe->aivSimtDcuSmSize = kernelInfo->simtDcuSmSize;
    sqe->aicTaskParamPtrLow = 0U;
    sqe->aicTaskParamPtrHigh = 0U;
    sqe->aivTaskParamPtrLow = static_cast<uint32_t>(addr);
    sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
    RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, sqe_schem=%u, ratio=%u, aivSimtDcuSmSize=%u.",
        schemMode, sqe->schem, sqe->ratio, sqe->aivSimtDcuSmSize);
}

template<typename T>
inline void ConstructCommonAicAivSqePart(const T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe,
    const TaskInfo *taskInfo, const Stream *const stm)
{
    const Kernel *kernelPtr = taskInfo->u.aicTaskInfo.kernel;
    uint32_t minStackSize = 0U;
    if (kernelPtr != nullptr) {
        minStackSize = kernelPtr->GetMinStackSize1();
    }
    if (((kernelInfo->kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) ||
        (stm->IsDebugRegister() && (!stm->GetBindFlag()))) {
        sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqe->header.blockDim = kernelInfo->dim;

    ConfigDieFriendly(taskInfo, sqe, stm);
    sqe->kernelCredit = static_cast<uint8_t>(GetAicoreKernelCredit(taskInfo->u.aicTaskInfo.timeout));
    sqe->mix = 0U;
    sqe->loose = 1U;
    sqe->sqeLength = 0U;

    if ((!stm->GetBindFlag()) && (Runtime::Instance()->GetBiuperfProfFlag())) {
        if (sqe->header.postP == RT_STARS_SQE_INT_DIR_TO_TSCPU) {
            RT_LOG(RT_LOG_WARNING, "post-p has already be set, service scenarios conflict.");
        } else {
            sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->featureFlag = static_cast<uint8_t>(sqe->featureFlag | SQE_BIZ_FLAG_BIUPERF);
        }
    }

    if ((kernelInfo->kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        if (stm->IsOverflowEnable()) {
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        }
        sqe->featureFlag = static_cast<uint8_t>(sqe->featureFlag | SQE_BIZ_FLAG_DATADUMP);
    }

    if (Runtime::Instance()->GetL2CacheProfFlag()) {
        sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        sqe->featureFlag = static_cast<uint8_t>(sqe->featureFlag | SQE_BIZ_FLAG_L2CACHE);
    }

    RT_LOG(RT_LOG_INFO, "sqe dieFriendly=%u, blockdim=%u, groupDim=%u, groupBlockDim=%u, featureFlag=%u.",
        sqe->dieFriendly, sqe->header.blockDim, sqe->groupDim, sqe->groupBlockdim, sqe->featureFlag);
    uint64_t stackPhyBase = RtPtrToValue(stm->Device_()->GetStackPhyBase32k());
    if (unlikely(minStackSize > KERNEL_STACK_SIZE_32K)) {
        stackPhyBase = RtPtrToValue(stm->Device_()->GetCustomerStackPhyBase());
        const uint32_t stackLevel = stm->Device_()->GetDeviceCustomerStackLevel();
        sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0x000FFFFFU) | (stackLevel << 20U);
        sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0x000FFFFFU) | (stackLevel << 20U);
    }
    sqe->stackPhyBaseLow = static_cast<uint32_t>(stackPhyBase);
    sqe->stackPhyBaseHigh = static_cast<uint32_t>(stackPhyBase >> UINT32_BIT_NUM);
}

template<typename T>
inline void ConstructMixSqePart(T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe, uint64_t addr)
{
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    const uint64_t funcAddr = kernelInfo->funcAddr;
    const uint64_t funcAddr2 = kernelInfo->funcAddr1;
    uint32_t prefetchCnt1 = 0U;
    uint32_t prefetchCnt2 = 0U;
    if (kernelInfo->kernel != nullptr) {
        mixType = kernelInfo->kernel->GetMixType();
        prefetchCnt1 = kernelInfo->kernel->PrefetchCnt1_();
        prefetchCnt2 = kernelInfo->kernel->PrefetchCnt2_();
    }
    sqe->mix = 0U;
    sqe->piMix = 0U;
    sqe->aivSimtDcuSmSize = kernelInfo->simtDcuSmSize;
    switch (mixType) {
        case MIX_AIC:
            sqe->aicPmg = 0U;
            sqe->aicPartId = kernelInfo->partId;
            sqe->aicQos = kernelInfo->qos;
            sqe->aicWrrRd = RT_DAVID_AIC_WRR_RD;
            sqe->aicWrrWr = RT_DAVID_AIC_WRR_WR;
            sqe->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
            sqe->aivIcachePrefetchCnt = 0U;
            sqe->aivPmg = 0U;
            sqe->aivPartId = 0U;
            sqe->res4 = 0U;
            sqe->aivQos = 0U;
            sqe->aivWrrRd = 0U;
            sqe->aivWrrWr = 0U;
            sqe->aicStartPcLow = static_cast<uint32_t>(funcAddr);
            sqe->aivStartPcLow = 0U;
            sqe->aicStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);
            sqe->aivStartPcHigh = 0U;
            sqe->aicTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            sqe->aivTaskParamPtrLow = 0U;
            sqe->aivTaskParamPtrHigh = 0U;
            break;
        case MIX_AIV:
            sqe->aicPmg = 0U;
            sqe->aicPartId = 0U;
            sqe->aicQos = 0U;
            sqe->aicWrrRd = 0U;
            sqe->aicWrrWr = 0U;
            sqe->aicIcachePrefetchCnt = 0U;
            sqe->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
            sqe->aivPmg = 0U;
            sqe->aivPartId = kernelInfo->partId;
            sqe->res4 = 0U;
            sqe->aivQos = kernelInfo->qos;
            sqe->aivWrrRd = RT_DAVID_AIV_WRR_RD;
            sqe->aivWrrWr = RT_DAVID_AIV_WRR_WR;
            sqe->aicStartPcLow = 0U;
            sqe->aivStartPcLow = static_cast<uint32_t>(funcAddr);
            sqe->aicStartPcHigh = 0U;
            sqe->aivStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);
            sqe->aicTaskParamPtrLow = 0U;
            sqe->aicTaskParamPtrHigh = 0U;
            sqe->aivTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            break;
        case MIX_AIC_AIV_MAIN_AIC:
        case MIX_AIC_AIV_MAIN_AIV:
            sqe->mix = 1U;
            sqe->aicPmg = 0U;
            sqe->aicPartId = kernelInfo->partId;
            sqe->piMix = 1U;
            sqe->aicQos = kernelInfo->qos;
            sqe->aicWrrRd = RT_DAVID_AIC_WRR_RD;
            sqe->aicWrrWr = RT_DAVID_AIC_WRR_WR;
            sqe->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
            sqe->aivIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt2);
            sqe->aivPmg = 0U;
            sqe->aivPartId = kernelInfo->partId;
            sqe->res4 = 0U;
            sqe->aivQos = kernelInfo->qos;
            sqe->aivWrrRd = RT_DAVID_AIV_WRR_RD;
            sqe->aivWrrWr = RT_DAVID_AIV_WRR_WR;
            sqe->aicStartPcLow = static_cast<uint32_t>(funcAddr & MASK_32_BIT);
            sqe->aivStartPcLow = static_cast<uint32_t>(funcAddr2 & MASK_32_BIT);
            sqe->aicStartPcHigh = static_cast<uint16_t>((funcAddr >> UINT32_BIT_NUM) & MASK_32_BIT);
            sqe->aivStartPcHigh = static_cast<uint16_t>((funcAddr2 >> UINT32_BIT_NUM) & MASK_32_BIT);
            sqe->aicTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            sqe->aivTaskParamPtrLow = static_cast<uint32_t>(addr);
            sqe->aivTaskParamPtrHigh = (sqe->aivTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
            break;
        default:
            RT_LOG(RT_LOG_ERROR, "DavinciKernelTask mix error. ");
            return;
    }
}

template<typename T>
inline void ConstructAicSqePart(T * const kernelInfo, RtDavidStarsAicAivKernelSqe * const sqe, uint64_t addr,
    const Stream *const stm)
{
    uint8_t schemMode = kernelInfo->schemMode;
    const Kernel *kernel = kernelInfo->kernel;
    const uint64_t funcAddr = kernelInfo->funcAddr;
    uint32_t prefetchCnt1 = 0U;
    if (kernel != nullptr) {
        prefetchCnt1 = kernel->PrefetchCnt1_();
    }
    sqe->header.type = RT_DAVID_SQE_TYPE_AIC;
    sqe->aicPmg = 0U;
    sqe->aicPartId = kernelInfo->partId;
    sqe->piMix = 0U;
    sqe->aicQos = kernelInfo->qos;
    sqe->aicWrrRd = RT_DAVID_AIC_WRR_RD;
    sqe->aicWrrWr = RT_DAVID_AIC_WRR_WR;
    sqe->aicIcachePrefetchCnt = static_cast<uint16_t>(prefetchCnt1);
    sqe->aivIcachePrefetchCnt = 0U;
    sqe->aivPmg = 0U;
    sqe->aivPartId = 0U;
    sqe->res4 = 0U;
    sqe->aivQos = 0U;
    sqe->aivWrrRd = 0U;
    sqe->aivWrrWr = 0U;
    uint16_t curSchemMode = GetSchemMode(kernel, schemMode);
    sqe->schem = curSchemMode;
    if (curSchemMode == RT_SCHEM_MODE_BATCH) {
        const uint16_t sqeType = sqe->header.type;
        const uint16_t blockDim = sqe->header.blockDim;
        CheckBlockDim(stm, sqeType, blockDim);
    }
    sqe->ratio = 1U;
    sqe->aicStartPcLow = static_cast<uint32_t>(funcAddr);
    sqe->aivStartPcLow = 0U;
    sqe->aicStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);
    sqe->aivStartPcHigh = 0U;
    sqe->aivSimtDcuSmSize = kernelInfo->simtDcuSmSize;
    sqe->aicTaskParamPtrLow = static_cast<uint32_t>(addr);
    sqe->aicTaskParamPtrHigh = (sqe->aicTaskParamPtrHigh & 0xFFF00000U) | static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
    sqe->aivTaskParamPtrLow = 0U;
    sqe->aivTaskParamPtrHigh = 0U;
    RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, sqe_schem=%u, ratio=%u, aivSimtDcuSmSize=%u.",
        schemMode, sqe->schem, sqe->ratio, sqe->aivSimtDcuSmSize);
}

}  // namespace runtime
}  // namespace cce

#endif // __CCE_RUNTIME_AIC_AIV_SQE_COMMON_HPP__
