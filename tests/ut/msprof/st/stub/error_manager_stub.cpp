/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstddef>
#include <cstdint>
#include <vector>
#include "base/err_mgr.h"

// Stub for the error reporting API the code under test actually uses. base/err_msg.h declares these
// as WEAK_SYMBOL, so a missing definition links fine and then jumps to null at run time -- every
// symbol reachable from the code under test must be defined here.
namespace error_message {
ErrorManagerContext GetErrMgrContext()
{
    static ErrorManagerContext errorContext{};
    return errorContext;
}

void SetErrMgrContext(ErrorManagerContext errorContext)
{
    (void)(errorContext);
}

int32_t ReportInnerErrMsg(const char *fileName, const char *func, uint32_t line, const char *errorCode,
                          const char *format, ...)
{
    (void)fileName;
    (void)func;
    (void)line;
    (void)errorCode;
    (void)format;
    return 0;
}

int32_t ReportPredefinedErrMsg(const char *errorCode, const std::vector<const char *> &key,
                               const std::vector<const char *> &value)
{
    (void)errorCode;
    (void)key;
    (void)value;
    return 0;
}

int32_t ReportPredefinedErrMsg(const char *errorCode)
{
    (void)errorCode;
    return 0;
}

int32_t ReportUserDefinedErrMsg(const char *errorCode, const char *format, ...)
{
    (void)errorCode;
    (void)format;
    return 0;
}

int32_t RegisterFormatErrorMessage(const char *errorMsg, size_t errorMsgLen)
{
    (void)errorMsg;
    (void)errorMsgLen;
    return 0;
}
}  // namespace error_message
