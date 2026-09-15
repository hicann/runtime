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
#include <pthread.h>
#include <stdatomic.h>
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
#include "dlog_drv.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

STATIC bool g_dlogIsInited = false;

/**
 * @brief       : check dlog init or not
 * @return      : true inited; false not-inited
 */
bool DlogIsInited(void) { return g_dlogIsInited; }

/**
 * @brief       : set dlog init flag
 * @param [in]  : initFlag      init flag setted
 */
STATIC INLINE void DlogSetInited(bool initFlag) { g_dlogIsInited = initFlag; }

#ifdef LOG_CPP
/*
 * Latch for the deferred transfer, mirroring dlog_core.c: attempted at most
 * once per init cycle, mutex-based so a re-arm is well defined (a pthread_once
 * control must not be reset while another thread may still be blocked on it). The
 * unlocked fast-path read of g_dlogTransferDone is the per-entry cost: DONE is
 * published with release semantics only after the result is stored.
 */
STATIC pthread_mutex_t g_dlogTransferMutex = PTHREAD_MUTEX_INITIALIZER;
STATIC int32_t g_dlogTransferRet = LOG_FAILURE;
STATIC _Atomic bool g_dlogTransferDone = false;

/* Same-thread re-entrancy guard: the attempt dlopens the slog library, and a
 * constructor of the loaded library may log through this library's entries
 * while the attempt is still running; the re-entrant call reports the current
 * state instead of self-deadlocking on the latch mutex. */
STATIC LOG_THREAD_LOCAL bool g_dlogInTransfer = false;

STATIC void DlogTransferToSlogLocked(void)
{
    g_dlogTransferRet = LOG_FAILURE;
    if (AlogTryUseSlog() == LOG_SUCCESS) {
        DlogSetInited(true);
        g_dlogTransferRet = LOG_SUCCESS;
    }
}
#endif

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

