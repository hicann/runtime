/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RTS_CONTEXT_H
#define CCE_RUNTIME_RTS_CONTEXT_H

#include <stdlib.h>

#include "base.h"
#include "runtime/context.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup rts_context
 * @brief create context and associates it with the calling thread
 * @param [out] createCtx   created context
 * @param [in] flags   context creation flag. set to 0.
 * @param [in] devId    device to create context on
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsCtxCreate(rtContext_t *createCtx, uint64_t flags, int32_t devId);

/**
 * @ingroup rts_context
 * @brief destroy context instance
 * @param [in] destroyCtx   context to destroy
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsCtxDestroy(rtContext_t destroyCtx);

/**
 * @ingroup rts_context
 * @brief binds context to the calling CPU thread.
 * @param [in] currentCtx   context to bind.
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsCtxSetCurrent(rtContext_t currentCtx);

/**
 * @ingroup rts_context
 * @brief returns the context bound to the calling CPU thread.
 * @param [out] currentCtx   returned context
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtsCtxGetCurrent(rtContext_t *currentCtx);

/**
 * @ingroup rts_context
 * @brief set current context system param option
 * @param [in] configOpt system option to be set
 * @param [in] configVal system option's value to be set
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsCtxSetSysParamOpt(rtSysParamOpt configOpt, int64_t configVal);

/**
 * @ingroup rts_context
 * @brief get current context system param option's value
 * @param [in] configOpt system option to be get value
 * @param [out] configVal system option's value to be get
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsCtxGetSysParamOpt(rtSysParamOpt configOpt, int64_t *configVal);

/**
 * @ingroup rts_context
 * @brief get current default stream
 * @param [out] stm: default stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtsCtxGetCurrentDefaultStream(rtStream_t *stm);

/**
 * @ingroup rt_context
 * @brief get primary ctx state
 * @param [out] active:pointer to store context state, 0=inactive, 1=active
 * @param [out] flags: Pointer to store flags
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsGetPrimaryCtxState(const int32_t devId, uint32_t *flags, int32_t *active);

/**
 * @ingroup rts_context
 * @brief get context overflowAddr
 * @param [out] overflowAddr current ctx's overflowAddr to be get
 * @return RT_ERROR_NONE for ok, errno for failed
 */
RTS_API rtError_t rtsCtxGetFloatOverflowAddr(void **overflowAddr);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_RTS_CONTEXT_H