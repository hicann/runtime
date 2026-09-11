/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plugin_lifecycle.h"

#include <cstdint>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr aclRegisterCallbackType kCallbackType = ACL_REG_TYPE_OTHER;

struct CallbackCounts {
    int activeInit = 0;
    int cancelledInit = 0;
    int activeFinalize = 0;
    int cancelledFinalize = 0;
};

struct PluginLifecycleSession {
    PluginLifecycleSession() = default;
    PluginLifecycleSession(const PluginLifecycleSession&) = delete;
    PluginLifecycleSession& operator=(const PluginLifecycleSession&) = delete;

    CallbackCounts counts;
    bool activeInitRegistered = false;
    bool cancelledInitRegistered = false;
    bool runtimeInitialized = false;
    bool deviceSet = false;
    bool activeFinalizeRegistered = false;
    bool cancelledFinalizeRegistered = false;
    uint64_t referenceCount = 1U;
};

aclError ActiveInitCallback(const char*, size_t, void* userData)
{
    if (userData == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }
    ++static_cast<CallbackCounts*>(userData)->activeInit;
    return ACL_SUCCESS;
}

aclError CancelledInitCallback(const char*, size_t, void* userData)
{
    if (userData == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }
    ++static_cast<CallbackCounts*>(userData)->cancelledInit;
    return ACL_SUCCESS;
}

aclError ActiveFinalizeCallback(void* userData)
{
    if (userData == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }
    ++static_cast<CallbackCounts*>(userData)->activeFinalize;
    return ACL_SUCCESS;
}

aclError CancelledFinalizeCallback(void* userData)
{
    if (userData == nullptr) {
        return ACL_ERROR_INVALID_PARAM;
    }
    ++static_cast<CallbackCounts*>(userData)->cancelledFinalize;
    return ACL_SUCCESS;
}

int RegisterInitCallbacks(PluginLifecycleSession& session)
{
    CHECK_ERROR(aclInitCallbackRegister(kCallbackType, ActiveInitCallback, &session.counts));
    session.activeInitRegistered = true;
    CHECK_ERROR(aclInitCallbackRegister(kCallbackType, CancelledInitCallback, &session.counts));
    session.cancelledInitRegistered = true;
    CHECK_ERROR(aclInitCallbackUnRegister(kCallbackType, CancelledInitCallback));
    session.cancelledInitRegistered = false;
    return 0;
}

int InitializeRuntime(PluginLifecycleSession& session)
{
    CHECK_ERROR(aclInit(nullptr));
    session.runtimeInitialized = true;
    if (session.counts.activeInit != 1 || session.counts.cancelledInit != 0) {
        ERROR_LOG(
            "Unexpected initialization callback counts: active=%d, cancelled=%d.", session.counts.activeInit,
            session.counts.cancelledInit);
        return -1;
    }
    INFO_LOG("Initialization callbacks verified: active=1, cancelled=0.");

    CHECK_ERROR(aclrtSetDevice(kDeviceId));
    session.deviceSet = true;
    int32_t currentDevice = -1;
    CHECK_ERROR(aclrtGetDevice(&currentDevice));
    if (currentDevice != kDeviceId) {
        ERROR_LOG("Unexpected current Device: expected=%d, actual=%d.", kDeviceId, currentDevice);
        return -1;
    }
    INFO_LOG("Device %d selected and verified.", currentDevice);
    return 0;
}

int RegisterFinalizeCallbacks(PluginLifecycleSession& session)
{
    CHECK_ERROR(aclFinalizeCallbackRegister(kCallbackType, ActiveFinalizeCallback, &session.counts));
    session.activeFinalizeRegistered = true;
    CHECK_ERROR(aclFinalizeCallbackRegister(kCallbackType, CancelledFinalizeCallback, &session.counts));
    session.cancelledFinalizeRegistered = true;
    CHECK_ERROR(aclFinalizeCallbackUnRegister(kCallbackType, CancelledFinalizeCallback));
    session.cancelledFinalizeRegistered = false;
    return 0;
}

void RecordCleanupError(const char* operation, aclError error, int& result)
{
    if (error == ACL_SUCCESS) {
        return;
    }
    ERROR_LOG("Cleanup failed: %s returned error code %d.", operation, static_cast<int32_t>(error));
    result = -1;
}

void Cleanup(PluginLifecycleSession& session, int& result)
{
    if (session.deviceSet) {
        RecordCleanupError("aclrtResetDeviceForce", aclrtResetDeviceForce(kDeviceId), result);
        session.deviceSet = false;
    }
    if (session.runtimeInitialized) {
        RecordCleanupError("aclFinalizeReference", aclFinalizeReference(&session.referenceCount), result);
        session.runtimeInitialized = false;
    }
    if (session.cancelledFinalizeRegistered) {
        RecordCleanupError(
            "aclFinalizeCallbackUnRegister(cancelled)",
            aclFinalizeCallbackUnRegister(kCallbackType, CancelledFinalizeCallback), result);
        session.cancelledFinalizeRegistered = false;
    }
    if (session.activeFinalizeRegistered) {
        RecordCleanupError(
            "aclFinalizeCallbackUnRegister(active)",
            aclFinalizeCallbackUnRegister(kCallbackType, ActiveFinalizeCallback), result);
        session.activeFinalizeRegistered = false;
    }
    if (session.cancelledInitRegistered) {
        RecordCleanupError(
            "aclInitCallbackUnRegister(cancelled)", aclInitCallbackUnRegister(kCallbackType, CancelledInitCallback),
            result);
        session.cancelledInitRegistered = false;
    }
    if (session.activeInitRegistered) {
        RecordCleanupError(
            "aclInitCallbackUnRegister(active)", aclInitCallbackUnRegister(kCallbackType, ActiveInitCallback), result);
        session.activeInitRegistered = false;
    }
}

int VerifyLifecycle(const PluginLifecycleSession& session)
{
    const auto& counts = session.counts;
    if (counts.activeInit != 1 || counts.cancelledInit != 0 || counts.activeFinalize != 1 ||
        counts.cancelledFinalize != 0 || session.referenceCount != 0U) {
        ERROR_LOG(
            "Unexpected lifecycle result: active_init=%d, cancelled_init=%d, active_finalize=%d, "
            "cancelled_finalize=%d, reference=%lu.",
            counts.activeInit, counts.cancelledInit, counts.activeFinalize, counts.cancelledFinalize,
            session.referenceCount);
        return -1;
    }
    INFO_LOG("Plugin lifecycle verified: active_init=1, cancelled_init=0, active_finalize=1, "
             "cancelled_finalize=0, reference=0.");
    return 0;
}
} // namespace

int RunPluginLifecycle()
{
    PluginLifecycleSession session;
    int result = RegisterInitCallbacks(session);
    if (result == 0) {
        result = InitializeRuntime(session);
    }
    if (result == 0) {
        result = RegisterFinalizeCallbacks(session);
    }
    Cleanup(session, result);
    return result == 0 ? VerifyLifecycle(session) : result;
}
