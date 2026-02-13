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
#include "stream_david.hpp"
#include "task_scheduler_error.h"
#include "task_manager.h"
#include "device_error_proc.hpp"

namespace cce {
namespace runtime {

#if F_DESC("DavinciMultipleTask")
void DavinciMultipleTaskUnInit(TaskInfo* taskInfo)
{
    DavinciMultiTaskInfo *davMultiTaskInfo = &(taskInfo->u.davinciMultiTaskInfo);
    Stream * const stm = taskInfo->stream;
    davMultiTaskInfo->multipleTaskInfo = nullptr;
    static_cast<DavidStream *>(stm)->ArgReleaseMultipleTask(taskInfo);
    ResetCmdList(taskInfo);
}
#endif

#if F_DESC("DavinciKernelTask")
void DoCompleteSuccessForDavinciTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t errorCode = taskInfo->errorCode;
    Stream * const stream = taskInfo->stream;

    PreCheckTaskErr(taskInfo, devId);
    TIMESTAMP_NAME(__func__);

    if ((errorCode != TS_ERROR_AICORE_OVERFLOW) && (errorCode != TS_ERROR_AIVEC_OVERFLOW) &&
        (errorCode != TS_ERROR_AICPU_OVERFLOW) && (errorCode != TS_ERROR_SDMA_OVERFLOW) && (errorCode != 0U)) {
        TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, errorCode, stream->Device_());
    }
}

void DavinciTaskUnInit(TaskInfo *taskInfo)
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

void MapAicpuErrorCodeForFastRecovery(TaskInfo *taskInfo, const rtLogicCqReport_t &logicCq)
{
    taskInfo->errorCode = TS_ERROR_AICPU_EXCEPTION;
    Stream * const stream = taskInfo->stream;
    if (logicCq.errorCode == AICPU_HCCL_OP_UB_DDRC_FAILED) {
        if(HasMteErr(stream->Device_()) && IsEventIdAndRasCodeMatch(stream->Device_()->Id_(), g_ubNonMemPoisonRasList) && !HasMemUceErr(stream->Device_()->Id_(), g_aicOrSdmaOrHcclLocalMulBitEccEventIdBlkList)) {
                taskInfo->errorCode = TS_ERROR_LOCAL_MEM_ERROR;
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
    }
}

void SetStarsResultForDavinciTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        RT_LOG(RT_LOG_DEBUG, "AICPU Kernel task happen error, retCode=%#x.", logicCq.errorCode);
        if (logicCq.errorCode == AICPU_HCCL_OP_UB_DDRC_FAILED || logicCq.errorCode == AICPU_HCCL_OP_UB_POISON_FAILED) {
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
#endif

}  // namespace runtime
}  // namespace cce