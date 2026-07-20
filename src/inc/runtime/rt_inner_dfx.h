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

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_DFX_H
