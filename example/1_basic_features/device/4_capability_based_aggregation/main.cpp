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
#include <array>
#include <charconv>
#include <cstddef>
#include <cstring>

#include "acl/acl.h"
#include "aggregation.h"
#include "utils.h"

namespace {
constexpr size_t kInputElements = kRecordCount * kCategoryCount;
constexpr size_t kInputBytes = kInputElements * sizeof(int32_t);
constexpr size_t kHostResultBytes = 4096;

struct Session {
    bool initialized = false;
    bool deviceSet = false;
    bool registered = false;
    bool pending = false;
    int32_t userDeviceId = -1;
    aclrtStream stream = nullptr;
    void* input = nullptr;
    void* devicePartials = nullptr;
    void* hostResult = nullptr;
    void* mappedResult = nullptr;
};

struct Plan {
    uint32_t blocks = 0;
    bool hostAtomic = false;
};

using InputData = std::array<int32_t, kInputElements>;
using AggregationResult = std::array<int32_t, kCategoryCount>;

int ResolveDevice(int32_t physicalDeviceId, Session& session)
{
    uint32_t deviceCount = 0;
    CHECK_ERROR(aclrtGetDeviceCount(&deviceCount));
    if (deviceCount == 0) {
        ERROR_LOG("No user-visible Device is available.");
        return -1;
    }
    // The legacy LogicDevId parameters actually refer to user Device IDs.
    if (physicalDeviceId < 0) {
        CHECK_ERROR(aclrtGetPhyDevIdByLogicDevId(0, &physicalDeviceId));
    }
    CHECK_ERROR(aclrtGetLogicDevIdByPhyDevId(physicalDeviceId, &session.userDeviceId));
    if (session.userDeviceId < 0 || static_cast<uint32_t>(session.userDeviceId) >= deviceCount) {
        ERROR_LOG("Physical Device %d is not visible to this process.", physicalDeviceId);
        return -1;
    }
    int32_t roundTripPhysicalId = -1;
    CHECK_ERROR(aclrtGetPhyDevIdByLogicDevId(session.userDeviceId, &roundTripPhysicalId));
    if (roundTripPhysicalId != physicalDeviceId) {
        ERROR_LOG("Physical Device ID mismatch: requested=%d, returned=%d", physicalDeviceId, roundTripPhysicalId);
        return -1;
    }
    INFO_LOG(
        "ID round-trip: physical=%d -> legacy logic (user)=%d -> physical=%d", physicalDeviceId, session.userDeviceId,
        roundTripPhysicalId);
    CHECK_ERROR(aclrtSetDevice(session.userDeviceId));
    session.deviceSet = true;
    return 0;
}

int SelectPlan(int32_t userDeviceId, Plan& plan)
{
    // Size the parallel work from the hardware specification.
    int64_t vectorCores = 0;
    CHECK_ERROR(aclGetDeviceCapability(userDeviceId, ACL_DEVICE_INFO_VECTOR_CORE_NUM, &vectorCores));
    if (vectorCores <= 0) {
        ERROR_LOG("Counter aggregation requires at least one Vector Core.");
        return -1;
    }
    plan.blocks = static_cast<uint32_t>(std::min<int64_t>(vectorCores, kMaxBlocks));

    // DMA_ADD matches SetAtomicAdd in the kernel; both signed and 32-bit support are required.
    const std::array<aclrtAtomicOperation, 1> operations = {ACL_RT_ATOMIC_OPERATION_DMA_ADD};
    std::array<uint32_t, operations.size()> capabilities = {};
    CHECK_ERROR(aclrtDeviceGetHostAtomicCapabilities(
        capabilities.data(), operations.data(), static_cast<uint32_t>(operations.size()), userDeviceId));
    constexpr uint32_t kRequired = ACL_RT_ATOMIC_CAPABILITY_SIGNED | ACL_RT_ATOMIC_CAPABILITY_SCALAR32;
    plan.hostAtomic = (capabilities[0] & kRequired) == kRequired;
    INFO_LOG("Vector Cores=%lld, aggregation blocks=%u", static_cast<long long>(vectorCores), plan.blocks);
    INFO_LOG("Host/Device DMA_ADD capabilities=0x%x, required int32 mask=0x%x", capabilities[0], kRequired);
    INFO_LOG("Selected path: %s", plan.hostAtomic ? "mapped Host atomic add" : "Device partials + Host sum");
    return 0;
}

void PrepareInput(InputData& input, AggregationResult& expected)
{
    for (uint32_t record = 0; record < kRecordCount; ++record) {
        for (uint32_t category = 0; category < kCategoryCount; ++category) {
            const int32_t value = (static_cast<int32_t>(record % 13) - 6) * static_cast<int32_t>(category + 1);
            input[record * kCategoryCount + category] = value;
            expected[category] += value;
        }
    }
}

int VerifyResults(const Session& session, const Plan& plan, const AggregationResult& expected)
{
    const auto* partials = static_cast<const int32_t*>(session.hostResult);
    AggregationResult actual = {};
    const uint32_t resultBlocks = plan.hostAtomic ? 1 : plan.blocks;
    for (uint32_t block = 0; block < resultBlocks; ++block) {
        for (uint32_t category = 0; category < kCategoryCount; ++category) {
            actual[category] += partials[block * kCategoryCount + category];
        }
    }
    for (uint32_t category = 0; category < kCategoryCount; ++category) {
        if (actual[category] != expected[category]) {
            ERROR_LOG("Category %u mismatch: actual=%d, expected=%d", category, actual[category], expected[category]);
            return -1;
        }
        INFO_LOG("Category %u: actual=%d, expected=%d", category, actual[category], expected[category]);
    }
    INFO_LOG("Verified %u categories across %u records.", kCategoryCount, kRecordCount);
    return 0;
}

int ExecuteAndVerify(Session& session, const Plan& plan)
{
    // Generate deterministic signed counter adjustments and an independent CPU reference.
    InputData input = {};
    AggregationResult expected = {};
    PrepareInput(input, expected);
    CHECK_ERROR(aclrtMalloc(&session.input, kInputBytes, ACL_MEM_MALLOC_HUGE_FIRST));
    CHECK_ERROR(aclrtMemcpy(session.input, kInputBytes, input.data(), kInputBytes, ACL_MEMCPY_HOST_TO_DEVICE));
    CHECK_ERROR(aclrtMallocHost(&session.hostResult, kHostResultBytes));
    std::fill_n(static_cast<int32_t*>(session.hostResult), kHostResultBytes / sizeof(int32_t), 0);

    const size_t partialBytes = plan.blocks * kCategoryCount * sizeof(int32_t);
    void* kernelOutput = nullptr;
    if (plan.hostAtomic) {
        CHECK_ERROR(aclrtHostRegisterV2(session.hostResult, kHostResultBytes, ACL_HOST_REG_MAPPED));
        session.registered = true;
        CHECK_ERROR(aclrtHostGetDevicePointer(session.hostResult, &session.mappedResult, 0));
        kernelOutput = session.mappedResult;
    } else {
        CHECK_ERROR(aclrtMalloc(&session.devicePartials, partialBytes, ACL_MEM_MALLOC_HUGE_FIRST));
        CHECK_ERROR(aclrtMemset(session.devicePartials, partialBytes, 0, partialBytes));
        kernelOutput = session.devicePartials;
    }
    if (kernelOutput == nullptr) {
        ERROR_LOG("Kernel output address is null.");
        return -1;
    }
    CHECK_ERROR(aclrtCreateStream(&session.stream));
    const int32_t launchResult =
        AggregateCountersDo(plan.blocks, session.stream, session.input, kernelOutput, plan.hostAtomic);
    if (launchResult != 0) {
        ERROR_LOG("AggregateCounters launch failed: %d", launchResult);
        return -1;
    }
    session.pending = true;
    CHECK_ERROR(aclrtSynchronizeStream(session.stream));
    session.pending = false;

    // Host reads only after synchronization; the fallback copies disjoint block results.
    if (!plan.hostAtomic) {
        CHECK_ERROR(aclrtMemcpy(
            session.hostResult, kHostResultBytes, session.devicePartials, partialBytes, ACL_MEMCPY_DEVICE_TO_HOST));
    }
    return VerifyResults(session, plan, expected);
}

void RecordCleanupError(const char* operation, aclError error, int& result)
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, static_cast<int32_t>(error));
        result = -1;
    }
}

