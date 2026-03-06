/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_MODEL_H
#define CCE_RUNTIME_RT_INNER_MODEL_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

/**
 * @ingroup rt_model
 * @brief get streams from the model
 * @param [in] mdl: model handle
 * @param [in, out] streams: array to store the retrieved streams
 * @param [in] numStreams: size of streams array
 * @param [out] numStreams: actual number of streams retrieved
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_INSUFFICIENT_INPUT_ARRAY for insufficient tasks array size to hold all streams
 */
RTS_API rtError_t rtModelGetStreams(rtModel_t mdl, rtStream_t *streams, uint32_t *numStreams);

/**
 * @ingroup rt_model
 * @brief register callback func for model destroy
 * @param [in] mdl
 * @param [in] fn
 * @param [in] ptr
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtModelDestroyRegisterCallback(rtModel_t mdl, rtCallback_t fn, void *ptr);

/**
 * @ingroup rt_model
 * @brief unregister callback func for model destroy
 * @param [in] mdl
 * @param [in] fn
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtModelDestroyUnregisterCallback(rtModel_t mdl, rtCallback_t fn);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_MODEL_H
