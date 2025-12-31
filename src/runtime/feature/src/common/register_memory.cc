/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "register_memory.hpp"

namespace cce {
namespace runtime {
static std::mutex g_registeredMutex;
static std::map<uint64_t, uint64_t> g_pinnedHost;
static std::map<uint64_t, uint64_t> g_mappedHost;
static std::map<uint64_t, uint64_t> g_mappedPair; /* pHost + pDevice */

static std::map<uint64_t, uint64_t>::const_iterator FindRegisteredMemory(
    const std::map<uint64_t, uint64_t> &data,
    const uint64_t value)
{
    if (data.empty()) {
        return data.end();
    }

    // find the first iterator whose key is greater than or equal to value.
    const auto iter = data.lower_bound(value);
    if ((iter != data.end()) && (iter->first == value)) {
        return iter;
    }
    // check whether the previous value range contains value.
    if (iter != data.begin()) {
        const auto prev_iter = std::prev(iter);
        if (value <= prev_iter->second) {
            return prev_iter;
        }
    }
    return data.end();
}

rtError_t InsertPinnedMemory(const void *ptr, const uint64_t size)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    const uint64_t start = RtPtrToValue(ptr);
    const uint64_t end = start + size - 1U;
    if ((FindRegisteredMemory(g_pinnedHost, start) != g_pinnedHost.cend()) ||
        (FindRegisteredMemory(g_pinnedHost, end) != g_pinnedHost.cend())) {
        RT_LOG(RT_LOG_ERROR, "the memory range has already been registered, "
            "base=%#" PRIx64 ", end=%#" PRIx64 ", size=%#" PRIx64 ".", start, end, size);
        return RT_ERROR_HOST_MEMORY_ALREADY_REGISTERED;
    }
    (void)g_pinnedHost.insert({start, end});
    RT_LOG(RT_LOG_INFO, "base=%#" PRIx64 ", end=%#" PRIx64 ", size=%#" PRIx64 ", cnt=%zu.",
        start, end, size, g_pinnedHost.size());
    return RT_ERROR_NONE;
}

void InsertMappedMemory(const void *ptr, const uint64_t size, const void *devPtr)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    const uint64_t hostValue = RtPtrToValue(ptr);
    const uint64_t hostEnd =  hostValue + size - 1U;
    const uint64_t devValue = RtPtrToValue(devPtr);
    (void)g_mappedHost.insert({hostValue, hostEnd});
    (void)g_mappedPair.insert({hostValue, devValue});
    RT_LOG(RT_LOG_INFO, "hostBase=%#" PRIx64 ", hostEnd=%#" PRIx64 ", "
        "size=%#" PRIx64 ", deviceBase=%#" PRIx64 ", mappedMemoryCnt=%zu, memoryPairCnt=%zu.",
        hostValue, hostEnd, size, devValue, g_mappedHost.size(), g_mappedPair.size());
}

bool IsRegisteredMemory(const void *ptr)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    const uint64_t value = RtPtrToValue(ptr);
    if ((!g_pinnedHost.empty()) &&
        (FindRegisteredMemory(g_pinnedHost, value) != g_pinnedHost.cend())) {
        return true;
    }
    if ((!g_mappedHost.empty()) &&
        (FindRegisteredMemory(g_mappedHost, value) != g_mappedHost.cend())) {
        return true;
    }
    return false;
}

bool IsPinnedMemoryBase(const void *ptr)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    const uint64_t key = RtPtrToValue(ptr);
    return (g_pinnedHost.find(key) != g_pinnedHost.end());
}

bool IsMappedMemoryBase(const void *ptr)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    const uint64_t key = RtPtrToValue(ptr);
    return (g_mappedHost.find(key) != g_mappedHost.end());
}

void ErasePinnedMemory(const void *ptr)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    (void)g_pinnedHost.erase(RtPtrToValue(ptr));
    RT_LOG(RT_LOG_INFO, "pinnedMemoryCnt=%zu.", g_pinnedHost.size());
}

void EraseMappedMemory(const void *ptr)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    const uint64_t value = RtPtrToValue(ptr);
    (void)g_mappedHost.erase(value);
    (void)g_mappedPair.erase(value);
    RT_LOG(RT_LOG_INFO, "mappedMemoryCnt=%zu, memoryPairCnt=%zu.", g_mappedHost.size(), g_mappedPair.size());
}

void* GetMappedDevicePointer(const void *ptr)
{
    std::lock_guard<std::mutex> lock(g_registeredMutex);
    const uint64_t key = RtPtrToValue(ptr);
    if (g_mappedHost.find(key) != g_mappedHost.end()) {
        const auto &iter = g_mappedPair.find(key);
        if (iter != g_mappedPair.end()) {
            return RtValueToPtr<void *>(iter->second);
        }
    }
    return nullptr;
}
}  // namespace runtime
}  // namespace cce