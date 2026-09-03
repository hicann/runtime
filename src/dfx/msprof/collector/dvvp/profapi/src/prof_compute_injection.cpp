/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. See
 * LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_cann_plugin.h"

#include <cstdlib>
#include <dlfcn.h>
#include <mutex>

#include "errno/error_code.h"
#include "msprof_dlog.h"
#include "prof_acl_plugin.h"
#include "prof_compute_injection_impl.h"
#include "prof_api.h"
#include "prof_mstx_plugin.h"
#include "prof_tx_plugin.h"
#include "securec.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;

namespace {
constexpr char ACL_API_INJECTION_ENV[] = "ACL_API_INJECTION";
constexpr char ACL_TOOL_INITIALIZE_FUNC[] = "acltoolInitialize";

bool HasAclToolInjectionPath(const char* injectionPath) { return injectionPath != nullptr && injectionPath[0] != '\0'; }

int32_t LoadAclToolLibrary(const char* injectionPath, void*& aclToolHandle)
{
    aclToolHandle = dlopen(injectionPath, RTLD_LAZY | RTLD_LOCAL);
    if (aclToolHandle == nullptr) {
        MSPROF_LOGE("Failed to dlopen acl tool injection:%s.", dlerror());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t GetAclToolInitialize(void* aclToolHandle, ProfAPI::AclToolInitializeFunc& initializeFunc)
{
    initializeFunc = reinterpret_cast<ProfAPI::AclToolInitializeFunc>(dlsym(aclToolHandle, ACL_TOOL_INITIALIZE_FUNC));
    if (initializeFunc == nullptr) {
        MSPROF_LOGE("Failed to find acltoolInitialize:%s.", dlerror());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t CallAclToolInitialize(ProfAPI::AclToolInitializeFunc initializeFunc)
{
    if (initializeFunc() != PROFILING_SUCCESS) {
        MSPROF_LOGE("acltoolInitialize failed.");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t PrepareInjectionState(
    ProfAPI::InjectionState& state, const char* injectionPath, ProfAPI::AclToolInitializeFunc& initializeFunc,
    void* newAclToolHandle, void*& oldAclToolHandle)
{
    const bool hasInjectionPath = HasAclToolInjectionPath(injectionPath);
    if (!hasInjectionPath) {
        initializeFunc =
            reinterpret_cast<ProfAPI::AclToolInitializeFunc>(state.hookInitFunc.load(std::memory_order_acquire));
    }
    if (initializeFunc == nullptr) {
        MSPROF_LOGI("ACL_API_INJECTION and PROF_HOOK_INIT are not configured.");
        oldAclToolHandle = state.aclToolHandle.exchange(nullptr, std::memory_order_acq_rel);
        state.setInjectionFunc.store(nullptr, std::memory_order_release);
        state.getInjectionFunc.store(nullptr, std::memory_order_release);
        state.hookInitFunc.store(nullptr, std::memory_order_release);
        state.injectionEnabled.store(false, std::memory_order_release);
        return PROFILING_SUCCESS;
    }
    if (state.setInjectionFunc.load(std::memory_order_acquire) == nullptr ||
        state.getInjectionFunc.load(std::memory_order_acquire) == nullptr) {
        MSPROF_LOGE("Runtime injection funcs are not registered.");
        oldAclToolHandle = state.aclToolHandle.exchange(nullptr, std::memory_order_acq_rel);
        state.setInjectionFunc.store(nullptr, std::memory_order_release);
        state.getInjectionFunc.store(nullptr, std::memory_order_release);
        state.hookInitFunc.store(nullptr, std::memory_order_release);
        state.injectionEnabled.store(false, std::memory_order_release);
        return PROFILING_FAILED;
    }
    oldAclToolHandle = state.aclToolHandle.exchange(newAclToolHandle, std::memory_order_acq_rel);
    state.injectionEnabled.store(true, std::memory_order_release);
    return PROFILING_SUCCESS;
}
} // namespace

namespace ProfAPI {
int32_t ProfCannPlugin::ProfSetInjectionFunc(uint32_t type, void* func)
{
    if (func == nullptr) {
        MSPROF_LOGE("Invalid injection func, type:%u.", type);
        return PROFILING_FAILED;
    }
    auto& state = GetInjectionState();
    if (type == PROF_HOOK_SET) {
        state.setInjectionFunc.store(func, std::memory_order_release);
    } else if (type == PROF_HOOK_GET) {
        state.getInjectionFunc.store(func, std::memory_order_release);
    } else if (type == PROF_HOOK_INIT) {
        state.hookInitFunc.store(func, std::memory_order_release);
    } else {
        MSPROF_LOGE("Invalid injection func type:%u.", type);
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfCannPlugin::ProfInjectionInitialize()
{
    auto& state = GetInjectionState();
    const char* injectionPath = std::getenv(ACL_API_INJECTION_ENV);
    AclToolInitializeFunc initializeFunc = nullptr;
    void* newAclToolHandle = nullptr;
    if (HasAclToolInjectionPath(injectionPath) &&
        (LoadAclToolLibrary(injectionPath, newAclToolHandle) != PROFILING_SUCCESS ||
         GetAclToolInitialize(newAclToolHandle, initializeFunc) != PROFILING_SUCCESS)) {
        if (newAclToolHandle != nullptr) {
            dlclose(newAclToolHandle);
        }
        ProfResetInjectionState();
        return PROFILING_FAILED;
    }

    void* oldAclToolHandle = nullptr;
    if (PrepareInjectionState(state, injectionPath, initializeFunc, newAclToolHandle, oldAclToolHandle) !=
        PROFILING_SUCCESS) {
        if (newAclToolHandle != nullptr) {
            dlclose(newAclToolHandle);
        }
        if (oldAclToolHandle != nullptr) {
            dlclose(oldAclToolHandle);
        }
        return PROFILING_FAILED;
    }
    if (initializeFunc == nullptr) {
        if (oldAclToolHandle != nullptr) {
            dlclose(oldAclToolHandle);
        }
        return PROFILING_SUCCESS;
    }
    if (CallAclToolInitialize(initializeFunc) != PROFILING_SUCCESS) {
        if (oldAclToolHandle != nullptr) {
            dlclose(oldAclToolHandle);
        }
        ProfResetInjectionState();
        return PROFILING_FAILED;
    }
    if (oldAclToolHandle != nullptr) {
        dlclose(oldAclToolHandle);
    }
    MSPROF_LOGI("Initialize acl tool injection success.");
    return PROFILING_SUCCESS;
}

void* ProfCannPlugin::ProfGetInjectionFunc(uint32_t type)
{
    auto& state = GetInjectionState();
    if (!state.injectionEnabled.load(std::memory_order_acquire)) {
        MSPROF_LOGW("Acl tool injection is not enabled.");
        return nullptr;
    }
    if (type == PROF_HOOK_SET) {
        return state.setInjectionFunc.load(std::memory_order_acquire);
    }
    if (type == PROF_HOOK_GET) {
        return state.getInjectionFunc.load(std::memory_order_acquire);
    }
    MSPROF_LOGE("Invalid injection func type:%u.", type);
    return nullptr;
}

int32_t ProfCannPlugin::ProfRegisterDataCallback(uint32_t type, void* callback)
{
    if (type != PROF_DATA_CALLBACK_COMPUTE || callback == nullptr) {
        MSPROF_LOGE("Invalid compute data callback, type:%u.", type);
        return PROFILING_FAILED;
    }
    {
        auto& state = GetInjectionState();
        std::lock_guard<std::mutex> lock(state.dataCallbackMutex);
        state.pendingDataCallbackType = type;
        state.pendingDataCallback = callback;
        state.pendingDataCallbackReady = true;
        if (profRegisterDataCallback_ != nullptr) {
            int32_t ret = profRegisterDataCallback_(type, callback);
            if (ret == PROFILING_SUCCESS) {
                state.pendingDataCallbackReady = false;
            }
            return ret;
        }
    }
    MSPROF_LOGI("Cache compute data callback until prof impl is ready.");
    return PROFILING_SUCCESS;
}

int32_t ProfCannPlugin::SyncComputeDataCallback()
{
    auto& state = GetInjectionState();
    std::lock_guard<std::mutex> lock(state.dataCallbackMutex);
    if (!state.pendingDataCallbackReady || profRegisterDataCallback_ == nullptr) {
        return PROFILING_SUCCESS;
    }
    int32_t ret = profRegisterDataCallback_(state.pendingDataCallbackType, state.pendingDataCallback);
    if (ret == PROFILING_SUCCESS) {
        state.pendingDataCallbackReady = false;
    }
    return ret;
}
} // namespace ProfAPI
