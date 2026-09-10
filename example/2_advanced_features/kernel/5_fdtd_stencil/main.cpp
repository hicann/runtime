/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "fdtd_stencil.h"

#include <cstddef>
#include <cstdint>

#include "acl/acl_rt_api.h"
#include "kernel_operator.h"
#include "utils.h"

__gm__ float g_fdtdCoefficients[kCoefficientCount];

extern "C" __global__ __vector__ void FdtdStencilKernel(__gm__ float* output, __gm__ float* input)
{
    const uint32_t strideY = kOuterDim;
    const uint32_t strideZ = kOuterDim * kOuterDim;
    for (uint32_t z = 1; z <= kInnerDim; ++z) {
        for (uint32_t y = 1; y <= kInnerDim; ++y) {
            for (uint32_t x = 1; x <= kInnerDim; ++x) {
                const uint32_t center = z * strideZ + y * strideY + x;
                const float neighbors = input[center - 1] + input[center + 1] + input[center - strideY] +
                                        input[center + strideY] + input[center - strideZ] + input[center + strideZ];
                output[center] = g_fdtdCoefficients[0] * input[center] + g_fdtdCoefficients[1] * neighbors;
            }
        }
    }
#if __NPU_ARCH__ == 3510
    dcci(reinterpret_cast<__gm__ int64_t*>(output), cache_line_t::ENTIRE_DATA_CACHE, dcci_dst_t::CACHELINE_OUT);
#endif
}

namespace {
int ConfigureKernel(aclrtFuncHandle& funcHandle)
{
    CHECK_ERROR(aclrtGetFuncBySymbol(reinterpret_cast<const void*>(&FdtdStencilKernel), &funcHandle));
    int64_t kernelType = -1;
    CHECK_ERROR(aclrtGetFunctionAttribute(funcHandle, ACL_FUNC_ATTR_KERNEL_TYPE, &kernelType));
    if (kernelType != ACL_KERNEL_TYPE_VECTOR) {
        ERROR_LOG("FDTD stencil requires a Vector Core kernel, but kernel type is %ld.", kernelType);
        return -1;
    }
    INFO_LOG("Kernel type %ld confirms Vector Core compatibility.", kernelType);
    return 0;
}

int CopyCoefficients(const float (&coefficients)[kCoefficientCount])
{
    size_t symbolSize = 0;
    CHECK_ERROR(aclrtGetSymbolSize(g_fdtdCoefficients, &symbolSize));
    if (symbolSize != sizeof(coefficients)) {
        ERROR_LOG("Coefficient symbol size is %zu, expected %zu.", symbolSize, sizeof(coefficients));
        return -1;
    }
    CHECK_ERROR(
        aclrtMemcpyToSymbol(g_fdtdCoefficients, coefficients, sizeof(coefficients), 0, ACL_MEMCPY_HOST_TO_DEVICE));
    INFO_LOG("Copied %u FDTD coefficients to the Device variable.", kCoefficientCount);
    return 0;
}

int RunFdtdStencil()
{
    RuntimeResources resources;
    float input[kVolumeSize] = {};
    float output[kVolumeSize] = {};
    const float coefficients[kCoefficientCount] = {0.5F, 1.0F / 12.0F};
    aclrtFuncHandle funcHandle = nullptr;

    int result = InitializeRuntime(resources);
    if (result == 0) {
        result = ConfigureKernel(funcHandle);
    }
    if (result == 0) {
        result = CopyCoefficients(coefficients);
    }
    if (result == 0) {
        result = PrepareBuffers(resources, input);
    }
    if (result == 0) {
        result = ExecuteStencil(resources, funcHandle, output);
    }
    if (result == 0) {
        result = VerifyResult(input, output, coefficients);
    }
    return ReleaseResources(resources, result);
}
} // namespace

int main()
{
    INFO_LOG("Start to run the 5_fdtd_stencil sample.");
    if (RunFdtdStencil() != 0) {
        ERROR_LOG("Run the 5_fdtd_stencil sample failed.");
        return -1;
    }
    INFO_LOG("Run the 5_fdtd_stencil sample successfully.");
    return 0;
}
