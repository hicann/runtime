/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "davinci_kernel_task.h"
#include "stars.hpp"
#include "stream.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "fwk_adpt_struct.h"
#include "device/device_error_proc.hpp"
#include "aicpu_sched/common/aicpu_task_struct.h"
#include "context.hpp"
#include "task_info_v100.h"
#include "task_manager.h"
#include "task_execute_time.h"
#include "error_code.h"

namespace cce {
namespace runtime {
#if F_DESC("DavinciKernelTask")
void ConstructAICoreSqeForDavinciTask(TaskInfo* const taskInfo, rtStarsSqe_t *const command)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    (void)memset_s(command, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    RtStarsAicAivKernelSqe *sqe = &(command->aicAivKernelSqe);
    Stream * const stm = taskInfo->stream;
    Device *dev = stm->Device_();
    uint64_t stackSize = KERNEL_STACK_SIZE_32K;
    const uint64_t funcAddr = aicTaskInfo->funcAddr;
    uint32_t minStackSize = 0U;
    if (aicTaskInfo->kernel != nullptr) {
        minStackSize = aicTaskInfo->kernel->GetMinStackSize1();
    }

    uint64_t stackPhyBase = 0UL;
    if (likely(minStackSize == 0)) {
        stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
        if (stackSize == KERNEL_STACK_SIZE_16K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase16k());
        }
        RT_LOG(RT_LOG_INFO, "stackSize=%llu(bytes), stackPhyBase=%#llx", stackSize, stackPhyBase);
    } else {
        if (minStackSize <= KERNEL_STACK_SIZE_32K) {
            stackPhyBase = RtPtrToValue(dev->GetStackPhyBase32k());
            stackSize = KERNEL_STACK_SIZE_32K;
        } else {
            stackPhyBase = RtPtrToValue(dev->GetCustomerStackPhyBase());
            stackSize = Runtime::Instance()->GetDeviceCustomerStackSize();
        }
        RT_LOG(RT_LOG_INFO, "minStackSize=%u(bytes), stackSize=%u(bytes), stackPhyBase=%#llx",
            minStackSize, stackSize, stackPhyBase);
    }

    sqe->header.type = RT_STARS_SQE_TYPE_KS_AIC;
    sqe->header.l1Lock = 0U;
    sqe->header.l1UnLock = 0U;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wrCqe = stm->GetStarsWrCqeFlag();
    sqe->header.rdConds = 0U;
    sqe->header.taskId = taskInfo->id;
    sqe->header.rtStreamId = static_cast<uint16_t>(stm->Id_());
    sqe->header.u.blockDim = aicTaskInfo->comm.dim;

    /* word2-4 */
    sqe->scheme = 0U;
    sqe->kernelCredit = GetAicoreKernelCredit(aicTaskInfo->timeout);
    sqe->iCachePrefetchCnt = 0U;
    sqe->aiCacheEn = 0U;
    sqe->wrrRatioWr = 0U;
    sqe->wrrRatioRd = 0U;
    sqe->mtePortAwOstdWl = 0U;
    sqe->mtePortArOstdWl = 0U;

    /* word5-7 */
    sqe->loadMonitorEn = 0U;
    sqe->qos = 0U;
    sqe->aiCacheFmFlag = 0U;
    sqe->stackPhyBaseLow = static_cast<uint32_t>(stackPhyBase);
    sqe->stackPhyBaseHigh = static_cast<uint32_t>(stackPhyBase >> UINT32_BIT_NUM);

    /* word8-9 */
    sqe->aicStartPcLow = static_cast<uint32_t>(funcAddr);
    sqe->aicStartPcHigh = static_cast<uint16_t>(funcAddr >> UINT32_BIT_NUM);

    /* word10-11 */
    const uint64_t addr = RtPtrToValue(aicTaskInfo->comm.args);
    sqe->TaskParamPtrLow = static_cast<uint32_t>(addr);
    sqe->TaskParamPtrHigh = static_cast<uint32_t>(addr >> UINT32_BIT_NUM);
    if (unlikely(minStackSize > 0)) {
        sqe->TaskParamPtrHigh &= 0x000FFFFFU;
        const uint32_t stackLevel = static_cast<uint32_t>(stackSize / KERNEL_STACK_SIZE_16K - 2U);
        sqe->TaskParamPtrHigh |= stackLevel << 20U;
    }
    PrintSqe(command, "AIC or AIV Task");
}

void ConstructAICpuSqeForDavinciTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    UNUSED(taskInfo);
    UNUSED(command);
    return;
}

