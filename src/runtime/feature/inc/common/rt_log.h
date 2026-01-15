/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_LOG_H
#define CCE_RUNTIME_LOG_H
#include <cstdint>
#include <string>
#include <vector>
namespace cce {
namespace runtime {
constexpr int32_t RT_MAX_LOG_BUF_SIZE = 896;  // Total length for slog is 1024 bytes, and head use 128 bytes.
void RecordErrorLog(const char *file, const int32_t line, const char *fun, const char *fmt, ...);
void RecordLog(int32_t level, const char *file, const int32_t line, const char *fun, const char *fmt, ...);
void ReportErrMsg(std::string errorCode, const std::vector<char> &valueString);
// 具体含义见error_manager/error_code.json
enum class ErrorCode
{
    EE_NO_ERROR = 0,
    EE1001,
    EE1002,
    EE1003,
    EE1004,
    EE1005,
    EE1006,
    EE1007,
    EE1008,
    EE1009,
    EE1010,
    EE1011,
    EE2002
};
std::vector<std::string> GetParamNames(ErrorCode code);
void PrintErrMsgToLog(ErrorCode errCode, const char *file, const int32_t line, const char *func,
    const std::vector<std::string> &values);
void ProcessErrorCodeImpl(ErrorCode errCode, const char *file, const int32_t line, const char *func,
    const std::vector<std::string> &values);
}
}
#endif

