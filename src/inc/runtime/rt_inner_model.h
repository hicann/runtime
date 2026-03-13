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
 * @brief register callback func for model destroy
 * @param [in] mdl
 * @param [in] fn
 * @param [in] ptr
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtModelDestroyRegisterCallback(rtModel_t const mdl, rtCallback_t fn, void *ptr);

/**
 * @ingroup rt_model
 * @brief unregister callback func for model destroy
 * @param [in] mdl
 * @param [in] fn
 * @return ACL_RT_SUCCESS for ok
 * @return ACL_ERROR_RT_PARAM_INVALID for error input
 */
RTS_API rtError_t rtModelDestroyUnregisterCallback(rtModel_t const mdl, rtCallback_t fn);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_MODEL_H
