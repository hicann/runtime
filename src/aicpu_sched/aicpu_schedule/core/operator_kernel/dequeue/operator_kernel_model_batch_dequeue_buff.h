/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_MODEL_BATCH_DEQUEUE_BUFF_H
#define OPERATOR_KERNEL_MODEL_BATCH_DEQUEUE_BUFF_H

#include "operator_kernel.h"
#include "operator_kernel_dequeue_base.h"


namespace AicpuSchedule {
class OperatorKernelModelBatchDequeueBuff : public OperatorKernel, public OperatorKernelDequeueBase {
public:
    OperatorKernelModelBatchDequeueBuff() = default;
    ~OperatorKernelModelBatchDequeueBuff() override = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
    int32_t ModelAttachAndDequeueBuff(BufEnQueueBuffInfo &queueInfo, const RunContext &taskContext,
        bool tryOnce=false) const;
private:
    int32_t CheckAndParseBatchDeqBufParams(const BatchDequeueBuffDesc *const batchDeqBufDesc,
                                           const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext,
                                           BatchDequeueBuffInfo &batchDeqBufInfo) const;
    int32_t ModelDequeueBuffTaskKernel(BufEnQueueBuffInfo &bufInfo, const RunContext &taskContext,
        bool tryOnce=false) const;
    int32_t DequeueBuff(BufEnQueueBuffInfo &bufInfo, const RunContext &taskContext, const uint64_t respLen,
                        const uint32_t queueId, const int32_t deviceId) const;
    int32_t AlignBatchDequeueBuff(BatchDequeueBuffInfo &batchDeqBufInfo, const RunContext &taskContext) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_MODEL_BATCH_DEQUEUE_BUFF_H
