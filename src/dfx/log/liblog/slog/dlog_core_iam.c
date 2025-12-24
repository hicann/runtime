/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <sys/ioctl.h>
#include "securec.h"
#include "log_platform.h"
#include "log_common.h"
#include "dlog_async_process.h"
#include "dlog_message.h"
#include "dlog_level_mgr.h"
#include "dlog_time.h"
#include "dlog_core.h"
#include "log_time.h"
#include "alog_to_slog.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC bool g_dlogIsInited = false;

/**
 * @brief       : check dlog init or not
 * @return      : true inited; false not-inited
 */
STATIC INLINE bool DlogIsInited(void)
{
    return g_dlogIsInited;
}

/**
 * @brief       : set dlog init flag
 * @param [in]  : initFlag      init flag setted
 */
STATIC INLINE void DlogSetInited(bool initFlag)
{
    g_dlogIsInited = initFlag;
}

/**
 * @brief DlogCheckLogLevel: check log allow output or not
 * @param [in]level: log level
 * @return: TRUE/FALSE
 */
int32_t DlogCheckLogLevel(int32_t logLevel)
{
    (void)logLevel;
    return TRUE;
}

STATIC bool CheckLogLevelInner(const LogMsgArg *msgArg)
{
    if (msgArg->level == DLOG_EVENT) {
        return GetGlobalEnableEventVar();
    }
    // get module loglevel by moduleId
    int32_t moduleLevel = DlogGetLogTypeLevelByModuleId(msgArg->moduleId, msgArg->typeMask);
    if ((msgArg->level < moduleLevel) || (msgArg->level >= LOG_MAX_LEVEL)) {
        return false;
    }
    return true;
}

/**
* @brief ParseLogMsg: parse module Id
* @param [out]logMsg: log Msg data struct
* @param [in/out]msgArg: LogMsgArg struct pointer
*/
STATIC void ParseLogMsg(LogMsg *logMsg, LogMsgArg *msgArg)
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
 * @brief       : construct base log message
 * @param [out] : msg           log message, to save log content
 * @param [in]  : msgLen        log message max length
 * @param [in]  : msgArg        log info, include information to construct
 * @return      : SYS_OK success; SYS_ERROR failure
 */
