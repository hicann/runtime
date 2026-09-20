/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr char kFunctionName[] = "ValidateSimdStackKernel";
constexpr int32_t kDeviceId = 0;
constexpr size_t kSimdStackBudget = 64U * 1024U;
constexpr uint32_t kStackElementCount = 12U * 1024U;
constexpr size_t kStackDataBytes = kStackElementCount * sizeof(uint32_t);
constexpr uint32_t kSeed = 11U;

struct RuntimeResources {
    aclrtStream stream = nullptr;
    aclrtBinHandle binary = nullptr;
    uint32_t* outputDevice = nullptr;
    bool initialized = false;
    bool deviceSet = false;
    bool streamCreated = false;
};

void RecordCleanupError(const char* operation, aclError error, int32_t& result)
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("%s failed, error code %d.", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

int32_t ConfigureSimdStackBudget()
{
    // Configure the process-wide budget before binding a Device so the next Device setup applies it.
    CHECK_ERROR(aclrtDeviceSetLimit(ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE, kSimdStackBudget));
    size_t configuredBudget = 0U;
    CHECK_ERROR(aclrtDeviceGetLimit(ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE, &configuredBudget));
    if (configuredBudget != kSimdStackBudget) {
        ERROR_LOG("SIMD stack budget is %zu bytes, expected %zu bytes.", configuredBudget, kSimdStackBudget);
        return -1;
    }
    INFO_LOG("Configured and verified the SIMD stack budget: %zu bytes.", configuredBudget);
    return 0;
}

int32_t InitializeRuntime(const char* binaryPath, RuntimeResources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.initialized = true;
    if (ConfigureSimdStackBudget() != 0) {
        return -1;
    }
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    resources.streamCreated = true;
    CHECK_ERROR(aclrtBinaryLoadFromFile(binaryPath, nullptr, &resources.binary));
    CHECK_ERROR(
        aclrtMalloc(reinterpret_cast<void**>(&resources.outputDevice), sizeof(uint32_t), ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

uint32_t CalculateExpectedChecksum()
{
    uint32_t checksum = 0U;
    for (uint32_t index = 0U; index < kStackElementCount; ++index) {
        checksum += kSeed + index % 97U;
    }
    return checksum;
}

int32_t ExecuteAndVerifyKernel(RuntimeResources& resources)
{
    aclrtFuncHandle function = nullptr;
    CHECK_ERROR(aclrtBinaryGetFunction(resources.binary, kFunctionName, &function));
    uint32_t seed = kSeed;
    void* arguments[] = {&resources.outputDevice, &seed};
    CHECK_ERROR(aclrtLaunchKernelWithArgsArray(function, 1U, resources.stream, nullptr, arguments));
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));

    uint32_t actual = 0U;
    CHECK_ERROR(
        aclrtMemcpy(&actual, sizeof(actual), resources.outputDevice, sizeof(actual), ACL_MEMCPY_DEVICE_TO_HOST));
    const uint32_t expected = CalculateExpectedChecksum();
    if (actual != expected) {
        ERROR_LOG("Kernel checksum is %u, expected %u.", actual, expected);
        return -1;
    }
    INFO_LOG("Verified Kernel checksum %u using %zu bytes of local stack data.", actual, kStackDataBytes);
    return 0;
}

int32_t ReleaseResources(RuntimeResources& resources, int32_t result)
{
    if (resources.streamCreated) {
        RecordCleanupError("aclrtSynchronizeStream", aclrtSynchronizeStream(resources.stream), result);
    }
    if (resources.outputDevice != nullptr) {
        RecordCleanupError("aclrtFree(outputDevice)", aclrtFree(resources.outputDevice), result);
    }
    if (resources.binary != nullptr) {
        RecordCleanupError("aclrtBinaryUnLoad", aclrtBinaryUnLoad(resources.binary), result);
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

int32_t RunSimdStackBudgetSample(const char* binaryPath)
{
    RuntimeResources resources;
    int32_t result = InitializeRuntime(binaryPath, resources);
    if (result == 0) {
        result = ExecuteAndVerifyKernel(resources);
    }
    return ReleaseResources(resources, result);
}
} // namespace

int32_t main(int32_t argc, char* argv[])
{
    INFO_LOG("Start to run the 10_simd_stack_budget sample.");
    if (argc != 2) {
        ERROR_LOG("Usage: %s <absolute_kernel_binary_path>", argv[0]);
        return -1;
    }
    if (RunSimdStackBudgetSample(argv[1]) != 0) {
        ERROR_LOG("Run the 10_simd_stack_budget sample failed.");
        return -1;
    }
    INFO_LOG("Run the 10_simd_stack_budget sample successfully.");
    return 0;
}
