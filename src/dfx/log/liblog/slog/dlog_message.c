/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dlog_message.h"
#include "log_platform.h"
#include "dlog_level_mgr.h"
#include "dlog_attr.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC int32_t ConstructBaseLogForValidModuleId(char *msg, uint32_t msgLen, const LogMsgArg *msgArg)
{
    int32_t err;
    if (((msgArg->level >= DLOG_DEBUG) && (msgArg->level <= DLOG_NULL)) || (msgArg->level == DLOG_EVENT)) {
        err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%s] %s(%d,%s):%s ",
                         DlogGetLevelNameById(msgArg->level), DlogGetModuleNameById(msgArg->moduleId),
                         msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
    } else {
        err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%d] %s(%d,%s):%s ",
                         msgArg->level, DlogGetModuleNameById(msgArg->moduleId),
                         msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
    }
    return err;
}

STATIC int32_t ConstructBaseLogForInvalidModuleId(char *msg, uint32_t msgLen, const LogMsgArg *msgArg)
{
    int32_t err;
    if (((msgArg->level >= DLOG_DEBUG) && (msgArg->level <= DLOG_NULL)) || (msgArg->level == DLOG_EVENT)) {
        err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%s] %u(%d,%s):%s ",
                         DlogGetLevelNameById(msgArg->level), msgArg->moduleId,
                         msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
    } else {
        err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%d] %u(%d,%s):%s ",
                         msgArg->level, msgArg->moduleId, msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
    }
    return err;
}

/**
 * @brief       : construct base log message
 * @param [out] : msg           log message, to save log content
 * @param [in]  : msgLen        log message max length
 * @param [in]  : msgArg        log info, include information to construct
 * @return      : SYS_OK success; SYS_ERROR failure
 */
STATIC int32_t ConstructBaseLogMsg(char *msg, uint32_t msgLen, const LogMsgArg *msgArg)
{
    int32_t err;
    if (msgArg->moduleId < (uint32_t)INVLID_MOUDLE_ID) {
        err = ConstructBaseLogForValidModuleId(msg, msgLen, msgArg);
    } else {
        err = ConstructBaseLogForInvalidModuleId(msg, msgLen, msgArg);
    }
    if (err == -1) {
        SELF_LOG_ERROR("snprintf_s failed, strerr=%s, pid=%d, pid_name=%s, module=%u.",
                       strerror(ToolGetErrorCode()), msgArg->selfPid, DlogGetPidName(), msgArg->moduleId);
        return SYS_ERROR;
    }
    return SYS_OK;
}


STATIC void DlogInitMsgHead(const LogMsg *logMsg, LogHead *head)
{
    ONE_ACT_NO_LOG(logMsg == NULL, return);
    ONE_ACT_NO_LOG(head == NULL, return);
    (void)memset_s(head, sizeof(LogHead), 0, sizeof(LogHead));

    head->magic = HEAD_MAGIC;
    head->version = HEAD_VERSION;
    head->aosType = (uint8_t)DlogGetAosType(); // AOS_GEA/AOS_SEA
    head->processType = (uint8_t)DlogGetProcessType();  // APPLICATION/SYSTEM
    head->logType = (uint8_t)logMsg->type;     // debug/run/security
    head->logLevel = (uint8_t)logMsg->level;   // debug/info/warning/error/event
    head->hostPid = DlogGetHostPid();
    head->devicePid = (uint32_t)DlogGetCurrPid();
    head->deviceId = (uint16_t)DlogGetAttrDeviceId();
    head->moduleId = (uint16_t)logMsg->moduleId;
    head->allLength = 0;
    head->msgLength = (uint16_t)logMsg->msgLength;
    head->tagSwitch = 0; // 0:without tag; 1:with tag
    head->saveMode = 0;
}

LogStatus DlogAddMessageHead(LogMsg *logMsg, char *buffer, uint32_t bufLen)
{
    ONE_ACT_NO_LOG(logMsg == NULL, return LOG_FAILURE);
    ONE_ACT_NO_LOG(buffer == NULL, return LOG_FAILURE);
    ONE_ACT_NO_LOG(bufLen < ((uint32_t)LOGHEAD_LEN + (uint32_t)MSG_LENGTH), return LOG_FAILURE);

    LogHead head;
    DlogInitMsgHead(logMsg, &head);
    int32_t ret = memcpy_s(buffer, bufLen, (const char *)&head, LOGHEAD_LEN);
    ONE_ACT_ERR_LOG(ret != 0, return LOG_FAILURE, "memcpy data failed, strerr=%s.", strerror(ToolGetErrorCode()));
    ret = memcpy_s(buffer + LOGHEAD_LEN, bufLen - LOGHEAD_LEN, &logMsg->msg, logMsg->msgLength);
    ONE_ACT_ERR_LOG(ret != 0, return LOG_FAILURE, "memcpy data failed, strerr=%s.", strerror(ToolGetErrorCode()));
    logMsg->msgLength += (uint32_t)LOGHEAD_LEN;
    return LOG_SUCCESS;
}

