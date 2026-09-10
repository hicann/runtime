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
#include <fstream>
#include <vector>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr char kBinaryPath[] = "./out/fatbin/memory_add_kernel/memory_add_kernel.o";
constexpr int32_t kDeviceId = 0;
constexpr uint32_t kBlockDim = 8U;
constexpr size_t kElementCount = 8U * 2048U;

struct Resources {
    aclrtStream stream = nullptr;
    aclrtBinHandle binary = nullptr;
    void* xDevice = nullptr;
    void* yDevice = nullptr;
    void* zDevice = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
};

bool ReadBinary(std::vector<uint8_t>& bytes)
{
    std::ifstream input(kBinaryPath, std::ios::binary | std::ios::ate);
    if (!input.is_open() || input.tellg() <= 0) {
        ERROR_LOG("Cannot read Kernel binary: %s", kBinaryPath);
        return false;
    }
    bytes.resize(static_cast<size_t>(input.tellg()));
    input.seekg(0, std::ios::beg);
    if (!input.read(reinterpret_cast<char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()))) {
        ERROR_LOG("Failed to read %zu bytes from %s", bytes.size(), kBinaryPath);
        return false;
    }
    return true;
}

int Initialize(Resources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    return 0;
}

int Execute(const std::vector<uint8_t>& bytes, Resources& resources)
{
    CHECK_ERROR(aclrtBinaryLoadFromData(bytes.data(), bytes.size(), nullptr, &resources.binary));
    INFO_LOG("Loaded %zu binary bytes from Host memory.", bytes.size());
    aclrtFuncHandle function = nullptr;
    CHECK_ERROR(aclrtBinaryGetFunction(resources.binary, "add_custom", &function));

    std::vector<aclFloat16> x(kElementCount, aclFloatToFloat16(1.0F));
    std::vector<aclFloat16> y(kElementCount, aclFloatToFloat16(2.0F));
    std::vector<aclFloat16> z(kElementCount);
    const size_t dataSize = kElementCount * sizeof(aclFloat16);
    CHECK_ERROR(aclrtMalloc(&resources.xDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources.yDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMalloc(&resources.zDevice, dataSize, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(resources.xDevice, dataSize, x.data(), dataSize, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(resources.yDevice, dataSize, y.data(), dataSize, ACL_MEMCPY_HOST_TO_DEVICE));

    void* args[] = {resources.xDevice, resources.yDevice, resources.zDevice};
    CHECK_ERROR(
        aclrtLaunchKernelWithHostArgs(function, kBlockDim, resources.stream, nullptr, args, sizeof(args), nullptr, 0U));
    CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
    CHECK_ERROR(aclrtMemcpy(z.data(), dataSize, resources.zDevice, dataSize, ACL_MEMCPY_DEVICE_TO_HOST));
    for (size_t i = 0U; i < kElementCount; ++i) {
        const float actual = aclFloat16ToFloat(z[i]);
        if (actual != 3.0F) {
            ERROR_LOG("Result[%zu]=%.1f, expected 3.0", i, actual);
            return -1;
        }
    }
    INFO_LOG("Verified %zu FP16 additions: 1.0 + 2.0 = 3.0.", kElementCount);
    return 0;
}

void RecordCleanup(const char* operation, aclError error, int& result)
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

void Release(Resources& resources, int& result)
{
    if (resources.zDevice != nullptr) {
        RecordCleanup("aclrtFree(zDevice)", aclrtFree(resources.zDevice), result);
    }
    if (resources.yDevice != nullptr) {
        RecordCleanup("aclrtFree(yDevice)", aclrtFree(resources.yDevice), result);
    }
    if (resources.xDevice != nullptr) {
        RecordCleanup("aclrtFree(xDevice)", aclrtFree(resources.xDevice), result);
    }
    if (resources.binary != nullptr) {
        RecordCleanup("aclrtBinaryUnLoad", aclrtBinaryUnLoad(resources.binary), result);
    }
    if (resources.stream != nullptr) {
        RecordCleanup("aclrtDestroyStreamForce", aclrtDestroyStreamForce(resources.stream), result);
    }
    if (resources.deviceSet) {
        RecordCleanup("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (resources.aclInitialized) {
        RecordCleanup("aclFinalize", aclFinalize(), result);
    }
}
} // namespace

int main()
{
    INFO_LOG("Start to run 6_memory_loaded_vector_add sample.");
    std::vector<uint8_t> binaryBytes;
    Resources resources;
    int result = ReadBinary(binaryBytes) ? Initialize(resources) : -1;
    if (result == 0) {
        result = Execute(binaryBytes, resources);
    }
    Release(resources, result);
    if (result != 0) {
        ERROR_LOG("Run the 6_memory_loaded_vector_add sample failed.");
        return -1;
    }
    INFO_LOG("Run the 6_memory_loaded_vector_add sample successfully.");
    return 0;
}
