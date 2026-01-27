/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <memory>
#include <sstream>
#include <cstdarg>
#include <securec.h>
#include "aicpu_sharder_log.h"
#include "aicpu_error_log_api.h"
#include "aicpu_error_log.h"

namespace {
    constexpr size_t ERROR_LOG_NUM = 20LU;
    constexpr uint32_t MAX_LOG_STRING = 0x100U;

    std::shared_ptr<aicpu::AicpuErrorLog> g_errLogs = nullptr;
}

namespace aicpu {
void InitAicpuErrorLog()
{
    if (g_errLogs != nullptr) {
        return;
    }

    g_errLogs = std::make_shared<AicpuErrorLog>();
    return;
}

void RestoreErrorLog(const char_t * const funcName, const char_t * const filePath, const int32_t lineNumber,
                     const uint64_t tid, const char_t * const format, ...)
{
    if (g_errLogs == nullptr) {
        return;
    }

    va_list ap;
    va_start(ap, format);
    g_errLogs->RestoreErrorLog(funcName, filePath, lineNumber, tid, format, ap);
    va_end(ap);
    return;
}

void PrintErrorLog()
{
    if (g_errLogs == nullptr) {
        return;
    }

    return g_errLogs->PrintErrorLog();
}

bool HasErrorLog()
{
    if (g_errLogs == nullptr) {
        return false;
    }

    return g_errLogs->GetErrorLogSize() != 0UL;
}

void AicpuErrorLog::RestoreErrorLog(const char_t * const funcName, const char_t * const filePath,
                                    const int32_t lineNumber, const uint64_t tid, const char_t * const format,
                                    va_list ap)
{
    if ((funcName == nullptr) || (filePath == nullptr)) {
        return;
    }

    std::unique_ptr<char_t[]> tmpStr(new (std::nothrow) char_t[MAX_LOG_STRING + 1U], std::default_delete<char_t[]>());
    if (tmpStr == nullptr) {
        return;
    }

    auto eRet = memset_s(tmpStr.get(), static_cast<size_t>(MAX_LOG_STRING + 1U),
                         0, static_cast<size_t>(MAX_LOG_STRING + 1U));
    if (eRet != EOK) {
        return;
    }

    int32_t ret = vsnprintf_s(tmpStr.get(), MAX_LOG_STRING, MAX_LOG_STRING - 1U, format, ap);
    if (ret <= 0) {
        return;
    }

    std::unique_ptr<char_t[]> errorLog(new (std::nothrow) char_t[MAX_LOG_STRING + 1U], std::default_delete<char_t[]>());
    if (errorLog == nullptr) {
        return;
    }

    eRet = memset_s(errorLog.get(), static_cast<size_t>(MAX_LOG_STRING + 1U),
                    0, static_cast<size_t>(MAX_LOG_STRING + 1U));
    if (eRet != EOK) {
        return;
    }

    ret = sprintf_s(errorLog.get(), MAX_LOG_STRING, "%s [%s:%d][%s][tid:%lu]\n", tmpStr.get(), filePath, lineNumber,
                    funcName, tid);
    if (ret <= 0) {
        return;
    }

    {
        std::lock_guard<std::mutex> lk(errLogMutex_);
        if (errLogs_.size() > ERROR_LOG_NUM) {
            errLogs_.pop();
        }
        errLogs_.emplace(std::string(errorLog.get()));
    }
    return;
}

void AicpuErrorLog::PrintErrorLog()
{
    std::lock_guard<std::mutex> lk(errLogMutex_);
    while (!errLogs_.empty()) {
        AICPUE_LOGE("%s", errLogs_.front().c_str());
        errLogs_.pop();
    }

    return;
}
}

