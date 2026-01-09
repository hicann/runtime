/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "api_c.h"
#include "api.hpp"
#include "api_mbuf.hpp"
#include "osal.hpp"
#include "global_state_manager.hpp"

using namespace cce::runtime;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtMbufInit(rtMemBuffCfg_t *cfg)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    const rtError_t error = apiMbufInstance->MbufInit(cfg);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT); // special state
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_DRV_REPEATED_INIT, ACL_ERROR_RT_REPEATED_INIT); // special state
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufBuild(void* buff, const uint64_t size, rtMbufPtr_t *mbufPtr)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(buff, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufBuild(buff, size, mbufPtr);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufAlloc(rtMbufPtr_t *memBuf, uint64_t size)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufAlloc(memBuf, size);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufAllocEx(rtMbufPtr_t *memBuf, uint64_t size, uint64_t flag, int32_t grpId)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufAllocEx(memBuf, size, flag, grpId);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufUnBuild(const rtMbufPtr_t mbufPtr, void **buff, uint64_t *size)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(mbufPtr, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufUnBuild(mbufPtr, buff, size);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtBuffGet(const rtMbufPtr_t mbufPtr, void *buff, const uint64_t size)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(buff, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufGet(mbufPtr, buff, size);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
rtError_t rtBuffPut(const rtMbufPtr_t mbufPtr, void *buff)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(buff, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufPut(mbufPtr, buff);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}


VISIBILITY_DEFAULT
rtError_t rtMbufFree(rtMbufPtr_t memBuf)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufFree(memBuf);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufSetDataLen(rtMbufPtr_t memBuf, uint64_t len)
{
    GLOBAL_STATE_WAIT_IF_LOCKED();
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufSetDataLen(memBuf, len);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetDataLen(rtMbufPtr_t memBuf, uint64_t *len)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG_OUTER(len, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufGetDataLen(memBuf, len);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetBuffAddr(rtMbufPtr_t memBuf, void **buf)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG_OUTER(buf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufGetBuffAddr(memBuf, buf);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetBuffSize(rtMbufPtr_t memBuf, uint64_t *totalSize)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG_OUTER(totalSize, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufGetBuffSize(memBuf, totalSize);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetPrivInfo(rtMbufPtr_t memBuf,  void **priv, uint64_t *size)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG_OUTER(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG_OUTER(priv, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG_OUTER(size, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufGetPrivInfo(memBuf, priv, size);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufCopyBufRef(rtMbufPtr_t memBuf, rtMbufPtr_t *newMemBuf)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    NULL_PTR_RETURN_MSG(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG(newMemBuf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufCopyBufRef(memBuf, newMemBuf);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufChainAppend(rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG(memBufChainHead, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufChainAppend(memBufChainHead, memBuf);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufChainGetMbufNum(rtMbufPtr_t memBufChainHead, uint32_t *num)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG(memBufChainHead, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG(num, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufChainGetMbufNum(memBufChainHead, num);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

VISIBILITY_DEFAULT
rtError_t rtMbufChainGetMbuf(rtMbufPtr_t memBufChainHead, uint32_t index, rtMbufPtr_t *memBuf)
{
    ApiMbuf * const apiMbufInstance = ApiMbuf::Instance();
    NULL_RETURN_ERROR_WITH_EXT_ERRCODE(apiMbufInstance);
    TIMESTAMP_NAME(__func__);
    NULL_PTR_RETURN_MSG(memBufChainHead, ACL_ERROR_RT_PARAM_INVALID);
    NULL_PTR_RETURN_MSG(memBuf, ACL_ERROR_RT_PARAM_INVALID);
    const rtError_t error = apiMbufInstance->MbufChainGetMbuf(memBufChainHead, index, memBuf);
    COND_RETURN_WITH_NOLOG(error == RT_ERROR_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    ERROR_RETURN_WITH_EXT_ERRCODE(error);
    return ACL_RT_SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus