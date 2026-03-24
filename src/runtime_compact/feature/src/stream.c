/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "securec.h"
#include "common.h"
#include "context.h"
#include "error_manage.h"
#include "rt_ctrl_model.h"
#include "stream.h"

#if defined(__cplusplus)
extern "C" {
#endif

// stream
typedef struct TagStream {
    uint32_t streamId;
    uint32_t sqId;
    uint32_t priority;
    mmAtomicType64 threadId[MODEL_TYPE_MAX];
    void *sharedWorkPtr;
    size_t sharedWorkSize;
    Context *context;
    uint64_t lastMeid;
} Stream;

static rtError_t SetupStream(Stream* stream)
{
    if (GetContextDevice(stream->context) == NULL) {
        RT_LOG_ERROR("Device is NULL!");
        return ACL_ERROR_RT_DEV_SETUP_ERROR;
    }
    static mmAtomicType streamId = 0;
    stream->streamId = mmValueInc(&streamId, 1);
    struct halSqCqInputInfo in = {0};
    in.cfg.qos = (uint8_t)stream->priority;
    struct halSqCqOutputInfo out = {0};
    drvError_t  drvRet = halSqCqAllocate(GetContextDeviceId(stream->context), &in, &out);
    if (drvRet != DRV_ERROR_NONE) {
        return(rtError_t)ErrorConvert(drvRet);
    }
    stream->sqId = out.sqid;
    return ACL_RT_SUCCESS;
}

rtError_t FreeStream(Stream* stream)
{
    if (stream->sqId != UINT32_MAX) {
        halSqCqFree(GetContextDeviceId(stream->context), (stream)->sqId);
    }
    mmFree(stream);
    return ACL_RT_SUCCESS;
}

Stream *CreateStream(Context *curCtx, rtStreamConfigHandle *handle, rtError_t *error)
{
    Stream *stm = (Stream *)mmMalloc(sizeof(Stream));
    if (stm == NULL) {
        *error = ACL_ERROR_RT_MEMORY_ALLOCATION;
        return NULL;
    }
    stm->streamId = UINT32_MAX;
    stm->sqId = UINT32_MAX;
    stm->threadId[SUBSCRIBE_CALLBACK] = UINT64_MAX;
    stm->threadId[SUBSCRIBE_HOSTFUNC] = UINT64_MAX;
    stm->lastMeid = UINT64_MAX;
    stm->context = curCtx;
    bool valid = (handle != NULL);
    stm->priority = valid ? handle->priority : 0;
    stm->sharedWorkPtr = valid ? handle->workPtr : NULL;
    stm->sharedWorkSize = valid ? handle->workSize : 0;

    *error = SetupStream(stm);
    if (*error != ACL_RT_SUCCESS) {
        FreeStream(stm);
        RT_LOG_ERROR("stream setup fail., ret=%#x.", *error);
        return NULL;
    }

    return stm;
}

uint32_t GetStreamDeviceId(rtStream_t stm)
{
    return GetContextDeviceId(((Stream*)stm)->context);
}

uint64_t GetStreamThreadID(rtStream_t stm, SUBSCRIBE_TYPE type)
{
    return ((Stream*)stm)->threadId[type];
}

bool SetStreamThreadID(rtStream_t stm, SUBSCRIBE_TYPE type, uint64_t threadId)
{
    return mmCompareAndSwap64(&((Stream*)stm)->threadId[type], UINT64_MAX, threadId);
}

void ResetStreamThreadID(rtStream_t stm, SUBSCRIBE_TYPE type)
{
    mmSetData64((mmAtomicType64 *)(&(((Stream*)stm)->threadId[type])), UINT64_MAX);
    return;
}

uint32_t GetStreamSqID(rtStream_t stm)
{
    return ((Stream*)stm)->sqId;
}

rtError_t rtStreamCreateWithConfig(rtStream_t *stm, rtStreamConfigHandle *handle)
{
    if (stm == NULL) {
        RT_LOG_ERROR("stream is NULL!");
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    rtContext_t currentCtx;
    rtError_t err = rtCtxGetCurrent(&currentCtx);
    if (err != ACL_RT_SUCCESS) {
        RT_LOG_ERROR("get current context fail");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    rtError_t error;
    *stm = CreateContextStream((Context*)currentCtx, handle, &error);
    if (*stm == NULL) {
        RT_LOG_ERROR("New stream fail");
        return error;
    }
    return ACL_RT_SUCCESS;
}

rtError_t rtStreamDestroy(rtStream_t stm)
{
    if (stm == NULL) {
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }

    rtContext_t curCtx;
    rtError_t err = rtCtxGetCurrent(&curCtx);
    if (err != ACL_RT_SUCCESS) {
        RT_LOG_ERROR("get current context fail");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    Stream* inStm = (Stream*)stm;
    if (inStm->context != (Context*)curCtx) {
        RT_LOG_ERROR("stream is not in current context.");
        return ACL_ERROR_RT_STREAM_CONTEXT;
    }

    DestroyContextStream(((Stream*)stm)->context, (Stream*)stm);
    return ACL_RT_SUCCESS;
}

rtError_t rtStreamSynchronize(rtStream_t stm)
{
    Stream *inStm = (Stream *)stm;
    if (inStm == NULL) {
        RT_LOG_ERROR("stream is NULL.");
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    return SendNullMdl(inStm->sqId);
}

rtError_t rtStreamGetSqid(const rtStream_t stm, uint32_t *sqId)
{
    if (sqId == NULL) {
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    if (stm == NULL) {
        RT_LOG_ERROR("stream is NULL.");
        return ACL_ERROR_RT_PARAM_INVALID;
    }
    *sqId = ((Stream *)stm)->sqId;
    return ACL_RT_SUCCESS;
}

rtError_t rtStreamGetWorkspace(const rtStream_t stm, void **workaddr, size_t *worksize)
{
    if (stm == NULL || workaddr == NULL || worksize == NULL) {
        return ACL_ERROR_RT_INTERNAL_ERROR;
    }
    *workaddr = ((Stream *)stm)->sharedWorkPtr;
    *worksize = ((Stream *)stm)->sharedWorkSize;
    return ACL_RT_SUCCESS;
}

#if defined(__cplusplus)
}
#endif