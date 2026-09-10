/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef EXAMPLE_2_ADVANCED_FEATURES_KERNEL_5_FDTD_STENCIL_FDTD_STENCIL_H_
#define EXAMPLE_2_ADVANCED_FEATURES_KERNEL_5_FDTD_STENCIL_FDTD_STENCIL_H_

#include <cstdint>

#include "acl/acl.h"

constexpr int32_t kDeviceId = 0;
constexpr uint32_t kInnerDim = 4;
constexpr uint32_t kOuterDim = kInnerDim + 2;
constexpr uint32_t kVolumeSize = kOuterDim * kOuterDim * kOuterDim;
constexpr uint32_t kCoefficientCount = 2;

struct RuntimeResources {
    aclrtStream stream = nullptr;
    float* inputDevice = nullptr;
    float* outputDevice = nullptr;
    bool initialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
};

int InitializeRuntime(RuntimeResources& resources);
int PrepareBuffers(RuntimeResources& resources, float (&input)[kVolumeSize]);
int ExecuteStencil(RuntimeResources& resources, aclrtFuncHandle funcHandle, float (&output)[kVolumeSize]);
int VerifyResult(
    const float (&input)[kVolumeSize], const float (&output)[kVolumeSize],
    const float (&coefficients)[kCoefficientCount]);
int ReleaseResources(RuntimeResources& resources, int result);

#endif // EXAMPLE_2_ADVANCED_FEATURES_KERNEL_5_FDTD_STENCIL_FDTD_STENCIL_H_
