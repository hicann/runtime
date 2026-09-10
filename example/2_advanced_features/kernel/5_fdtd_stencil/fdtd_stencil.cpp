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

#include <cmath>
#include <cstddef>
#include <cstdint>

#include "utils.h"

namespace {
constexpr float kTolerance = 1e-5F;

void RecordCleanupError(const char* operation, aclError ret, int& result)
{
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("%s failed, error code %d.", operation, static_cast<int32_t>(ret));
        result = -1;
    }
}
} // namespace

int InitializeRuntime(RuntimeResources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    resources.streamCreated = true;
    return 0;
}

int PrepareBuffers(RuntimeResources& resources, float (&input)[kVolumeSize])
{
    constexpr size_t bufferBytes = kVolumeSize * sizeof(float);
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&resources.inputDevice), bufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(reinterpret_cast<void**>(&resources.outputDevice), bufferBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    for (uint32_t i = 0; i < kVolumeSize; ++i) {
        input[i] = static_cast<float>((i * 7U) % 29U) / 29.0F;
    }
    CHECK_ERROR(aclrtMemcpy(resources.inputDevice, bufferBytes, input, bufferBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int ExecuteStencil(RuntimeResources& resources, aclrtFuncHandle funcHandle, float (&output)[kVolumeSize])
{
    void* args[] = {&resources.outputDevice, &resources.inputDevice};
    CHECK_ERROR(aclrtLaunchKernelWithArgsArray(funcHandle, 1, resources.stream, nullptr, args));
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    constexpr size_t bufferBytes = kVolumeSize * sizeof(float);
    CHECK_ERROR(aclrtMemcpy(output, bufferBytes, resources.outputDevice, bufferBytes, ACL_MEMCPY_DEVICE_TO_HOST));
    return 0;
}

int VerifyResult(
    const float (&input)[kVolumeSize], const float (&output)[kVolumeSize],
    const float (&coefficients)[kCoefficientCount])
{
    const uint32_t strideY = kOuterDim;
    const uint32_t strideZ = kOuterDim * kOuterDim;
    float maxError = 0.0F;
    for (uint32_t z = 1; z <= kInnerDim; ++z) {
        for (uint32_t y = 1; y <= kInnerDim; ++y) {
            for (uint32_t x = 1; x <= kInnerDim; ++x) {
                const uint32_t center = z * strideZ + y * strideY + x;
                const float neighbors = input[center - 1] + input[center + 1] + input[center - strideY] +
                                        input[center + strideY] + input[center - strideZ] + input[center + strideZ];
                const float expected = coefficients[0] * input[center] + coefficients[1] * neighbors;
                const float error = std::fabs(output[center] - expected);
                maxError = error > maxError ? error : maxError;
            }
        }
    }
    if (maxError > kTolerance) {
        ERROR_LOG("FDTD result mismatch: max error %.8f exceeds %.8f.", maxError, kTolerance);
        return -1;
    }
    INFO_LOG("Verified %u interior points; max error is %.8f.", kInnerDim * kInnerDim * kInnerDim, maxError);
    return 0;
}

int ReleaseResources(RuntimeResources& resources, int result)
{
    if (resources.outputDevice != nullptr) {
        RecordCleanupError("aclrtFree(output)", aclrtFree(resources.outputDevice), result);
    }
    if (resources.inputDevice != nullptr) {
        RecordCleanupError("aclrtFree(input)", aclrtFree(resources.inputDevice), result);
    }
    if (resources.streamCreated) {
        RecordCleanupError("aclrtDestroyStreamForce", aclrtDestroyStreamForce(resources.stream), result);
    }
    if (resources.deviceSet) {
        RecordCleanupError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (resources.initialized) {
        RecordCleanupError("aclFinalize", aclFinalize(), result);
    }
    return result;
}
