/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "xpu_kernel_task.h"
#include "tprt_sqe_cqe.h"
#include "stream_xpu.hpp"
#include "kernel.hpp"
#include "task_manager.h"

namespace cce {
namespace runtime {

template<typename T>
void PrintXpuSqe(T const sqe, const char *desc, size_t size = 64)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 0) {
        return;
    }
    const uint32_t * const cmd = RtPtrToPtr<const uint32_t *>(sqe);
    for (size_t i = 0UL; i < (size / sizeof(uint32_t)); i += 8U) {
        RT_LOG(RT_LOG_DEBUG, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", desc,
            cmd[i], cmd[i + 1U], cmd[i + 2U], cmd[i + 3U], cmd[i + 4U], cmd[i + 5U], cmd[i + 6U],
            cmd[i + 7U]);
    }
}

void ConstructTprtSqeForHeadCommon(const TaskInfo *taskInfo, TprtSqe_t * const sqe)
{
    Stream * const stream = taskInfo->stream;
    (void)memset_s(sqe, sizeof(TprtSqe_t), 0, sizeof(TprtSqe_t));
    sqe->commonSqe.sqeHeader.sqId = stream->GetSqId();
    sqe->commonSqe.sqeHeader.taskSn = taskInfo->taskSn;
}


void ConstructTprtAICpuSqeForDavinciTask(TaskInfo *taskInfo, TprtSqe_t * const command)
{
    ConstructTprtSqeForHeadCommon(taskInfo, command);
    TprtStarsAicpuSqe *const sqe = &(command->aicpuSqe);

    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);

    /* word0-1 */
    sqe->header.type = TPRT_SQE_TYPE_AICPU;

    /* word2 - 3 */
    sqe->startPcAddr = RtPtrToValue(aicpuTaskInfo->kernel->GetFuncNameDevAddr(taskInfo->stream->Device_()->Id_()));

    /* word4 - 5 */
    sqe->argsAddr = RtPtrToValue(aicpuTaskInfo->comm.args);

    /* word6 */
    sqe->timeout = aicpuTaskInfo->timeout;

    PrintXpuSqe(command, "AICpuTask");
    RT_LOG(RT_LOG_INFO, "TprtAICpu sq_id=%u, task_sn=%u, pos=%u.", sqe->header.sqId, sqe->header.taskSn, taskInfo->id);
    return;
}

void DoCompleteSuccessForXpuDavinciTask(TaskInfo *taskInfo, const uint32_t devId)
{
    XpuPrintAICpuErrorInfoForDavinciTask(taskInfo, devId);
    taskInfo->stream->SetErrCode(taskInfo->errorCode);
}

void XpuPrintAICpuErrorInfoForDavinciTask(TaskInfo *taskInfo, const uint32_t devId)
{
    AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    const Kernel *kernel = aicpuTaskInfo->kernel;
    const std::string funcName = (kernel != nullptr) ? kernel->GetCpuFuncName() : "";
    std::string kernelName = (kernel != nullptr) ? kernel->GetCpuOpType() : "";
    std::string soName = (kernel != nullptr) ? kernel->GetCpuKernelSo() : "";

    RT_LOG_CALL_MSG(ERR_MODULE_AICPU, "Aicpu kernel execute failed, device_id=%u, stream_id=%d,"
        "%s=%u, soName=%s, funcName=%s, kernelName=%s, errorCode=%#x.",
        devId, streamId, TaskIdDesc(), taskId, soName.c_str(), funcName.c_str(), kernelName.c_str(), taskInfo->errorCode);
}

void TprtDavinciTaskUnInit(TaskInfo *taskInfo)
{
    if ((taskInfo->stream != nullptr) && (taskInfo->stream->Context_() != nullptr)) {
        static_cast<XpuStream *>(taskInfo->stream)->ArgRelease(taskInfo, true);
    }
    if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
        AicpuTaskInfo *aicpuTaskInfo = &(taskInfo->u.aicpuTaskInfo);
        aicpuTaskInfo->comm.args = nullptr;
        aicpuTaskInfo->funcName = nullptr;
        DELETE_O(aicpuTaskInfo->kernel);
    } else {
        RT_LOG(RT_LOG_ERROR, "only support aicpu.");
    }
}

void SetTprtResultForDavinciTask(TaskInfo* taskInfo, const TprtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        uint32_t aicpuErrMap[TS_STARS_ERROR_MAX_INDEX] = {
            TS_ERROR_AICPU_EXCEPTION,
            TS_ERROR_AICPU_TIMEOUT,
            logicCq.errorCode,
            logicCq.errorCode,
            logicCq.errorCode,
            logicCq.errorCode};

        const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
        if (taskInfo->type == TS_TASK_TYPE_KERNEL_AICPU) {
            taskInfo->errorCode = aicpuErrMap[errorIndex];
            STREAM_REPORT_ERR_MSG(taskInfo->stream, ERR_MODULE_HCCL,
                "AICPU Kernel task happen error, retCode=%#x, streamId=%u, taskId=%u.", taskInfo->errorCode, taskInfo->stream->Id_(), taskInfo->id);
        } else {
            RT_LOG(RT_LOG_ERROR, "only support aicpu, streamId=%u, taskId=%u.", taskInfo->stream->Id_(), taskInfo->id);
        }
    }
}

}  // namespace runtime
}  // namespace cce