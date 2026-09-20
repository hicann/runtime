/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_c.h"
#include "api_ipc_memory.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "global_state_manager.hpp"
#include "runtime/rts/rts_mem.h"

#include <string>

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtIpcSetMemoryName(const void* ptr, uint64_t byteCount, char_t* name, uint32_t len)
{
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcSetMemoryName(ptr, byteCount, name, len, RT_IPC_MEM_FLAG_DEFAULT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcDestroyMemoryName(const char_t* name)
{
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcDestroyMemoryName(name);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcOpenMemory(void** ptr, const char_t* name)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcOpenMemory(ptr, name, RT_IPC_MEM_FLAG_DEFAULT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcCloseMemory(const void* ptr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcCloseMemory(ptr);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetIpcMemPid(const char_t* name, int32_t pid[], int32_t num)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->SetIpcMemPid(name, pid, num);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtSetIpcMemorySuperPodPid(const char* name, uint32_t sdid, int32_t pid[], int32_t num)
{
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->ShmemSetPodPid(name, sdid, pid, num);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtIpcMemImportPidInterServer(const char* key, const rtServerPid* serverPids, size_t num)
{
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(key, RT_ERROR_INVALID_VALUE);
    PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(serverPids, RT_ERROR_INVALID_VALUE);
    COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(num == 0UL, RT_ERROR_INVALID_VALUE, num, "not equal to 0");

    for (size_t i = 0; i < num; i++) {
        COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER(
            (serverPids[i].pid == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004, __func__,
            "serverPids[" + std::to_string(i) + "].pid");
        COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER(
            (serverPids[i].num > static_cast<size_t>(INT32_MAX)), RT_ERROR_INVALID_VALUE, ErrorCode::EE1003, __func__,
            serverPids[i].num, "serverPids[" + std::to_string(i) + "].num", "INT32_MAX");
        const rtError_t ret = rtSetIpcMemorySuperPodPid(
            key, serverPids[i].sdid, serverPids[i].pid, static_cast<int32_t>(serverPids[i].num));
        if (ret != ACL_RT_SUCCESS) {
            return ret;
        }
    }

    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemGetExportKey(const void* ptr, size_t size, char_t* key, uint32_t len, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcSetMemoryName(ptr, static_cast<uint64_t>(size), key, len, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemClose(const char_t* key)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    Runtime* const rtInstance = Runtime::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(rtInstance);

    const rtChipType_t chipType = rtInstance->GetChipType();
    if (!IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_IPC_MEMORY)) {
        RT_LOG(RT_LOG_WARNING, "chip type(%d) does not support IpcMemClose.", chipType);
        return GetRtExtErrCodeAndSetGlobalErr(RT_ERROR_FEATURE_NOT_SUPPORT);
    }

    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcCloseMemoryByName(key);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemImportByKey(void** ptr, const char_t* key, uint64_t flags)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiIpcMemory* const apiInstance = ApiIpcMemory::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->IpcOpenMemory(ptr, key, flags);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtsIpcMemSetImportPid(const char_t* key, int32_t pid[], int num) { return rtSetIpcMemPid(key, pid, num); }

#ifdef __cplusplus
}
#endif // __cplusplus
