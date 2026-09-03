/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl_rt_impl.h"

#include <cstring>
#include "runtime/rts/rts_dfx.h"

#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"
#include "common/resource_statistics.h"

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtProfTraceImpl(void* userdata, int32_t length, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtProfTrace);
    ACL_LOG_INFO("start to execute AclrtProfTrace, length is [%d]", length);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(userdata);
    ACL_REQUIRES_RTS_OK(rtsProfTrace(userdata, length, stream));
    return ACL_SUCCESS;
}

#ifdef ACL_RT_API_HOOK_ENABLE

namespace {
const AclrtApiLookupEntry* g_hookLookupTable = nullptr;
size_t g_hookLookupCount = 0;

aclrtApiEntry* FindHookEntryByName(const char* name)
{
    if (name == nullptr) {
        return nullptr;
    }
    if ((g_hookLookupTable == nullptr) || (g_hookLookupCount == 0)) {
        ACL_LOG_WARN("Hook lookup table not registered yet.");
        return nullptr;
    }
    for (size_t i = 0; i < g_hookLookupCount; ++i) {
        if (strcmp(name, g_hookLookupTable[i].name) == 0) {
            ACL_LOG_DEBUG("Find api, name is [%s].", name);
            return g_hookLookupTable[i].entry;
        }
    }
    ACL_LOG_DEBUG("Cannot find api, name is [%s].", name);
    return nullptr;
}
} // namespace

ACL_FUNC_VISIBILITY void RegisterHookLookupTable(const AclrtApiLookupEntry* table, size_t count)
{
    g_hookLookupTable = table;
    g_hookLookupCount = count;
    ACL_LOG_DEBUG("Hook lookup table registered, count=%zu.", count);
}

__attribute__((constructor)) void RegisterApiHookToProf()
{
    auto ret = MsprofSetInjectionFunc(
        static_cast<uint32_t>(PROF_HOOK_SET), reinterpret_cast<void*>(&aclrtApiInjectionSetFuncImpl));
    if (ret != 0) {
        ACL_LOG_WARN("MsprofSetInjectionFunc register set function failed, prof result = %d", ret);
    }
    ret = MsprofSetInjectionFunc(
        static_cast<uint32_t>(PROF_HOOK_GET), reinterpret_cast<void*>(&aclrtApiInjectionGetFuncImpl));
    if (ret != 0) {
        ACL_LOG_WARN("MsprofSetInjectionFunc register get function failed, prof result = %d", ret);
    }
    ret = MsprofInjectionInitialize();
    if (ret != 0) {
        ACL_LOG_WARN("MsprofInjectionInitialize failed, prof result = %d", ret);
    }
    ACL_LOG_DEBUG("Hook init finished.");
}
#endif // ACL_RT_API_HOOK_ENABLE

aclError aclrtApiInjectionSetFuncImpl(const char* name, aclrtApiFunc func)
{
#ifdef ACL_RT_API_HOOK_ENABLE
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(name);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(func);
    ACL_LOG_INFO("start to execute aclrtApiInjectionSetFunc, name is [%s].", name);

    aclrtApiEntry* entry = FindHookEntryByName(name);
    if (entry == nullptr) {
        ACL_LOG_ERROR("[aclrtApiInjectionSetFunc]This interface cannot be injected: [%s].", name);
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        acl::AclErrorLogManager::ReportInputError(
            acl::INVALID_VALUE_MSG, {"func", "value", "param", "expect"},
            {funcName.c_str(), name, "name", "The API name is prefixed with aclrt or aclmdlRI"});
        return ACL_ERROR_INVALID_PARAM;
    }
    __atomic_store_n(&entry->currentFunc, func, __ATOMIC_RELEASE);

    ACL_LOG_INFO(
        "end to execute aclrtApiInjectionSetFunc, set to %s func, name is [%s].",
        ((func == entry->originalFunc) ? "original" : "hook"), name);
    return ACL_SUCCESS;
#else  // !ACL_RT_API_HOOK_ENABLE
    (void)name;
    (void)func;
    ACL_LOG_ERROR("[aclrtApiInjectionSetFunc]This feature is not supported.");
    acl::AclErrorLogManager::ReportInputError(acl::UNSUPPORTED_SYSTEM_MSG, {"func"}, {"aclrtApiInjectionSetFunc"});
    return ACL_ERROR_FEATURE_UNSUPPORTED;
#endif // ACL_RT_API_HOOK_ENABLE
}

aclError aclrtApiInjectionGetFuncImpl(const char* name, aclrtApiFunc* originFunc, aclrtApiFunc* currentFunc)
{
#ifdef ACL_RT_API_HOOK_ENABLE
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(name);
    ACL_LOG_INFO("start to execute aclrtApiInjectionGetFunc, name is [%s].", name);

    aclrtApiEntry* entry = FindHookEntryByName(name);
    if (entry == nullptr) {
        ACL_LOG_ERROR("[aclrtApiInjectionGetFunc]This interface cannot be injected so cannot get: [%s].", name);
        std::string funcName = acl::AclErrorLogManager::GetFuncNameWithoutImplSuffix(__func__);
        acl::AclErrorLogManager::ReportInputError(
            acl::INVALID_VALUE_MSG, {"func", "value", "param", "expect"},
            {funcName.c_str(), name, "name", "The API name is prefixed with aclrt or aclmdlRI"});
        return ACL_ERROR_INVALID_PARAM;
    }
    if (originFunc != nullptr) {
        *originFunc = entry->originalFunc;
    }
    if (currentFunc != nullptr) {
        *currentFunc = __atomic_load_n(&entry->currentFunc, __ATOMIC_ACQUIRE);
    }
    ACL_LOG_INFO("end to execute aclrtApiInjectionGetFunc, name is [%s].", name);
    return ACL_SUCCESS;
#else  // !ACL_RT_API_HOOK_ENABLE
    (void)name;
    (void)originFunc;
    (void)currentFunc;
    ACL_LOG_ERROR("[aclrtApiInjectionGetFunc]This feature is not supported.");
    acl::AclErrorLogManager::ReportInputError(acl::UNSUPPORTED_SYSTEM_MSG, {"func"}, {"aclrtApiInjectionGetFunc"});
    return ACL_ERROR_FEATURE_UNSUPPORTED;
#endif // ACL_RT_API_HOOK_ENABLE
}
#ifdef __cplusplus
}
#endif
