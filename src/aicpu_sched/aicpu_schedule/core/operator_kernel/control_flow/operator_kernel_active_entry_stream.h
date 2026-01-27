/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_ACTIVE_ENTRY_STREAM_H
#define OPERATOR_KERNEL_ACTIVE_ENTRY_STREAM_H

#include "operator_kernel.h"
#include "aicpusd_sqe_adapter.h"


namespace AicpuSchedule {
class OperatorKernelActiveEntryStream : public OperatorKernel {
public:
    OperatorKernelActiveEntryStream() = default;
    ~OperatorKernelActiveEntryStream() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    int32_t DoCompute(const uint32_t streamId, const RunContext &taskContext) const;
    int32_t SubmitEndGraph(const uint32_t modelId) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_ACTIVE_ENTRY_STREAM_H
