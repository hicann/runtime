/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_BASE_DAVID_HPP__
#define __CCE_RUNTIME_BASE_DAVID_HPP__

#include <cinttypes>

#define RT_DAVID_SCALAR_BUFFER_SIZE_32K \
    (32U * 1024U * (RT_DAVID_AICORE_NUM + RT_DAVID_AIVECTOR_NUM))

#define RT_MAX_THREAD_NUM_PER_WARP (32U)
#define RT_MAX_WARP_NUM_PER_VECTOR_CORE (64U)
#define RT_MAX_THREAD_PER_VECTOR_CORE (RT_MAX_THREAD_NUM_PER_WARP * RT_MAX_WARP_NUM_PER_VECTOR_CORE)
#define RT_SIMT_DEFAULT_STACK_SIZE_THREAD (256U)
#define RT_KIS_SIMT_WARP_STK_SIZE (RT_MAX_THREAD_NUM_PER_WARP * RT_SIMT_DEFAULT_STACK_SIZE_THREAD) // 0x2000B
#define RT_KIS_SIMT_DVG_WARP_STK_SIZE (1024U)            // 1024B
#define RT_SIMT_UB_SIZE (256U * 1024U)                  // UBSize 256K
#define RT_SIMT_DCACHE_MIN_SIZE (32U * 1024U)           // SIMTDCacheMinSize 32K
#define RT_SIMT_REMAIN_UB_SIZE (RT_SIMT_UB_SIZE - RT_SIMT_DCACHE_MIN_SIZE)
#define RT_SIMT_COMPILER_AUX_SIZE (8U * 1024U)          // BiSheng aux scalar stack + ASC: 8K
#define RT_SIMT_AVAILBALE_UB_SIZE (RT_SIMT_UB_SIZE - RT_SIMT_DCACHE_MIN_SIZE - RT_SIMT_COMPILER_AUX_SIZE)

namespace cce {
namespace runtime {

constexpr uint32_t STACK_PHY_BASE_ALIGN_LEN = 128U;
constexpr uint32_t STACK_PHY_BASE_ALIGN_BIT = 7U;

constexpr uint32_t RT_DAVID_AICORE_NUM = 36U;
constexpr uint32_t RT_DAVID_AIVECTOR_NUM = 72U;
}
}

#endif // __CCE_RUNTIME_BASE_DAVID_HPP__
