// -----------------------------------------------------------------------------------------------------------
// Copyright (c) 2026 Huawei Technologies Co., Ltd.
// This program is free software, you can redistribute it and/or modify it under the terms and conditions of
// CANN Open Software License Agreement Version 2.0 (the "License").
// Please refer to the License for details. You may not use this file except in compliance with the License.
// THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
// See LICENSE in the root of the software repository for the full text of the License.
// -----------------------------------------------------------------------------------------------------------

#include <cstdarg>
#include <cstdint>
#include <cstdio>

#include "acl_log.h"

namespace {
constexpr int32_t kUserModuleId = 0xff00;

int32_t LogCallback(void*, uint32_t outputLogType, const char* logContent, size_t length)
{
    std::printf("[CALLBACK type=%u] %.*s", outputLogType, static_cast<int>(length), logContent);
    return 0;
}

void RecordWithVaList(int32_t moduleId, int32_t level, const char* format, ...)
{
    va_list args;
    va_start(args, format);
    acllogVaList(moduleId, level, format, args);
    va_end(args);
}
} // namespace

int main()
{
    acllogCallbackHandle callbackHandle = 0;
    const int32_t registerResult = acllogRegisterCallback(LogCallback, nullptr, OUTPUT_TYPE_BOTH, &callbackHandle);
    if (registerResult != 0) {
        std::printf("[FAILURE] acllogRegisterCallback returned %d.\n", registerResult);
        return 1;
    }

    if (acllogRecord != nullptr && acllogVaList != nullptr && acllogCheckDebugLevel != nullptr) {
        acllogRecord(kUserModuleId, DLOG_INFO, "user debug log: %d\n", 1);
        acllogRecord(kUserModuleId | RUN_LOG_MASK, DLOG_INFO, "user run log: %d\n", 2);
        RecordWithVaList(kUserModuleId, DLOG_WARN, "user va_list log: %s\n", "ok");

        const int32_t debugLevelEnabled = acllogCheckDebugLevel(kUserModuleId, DLOG_INFO);
        std::printf("[INFO] acllogCheckDebugLevel returned %d.\n", debugLevelEnabled);
    } else {
        std::printf("[WARN] Optional ACL log record APIs are unavailable; callback APIs were verified.\n");
    }

    const int32_t unregisterResult = acllogUnregisterCallback(callbackHandle);
    if (unregisterResult != 0) {
        std::printf("[FAILURE] acllogUnregisterCallback returned %d.\n", unregisterResult);
        return 1;
    }

    std::printf("[SUCCESS] ACL log sample completed successfully.\n");
    return 0;
}
