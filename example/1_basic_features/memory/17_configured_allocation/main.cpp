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
constexpr int32_t kDeviceId = 0;
constexpr uint16_t kApplicationModuleId = 33U;
constexpr size_t kElementCount = 1024U;
constexpr size_t kBufferBytes = kElementCount * sizeof(uint32_t);
constexpr uint32_t kValueBase = 0x12340000U;
constexpr uint32_t kValueStride = 17U;

struct RuntimeResources {
    void* inputHost = nullptr;
    void* outputHost = nullptr;
    void* stagingDevice = nullptr;
    void* cachedDevice = nullptr;
    aclrtStream stream = nullptr;
    bool initialized = false;
    bool deviceSet = false;
};

void RecordError(const char* apiName, aclError ret, int32_t& result)
{
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
        result = -1;
    }
}

uint32_t ExpectedValue(size_t index) { return kValueBase + static_cast<uint32_t>(index) * kValueStride; }

int32_t InitializeRuntime(RuntimeResources& resources)
{
    // Initialize and bind a single device.
    CHECK_ERROR(aclInit(nullptr));
    resources.initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    return 0;
}

int32_t AllocateBuffers(RuntimeResources& resources)
{
    // Tag configured allocations as application memory for diagnostics.
    aclrtMallocAttribute attribute{};
    attribute.attr = ACL_RT_MEM_ATTR_MODULE_ID;
    attribute.value.moduleId = kApplicationModuleId;
    aclrtMallocConfig config{&attribute, 1U};
    CHECK_ERROR(aclrtMallocHostWithCfg(&resources.inputHost, kBufferBytes, &config));
    CHECK_ERROR(aclrtMallocHostWithCfg(&resources.outputHost, kBufferBytes, &config));
    CHECK_ERROR(aclrtMallocWithCfg(&resources.stagingDevice, kBufferBytes, ACL_MEM_MALLOC_NORMAL_ONLY, &config));
    CHECK_ERROR(aclrtMallocCached(&resources.cachedDevice, kBufferBytes, ACL_MEM_MALLOC_NORMAL_ONLY));
    CHECK_ERROR(aclrtCreateStream(&resources.stream));
    auto* input = static_cast<uint32_t*>(resources.inputHost);
    auto* output = static_cast<uint32_t*>(resources.outputHost);
    for (size_t index = 0U; index < kElementCount; ++index) {
        input[index] = ExpectedValue(index);
        output[index] = 0U;
    }
    INFO_LOG(
        "Configured Host and staging buffers: %zu bytes, application module ID %u", kBufferBytes, kApplicationModuleId);
    return 0;
}

int32_t ValidateDeviceBuffers(const RuntimeResources& resources)
{
    // Reject buffers outside the ordinary Device-memory copy path.
    void* addresses[] = {resources.stagingDevice, resources.cachedDevice};
    uint32_t matched = 0U;
    CHECK_ERROR(aclrtCheckMemType(addresses, 2U, ACL_RT_MEM_TYPE_DEV, &matched, 0U));
    if (matched != 1U) {
        ERROR_LOG("Configured and cached buffers do not both match Device memory");
        return -1;
    }
    INFO_LOG("Verified both Device buffers match ACL_RT_MEM_TYPE_DEV");
    return 0;
}

int32_t QueryLocation(const void* pointer, aclrtPtrAttributes& attributes)
{
    CHECK_ERROR(aclrtPointerGetAttributes(pointer, &attributes));
    if (attributes.location.type == ACL_MEM_LOCATION_TYPE_DEVICE) {
        if (attributes.location.id != static_cast<uint32_t>(kDeviceId)) {
            ERROR_LOG("Buffer belongs to a different Device: %u", attributes.location.id);
            return -1;
        }
    } else if (attributes.location.type != ACL_MEM_LOCATION_TYPE_HOST) {
        ERROR_LOG("Unsupported buffer location: %d", static_cast<int32_t>(attributes.location.type));
        return -1;
    }
    return 0;
}

