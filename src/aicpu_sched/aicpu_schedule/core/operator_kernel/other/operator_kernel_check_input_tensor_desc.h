/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_CHECK_INPUT_TENSOR_DESC_H
#define OPERATOR_KERNEL_CHECK_INPUT_TENSOR_DESC_H

#include "operator_kernel.h"


namespace AicpuSchedule {
class OperatorKernelCheckInputTensorDesc : public OperatorKernel {
public:
    OperatorKernelCheckInputTensorDesc() = default;
    ~OperatorKernelCheckInputTensorDesc() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    int32_t CheckInputTensorDesc(const uint64_t shapeValidationAddr, const uint64_t index,
                                 const ModelConfigTensorDesc &modelTensorDesc,  uint64_t &curSize) const;
    int32_t CheckShapeInfo(const ModelConfigTensorDesc &modelTensorDesc, const RuntimeTensorDesc &tensorDesc) const;
    void PrintErrShapeInfo(const ModelConfigTensorDesc &modelTensorDesc, const RuntimeTensorDesc &tensorDesc) const;
    int32_t CheckMsgType(Mbuf **const mbufPtr) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_CHECK_INPUT_TENSOR_DESC_H
