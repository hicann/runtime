/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <atomic>
#include <cstdint>
#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr char kApiName[] = "aclrtGetDevice";
using GetDeviceFunc = decltype(&aclrtGetDevice);
GetDeviceFunc g_originalGetDevice = nullptr;
std::atomic<uint32_t> g_callCount{0};

struct SampleState {
    aclrtApiFunc original = nullptr;
    bool initialized = false;
    bool deviceSet = false;
    bool hookInstalled = false;
};

aclError CountGetDevice(int32_t* deviceId)
{
    g_callCount.fetch_add(1, std::memory_order_relaxed);
    // Forward directly to the saved implementation to avoid re-entering the hook.
    return g_originalGetDevice(deviceId);
}

aclrtApiFunc GetCountHook()
{
    // The generic hook pointer is only stored; calls use the exact API signature.
    return reinterpret_cast<aclrtApiFunc>(reinterpret_cast<void*>(&CountGetDevice));
}

int Initialize(SampleState& state)
{
    CHECK_ERROR(aclInit(nullptr));
    state.initialized = true;
    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    state.deviceSet = true;
    return 0;
}

int VerifyFunction(aclrtApiFunc expected, aclrtApiFunc original)
{
    aclrtApiFunc observedOriginal = nullptr;
    aclrtApiFunc current = nullptr;
    CHECK_ERROR(aclrtApiInjectionGetFunc(kApiName, &observedOriginal, &current));
    if (observedOriginal != original || current != expected) {
        ERROR_LOG("Unexpected original or current function pointer");
        return -1;
    }
    return 0;
}

int InstallHook(SampleState& state)
{
    // All application calls and hook changes are serialized on the main thread.
    aclrtApiFunc current = nullptr;
    CHECK_ERROR(aclrtApiInjectionGetFunc(kApiName, &state.original, &current));
    if (state.original == nullptr || current != state.original) {
        ERROR_LOG("Missing original function or an existing hook is active");
        return -1;
    }
    g_originalGetDevice = reinterpret_cast<GetDeviceFunc>(reinterpret_cast<void*>(state.original));
    CHECK_ERROR(aclrtApiInjectionSetFunc(kApiName, GetCountHook()));
    state.hookInstalled = true;
    if (VerifyFunction(GetCountHook(), state.original) != 0) {
        return -1;
    }
    if (g_callCount.load(std::memory_order_relaxed) != 0) {
        ERROR_LOG("Hook count must be zero before the measured call");
        return -1;
    }
    INFO_LOG("Hook installed for %s", kApiName);
    return 0;
}

int VerifyQuery(const char* phase)
{
    int32_t deviceId = -1;
    CHECK_ERROR(aclrtGetDevice(&deviceId));
    const uint32_t count = g_callCount.load(std::memory_order_relaxed);
    if (deviceId != kDeviceId || count != 1) {
        ERROR_LOG("%s: device=%d, hook count=%u; expected device=%d, count=1", phase, deviceId, count, kDeviceId);
        return -1;
    }
    INFO_LOG("%s: device=%d, hook count=%u", phase, deviceId, count);
    return 0;
}

int RestoreHook(SampleState& state)
{
    if (!state.hookInstalled) {
        return 0;
    }
    CHECK_ERROR(aclrtApiInjectionSetFunc(kApiName, state.original));
    state.hookInstalled = false;
    if (VerifyFunction(state.original, state.original) != 0) {
        return -1;
    }
    INFO_LOG("Original function restored");
    return 0;
}

int RunScenario(SampleState& state)
{
    // Install, measure exactly one call, then verify the restored behavior.
    if (Initialize(state) != 0 || InstallHook(state) != 0) {
        return -1;
    }
    if (VerifyQuery("Hooked call") != 0 || RestoreHook(state) != 0) {
        return -1;
    }
    return VerifyQuery("Restored call");
}

void RecordCleanupError(const char* operation, aclError error, int& result)
{
    if (error != ACL_SUCCESS) {
        ERROR_LOG("Cleanup failed: %s returned error code %d", operation, error);
        result = -1;
    }
}

void Cleanup(SampleState& state, int& result)
{
    // Restore the hook even when the measured call or validation failed.
    if (RestoreHook(state) != 0) {
        result = -1;
    }
    if (state.deviceSet) {
        RecordCleanupError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
    }
    if (state.initialized) {
        RecordCleanupError("aclFinalize", aclFinalize(), result);
    }
}
} // namespace

int main()
{
    SampleState state;
    int result = RunScenario(state);
    Cleanup(state, result);
    if (result == 0) {
        INFO_LOG("Run the call_count sample successfully.");
    } else {
        ERROR_LOG("Run the call_count sample failed.");
    }
    return result == 0 ? 0 : 1;
}
