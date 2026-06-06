/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * This sample demonstrates how users can run kernels under resource limits.
 */

#include <cstdint>
#include "acl/acl.h"
#include "kernel_func/kernel_ops.h"
#include "utils.h"

namespace {
void UpdateFinalResultOnError(const char *apiName, aclError ret, int32_t &finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

int32_t LaunchPrintKernelWithCurrentResLimit(int32_t deviceId, aclrtDevResLimitType type, aclrtStream stream)
{
    // Query the resource limit and use it as the print kernel block dimension.
    uint32_t coreDim = 0;
    CHECK_ERROR(aclrtGetDeviceResLimit(deviceId, type, &coreDim));
    INFO_LOG("Current device resource limit type %d is %u.", static_cast<int32_t>(type), coreDim);
    PrintDo(coreDim, stream);
    CHECK_ERROR(aclrtSynchronizeStream(stream));
    return 0;
}
} // namespace

int32_t main()
{
    const int32_t deviceId = 0;
    const aclrtDevResLimitType resLimitType = ACL_RT_DEV_RES_CUBE_CORE;
    const uint32_t blockDim = 8;

    aclrtStream stream = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool streamCreated = false;

    const int32_t result = [&]() -> int32_t {
        // Initialize ACL and create a stream on device 0.
        CHECK_ERROR(aclInit(nullptr));
        aclInitialized = true;
        INFO_LOG("ACL initialized.");

        CHECK_ERROR(aclrtSetDevice(deviceId));
        deviceSet = true;
        INFO_LOG("Device %d selected.", deviceId);

        CHECK_ERROR(aclrtCreateStream(&stream));
        streamCreated = true;
        INFO_LOG("Stream created.");

        // Set process-level device resource limits before launching the kernel.
        CHECK_ERROR(aclrtSetDeviceResLimit(deviceId, resLimitType, blockDim));
        INFO_LOG("Device resource limit type %d set to %u.", static_cast<int32_t>(resLimitType), blockDim);

        if (LaunchPrintKernelWithCurrentResLimit(deviceId, resLimitType, stream) != 0) {
            return -1;
        }
        return 0;
    }();

    int32_t finalResult = result;
    if (streamCreated) {
        UpdateFinalResultOnError("aclrtDestroyStreamForce(stream)", aclrtDestroyStreamForce(stream), finalResult);
    }
    if (deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce(deviceId)", aclrtResetDeviceForce(deviceId), finalResult);
    }
    if (aclInitialized) {
        UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
    if (finalResult == 0) {
        INFO_LOG("Run the launch_kernel_with_reslimit sample successfully.");
    }
    return finalResult;
}
