/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdint>
#include <cstdio>

#include "acl/acl.h"
#include "utils.h"

namespace {
constexpr int32_t kDeviceId = 0;
constexpr int32_t kPrimaryContextInactive = 0;
constexpr int32_t kPrimaryContextActive = 1;
constexpr int64_t kProcessDeterminism = 2;
constexpr int64_t kContextADeterminism = 1;
constexpr int64_t kContextBDeterminism = 0;

int CheckAcl(aclError ret, const char* expression)
{
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("Operation failed: %s returned error code %d", expression, static_cast<int32_t>(ret));
        return -1;
    }
    return 0;
}

int VerifyPrimaryContextState(const char* stage, int32_t expectedState)
{
    int32_t active = -1;
    CHECK_ERROR(aclrtGetPrimaryCtxState(kDeviceId, nullptr, &active));
    INFO_LOG("Default Context %s: %s", stage, active == kPrimaryContextActive ? "active" : "inactive");
    if (active != expectedState) {
        ERROR_LOG("Unexpected default Context state: got %d, expected %d", active, expectedState);
        return -1;
    }
    return 0;
}

int SetAndVerifyContextDeterminism(aclrtContext context, int64_t expectedValue, const char* contextName)
{
    CHECK_ERROR(aclrtSetCurrentContext(context));
    CHECK_ERROR(aclrtCtxSetSysParamOpt(ACL_OPT_DETERMINISTIC, expectedValue));

    int64_t actualValue = -1;
    CHECK_ERROR(aclrtCtxGetSysParamOpt(ACL_OPT_DETERMINISTIC, &actualValue));
    if (actualValue != expectedValue) {
        ERROR_LOG(
            "%s deterministic mode mismatch: got %ld, expected %ld", contextName, static_cast<long>(actualValue),
            static_cast<long>(expectedValue));
        return -1;
    }
    INFO_LOG("%s deterministic mode: %ld", contextName, static_cast<long>(actualValue));
    return 0;
}

int VerifyContextDeterminism(aclrtContext context, int64_t expectedValue, const char* contextName)
{
    CHECK_ERROR(aclrtSetCurrentContext(context));

    int64_t actualValue = -1;
    CHECK_ERROR(aclrtCtxGetSysParamOpt(ACL_OPT_DETERMINISTIC, &actualValue));
    if (actualValue != expectedValue) {
        ERROR_LOG(
            "%s deterministic mode changed unexpectedly: got %ld, expected %ld", contextName,
            static_cast<long>(actualValue), static_cast<long>(expectedValue));
        return -1;
    }
    INFO_LOG("%s deterministic mode after switching back: %ld", contextName, static_cast<long>(actualValue));
    return 0;
}

int ConfigureProcessDeterminism(int64_t& originalValue, bool& valueChanged)
{
    CHECK_ERROR(aclrtGetSysParamOpt(ACL_OPT_DETERMINISTIC, &originalValue));
    INFO_LOG("Saved process deterministic mode: %ld", static_cast<long>(originalValue));

    CHECK_ERROR(aclrtSetSysParamOpt(ACL_OPT_DETERMINISTIC, kProcessDeterminism));
    valueChanged = true;

    int64_t actualValue = -1;
    CHECK_ERROR(aclrtGetSysParamOpt(ACL_OPT_DETERMINISTIC, &actualValue));
    if (actualValue != kProcessDeterminism) {
        ERROR_LOG(
            "Process deterministic mode mismatch: got %ld, expected %ld", static_cast<long>(actualValue),
            static_cast<long>(kProcessDeterminism));
        return -1;
    }
    INFO_LOG("Process deterministic mode set to: %ld", static_cast<long>(actualValue));
    return 0;
}

