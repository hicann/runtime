/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_ELF_BASE_H
#define CCE_RUNTIME_ELF_BASE_H

#if defined(__cplusplus)
extern "C" {
#endif

typedef enum {
    RT_BINARY_TYPE_BIN_VERSION = 0U,
    RT_BINARY_TYPE_DEBUG_INFO = 1U,
    RT_BINARY_TYPE_DYNAMIC_PARAM = 2U,
    RT_BINARY_TYPE_OPTIONAL_PARAM = 3U,
    RT_BINARY_TYPE_RUNTIME_IMPLICIT_INFO = 4U,
} rtBinaryMetaType;

typedef enum {
    RT_FUNCTION_TYPE_INVALID = 0U,
    RT_FUNCTION_TYPE_KERNEL_TYPE = 1U,
    RT_FUNCTION_TYPE_CROSS_CORE = 2U,
    RT_FUNCTION_TYPE_MIX_TASK_RATION = 3U,
    RT_FUNCTION_TYPE_DFX_TYPE = 4U,
    RT_FUNCTION_TYPE_DFX_ARG_INFO = 5U,
    RT_FUNCTION_TYPE_L0_EXCEPTION_DFX_IS_TIK = 6U,
    RT_FUNCTION_TYPE_COMPILER_ALLOC_UB_SIZE = 7U,
    RT_FUNCTION_TYPE_SU_STACK_SIZE = 8U,
    RT_FUNCTION_TYPE_SIMT_WARP_STACK_SIZE = 9U,
    RT_FUNCTION_TYPE_SIMT_DVG_WARP_STACK_SIZE = 10U,
    RT_FUNCTION_TYPE_EARLY_START_ENABLE = 11U,
    RT_FUNCTION_TYPE_AIV_TYPE_FLAG = 12U,
    RT_FUNCTION_TYPE_DETERMINISTIC_INFO = 13U,
    RT_FUNCTION_TYPE_FUNCTION_ENTRY_INFO = 14U,
    RT_FUNCTION_TYPE_BLOCK_DIM_INFO = 15U,
    RT_FUNCTION_TYPE_PARAM_SUMMARY = 16U,
    RT_FUNCTION_TYPE_PARAM_INFO = 17U,
} rtFunctionMetaType;

#if defined(__cplusplus)
}
#endif

#endif  // CCE_RUNTIME_ELF_BASE_H