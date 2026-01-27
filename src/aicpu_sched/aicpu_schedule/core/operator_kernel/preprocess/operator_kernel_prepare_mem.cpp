/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "operator_kernel_prepare_mem.h"

#include "aicpusd_status.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_resource_manager.h"


namespace AicpuSchedule {
namespace {
const std::string KERNEL_PREPARE_MEM = "prepareMem";
}  // namespace

int32_t OperatorKernelPrepareMem::Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext)
{
    aicpusd_info("Start prepare model memory. modelId=%u, streamId=%u, taskId=%u",
                 taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);

    AicpuModel *const model = AicpuModelManager::GetInstance().GetModel(taskContext.modelId);
    if (model == nullptr) {
        aicpusd_err("cannot get model by modelId:[%u]!", taskContext.modelId);
        return AICPU_SCHEDULE_ERROR_INNER_ERROR;
    }

    PrepareMemTaskParam *const prepareMemInfo =
        PtrToPtr<void, PrepareMemTaskParam>(ValueToPtr(kernelTaskInfo.paraBase));
    if ((prepareMemInfo == nullptr) ||
        ((prepareMemInfo->inBuffNum != 0U) && (prepareMemInfo->inBuffPtr == 0U)) ||
        ((prepareMemInfo->outBuffNum != 0U) && (prepareMemInfo->outBuffPtr == 0U))) {
        aicpusd_err("Model prepare memory info is nullptr. modelId=%u, streamId=%u, taskId=%u",
                    taskContext.modelId, kernelTaskInfo.streamID, kernelTaskInfo.taskID);
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    std::unordered_map<uint32_t, Mbuf*> allocatedInputMbufs;
    uintptr_t *const inputPptrs = reinterpret_cast<uintptr_t *>(prepareMemInfo->inBuffPtr);
    for (uint32_t inputIndex = 0U; inputIndex < prepareMemInfo->inBuffNum; ++inputIndex) {
        const auto ret = AllocateMbufForPrepareMem(
            reinterpret_cast<Mbuf **>(inputPptrs[static_cast<size_t>(inputIndex)]),
            model->GetInputBufPool(inputIndex), taskContext, allocatedInputMbufs, inputIndex);
        if ((ret != AICPU_SCHEDULE_OK) || (taskContext.pending)) {
            aicpusd_warn("Allocate [%u]th input for model[%u] fail, ret is %d.",
                         inputIndex, taskContext.modelId, ret);
            for (auto &allocatedInputMbuf : allocatedInputMbufs) {
                model->GetInputBufPool(allocatedInputMbuf.first).Free(allocatedInputMbuf.second);
            }
            return ret;
        }
    }

    std::unordered_map<uint32_t, Mbuf*> allocatedOutputMbufs;
    uintptr_t *const outputPptrs = PtrToPtr<void, uintptr_t>(ValueToPtr(prepareMemInfo->outBuffPtr));
    for (uint32_t outputIndex = 0U; outputIndex < prepareMemInfo->outBuffNum; ++outputIndex) {
        const auto ret = AllocateMbufForPrepareMem(
            reinterpret_cast<Mbuf **>(outputPptrs[static_cast<size_t>(outputIndex)]),
            model->GetOutputBufPool(outputIndex), taskContext, allocatedOutputMbufs, outputIndex);
        if ((ret != AICPU_SCHEDULE_OK) || (taskContext.pending)) {
            aicpusd_warn("Allocate [%u]th output for model[%u] fail, ret is %d.",
                         outputIndex, taskContext.modelId, ret);
            for (auto &allocatedInputMbuf : allocatedInputMbufs) {
                model->GetInputBufPool(allocatedInputMbuf.first).Free(allocatedInputMbuf.second);
            }

            for (auto &allocatedOutputMbuf : allocatedOutputMbufs) {
                model->GetOutputBufPool(allocatedOutputMbuf.first).Free(allocatedOutputMbuf.second);
            }
            return ret;
        }
    }

    return AICPU_SCHEDULE_OK;
}

int32_t OperatorKernelPrepareMem::AllocateMbufForPrepareMem(Mbuf **pPtr, MBufferPool &pool,
                                                            const RunContext &taskContext,
                                                            std::unordered_map<uint32_t, Mbuf*> &allocatedMbufs,
                                                            const uint32_t index) const
{
    if (pPtr == nullptr) {
        aicpusd_err("null second ptr.");
        return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
    }

    EventWaitManager::PrepareMemWaitManager().ResetEventState(static_cast<size_t>(taskContext.modelId));
    Mbuf *mbuf = nullptr;
    do {
        bool needWait = false;
        const auto allocateRet = pool.Allocate(&mbuf);
        if ((allocateRet != 0) || (mbuf == nullptr)) {
            aicpusd_warn("Fail to allocate mbuf for model[%u], ret is %d", taskContext.modelId, allocateRet);
            PendPrepareMemoryTask(taskContext, needWait);
            if (needWait) {
                return AICPU_SCHEDULE_OK;
            }
        } else {
            break;
        }
    } while (true);

    *pPtr = mbuf;
    allocatedMbufs[index] = mbuf;
    return AICPU_SCHEDULE_OK;
}

void OperatorKernelPrepareMem::PendPrepareMemoryTask(const RunContext &taskContext, bool &needWait) const
{
    EventWaitManager::PrepareMemWaitManager().WaitEvent(static_cast<size_t>(taskContext.modelId),
                                                        taskContext.streamId, needWait);
    if (needWait) {
        bool * const pending = const_cast<bool *>(&taskContext.pending);
        *pending = true;
    }
    return;
}


REGISTER_OPERATOR_KERNEL(KERNEL_PREPARE_MEM, OperatorKernelPrepareMem);
}  // namespace AicpuSchedule