int CreateAndVerifyContexts(aclrtContext& contextA, aclrtContext& contextB)
{
    CHECK_ERROR(aclrtCreateContext(&contextA, kDeviceId));
    CHECK_ERROR(aclrtCreateContext(&contextB, kDeviceId));
    if (SetAndVerifyContextDeterminism(contextA, kContextADeterminism, "Context A") != 0) {
        return -1;
    }
    if (SetAndVerifyContextDeterminism(contextB, kContextBDeterminism, "Context B") != 0) {
        return -1;
    }
    if (VerifyContextDeterminism(contextA, kContextADeterminism, "Context A") != 0) {
        return -1;
    }
    if (VerifyContextDeterminism(contextB, kContextBDeterminism, "Context B") != 0) {
        return -1;
    }
    INFO_LOG("Context-scoped deterministic modes are isolated successfully");
    return 0;
}

int RestoreProcessDeterminism(int64_t originalValue)
{
    if (CheckAcl(
            aclrtSetSysParamOpt(ACL_OPT_DETERMINISTIC, originalValue),
            "aclrtSetSysParamOpt(ACL_OPT_DETERMINISTIC, originalValue)") != 0) {
        return -1;
    }

    int64_t restoredValue = -1;
    CHECK_ERROR(aclrtGetSysParamOpt(ACL_OPT_DETERMINISTIC, &restoredValue));
    if (restoredValue != originalValue) {
        ERROR_LOG(
            "Failed to restore process deterministic mode: got %ld, expected %ld", static_cast<long>(restoredValue),
            static_cast<long>(originalValue));
        return -1;
    }
    INFO_LOG("Restored process deterministic mode: %ld", static_cast<long>(restoredValue));
    return 0;
}

int DestroyContexts(aclrtContext contextA, aclrtContext contextB)
{
    int result = 0;
    if ((contextB != nullptr) && (CheckAcl(aclrtDestroyContext(contextB), "aclrtDestroyContext(contextB)") != 0)) {
        result = -1;
    }
    if ((contextA != nullptr) && (CheckAcl(aclrtDestroyContext(contextA), "aclrtDestroyContext(contextA)") != 0)) {
        result = -1;
    }
    return result;
}

int RunContextScopedDeterminismSample()
{
    aclrtContext contextA = nullptr;
    aclrtContext contextB = nullptr;
    int64_t originalProcessValue = 0;
    bool processValueChanged = false;

    int result = ConfigureProcessDeterminism(originalProcessValue, processValueChanged);
    if (result == 0) {
        result = CreateAndVerifyContexts(contextA, contextB);
    }
    if (processValueChanged && (RestoreProcessDeterminism(originalProcessValue) != 0)) {
        result = -1;
    }
    if (DestroyContexts(contextA, contextB) != 0) {
        result = -1;
    }
    return result;
}
} // namespace

int32_t main()
{
    if (CheckAcl(aclInit(nullptr), "aclInit(nullptr)") != 0) {
        return -1;
    }

    bool deviceSet = false;
    int result = [&]() -> int {
        // Observe the default Context lifecycle around Device binding.
        if (VerifyPrimaryContextState("before aclrtSetDevice", kPrimaryContextInactive) != 0) {
            return -1;
        }
        CHECK_ERROR(aclrtSetDevice(kDeviceId));
        deviceSet = true;
        if (VerifyPrimaryContextState("after aclrtSetDevice", kPrimaryContextActive) != 0) {
            return -1;
        }
        return RunContextScopedDeterminismSample();
    }();

    if (deviceSet) {
        if (CheckAcl(aclrtResetDeviceForce(kDeviceId), "aclrtResetDeviceForce(kDeviceId)") != 0) {
            result = -1;
        } else if (VerifyPrimaryContextState("after aclrtResetDeviceForce", kPrimaryContextInactive) != 0) {
            result = -1;
        }
    }
    if (CheckAcl(aclFinalize(), "aclFinalize()") != 0) {
        result = -1;
    }

    if (result == 0) {
        INFO_LOG("[SUCCESS] Context-scoped determinism sample completed successfully");
    }
    return result;
}
