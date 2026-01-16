/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_API_C_H__
#define __CCE_RUNTIME_API_C_H__

#include "error_code.h"
#include "api_global_err.h"

#define REPORT_FUNC_ERROR_REASON(ERRCODE) \
    do { \
        const std::string errorStr = RT_GET_ERRDESC(ERRCODE); \
        RT_LOG(RT_LOG_ERROR, "%s", errorStr.c_str()); \
        constexpr const char_t * const functionName = __func__; \
        ErrorMessageUtils::FuncErrorReason((ERRCODE), functionName); \
        RT_LOG_FLUSH(); \
    } while (false)

#define ERROR_RETURN_WITH_EXT_ERRCODE(ERRCODE) \
    do { \
        if (unlikely((ERRCODE) != RT_ERROR_NONE)) { \
            REPORT_FUNC_ERROR_REASON(ERRCODE); \
            return GetRtExtErrCodeAndSetGlobalErr((ERRCODE)); \
        } \
    } while (false)

#define COND_RETURN_WITH_EXT_ERRCODE(COND, ERRCODE, format, ...) \
    do { \
        if (unlikely(COND)) { \
            if ((ERRCODE) == RT_ERROR_INVALID_VALUE){ \
                RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, format, ##__VA_ARGS__); \
            } else { \
                RT_LOG_INNER_MSG(RT_LOG_ERROR, format, ##__VA_ARGS__); \
            } \
            const std::string errorStr = RT_GET_ERRDESC(ERRCODE); \
            RT_LOG(RT_LOG_ERROR, "%s", errorStr.c_str()); \
            RT_LOG_FLUSH(); \
            return GetRtExtErrCodeAndSetGlobalErr((ERRCODE)); \
        } \
    } while (false)

// 整改代码上线之后删除此宏
#define COND_RETURN_ERROR_WITH_EXT_ERRCODE(COND, ERRCODE, format, ...) \
    COND_RETURN_WITH_EXT_ERRCODE((COND), (ERRCODE), format, ##__VA_ARGS__)

// EE1003使用，可变参数内容为参数期望值
#define COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER_WITH_PARAM(COND, RTERRCODE, param, ...) \
    do {                                                                              \
        if (unlikely(COND)) {                                                         \
            RT_LOG_OUTER_MSG_INVALID_PARAM(param, ##__VA_ARGS__);                     \
            const std::string& errorStr = RT_GET_ERRDESC(RTERRCODE);                  \
            RT_LOG(RT_LOG_ERROR, "%s", errorStr.c_str());                             \
            RT_LOG_FLUSH();                                                           \
            return GetRtExtErrCodeAndSetGlobalErr((RTERRCODE));                       \
        }                                                                             \
    } while (false)

// 除EE1003之外的其他外部错误码使用
#define COND_RETURN_EXT_ERRCODE_AND_MSG_OUTER(COND, RTERRCODE, ERRCODE, ...) \
    do {                                                                     \
        if (unlikely(COND)) {                                                \
            RT_LOG_OUTER_MSG_IMPL(ERRCODE, ##__VA_ARGS__);                   \
            const std::string& errorStr = RT_GET_ERRDESC(RTERRCODE);         \
            RT_LOG(RT_LOG_ERROR, "%s", errorStr.c_str());                    \
            RT_LOG_FLUSH();                                                  \
            return GetRtExtErrCodeAndSetGlobalErr((RTERRCODE));              \
        }                                                                    \
    } while (false)

// EE9999 使用
#define COND_RETURN_EXT_ERRCODE_AND_MSG_INNER(COND, RTERRCODE, format, ...) \
    do {                                                                    \
        if (unlikely(COND)) {                                               \
            RT_LOG_INNER_MSG(RT_LOG_ERROR, format, ##__VA_ARGS__);          \
            const std::string errorStr = RT_GET_ERRDESC(RTERRCODE);         \
            RT_LOG(RT_LOG_ERROR, "%s", errorStr.c_str());                   \
            RT_LOG_FLUSH();                                                 \
            return GetRtExtErrCodeAndSetGlobalErr((RTERRCODE));             \
        }                                                                   \
    } while (false)

#define NULL_RETURN_ERROR_WITH_EXT_ERRCODE(PTR)                                                     \
    do {                                                                                            \
        if (unlikely((PTR) == nullptr)) {                                                           \
            RT_LOG(RT_LOG_ERROR, "Null " #PTR " pointer, ErrCode=%d", ACL_ERROR_RT_INTERNAL_ERROR); \
            RT_LOG_FLUSH();                                                                         \
            return ACL_ERROR_RT_INTERNAL_ERROR;                                                     \
        }                                                                                           \
    } while (false)

#define NULL_RETURN_WARNING_WITH_EXT_ERRCODE(PTR, ERRCODE) \
    do { \
        if (unlikely((PTR) == nullptr)) { \
            if (((ERRCODE) == RT_ERROR_API_NULL) || ((ERRCODE) == RT_ERROR_INSTANCE_NULL)) { \
                RT_LOG(RT_LOG_WARNING, "Null " #PTR " pointer, ErrCode=%d", ACL_ERROR_RT_INTERNAL_ERROR); \
                RT_LOG_FLUSH(); \
                return ACL_ERROR_RT_INTERNAL_ERROR; \
            } \
        } \
    } while (false)

#define PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(PTR, RET_CODE) \
    do { \
        if (unlikely((PTR) == nullptr)) { \
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1004, #PTR); \
            RT_LOG_FLUSH(); \
            return GetRtExtErrCodeAndSetGlobalErr((RET_CODE)); \
        } \
    } while (false)

#endif // __CCE_RUNTIME_API_C_H__