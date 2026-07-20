/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstdarg>
#include <securec.h>
#include "acl_rt_impl.h"
#include "common/log_inner.h"

namespace {
constexpr const char_t* const TRUNCATED_MARK = "...[truncated]";
constexpr size_t TRUNCATED_MARK_LEN = 14U; // strlen("...[truncated]")

// 在缓冲区尾部覆盖写入截断标记，标记连同结尾 '\0' 仍落在 MAX_LOG_STRING 预算内，避免被下游二次截断。
void AppendTruncatedMark(char_t* const buf)
{
    (void)strcpy_s(&buf[acl::MAX_LOG_STRING - 1U - TRUNCATED_MARK_LEN], TRUNCATED_MARK_LEN + 1U, TRUNCATED_MARK);
}
} // namespace

#ifdef __cplusplus
extern "C" {
#endif

void aclAppLogImpl(
    aclLogLevel logLevel, const char* func, const char* file, uint32_t line, const char* fmt, va_list args)
{
    if ((fmt == nullptr) || (func == nullptr) || (file == nullptr)) {
        return;
    }
    if (!acl::AclLog::IsLogOutputEnable(logLevel)) {
        return;
    }
    // 使用 vsnprintf_truncated_s / snprintf_truncated_s 而非 vsnprintf_s / sprintf_s：
    // 后者在内容超长时返回 -1 并丢弃整条日志，前者会截断保留内容（截断时返回 MAX_LOG_STRING - 1）。
    char_t str[acl::MAX_LOG_STRING] = {};
    const int32_t bodyRet = vsnprintf_truncated_s(str, static_cast<size_t>(acl::MAX_LOG_STRING), fmt, args);
    if (bodyRet == -1) {
        // 仅在格式化字符串非法（如包含 %n）时进入此分支，给出准确提示。
        acl::AclLog::ACLSaveLog(ACL_ERROR, "aclAppLog format string is invalid");
        return;
    }

    char_t strLog[acl::MAX_LOG_STRING] = {};
    const int32_t headRet = snprintf_truncated_s(
        strLog, static_cast<size_t>(acl::MAX_LOG_STRING), "%d %s:%s:%u: \"%s\"", acl::AclLog::GetTid(), func, file,
        line, str);

    // 正文或头部拼接发生截断时，在最终串尾部补写截断标记，提示用户内容不完整。
    if ((bodyRet >= static_cast<int32_t>(acl::MAX_LOG_STRING - 1U)) ||
        (headRet >= static_cast<int32_t>(acl::MAX_LOG_STRING - 1U))) {
        AppendTruncatedMark(strLog);
    }
    acl::AclLog::ACLSaveLog(logLevel, strLog);
    return;
}
#ifdef __cplusplus
}
#endif
