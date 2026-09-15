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
#include <cstring>
#include <string>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kPciBusIdBufferSize = 13;

std::string UuidToString(const aclrtUuid& uuid)
{
    constexpr char kHexDigits[] = "0123456789abcdef";
    std::string result;
    result.reserve(36U);
    for (std::size_t i = 0U; i < sizeof(uuid.bytes); ++i) {
        if (i == 4U || i == 6U || i == 8U || i == 10U) {
            result.push_back('-');
        }
        const auto value = static_cast<unsigned char>(uuid.bytes[i]);
        result.push_back(kHexDigits[value >> 4U]);
        result.push_back(kHexDigits[value & 0x0FU]);
    }
    return result;
}

int VerifyPciRoundTrip(int32_t userDeviceId)
{
    char pciBusId[kPciBusIdBufferSize] = {};
    aclError ret = aclrtDeviceGetPCIBusId(userDeviceId, pciBusId, static_cast<int32_t>(sizeof(pciBusId)));
    if (ret == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
        WARN_LOG("Skip PCI discovery for user Device %d: the current interconnect is not PCIe.", userDeviceId);
        return 1;
    }
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclrtDeviceGetPCIBusId returned error code %d", static_cast<int32_t>(ret));
        return -1;
    }

    int32_t deviceFromPci = -1;
    ret = aclrtDeviceGetByPCIBusId(pciBusId, &deviceFromPci);
    if (ret == ACL_ERROR_RT_FEATURE_NOT_SUPPORT) {
        WARN_LOG("Skip PCI round-trip for user Device %d: reverse PCI lookup is not supported.", userDeviceId);
        return 1;
    }
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclrtDeviceGetByPCIBusId returned error code %d", static_cast<int32_t>(ret));
        return -1;
    }
    if (std::strlen(pciBusId) != 12U || deviceFromPci != userDeviceId) {
        ERROR_LOG(
            "PCI round-trip is inconsistent: user=%d, PCI Bus ID=%s, pci->user=%d", userDeviceId, pciBusId,
            deviceFromPci);
        return -1;
    }

    INFO_LOG("PCI Bus ID: %s (round-trip user Device ID: %d)", pciBusId, deviceFromPci);
    return 0;
}

int InspectDevice(int32_t userDeviceId)
{
    int32_t logicDeviceId = -1;
    int32_t userFromLogic = -1;
    int32_t physicalDeviceId = -1;
    int32_t userFromPhysical = -1;
    aclrtUuid uuid = {};

    // Resolve logical and physical IDs, then map both back to the original user Device.
    CHECK_ERROR(aclrtGetLogicDevIdByUserDevId(userDeviceId, &logicDeviceId));
    CHECK_ERROR(aclrtGetUserDevIdByLogicDevId(logicDeviceId, &userFromLogic));
    CHECK_ERROR(aclrtGetPhyDevIdByUserDevId(userDeviceId, &physicalDeviceId));
    CHECK_ERROR(aclrtGetUserDevIdByPhyDevId(physicalDeviceId, &userFromPhysical));
    if (userFromLogic != userDeviceId || userFromPhysical != userDeviceId) {
        ERROR_LOG(
            "Device ID round-trip is inconsistent: user=%d, logic->user=%d, physical->user=%d", userDeviceId,
            userFromLogic, userFromPhysical);
        return -1;
    }

    // Query and print the stable UUID before checking the optional PCI identity path.
    CHECK_ERROR(aclrtDeviceGetUuid(userDeviceId, &uuid));
    INFO_LOG("Device ID mapping: user=%d, logic=%d, physical=%d", userDeviceId, logicDeviceId, physicalDeviceId);
    INFO_LOG("UUID: %s", UuidToString(uuid).c_str());
    return VerifyPciRoundTrip(userDeviceId);
}
} // namespace

int main()
{
    INFO_LOG("Start to run device_identity_mapping sample.");

    // Initialize ACL before enumerating the user-visible Device IDs.
    aclError ret = aclInit(nullptr);
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclInit returned error code %d", static_cast<int32_t>(ret));
        return -1;
    }

    int result = 0;
    uint32_t deviceCount = 0U;
    uint32_t pciSkipCount = 0U;
    ret = aclrtGetDeviceCount(&deviceCount);
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclrtGetDeviceCount returned error code %d", static_cast<int32_t>(ret));
        result = -1;
    } else if (deviceCount == 0U) {
        ERROR_LOG("No user-visible Device is available.");
        result = -1;
    }

    // Inspect each Device independently; no cross-Device resources or operations are used.
    for (uint32_t index = 0U; result == 0 && index < deviceCount; ++index) {
        const int inspectResult = InspectDevice(static_cast<int32_t>(index));
        if (inspectResult < 0) {
            result = -1;
        } else if (inspectResult > 0) {
            ++pciSkipCount;
        }
    }

    // Finalize ACL even when a Device identity check fails.
    ret = aclFinalize();
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: aclFinalize returned error code %d", static_cast<int32_t>(ret));
        result = -1;
    }

    if (result != 0) {
        ERROR_LOG("Run the device_identity_mapping sample failed.");
        return -1;
    }
    INFO_LOG(
        "Enumerated %u user-visible Device(s); PCI discovery skipped for %u Device(s).", deviceCount, pciSkipCount);
    INFO_LOG("Run the device_identity_mapping sample successfully.");
    return 0;
}
