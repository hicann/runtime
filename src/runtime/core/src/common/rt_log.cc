/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "rt_log.h"
#include "dlog_pub.h"
#if (!defined(WIN32)) && (!defined(CFG_DEV_PLATFORM_PC))
#include "error_manager.h"
#endif
#include "mmpa/mmpa_api.h"
#include "common/error_code_meta.h"
namespace cce {
namespace runtime {
void RecordErrorLog(const char *file, const int32_t line, const char *fun, const char *fmt, ...)
{
    if (file == nullptr || fun == nullptr || fmt == nullptr) {
        return;
    }
    char buf[RT_MAX_LOG_BUF_SIZE] = {0};
#if (!defined(WIN32)) && (!defined(CFG_DEV_PLATFORM_PC))
    std::string err = ErrorManager::GetInstance().GetLogHeader();
#else
    std::string err = " ";
#endif
    va_list arg;
    va_start(arg, fmt);
    int ret = vsnprintf_truncated_s(buf, RT_MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);
    if (ret > 0) {
        DlogRecord(static_cast<int32_t>(RUNTIME), DLOG_ERROR, "[%s:%d]%d %s:%s%s",
            file, line, mmGetTid(), fun, err.c_str(), buf);
    }
    return;
}

void RecordLog(int32_t level, const char *file, const int32_t line, const char *fun, const char *fmt, ...)
{
    if (file == nullptr || fun == nullptr || fmt == nullptr) {
        return;
    }
    // To keep the same performance as the original one, the log level is verified by the caller.
    char buf[RT_MAX_LOG_BUF_SIZE] = {0};
    va_list arg;
    va_start(arg, fmt);
    int ret = vsnprintf_truncated_s(buf, RT_MAX_LOG_BUF_SIZE, fmt, arg);
    va_end(arg);
    if (ret > 0) {
        DlogRecord(static_cast<int32_t>(RUNTIME), level, "[%s:%d] %d %s:%s", file, line, mmGetTid(), fun, buf);
    }
    return;
}

void ReportErrMsg(std::string errorCode, const std::vector<char> &valueString)
{
#if (!defined(WIN32)) && (!defined(CFG_DEV_PLATFORM_PC))
    const std::string valueStr(valueString.data());
    ErrorManager::GetInstance().ATCReportErrMessage((errorCode), std::vector<std::string>({"extend_info"}),
        std::vector<std::string>({valueStr}));
#else
    (void)errorCode;
    (void)valueString;
#endif
}

#define RT_PARAMS_TO_VEC(...) { __VA_ARGS__ }

std::vector<std::string> GetParamNames(ErrorCode code) {
#undef RT_GET_PARAMS
#define RT_GET_PARAMS(code, name, params, msg, level) \
    case ErrorCode::code: return RT_PARAMS_TO_VEC params;
    switch (code) {
        RUNTIME_ERROR_CODE_TABLE(RT_GET_PARAMS)
        default:
            return {};
    }
#undef RT_GET_PARAMS
#undef RT_PARAMS_TO_VEC
}

namespace {
// 辅助宏：为 DispatchErrMsg 生成一个 switch case
#define RT_DISPATCH(n, ...) \
    case n: \
        if (level == DLOG_WARN) { \
            RecordLog(DLOG_WARN, file, line, func, fmt, ##__VA_ARGS__); \
        } else { \
            RecordErrorLog(file, line, func, fmt, ##__VA_ARGS__); \
        } \
        break;

static void DispatchErrMsg(int32_t level, const char* file, int32_t line,
    const char* func, const char* fmt, const std::vector<std::string>& values)
{
    switch (values.size()) {
        case 0:
            if (level == DLOG_WARN) {
                RecordLog(DLOG_WARN, file, line, func, "%s", fmt);
            } else {
                RecordErrorLog(file, line, func, "%s", fmt);
            }
            break;
        RT_DISPATCH(1, values[0].c_str())
        RT_DISPATCH(2, values[0].c_str(), values[1].c_str())
        RT_DISPATCH(3, values[0].c_str(), values[1].c_str(), values[2].c_str())
        RT_DISPATCH(4, values[0].c_str(), values[1].c_str(), values[2].c_str(), values[3].c_str())
        RT_DISPATCH(5, values[0].c_str(), values[1].c_str(), values[2].c_str(), values[3].c_str(), values[4].c_str())
        default:
            break;
    }
}
#undef RT_DISPATCH
}

void PrintErrMsgToLog(ErrorCode errCode, const char *file, const int32_t line, const char *func,
    const std::vector<std::string> &values)
{
    const size_t expectedSize = GetParamNames(errCode).size();
    if (values.size() != expectedSize) {
        RecordLog(DLOG_WARN, file, line, func,
            "Parameter count mismatch for error code %d. Expected %zu, got %zu.\n",
            static_cast<int32_t>(errCode), expectedSize, values.size());
        return;
    }

#undef RT_PRINT_CASE
#define RT_PRINT_CASE(code, name, params, msg, level) \
    case ErrorCode::code: DispatchErrMsg((level), (file), (line), (func), (msg), (values)); break;
    switch (errCode) {
        RUNTIME_ERROR_CODE_TABLE(RT_PRINT_CASE)
        default:
            RecordErrorLog(file, line, func,
                "Unknown error code: %d\n", static_cast<int32_t>(errCode));
            break;
    }
#undef RT_PRINT_CASE
}

void ProcessErrorCodeImpl(ErrorCode errCode, const char *file, const int32_t line, const char *func,
    const std::vector<std::string> &values)
{
    PrintErrMsgToLog(errCode, file, line, func, values);
}
}  // namespace runtime
}  // namespace cce
