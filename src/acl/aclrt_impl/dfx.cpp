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
#if __GNUC__ >= 8
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wcast-function-type"
#endif // __GNUC__ >= 8
ACL_RT_FUNC_MAP(ACL_HOOK_DEF)
ACL_RT_ALLOCATOR_FUNC_MAP(ACL_HOOK_DEF)
ACL_MDLRI_FUNC_MAP(ACL_HOOK_DEF)
#if __GNUC__ >= 8
#pragma GCC diagnostic pop
#endif // __GNUC__ >= 8

namespace {
// Cold-path lookup table for SetFunc/GetFunc (string name -> entry pointer).
// Linear scan is sufficient: ~250 entries, only invoked by tools at init time.
struct AclrtApiLookupEntry {
    const char* name;
    aclrtApiEntry* entry;
};

#define ACL_HOOK_LOOKUP(ret, name, sig, args) {#name, &g_hook_##name},
const AclrtApiLookupEntry g_aclrtApiLookup[] = {ACL_RT_FUNC_MAP(ACL_HOOK_LOOKUP) ACL_MDLRI_FUNC_MAP(ACL_HOOK_LOOKUP)
                                                    ACL_RT_ALLOCATOR_FUNC_MAP(ACL_HOOK_LOOKUP)};
#undef ACL_HOOK_LOOKUP

constexpr size_t ACLRT_API_LOOKUP_COUNT = sizeof(g_aclrtApiLookup) / sizeof(g_aclrtApiLookup[0]);

aclrtApiEntry* FindHookEntryByName(const char* name)
{
    if (name == nullptr) {
        return nullptr;
    }
    for (size_t i = 0; i < ACLRT_API_LOOKUP_COUNT; ++i) {
        if (strcmp(name, g_aclrtApiLookup[i].name) == 0) {
            return g_aclrtApiLookup[i].entry;
        }
    }
    return nullptr;
}
} // namespace
#endif // ACL_RT_API_HOOK_ENABLE

#ifdef ACL_RT_API_HOOK_ENABLE
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
