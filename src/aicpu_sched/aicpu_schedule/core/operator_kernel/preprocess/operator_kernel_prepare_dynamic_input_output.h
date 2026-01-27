/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_PREPARE_DYNAMIC_INPUT_OUTPUT_H
#define OPERATOR_KERNEL_PREPARE_DYNAMIC_INPUT_OUTPUT_H

#include <vector>
#include "operator_kernel.h"


namespace AicpuSchedule {
class PrepareDynamicInputOutputBase {
public:
    PrepareDynamicInputOutputBase() = default;
    ~PrepareDynamicInputOutputBase() = default;
    int32_t PrepareDynamicInputOutput(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext,
                                      const bool hostAllocDynamicOutput) const;
private:
    int32_t AllocateAndInitOutput(const PrepareDynamicInputOutputKernelArgs * const param,
                                  const RunContext &taskContext, std::vector<Mbuf *> &mbufsToFree,
                                  const bool hostAllocDynamicOutput) const;
    int32_t PrepareReqMsg(const PrepareDynamicInputOutputKernelArgs * const param, const RunContext &taskContext,
                          std::vector<Mbuf *> &mbufsToFree, const bool hostAllocDynamicOutput) const;
    int32_t UpdateReqMsgHead(Mbuf *const reqMbuf, const uint64_t * const inputPptrs, const uint32_t inputNum,
                             const RunContext &taskContext) const;
    void ExtractHeadInfo(Mbuf *const mbuf, int32_t &retCode, bool &nullDataFlag, bool &isEndofSequence) const;
};


class OperatorKernelPrepareDynamicInputOutput : public OperatorKernel, public PrepareDynamicInputOutputBase {
public:
    OperatorKernelPrepareDynamicInputOutput() = default;
    ~OperatorKernelPrepareDynamicInputOutput() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};

class OperatorKernelPrepareDynamicInputOutputV2 : public OperatorKernel, public PrepareDynamicInputOutputBase {
public:
    OperatorKernelPrepareDynamicInputOutputV2() = default;
    ~OperatorKernelPrepareDynamicInputOutputV2() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_PREPARE_DYNAMIC_INPUT_OUTPUT_H
