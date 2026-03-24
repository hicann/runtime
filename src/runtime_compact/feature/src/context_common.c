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
#include "device.h"
#include "stream.h"
#include "mem_pool.h"
#include "sort_vector.h"
#include "context.h"

#if defined(__cplusplus)
extern "C" {
#endif
static MemPool g_contextMemPool = MEM_POOL_INIT(sizeof(Context));

// context
Device *GetContextDevice(Context *context)
{
    return context->device;
}

uint32_t GetContextDeviceId(Context *context)
{
    return GetDeviceId(context->device);
}

static void DestroyStream(void *pStream)
{
    FreeStream(*(Stream**)pStream);
    return;
}

static void FreeContextRes(Context* context)
{
    TearDownContext(context);
    mmMutexDestroy(&((context)->streamLock));
    return;
}

static void FreeContext(Context *context)
{
    MemPoolFreeWithCSingleList(&g_contextMemPool, context, (FnDestroy)FreeContextRes);
    return;
}

static Context* CreateContext(Device* const dev, rtError_t *error)
{
    Context* ctx = (Context *)MemPoolAllocWithCSingleList(&g_contextMemPool);
    if (ctx == NULL) {
        RT_LOG_ERROR("malloc fail");
        *error = ACL_ERROR_RT_MEMORY_ALLOCATION;
        return NULL;
    }
    ctx->device = dev;
    InitVector(&(ctx->streamVec), sizeof(Stream*));
    SetVectorDestroyItem(&(ctx->streamVec), DestroyStream);

    mmMutexInit(&ctx->streamLock);

    *error = SetupContext(ctx);
    if (*error != RT_ERROR_NONE) {
        FreeContext(ctx);
        return NULL;
    }
    return ctx;
}

static rtError_t EmplaceStream(Context* curCtx, Stream* stream)
{
    mmMutexLock(&curCtx->streamLock);
    void *err = EmplaceBackVector(&(curCtx->streamVec), &stream);
    mmMutexUnLock(&curCtx->streamLock);
    return err == NULL ? ACL_ERROR_RT_INTERNAL_ERROR : RT_ERROR_NONE;
}

Stream *CreateContextStream(Context* curCtx, rtStreamConfigHandle *handle, rtError_t *error)
{
    Stream *stm = CreateStream(curCtx, handle, error);
    if (stm != NULL) {
        if (EmplaceStream(curCtx, stm) != RT_ERROR_NONE) {
            FreeStream(stm);
            RT_LOG_ERROR("EmplaceStream fail");
            *error = ACL_ERROR_RT_INTERNAL_ERROR;
            return NULL;
        }
    }
    return stm;
}

void DestroyContextStream(Context* curCtx, Stream* stream)
{
    mmMutexLock(&curCtx->streamLock);
    size_t size = VectorSize(&(curCtx->streamVec));
    for (size_t i = 0; i < size; ++i) {
        Stream *tmpStm = *(Stream **)VectorAt(&(curCtx->streamVec), i);
        if (tmpStm == stream) {
            RemoveVector(&(curCtx->streamVec), i);
            break;
        }
    }
    mmMutexUnLock(&curCtx->streamLock);
    return;
}

static void DestroyContext(Context *context)
{
    FreeContextRes(context);
    uint32_t devId = GetContextDeviceId(context);
    (void)ReleaseDevice(devId);
    return;
}

rtError_t rtCtxCreateEx(rtContext_t *createCtx, uint32_t flags, int32_t devId)
{
    (void)flags;
    if (createCtx == NULL) {
        RT_LOG_ERROR("context is NULL");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    Device *const dev = RetainDevice((uint32_t)devId);
    if (dev == NULL) {
        RT_LOG_ERROR("retain dev fail, devId=%d.", devId);
        return ACL_ERROR_RT_DEV_SETUP_ERROR;
    }
    rtError_t error;
    *createCtx = CreateContext(dev, &error);
    if (*createCtx == NULL) {
        ReleaseDevice((uint32_t)devId);
        RT_LOG_ERROR("context is NULL");
        return error;
    }
    return RT_ERROR_NONE;
}

rtError_t rtCtxDestroyEx(rtContext_t destroyCtx)
{
    if ((!((destroyCtx != NULL) && MemPoolMemUsed(destroyCtx))) || destroyCtx == NULL) {
        RT_LOG_ERROR("input is invalid");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }

    MemPoolFreeWithCSingleList(&g_contextMemPool, destroyCtx, (FnDestroy)DestroyContext);
    return RT_ERROR_NONE;
}

void InitCtxMemPool(void) {
    InitMemPoolWithCSingleList(&g_contextMemPool, sizeof(Context));
    return;
}

void DeInitCtxMemPool(void) {
    DeInitMemPoolWithCSingleList(&g_contextMemPool);
    return;
}
#if defined(__cplusplus)
}
#endif
