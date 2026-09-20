/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * This sample reuses one aclDataBuffer for device payloads with different addresses and valid lengths.
 */

#include <cstddef>
#include <cstdint>
#include <vector>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kShortPayloadSize = 37U;
constexpr size_t kLongPayloadSize = 83U;

struct RuntimeResources {
    void* shortDeviceBuffer = nullptr;
    void* longDeviceBuffer = nullptr;
    aclDataBuffer* dataBuffer = nullptr;
    bool aclInitialized = false;
    bool deviceSet = false;
};

void UpdateFinalResultOnError(const char* apiName, aclError ret, int32_t& finalResult)
{
    if (ret == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    finalResult = -1;
}

std::vector<uint8_t> CreatePayload(size_t size, uint32_t seed)
{
    std::vector<uint8_t> payload(size);
    for (size_t index = 0U; index < payload.size(); ++index) {
        payload[index] = static_cast<uint8_t>((seed + static_cast<uint32_t>(index) * 17U) & 0xFFU);
    }
    return payload;
}

int32_t InitializeRuntime(RuntimeResources* resources)
{
    // Initialize ACL and bind the process to device 0.
    CHECK_ERROR(aclInit(nullptr));
    resources->aclInitialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources->deviceSet = true;
    return 0;
}

int32_t AllocateAndPrepareBuffers(
    const std::vector<uint8_t>& shortPayload, const std::vector<uint8_t>& longPayload, RuntimeResources* resources)
{
    // Allocate two 32-byte-aligned device regions for payloads with different valid lengths.
    CHECK_ERROR(aclrtMallocAlign32(&resources->shortDeviceBuffer, shortPayload.size(), ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMallocAlign32(&resources->longDeviceBuffer, longPayload.size(), ACL_MEM_MALLOC_HUGE_FIRST));

    // Populate both regions so each descriptor binding can be verified independently.
    CHECK_ERROR(aclrtMemcpy(
        resources->shortDeviceBuffer, shortPayload.size(), shortPayload.data(), shortPayload.size(),
        ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMemcpy(
        resources->longDeviceBuffer, longPayload.size(), longPayload.data(), longPayload.size(),
        ACL_MEMCPY_HOST_TO_DEVICE));
    return 0;
}

int32_t VerifyDataBuffer(
    const aclDataBuffer* dataBuffer, void* expectedAddress, const std::vector<uint8_t>& expectedPayload,
    const char* payloadName)
{
    void* actualAddress = aclGetDataBufferAddr(dataBuffer);
    if (actualAddress != expectedAddress) {
        ERROR_LOG("%s address mismatch: expected %p, actual %p", payloadName, expectedAddress, actualAddress);
        return -1;
    }
    const size_t actualSize = aclGetDataBufferSizeV2(dataBuffer);
    if (actualSize != expectedPayload.size()) {
        ERROR_LOG("%s size mismatch: expected %zu, actual %zu", payloadName, expectedPayload.size(), actualSize);
        return -1;
    }

    // Read through the address and valid length held by the descriptor, then compare every byte.
    std::vector<uint8_t> actualPayload(actualSize, 0U);
    CHECK_ERROR(
        aclrtMemcpy(actualPayload.data(), actualPayload.size(), actualAddress, actualSize, ACL_MEMCPY_DEVICE_TO_HOST));
    for (size_t index = 0U; index < expectedPayload.size(); ++index) {
        if (actualPayload[index] != expectedPayload[index]) {
            ERROR_LOG(
                "%s data mismatch at byte %zu: expected %u, actual %u", payloadName, index,
                static_cast<uint32_t>(expectedPayload[index]), static_cast<uint32_t>(actualPayload[index]));
            return -1;
        }
    }
    INFO_LOG(
        "Verified %s binding: address=%p, size=%zu bytes, content matched", payloadName, actualAddress, actualSize);
    return 0;
}

int32_t ReuseDataBuffer(
    const std::vector<uint8_t>& shortPayload, const std::vector<uint8_t>& longPayload, RuntimeResources* resources)
{
    // Create one descriptor for the short payload and validate its initial binding.
    resources->dataBuffer = aclCreateDataBuffer(resources->shortDeviceBuffer, shortPayload.size());
    if (resources->dataBuffer == nullptr) {
        ERROR_LOG("Operation failed: aclCreateDataBuffer returned nullptr");
        return -1;
    }
    if (VerifyDataBuffer(resources->dataBuffer, resources->shortDeviceBuffer, shortPayload, "short payload") != 0) {
        return -1;
    }

    // Rebind the same descriptor to the longer payload and validate the updated state.
    CHECK_ERROR(aclUpdateDataBuffer(resources->dataBuffer, resources->longDeviceBuffer, longPayload.size()));
    INFO_LOG("Updated one aclDataBuffer from %zu to %zu bytes", shortPayload.size(), longPayload.size());
    return VerifyDataBuffer(resources->dataBuffer, resources->longDeviceBuffer, longPayload, "long payload");
}

void ReleaseResources(RuntimeResources& resources, int32_t& finalResult)
{
    // Destroy the descriptor before releasing the device memory it references.
    if (resources.dataBuffer != nullptr) {
        UpdateFinalResultOnError(
            "aclDestroyDataBuffer(resources.dataBuffer)", aclDestroyDataBuffer(resources.dataBuffer), finalResult);
    }
    if (resources.longDeviceBuffer != nullptr) {
        UpdateFinalResultOnError(
            "aclrtFree(resources.longDeviceBuffer)", aclrtFree(resources.longDeviceBuffer), finalResult);
    }
    if (resources.shortDeviceBuffer != nullptr) {
        UpdateFinalResultOnError(
            "aclrtFree(resources.shortDeviceBuffer)", aclrtFree(resources.shortDeviceBuffer), finalResult);
    }
    if (resources.deviceSet) {
        UpdateFinalResultOnError("aclrtResetDeviceForce(kDeviceId)", aclrtResetDeviceForce(kDeviceId), finalResult);
    }
    if (resources.aclInitialized) {
        UpdateFinalResultOnError("aclFinalize()", aclFinalize(), finalResult);
    }
}

int32_t RunReusableDataBufferSample()
{
    const std::vector<uint8_t> shortPayload = CreatePayload(kShortPayloadSize, 0x21U);
    const std::vector<uint8_t> longPayload = CreatePayload(kLongPayloadSize, 0xA5U);
    RuntimeResources resources;

    int32_t result = InitializeRuntime(&resources);
    if (result == 0) {
        result = AllocateAndPrepareBuffers(shortPayload, longPayload, &resources);
    }
    if (result == 0) {
        result = ReuseDataBuffer(shortPayload, longPayload, &resources);
    }

    int32_t finalResult = result;
    ReleaseResources(resources, finalResult);
    if (finalResult == 0) {
        INFO_LOG("[SUCCESS] Reusable data buffer sample completed successfully");
    }
    return finalResult;
}
} // namespace

int32_t main() { return RunReusableDataBufferSample(); }
