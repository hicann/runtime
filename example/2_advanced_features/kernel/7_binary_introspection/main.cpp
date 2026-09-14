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
constexpr char kDefaultBinaryPath[] = "./out/fatbin/binary_introspection_kernel/binary_introspection_kernel.o";
constexpr char kFunctionName[] = "binary_introspection_kernel";
constexpr char kGlobalName[] = "g_binary_metadata_value";
constexpr int32_t kDeviceId = 0;
constexpr size_t kExpectedParamCount = 3U;
constexpr uint32_t kGlobalProbeValue = 0x13572468U;

struct Resources {
    aclrtBinary binary = nullptr;
    aclrtBinHandle binHandle = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
};

bool ReadBinary(const char* path, std::vector<uint8_t>& bytes)
{
    std::ifstream input(path, std::ios::binary | std::ios::ate);
    if (!input.is_open() || input.tellg() <= 0) {
        ERROR_LOG("Cannot read Kernel binary: %s", path);
        return false;
    }
    bytes.resize(static_cast<size_t>(input.tellg()));
    input.seekg(0, std::ios::beg);
    if (!input.read(reinterpret_cast<char*>(bytes.data()), static_cast<std::streamsize>(bytes.size()))) {
        ERROR_LOG("Failed to read %zu bytes from %s", bytes.size(), path);
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
    return 0;
}

int LoadBinary(const std::vector<uint8_t>& bytes, Resources& resources)
{
    resources.binary = aclrtCreateBinary(bytes.data(), bytes.size());
    if (resources.binary == nullptr) {
        ERROR_LOG("aclrtCreateBinary returned nullptr.");
        return -1;
    }
    CHECK_ERROR(aclrtBinaryLoad(resources.binary, &resources.binHandle));
    if (resources.binHandle == nullptr) {
        ERROR_LOG("aclrtBinaryLoad returned a null Binary handle.");
        return -1;
    }
    INFO_LOG("Loaded %zu binary bytes from Host memory.", bytes.size());
    return 0;
}

int InspectParameters(aclrtFuncHandle function)
{
    size_t paramCount = 0U;
    CHECK_ERROR(aclrtFunctionGetParamCount(function, &paramCount));
    if (paramCount != kExpectedParamCount) {
        ERROR_LOG("Function has %zu parameters, expected %zu.", paramCount, kExpectedParamCount);
        return -1;
    }

    size_t previousEnd = 0U;
    for (size_t index = 0U; index < paramCount; ++index) {
        size_t offset = 0U;
        size_t size = 0U;
        CHECK_ERROR(aclrtFunctionGetParamInfo(function, index, &offset, &size));
        if ((size == 0U) || ((index > 0U) && (offset < previousEnd))) {
            ERROR_LOG("Invalid parameter layout at index %zu: offset=%zu, size=%zu.", index, offset, size);
            return -1;
        }
        previousEnd = offset + size;
        INFO_LOG("Parameter[%zu]: offset=%zu, size=%zu.", index, offset, size);
    }
    return 0;
}

int InspectFunction(aclrtFuncHandle function, aclrtBinHandle& associatedBinary)
{
    CHECK_ERROR(aclrtFunctionGetBinary(function, &associatedBinary));
    if (associatedBinary == nullptr) {
        ERROR_LOG("aclrtFunctionGetBinary returned a null Binary handle.");
        return -1;
    }
    if (InspectParameters(function) != 0) {
        return -1;
    }

    size_t aicSize = 0U;
    size_t aivSize = 0U;
    CHECK_ERROR(aclrtGetFunctionSize(function, &aicSize, &aivSize));
    if ((aicSize == 0U) && (aivSize == 0U)) {
        ERROR_LOG("Both AI Core and Vector Core code sizes are zero.");
        return -1;
    }

    size_t dynamicUbufSize = 0U;
    CHECK_ERROR(aclrtFunctionGetAvailDynUbufPerBlock(function, 0U, &dynamicUbufSize));
    if (dynamicUbufSize != 0U) {
        ERROR_LOG("Non-SIMT Kernel returned a non-zero dynamic UB size: %zu.", dynamicUbufSize);
        return -1;
    }
    INFO_LOG(
        "Function code size: aic=%zu bytes, aiv=%zu bytes; dynamic UB=%zu bytes.", aicSize, aivSize, dynamicUbufSize);
    return 0;
}

int InspectBinary(const Resources& resources)
{
    void* binaryAddress = nullptr;
    size_t binarySize = 0U;
    CHECK_ERROR(aclrtBinaryGetDevAddress(resources.binHandle, &binaryAddress, &binarySize));
    if ((binaryAddress == nullptr) || (binarySize == 0U)) {
        ERROR_LOG("Loaded Binary has an invalid Device address or size.");
        return -1;
    }

    aclrtFuncHandle function = nullptr;
    CHECK_ERROR(aclrtBinaryGetFunction(resources.binHandle, kFunctionName, &function));
    if (function == nullptr) {
        ERROR_LOG("aclrtBinaryGetFunction returned a null Function handle.");
        return -1;
    }

    aclrtBinHandle associatedBinary = nullptr;
    if (InspectFunction(function, associatedBinary) != 0) {
        return -1;
    }

    void* associatedAddress = nullptr;
    size_t associatedSize = 0U;
    CHECK_ERROR(aclrtBinaryGetDevAddress(associatedBinary, &associatedAddress, &associatedSize));
    if ((associatedAddress != binaryAddress) || (associatedSize != binarySize)) {
        ERROR_LOG("Function does not resolve to the loaded Binary image.");
        return -1;
    }
    INFO_LOG("Binary Device image: address=%p, size=%zu bytes.", binaryAddress, binarySize);

    void* globalAddress = nullptr;
    size_t globalSize = 0U;
    CHECK_ERROR(aclrtBinaryGetGlobal(associatedBinary, kGlobalName, &globalAddress, &globalSize));
    if ((globalAddress == nullptr) || (globalSize < sizeof(kGlobalProbeValue))) {
        ERROR_LOG("Global variable has an invalid Device address or size.");
        return -1;
    }

    uint32_t actualValue = 0U;
    CHECK_ERROR(aclrtMemcpy(
        globalAddress, globalSize, &kGlobalProbeValue, sizeof(kGlobalProbeValue), ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(
        aclrtMemcpy(&actualValue, sizeof(actualValue), globalAddress, sizeof(actualValue), ACL_MEMCPY_DEVICE_TO_HOST));
    if (actualValue != kGlobalProbeValue) {
        ERROR_LOG("Global variable value is 0x%08x, expected 0x%08x.", actualValue, kGlobalProbeValue);
        return -1;
    }
    INFO_LOG("Verified Device global %s: size=%zu bytes, value=0x%08x.", kGlobalName, globalSize, actualValue);
    return 0;
}

void RecordCleanup(const char* operation, aclError error, int& result)
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d.", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

void Release(Resources& resources, int& result)
{
    if (resources.binHandle != nullptr) {
        RecordCleanup("aclrtBinaryUnLoad", aclrtBinaryUnLoad(resources.binHandle), result);
        resources.binHandle = nullptr;
    }
    if (resources.binary != nullptr) {
        RecordCleanup("aclrtDestroyBinary", aclrtDestroyBinary(resources.binary), result);
        resources.binary = nullptr;
    }
    if (resources.deviceSet) {
        RecordCleanup("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
        resources.deviceSet = false;
    }
    if (resources.aclInitialized) {
        RecordCleanup("aclFinalize", aclFinalize(), result);
        resources.aclInitialized = false;
    }
}
} // namespace

int main(int argc, char* argv[])
{
    const char* binaryPath = (argc > 1) ? argv[1] : kDefaultBinaryPath;
    INFO_LOG("Start to run the 7_binary_introspection sample.");

    std::vector<uint8_t> binaryBytes;
    Resources resources;
    int result = ReadBinary(binaryPath, binaryBytes) ? Initialize(resources) : -1;
    if (result == 0) {
        result = LoadBinary(binaryBytes, resources);
    }
    if (result == 0) {
        result = InspectBinary(resources);
    }
    Release(resources, result);

    if (result != 0) {
        ERROR_LOG("Run the 7_binary_introspection sample failed.");
        return -1;
    }
    INFO_LOG("Run the 7_binary_introspection sample successfully.");
    return 0;
}
