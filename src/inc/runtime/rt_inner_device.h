/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_DEVICE_H
#define CCE_RUNTIME_RT_INNER_DEVICE_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum rtAtomicOperationCapability {
    RT_ATOMIC_CAPABILITY_SIGNED = 1U << 0U,
    RT_ATOMIC_CAPABILITY_UNSIGNED = 1U << 1U,
    RT_ATOMIC_CAPABILITY_REDUCATION = 1U << 2U,
    RT_ATOMIC_CAPABILITY_SCALAR8 = 1U << 3U,
    RT_ATOMIC_CAPABILITY_SCALAR16 = 1U << 4U,
    RT_ATOMIC_CAPABILITY_SCALAR32 = 1U << 5U,
    RT_ATOMIC_CAPABILITY_SCALAR64 = 1U << 6U,
    RT_ATOMIC_CAPABILITY_SCALAR128 = 1U << 7U,
    RT_ATOMIC_CAPABILITY_VECTOR32X4 = 1U << 8U,
} rtAtomicOperationCapability;

typedef enum rtAtomicOperation {
    RT_ATOMIC_OPERATION_INTEGER_ADD = 0,
    RT_ATOMIC_OPERATION_INTEGER_MIN = 1,
    RT_ATOMIC_OPERATION_INTEGER_MAX = 2,
    RT_ATOMIC_OPERATION_INTEGER_INCREMENT = 3,
    RT_ATOMIC_OPERATION_INTEGER_DECREMENT = 4,
    RT_ATOMIC_OPERATION_AND = 5,
    RT_ATOMIC_OPERATION_OR = 6,
    RT_ATOMIC_OPERATION_XOR = 7,
    RT_ATOMIC_OPERATION_EXCHANGE = 8,
    RT_ATOMIC_OPERATION_CAS = 9,
    RT_ATOMIC_OPERATION_FLOAT_ADD = 10,
    RT_ATOMIC_OPERATION_FLOAT_MIN = 11,
    RT_ATOMIC_OPERATION_FLOAT_MAX = 12,

    RT_ATOMIC_OPERATION_DMA_ADD = 30,
    RT_ATOMIC_OPERATION_DMA_MIN = 31,
    RT_ATOMIC_OPERATION_DMA_MAX = 32,

    RT_ATOMIC_OPERATION_SIMD_SCALAR_ADD = 40,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_MIN = 41,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_MAX = 42,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_CAS = 43,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_EXCH = 44,
} rtAtomicOperation;

/**
 * @ingroup dvrt_dev
 * @brief get h2d atomic capabilities by device id
 * @param [out] capabilities   atomic capabilities
 * @param [in] operations   atomic operations
 * @param [in] count   atomic operations count
 * @param [in] deviceId   device id
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDeviceGetHostAtomicCapabilities(
    uint32_t* capabilities, const rtAtomicOperation* operations, const uint32_t count, int32_t deviceId);

/**
 * @ingroup dvrt_dev
 * @brief get p2p atomic capabilities by device id
 * @param [out] capabilities   atomic capabilities
 * @param [in] operations   atomic operations
 * @param [in] count   atomic operations count
 * @param [in] srcDeviceId   source device id
 * @param [in] dstDeviceId   destination device id
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDeviceGetP2PAtomicCapabilities(
    uint32_t* capabilities, const rtAtomicOperation* operations, const uint32_t count, int32_t srcDeviceId,
    int32_t dstDeviceId);

/**
 * @ingroup dvrt_dev
 * @brief get device resource limit value
 * @param [in] type   limit type
 * @param [out] val   limit value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceGetLimit(rtLimitType_t type, uint32_t *val);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_DEVICE_H