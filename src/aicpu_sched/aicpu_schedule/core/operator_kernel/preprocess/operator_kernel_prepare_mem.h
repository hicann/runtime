/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_PREPARE_MEM_H
#define OPERATOR_KERNEL_PREPARE_MEM_H

#include <unordered_map>
#include "aicpusd_hccl_api.h"
#include "operator_kernel.h"


namespace AicpuSchedule {
class OperatorKernelPrepareMem : public OperatorKernel {
public:
    OperatorKernelPrepareMem() = default;
    ~OperatorKernelPrepareMem() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    int32_t AllocateMbufForPrepareMem(Mbuf **pPtr, MBufferPool &pool, const RunContext &taskContext,
                                      std::unordered_map<uint32_t, Mbuf*> &allocatedMbufs, const uint32_t index) const;
    void PendPrepareMemoryTask(const RunContext &taskContext, bool &needWait) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_PREPARE_MEM_H
