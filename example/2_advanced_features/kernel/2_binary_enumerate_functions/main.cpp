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
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kFunctionCount = 3U;
constexpr uint32_t kFunctionNameLength = 128U;
constexpr uint32_t kBlockDim = 8U;
constexpr size_t kElementCount = 8U * 2048U;

struct SampleResources {
    aclrtBinHandle binHandle = nullptr;
    aclrtStream stream = nullptr;
    void* xDevice = nullptr;
    void* yDevice = nullptr;
    void* zDevice = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
};

int32_t RunSample(const char* binaryPath, SampleResources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    CHECK_ERROR(aclrtBinaryLoadFromFile(binaryPath, nullptr, &resources.binHandle));

    aclrtFuncHandle functions[kFunctionCount] = {};
    char functionNames[kFunctionCount][kFunctionNameLength] = {};
    INFO_LOG("Enumerating functions in the Kernel binary.");
    CHECK_ERROR(aclrtBinaryEnumerateFunctions(resources.binHandle, functions, kFunctionCount));
    INFO_LOG("aclrtBinaryEnumerateFunctions succeeded.");
    for (uint32_t i = 0U; i < kFunctionCount; ++i) {
        CHECK_ERROR(aclrtGetFunctionName(functions[i], kFunctionNameLength, functionNames[i]));
        INFO_LOG("function[%u]: name=%s, handle=%p", i, functionNames[i], functions[i]);
    }

    std::vector<aclFloat16> x(kElementCount, aclFloatToFloat16(1.0F));
    std::vector<aclFloat16> y(kElementCount, aclFloatToFloat16(2.0F));
    std::vector<aclFloat16> z(kElementCount);
    const size_t dataSize = kElementCount * sizeof(aclFloat16);
    CHECK_ERROR(aclrtMalloc(&resources.xDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources.yDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources.zDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(resources.xDevice, dataSize, x.data(), dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(resources.yDevice, dataSize, y.data(), dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    for (uint32_t i = 0U; i < kFunctionCount; ++i) {
        void* args[] = {resources.xDevice, resources.yDevice, resources.zDevice};
        CHECK_ERROR(aclrtLaunchKernelWithHostArgs(
            functions[i], kBlockDim, resources.stream, nullptr, args, sizeof(args), nullptr, 0U));
        CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
        CHECK_ERROR(aclrtMemcpy(z.data(), dataSize, resources.zDevice, dataSize, ACL_MEMCPY_DEVICE_TO_HOST));
        INFO_LOG("%s result: %.1f", functionNames[i], aclFloat16ToFloat(z[0]));
    }
    return 0;
}

void ReleaseResources(const SampleResources& resources)
{
    if (resources.zDevice != nullptr) {
        CHECK_ERROR_WITHOUT_RETURN(aclrtFree(resources.zDevice));
    }
    if (resources.yDevice != nullptr) {
        CHECK_ERROR_WITHOUT_RETURN(aclrtFree(resources.yDevice));
    }
    if (resources.xDevice != nullptr) {
        CHECK_ERROR_WITHOUT_RETURN(aclrtFree(resources.xDevice));
    }
    if (resources.binHandle != nullptr) {
        CHECK_ERROR_WITHOUT_RETURN(aclrtBinaryUnLoad(resources.binHandle));
    }
    if (resources.stream != nullptr) {
        CHECK_ERROR_WITHOUT_RETURN(aclrtDestroyStreamForce(resources.stream));
    }
    if (resources.deviceSet) {
        CHECK_ERROR_WITHOUT_RETURN(aclrtResetDeviceForce(kDeviceId));
    }
    if (resources.aclInitialized) {
        CHECK_ERROR_WITHOUT_RETURN(aclFinalize());
    }
}
} // namespace

int32_t main(int32_t argc, char* argv[])
{
    const char* binaryPath = (argc > 1) ? argv[1] : "custom_kernels.o";
    SampleResources resources;
    const int32_t result = RunSample(binaryPath, resources);
    ReleaseResources(resources);
    return result;
}
