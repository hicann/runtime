/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_PREPARE_OUTPUT_H
#define OPERATOR_KERNEL_PREPARE_OUTPUT_H

#include "operator_kernel.h"
#include "operator_kernel_context.h"


namespace AicpuSchedule {
class OperatorKernelPrepareOutputBase {
public:
    OperatorKernelPrepareOutputBase() = default;
    virtual ~OperatorKernelPrepareOutputBase() {};

    int32_t PrepareOutput(ProcessOutputInfo &outputInfo, const RunContext &taskContext, const bool zeroCpy,
                          RuntimeTensorDesc *const tensorDesc) const;
    int32_t PrepareOutWithTensorDesc(const AicpuTaskInfo &kernelTaskInfo, const bool zeroCpy,
                                     const RunContext &taskContext) const;
private:
    int32_t PrepareOutputNonZeroCpy(const ProcessOutputInfo &outputInfo, Mbuf * const outMBuf,
                                    RuntimeTensorDesc *const tensorDesc) const;
    int32_t GetStaticNNOutPutIndex(const uint32_t modelId) const;
    void MarkStaticNNOutPutIndex(const uint32_t modelId) const;
};

class OperatorKernelModelPrepareOutput : public OperatorKernel, public OperatorKernelPrepareOutputBase {
public:
    OperatorKernelModelPrepareOutput() = default;
    ~OperatorKernelModelPrepareOutput() = default;

    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};

class OperatorKernelModelPrepareOutputWithTensorDesc : public OperatorKernel, public OperatorKernelPrepareOutputBase {
public:
    OperatorKernelModelPrepareOutputWithTensorDesc() = default;
    ~OperatorKernelModelPrepareOutputWithTensorDesc() = default;

    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};

class OperatorKernelBufferPrepareOutput : public OperatorKernel, public OperatorKernelPrepareOutputBase {
public:
    OperatorKernelBufferPrepareOutput() = default;
    ~OperatorKernelBufferPrepareOutput() = default;

    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};

class OperatorKernelBufferPrepareOutputWithTensorDesc : public OperatorKernel, public OperatorKernelPrepareOutputBase {
public:
    OperatorKernelBufferPrepareOutputWithTensorDesc() = default;
    ~OperatorKernelBufferPrepareOutputWithTensorDesc() = default;

    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
};

}  // namespace AicpuSchedule

#endif  // OPERATOR_KERNEL_PREPARE_OUTPUT_H
