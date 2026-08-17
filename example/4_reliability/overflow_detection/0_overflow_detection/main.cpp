/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <algorithm>
#include <cstddef>
#include <cstdint>
#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr size_t kOverflowStatusBufferSize = 64;

uint32_t ReadOverflowFlag(const uint8_t* statusBuffer)
{
    uint32_t overflowFlag = 0;
    std::copy_n(statusBuffer, sizeof(overflowFlag), reinterpret_cast<unsigned char*>(&overflowFlag));
    return overflowFlag;
}

const char* OverflowModeToString(aclrtFloatOverflowMode mode)
{
    switch (mode) {
        case ACL_RT_OVERFLOW_MODE_SATURATION:
            return "ACL_RT_OVERFLOW_MODE_SATURATION";
        case ACL_RT_OVERFLOW_MODE_INFNAN:
            return "ACL_RT_OVERFLOW_MODE_INFNAN";
        case ACL_RT_OVERFLOW_MODE_UNDEF:
            return "ACL_RT_OVERFLOW_MODE_UNDEF";
        default:
            return "ACL_RT_OVERFLOW_MODE_UNKNOWN";
    }
}

int32_t HandleOptionalOverflowRet(const char* apiName, aclError ret, const char* reason)
{
    if (ret == ACL_SUCCESS) {
        return 0;
    }
    if (ret == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
        WARN_LOG(
            "%s is unavailable in the current environment (ret=%d): %s", apiName, static_cast<int32_t>(ret), reason);
        return 1;
    }
    ERROR_LOG("Operation failed: %s returned error code %d", apiName, static_cast<int32_t>(ret));
    return -1;
}
} // namespace

