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
#include "context.h"

#if defined(__cplusplus)
extern "C" {
#endif
__thread  Context *g_curCtx = NULL;
__thread  uint32_t g_curCtxSeq = 0;
void InitCtxRecord(void)
{
    return;
}

void DeinitCtxRecord(void)
{
    return;
}

rtError_t SetupContext(Context* context)
{
    g_curCtx = context;
    g_curCtxSeq = GetMemPoolMemSeq(context);
    return RT_ERROR_NONE;
}

rtError_t TearDownContext(Context* context)
{
    if (g_curCtx == context) {
        g_curCtx = NULL;
        g_curCtxSeq = 0;
    }

    mmMutexLock(&context->streamLock);
    DeInitVector(&context->streamVec);
    mmMutexUnLock(&context->streamLock);
    return RT_ERROR_NONE;
}

rtError_t rtCtxGetCurrent(rtContext_t *currentCtx)
{
    if (currentCtx == NULL) {
        RT_LOG_ERROR("context is NULL!");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    if (g_curCtx == NULL || (!MemPoolMemMatchSeq(g_curCtx, g_curCtxSeq))) {
        RT_LOG_WARNING("current context is NULL!");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    *currentCtx = g_curCtx;
    return RT_ERROR_NONE;
}

rtError_t rtCtxSetCurrent(rtContext_t currentCtx)
{
    if ((currentCtx != NULL) && !MemPoolMemUsed(currentCtx)) {
        RT_LOG_ERROR("context is invalid!");
        return ACL_ERROR_RT_CONTEXT_NULL;
    }
    g_curCtx = currentCtx;
    g_curCtxSeq = currentCtx == NULL ? 0 : GetMemPoolMemSeq(currentCtx);
    return RT_ERROR_NONE;
}

#if defined(__cplusplus)
}
#endif
