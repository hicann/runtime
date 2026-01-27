/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stream.hpp"
#include "runtime.hpp"
#include "event_david.hpp"
#include "task_manager.h"
#include "stars.hpp"
#include "stars_david.hpp"
#include "device.hpp"
#include "task_info.h"
#include "error_code.h"
#include "task_execute_time.h"
namespace cce {
namespace runtime {

static void ConstructDavidAICpuSqeForDavinciTaskResField(AicpuTaskInfo *const aicpuTaskInfo, rtDavidSqe_t *const davidSqe,
    const Stream * const stm, const uint8_t kernelFlag)
{
    RtDavidStarsAicpuKernelSqe *const sqe = &(davidSqe->aicpuSqe);

    /* word4-5 */
    uint64_t addr = RtPtrToValue(aicpuTaskInfo->soName);
    sqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    sqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    /* word6-7 */
    const uint8_t *tmpAddr = RtPtrToPtr<const uint8_t *, void *>(aicpuTaskInfo->comm.args);
    const void *paramAddr = tmpAddr + aicpuTaskInfo->headParamOffset;
    addr = RtPtrToValue(paramAddr);
    sqe->paramAddrLow = static_cast<uint32_t>(addr);
    sqe->paramAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);
    // for kfcArgsFmtOffset, A1算子目前不用，先赋默认值
    sqe->res5 = 0xFFFFU;