int32_t CopyByLocation(void* destination, const void* source, aclrtStream stream)
{
    // Select the transfer direction from queried locations, never from pointer values.
    aclrtPtrAttributes sourceAttributes{};
    aclrtPtrAttributes destinationAttributes{};
    if (QueryLocation(source, sourceAttributes) != 0 || QueryLocation(destination, destinationAttributes) != 0) {
        return -1;
    }
    const bool sourceOnDevice = sourceAttributes.location.type == ACL_MEM_LOCATION_TYPE_DEVICE;
    const bool destinationOnDevice = destinationAttributes.location.type == ACL_MEM_LOCATION_TYPE_DEVICE;
    aclrtMemcpyKind kind = ACL_MEMCPY_HOST_TO_DEVICE;
    const char* direction = "Host -> Device";
    if (sourceOnDevice && destinationOnDevice) {
        kind = ACL_MEMCPY_DEVICE_TO_DEVICE;
        direction = "Device -> Device";
    } else if (sourceOnDevice && !destinationOnDevice) {
        kind = ACL_MEMCPY_DEVICE_TO_HOST;
        direction = "Device -> Host";
    } else if (!destinationOnDevice) {
        ERROR_LOG("This transfer path requires at least one Device buffer");
        return -1;
    }
    CHECK_ERROR(aclrtMemcpyAsync(destination, kBufferBytes, source, kBufferBytes, kind, stream));
    INFO_LOG(
        "Selected %s from pointer attributes (source page %u, destination page %u)", direction,
        sourceAttributes.pageSize, destinationAttributes.pageSize);
    return 0;
}

int32_t TransferPayload(RuntimeResources& resources)
{
    if (ValidateDeviceBuffers(resources) != 0 ||
        CopyByLocation(resources.stagingDevice, resources.inputHost, resources.stream) != 0) {
        return -1;
    }
    // Retire the input only after its asynchronous upload finishes.
    CHECK_ERROR(aclrtFreeHostWithDevSync(resources.inputHost));
    resources.inputHost = nullptr;
    INFO_LOG("Released Host input after implicit Device synchronization");
    if (CopyByLocation(resources.cachedDevice, resources.stagingDevice, resources.stream) != 0 ||
        CopyByLocation(resources.outputHost, resources.cachedDevice, resources.stream) != 0) {
        return -1;
    }
    // This release also waits for the download before Host verification.
    CHECK_ERROR(aclrtFreeWithDevSync(resources.cachedDevice));
    resources.cachedDevice = nullptr;
    INFO_LOG("Released cached Device buffer after implicit Device synchronization");
    return 0;
}

int32_t VerifyPayload(const RuntimeResources& resources)
{
    const auto* output = static_cast<const uint32_t*>(resources.outputHost);
    for (size_t index = 0U; index < kElementCount; ++index) {
        const uint32_t expected = ExpectedValue(index);
        if (output[index] != expected) {
            ERROR_LOG("Mismatch at element %zu: expected %u, got %u", index, expected, output[index]);
            return -1;
        }
    }
    INFO_LOG("Verified %zu elements after Host -> configured Device -> cached Device -> Host", kElementCount);
    return 0;
}

void Cleanup(RuntimeResources& resources, int32_t& result)
{
    // Drain pending work on failure, then release resources in reverse order.
    if (resources.stream != nullptr) {
        RecordError("aclrtSynchronizeStream", aclrtSynchronizeStream(resources.stream), result);
        RecordError("aclrtDestroyStreamForce", aclrtDestroyStreamForce(resources.stream), result);
    }
    if (resources.cachedDevice != nullptr) {
        RecordError("aclrtFreeWithDevSync(cached)", aclrtFreeWithDevSync(resources.cachedDevice), result);
    }
    if (resources.stagingDevice != nullptr) {
        RecordError("aclrtFreeWithDevSync(staging)", aclrtFreeWithDevSync(resources.stagingDevice), result);
    }
    if (resources.outputHost != nullptr) {
        RecordError("aclrtFreeHostWithDevSync(output)", aclrtFreeHostWithDevSync(resources.outputHost), result);
    }
    if (resources.inputHost != nullptr) {
        RecordError("aclrtFreeHostWithDevSync(input)", aclrtFreeHostWithDevSync(resources.inputHost), result);
    }
    if (resources.deviceSet) {
        RecordError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (resources.initialized) {
        RecordError("aclFinalize", aclFinalize(), result);
    }
}
} // namespace

int32_t main()
{
    RuntimeResources resources;
    int32_t result = InitializeRuntime(resources);
    if (result == 0) {
        result = AllocateBuffers(resources);
    }
    if (result == 0) {
        result = TransferPayload(resources);
    }
    if (result == 0) {
        result = VerifyPayload(resources);
    }
    Cleanup(resources, result);
    if (result == 0) {
        INFO_LOG("[SUCCESS] Configured allocation sample completed successfully");
    } else {
        ERROR_LOG("[FAILURE] Configured allocation sample failed");
    }
    return result;
}
