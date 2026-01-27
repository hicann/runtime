/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <sstream>
#include "mmpa/mmpa_api.h"
#include "inc/tsd_util.h"
#include "inc/internal_api.h"

namespace {
    constexpr size_t DEBUG_ERROR_NUM = 10LU;
    constexpr uint32_t MAX_LOG_STRING = 0x200U;
}

namespace tsd {
TSDLog *TSDLog::GetInstance()
{
    static TSDLog instance;
    return &instance;
}

void TSDLog::RestoreErrorMsg(const char_t * const funcPointer, const char_t * const filePath, const int32_t lineNumber,
                             const char_t * const format, ...)
{
    if ((funcPointer == nullptr) || (filePath == nullptr)) {
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

    va_list ap;
    va_start(ap, format);
    const ScopeGuard vaGuard([&ap]() {va_end(ap);});
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

    ret = sprintf_s(errorLog.get(), MAX_LOG_STRING, "%s,[%s:%d:%s]%d\n", tmpStr.get(), filePath, lineNumber,
                    funcPointer, mmGetTid());
    if (ret <= 0) {
        return;
    }

    {
        const std::lock_guard<std::mutex> lk(errorListMutex_);
        if (errorList_.size() > DEBUG_ERROR_NUM) {
            errorList_.pop();
        }

        errorList_.emplace(std::string(errorLog.get()));
    }

    return;
}

std::string TSDLog::GetErrorMsg()
{
    const std::lock_guard<std::mutex> lk(errorListMutex_);
    std::stringstream ss;
    while (!errorList_.empty()) {
        ss << errorList_.front();
        errorList_.pop();
    }
    return ss.str();
}
}  // namespace tsd
