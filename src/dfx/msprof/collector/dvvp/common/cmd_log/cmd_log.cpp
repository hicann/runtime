/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "cmd_log/cmd_log.h"
#include <cstdarg>
#include "securec.h"

namespace analysis {
namespace dvvp {
namespace common {
namespace cmdlog {
constexpr int32_t MSPROF_BIN_MAX_LOG_SIZE  = 1024; // 1024 : 1k

void CmdLog::CmdLogNoLevel(CONST_CHAR_PTR format, ...)
{
    va_list args;
    char buffer[MSPROF_BIN_MAX_LOG_SIZE + 1] = {0};
    va_start(args, format);
    int ret = vsnprintf_truncated_s(buffer, sizeof(buffer), format, args);
    if (ret > 0) {
        std::cout << buffer << std::endl;
    }
    va_end(args);
}

void CmdLog::CmdErrorLog(CONST_CHAR_PTR format, ...)
{
    va_list args;
    char buffer[MSPROF_BIN_MAX_LOG_SIZE + 1] = {0};
    va_start(args, format);
    int ret = vsnprintf_truncated_s(buffer, sizeof(buffer), format, args);
    if (ret > 0) {
        std::cout << "[ERROR] " << buffer << std::endl;
    }
    va_end(args);
}

void CmdLog::CmdInfoLog(CONST_CHAR_PTR format, ...)
{
    va_list args;
    char buffer[MSPROF_BIN_MAX_LOG_SIZE + 1] = {0};
    va_start(args, format);
    int ret = vsnprintf_truncated_s(buffer, sizeof(buffer), format, args);
    if (ret > 0) {
        std::cout << "[INFO] " << buffer << std::endl;
    }
    va_end(args);
}

void CmdLog::CmdWarningLog(CONST_CHAR_PTR format, ...)
{
    va_list args;
    char buffer[MSPROF_BIN_MAX_LOG_SIZE + 1] = {0};
    va_start(args, format);
    int ret = vsnprintf_truncated_s(buffer, sizeof(buffer), format, args);
    if (ret > 0) {
        std::cout << "[WARNING] " << buffer << std::endl;
    }
    va_end(args);
}
}
}
}
}