LogStatus DlogAddMessageTag(LogMsg *logMsg, const LogMsgArg *msgArg, char *buffer, uint32_t bufLen)
{
    ONE_ACT_NO_LOG(logMsg == NULL, return LOG_FAILURE);
    ONE_ACT_NO_LOG(buffer == NULL, return LOG_FAILURE);
    ONE_ACT_NO_LOG(bufLen < MSG_LENGTH, return LOG_FAILURE);

    int32_t ret = snprintf_s(buffer, (size_t)MSG_LENGTH, (size_t)MSG_LENGTH - 1U, "[%d,%u,%u,%d]%s",
                             (int32_t)msgArg->attr.type, msgArg->attr.pid, msgArg->attr.deviceId, logMsg->type,
                             logMsg->msg);
    ONE_ACT_ERR_LOG(ret == -1, return LOG_FAILURE, "snprintf_s failed, strerr=%s.", strerror(ToolGetErrorCode()));

    uint32_t strLen = LogStrlen(buffer);
    if ((strLen > 1U) && (buffer[strLen - 1U] != '\n')) {
        if (strLen == ((uint32_t)MSG_LENGTH - 1U)) {
            buffer[strLen - 1U] = '\n';
        } else {
            ret = snprintf_truncated_s(buffer, MSG_LENGTH, "%s\n", buffer);
            ONE_ACT_ERR_LOG(ret == -1, return LOG_FAILURE, "copy failed, strerr=%s.", strerror(ToolGetErrorCode()));
        }
    }
    logMsg->msgLength = LogStrlen(buffer);
    return LOG_SUCCESS;
}

/**
 * @brief       : construct full log content
 * @param [out] : logMsg        struct of log message
 * @param [in]  : msgLen        log message max length
 * @param [in]  : msgArg        log info, include information to construct
 * @param [in]  : fmt           log content format
 * @param [in]  : v             merge to log message variable
 * @return      : SYS_OK success; SYS_ERROR failure
 */
int32_t DlogSetMessage(LogMsg *logMsg, const LogMsgArg *msgArg, const char *fmt, va_list v)
{
    ONE_ACT_NO_LOG(logMsg == NULL, return SYS_ERROR);
    ONE_ACT_NO_LOG(fmt == NULL, return SYS_ERROR);

    int32_t err = ConstructBaseLogMsg(logMsg->msg, MSG_LENGTH, msgArg);
    if (err != SYS_OK) {
        SELF_LOG_ERROR("construct base log msg failed.");
        return SYS_ERROR;
    }

    // splice key and value
    const KeyValue *pstKVArray = msgArg->kvArg.pstKVArray;
    int32_t i;
    for (i = 0; i < msgArg->kvArg.kvNum; i++) {
        logMsg->msgLength = LogStrlen(logMsg->msg);
        err = snprintf_s(logMsg->msg + logMsg->msgLength, (size_t)MSG_LENGTH - (size_t)logMsg->msgLength,
            (size_t)MSG_LENGTH - (size_t)logMsg->msgLength - 1U, "[%s:%s] ", pstKVArray->kname, pstKVArray->value);
        if (err == -1) {
            SELF_LOG_ERROR("snprintf_s failed, strerr=%s, pid=%d, pid_name=%s, module=%u.",
                           strerror(ToolGetErrorCode()), msgArg->selfPid, DlogGetPidName(), msgArg->moduleId);
            return SYS_ERROR;
        }
        pstKVArray++;
    }

    // construct log content
    logMsg->msgLength = LogStrlen(logMsg->msg);
    err = vsnprintf_truncated_s(logMsg->msg + logMsg->msgLength, (size_t)MSG_LENGTH - (size_t)logMsg->msgLength,
        fmt, v);
    if (err == -1) {
        SELF_LOG_ERROR("vsnprintf_truncated_s failed, strerr=%s, pid=%d, pid_name=%s, module=%u.",
                       strerror(ToolGetErrorCode()), msgArg->selfPid, DlogGetPidName(), msgArg->moduleId);
        return SYS_ERROR;
    }

    logMsg->msg[MSG_LENGTH - 1] = '\0';
    logMsg->msgLength = LogStrlen(logMsg->msg);
    logMsg->logContent = logMsg->msg;
    logMsg->contentLength = LogStrlen(logMsg->logContent);
    return SYS_OK;
}

/**
* @brief ParseLogMsg: parse module Id
* @param [in]moduleId: module id (in lower 16 bits) with log type(in higher 16 bits)
* @param [out]logMsg: log Msg data struct
*/
void DlogParseLogMsg(LogMsgArg *msgArg, LogMsg *logMsg)
{
    logMsg->level = msgArg->level;
    logMsg->moduleId = msgArg->moduleId;
    if (msgArg->level == DLOG_EVENT) {
        logMsg->type = RUN_LOG;
        return;
    }

    if (msgArg->typeMask == DEBUG_LOG_MASK) {
        logMsg->type = DEBUG_LOG;
    } else if (msgArg->typeMask == SECURITY_LOG_MASK) {
        logMsg->level = DLOG_INFO;
        msgArg->level = DLOG_INFO;
        logMsg->type = SECURITY_LOG;
    } else if (msgArg->typeMask == RUN_LOG_MASK) {
        logMsg->type = RUN_LOG;
    } else {
        logMsg->type = DEBUG_LOG;
    }
}

/**
 * @brief       : make sure the log message end with '\n'
 * @param [out] : logMsg        struct of log message
 */
void DlogSetMessageNl(LogMsg *logMsg)
{
    if ((logMsg->msgLength > 1) && (logMsg->msg[logMsg->msgLength - 1U] != '\n')) {
        if (logMsg->msgLength == (MSG_LENGTH - 1U)) {
            logMsg->msg[logMsg->msgLength - 1U] = '\n';
        } else {
            int32_t err = snprintf_truncated_s(logMsg->msg, MSG_LENGTH, "%s\n", logMsg->msg);
            ONE_ACT_ERR_LOG(err == -1, return, "copy failed, strerr=%s.", strerror(ToolGetErrorCode()));
        }
        logMsg->msgLength = LogStrlen(logMsg->msg);
        logMsg->contentLength = LogStrlen(logMsg->logContent);
    }
}

#ifdef __cplusplus
}
#endif // __cplusplus

