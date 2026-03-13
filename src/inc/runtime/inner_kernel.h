/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_INNER_KERNEL_H
#define CCE_RUNTIME_INNER_KERNEL_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum tagRtStackType {
    RT_STACK_TYPE_SCALAR = 0,
    RT_STACK_TYPE_SIMT
} rtStackType_t;

/**
 * @ingroup rt_kernel
 * @brief Get Stack Buffer
 * @param [in] binHandle    bin handle
 * @param [in] deviceId     device id
 * @param [in] stackType    stack type
 * @param [in] coreType     core type
 * @param [in] coreId       core id
 * @param [out] stack       stack buffer
 * @param [out] stackSize   stack size
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetStackBuffer(const rtBinHandle binHandle, uint32_t deviceId, const uint32_t stackType, const uint32_t coreType, 
                                   const uint16_t coreId, const void **stack, uint32_t *stackSize);

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_INNER_KERNEL_H