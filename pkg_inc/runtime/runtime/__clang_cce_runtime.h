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

#include <stdint.h>

#ifndef RT_DEPRECATED
#if defined(RT_RUNTIME_DISABLE_DEPRECATED_WARNINGS) || \
    (defined(CFG_BUILD_NDEBUG) && !defined(RT_RUNTIME_ENABLE_DEPRECATED_WARNINGS))
    #define RT_DEPRECATED
    #define RT_DEPRECATED_MESSAGE(message)
#elif defined(__GNUC__) && (__GNUC__ >= 6)
    #define RT_DEPRECATED __attribute__((deprecated))
    #define RT_DEPRECATED_MESSAGE(message) __attribute__((deprecated(message)))
#elif defined(_MSC_VER)
    #define RT_DEPRECATED __declspec(deprecated)
    #define RT_DEPRECATED_MESSAGE(message) __declspec(deprecated(message))
#else
    #define RT_DEPRECATED
    #define RT_DEPRECATED_MESSAGE(message)
#endif
#endif

#ifndef RT_RUNTIME_DEPRECATED_MESSAGE
#define RT_RUNTIME_DEPRECATED_MESSAGE "This runtime interface is deprecated and will be removed in a future release"
#endif

#ifndef RT_RUNTIME_DEPRECATED_DECLS_BEGIN
#if defined(__GNUC__) && (__GNUC__ >= 6)
    #define RT_RUNTIME_DEPRECATED_DECLS_BEGIN \
        _Pragma("GCC diagnostic push") \
        _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
    #define RT_RUNTIME_DEPRECATED_DECLS_END _Pragma("GCC diagnostic pop")
#elif defined(_MSC_VER)
    #define RT_RUNTIME_DEPRECATED_DECLS_BEGIN \
        __pragma(warning(push)) \
        __pragma(warning(disable: 4996))
    #define RT_RUNTIME_DEPRECATED_DECLS_END __pragma(warning(pop))
#else
    #define RT_RUNTIME_DEPRECATED_DECLS_BEGIN
    #define RT_RUNTIME_DEPRECATED_DECLS_END
#endif
#endif

#if defined(__cplusplus)
extern "C" {
#endif  // __cplusplus

RT_RUNTIME_DEPRECATED_DECLS_BEGIN

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
RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) uint32_t rtConfigureCall(uint32_t numBlocks, void *smDesc = nullptr, void *stream = nullptr);
#else  // __cplusplus
RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) uint32_t rtConfigureCall(uint32_t numBlocks, void *smDesc, void *stream);
#endif

RT_RUNTIME_DEPRECATED_DECLS_END

#if defined(__cplusplus)
}
#endif  // __cplusplus

#endif  // __CLANG_CCE_RUNTIME_H__
