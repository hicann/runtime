/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "watershed_image_staging.h"

#include <algorithm>
#include <cstddef>
#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr size_t kImageCount = 3;
constexpr size_t kWidth = 512;
constexpr size_t kHeight = 512;
constexpr size_t kHostPitch = 544;
constexpr size_t kDevicePitch = 576;
constexpr size_t kHostBytes = kHostPitch * kHeight;
constexpr size_t kDeviceBytes = kDevicePitch * kHeight;
constexpr uint8_t kInputPadding = 0xA5U;
constexpr uint8_t kOutputPadding = 0xCDU;
constexpr uint32_t kStreamFlags = ACL_STREAM_FAST_SYNC;

struct Resources {
    bool initialized = false;
    bool deviceSet = false;
    aclrtStream stream = nullptr;
    uint8_t* input = nullptr;
    uint8_t* output = nullptr;
    void* device = nullptr;
};

uint8_t PixelValue(size_t imageIndex, size_t row, size_t column)
{
    return static_cast<uint8_t>((imageIndex * 53U + row * 3U + column * 5U) % 251U);
}

int Initialize(Resources& resources)
{
    CHECK_ERROR(aclInit(nullptr));
    resources.initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    resources.deviceSet = true;
    CHECK_ERROR(aclrtCreateStreamWithConfig(&resources.stream, 0, kStreamFlags));
    return 0;
}

int32_t QueryPackageVersion(char* packageName)
{
    int32_t version = -1;
    const aclError ret = aclsysGetVersionNum(packageName, &version);
    if (ret != ACL_SUCCESS) {
        WARN_LOG(
            "Optional package version query failed: package=%s, error code=%d.", packageName,
            static_cast<int32_t>(ret));
    }
    return version;
}

int ValidateEnvironment(const Resources& resources)
{
    char runtimePackage[] = "runtime";
    char driverPackage[] = "driver";
    const int32_t runtimeVersion = QueryPackageVersion(runtimePackage);
    const int32_t driverVersion = QueryPackageVersion(driverPackage);
    int32_t currentDevice = -1;
    int64_t globalMemory = 0;
    uint32_t streamFlags = 0;
    CHECK_ERROR(aclrtGetDevice(&currentDevice));
    CHECK_ERROR(aclrtGetDeviceInfo(kDeviceId, ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE, &globalMemory));
    CHECK_ERROR(aclrtStreamGetFlags(resources.stream, &streamFlags));
    if (currentDevice != kDeviceId) {
        ERROR_LOG("Current Device mismatch: actual=%d, expected=%d", currentDevice, kDeviceId);
        return -1;
    }
    if (globalMemory < static_cast<int64_t>(kDeviceBytes)) {
        ERROR_LOG(
            "Device memory is too small: available=%lld, required=%zu", static_cast<long long>(globalMemory),
            kDeviceBytes);
        return -1;
    }
    if (streamFlags != kStreamFlags) {
        ERROR_LOG("Stream flag mismatch: actual=0x%x, expected=0x%x", streamFlags, kStreamFlags);
        return -1;
    }
    INFO_LOG(
        "Environment verified: runtime=%d, driver=%d, Device=%d, global memory=%lld bytes, Stream flag=0x%x.",
        runtimeVersion, driverVersion, currentDevice, static_cast<long long>(globalMemory), streamFlags);
    return 0;
}

