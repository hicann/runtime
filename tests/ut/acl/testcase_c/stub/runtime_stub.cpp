/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stub/runtime_stub.h"

static constexpr rtError_t RT_ERROR_STUB_FAILURE = -1;

rtError_t rtMalloc(void **devPtr, uint64_t size, rtMemType_t type, uint16_t moduleId)
{
    (void)moduleId;
    const uint32_t p2pTypeSet = RT_MEMORY_POLICY_HUGE_PAGE_FIRST_P2P | RT_MEMORY_POLICY_HUGE_PAGE_ONLY_P2P |
                                RT_MEMORY_POLICY_DEFAULT_PAGE_ONLY_P2P;
    if ((type & p2pTypeSet) != 0U) {
      return ACL_ERROR_FEATURE_UNSUPPORTED;
    }
    
    if (size == 0) {
        return RT_ERROR_STUB_FAILURE;
    }
    *devPtr = malloc(size);
    return *devPtr != nullptr ? RT_ERROR_NONE : RT_ERROR_STUB_FAILURE;
}

rtError_t rtFree(void *devPtr)
{
    free(devPtr);
    return RT_ERROR_NONE;
}

rtError_t rtMemcpy(void *dst, uint64_t destMax, const void *src, uint64_t count, rtMemcpyKind_t kind)
{
    (void)dst;
    (void)src;
    (void)kind;
    if (destMax < count) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtMemset(void *devPtr, uint64_t destMax, uint32_t value, uint64_t count)
{
    (void)devPtr;
    (void)value;
    if (destMax < count) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtMemGetInfoEx(rtMemInfoType_t memInfoType, size_t *free, size_t *total)
{
    (void)free;
    (void)total;
    if (memInfoType > (rtMemInfoType_t)ACL_HBM_MEM_P2P_NORMAL) {
      return ACL_ERROR_RT_INVALID_MEMORY_TYPE;
    }
    return RT_ERROR_NONE;
}

rtError_t rtInit()
{
    return RuntimeStubMock::GetInstance().rtInit();
}

void rtDeinit()
{
    return;
}

rtError_t rtSetDevice(int32_t device)
{
    if (device < 0) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtDeviceReset(int32_t device)
{
    if (device < 0) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtGetDevice(int32_t *device)
{
    if (device == NULL || device == (int32_t *)0x2) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtCtxCreateEx(rtContext_t *ctx, uint32_t flags, int32_t device)
{
    (void)flags;
    (void)device;
    if (ctx == NULL || ctx == (rtContext_t *)0x2) {
        return ACL_ERROR_INVALID_PARAM;
    }
    if (device < 0) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtCtxDestroyEx(rtContext_t ctx)
{
    if (ctx == NULL || ctx == (rtContext_t)0x2) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtCtxSetCurrent(rtContext_t ctx)
{
    if (ctx == NULL || ctx == (rtContext_t)0x2) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtStreamSetLastMeid(rtStream_t stream, const uint64_t meid)
{
    (void)meid;
    if (stream == NULL) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtStreamGetSqid(const rtStream_t stream, uint32_t* sqId)
{
    if (stream == NULL || sqId == NULL) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtStreamDestroy(rtStream_t stream)
{
    if (stream == NULL || stream == (rtStream_t)0x2) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtStreamSynchronize(rtStream_t stream)
{
    if (stream == (rtStream_t)0x2) {
        return ACL_ERROR_INVALID_PARAM;
    }
    (void)stream;
    return RT_ERROR_NONE;
}

rtError_t rtStreamGetWorkspace(rtStream_t stream, void **workaddr, size_t *worksize) {
    (void)workaddr;
    (void)worksize;
    if (stream == NULL) {
        return ACL_ERROR_INVALID_PARAM;
    }
    return RT_ERROR_NONE;
}

rtError_t rtSubscribeReport(uint64_t threadId, rtStream_t stream) {
  return RuntimeStubMock::GetInstance().rtSubscribeReport(threadId, stream);
}

rtError_t rtUnSubscribeReport(uint64_t threadId, rtStream_t stream)
{
    return RuntimeStubMock::GetInstance().rtUnSubscribeReport(threadId, stream);
}

rtError_t rtCallbackLaunch(rtCallback_t callBackFunc, void *fnData, rtStream_t stream, bool isBlock)
{
    return RuntimeStubMock::GetInstance().rtCallbackLaunch(callBackFunc, fnData, stream, isBlock);
}

rtError_t rtProcessReport(int32_t timeout)
{
    return RuntimeStubMock::GetInstance().rtProcessReport(timeout);
}

rtError_t rtSubscribeHostFunc(uint64_t threadId, rtStream_t stream) {
  return RuntimeStubMock::GetInstance().rtSubscribeHostFunc(threadId, stream);
}

rtError_t rtUnSubscribeHostFunc(uint64_t threadId, rtStream_t stream)
{
    return RuntimeStubMock::GetInstance().rtUnSubscribeHostFunc(threadId, stream);
}

rtError_t rtProcessHostFunc(int32_t timeout)
{
    return RuntimeStubMock::GetInstance().rtProcessHostFunc(timeout);
}

rtError_t rtCtxGetCurrent(rtContext_t *ctx)
{
    return RuntimeStubMock::GetInstance().rtCtxGetCurrent(ctx);
}

rtError_t rtGetRunMode(rtRunMode *mode)
{
    return RuntimeStubMock::GetInstance().rtGetRunMode(mode);
}

rtError_t rtStreamCreateWithConfig(rtStream_t *stream, rtStreamConfigHandle *handle)
{
    return RuntimeStubMock::GetInstance().rtStreamCreateWithConfig(stream, handle);
}

rtError_t rtGetRunMode_Device_Normal_Invoke(rtRunMode *mode) {
  *mode = RT_RUN_MODE_OFFLINE;
  return RT_ERROR_NONE;
}