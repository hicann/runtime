/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_ZERO_CPY_H
#define OPERATOR_KERNEL_ZERO_CPY_H

#include <vector>
#include <unordered_map>
#include "operator_kernel.h"


namespace AicpuSchedule {
class OperatorKernelZeroCpy : public OperatorKernel {
public:
    OperatorKernelZeroCpy() = default;
    ~OperatorKernelZeroCpy() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};

class OperatorKernelZeroCpyV2 : public OperatorKernel {
public:
    OperatorKernelZeroCpyV2() = default;
    ~OperatorKernelZeroCpyV2() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    int32_t DoCompute(AddrMapInfoV2 &mapInfo, const RunContext &taskContext) const;
    int32_t ResolveFusionOffsets(const uint64_t *const fusionOffsetListAddr, const uint32_t addrNum,
                                 std::vector<int32_t> &fusionOffsets) const;
    int32_t UpdateDataPtrExtend(const uint64_t mbufAddr, const int32_t fusionOffset, void *&dataPtr,
                                std::unordered_map<uint64_t, FusionInfo> &fusionMap) const;
};

class OperatorKernelCpuZeroCpy : public OperatorKernel {
public:
    OperatorKernelCpuZeroCpy() = default;
    ~OperatorKernelCpuZeroCpy() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_ZERO_CPY_H
