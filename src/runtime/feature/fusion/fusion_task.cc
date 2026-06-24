/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <sstream>
#include <vector>
#include "fusion_task.h"
#include "stream.hpp"
#include "stream_david.hpp"
#include "runtime.hpp"
#include "event_david.hpp"
#include "task_manager.h"
#include "stars.hpp"
#include "device.hpp"
#include "stars_david.hpp"
#include "error_code.h"
#include "error_message_manage.hpp"
#include "davinci_kernel_task.h"
#include "task_execute_time.h"
#include "ccu_sqe.hpp"
#include "aic_aiv_sqe_common.hpp"

namespace cce {
namespace runtime {

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

    /* word8-11 */
    addr = RtPtrToValue(fusionKernelTask->aicpuArgsDesc[aicpuIndex].funcName);
    ConstructDavidAICpuSqeForDavinciTaskResFieldPart(sqe, addr, kernelFlag, stm);

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

    FillTopicType(sqe, kernelFlag);

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
        sqe->kernelCredit = static_cast<uint8_t>(GetAicoreKernelCredit(0U));
    }

    RT_LOG(RT_LOG_INFO, "taskIdx=%u, sqeIndex=%u, aicpuIndex=%u, kfcArgsFmtOffset=%hu, kernelFlag=%u, aicpuKernelType=%hu.",
        taskIdx, sqeIndex, aicpuIndex, sqe->res5, kernelFlag, aicpuKernelType);

    return;
}

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
    const uint8_t schemMode = aicPart->schemMode;
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

    sqe->schem = schemMode;
    if (schemMode == RT_SCHEM_MODE_BATCH) {
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

void ConstructDavidSqeForFusionKernelTask(TaskInfo* const taskInfo, void* const sqe, const TaskSqeInfo& sqeInfo)
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

std::string BuildFusionKernelTaskName(FusionTaskInfo* fusionTaskInfo)
{
    std::string taskName = "FUSION_KERNEL";
    const uint8_t sqeSubType = fusionTaskInfo->sqeSubType;

    std::vector<std::string> subTaskNames;
    if ((sqeSubType & (1U << (uint32_t)RT_FUSION_AICPU)) != 0U) {
        subTaskNames.push_back("AICPU");
    }
    if ((sqeSubType & (1U << (uint32_t)RT_FUSION_HCOM_CPU)) != 0U) {
        subTaskNames.push_back("HCOM_CPU");
    }
    if ((sqeSubType & (3U << (uint32_t)RT_FUSION_CCU)) != 0U) {
        subTaskNames.push_back("CCU");
    }
    if ((sqeSubType & (1U << (uint32_t)RT_FUSION_AICORE)) != 0U) {
        FusionTaskInfoAicPart* aicPart = &(fusionTaskInfo->aicPart);
        const Kernel *kernel = aicPart->kernel;
        std::string aicName = (kernel != nullptr) ? kernel->Name_() : "AICORE";
        subTaskNames.push_back(aicName);
    }

    if (!subTaskNames.empty()) {
        for (size_t i = 0; i < subTaskNames.size(); ++i) {
            taskName += "_" + subTaskNames[i];
        }
    }

    return taskName;
}

static rtError_t GetArgsInfoForFusionKernelTask(TaskInfo* taskInfo)
{
    FusionTaskInfo *const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    void *hostMem = nullptr;
    COND_RETURN_ERROR_MSG_INNER((fusionKernelTask->args == nullptr) || (fusionKernelTask->argsSize == 0U),
        RT_ERROR_INVALID_VALUE, "Get args info failed, address size=%u", fusionKernelTask->argsSize);
    const auto dev = taskInfo->stream->Device_();
    rtError_t error = dev->Driver_()->HostMemAlloc(&hostMem, static_cast<uint64_t>(fusionKernelTask->argsSize) + 1U,
        dev->Id_());
    ERROR_RETURN(error, "Malloc host memory for args failed, retCode=%#x", static_cast<uint32_t>(error));
    error = dev->Driver_()->MemCopySync(hostMem, static_cast<uint64_t>(fusionKernelTask->argsSize) + 1U,
        fusionKernelTask->args, static_cast<uint64_t>(fusionKernelTask->argsSize), RT_MEMCPY_DEVICE_TO_HOST);
    COND_PROC_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, (void)dev->Driver_()->HostMemFree(hostMem);,
        "Memcpy failed, size=%u, type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x",
        fusionKernelTask->argsSize, static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
    const uint32_t totalLen = fusionKernelTask->argsSize / static_cast<uint32_t>(sizeof(void *));
    const uint32_t argsTimes = (totalLen % ARGS_PER_STRING_MAX_LEN > 0) ?
        static_cast<uint32_t>((totalLen / ARGS_PER_STRING_MAX_LEN) + 1) :
        static_cast<uint32_t>(totalLen / ARGS_PER_STRING_MAX_LEN);
    for (uint32_t j = 1U; j <= argsTimes; j++) {
        std::stringstream ss;
        uint32_t i = 0U;
        const uint32_t curLen = totalLen > (j * ARGS_PER_STRING_MAX_LEN) ? (j * ARGS_PER_STRING_MAX_LEN) : totalLen;
        for (i = (j - 1U) * ARGS_PER_STRING_MAX_LEN; i < curLen - 1U; ++i) {
            ss << RtPtrToPtr<uint64_t *, uint64_t>(*(RtPtrToPtr<uint64_t *, void *>(hostMem) + i)) << ", ";
        }
        ss << RtPtrToPtr<uint64_t *, uint64_t>(*(RtPtrToPtr<uint64_t *, void *>(hostMem) + i));
        RT_LOG(RT_LOG_ERROR, "[FUSION_KERNEL_INFO] args(%u to %u) after execute:%s.",
            (j - 1U) * ARGS_PER_STRING_MAX_LEN, curLen - 1U, ss.str().c_str());
    }
    RT_LOG(RT_LOG_ERROR, "fusion kernel print %u Times totalLen=(%u*8), argsSize=%u", argsTimes, totalLen,
        fusionKernelTask->argsSize);
    (void)dev->Driver_()->HostMemFree(hostMem);
    return RT_ERROR_NONE;
}

void DoCompleteSuccessForFusionKernelTask(TaskInfo* taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    if ((taskInfo->mte_error == TS_ERROR_AICORE_MTE_ERROR) || (taskInfo->mte_error == TS_ERROR_LINK_ERROR) ||
        (taskInfo->mte_error == TS_ERROR_LOCAL_MEM_ERROR) || (taskInfo->mte_error == TS_ERROR_REMOTE_MEM_ERROR)) {
        taskInfo->errorCode = taskInfo->mte_error;
        taskInfo->mte_error = 0U;
    }
    const uint32_t errorCode = taskInfo->errorCode;
    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        stream->SetErrCode(errorCode);
        RT_LOG(RT_LOG_ERROR, "fusion kernel task proc error, retCode=%#x.", errorCode);
        PrintErrorInfo(taskInfo, devId);
    }
}

