/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api.hpp"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

VISIBILITY_DEFAULT
rtError_t rtMbufInit(rtMemBuffCfg_t* cfg)
{
    UNUSED(cfg);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufBuild(void* buff, const uint64_t size, rtMbufPtr_t* mbufPtr)
{
    UNUSED(buff);
    UNUSED(size);
    UNUSED(mbufPtr);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufAlloc(rtMbufPtr_t* memBuf, uint64_t size)
{
    UNUSED(memBuf);
    UNUSED(size);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufAllocEx(rtMbufPtr_t* memBuf, uint64_t size, uint64_t flag, int32_t grpId)
{
    UNUSED(memBuf);
    UNUSED(size);
    UNUSED(flag);
    UNUSED(grpId);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufUnBuild(const rtMbufPtr_t mbufPtr, void** buff, uint64_t* size)
{
    UNUSED(mbufPtr);
    UNUSED(buff);
    UNUSED(size);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtBuffGet(const rtMbufPtr_t mbufPtr, void* buff, const uint64_t size)
{
    UNUSED(mbufPtr);
    UNUSED(buff);
    UNUSED(size);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtBuffPut(const rtMbufPtr_t mbufPtr, void* buff)
{
    UNUSED(mbufPtr);
    UNUSED(buff);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufFree(rtMbufPtr_t memBuf)
{
    UNUSED(memBuf);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufSetDataLen(rtMbufPtr_t memBuf, uint64_t len)
{
    UNUSED(memBuf);
    UNUSED(len);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetDataLen(rtMbufPtr_t memBuf, uint64_t* len)
{
    UNUSED(memBuf);
    UNUSED(len);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetBuffAddr(rtMbufPtr_t memBuf, void** buf)
{
    UNUSED(memBuf);
    UNUSED(buf);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetBuffSize(rtMbufPtr_t memBuf, uint64_t* totalSize)
{
    UNUSED(memBuf);
    UNUSED(totalSize);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufGetPrivInfo(rtMbufPtr_t memBuf, void** priv, uint64_t* size)
{
    UNUSED(memBuf);
    UNUSED(priv);
    UNUSED(size);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufCopyBufRef(rtMbufPtr_t memBuf, rtMbufPtr_t* newMemBuf)
{
    UNUSED(memBuf);
    UNUSED(newMemBuf);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufChainAppend(rtMbufPtr_t memBufChainHead, rtMbufPtr_t memBuf)
{
    UNUSED(memBufChainHead);
    UNUSED(memBuf);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufChainGetMbufNum(rtMbufPtr_t memBufChainHead, uint32_t* num)
{
    UNUSED(memBufChainHead);
    UNUSED(num);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

VISIBILITY_DEFAULT
rtError_t rtMbufChainGetMbuf(rtMbufPtr_t memBufChainHead, uint32_t index, rtMbufPtr_t* memBuf)
{
    UNUSED(memBufChainHead);
    UNUSED(index);
    UNUSED(memBuf);
    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;
}

#ifdef __cplusplus
}
#endif // __cplusplus
