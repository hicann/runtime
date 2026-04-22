/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fusion_task_david.hpp"
#include "stream_david.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "davinci_kernel_task.h"
#include "task_manager.h"
#include "error_code.h"
#include <sstream>
#include <vector>

namespace cce {
namespace runtime {

std::string BuildFusionKernelTaskName(FusionTaskInfo* fusionTaskInfo)
{
    std::string taskName = "FUSION_KERNEL";
    uint8_t sqeSubType = fusionTaskInfo->sqeSubType;

    std::vector<std::string> subTaskNames;
    if ((sqeSubType & (1U << RT_FUSION_AICPU)) != 0U) {
        subTaskNames.push_back("AICPU");
    }
    if ((sqeSubType & (1U << RT_FUSION_HCOM_CPU)) != 0U) {
        subTaskNames.push_back("HCOM_CPU");
    }
    if ((sqeSubType & (3U << RT_FUSION_CCU)) != 0U) {
        subTaskNames.push_back("CCU");
    }
    if ((sqeSubType & (1U << RT_FUSION_AICORE)) != 0U) {
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
        RT_LOG(RT_LOG_ERROR, "FusionKernelTask errorCode=%u, logicCq:errType=%u, errCode=%u, "
            "stream_id=%hu, task_id=%hu", taskInfo->errorCode, logicCq.errorType, logicCq.errorCode,
            taskInfo->stream->Id_(), taskInfo->id);
    }
}

} // namespace runtime
} // namespace cce