void FusionKernelTaskUnInit(TaskInfo *taskInfo)
{
    static_cast<DavidStream *>(taskInfo->stream)->ArgReleaseSingleTask(taskInfo, true);
    FusionTaskInfo * const fusionKernelTask = &(taskInfo->u.fusionKernelTask);
    fusionKernelTask->args = nullptr;
    for (uint32_t i = 0; i < FUSION_SUB_TASK_MAX_CPU_NUM; i++) {
        fusionKernelTask->aicpuArgsDesc[i].funcName = nullptr;
        fusionKernelTask->aicpuArgsDesc[i].soName = nullptr;
    }
    RT_LOG(RT_LOG_INFO, "fusion kernel task uninit.");
}

void PrintErrorInfoForFusionKernelTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    FusionTaskInfo *const fusionKernelTask = &(taskInfo->u.fusionKernelTask);

    Stream *const reportStream = GetReportStream(taskInfo->stream);
    std::string kernelNameStr = "";
    std::string kernelInfoExt = "";
    if ((fusionKernelTask != nullptr) && (fusionKernelTask->aicPart.kernel != nullptr)) {
        kernelNameStr = fusionKernelTask->aicPart.kernel->Name_();
        kernelInfoExt = fusionKernelTask->aicPart.kernel->KernelInfoExtString();
    }

    kernelNameStr = kernelNameStr.empty() ? ("none") : kernelNameStr;
    kernelInfoExt = kernelInfoExt.empty() ? ("none") : kernelInfoExt;

    const rtError_t ret = GetArgsInfoForFusionKernelTask(taskInfo);
    RT_LOG(RT_LOG_ERROR, "Fusion kernel execute failed, device_id=%u, stream_id=%d, report_stream_id=%d, task_id=%u,"
        " flip_num=%hu, kernel_name=%s, kernel info ext=%s", devId, streamId, reportStream->Id_(), taskId,
        taskInfo->flipNum, kernelNameStr.c_str(), kernelInfoExt.c_str());
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE, "[FUSION_KERNEL_INFO] after execute: %s",
        (ret != RT_ERROR_NONE) ? "(no result)" : "args print end");
}

void SetStarsResultForFusionKernelTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        static uint32_t errMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_TASK_EXCEPTION,
            TS_ERROR_TASK_BUS_ERROR,
            TS_ERROR_TASK_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_TASK_RES_CONFLICT_ERROR,
            TS_ERROR_TASK_SW_STATUS_ERROR};
        const uint32_t errorIndex =
            static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType & RT_STARS_EXIST_ERROR)));
        taskInfo->errorCode = errMap[errorIndex];

        const uint32_t logicCqErrorCode = logicCq.errorCode;
        const uint32_t MASK_AICORE = 0x00000400U;
        const uint32_t MASK_AICPU = 0x00000044U;
        const uint32_t MASK_CCU = 0x00044000U;
        const bool isTimeout = (taskInfo->errorCode == TS_ERROR_TASK_TIMEOUT);
    
        if ((logicCqErrorCode & MASK_AICORE) != 0U) {
            taskInfo->errorCode = isTimeout ? TS_ERROR_AICORE_TIMEOUT : TS_ERROR_AICORE_EXCEPTION;
        } else if ((logicCqErrorCode & MASK_AICPU) != 0U) {
            taskInfo->errorCode = isTimeout ? TS_ERROR_AICPU_TIMEOUT : TS_ERROR_AICPU_EXCEPTION;
        } else if ((logicCqErrorCode & MASK_CCU) != 0U) {
            taskInfo->errorCode = isTimeout ? TS_ERROR_CCU_TIMEOUT : TS_ERROR_CCU_EXCEPTION;
        } else {}

        RT_LOG(RT_LOG_ERROR, "FusionKernelTask errorCode=%u, logicCq:errType=%u, errCode=%u, "
            "stream_id=%hu, task_id=%hu", taskInfo->errorCode, logicCq.errorType, logicCq.errorCode,
            taskInfo->stream->Id_(), taskInfo->id);
    }
}

}  // namespace runtime
}  // namespace cce