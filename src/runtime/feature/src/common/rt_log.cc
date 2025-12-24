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

}  // namespace runtime
}  // namespace cce
