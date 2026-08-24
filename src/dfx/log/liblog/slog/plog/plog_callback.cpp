/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "plog_callback.h"

#include <algorithm>
#include <mutex>
#include <vector>

#include "log_common.h"

namespace {
constexpr int32_t ACLLOG_SUCCESS = 0;
constexpr int32_t ACLLOG_FAILURE = -1;
constexpr size_t MAX_CALLBACK_NUM = 16U;

struct CallbackEntry {
    acllogCallbackHandle handle;
    acllogRecordCallback callback;
    void* userData;
    uint32_t outputLogType;
};

std::mutex g_callbackMutex;
std::vector<CallbackEntry> g_callbacks;
acllogCallbackHandle g_nextHandle = 1U;

bool IsValidOutputType(const uint32_t outputLogType) { return outputLogType < static_cast<uint32_t>(OUTPUT_TYPE_MAX); }

bool IsMatchedOutputType(const uint32_t registeredType, const uint32_t outputLogType)
{
    return (registeredType == outputLogType) || (registeredType == static_cast<uint32_t>(OUTPUT_TYPE_BOTH));
}

bool ConvertLogType(const int32_t logType, uint32_t& outputLogType)
{
    if (logType == static_cast<int32_t>(DEBUG_LOG)) {
        outputLogType = static_cast<uint32_t>(OUTPUT_TYPE_DEBUG);
        return true;
    }
    if (logType == static_cast<int32_t>(RUN_LOG)) {
        outputLogType = static_cast<uint32_t>(OUTPUT_TYPE_RUN);
        return true;
    }
    return false;
}

acllogCallbackHandle AllocHandle()
{
    const acllogCallbackHandle handle = g_nextHandle;
    ++g_nextHandle;
    if (g_nextHandle == 0U) {
        g_nextHandle = 1U;
    }
    return handle;
}
} // namespace

extern "C" int32_t PlogRegisterCallbackInner(
    acllogRecordCallback callbackFunc, void* userData, uint32_t outputLogType, acllogCallbackHandle* callbackHandle)
{
    if ((callbackFunc == nullptr) || (callbackHandle == nullptr) || (!IsValidOutputType(outputLogType))) {
        return ACLLOG_FAILURE;
    }

    std::lock_guard<std::mutex> lock(g_callbackMutex);
    if (g_callbacks.size() >= MAX_CALLBACK_NUM) {
        return ACLLOG_FAILURE;
    }
    CallbackEntry entry = {AllocHandle(), callbackFunc, userData, outputLogType};
    g_callbacks.push_back(entry);
    *callbackHandle = entry.handle;
    return ACLLOG_SUCCESS;
}

extern "C" int32_t PlogUnregisterCallbackInner(acllogCallbackHandle callback)
{
    std::lock_guard<std::mutex> lock(g_callbackMutex);
    const auto iter = std::find_if(g_callbacks.begin(), g_callbacks.end(), [callback](const CallbackEntry& entry) {
        return entry.handle == callback;
    });
    if (iter == g_callbacks.end()) {
        return ACLLOG_FAILURE;
    }
    g_callbacks.erase(iter);
    return ACLLOG_SUCCESS;
}

extern "C" void PlogDispatchDeviceLogCallback(int32_t logType, const char* logContent, size_t length)
{
    uint32_t outputLogType = static_cast<uint32_t>(OUTPUT_TYPE_MAX);
    if ((logContent == nullptr) || (length == 0U) || (!ConvertLogType(logType, outputLogType))) {
        return;
    }

    std::vector<CallbackEntry> callbacks;
    {
        std::lock_guard<std::mutex> lock(g_callbackMutex);
        callbacks = g_callbacks;
    }

    for (const auto& entry : callbacks) {
        if (!IsMatchedOutputType(entry.outputLogType, outputLogType)) {
            continue;
        }
        try {
            (void)entry.callback(entry.userData, outputLogType, logContent, length);
        } catch (...) {
            continue;
        }
    }
}
