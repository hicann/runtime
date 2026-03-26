/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdio>
#include <cstdint>
#include <cstring>
#include "acl/acl.h"
#include "utils.h"

namespace {
const char *SafeString(const char *message)
{
    return message != nullptr ? message : "<null>";
}

const char *RunModeToString(aclrtRunMode runMode)
{
    return runMode == ACL_HOST ? "ACL_HOST" : "ACL_DEVICE";
}

void PrintVerboseErrorInfo(int32_t deviceId)
{
    aclrtErrorInfo errorInfo = {};
    aclError verboseRet = aclrtGetErrorVerbose(deviceId, &errorInfo);
    if (verboseRet != ACL_SUCCESS) {
        WARN_LOG("aclrtGetErrorVerbose(%d) returned error code %d", deviceId, static_cast<int32_t>(verboseRet));
        return;
    }

    INFO_LOG("Verbose error info: errorType=%d, tryRepair=%u, hasDetail=%u",
        static_cast<int32_t>(errorInfo.errorType),
        static_cast<uint32_t>(errorInfo.tryRepair),
        static_cast<uint32_t>(errorInfo.hasDetail));
}
} // namespace

#define CHECK_ACL_RETURN(call) \
    do { \
        aclError ret = (call); \
        if (ret != ACL_SUCCESS) { \
            ERROR_LOG("%s failed: ret=%d", #call, static_cast<int32_t>(ret)); \
            return -1; \
        } \
    } while (0)

int main()
{
    const int32_t deviceId = 0;
    CHECK_ACL_RETURN(aclInit(nullptr));
    CHECK_ACL_RETURN(aclrtSetDevice(deviceId));
    INFO_LOG("ACL init and set device successfully");

    aclrtRunMode runMode = ACL_HOST;
    CHECK_ACL_RETURN(aclrtGetRunMode(&runMode));
    INFO_LOG("Current run mode: %s", RunModeToString(runMode));

    INFO_LOG("Triggering an expected invalid-parameter error with aclrtGetRunMode(nullptr)");
    aclError expectedRet = aclrtGetRunMode(nullptr);
    if (expectedRet == ACL_SUCCESS) {
        WARN_LOG("Expected aclrtGetRunMode(nullptr) to fail, but it succeeded");
    } else {
        aclError peekError = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
        aclError lastError = aclrtGetLastError(ACL_RT_THREAD_LEVEL);
        const char *recentErrMsg = aclGetRecentErrMsg();
        ERROR_LOG("Diagnostics: ret=%d, peekErr=%d, lastErr=%d, recentErrMsg=%s",
            static_cast<int32_t>(expectedRet),
            static_cast<int32_t>(peekError),
            static_cast<int32_t>(lastError),
            SafeString(recentErrMsg));
        PrintVerboseErrorInfo(deviceId);

        aclError clearedPeek = aclrtPeekAtLastError(ACL_RT_THREAD_LEVEL);
        aclError clearedLast = aclrtGetLastError(ACL_RT_THREAD_LEVEL);
        const char *clearedErrMsg = aclGetRecentErrMsg();
        INFO_LOG("After diagnostics are consumed once: peekErr=%d, lastErr=%d, recentErrMsg=%s",
            static_cast<int32_t>(clearedPeek),
            static_cast<int32_t>(clearedLast),
            SafeString(clearedErrMsg));
    }

    CHECK_ACL_RETURN(aclrtResetDeviceForce(deviceId));
    CHECK_ACL_RETURN(aclFinalize());
    INFO_LOG("ACL finalize successfully");
    return 0;
}