STATIC bool CheckLogLevelInner(const LogMsgArg* msgArg)
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
STATIC void ParseLogMsg(LogMsg* logMsg, LogMsgArg* msgArg)
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
STATIC int32_t ConstructBaseMsg(char* msg, uint32_t msgLen, const LogMsgArg* msgArg)
{
    int32_t err;
    if (msgArg->moduleId < (uint32_t)INVALID_MODULE_ID) {
        if (((msgArg->level >= DLOG_DEBUG) && (msgArg->level < DLOG_NULL)) || (msgArg->level == DLOG_EVENT)) {
            err = snprintf_s(
                msg, msgLen, (size_t)msgLen - 1U, "[%s] %s(%d,%s):%s ", DlogGetLevelNameById(msgArg->level),
                DlogGetModuleNameById(msgArg->moduleId), msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        } else {
            err = snprintf_s(
                msg, msgLen, (size_t)msgLen - 1U, "[%d] %s(%d,%s):%s ", msgArg->level,
                DlogGetModuleNameById(msgArg->moduleId), msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        }
    } else {
        if (((msgArg->level >= DLOG_DEBUG) && (msgArg->level < DLOG_NULL)) || (msgArg->level == DLOG_EVENT)) {
            err = snprintf_s(
                msg, msgLen, (size_t)msgLen - 1U, "[%s] %u(%d,%s):%s ", DlogGetLevelNameById(msgArg->level),
                msgArg->moduleId, msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        } else {
            err = snprintf_s(
                msg, msgLen, (size_t)msgLen - 1U, "[%d] %u(%d,%s):%s ", msgArg->level, msgArg->moduleId,
                msgArg->selfPid, DlogGetPidName(), msgArg->timestamp);
        }
    }
    if (err == -1) {
        SELF_LOG_ERROR(
            "snprintf_s failed, strerr=%s, pid=%d, pid_name=%s, module=%u.", strerror(ToolGetErrorCode()),
            msgArg->selfPid, DlogGetPidName(), msgArg->moduleId);
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
STATIC int32_t ConstructLogMsg(LogMsg* logMsg, const LogMsgArg* msgArg, const char* fmt, va_list v)
{
    ONE_ACT_NO_LOG(logMsg == NULL, return SYS_ERROR);
    ONE_ACT_NO_LOG(fmt == NULL, return SYS_ERROR);
    int32_t err = ConstructBaseMsg(logMsg->msg, MSG_LENGTH, msgArg);
    if (err != SYS_OK) {
        SELF_LOG_ERROR("construct base log msg failed.");
        return SYS_ERROR;
    }

    // splice key and value
    const KeyValue* pstKVArray = msgArg->kvArg.pstKVArray;
    for (int32_t i = 0; i < msgArg->kvArg.kvNum; i++) {
        logMsg->msgLength = LogStrlen(logMsg->msg);
        err = snprintf_s(
            logMsg->msg + logMsg->msgLength, (size_t)MSG_LENGTH - (size_t)logMsg->msgLength,
            (size_t)MSG_LENGTH - (size_t)logMsg->msgLength - 1U, "[%s:%s] ", pstKVArray->kname, pstKVArray->value);
        if (err == -1) {
            SELF_LOG_ERROR(
                "snprintf_s failed, strerr=%s, pid=%d, pid_name=%s, module=%u.", strerror(ToolGetErrorCode()),
                msgArg->selfPid, DlogGetPidName(), msgArg->moduleId);
            return SYS_ERROR;
        }
        pstKVArray++;
    }

    // construct log content
    logMsg->msgLength = LogStrlen(logMsg->msg);
    err =
        vsnprintf_truncated_s(logMsg->msg + logMsg->msgLength, (size_t)MSG_LENGTH - (size_t)logMsg->msgLength, fmt, v);
    if (err == -1) {
        SELF_LOG_ERROR(
            "vsnprintf_truncated_s failed, strerr=%s, pid=%d, pid_name=%s, module=%u.", strerror(ToolGetErrorCode()),
            msgArg->selfPid, DlogGetPidName(), msgArg->moduleId);
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
STATIC void DlogWriteToStdout(LogMsg* logMsg)
{
    // make sure log content end with '\n'
    DlogSetMessageNl(logMsg);

    // write to stdout
    int32_t fd = ToolFileno(stdout);
    ONE_ACT_ERR_LOG(fd <= 0, return, "file_handle is invalid, file_handle=%d.", fd);
    (void)ToolWrite(fd, (void*)logMsg->logContent, logMsg->contentLength);
}

/**
 * @brief DlogWriteInner: write log to log socket or stdout
 * @param [in]msgArg: LogMsgArg struct pointer
 * @param [in]fmt: pointer to first value in va_list
 * @param [in]v: variable list
 */
int32_t DlogWriteInner(LogMsgArg* msgArg, const char* fmt, va_list v)
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
#if defined LOG_CPP || defined APP_LOG
    // level already comes from the env in these builds, so slogd must not filter
    // by level again; must run after DlogAsyncInit inited the buffers
    DlogUpdateFlierLevelStatus();
#endif
    (void)LogGetCpuFrequency();
    DlogSetInited(true);

    /* Register the driver log callback after the init flag is set; the
     * registering flag in dlog_drv.c keeps the driver's synchronous probe call
     * from re-entering the write path. */
    DlogInitDriverLog();
}

/*
 * Deferred driver resolution, mirroring dlog_core.c: switch alog to slog at
 * most once, from a normal API entry point (DlogSetAttr). The IAM constructor
 * cannot dlopen the driver library while the library is still initialising.
 * Returns LOG_SUCCESS when writes are being forwarded to slog.
 */
int32_t DlogTryTransferToSlog(void)
{
#ifdef LOG_CPP
    if (g_dlogInTransfer) {
        return g_dlogTransferRet;
    }
    if (atomic_load_explicit(&g_dlogTransferDone, memory_order_acquire)) {
        return g_dlogTransferRet;
    }
    g_dlogInTransfer = true;
    (void)pthread_mutex_lock(&g_dlogTransferMutex);
    if (!atomic_load_explicit(&g_dlogTransferDone, memory_order_relaxed)) {
        DlogTransferToSlogLocked();
        atomic_store_explicit(&g_dlogTransferDone, true, memory_order_release);
    }
    /* Snapshot under the mutex: a concurrent reset (DlogExitForIam) between
     * the unlock and the read would otherwise flip the result. */
    const int32_t ret = g_dlogTransferRet;
    (void)pthread_mutex_unlock(&g_dlogTransferMutex);
    g_dlogInTransfer = false;
    return ret;
#else
    return LOG_FAILURE;
#endif
}

STATIC CONSTRUCTOR void DllMain(void)
{
#ifdef LOG_CPP
    if (DlogTryTransferToSlog() != LOG_SUCCESS) {
        DlogInit();
    }
#else
    DlogInit();
#endif
}

/**
 * @brief DlogExitForIam: destructor function of libslog.so
 * @return: void
 */
STATIC DESTRUCTOR void DlogExitForIam(void)
{
    /* Stop the driver callbacks first: the steps below release the async
     * buffers and the slog handles, and a driver log firing in that window
     * would write into freed resources. No-op unless this library registered
     * the callback itself. */
    DlogUnregisterDriverLog();
    // if call this in thread exit, it may not be called
    DlogAsyncExit();
    AlogCloseSlogLib();
    AlogCloseDrvLib();
    DlogResetDriverLog();
#ifdef LOG_CPP
    /* Re-arm the transfer latch for the next init cycle. */
    (void)pthread_mutex_lock(&g_dlogTransferMutex);
    g_dlogTransferRet = LOG_FAILURE;
    atomic_store_explicit(&g_dlogTransferDone, false, memory_order_release);
    (void)pthread_mutex_unlock(&g_dlogTransferMutex);
#endif
}

/**
 * @brief DlogRefreshCache: flush log buffer to file
 * @return: void
 */
void DlogRefreshCache(void) { DlogFlushBuf(); }

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