int main()
{
    const int32_t deviceId = 0;
    aclrtContext context = nullptr;
    aclrtStream stream = nullptr;
    uint8_t* statusDevice = nullptr;
    aclrtFloatOverflowMode originalMode = ACL_RT_OVERFLOW_MODE_UNDEF;
    aclrtFloatOverflowMode currentMode = ACL_RT_OVERFLOW_MODE_UNDEF;
    bool aclInitialized = false;
    bool deviceSet = false;
    bool contextCreated = false;
    bool streamCreated = false;
    bool statusAllocated = false;
    bool saturationModeChanged = false;

    int32_t finalResult = [&]() -> int32_t {
        CHECK_ERROR(aclInit(nullptr));
        aclInitialized = true;

        CHECK_ERROR(aclrtSetDevice(deviceId));
        deviceSet = true;

        CHECK_ERROR(aclrtCreateContext(&context, deviceId));
        contextCreated = true;

        const int32_t getModeStatus = HandleOptionalOverflowRet(
            "aclrtGetDeviceSatMode(&originalMode)", aclrtGetDeviceSatMode(&originalMode),
            "the current device/runtime does not expose device saturation mode");
        if (getModeStatus < 0) {
            return -1;
        }
        if (getModeStatus > 0) {
            WARN_LOG("Overflow detection is unavailable in the current environment, sample finished after probing.");
            return 0;
        }

        const int32_t setModeStatus = HandleOptionalOverflowRet(
            "aclrtSetDeviceSatMode(ACL_RT_OVERFLOW_MODE_SATURATION)",
            aclrtSetDeviceSatMode(ACL_RT_OVERFLOW_MODE_SATURATION),
            "stream overflow detection requires saturation mode and is only supported on specific products/runtime "
            "builds");
        if (setModeStatus < 0) {
            return -1;
        }
        if (setModeStatus > 0) {
            WARN_LOG("Overflow detection is unavailable in the current environment, sample finished after probing.");
            return 0;
        }
        saturationModeChanged = true;

        CHECK_ERROR(aclrtGetDeviceSatMode(&currentMode));
        INFO_LOG(
            "Device saturation mode switched from %s to %s.", OverflowModeToString(originalMode),
            OverflowModeToString(currentMode));

        CHECK_ERROR(aclrtCreateStream(&stream));
        streamCreated = true;

        const int32_t setOverflowSwitchStatus = HandleOptionalOverflowRet(
            "aclrtSetStreamOverflowSwitch(stream, 1)", aclrtSetStreamOverflowSwitch(stream, 1),
            "the current environment does not expose stream-level overflow detection even in saturation mode");
        if (setOverflowSwitchStatus < 0) {
            return -1;
        }
        if (setOverflowSwitchStatus > 0) {
            WARN_LOG(
                "Stream overflow detection is unavailable in the current environment, sample finished after probing.");
            return 0;
        }

        uint32_t queriedSwitch = 0;
        CHECK_ERROR(aclrtGetStreamOverflowSwitch(stream, &queriedSwitch));
        INFO_LOG("Overflow switch=%u", queriedSwitch);

        CHECK_ERROR(
            aclrtMalloc(reinterpret_cast<void**>(&statusDevice), kOverflowStatusBufferSize, ACL_MEM_MALLOC_HUGE_FIRST));
        statusAllocated = true;

        uint8_t statusHost[kOverflowStatusBufferSize] = {};
        uint32_t overflowFlag = 0;

        CHECK_ERROR(aclrtGetOverflowStatus(statusDevice, kOverflowStatusBufferSize, stream));
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        CHECK_ERROR(aclrtMemcpy(
            statusHost, sizeof(statusHost), statusDevice, kOverflowStatusBufferSize, ACL_MEMCPY_DEVICE_TO_HOST));
        overflowFlag = ReadOverflowFlag(statusHost);
        INFO_LOG("Overflow status before reset=%u", overflowFlag);

        CHECK_ERROR(aclrtResetOverflowStatus(stream));
        CHECK_ERROR(aclrtSynchronizeStream(stream));

        std::fill_n(statusHost, kOverflowStatusBufferSize, static_cast<uint8_t>(0));
        overflowFlag = 0;
        CHECK_ERROR(aclrtGetOverflowStatus(statusDevice, kOverflowStatusBufferSize, stream));
        CHECK_ERROR(aclrtSynchronizeStream(stream));
        CHECK_ERROR(aclrtMemcpy(
            statusHost, sizeof(statusHost), statusDevice, kOverflowStatusBufferSize, ACL_MEMCPY_DEVICE_TO_HOST));
        overflowFlag = ReadOverflowFlag(statusHost);
        INFO_LOG("Overflow status after reset=%u", overflowFlag);
        return 0;
    }();

    if (statusAllocated) {
        const aclError freeRet = aclrtFree(statusDevice);
        if (freeRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: aclrtFree(statusDevice) returned error code %d", static_cast<int32_t>(freeRet));
            finalResult = -1;
        }
    }
    if (saturationModeChanged) {
        const aclError restoreModeRet = aclrtSetDeviceSatMode(originalMode);
        if (restoreModeRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: aclrtSetDeviceSatMode(originalMode) returned error code %d",
                static_cast<int32_t>(restoreModeRet));
            finalResult = -1;
        }
    }
    if (streamCreated) {
        const aclError destroyStreamRet = aclrtDestroyStream(stream);
        if (destroyStreamRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: aclrtDestroyStream(stream) returned error code %d",
                static_cast<int32_t>(destroyStreamRet));
            finalResult = -1;
        }
    }
    if (contextCreated) {
        const aclError destroyContextRet = aclrtDestroyContext(context);
        if (destroyContextRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: aclrtDestroyContext(context) returned error code %d",
                static_cast<int32_t>(destroyContextRet));
            finalResult = -1;
        }
    }
    if (deviceSet) {
        const aclError resetDeviceRet = aclrtResetDeviceForce(deviceId);
        if (resetDeviceRet != ACL_SUCCESS) {
            ERROR_LOG(
                "Operation failed: aclrtResetDeviceForce(deviceId) returned error code %d",
                static_cast<int32_t>(resetDeviceRet));
            finalResult = -1;
        }
    }
    if (aclInitialized) {
        const aclError finalizeRet = aclFinalize();
        if (finalizeRet != ACL_SUCCESS) {
            ERROR_LOG("Operation failed: aclFinalize() returned error code %d", static_cast<int32_t>(finalizeRet));
            finalResult = -1;
        }
    }
    if (finalResult == 0) {
        INFO_LOG("Overflow detection sample finished successfully.");
    }
    return finalResult;
}