    /* word8-9 */
    addr = RtPtrToValue(aicpuTaskInfo->funcName);
    sqe->taskNameStrPtrLow = static_cast<uint32_t>(addr);
    sqe->taskNameStrPtrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    /* word10-11 */
    sqe->pL2ctrlLow = 0U;
    sqe->pL2ctrlHigh = 0U;
    sqe->overflowEn = stm->IsOverflowEnable();
    sqe->dumpEn = 0U;
    if ((kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        sqe->dumpEn = 1U; // 1: aicpu dump enable
        sqe->kernelCredit = RT_STARS_ADJUST_KERNEL_CREDIT;
    }
    sqe->debugDumpEn = 0U;
    if (stm->IsDebugRegister() && stm->GetBindFlag()) {
        sqe->debugDumpEn = 1U;
    }

    return;
}

void ConstructDavidAICpuSqeForDavinciTaskBase(TaskInfo *const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsAicpuKernelSqe *const sqe = &(davidSqe->aicpuSqe);

    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    Stream * const stm = taskInfo->stream;

    /* word0-1 */
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_H;    // modified by kernelFlag
    if (stm->IsDebugRegister() && (!stm->GetBindFlag())) {
        sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.blockDim = aicpuTaskInfo->comm.dim;

    /* word2 */
    sqe->kernelType = static_cast<uint16_t>(aicpuTaskInfo->aicpuKernelType);
    sqe->batchMode = 0U;

    const uint8_t kernelFlag = aicpuTaskInfo->comm.kernelFlag;
    if ((kernelFlag & RT_KERNEL_HOST_FIRST) == RT_KERNEL_HOST_FIRST) {
        sqe->topicType = TOPIC_TYPE_HOST_AICPU_FIRST;
    } else if ((kernelFlag & RT_KERNEL_HOST_ONLY) == RT_KERNEL_HOST_ONLY) {
        sqe->topicType = TOPIC_TYPE_HOST_AICPU_ONLY;
    } else if ((kernelFlag & RT_KERNEL_DEVICE_FIRST) == RT_KERNEL_DEVICE_FIRST) {
        sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
        sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_FIRST;
    } else {
        sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
        sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_ONLY;
    }

    // MC2走fusion的A1算子流程
    if ((stm->Device_()->IsSupportHcomcpu() == 1U) && (sqe->kernelType == KERNEL_TYPE_AICPU_KFC)
        && (aicpuTaskInfo->comm.dim == 1U)) {
        sqe->header.type = RT_DAVID_SQE_TYPE_FUSION;
        sqe->resv.fusionSubTypeDesc.subType = 1U;
    }

    sqe->qos = GetAICpuQos(taskInfo);

    /* word3 */
    sqe->sqeIndex = 0U; // useless
    const bool isSupportTimeout =
        ((sqe->kernelType == KERNEL_TYPE_AICPU_KFC) || (sqe->kernelType == KERNEL_TYPE_CUSTOM_KFC));
    const bool isNeedNoTimeout = ((aicpuTaskInfo->timeout > RUNTIME_DAVINCI_MAX_TIMEOUT) && isSupportTimeout) ||
        (aicpuTaskInfo->timeout == MAX_UINT64_NUM);
    sqe->kernelCredit = isNeedNoTimeout ? RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT :
                        static_cast<uint8_t>(GetAicpuKernelCredit(aicpuTaskInfo->timeout));
    sqe->sqeLength = 0U;

    /* words4-13 use reserved field */
    /* word4-11 */
    ConstructDavidAICpuSqeForDavinciTaskResField(aicpuTaskInfo, davidSqe, stm, kernelFlag);

    /* word12-13 */
    sqe->extraFieldLow = taskInfo->taskSn;  // send task id info to aicpu
    sqe->extraFieldHigh = 0U;

    /* word14 */
    sqe->subTopicId = 0U;
    sqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    sqe->groupId = 0U;
    sqe->usrDataLen = 40U; /* size: word4-13 */

    /* word15 */
    sqe->destPid = 0U;

    return;
}

static void ConstructAicpuSubSqeResField(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, const Stream * const stm,
    const uint32_t kernelFlag, uint32_t aicpuIndex)
{
    FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    RtDavidStarsAicpuKernelSqe *const sqe = &(davidSqe->aicpuSqe);

    /* word4-5 */
    uint64_t addr = RtPtrToValue(fusionKernelTask->aicpuArgsDesc[aicpuIndex].soName);
    sqe->taskSoAddrLow = static_cast<uint32_t>(addr);
    sqe->taskSoAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    /* word6-7 */
    addr = RtPtrToValue(fusionKernelTask->args);
    sqe->paramAddrLow = static_cast<uint32_t>(addr);
    sqe->paramAddrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);
    sqe->res5 = fusionKernelTask->argsInfo->aicpuArgs[aicpuIndex].kfcArgsFmtOffset;

    /* word8-9 */
    addr = RtPtrToValue(fusionKernelTask->aicpuArgsDesc[aicpuIndex].funcName);
    sqe->taskNameStrPtrLow = static_cast<uint32_t>(addr);
    sqe->taskNameStrPtrHigh = static_cast<uint16_t>(addr >> UINT32_BIT_NUM);

    /* word10-11 */
    sqe->pL2ctrlLow = 0U;
    sqe->pL2ctrlHigh = 0U;
    sqe->overflowEn = stm->IsOverflowEnable();
    sqe->dumpEn = 0U;
    if ((kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        sqe->dumpEn = 1U; // 1: aicpu dump enable
        sqe->kernelCredit = RT_STARS_ADJUST_KERNEL_CREDIT;
    }
    sqe->debugDumpEn = 0U;
    if (stm->IsDebugRegister() && stm->GetBindFlag()) {
        sqe->debugDumpEn = 1U;
    }

    /* word12-13 */
    sqe->extraFieldLow = taskInfo->taskSn;  // send task id info to aicpu
    sqe->extraFieldHigh = 0U;

    return;
}

void ConstructAicpuSubSqeBase(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint32_t &sqeIndex,
    uint32_t aicpuIndex, uint32_t taskIdx, uint64_t sqBaseAddr)
{
    FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    rtFunsionTaskInfo_t * const fusionKernelInfo =
        RtPtrToPtr<rtFunsionTaskInfo_t *>(RtPtrToUnConstPtr<void *>(fusionKernelTask->fusionKernelInfo));
    rtDavidSqe_t *sqeAddr = &davidSqe[sqeIndex];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + sqeIndex;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    RtDavidStarsAicpuKernelSqe * const sqe = &(sqeAddr->aicpuSqe);
    Stream * const stm = taskInfo->stream;
    const uint16_t aicpuKernelType = static_cast<uint16_t>(fusionKernelInfo->subTask[taskIdx].task.aicpuInfo.kernelType);
    const uint32_t kernelFlag = fusionKernelInfo->subTask[taskIdx].task.aicpuInfo.flags;

    /* word0-1 */
    sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_H;
    sqe->header.blockDim = static_cast<uint16_t>(fusionKernelInfo->subTask[taskIdx].task.aicpuInfo.blockDim);

    /* word2 */
    sqe->kernelType = aicpuKernelType;
    sqe->batchMode = 0U;

    if ((kernelFlag & RT_KERNEL_HOST_FIRST) == RT_KERNEL_HOST_FIRST) {
        sqe->topicType = TOPIC_TYPE_HOST_AICPU_FIRST;
    } else if ((kernelFlag & RT_KERNEL_HOST_ONLY) == RT_KERNEL_HOST_ONLY) {
        sqe->topicType = TOPIC_TYPE_HOST_AICPU_ONLY;
    } else if ((kernelFlag & RT_KERNEL_DEVICE_FIRST) == RT_KERNEL_DEVICE_FIRST) {
        sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
        sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_FIRST;
    } else {
        sqe->header.type = RT_DAVID_SQE_TYPE_AICPU_D;
        sqe->topicType = TOPIC_TYPE_DEVICE_AICPU_ONLY;
    }

    sqe->sqeLength = 0U;
    sqe->kernelCredit = static_cast<uint8_t>(GetAicpuKernelCredit(0UL));
    sqe->qos = taskInfo->stream->Device_()->GetTsdQos();

    /* word3 */
    sqe->sqeIndex = 0U; // useless

    /* words4-13 use reserved field */
    /* words4-13 */
    ConstructAicpuSubSqeResField(taskInfo, sqeAddr, stm, kernelFlag, aicpuIndex);

    /* word14 */
    sqe->subTopicId = 0U;
    sqe->topicId = 3U; // EVENT_TS_HWTS_KERNEL
    sqe->groupId = 0U;
    sqe->usrDataLen = 40U; /* size: word4-13 */

    /* word15 */
    sqe->destPid = 0U;

    if (taskIdx == 0) {
        sqe->header.type = RT_DAVID_SQE_TYPE_FUSION;
        sqe->resv.fusionSubTypeDesc.subType = fusionKernelTask->sqeSubType;
        sqe->resv.fusionSubTypeDesc.aic = fusionKernelTask->aicAivType;
        sqe->sqeLength = fusionKernelTask->sqeLen - 1U;
        sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    }

    RT_LOG(RT_LOG_INFO, "taskIdx=%u, sqeIndex=%u, aicpuIndex=%u, kfcArgsFmtOffset=%hu, kernelFlag=%u, aicpuKernelType=%hu.",
        taskIdx, sqeIndex, aicpuIndex, sqe->res4, kernelFlag, aicpuKernelType);

    return;
}

}  // namespace runtime
}  // namespace cce