STATIC int32_t ConstructBaseMsg(char *msg, uint32_t msgLen, const LogMsgArg *msgArg)
{
    int32_t err;
    if (msgArg->moduleId < (uint32_t)INVLID_MOUDLE_ID) {
        if (((msgArg->level >= DLOG_DEBUG) && (msgArg->level < DLOG_NULL)) || (msgArg->level == DLOG_EVENT)) {
            err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%s] %s(%d,%s):%s ",
                             DlogGetLevelNameById(msgArg->level), DlogGetModuleNameById(msgArg->moduleId),
                             msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        } else {
            err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%d] %s(%d,%s):%s ",
                             msgArg->level, DlogGetModuleNameById(msgArg->moduleId),
                             msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        }
    } else {
        if (((msgArg->level >= DLOG_DEBUG) && (msgArg->level < DLOG_NULL)) || (msgArg->level == DLOG_EVENT)) {
            err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%s] %u(%d,%s):%s ",
                             DlogGetLevelNameById(msgArg->level), msgArg->moduleId,
                             msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        } else {
            err = snprintf_s(msg, msgLen, (size_t)msgLen - 1U, "[%d] %u(%d,%s):%s ",
                             msgArg->level, msgArg->moduleId,
                             msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        }
    }
    if (err == -1) {
        SELF_LOG_ERROR("snprintf_s failed, strerr=%s, pid=%d, pid_name=%s, module=%u.",
                       strerror(ToolGetErrorCode()), msgArg->selfPid, DlogGetPidName(), msgArg->moduleId);
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief       : construct full log content
 * @param [out] : logMsg        log message, to save log content
 * @param [in]  : msgArg        log info, include information to construct
 * @param [in]  : fmt           log content format
 * @param [in]  : v             merge to log message variable
 * @return      : SYS_OK success; SYS_ERROR failure
 */
STATIC int32_t ConstructLogMsg(LogMsg *logMsg, const LogMsgArg *msgArg, const char *fmt, va_list v)
{
    ONE_ACT_NO_LOG(logMsg == NULL, return SYS_ERROR);
    ONE_ACT_NO_LOG(fmt == NULL, return SYS_ERROR);
    int32_t err = ConstructBaseMsg(logMsg->msg, MSG_LENGTH, msgArg);
    if (err != SYS_OK) {
        SELF_LOG_ERROR("construct base log msg failed.");
        return SYS_ERROR;
    }

    // splice key and value
    const KeyValue *pstKVArray = msgArg->kvArg.pstKVArray;
    for (int32_t i = 0; i < msgArg->kvArg.kvNum; i++) {
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
 * @brief       : write log to stdout
 * @param [in]  ：msgArg        LogMsgArg struct pointer
 * @param [in]  : fmt           log content format
 * @param [in]  : v             variable list
 * @return      : NA
 */
STATIC void DlogWriteToStdout(LogMsg *logMsg)
{
    // make sure log content end with '\n'
    DlogSetMessageNl(logMsg);

    // write to stdout
    int32_t fd = ToolFileno(stdout);
    ONE_ACT_ERR_LOG(fd <= 0, return, "file_handle is invalid, file_handle=%d.", fd);
    (void)ToolWrite(fd, (void *)logMsg->logContent, logMsg->contentLength);
}

/**
* @brief DlogWriteInner: write log to log socket or stdout
* @param [in]msgArg: LogMsgArg struct pointer
* @param [in]fmt: pointer to first value in va_list
* @param [in]v: variable list
*/
int32_t DlogWriteInner(LogMsgArg *msgArg, const char *fmt, va_list v)
{
    ONE_ACT_NO_LOG(!CheckLogLevelInner(msgArg), return LOG_FAILURE);

    DlogGetTime(msgArg->timestamp, TIMESTAMP_LEN);
    msgArg->selfPid = DlogGetCurrPid();
    DlogGetUserAttr(&msgArg->attr);

    CheckPid();
    LogMsg logMsg = {DEBUG_LOG, 0, 0, 0, NULL, 0, ""};
    ParseLogMsg(&logMsg, msgArg);
    int32_t result = ConstructLogMsg(&logMsg, msgArg, fmt, v);
    ONE_ACT_ERR_LOG(result != SYS_OK, return LOG_FAILURE, "construct log content failed.");

    if (msgArg->typeMask == STDOUT_LOG_MASK) {
        DlogWriteToStdout(&logMsg);
        return LOG_SUCCESS;
    }

    DlogWriteToBuf(&logMsg);
    return LOG_SUCCESS;
}

/**
 * @brief       : initialize dynamic library
 * @return      : NA
 */
void DlogInit(void)
{
    if (DlogIsInited()) {
        return;
    }

    DlogInitGlobalAttr();
    // sync time zone
    DlogLevelInit();
    (void)DlogAsyncInit();
    (void)LogGetCpuFrequency();
    DlogSetInited(true);
}

STATIC CONSTRUCTOR void DllMain(void)
{
#ifdef LOG_CPP
    if (!DlogIsInited()) {
        if (AlogTryUseSlog() == LOG_SUCCESS) {
            DlogSetInited(true);
            return;
        }
    }
#endif
    DlogInit();
}

/**
* @brief DlogExitForIam: destructor function of libslog.so
* @return: void
*/
STATIC DESTRUCTOR void DlogExitForIam(void)
{
    // if call this in thread exit, it may not be called
    DlogAsyncExit();
    AlogCloseSlogLib();
    AlogCloseDrvLib();
}

/**
* @brief DlogRefreshCache: flush log buffer to file
* @return: void
*/
void DlogRefreshCache(void)
{
    DlogFlushBuf();
}

/**
 * @brief RegisterCallback: register DlogCallback
 * @param [in]callback: function pointer
 * @return: 0: SUCCEED, others: FAILED
 */
int RegisterCallback(const ArgPtr callback, const CallbackType funcType)
{
    (void)callback;
    (void)funcType;
    return SUCCESS;
}

#ifdef __cplusplus
}
#endif // __cplusplus
