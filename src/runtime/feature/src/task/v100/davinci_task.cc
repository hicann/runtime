/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "davinci_multiple_task.h"
#include "davinci_kernel_task.h"
#include "stream.hpp"
#include "task_scheduler_error.h"
#include "task_manager.h"
#include "arg_loader.hpp"
#include "device_error_proc.hpp"

namespace cce {
namespace runtime {

std::mutex g_cmdListVecLock;

#if F_DESC("DavinciMultipleTask")
void DavinciMultipleTaskUnInit(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo *davMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stm = taskInfo->stream;
    const std::lock_guard<std::mutex> tskLock(g_cmdListVecLock);
    davMultiTaskInfo->multipleTaskInfo = nullptr;
    if (davMultiTaskInfo->argHandleVec != nullptr) {
        for (auto iter : *(davMultiTaskInfo->argHandleVec)) {
            if (iter != nullptr) {
                (void)stm->Device_()->ArgLoader_()->Release(iter);
            }
        }
        davMultiTaskInfo->argHandleVec->clear();
        delete davMultiTaskInfo->argHandleVec;
        davMultiTaskInfo->argHandleVec = nullptr;
    }

    ResetCmdList(taskInfo);
}
#endif

#if F_DESC("DavinciKernelTask")
TIMESTAMP_EXTERN(ArgRelease);
TIMESTAMP_EXTERN(KernelTaskCompleteOther);

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
    DELETE_O(aicpuTaskInfo->kernel);
}

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

    TIMESTAMP_NAME(__func__);
    TIMESTAMP_BEGIN(ArgRelease);

    // if stream with flag of "persistent and force cpy", record argHandle instand of releasing
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
                if (HasMteErr(taskInfo->stream->Device_())) {
                    taskInfo->errorCode = TS_ERROR_SDMA_POISON_ERROR;
                } else if (!HasMemUceErr(taskInfo->stream->Device_()->Id_())) {
                    taskInfo->errorCode = TS_ERROR_SDMA_LINK_ERROR;
                } else {
                    taskInfo->errorCode = TS_ERROR_SDMA_ERROR;
                }
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
#endif

}  // namespace runtime
}  // namespace cce