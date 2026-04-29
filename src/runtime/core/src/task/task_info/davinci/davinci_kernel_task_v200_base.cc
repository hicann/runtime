/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "davinci_kernel_task.h"
#include "stream_david.hpp"
#include "task_scheduler_error.h"
#include "task_manager.h"
#include "device_error_proc.hpp"
#include "runtime.hpp"
#include "event_david.hpp"
#include "stars.hpp"
#include "stars_david.hpp"
#include "task_info.h"
#include "device.hpp"
#include "error_code.h"
#include "thread_local_container.hpp"
#include "aic_aiv_sqe_common.hpp"

namespace cce {
namespace runtime {

#if F_DESC("DavinciKernelTask")

void ConstructDavidAICpuSqeForDavinciTaskResFieldPart(RtDavidStarsAicpuKernelSqe *const sqe, const uint64_t addr,
                                                             const uint8_t kernelFlag, const Stream * const stm)
{
    /* word8-9 */
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

    /* word8-11 */
    addr = RtPtrToValue(aicpuTaskInfo->funcName);
    ConstructDavidAICpuSqeForDavinciTaskResFieldPart(sqe, addr, kernelFlag, stm);
    return;
}

void FillTopicType(RtDavidStarsAicpuKernelSqe * const sqe, const uint32_t kernelFlag)
{
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
    FillTopicType(sqe, kernelFlag);

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

void StarsV2DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    Stream * const stream = taskInfo->stream;

    PreCheckTaskErr(taskInfo, devId);

    if ((errorCode != TS_ERROR_AICORE_OVERFLOW) && (errorCode != TS_ERROR_AIVEC_OVERFLOW) &&
        (errorCode != TS_ERROR_AICPU_OVERFLOW) && (errorCode != TS_ERROR_SDMA_OVERFLOW) && (errorCode != 0U)) {
        TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, errorCode, stream->Device_());
    }
}

void StarsV2DavinciTaskUnInit(TaskInfo *taskInfo)
{
    if ((taskInfo->stream != nullptr) && (taskInfo->stream->Context_() != nullptr)) {
        static_cast<DavidStream *>(taskInfo->stream)->ArgReleaseSingleTask(taskInfo, true);
    }
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
        aicpuTaskInfo->comm.args = nullptr;
        aicpuTaskInfo->funcName = nullptr;
        DELETE_O(aicpuTaskInfo->kernel);
    } else {
        AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
        aicTaskInfo->comm.args = nullptr;
    }
}

static void MapAicpuErrorCodeForFastRecovery(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    taskInfo->errorCode = TS_ERROR_AICPU_EXCEPTION;
    Stream * const stream = taskInfo->stream;
    if (logicCq.errorCode == AICPU_HCCL_OP_UB_DDRC_FAILED) {
        if(HasMteErr(stream->Device_()) && IsEventIdAndRasCodeMatch(stream->Device_()->Id_(), g_ubNonMemPoisonRasList) && !HasMemUceErr(stream->Device_()->Id_(), g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList)) {
                taskInfo->errorCode = TS_ERROR_LOCAL_MEM_ERROR;
                (RtPtrToUnConstPtr<Device *>(stream->Device_()))->SetDeviceFaultType(DeviceFaultType::HBM_UCE_ERROR);
                RT_LOG(RT_LOG_ERROR,
                    "hccl aicpu task error is local mem error, device_id=%u, stream_id=%d, task_id=%hu, logicCq.errorCode=%u, logicCq.errorType=%hhu, taskInfo->errorCode=%u",
                    stream->Device_()->Id_(), stream->Id_(), taskInfo->id, logicCq.errorCode, logicCq.errorType, taskInfo->errorCode);
        }  
    } else if (logicCq.errorCode == AICPU_HCCL_OP_UB_POISON_FAILED) {
        if (!HasMteErr(stream->Device_()) && !HasMemUceErr(stream->Device_()->Id_(), g_hcclRemoteMulBitEccEventIdBlkList)) {
                taskInfo->errorCode = TS_ERROR_REMOTE_MEM_ERROR;
                RT_LOG(RT_LOG_ERROR,
                    "hccl aicpu task error is remote mem error, device_id=%u, stream_id=%d, task_id=%hu, logicCq.errorCode=%u, logicCq.errorType=%hhu, taskInfo->errorCode=%u",
                    stream->Device_()->Id_(), stream->Id_(), taskInfo->id, logicCq.errorCode, logicCq.errorType, taskInfo->errorCode);
        }
    } else if (logicCq.errorCode == AICPU_HCCL_OP_UB_LINK_FAILED) {
        if (!HasBlacklistEventOnDevice(stream->Device_()->Id_(), g_ccuTimeoutEventIdBlkList)) {
            taskInfo->errorCode = TS_ERROR_LINK_ERROR;
            (RtPtrToUnConstPtr<Device *>(stream->Device_()))->SetDeviceFaultType(DeviceFaultType::LINK_ERROR);
            RT_LOG(RT_LOG_ERROR,
                    "hccl aicpu task error is link error, device_id=%u, stream_id=%d, task_id=%hu, logicCq.errorCode=%u, logicCq.errorType=%hhu, taskInfo->errorCode=%u",
                    stream->Device_()->Id_(), stream->Id_(), taskInfo->id, logicCq.errorCode, logicCq.errorType, taskInfo->errorCode);
        }
    }
}

