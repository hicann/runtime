/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_inner.h"

#include "base/err_msg.h"

namespace acl {
bool AclLog::isEnableEvent_ = false;
constexpr size_t const ACL_LIMIT_PER_MESSAGE = 1024U;

std::string AclGetErrorFormatMessage(const mmErrorMsg errnum)
{
    char_t errBuff[acl::MAX_ERROR_STRING + 1U] = {};
    const auto msgPtr = mmGetErrorFormatMessage(errnum, &errBuff[0], acl::MAX_ERROR_STRING);
    const auto errMessage = (msgPtr == nullptr) ? "" : msgPtr;
    return std::string(errMessage);
}

aclLogLevel AclLog::GetCurLogLevel()
{
    int32_t eventEnable = 0;
    const int32_t dlogLevel = dlog_getlevel(ACL_MODE_ID, &eventEnable);
    aclLogLevel curLevel = ACL_INFO;
    switch (dlogLevel) {
        case DLOG_ERROR:
            curLevel = ACL_ERROR;
            break;
        case DLOG_WARN:
            curLevel = ACL_WARNING;
            break;
        case DLOG_INFO:
            curLevel = ACL_INFO;
            break;
        case DLOG_DEBUG:
            curLevel = ACL_DEBUG;
            break;
        default:
            break;
    }

    isEnableEvent_ = (eventEnable == 1); // Out put event enable
    return curLevel;
}

bool AclLog::IsEventLogOutputEnable()
{
    (void)AclLog::GetCurLogLevel();
    return isEnableEvent_;
}

bool AclLog::IsLogOutputEnable(const aclLogLevel logLevel)
{
    const aclLogLevel curLevel = AclLog::GetCurLogLevel();
    return (curLevel <= logLevel);
}

mmPid_t AclLog::GetTid()
{
    static const thread_local mmPid_t tid = static_cast<mmPid_t>(mmGetTid());
    return tid;
}

void AclLog::ACLSaveLog(const aclLogLevel logLevel, const char_t *const strLog)
{
    if (strLog == nullptr) {
        return;
    }
    switch (logLevel) {
        case ACL_ERROR:
            dlog_error(APP_MODE_ID, "%s", strLog);
            break;
        case ACL_WARNING:
            dlog_warn(APP_MODE_ID, "%s", strLog);
            break;
        case ACL_INFO:
            dlog_info(APP_MODE_ID, "%s", strLog);
            break;
        case ACL_DEBUG:
            dlog_debug(APP_MODE_ID, "%s", strLog);
            break;
        default:
            break;
    }
}

std::string AclErrorLogManager::FormatStr(const char_t *const fmt, ...)
{
    if (fmt == nullptr) {
        return "";
    }

    va_list ap;
    va_start(ap, fmt);
    char_t str[acl::MAX_LOG_STRING] = {};
    const int32_t printRet = vsnprintf_s(str, static_cast<size_t>(acl::MAX_LOG_STRING),
        static_cast<size_t>(acl::MAX_LOG_STRING - 1U), fmt, ap);
    if (printRet == -1) {
        va_end(ap);
        return "";
    }
    va_end(ap);
    return str;
}

void AclErrorLogManager::ReportInputError(const char *errorCode, const std::vector<const char *> &key,
    const std::vector<const char *> &val)
{
    REPORT_PREDEFINED_ERR_MSG(errorCode, key, val);
}

void AclErrorLogManager::ReportInnerError(const char_t *const fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    char_t errorMsgStr[ACL_LIMIT_PER_MESSAGE] = {};
    const int32_t ret = vsnprintf_s(errorMsgStr, static_cast<size_t>(ACL_LIMIT_PER_MESSAGE),
        static_cast<size_t>(ACL_LIMIT_PER_MESSAGE - 1U), fmt, ap);
    if (ret == -1) {
        va_end(ap);
        ACL_LOG_ERROR("[Call][Vsnprintf]call vsnprintf failed, ret = %d", ret);
        return;
    }
    va_end(ap);
    REPORT_INNER_ERR_MSG("EH9999", "%s", errorMsgStr);
}

void AclErrorLogManager::ReportCallError(const char_t *const fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    char_t errorMsgStr[ACL_LIMIT_PER_MESSAGE] = {};
    const int32_t ret = vsnprintf_s(errorMsgStr, static_cast<size_t>(ACL_LIMIT_PER_MESSAGE),
        static_cast<size_t>(ACL_LIMIT_PER_MESSAGE - 1U), fmt, ap);
    if (ret == -1) {
        va_end(ap);
        ACL_LOG_ERROR("[Call][Vsnprintf]call vsnprintf failed, ret = %d", ret);
        return;
    }
    va_end(ap);
    REPORT_INNER_ERR_MSG("EH9999", "%s", errorMsgStr);
}

void AclErrorLogManager::ReportInputErrorWithChar(const char_t *const errorCode, const char_t *const argNames[],
    const char_t *const argVals[], const size_t size)
{
    std::vector<const char *> argNameArr;
    std::vector<const char *> argValArr;
    for (size_t i = 0U; i < size; ++i) {
        argNameArr.push_back(argNames[i]);
        argValArr.push_back(argVals[i]);
    }
    REPORT_PREDEFINED_ERR_MSG(errorCode, argNameArr, argValArr);
}
} // namespace acl
