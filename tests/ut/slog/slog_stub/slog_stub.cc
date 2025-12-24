/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slog.h"
#include <stdint.h>
#include <syslog.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
int32_t AlogCheckDebugLevel(uint32_t moduleId, int32_t level)
{
    (void)moduleId;
    (void)level;
    return 0;
}

int32_t AlogRecord(uint32_t moduleId, uint32_t logType, int32_t level, const char *fmt, ...)
{
    (void)moduleId;
    (void)fmt;
    if ((logType == (uint32_t)DLOG_TYPE_RUN) || (level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        va_list list;
        va_start(list, fmt);
        vprintf(fmt, list);
        va_end(list);
    }
    return 0;
}
#ifdef __cplusplus
}
#endif // __cplusplus

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus

/**
 * @ingroup slog
 * @brief External log interface, which called by modules
 */
void dlog_init(void)
{
    return;
}

/**
 * @ingroup slog
 * @brief dlog_getlevel: get module loglevel and enableEvent
 *
 * @param [in]moduleId: moudule id(see slog.h, eg: CCE), others: invalid
 * @param [out]enableEvent: 1: enable; 0: disable
 * @return: module level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
 */
int dlog_getlevel(int moduleId, int *enableEvent)
{
    (void)moduleId;
    (void)enableEvent;
    return 0;
}

/**
 * @ingroup slog
 * @brief dlog_setlevel: set module loglevel and enableEvent
 *
 * @param [in]moduleId: moudule id(see slog.h, eg: CCE), -1: all modules, others: invalid
 * @param [in]level: log level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
 * @param [in]enableEvent: 1: enable; 0: disable, others:invalid
 * @return: 0: SUCCEED, others: FAILED
 */
int dlog_setlevel(int moduleId, int level, int enableEvent)
{
    (void)moduleId;
    (void)level;
    (void)enableEvent;
    return 0;
}

/**
 * @ingroup slog
 * @brief CheckLogLevel: check module level enable or not
 * users no need to call it because all dlog interface(include inner interface) has already called
 *
 * @param [in]moduleId: module id, eg: CCE
 * @param [in]logLevel: eg: DLOG_EVENT/DLOG_ERROR/DLOG_WARN/DLOG_INFO/DLOG_DEBUG
 * @return: 1:enable, 0:disable
 */
int CheckLogLevel(int moduleId, int logLevel)
{
    (void)moduleId;
    (void)logLevel;
    return 0;
}

/**
 * @ingroup slog
 * @brief DlogSetAttr: set log attr, default pid is 0, default device id is 0, default process type is APPLICATION
 * @param [in]logAttr: attr info, include pid(must be larger than 0), process type and device id(chip ID)
 * @return: 0: SUCCEED, others: FAILED
 */
int DlogSetAttr(LogAttr logAttr)
{
    (void)logAttr;
    return 0;
}

/**
 * @ingroup     : slog
 * @brief       : print log, need va_list variable, exec CheckLogLevel() before call this function
 * @param[in]   : moduleId      module id, eg: CCE
 * @param[in]   : level         (0: debug, 1: info, 2: warning, 3: error, 5: trace, 6: oplog, 16: event)
 * @param[in]   : fmt           log content
 * @param[in]   : list          variable list of log content
 */
void DlogVaList(int moduleId, int level, const char *fmt, va_list list)
{
    (void)moduleId;
    (void)fmt;
    (void)list;
    if ((level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        vprintf(fmt, list);
    }
}

/**
 * @ingroup slog
 * @brief DlogFlush: flush log buffer to file
 */
void DlogFlush(void)
{
    return;
}

/**
 * @ingroup slog
 * @brief Internal log interface, other modules are not allowed to call this interface
 */
void DlogErrorInner(int moduleId, const char *fmt, ...)
{
    (void)moduleId;
    va_list list;
    va_start(list, fmt);
    vprintf(fmt, list);
    va_end(list);
}

void DlogWarnInner(int moduleId, const char *fmt, ...)
{
    (void)moduleId;
    (void)fmt;
}

void DlogInfoInner(int moduleId, const char *fmt, ...)
{
    (void)moduleId;
    (void)fmt;
}

void DlogDebugInner(int moduleId, const char *fmt, ...)
{
    (void)moduleId;
    (void)fmt;
}

void DlogEventInner(int moduleId, const char *fmt, ...)
{
    (void)moduleId;
    va_list list;
    va_start(list, fmt);
    vprintf(fmt, list);
    va_end(list);
}

void DlogInner(int moduleId, int level, const char *fmt, ...)
{
    (void)moduleId;
    (void)fmt;
    if ((level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        va_list list;
        va_start(list, fmt);
        vprintf(fmt, list);
        va_end(list);
    }
}

void DlogWrite(int moduleId, int level, const char *fmt, ...)
{
    (void)moduleId;
    (void)fmt;
    if ((level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        va_list list;
        va_start(list, fmt);
        vprintf(fmt, list);
        va_end(list);
    }
}

void DlogRecord(int moduleId, int level, const char *fmt, ...)
{
    (void)moduleId;
    (void)fmt;
    if ((level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        va_list list;
        va_start(list, fmt);
        vprintf(fmt, list);
        va_end(list);
    }
}

#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus

#ifdef LOG_CPP
#ifdef __cplusplus
extern "C" {
#endif

int32_t DlogGetlevelForC(int32_t moduleId, int32_t *enableEvent)
{
    return dlog_getlevel(moduleId, enableEvent);
}

int32_t DlogSetlevelForC(int32_t moduleId, int32_t level, int32_t enableEvent)
{
    return dlog_setlevel(moduleId, level, enableEvent);
}

int32_t CheckLogLevelForC(int32_t moduleId, int32_t logLevel)
{
    return CheckLogLevel(moduleId, logLevel);
}

int32_t DlogSetAttrForC(LogAttr logAttr)
{
    return DlogSetAttr(logAttr);
}

void DlogFlushForC(void)
{
    return DlogFlush();
}

void DlogInnerForC(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    (void)moduleId;
    if ((level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        va_list list;
        va_start(list, fmt);
        vprintf(fmt, list);
        va_end(list);
    }
}

void DlogWriteForC(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    (void)moduleId;
    if ((level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        va_list list;
        va_start(list, fmt);
        vprintf(fmt, list);
        va_end(list);
    }
}

void DlogRecordForC(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    (void)moduleId;
    if ((level == DLOG_ERROR) || (level == DLOG_EVENT)) {
        va_list list;
        va_start(list, fmt);
        vprintf(fmt, list);
        va_end(list);
    }
}

#ifdef __cplusplus
}
#endif
#endif // LOG_CPP