void Cleanup(Session& session, int& result)
{
    // Drain work and release all acquired resources even after an earlier failure.
    if (session.stream != nullptr) {
        if (session.pending) {
            RecordCleanupError("aclrtSynchronizeStream", aclrtSynchronizeStream(session.stream), result);
        }
        RecordCleanupError("aclrtDestroyStreamForce", aclrtDestroyStreamForce(session.stream), result);
    }
    if (session.devicePartials != nullptr) {
        RecordCleanupError("aclrtFree(partials)", aclrtFree(session.devicePartials), result);
    }
    if (session.registered) {
        RecordCleanupError("aclrtHostUnregister", aclrtHostUnregister(session.hostResult), result);
    }
    if (session.hostResult != nullptr) {
        RecordCleanupError("aclrtFreeHost", aclrtFreeHost(session.hostResult), result);
    }
    if (session.input != nullptr) {
        RecordCleanupError("aclrtFree(input)", aclrtFree(session.input), result);
    }
    if (session.deviceSet) {
        RecordCleanupError("aclrtResetDeviceForce", aclrtResetDeviceForce(session.userDeviceId), result);
    }
    if (session.initialized) {
        RecordCleanupError("aclFinalize", aclFinalize(), result);
    }
}
} // namespace

int main(int argc, char* argv[])
{
    int32_t physicalDeviceId = -1;
    if (argc > 2) {
        ERROR_LOG("Usage: %s [physical_device_id]", argv[0]);
        return 1;
    }
    if (argc == 2) {
        const char* end = argv[1] + std::strlen(argv[1]);
        const auto parsed = std::from_chars(argv[1], end, physicalDeviceId);
        if (parsed.ec != std::errc{} || parsed.ptr != end || physicalDeviceId < 0) {
            ERROR_LOG("physical_device_id must be a nonnegative int32 value.");
            return 1;
        }
    }
    INFO_LOG("Start to run capability_based_aggregation sample.");
    Session session;
    Plan plan;
    // Initialize once and bind only the selected Device.
    CHECK_ERROR(aclInit(nullptr));
    session.initialized = true;
    int result = 0;
    if (ResolveDevice(physicalDeviceId, session) != 0 || SelectPlan(session.userDeviceId, plan) != 0 ||
        ExecuteAndVerify(session, plan) != 0) {
        result = -1;
    }
    Cleanup(session, result);
    if (result != 0) {
        ERROR_LOG("Run the capability_based_aggregation sample failed.");
        return 1;
    }
    INFO_LOG("Run the capability_based_aggregation sample successfully.");
    return 0;
}