void SetResultForDavinciTask(TaskInfo* taskInfo, const void *const data, const uint32_t dataSize)
{
    UNUSED(dataSize);
    const auto *const tsData = static_cast<const uint32_t *>(data);
    const uint32_t payLoad = *tsData;
    const uint32_t highTaskId = *(tsData + 1);
    const uint32_t streamIdEx = *(tsData + 2);

    const uint32_t deviceId = taskInfo->stream->Device_()->Id_();
    const uint32_t retCode = static_cast<uint32_t>(payLoad & 0xFFFU);
    taskInfo->errorCode = retCode;
    const uint32_t taskId = (static_cast<uint32_t>(payLoad >> 22U) & 0x3FFU) |
        static_cast<uint32_t>(highTaskId << 10U); // get taskid
    const uint32_t streamId = (static_cast<uint32_t>(payLoad >> 12U) & 0x3FFU) |
        (streamIdEx << RT_STREAM_ID_OFFSET); // get streamid
    RT_LOG(RT_LOG_INFO, "Kernel payLoad=%u, highTaskId=%u, device_id=%u, rtCode=0x%x, "
           "errorTaskId=%u, errorStreamId=%u.",
           payLoad, highTaskId, deviceId, retCode, taskId, streamId);
}

TIMESTAMP_EXTERN(rtKernelLaunch_WaitAsyncCopyComplete);
rtError_t WaitAsyncCopyCompleteForDavinciTask(TaskInfo* taskInfo)
{
    DavinciTaskInfoCommon *comm = (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) ?
        &(taskInfo->u.aicpuTaskInfo.comm) : &(taskInfo->u.aicTaskInfo.comm);

    if (comm->argHandle == nullptr) {
        return RT_ERROR_NONE;
    }

    Handle *argHdl = static_cast<Handle *>(comm->argHandle);
    if (!(argHdl->freeArgs)) {
        return RT_ERROR_NONE;
    }
    TIMESTAMP_BEGIN(rtKernelLaunch_WaitAsyncCopyComplete);
    const rtError_t error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
    TIMESTAMP_END(rtKernelLaunch_WaitAsyncCopyComplete);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "H2DMemCopyWaitFinish for args cpy result failed, retCode=%#x.", static_cast<uint32_t>(error));
        return error;
    }

    return RT_ERROR_NONE;
}

TIMESTAMP_EXTERN(ArgRelease);
TIMESTAMP_EXTERN(KernelTaskCompleteOther);
void DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    Stream * const stream = taskInfo->stream;
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);

    PreCheckTaskErr(taskInfo, devId);

    if ((errorCode != TS_ERROR_AICORE_OVERFLOW) && (errorCode != TS_ERROR_AIVEC_OVERFLOW) &&
        (errorCode != TS_ERROR_AICPU_OVERFLOW) && (errorCode != TS_ERROR_SDMA_OVERFLOW)) {
        TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, errorCode, stream->Device_());
    }

    TIMESTAMP_BEGIN(ArgRelease);

    Handle *argHdl = static_cast<Handle *>(aicTaskInfo->comm.argHandle);
     if (stream->Model_() != nullptr) {
        RT_LOG(RT_LOG_INFO, "Model Task no relase args, stream_id=%d ,task_id=%hu", stream->Id_(), taskInfo->id);
        (stream->Model_())->PushbackArgHandle(static_cast<uint16_t>(stream->Id_()), taskInfo->id, argHdl);
    } else if (stream->IsSeparateSendAndRecycle() && taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        stream->SetArgHandle(aicTaskInfo->comm.argHandle);
    } else {
        (void)stream->Device_()->ArgLoader_()->Release(argHdl);
    }

    if (aicTaskInfo->mixOpt == 1U) {
        aicTaskInfo->descBuf = nullptr;
    }
    aicTaskInfo->comm.argHandle = nullptr;
    TIMESTAMP_END(ArgRelease);

    TIMESTAMP_BEGIN(KernelTaskCompleteOther);
    if (unlikely(taskInfo->pcTrace != nullptr)) {
        RT_LOG(RT_LOG_INFO, "DoCompleteSuccess, davinci kernel task has been completed successfully!");
        (void)taskInfo->pcTrace->WritePCTraceFile();
    }
    TIMESTAMP_END(KernelTaskCompleteOther);
}

static void ArgReleaseForAicTaskUnInit(TaskInfo *taskInfo)
{
    AicTaskInfo *aicTaskInfo = &(taskInfo->u.aicTaskInfo);
    const auto dev = taskInfo->stream->Device_();

    if (aicTaskInfo->comm.argHandle != nullptr) {
        (void)dev->ArgLoader_()->Release(aicTaskInfo->comm.argHandle);
        aicTaskInfo->comm.argHandle = nullptr;
        if (aicTaskInfo->mixOpt == 1) {
            aicTaskInfo->descBuf = nullptr;
        }
    }

    if (aicTaskInfo->descBuf != nullptr) {
        (void) (dev->Driver_())->DevMemFree(aicTaskInfo->descBuf, dev->Id_());
        aicTaskInfo->descBuf = nullptr;
    }
    aicTaskInfo->descAlignBuf = nullptr;
    aicTaskInfo->comm.args = nullptr;

    if (aicTaskInfo->sqeDevBuf != nullptr) {
        (void)(dev->Driver_())->DevMemFree(aicTaskInfo->sqeDevBuf, dev->Id_());
        aicTaskInfo->sqeDevBuf = nullptr;
    }

    if (aicTaskInfo->launchParam.placeHoderPtr != nullptr) {
        delete [](aicTaskInfo->launchParam.placeHoderPtr);
        aicTaskInfo->launchParam.placeHoderPtr = nullptr;
        aicTaskInfo->launchParam.placeHoderNum = 0U;
    }
}

