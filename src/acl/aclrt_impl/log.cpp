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
#include "acl/acl_rt_impl.h"
#include "common/log_inner.h"

void aclAppLogImpl(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, va_list args)
{
    if ((fmt == nullptr) || (func == nullptr) || (file == nullptr)) {
        return;
    }
    if (!acl::AclLog::IsLogOutputEnable(logLevel)) {
        return;
    }
    char_t str[acl::MAX_LOG_STRING] = {};
    int32_t printRet = vsnprintf_s(str, static_cast<size_t>(acl::MAX_LOG_STRING),
        static_cast<size_t>(acl::MAX_LOG_STRING - 1U), fmt, args);
    if (printRet != -1) {
        char_t strLog[acl::MAX_LOG_STRING] = {};
        printRet = sprintf_s(strLog, static_cast<size_t>(acl::MAX_LOG_STRING), "%d %s:%s:%u: \"%s\"",
            acl::AclLog::GetTid(), func, file, line, str);
        if (printRet != -1) {
            acl::AclLog::ACLSaveLog(logLevel, strLog);
        } else {
            acl::AclLog::ACLSaveLog(ACL_ERROR, "aclAppLog call sprintf_s failed");
        }
    } else {
        acl::AclLog::ACLSaveLog(ACL_ERROR, "aclAppLog call vsnprintf_s failed");
    }
    return;
}
