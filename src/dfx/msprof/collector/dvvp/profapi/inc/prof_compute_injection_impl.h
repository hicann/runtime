/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef PROF_COMPUTE_INJECTION_IMPL_H
#define PROF_COMPUTE_INJECTION_IMPL_H

#include <atomic>
#include <cstdint>
#include <mutex>

namespace ProfAPI {
using AclToolInitializeFunc = int32_t (*)();

// Injection registration is lock-free on the pointer path.
// Initialize reads a snapshot of the registered pointers and applies state changes separately.
struct InjectionState {
    std::mutex dataCallbackMutex;
    std::atomic<void*> setInjectionFunc{nullptr};
    std::atomic<void*> getInjectionFunc{nullptr};
    std::atomic<void*> hookInitFunc{nullptr};
    std::atomic<void*> aclToolHandle{nullptr};
    uint32_t pendingDataCallbackType = 0;
    void* pendingDataCallback = nullptr;
    bool pendingDataCallbackReady = false;
    std::atomic<bool> injectionEnabled{false};
};
} // namespace ProfAPI

#endif