void StarsV2SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        RT_LOG(RT_LOG_DEBUG, "AICPU Kernel task happen error, retCode=%#x.", logicCq.errorCode);
        if (logicCq.errorCode == AICPU_HCCL_OP_UB_DDRC_FAILED || logicCq.errorCode == AICPU_HCCL_OP_UB_POISON_FAILED || logicCq.errorCode == AICPU_HCCL_OP_UB_LINK_FAILED) {
            MapAicpuErrorCodeForFastRecovery(taskInfo, logicCq);
            return;
        } else if ((logicCq.errorCode >> RT_AICPU_ERROR_CODE_BIT_MOVE) == AE_END_OF_SEQUENCE) {
            taskInfo->errorCode = TS_ERROR_END_OF_SEQUENCE;
            return;
        }
    }
    
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        Stream *const reportStream = GetReportStream(taskInfo->stream);
        uint32_t vectorErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_VECTOR_CORE_EXCEPTION,
            TS_ERROR_TASK_BUS_ERROR,
            TS_ERROR_VECTOR_CORE_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_VECTOR_CORE_EXCEPTION,
            logicCq.errorCode};
        uint32_t aicpuErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_AICPU_EXCEPTION,
            TS_ERROR_TASK_BUS_ERROR,
            TS_ERROR_AICPU_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_AICPU_EXCEPTION,
            logicCq.errorCode};
        uint32_t aicorerErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_AICORE_EXCEPTION,
            TS_ERROR_TASK_BUS_ERROR,
            TS_ERROR_AICORE_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_AICORE_EXCEPTION,
            logicCq.errorCode};

        const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC) {
            taskInfo->errorCode = vectorErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "AIV Kernel happen error, retCode=%#x.", taskInfo->errorCode));
        } else if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
            taskInfo->errorCode = aicpuErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
                "AICPU Kernel task happen error, retCode=%#x.", taskInfo->errorCode));
        } else {
            taskInfo->errorCode = aicorerErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "AICORE Kernel task happen error, retCode=%#x.", taskInfo->errorCode));
        }
    }
}

void AicTaskInitV2(TaskInfo *taskInfo, const rtKernelAttrType kernelAttrType, const uint16_t dimNum,
    const uint32_t flag, const LaunchTaskCfgInfo_t * const launchTaskCfg)
{
    AicTaskInitCommon(taskInfo, kernelAttrType, dimNum, flag, false);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    if (launchTaskCfg != nullptr) {
        aicTaskInfo->qos = launchTaskCfg->qos;
        aicTaskInfo->partId = launchTaskCfg->partId;
        aicTaskInfo->schemMode = launchTaskCfg->schemMode;
        aicTaskInfo->blockDimOffset = launchTaskCfg->blockDimOffset;
        aicTaskInfo->dynamicShareMemSize = launchTaskCfg->dynamicShareMemSize;
        if ((launchTaskCfg->dumpflag == RT_KERNEL_DUMPFLAG) || (launchTaskCfg->dumpflag == RT_FUSION_KERNEL_DUMPFLAG)) {
            aicTaskInfo->comm.kernelFlag = static_cast<uint8_t>(launchTaskCfg->dumpflag & 0xFFU);
            RT_LOG(RT_LOG_WARNING, "dumpflag set %u.", launchTaskCfg->dumpflag);
        }
        aicTaskInfo->groupDim = launchTaskCfg->Group.groupDim;
        aicTaskInfo->groupBlockDim = launchTaskCfg->Group.groupBlockDim;
    }

    RT_LOG(RT_LOG_INFO, "kernelFlag=0x%x, qos=%u, partId=%u, schemMode=%u, groupDim=%u, groupBlockDim=%u.",
           aicTaskInfo->comm.kernelFlag, aicTaskInfo->qos,
           aicTaskInfo->partId, aicTaskInfo->schemMode,
           aicTaskInfo->groupDim, aicTaskInfo->groupBlockDim);

    return;
}

