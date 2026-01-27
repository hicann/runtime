/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_GATHER_DEQUEUE_H
#define OPERATOR_KERNEL_GATHER_DEQUEUE_H

#include "operator_kernel.h"
#include "operator_kernel_model_batch_dequeue_buff.h"


namespace AicpuSchedule {
class OperatorKernelGatherDequeue : public OperatorKernelModelBatchDequeueBuff {
public:
    OperatorKernelGatherDequeue() = default;
    ~OperatorKernelGatherDequeue() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    bool SelectMbuf(const GatherDequeParam * const batchDeqInfo, const RunContext &taskContext,
                    void *const modelPtr, int32_t &gatherRet) const;
    Mbuf *MakeUpPassedMbuf(const uint32_t modelId) const;
    MbufHeadMsg *GetMbufHeadMsg(Mbuf *const mbuf) const;
    bool DequeAndCheckIfReady(const GatherDequeParam * const batchDeqInfo, int32_t &gatherRet,
                              void *const modelPtr, const RunContext &taskContext, bool &blockOnClientQ) const;
    bool StoreMbufIntoModel(Mbuf *const mbuf, const size_t index, const uint32_t capacity, void *const modelPtr) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_GATHER_DEQUEUE_H
