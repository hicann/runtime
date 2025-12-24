/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CLANG_CCE_RUNTIME_H__
#define __CLANG_CCE_RUNTIME_H__
#if defined(__cplusplus)
extern "C" {
#endif  // __cplusplus

// This interface is provided by runtime, it needs to be kept the same as their.
/**
 * @ingroup dvrt_clang_cce_runtime
 * @brief Config kernel launch parameters
 * @param [in] numBlocks block dimemsions
 * @param [in|out] smDesc  L2 memory usage control information
 * @param [in|out] stream associated stream
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
#ifdef __cplusplus
uint32_t rtConfigureCall(uint32_t numBlocks, void *smDesc = nullptr, void *stream = nullptr);
#else  // __cplusplus
uint32_t rtConfigureCall(uint32_t numBlocks, void *smDesc, void *stream);
#endif

#if defined(__cplusplus)
}
#endif  // __cplusplus

#endif  // __CLANG_CCE_RUNTIME_H__
