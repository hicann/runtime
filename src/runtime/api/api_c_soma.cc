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
#include "api.hpp"
#include "api_soma.hpp"
#include "base.hpp"
#include "api_handle_guard.h"
#include "error_message_manage.hpp"
#include "errcode_manage.hpp"
#include "error_code.h"
#include "dvpp_grp.hpp"
#include "inner.hpp"
#include "osal.hpp"
#include "runtime.hpp"
#include "thread_local_container.hpp"
#include "global_state_manager.hpp"
 
using namespace cce::runtime;
namespace cce {
namespace runtime {
TIMESTAMP_EXTERN(rtMemPoolCreate);
TIMESTAMP_EXTERN(rtMemPoolDestroy);
TIMESTAMP_EXTERN(rtMemPoolSetAttr);
TIMESTAMP_EXTERN(rtMemPoolGetAttr);
TIMESTAMP_EXTERN(rtMemPoolMallocAsync);
TIMESTAMP_EXTERN(rtMemPoolFreeAsync);
}
}
 
#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
 
VISIBILITY_DEFAULT
rtError_t rtMemPoolCreate(rtMemPool_t *memPool, const rtMemPoolProps *poolProps)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiSoma * const apiInstance = ApiSoma::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemPoolCreate);
    const rtError_t error = apiInstance->StreamMemPoolCreate(memPool, poolProps);
    TIMESTAMP_END(rtMemPoolCreate);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtMemPoolDestroy(const rtMemPool_t memPool)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiSoma * const apiInstance = ApiSoma::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemPoolDestroy);
    const rtError_t error = apiInstance->StreamMemPoolDestroy(memPool);
    TIMESTAMP_END(rtMemPoolDestroy);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtMemPoolSetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiSoma * const apiInstance = ApiSoma::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemPoolSetAttr);
    const rtError_t error = apiInstance->StreamMemPoolSetAttr(memPool, attr, value);
    TIMESTAMP_END(rtMemPoolSetAttr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtMemPoolGetAttr(rtMemPool_t memPool, rtMemPoolAttr attr, void *value)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiSoma * const apiInstance = ApiSoma::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    TIMESTAMP_BEGIN(rtMemPoolGetAttr);
    const rtError_t error = apiInstance->StreamMemPoolGetAttr(memPool, attr, value);
    TIMESTAMP_END(rtMemPoolGetAttr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtMemPoolMallocAsync(void **devPtr, const uint64_t size, const rtMemPool_t memPoolId, const rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiSoma * const apiInstance = ApiSoma::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
 
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(exeStream);
    TIMESTAMP_BEGIN(rtMemPoolMallocAsync);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemPoolMallocAsync(devPtr, size, memPoolId, exeStream);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemPoolMallocAsync);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
 
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtMemPoolFreeAsync(void *ptr, rtStream_t stm)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    RT_VALIDATE_AND_UNWRAP_OBJECT(stm, Stream, exeStream);
    ApiSoma * const apiInstance = ApiSoma::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    
    TIMESTAMP_BEGIN(rtMemPoolFreeAsync);
    const auto watchDogHandle = ThreadLocalContainer::GetOrCreateWatchDogHandle();
    (void)AwdStartThreadWatchdog(watchDogHandle);
    const rtError_t error = apiInstance->MemPoolFreeAsync(ptr, exeStream);
    (void)AwdStopThreadWatchdog(watchDogHandle);
    TIMESTAMP_END(rtMemPoolFreeAsync);
 
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}
 
VISIBILITY_DEFAULT
rtError_t rtMemPoolTrimTo(rtMemPool_t memPool, uint64_t minBytesToKeep)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiSoma * const apiInstance = ApiSoma::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiInstance);
    const rtError_t error = apiInstance->MemPoolTrimTo(memPool, minBytesToKeep);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus