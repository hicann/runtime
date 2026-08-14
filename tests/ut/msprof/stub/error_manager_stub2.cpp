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
#include <string>
#include <vector>
#include "base/err_mgr.h"
#include "error_manager_stub2.h"

namespace {
std::string g_msprofLastInputErrorCode;
std::vector<std::string> g_msprofLastInputErrorValues;
}  // namespace

namespace MsprofUtestStub {
void ResetMsprofLastInputErrorCode()
{
  g_msprofLastInputErrorCode.clear();
  g_msprofLastInputErrorValues.clear();
}

void RecordMsprofInputErrorCode(const std::string &errorCode)
{
  g_msprofLastInputErrorCode = errorCode;
  g_msprofLastInputErrorValues.clear();
}

void RecordMsprofInputErrorCode(const std::string &errorCode, const std::vector<std::string> &values)
{
  g_msprofLastInputErrorCode = errorCode;
  g_msprofLastInputErrorValues = values;
}

const std::string &GetMsprofLastInputErrorCode()
{
  return g_msprofLastInputErrorCode;
}

const std::vector<std::string> &GetMsprofLastInputErrorValues()
{
  return g_msprofLastInputErrorValues;
}
} // namespace MsprofUtestStub

///
/// @brief Obtain ErrorManager instance
/// @return ErrorManager instance
// Definitions for the WEAK_SYMBOL declarations in base/err_msg.h. Missing definitions would link
// silently and then jump to null at run time. ReportPredefinedErrMsg records the reported code so
// the MSPROF_INPUT_ERROR assertions keep working for code paths that reach the real macro rather
// than the override in error_manager_stub2.h.
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
    (void)key;
    std::vector<std::string> values;
    values.reserve(value.size());
    for (const auto *v : value) {
        values.emplace_back((v == nullptr) ? "" : v);
    }
    MsprofUtestStub::RecordMsprofInputErrorCode((errorCode == nullptr) ? "" : errorCode, values);
    return 0;
}

int32_t ReportPredefinedErrMsg(const char *errorCode)
{
    MsprofUtestStub::RecordMsprofInputErrorCode((errorCode == nullptr) ? "" : errorCode);
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
