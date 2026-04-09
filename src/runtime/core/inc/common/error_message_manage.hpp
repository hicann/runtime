/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef RT_ERROR_MESSAGE_MANAGE_HPP
#define RT_ERROR_MESSAGE_MANAGE_HPP
#include <string>
#include <vector>
#include <memory>
#include "base.hpp"
#include "device.hpp"
#include "errcode_manage.hpp"

// Do NOT use this Marco directly
#define COND_RETURN_MSG_(TYPE, COND, ERRCODE, LOGTYPE, format, ...) \
    if (unlikely(COND)) {                         \
        RT_LOG_##TYPE##_MSG(LOGTYPE, format, ##__VA_ARGS__);           \
        return ERRCODE;                           \
    }
// Do NOT use this Marco directly
#define COND_PROC_RETURN_MSG_(TYPE, COND, ERRCODE, PROC, LOGTYPE, format, ...) \
    if (unlikely(COND)) {                                    \
        PROC;                                                \
        RT_LOG_##TYPE##_MSG(LOGTYPE, format, ##__VA_ARGS__);         \
        return ERRCODE;                                      \
    }

// Do NOT use this Marco directly
#define COND_GOTO_ERROR_MSG_AND_ASSIGN_(TYPE, COND, LABEL, ERROR, ERRCODE, format, ...) \
    if (unlikely(COND)) {                                                   \
        RT_LOG_##TYPE##_MSG(RT_LOG_ERROR, format, ##__VA_ARGS__);                       \
        (ERROR) = static_cast<rtError_t>(ERRCODE);                                      \
        goto LABEL;                                                        \
    }