int AllocateBuffers(Resources& resources)
{
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.input), kHostBytes));
    CHECK_ERROR(aclrtMallocHost(reinterpret_cast<void**>(&resources.output), kHostBytes));
    CHECK_ERROR(aclrtMalloc(&resources.device, kDeviceBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    return 0;
}

void PrepareImage(Resources& resources, size_t imageIndex)
{
    std::fill_n(resources.output, kHostBytes, kOutputPadding);
    for (size_t row = 0; row < kHeight; ++row) {
        uint8_t* inputRow = resources.input + row * kHostPitch;
        std::fill_n(inputRow, kHostPitch, kInputPadding);
        for (size_t column = 0; column < kWidth; ++column) {
            inputRow[column] = PixelValue(imageIndex, row, column);
        }
    }
}

int VerifyImage(const Resources& resources, size_t imageIndex, uint64_t& checksum)
{
    checksum = 0;
    for (size_t row = 0; row < kHeight; ++row) {
        const uint8_t* outputRow = resources.output + row * kHostPitch;
        for (size_t column = 0; column < kWidth; ++column) {
            const uint8_t expected = PixelValue(imageIndex, row, column);
            if (outputRow[column] != expected) {
                ERROR_LOG(
                    "Pixel mismatch in image %zu at (%zu, %zu): actual=%u, expected=%u", imageIndex, row, column,
                    outputRow[column], expected);
                return -1;
            }
            checksum += outputRow[column];
        }
        for (size_t column = kWidth; column < kHostPitch; ++column) {
            if (outputRow[column] != kOutputPadding) {
                ERROR_LOG("Host padding was overwritten in image %zu at (%zu, %zu).", imageIndex, row, column);
                return -1;
            }
        }
    }
    return 0;
}

int TransferImages(Resources& resources)
{
    for (size_t imageIndex = 0; imageIndex < kImageCount; ++imageIndex) {
        PrepareImage(resources, imageIndex);
        CHECK_ERROR(aclrtMemcpy2dAsync(
            resources.device, kDevicePitch, resources.input, kHostPitch, kWidth, kHeight, ACL_MEMCPY_HOST_TO_DEVICE,
            resources.stream));
        CHECK_ERROR(aclrtMemcpy2dAsync(
            resources.output, kHostPitch, resources.device, kDevicePitch, kWidth, kHeight, ACL_MEMCPY_DEVICE_TO_HOST,
            resources.stream));
        CHECK_ERROR(aclrtSynchronizeStream(resources.stream));
        uint64_t checksum = 0;
        if (VerifyImage(resources, imageIndex, checksum) != 0) {
            return -1;
        }
        INFO_LOG(
            "Image %zu staging verified: %zu pixels, checksum=%llu.", imageIndex, kWidth * kHeight,
            static_cast<unsigned long long>(checksum));
    }
    return 0;
}

void UpdateCleanupResult(const char* expression, aclError ret, int& result)
{
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", expression, static_cast<int32_t>(ret));
        result = -1;
    }
}

int Cleanup(Resources& resources)
{
    int result = 0;
    if (resources.stream != nullptr) {
        UpdateCleanupResult("aclrtSynchronizeStream", aclrtSynchronizeStream(resources.stream), result);
    }
    if (resources.device != nullptr) {
        UpdateCleanupResult("aclrtFree", aclrtFree(resources.device), result);
    }
    if (resources.input != nullptr) {
        UpdateCleanupResult("aclrtFreeHost(input)", aclrtFreeHost(resources.input), result);
    }
    if (resources.output != nullptr) {
        UpdateCleanupResult("aclrtFreeHost(output)", aclrtFreeHost(resources.output), result);
    }
    if (resources.stream != nullptr) {
        UpdateCleanupResult("aclrtDestroyStream", aclrtDestroyStream(resources.stream), result);
    }
    if (resources.deviceSet) {
        UpdateCleanupResult("aclrtResetDevice", aclrtResetDevice(kDeviceId), result);
    }
    if (resources.initialized) {
        UpdateCleanupResult("aclFinalize", aclFinalize(), result);
    }
    return result;
}
} // namespace

int RunWatershedImageStaging()
{
    Resources resources;
    int result = Initialize(resources);
    if (result == 0) {
        result = ValidateEnvironment(resources);
    }
    if (result == 0) {
        result = AllocateBuffers(resources);
    }
    if (result == 0) {
        result = TransferImages(resources);
    }
    if (Cleanup(resources) != 0) {
        result = -1;
    }
    return result;
}