static void ConstructDavidCommonSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command,
    uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    Stream * const stm = taskInfo->stream;
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    ConstructCommonAicAivSqePart(&(aicTaskInfo->comm), sqe, taskInfo, stm);
    return;
}

static void ConstructDavidAICoreSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command,
    uint64_t sqBaseAddr)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    Stream * const stm = taskInfo->stream;
    ConstructAicSqePart(aicTaskInfo, sqe, addr, stm);
    UpdateDavidAICoreSqeForDavinciTask(sqe);
    PrintDavidSqe(command, "AICore Task");
    return;
}

static void ConstructDavidAivSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    Stream * const stm = taskInfo->stream;
    ConstructAivSqePart(aicTaskInfo, sqe, addr, stm);

    PrintDavidSqe(command, "AIV Task");
    return;
}

static void SetMixStartPcAndParam(TaskInfo *taskInfo, rtDavidSqe_t * const command)
{
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    ConstructMixSqePart(aicTaskInfo, sqe, addr);
    return;
}

static void ConstructDavidMixSqeForDavinciTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    ConstructDavidCommonSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    RtDavidStarsAicAivKernelSqe *sqe = &(command->aicAivSqe);
    Stream * const stm = taskInfo->stream;
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    uint8_t taskRation = 0U;
    uint8_t mixType = static_cast<uint8_t>(NO_MIX);
    uint8_t schemMode = aicTaskInfo->schemMode;
    const Kernel *kernel = aicTaskInfo->kernel;
    if (kernel != nullptr) {
        taskRation = static_cast<uint8_t>(kernel->GetTaskRation());
        mixType = kernel->GetMixType();
        Program *programPtr = kernel->Program_();
        if (programPtr != nullptr && programPtr->IsDcacheLockOp()) {
            sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
            sqe->featureFlag |= SQE_DCACHE_LOCK_FLAG;
        }
    }

    /* word0-1 */
    if ((mixType == static_cast<uint8_t>(MIX_AIC)) || (mixType == static_cast<uint8_t>(MIX_AIC_AIV_MAIN_AIC))) {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIC;
    } else {
        sqe->header.type = RT_DAVID_SQE_TYPE_AIV;
    }

    SetMixStartPcAndParam(taskInfo, command);
    uint16_t curSchemMode = GetSchemMode(kernel, schemMode);
    sqe->schem = curSchemMode;
    if (curSchemMode == RT_SCHEM_MODE_BATCH) {
        const uint16_t sqeType = sqe->header.type;
        const uint16_t blockDim = sqe->header.blockDim;
        CheckBlockDim(stm, sqeType, blockDim);
    }
    sqe->ratio = 1U;            // only ratio is 1.
    if (sqe->mix == 1U) {
        sqe->ratio = taskRation;    // ratio from elf
        if ((sqe->header.type == RT_DAVID_SQE_TYPE_AIC) && (sqe->ratio == DEFAULT_TASK_RATION)) {
            sqe->loose = 0U;
        }
    }
    RT_LOG(RT_LOG_INFO, "set cfgInfo schemMode=%u, sqe_schem=%u, taskType=%u, ratio=%u, mix=%u, loose=%u, piMix=%u,"
        "aivSimtDcuSmSize=%u, featureFlag=0x%x.", schemMode, sqe->schem, taskInfo->type, sqe->ratio,
        sqe->mix, sqe->loose, sqe->piMix, sqe->aivSimtDcuSmSize, sqe->featureFlag);

    PrintDavidSqe(command, "MIX Task");

    return;
}

void ConstructDavidAicAivSqeForDavinciTask(TaskInfo * const taskInfo, rtDavidSqe_t * const command,
    uint64_t sqBaseAddr)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const uint8_t mixType = (aicTaskInfo->kernel != nullptr) ? aicTaskInfo->kernel->GetMixType() :
        static_cast<uint8_t>(NO_MIX);
    if (mixType != NO_MIX) {
        ConstructDavidMixSqeForDavinciTask(taskInfo, command, sqBaseAddr);
    } else {
        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICORE) {
            ConstructDavidAICoreSqeForDavinciTask(taskInfo, command, sqBaseAddr);
        } else {
            ConstructDavidAivSqeForDavinciTask(taskInfo, command, sqBaseAddr);
        }
    }

    return;
}
#endif

}  // namespace runtime
}  // namespace cce
