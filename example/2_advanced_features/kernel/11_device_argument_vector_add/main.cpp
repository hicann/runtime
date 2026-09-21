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
#include <vector>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr char kFunctionName[] = "add_custom";
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kBlockDim = 8U;
constexpr size_t kElementCount = 8U * 2048U;

struct KernelArgs {
    void* x;
    void* y;
    void* z;
};

static_assert(sizeof(KernelArgs) == 3U * sizeof(void*), "Kernel argument package must contain three addresses");

struct Resources {
    aclrtStream stream = nullptr;
    aclrtBinHandle binary = nullptr;
    aclrtFuncHandle function = nullptr;
    void* xDevice = nullptr;
    void* yDevice = nullptr;
    void* zDevice = nullptr;
    void* argsDevice = nullptr;
    bool initialized = false;
    bool deviceSet = false;
};

float InputX(size_t index) { return static_cast<float>(index % 7U) + 1.0F; }

float InputY(size_t index) { return static_cast<float>(index % 5U) + 2.0F; }

void RecordCleanupError(const char* operation, aclError error, int32_t& result)
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("%s failed, error code %d.", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

int32_t InitializeRuntime(const char* binaryPath, Resources& resources)
{
    // Initialize the single-Device execution resources and load the shared vector Kernel.
    CHECK_ERROR(aclInit(nullptr));
    resources.initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    CHECK_ERROR(aclrtBinaryLoadFromFile(binaryPath, nullptr, &resources.binary));
    CHECK_ERROR(aclrtBinaryGetFunction(resources.binary, kFunctionName, &resources.function));
    return 0;
}

void PrepareInputs(std::vector<aclFloat16>& xHost, std::vector<aclFloat16>& yHost)
{
    for (size_t index = 0U; index < kElementCount; ++index) {
        xHost[index] = aclFloatToFloat16(InputX(index));
        yHost[index] = aclFloatToFloat16(InputY(index));
    }
}

int32_t AllocateAndUploadData(Resources& resources)
{
    // Allocate vector buffers and copy deterministic inputs to the selected Device.
    std::vector<aclFloat16> xHost(kElementCount);
    std::vector<aclFloat16> yHost(kElementCount);
    PrepareInputs(xHost, yHost);
    const size_t dataSize = kElementCount * sizeof(aclFloat16);
    CHECK_ERROR(aclrtMalloc(&resources.xDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources.yDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources.zDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(resources.xDevice, dataSize, xHost.data(), dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(resources.yDevice, dataSize, yHost.data(), dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int32_t UploadDeviceArgumentPackage(Resources& resources)
{
    // Package Kernel arguments on the Host, then retain only the Device copy for asynchronous launch.
    const KernelArgs hostArgs{resources.xDevice, resources.yDevice, resources.zDevice};
    CHECK_ERROR(aclrtMalloc(&resources.argsDevice, sizeof(KernelArgs), ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(
        resources.argsDevice, sizeof(KernelArgs), &hostArgs, sizeof(KernelArgs), ACL_MEMCPY_HOST_TO_DEVICE));
    INFO_LOG("Uploaded a %zu-byte Kernel argument package to Device memory.", sizeof(KernelArgs));
    return 0;
}

int32_t VerifyOutput(const Resources& resources)
{
    std::vector<aclFloat16> output(kElementCount);
    const size_t dataSize = kElementCount * sizeof(aclFloat16);
    CHECK_ERROR(aclrtMemcpy(output.data(), dataSize, resources.zDevice, dataSize, ACL_MEMCPY_DEVICE_TO_HOST));
    for (size_t index = 0U; index < output.size(); ++index) {
        const float actual = aclFloat16ToFloat(output[index]);
        const float expected = InputX(index) + InputY(index);
        if (actual != expected) {
            ERROR_LOG("Result[%zu]=%.1f, expected %.1f.", index, actual, expected);
            return -1;
        }
    }
    INFO_LOG("Verified %zu FP16 vector additions element by element.", output.size());
    return 0;
}

int32_t LaunchAndVerify(Resources& resources)
{
    // Keep the Device argument package alive until the asynchronous Kernel task is complete.
    CHECK_ERROR(aclrtLaunchKernelV2(
        resources.function, kBlockDim, resources.argsDevice, sizeof(KernelArgs), nullptr, resources.stream));
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    CHECK_ERROR(aclrtFree(resources.argsDevice));
    resources.argsDevice = nullptr;
    INFO_LOG("Released the Device argument package after Stream synchronization.");
    return VerifyOutput(resources);
}

int32_t ReleaseResources(Resources& resources, int32_t result)
{
    if (resources.stream != nullptr) {
        RecordCleanupError("aclrtSynchronizeStream", aclrtSynchronizeStream(resources.stream), result);
    }
    if (resources.argsDevice != nullptr) {
        RecordCleanupError("aclrtFree(argsDevice)", aclrtFree(resources.argsDevice), result);
    }
    if (resources.zDevice != nullptr) {
        RecordCleanupError("aclrtFree(zDevice)", aclrtFree(resources.zDevice), result);
    }
    if (resources.yDevice != nullptr) {
        RecordCleanupError("aclrtFree(yDevice)", aclrtFree(resources.yDevice), result);
    }
    if (resources.xDevice != nullptr) {
        RecordCleanupError("aclrtFree(xDevice)", aclrtFree(resources.xDevice), result);
    }
    if (resources.binary != nullptr) {
        RecordCleanupError("aclrtBinaryUnLoad", aclrtBinaryUnLoad(resources.binary), result);
    }
    if (resources.stream != nullptr) {
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

int32_t RunSample(const char* binaryPath)
{
    Resources resources;
    int32_t result = InitializeRuntime(binaryPath, resources);
    if (result == 0) {
        result = AllocateAndUploadData(resources);
    }
    if (result == 0) {
        result = UploadDeviceArgumentPackage(resources);
    }
    if (result == 0) {
        result = LaunchAndVerify(resources);
    }
    return ReleaseResources(resources, result);
}
} // namespace

int32_t main(int32_t argc, char* argv[])
{
    INFO_LOG("Start to run the 11_device_argument_vector_add sample.");
    if (argc != 2) {
        ERROR_LOG("Usage: %s <absolute_kernel_binary_path>", argv[0]);
        return -1;
    }
    if (RunSample(argv[1]) != 0) {
        ERROR_LOG("Run the 11_device_argument_vector_add sample failed.");
        return -1;
    }
    INFO_LOG("Run the 11_device_argument_vector_add sample successfully.");
    return 0;
}
