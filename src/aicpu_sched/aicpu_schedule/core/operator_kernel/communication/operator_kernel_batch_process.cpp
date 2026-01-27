/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_batch_process.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_BATCH_RECV = "batchRecv";
const std::string KERNEL_BATCH_SEND = "batchSend";
}  // namespace

int32_t OperatorKernelBatchProcess::BatchProcess(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext,
                                                 HcomOperationType opType) const
{
    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR);
    }

    const BatchSendRecvTaskParam *const batchTaskInfo =
        PtrToPtr<void, BatchSendRecvTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    if ((batchTaskInfo == nullptr) || (batchTaskInfo->ioNum == 0U) || (batchTaskInfo->hcomP2pOpList == 0U)) {
        aicpusd_err("Model batch task's parameter is invalid. modelId=%u, streamId=%u, taskId=%u",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
        return static_cast<int32_t>(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    }

    HcomP2pOpInfo *opList = PtrToPtr<void, HcomP2pOpInfo>(ValueToPtr(batchTaskInfo->hcomP2pOpList));
    for (size_t i = 0U; i < static_cast<size_t>(batchTaskInfo->ioNum); ++i) {
        HcclResult ret = HCCL_SUCCESS;
        if (opType == HCOM_OP_TYPE_SEND) {
            ret = StubHcomSendByOS(opList[i].addr, opList[i].count, opList[i].dataType,
                opList[i].peerRank, opList[i].tag, opList[i].group, batchTaskInfo->flag);
        } else if (opType == HCOM_OP_TYPE_RECV) {
            ret = StubHcomReceiveByOS(opList[i].addr, opList[i].count, opList[i].dataType,
                opList[i].peerRank, opList[i].tag, opList[i].group, batchTaskInfo->flag);
        } else {
            aicpusd_err("Invalid op type: %d", static_cast<int32_t>(opType));
            return static_cast<int32_t>(AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
        }

        if (ret != HCCL_SUCCESS) {
            aicpusd_err("Send/Recv fail for tag[%d], type[%d], ret is %d", opList[i].tag,
                static_cast<int32_t>(opType), static_cast<int32_t>(ret));
            return static_cast<int32_t>(AICPU_SCHEDULE_ERROR_CALL_HCCL);
        }
    }
    aicpusd_info("Finish batch process. modelId=%u, streamId=%u, taskId=%u",
        taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    return static_cast<int32_t>(AICPU_SCHEDULE_OK);
}

int32_t OperatorKernelBatchRecv::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start batch recv. modelId=%u, streamId=%u, taskId=%u",
        taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    return BatchProcess(kernelTaskInfo, taskContext, HCOM_OP_TYPE_RECV);
}

int32_t OperatorKernelBatchSend::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start batch send. modelId=%u, streamId=%u, taskId=%u",
        taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
    return BatchProcess(kernelTaskInfo, taskContext, HCOM_OP_TYPE_SEND);
}


REGISTER_OPERATOR_KERNEL(KERNEL_BATCH_RECV, OperatorKernelBatchRecv);
REGISTER_OPERATOR_KERNEL(KERNEL_BATCH_SEND, OperatorKernelBatchSend);
}  // namespace AicpuSchedule