static void ArgReleaseForAicpuTaskUnInit(TaskInfo *taskInfo)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    const auto dev = taskInfo->stream->Device_();

    if (aicpuTaskInfo->comm.argHandle != nullptr) {
        if ((taskInfo->stream->IsSeparateSendAndRecycle()) && (!taskInfo->stream->GetBindFlag())) {
            taskInfo->stream->SetArgHandle(aicpuTaskInfo->comm.argHandle);
        } else {
            (void)dev->ArgLoader_()->Release(aicpuTaskInfo->comm.argHandle);
        }
        aicpuTaskInfo->comm.argHandle = nullptr;
    }
    aicpuTaskInfo->comm.args = nullptr;
    aicpuTaskInfo->funcName = nullptr;
    aicpuTaskInfo->soName = nullptr;
}

void DavinciTaskUnInit(TaskInfo *taskInfo)
{
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        ArgReleaseForAicpuTaskUnInit(taskInfo);
    } else {
        ArgReleaseForAicTaskUnInit(taskInfo);
    }
    taskInfo->pcTrace.reset();
}

void SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) && (logicCq.errorCode == AE_STATUS_TASK_ABORT)) {
        return;
    }

    // hccl aicpu返回的errorType为0x1
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        if ((logicCq.errorCode == AICPU_HCCL_OP_RETRY_FAILED) || (logicCq.errorCode == AICPU_HCCL_OP_SDMA_LINK_FAILED)) {
            RT_LOG(RT_LOG_ERROR,
                "hccl aicpu task error, stream_id=%d, task_id=%hu, logicCq.errorCode=%u, logicCq.errorType=%hhu",
                taskInfo->stream->Id_(),
                taskInfo->id,
                logicCq.errorCode,
                logicCq.errorType);
            if (logicCq.errorCode == AICPU_HCCL_OP_RETRY_FAILED) {
                taskInfo->errorCode = TS_ERROR_AICPU_HCCL_OP_RETRY_FAILED;
            } else {
                ProcessSdmaError(taskInfo);
            }
            return;
        }
    }

    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        Stream *const reportStream = GetReportStream(taskInfo->stream);
        uint32_t vectorErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_VECTOR_CORE_EXCEPTION,
            TS_ERROR_VECTOR_CORE_TRAP_EXCEPTION,
            TS_ERROR_VECTOR_CORE_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_VECTOR_CORE_EXCEPTION,
            logicCq.errorCode};
        uint32_t aicpuErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_AICPU_EXCEPTION,
            TS_ERROR_TASK_TRAP,
            TS_ERROR_AICPU_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_AICPU_EXCEPTION,
            logicCq.errorCode};
        uint32_t aicorerErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_AICORE_EXCEPTION,
            TS_ERROR_AICORE_TRAP_EXCEPTION,
            TS_ERROR_AICORE_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_AICORE_EXCEPTION,
            logicCq.errorCode};

        const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AIVEC) {
            taskInfo->errorCode = vectorErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "Vector Core kernel execution failed, retCode=%#x.", taskInfo->errorCode));
        } else if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
            taskInfo->errorCode = aicpuErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_AICPU,
                "AI CPU kernel task execution failed, retCode=%#x.", taskInfo->errorCode));
        } else {
            taskInfo->errorCode = aicorerErrMap[errorIndex];
            COND_PROC(CheckErrPrint(taskInfo->errorCode), STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_TBE,
                "AI Core kernel execution failed, retCode=%#x.", taskInfo->errorCode));
        }
    }
}

#endif

static bool DavinciKernelTaskRegister()
{
    TaskFuncSingle aicAivFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructAICoreSqeForDavinciTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForDavinciTask,
        .taskUnInitFunc = &DavinciTaskUnInit,
        .waitAsyncCpCompleteFunc = &WaitAsyncCopyCompleteForDavinciTask,
        .printErrorInfoFunc = &PrintErrorInfoForDavinciTask,
        .setResultFunc = &SetResultForDavinciTask,
        .setStarsResultFunc = &SetStarsResultForDavinciTask,
    };

    TaskFuncSingle aicpuFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructAICpuSqeForDavinciTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForDavinciTask,
        .taskUnInitFunc = &DavinciTaskUnInit,
        .waitAsyncCpCompleteFunc = &WaitAsyncCopyCompleteForDavinciTask,
        .printErrorInfoFunc = &PrintErrorInfoForDavinciTask,
        .setResultFunc = &SetResultForDavinciTask,
        .setStarsResultFunc = &SetStarsResultForDavinciTask,
    };

    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_KERNEL_AICPU, aicpuFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_KERNEL_AICORE, aicAivFuncs);
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_KERNEL_AIVEC, aicAivFuncs);

    return true;
}

static bool g_davinciKernelTaskRegister = DavinciKernelTaskRegister();

}  // namespace runtime
}  // namespace cce
