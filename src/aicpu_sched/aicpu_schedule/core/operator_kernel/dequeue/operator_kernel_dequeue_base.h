/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OPERATOR_KERNEL_DEQUEUE_BASE_H
#define OPERATOR_KERNEL_DEQUEUE_BASE_H

#include "operator_kernel_context.h"


namespace AicpuSchedule {
class OperatorKernelDequeueBase {
public:
    OperatorKernelDequeueBase() = default;
    virtual ~OperatorKernelDequeueBase() {};

    int32_t DequeueTask(BufEnQueueInfo &bufInfo, const RunContext &taskContext, const bool needPending) const;
    static int32_t AlignTimestamp(BatchDequeueInfo &batchDeqInfo, const RunContext &taskContext,
                                  uint32_t &maxAlignTimestamp, uint32_t &minAlignTimestamp,
                                  uint32_t &minTimestampIndex);
    void ProcessMbufHeadInDequeueTask(const uint32_t modelId, void * const headBuf, const uint32_t headSize) const;
    void SetModelEndOfSequence(const uint32_t modelId, void * const headBuf, const uint32_t headSize) const;
private:
    void SetModelNullData(const uint32_t modelId, const MbufHeadMsg * const headMsg) const;
    void SetModelRetCode(const uint32_t modelId, const MbufHeadMsg * const headMsg) const;
    void SetMbufStepId(const uint32_t modelId, MbufHeadMsg * const headMsg) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_DEQUEUE_BASE_H
