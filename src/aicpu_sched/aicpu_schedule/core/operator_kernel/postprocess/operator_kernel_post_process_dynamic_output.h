/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef OPERATOR_KERNEL_POST_PROCESS_DYNAMIC_OUTPUT_H
#define OPERATOR_KERNEL_POST_PROCESS_DYNAMIC_OUTPUT_H

#include <vector>
#include "operator_kernel.h"


namespace AicpuSchedule {
class OperatorKernelPostProcessDynamicOutput : public OperatorKernel {
public:
    OperatorKernelPostProcessDynamicOutput() = default;
    ~OperatorKernelPostProcessDynamicOutput() = default;
    int32_t Compute(const AicpuTaskInfo &kernelTaskInfo, const RunContext &taskContext) override;
private:
    int32_t CopyTensorDesc(const PostprocessDynamicOutputKernelArgs * const param, const RunContext &taskContext) const;
    int32_t AllocatedOutput(const PostprocessDynamicOutputKernelArgs * const param, Mbuf *const outputMbuf,
                            const uint32_t dynamicFlag, const size_t index, RuntimeTensorDesc **dynamicSrcDescPptr,
                            RuntimeTensorDesc **staticSrcDescPptr) const;
    int32_t GetRuntimeTensor(const PostprocessDynamicOutputKernelArgs * const param,
                             RuntimeTensorDesc **dynamicSrcDescPtr) const;
    int32_t PostprocessSetDataLen(const RuntimeTensorDesc * const runtimeTensorDesc, Mbuf *const outputMbuf,
                                  const size_t index) const;
    int32_t GetMbufHeadFromResp(Mbuf **const respMbufPtr, const RunContext &taskContext, void **const customBufPtr,
                                uint32_t *const customBufSizePtr) const;
    int32_t PostProcessForOutputToAllocate(const PostprocessDynamicOutputKernelArgs * const param,
                                           Mbuf **const outputMbufPtr, const size_t index,
                                           RuntimeTensorDesc **dynamicSrcDescPptr, void *const customBuf,
                                           const uint32_t customBufSize, const RunContext &taskContext) const;
    int32_t MakeupDynamicOutputMbuf(Mbuf **const outputMbufPtr, const size_t index,
                                    const RuntimeTensorDesc *const runtimeTensorDesc, void *const customBuf,
                                    const uint32_t customBufSize, const RunContext &taskContext) const;
    int32_t FreeMbuf(const PostprocessDynamicOutputKernelArgs * const param, const RunContext &taskContext) const;

    bool IsSupportSdmaCopy() const;

    bool OptimizedMemCopy(void *const dst_data, const size_t dst_size,
                          const void *const src_data, const size_t src_size) const;
};
}  // namespace AicpuSchedule
#endif  // OPERATOR_KERNEL_POST_PROCESS_DYNAMIC_OUTPUT_H