// Do NOT use this Marco directly
#define NULL_PTR_GOTO_MSG_(TYPE, PTR, LABEL, ERROR, ERRCODE) \
    COND_GOTO_ERROR_MSG_AND_ASSIGN_(TYPE, (PTR) == nullptr, LABEL, ERROR, ERRCODE, \
        "Check param failed, " #PTR " can not be NULL!")

// Do NOT use this Marco directly
#define COND_RETURN_ERROR_MSG_(TYPE, COND, ERRCODE, format, ...) \
    COND_RETURN_MSG_(TYPE, (COND), ERRCODE, RT_LOG_ERROR, format, ##__VA_ARGS__)

// Do NOT use this Marco directly
#define COND_RETURN_CALL_MSG_(TYPE, COND, ERRCODE, format, ...) \
    COND_RETURN_MSG_(TYPE, (COND), ERRCODE, ERR_MODULE_GE, format, ##__VA_ARGS__)

// Do NOT use this Marco directly
#define ERROR_RETURN_MSG_(TYPE, ERRCODE, format, ...) \
    COND_RETURN_ERROR_MSG_(TYPE, (ERRCODE) != RT_ERROR_NONE, ERRCODE, format, ##__VA_ARGS__)

// Do NOT use this Marco directly
#define COND_PROC_GOTO_MSG_(TYPE, COND, LABEL, PROC, format, ...) \
    if (unlikely(COND)) {                                                  \
        PROC; \
        RT_LOG_##TYPE##_MSG(RT_LOG_ERROR, format, ##__VA_ARGS__);                  \
        goto LABEL;                                                        \
    }
// Do NOT use this Marco directly
#define ERROR_PROC_GOTO_MSG_(TYPE, ERRCODE, LABEL, PROC, format, ...) \
    COND_PROC_GOTO_MSG_(TYPE, (ERRCODE) != RT_ERROR_NONE, LABEL, PROC, format, ##__VA_ARGS__)
// Do NOT use this Marco directly
#define ERROR_GOTO_MSG_(TYPE, ERRCODE, LABEL, format, ...)     \
    ERROR_PROC_GOTO_MSG_(TYPE, ERRCODE, LABEL, , format, ##__VA_ARGS__)

// Do NOT use this Marco directly
#define COND_PROC_RETURN_ERROR_MSG_(TYPE, COND, ERRCODE, PROC, format, ...) \
    COND_PROC_RETURN_MSG_(TYPE, (COND), ERRCODE, PROC, RT_LOG_ERROR, format, ##__VA_ARGS__)

// Do NOT use this Marco directly
#define NULL_PTR_PROC_RETURN_ERROR_MSG_(TYPE, PTR, ERR, LOGTYPE, PROC) \
    if (unlikely((PTR) == nullptr)) { \
        PROC \
        RT_LOG_##TYPE##_MSG(LOGTYPE, "Check param failed, " #PTR " can not be null.");     \
        return ERR; }

#define NULL_PTR_PROC_RETURN_ERROR_MSG_INNER(PTR, ERR, PROC) \
    NULL_PTR_PROC_RETURN_ERROR_MSG_(INNER, PTR, ERR, RT_LOG_ERROR, (PROC))

#define COND_PROC_RETURN_ERROR_MSG_INNER(COND, ERRCODE, PROC, format, ...) \
    COND_PROC_RETURN_ERROR_MSG_(INNER, COND, ERRCODE, PROC, format, ##__VA_ARGS__)

#define ERROR_PROC_RETURN_MSG_INNER(ERRCODE, PROC, format, ...) \
    COND_PROC_RETURN_ERROR_MSG_(INNER, (ERRCODE != RT_ERROR_NONE), ERRCODE, PROC, format, ##__VA_ARGS__)

#define ERROR_GOTO_MSG_INNER(ERRCODE, LABEL, format, ...)     \
    ERROR_GOTO_MSG_(INNER, ERRCODE, LABEL, format, ##__VA_ARGS__)

#define ERROR_PROC_GOTO_MSG_INNER(ERRCODE, LABEL, PROC, format, ...) \
    ERROR_PROC_GOTO_MSG_(INNER, ERRCODE, LABEL, PROC, format, ##__VA_ARGS__)

#define COND_PROC_GOTO_MSG_INNER(COND, LABEL, PROC, format, ...) \
    COND_PROC_GOTO_MSG_(INNER, COND, LABEL, PROC, format, ##__VA_ARGS__)

#define COND_RETURN_ERROR_MSG_INNER(COND, ERRCODE, format, ...) \
    COND_RETURN_ERROR_MSG_(INNER, COND, ERRCODE, format, ##__VA_ARGS__)

#define COND_GOTO_ERROR_MSG_AND_ASSIGN_INNER(COND, LABEL, ERROR, ERRCODE, format, ...) \
    COND_GOTO_ERROR_MSG_AND_ASSIGN_(INNER, COND, LABEL, ERROR, ERRCODE, format, ##__VA_ARGS__)

#define NULL_PTR_GOTO_MSG_INNER(PTR, LABEL, ERROR, ERRCODE) \
    NULL_PTR_GOTO_MSG_(INNER, PTR, LABEL, ERROR, ERRCODE) \

#define ERROR_RETURN_MSG_INNER(ERRCODE, format, ...) \
    ERROR_RETURN_MSG_(INNER, ERRCODE, format, ##__VA_ARGS__) \

#define NULL_PTR_RETURN_MSG(PARAM, ERROR_CODE)                        \
    NULL_PTR_PROC_RETURN_ERROR_MSG_(INNER, PARAM, ERROR_CODE, RT_LOG_ERROR,) \

#define NULL_PTR_RETURN_MSG_OUTER(PTR, RET_CODE)                        \
    if (unlikely((PTR) == nullptr)) { \
        RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1004, #PTR); \
        return RET_CODE; \
    }

#define ZERO_RETURN_MSG(PARAM)            \
    COND_RETURN_CALL_MSG_(CALL, (PARAM) == 0U, \
        RT_ERROR_INVALID_VALUE, "Check param failed, " #PARAM " can not be 0.");

// 整改代码上线之后，此宏删除
#define ZERO_RETURN_MSG_OUTER(PARAM)            \
    COND_RETURN_MSG_(OUTER, (PARAM) == 0U, \
    RT_ERROR_INVALID_VALUE, RT_INVALID_ARGUMENT_ERROR, \
    "Check param failed, " #PARAM " can not be 0.")

#define ZERO_RETURN_AND_MSG_OUTER(PARAM)            \
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM((PARAM) == 0U, \
        RT_ERROR_INVALID_VALUE, PARAM, "not equal to 0")

//EE1003错误码专用，可变参数内容为：期望值
#define COND_RETURN_AND_MSG_OUTER_WITH_PARAM(COND, RTERRCODE, param, ...) \
    if (unlikely(COND)) { \
        RT_LOG_OUTER_MSG_INVALID_PARAM(param, ##__VA_ARGS__); \
        return RTERRCODE; \
    }

//除EE1003、EE1001之外的其他外部错误码使用
#define COND_RETURN_AND_MSG_OUTER(COND, RTERRCODE, ERRCODE, ...) \
    if (unlikely(COND)) { \
        RT_LOG_OUTER_MSG_IMPL(ERRCODE, ##__VA_ARGS__); \
        return RTERRCODE; \
    }

//EE9999 错误码使用
#define COND_RETURN_AND_MSG_INNER(COND, RTERRCODE, format, ...) \
    if (unlikely(COND)) { \
        RT_LOG_INNER_MSG(RT_LOG_ERROR, format, ##__VA_ARGS__); \
        return RTERRCODE; \
    }

#define NULL_PTR_PROC_RETURN_ERROR_MSG_CALL(MODULE_TYPE, PTR, ERR, PROC) \
    if (unlikely((PTR) == nullptr)) { \
        PROC \
        RT_LOG_CALL_MSG(MODULE_TYPE, "Check param failed, " #PTR " can not be null.");     \
        return ERR; }

#define COND_PROC_RETURN_ERROR_MSG_CALL(MODULE_TYPE, COND, ERRCODE, PROC, format, ...) \
    if (unlikely(COND)) {                                    \
        PROC;                                                \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);         \
        return ERRCODE;                                      \
    }

#define ERROR_GOTO_MSG_CALL(MODULE_TYPE, ERRCODE, LABEL, format, ...) \
    if (unlikely((ERRCODE) != RT_ERROR_NONE)) {                                                  \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);                  \
        goto LABEL;                                                        \
    }

#define ERROR_PROC_GOTO_MSG_CALL(MODULE_TYPE, ERRCODE, LABEL, PROC, format, ...) \
    if (unlikely((ERRCODE) != RT_ERROR_NONE)) {                                                  \
        PROC; \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);                  \
        goto LABEL;                                                        \
    }

#define COND_PROC_GOTO_MSG_CALL(MODULE_TYPE, COND, LABEL, PROC, format, ...) \
    if (unlikely(COND)) {                                                  \
        PROC; \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);                  \
        goto LABEL;                                                        \
    }

#define COND_RETURN_ERROR_MSG_CALL(MODULE_TYPE, COND, ERRCODE, format, ...) \
    if (unlikely(COND)) {                         \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);           \
        return ERRCODE;                           \
    }

// EE1001 错误码专用
#define COND_RETURN_OUT_ERROR_MSG_CALL(COND, ERRCODE, format, ...) \
    if (COND) {                         \
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, format, ##__VA_ARGS__);           \
        return ERRCODE;                           \
    }

#define COND_PROC_RETURN_OUT_ERROR_MSG_CALL(COND, ERRCODE, PROC, format, ...) \
    if (COND) {                         \
        PROC; \
        RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, format, ##__VA_ARGS__);           \
        return ERRCODE;                           \
    }

#define COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(MODULE_TYPE, COND, LABEL, ERROR, ERRCODE, format, ...) \
    if (unlikely(COND)) {                                                  \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);                                    \
        (ERROR) = (ERRCODE);                                                 \
        goto LABEL;                                                        \
    }

#define NULL_PTR_GOTO_MSG_CALL(MODULE_TYPE, PTR, LABEL, ERROR, ERRCODE) \
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL((MODULE_TYPE), (PTR) == nullptr, (LABEL), (ERROR), (ERRCODE), \
        "Check param failed, " #PTR " can not be NULL!")

#define ERROR_RETURN_MSG_CALL(MODULE_TYPE, ERRCODE, format, ...) \
    if (unlikely((ERRCODE) != RT_ERROR_NONE)) {                         \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);           \
        return ERRCODE;                           \
    }

#define ERROR_PROC_RETURN_MSG_CALL(MODULE_TYPE, ERRCODE, PROC, format, ...) \
    if (unlikely((ERRCODE) != RT_ERROR_NONE)) {                                    \
        PROC;                                                \
        RT_LOG_CALL_MSG(MODULE_TYPE, format, ##__VA_ARGS__);         \
        return ERRCODE;                                      \
    }

// define for detail msg
#define RT_LOG_INNER_DETAIL_MSG   (ErrorMessageUtils::RuntimeErrorMessage)

#define NULL_STREAM_PTR_RETURN_MSG(STREAM)     NULL_PTR_RETURN_MSG((STREAM), RT_ERROR_STREAM_NULL)

namespace cce {
namespace runtime {
// error code for report purpose.
// 1000~1999 for xxx error
enum TagRtErrMsgCode {
    // Runtime input error
    RT_SOC_VERSION_NOT_SUPPORT = 1000,
    // environment error
    RT_DEVICE_RUNNING_DOWN = 2000,
    RT_MEMORY_ALLOC_FAILED = 2001,
    // driver error
    RT_DRV_ERROR_SOCKET_LOST = 3001,
    // Ts input error
    RT_REPEAT_MODEL_STREAM_BIND = 4001,
    RT_MODEL_STREAM_UNBIND_FAILED = 4002,
    RT_ONLINE_PROFILING_NO_START = 4003,
    RT_PROFILING_ENABLE_FAILED = 4004,
    // Ts environment error
    RT_HWTS_SQ_SPACE_NOT_ENOUGH = 5001,
    RT_TS_MEMORY_ALLOC_FAILED = 5002,
    // other error
    RTS_INNER_ERROR = 9999,
    RT_RESERVED = 0xFFFF
};

class ErrorMessageUtils {
public:
    static void FuncErrorReason(const RtInnerErrcodeType rtErrCode, const char_t * const funcName);
    static void RuntimeErrorMessage(const int32_t errCode,
                                    const std::vector<std::string> &errMsgKey,
                                    const std::vector<std::string> &errMsgValue);
    static void RuntimeErrorMessage(const std::string &errCode,
                                    const std::vector<std::string> &errMsgKey,
                                    const std::vector<std::string> &errMsgValue);
    static std::string GetViewErrorCodeStr(const int32_t errCode)
    {
        return "EE" + std::to_string(errCode);
    }
    ErrorMessageUtils() = delete;
    ~ErrorMessageUtils() = delete;
};
}
}
#endif