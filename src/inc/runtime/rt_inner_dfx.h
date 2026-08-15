/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_DFX_H
#define CCE_RUNTIME_RT_INNER_DFX_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

enum rtKernelDfxInfoType {
    RT_KERNEL_DFX_INFO_DEFAULT = 0U,
    RT_KERNEL_DFX_INFO_PRINTF = 1U,
    RT_KERNEL_DFX_INFO_TENSOR = 2U,
    RT_KERNEL_DFX_INFO_ASSERT = 3U,
    RT_KERNEL_DFX_INFO_TIME_STAMP = 4U,
    RT_KERNEL_DFX_INFO_BLOCK_INFO = 5U,
    RT_KERNEL_DFX_INFO_INVALID = 0x7FFFFFFFU,
};

using rtKernelDfxInfoProFunc =
    void (*)(rtKernelDfxInfoType type, uint32_t coreType, uint32_t coreId, const uint8_t* buffer, size_t length);

/**
 * @brief register dump function
 * @param [in] type     data dump type
 * @param [in] func     dump func
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 * @return RT_ERROR_INSTANCE_NULL for error instance
 */
RTS_API rtError_t rtSetKernelDfxInfoCallback(rtKernelDfxInfoType type, rtKernelDfxInfoProFunc func);

/**
 * @brief rtDfxParseParam struct
 * @param data      Pointer to Host-side block snapshot (includes BlockInfo + ReadInfo + data area +
 * WriteInfo)
 * @param datalen   Total block length in bytes (blockSize)
 * @param readIdx   Ring buffer read position
 * @param writeIdx  Ring buffer write position
 * @param coreType  Core type: 0=AIC, 1=AIV, 2=SIMT
 * @param coreId    Core ID
 * @param deviceId  User device ID (converted from driver device ID via GetUserDevIdByDeviceId)
 */
typedef struct rtDfxParseParam {
    void* data;
    uint64_t datalen;
    uint64_t readIdx;
    uint64_t writeIdx;
    uint32_t coreType;
    uint32_t coreId;
    uint32_t deviceId;
} rtDfxParseParam;

/**
 * @brief Callback function invoked by runtime to deliver AI core dump block data
 * @param [in] param       Pointer to rtDfxParseParam containing block data and ring buffer info
 * @param [out] consumedLen Bytes consumed by callback.
 *             SIMD: consumedLen is treated as a flag (0=not processed, non-zero=processed).
 *                   readIdx is advanced to writeIdx regardless of the actual value.
 *             SIMT: consumedLen is the actual number of bytes consumed.
 *                   readIdx is advanced by consumedLen (clamped to availableData).
 *             Set to 0 if no data consumed (data retained for next round).
 * @note This callback is invoked synchronously in the PRINTF thread.
 *       The data pointer remains valid during callback invocation.
 *       The callback must not block or perform long-running operations.
 */
using rtParseDfxInfoFunc = void (*)(const rtDfxParseParam* param, uint64_t* consumedLen);

/**
 * @brief Register callback function for AI core dump block data delivery
 * @param [in] func  Callback function pointer. Pass nullptr to clear existing callback.
 *                   Duplicate registration is allowed (overwrites existing callback).
 * @return RT_ERROR_NONE on success
 */
RTS_API rtError_t rtRegisterParseDfxInfoFunc(rtParseDfxInfoFunc func);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_DFX_H
