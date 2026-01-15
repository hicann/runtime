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
#include "securec.h"
#if (!defined(CFG_DEV_PLATFORM_PC))
#include "error_manager.h"
#endif
#include "mmpa/mmpa_api.h"
namespace cce {
namespace runtime {
void RecordErrorLog(const char *file, const int32_t line, const char *fun, const char *fmt, ...)
{
    if (file == nullptr || fun == nullptr || fmt == nullptr) {
        return;
    }
    char buf[RT_MAX_LOG_BUF_SIZE] = {0};
#if (!defined(CFG_DEV_PLATFORM_PC))
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
#if (!defined(CFG_DEV_PLATFORM_PC))
    const std::string valueStr(valueString.data());
    ErrorManager::GetInstance().ATCReportErrMessage((errorCode), std::vector<std::string>({"extend_info"}),
        std::vector<std::string>({valueStr}));
#else
    (void)errorCode;
    (void)valueString;
#endif
}

std::vector<std::string> GetParamNames(ErrorCode code) {
    switch (code) {
        case ErrorCode::EE1001: 
            return {"extend_info"};
        case ErrorCode::EE1002: 
            return {"extend_info"};
        case ErrorCode::EE1003:
            return {"func", "value", "param", "expect"};
        case ErrorCode::EE1004:
            return {"func", "param"};
        case ErrorCode::EE1005:
            return {"func"};
        case ErrorCode::EE1006:
            return {"func", "type"};
        case ErrorCode::EE1007:
            return {"id", "reason"};
        case ErrorCode::EE1008:
            return {"reason"};
        case ErrorCode::EE1009:
            return {"id", "reason"};
        case ErrorCode::EE1010:
            return {"func", "object"};
        case ErrorCode::EE1011: 
            return {"func", "value", "param", "reason"};
        case ErrorCode::EE2002:
            return {"value", "env", "expect"};
        default:
            return {};
    }
}

void PrintErrMsgToLog(ErrorCode errCode, const char *file, const int32_t line, const char *func,
    const std::vector<std::string> &values)
{
    const size_t expectedSize = GetParamNames(errCode).size();
    if (values.size() != expectedSize) {
        RecordErrorLog(file, line, func,
            "Parameter count mismatch for error code %d. Expected %zu, got %zu." "\n",
            static_cast<int32_t>(errCode), expectedSize, values.size());
        return;
    }

    switch (errCode)
    {
        case ErrorCode::EE1001: 
            RecordErrorLog(file, line, func,
                "The argument is invalid.Reason: %s. ErrorCode=EE1001." "\n", values[0].c_str());
            break;
        case ErrorCode::EE1002: 
            RecordErrorLog(file, line, func,
                "Stream synchronize timeout. %s. ErrorCode=EE1002." "\n", values[0].c_str());
            break;
        // Invalid_Argument
        case ErrorCode::EE1003: 
            RecordErrorLog(file, line, func,
                "%s failed because value %s for parameter %s is invalid. Expected value: %s. ErrorCode=EE1003." "\n",
                values[0].c_str(), values[1].c_str(), values[2].c_str(), values[3].c_str());
            break;
        // Invalid_Argument_Null_Pointer
        case ErrorCode::EE1004:
            RecordErrorLog(file, line, func,
                "%s failed because %s cannot be a NULL pointer. ErrorCode=EE1004." "\n",
            values[0].c_str(), values[1].c_str());
            break;
        // Not_Supported
        case ErrorCode::EE1005:
            RecordErrorLog(file, line, func,
                "The current system or device does not support %s. ErrorCode=EE1005." "\n",
            values[0].c_str());
            break;
        // Not_Supported
        case ErrorCode::EE1006:
            RecordErrorLog(file, line, func,
                "%s execution failed because %s is not supported. ErrorCode=EE1006." "\n",
                values[0].c_str(), values[1].c_str());
            break;
        // Resource_Error_Bind_Stream
        case ErrorCode::EE1007:
            RecordErrorLog(file, line, func,
                "Failed to bind stream with ID %s. Reason: %s. ErrorCode=EE1007." "\n",
                values[0].c_str(), values[1].c_str());
            break;
        // Execution_Error_Load_OP_Kernel
        case ErrorCode::EE1008:
            RecordErrorLog(file, line, func,
                "OP kernel loading failed. Reason: %s. ErrorCode=EE1008." "\n",
                values[0].c_str());
            break;
        // Execution_Error_Model
        case ErrorCode::EE1009:
            RecordErrorLog(file, line, func,
                "Failed to execute model with ID %s. Reason: %s. ErrorCode=EE1009." "\n",
                values[0].c_str(), values[1].c_str());
            break;
        // Execution_Error_Invalid_Context
        case ErrorCode::EE1010:
            RecordErrorLog(file, line, func,
                "%s execution failed because %s does not belong to the current context. ErrorCode=EE1010." "\n",
                values[0].c_str(), values[1].c_str());
            break;
        case ErrorCode::EE1011:
            RecordErrorLog(file, line, func,
                "%s failed. Value %s for parameter %s is invalid. Reason: %s. ErrorCode=EE1011." "\n",
                values[0].c_str(), values[1].c_str(), values[2].c_str(), values[3].c_str());
            break;
        // Config_Error_Invalid_Environment_Variable
        case ErrorCode::EE2002:
            RecordErrorLog(file, line, func,
                "Value %s for environment variable %s is invalid. Expected value: %s. ErrorCode=EE2002." "\n",
                values[0].c_str(), values[1].c_str(), values[2].c_str());
            break;
        default:
            RecordErrorLog(file, line, func,
                "Unknown error code: %d" "\n", static_cast<int32_t>(errCode));
            break;
    }
}

void ProcessErrorCodeImpl(ErrorCode errCode, const char *file, const int32_t line, const char *func,
    const std::vector<std::string> &values)
{
    PrintErrMsgToLog(errCode, file, line, func, values);
}

}  // namespace runtime
}  // namespace cce
