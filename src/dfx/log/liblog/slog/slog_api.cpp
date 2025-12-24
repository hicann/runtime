/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slog_api.h"
#include <string>
#include "dlog_core.h"
#include "log_error_code.h"
#include "dlog_attr.h"
#include "dlog_level_mgr.h"
#include "dlog_message.h"
#include "library_load.h"
#include "alog_to_slog.h"
#include "alog_pub.h"

#ifdef IAM
#include "dlog_async_process.h"
#endif

namespace {
    ArgPtr g_sloglibHandle = nullptr;
    SymbolInfo g_slogFuncInfo[DLOG_FUNC_MAX] = {
        {"dlog_init", nullptr},
        {"dlog_getlevel", nullptr},
        {"dlog_setlevel", nullptr},
        {"CheckLogLevel", nullptr},
        {"DlogGetAttr", nullptr},
        {"DlogSetAttr", nullptr},
        {"DlogVaList", nullptr},
        {"DlogFlush", nullptr}
    };

    using DlogInitFunc = decltype(dlog_init)*;
    using DlogGetLogLevelFunc = decltype(dlog_getlevel)*;
    using DlogSetLogLevelFunc = decltype(dlog_setlevel)*;
    using CheckLogLevelFunc = decltype(CheckLogLevel)*;
    using DlogGetAttrFunc = decltype(DlogGetAttr)*;
    using DlogSetAttrFunc = decltype(DlogSetAttr)*;
    using DlogVaListFunc = decltype(DlogVaList)*;
    using DlogFlushFunc = decltype(DlogFlush)*;
};

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#ifdef PROCESS_LOG
int32_t AlogTransferToUnifiedlog(void)
{
    const std::string DLOG_LIBRARY_NAME = "libunified_dlog.so";
    g_sloglibHandle = LoadRuntimeDll(DLOG_LIBRARY_NAME.c_str());
    if (g_sloglibHandle == nullptr) {
        return LOG_FAILURE;
    }
    int32_t ret = LoadDllFunc(g_sloglibHandle, &g_slogFuncInfo[0], DLOG_FUNC_MAX);
    if (ret != LOG_SUCCESS) {
        return ret;
    }

    SELF_LOG_INFO("alog transfer to unified_dlog success");
    return LOG_SUCCESS;
}

int32_t AlogCheckDebugLevel(uint32_t moduleId, int32_t level)
{
    if (g_slogFuncInfo[CHECK_LOG_LEVEL].handle != nullptr) {
        return reinterpret_cast<CheckLogLevelFunc>(g_slogFuncInfo[CHECK_LOG_LEVEL].handle)(moduleId, level);
    }

    // get module loglevel by moduleId
    const int32_t moduleLevel = DlogGetDebugLogLevelByModuleId(moduleId);
    if ((level < moduleLevel) || (level >= LOG_MAX_LEVEL)) {
        return FALSE;
    }
    return TRUE;
}

int32_t AlogRecord(uint32_t moduleId, uint32_t logType, int32_t level, const char *fmt, ...)
{
    uint32_t type = DEBUG_LOG_MASK;
    if (logType == static_cast<uint32_t>(DLOG_TYPE_RUN)) {
        type = RUN_LOG_MASK;
    }
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId | type, level, fmt, list);
        va_end(list);
        return LOG_SUCCESS;
    }
    if (fmt == nullptr) {
        return LOG_FAILURE;
    }

    LogMsgArg msgArg = {moduleId, type, level, 0, {APPLICATION, 0, 0, 0, {'\0'}}, {'\0'}, {nullptr, 0}};

    va_list list;
    va_start(list, fmt);
    int32_t ret = DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
    return ret;
}
#else
int32_t AlogTransferToSlog(void)
{
    const std::string SLOG_LIBRARY_NAME = "libslog.so";
    g_sloglibHandle = LoadRuntimeDll(SLOG_LIBRARY_NAME.c_str());
    if (g_sloglibHandle == nullptr) {
        return LOG_FAILURE;
    }
    void *slogGetAttrFunc = LoadDllFuncSingle(g_sloglibHandle, "DlogGetAttr");
    if (slogGetAttrFunc == nullptr) {
        return LOG_FAILURE;
    }
    int32_t ret = LoadDllFunc(g_sloglibHandle, &g_slogFuncInfo[0], DLOG_FUNC_MAX);
    if (ret != LOG_SUCCESS) {
        return ret;
    }

    LogAttr attr = {};
    (void)memset_s(&(attr), sizeof(attr), DLOG_ATTR_INIT_VALUE, sizeof(attr));
    attr.type = APPLICATION;
    ret = DlogSetAttr(attr);
    if (ret != LOG_SUCCESS) {
        return ret;
    }
    SELF_LOG_INFO("alog transfer to slog success");
    return LOG_SUCCESS;
}
#endif
void AlogCloseSlogLib(void)
{
    (void)UnloadRuntimeDll(g_sloglibHandle);
}

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus

/**
* @brief DlogInner: log interface with level
* @param [in]moduleId: moudule Id eg: CCE
* @param [in]level: log level((0: debug, 1: info, 2: warning, 3: error)
* @param [in]fmt: log msg string
* @return: void
*/
void DlogInner(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, level, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

void DlogErrorInner(int32_t moduleId, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, DLOG_ERROR, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        DLOG_ERROR,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

void DlogWarnInner(int32_t moduleId, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, DLOG_WARN, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        DLOG_WARN,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

void DlogInfoInner(int32_t moduleId, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, DLOG_INFO, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        DLOG_INFO,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

void DlogDebugInner(int32_t moduleId, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, DLOG_DEBUG, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        DLOG_DEBUG,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

void DlogEventInner(int32_t moduleId, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, DLOG_EVENT, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        DLOG_EVENT,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

/**
* @brief DlogWithKVInner: log interface with level
* @param [in]moduleId: moudule Id eg: CCE
* @param [in]level: log level(0: debug, 1: info, 2: warning, 3: error)
* @param [in]pstKVArray: key-value arrary
* @param [in]kvNum: num of key-value arrary
* @param [in]fmt: log msg string
* @return: void
*/
void DlogWithKVInner(int32_t moduleId, int32_t level, const KeyValue *pstKVArray, int32_t kvNum, const char *fmt, ...)
{
    ONE_ACT_ERR_LOG(pstKVArray == nullptr, return, "[input] key-value array is null.");
    ONE_ACT_ERR_LOG(kvNum <= 0, return, "[input] key-value number is invalid, key_value_number=%d.", kvNum);
    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {pstKVArray, kvNum}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

/**
* @brief DlogRecord: log interface with level
* @param [in]moduleId: moudule Id eg: CCE
* @param [in]level: log level(0: debug, 1: info, 2: warning, 3: error)
* @param [in]fmt: log msg string
* @return: void
*/
void DlogRecord(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, level, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

/**
 * @brief       : set log attr
 * @param [in]  : logAttrInfo   attr info, include pid, process type and device id
 * @return      : 0: SUCCEED, others: FAILED
 */
int32_t DlogGetAttr(LogAttr *logAttrInfo)
{
    if (g_slogFuncInfo[DLOG_GET_ATTR].handle != nullptr) {
        return reinterpret_cast<DlogGetAttrFunc>(g_slogFuncInfo[DLOG_GET_ATTR].handle)(logAttrInfo);
    }
    DlogGetUserAttr(logAttrInfo);
    return LOG_SUCCESS;
}

/**
 * @brief       : set log attr
 * @param [in]  : logAttrInfo   attr info, include pid, process type and device id
 * @return      : 0: SUCCEED, others: FAILED
 */
int32_t DlogSetAttr(LogAttr logAttrInfo)
{
    if (g_slogFuncInfo[DLOG_SET_ATTR].handle != nullptr) {
        return reinterpret_cast<DlogSetAttrFunc>(g_slogFuncInfo[DLOG_SET_ATTR].handle)(logAttrInfo);
    }

    DlogSetUserAttr(&logAttrInfo);
    if ((logAttrInfo.type == APPLICATION) && (!GetGlobalLevelSettedVar())) {
        // update level by env after setting app property.
        // g_levelSetted is setted true in the interface 'dlog_setlevel',
        // if g_levelSetted is false, then update level by env.
        // EP/MDC aicpu call dlog_setlevel first, then set log attr
        // RC aicpu not call dlog_setlevel, only set log attr
        DlogLevelInitByEnv();
#ifdef IAM
        DlogUpdateFlierLevelStatus();
#endif
    }
    return LOG_SUCCESS;
}

void DlogVaList(int32_t moduleId, int32_t level, const char *fmt, va_list list)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, level, fmt, list);
        return;
    }
    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    (void)DlogWriteInner(&msgArg, fmt, list);
}

void dlog_init(void)
{
    if (g_slogFuncInfo[DLOG_INIT].handle != nullptr) {
        reinterpret_cast<DlogInitFunc>(g_slogFuncInfo[DLOG_INIT].handle)();
        return;
    }
    DlogInit();
}

/**
* @brief DlogGetLogLevel: get module loglevel
* @param [in]moduleId: moudule id(see slog.h, eg: CCE), ALL_MODULE: global
                       support DEBUG_LOG_MASK and RUN_LOG_MASK, default DEBUG_LOG_MASK
* @param [in/out]enableEvent: point to enableEvent to record enableEvent
* @return: module level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
*/
STATIC int32_t DlogGetLogLevel(uint32_t moduleId, int32_t *enableEvent)
{
    if (enableEvent != nullptr) {
        *enableEvent = GetGlobalEnableEventVar() ? TRUE : FALSE;
    }

    const uint32_t realModuleId = moduleId & MODULE_ID_MASK;
    const uint32_t typeMask = moduleId & LOG_TYPE_MASK;

    int32_t moduleLevel = DLOG_MODULE_DEFAULT_LEVEL;
    if (realModuleId == ALL_MODULE) {
        moduleLevel = GetGlobalLogTypeLevelVar(typeMask);
    } else {
        moduleLevel = DlogGetLogTypeLevelByModuleId(realModuleId, typeMask);
        if (moduleLevel < LOG_MIN_LEVEL || moduleLevel > LOG_MAX_LEVEL) {
            moduleLevel = GetGlobalLogTypeLevelVar(typeMask);
        }
    }
    return moduleLevel;
}

STATIC int32_t DlogSetModuleLevel(uint32_t moduleId, int32_t level)
{
    if ((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL)) {
        SELF_LOG_WARN("set loglevel input level=%d is illegal.", level);
        return SYS_ERROR;
    }

    const uint32_t realModuleId = moduleId & MODULE_ID_MASK;
    const uint32_t typeMask = moduleId & LOG_TYPE_MASK;
 
    if (realModuleId == ALL_MODULE) {
        SetGlobalLogTypeLevelVar(level, typeMask);
        DlogSetLogTypeLevelToAllModule(level, typeMask);
        SetGlobalLevelSettedVar(true);
    } else if (realModuleId < static_cast<uint32_t>(INVLID_MOUDLE_ID)) {
        (void)DlogSetLogTypeLevelByModuleId(static_cast<uint32_t>(realModuleId), level, typeMask);
    } else {
        SELF_LOG_WARN("set loglevel input moduleId=%u is illegal.", moduleId);
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
* @brief DlogSetLogLevel: set module loglevel and enableEvent
* @param [in]moduleId: moudule id(see slog.h, eg: CCE), ALL_MODULE: all modules, others: invalid
                       support DEBUG_LOG_MASK and RUN_LOG_MASK, default DEBUG_LOG_MASK
* @param [in]level: log level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
* @param [in]enableEvent: 1: enable; 0: disable, others:invalid
* @return: 0: SUCCEED, others: FAILED
*/
STATIC int32_t DlogSetLogLevel(uint32_t moduleId, int32_t level, int32_t enableEvent)
{
    int32_t ret = SYS_OK;
    if (enableEvent == TRUE) {
        SetGlobalEnableEventVar(true);
    } else if (enableEvent == FALSE) {
        SetGlobalEnableEventVar(false);
    } else {
        SELF_LOG_WARN("set loglevel input enableEvent=%d is illegal.", enableEvent);
        ret = SYS_ERROR;
    }

    if (DlogSetModuleLevel(moduleId, level) != SYS_OK) {
        ret = SYS_ERROR;
    }
    return ret;
}

/**
* @brief dlog_getlevel: get module loglevel
* @param [in]moduleId: moudule Id eg: CCE
* @param [in/out]enableEvent: point to enableEvent to record enableEvent
* @return: module level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
*/
int32_t dlog_getlevel(int32_t moduleId, int32_t *enableEvent)
{
    if (g_slogFuncInfo[DLOG_GET_LEVEL].handle != nullptr) {
        return reinterpret_cast<DlogGetLogLevelFunc>(g_slogFuncInfo[DLOG_GET_LEVEL].handle)(moduleId, enableEvent);
    }
    if (moduleId < 0) {
        return SYS_ERROR;
    } else {
        return DlogGetLogLevel((static_cast<uint32_t>(moduleId) & MODULE_ID_MASK) | DEBUG_LOG_MASK, enableEvent);
    }
}

/**
* @brief dlog_setlevel: set module loglevel and enableEvent
* @param [in]moduleId: moudule id(see slog.h, eg: CCE), -1: all modules, others: invalid
* @param [in]level: log level(0: debug, 1: info, 2: warning, 3: error, 4: null output)
* @param [in]enableEvent: 1: enable; 0: disable, others:invalid
* @return: 0: SUCCEED, others: FAILED
*/
int32_t dlog_setlevel(int32_t moduleId, int32_t level, int32_t enableEvent)
{
    if (g_slogFuncInfo[DLOG_SET_LEVEL].handle != nullptr) {
        return reinterpret_cast<DlogSetLogLevelFunc>(g_slogFuncInfo[DLOG_SET_LEVEL].handle)(
            moduleId, level, enableEvent);
    }

    if (moduleId == INVALID) {
        return DlogSetLogLevel(ALL_MODULE | DEBUG_LOG_MASK, level, enableEvent);
    } else if (moduleId < 0) {
        return SYS_ERROR;
    } else {
        return DlogSetLogLevel((static_cast<uint32_t>(moduleId) & MODULE_ID_MASK) | DEBUG_LOG_MASK, level, enableEvent);
    }
}

int32_t CheckLogLevel(int32_t moduleId, int32_t logLevel)
{
    if (g_slogFuncInfo[CHECK_LOG_LEVEL].handle != nullptr) {
        return reinterpret_cast<CheckLogLevelFunc>(g_slogFuncInfo[CHECK_LOG_LEVEL].handle)(moduleId, logLevel);
    }

    if (moduleId < 0) {
        return FALSE;
    } else if (logLevel == DLOG_EVENT) {
        return GetGlobalEnableEventVar() ? TRUE : FALSE;
    } else {
        // get module loglevel by moduleId
        const int32_t moduleLevel = DlogGetLogTypeLevelByModuleId(static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
            static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK);
        if ((logLevel < moduleLevel) || (logLevel >= LOG_MAX_LEVEL)) {
            return FALSE;
        }
        return DlogCheckLogLevel(logLevel);
    }
}

void DlogFlush(void)
{
    if (g_slogFuncInfo[DLOG_FLUSH].handle != nullptr) {
        reinterpret_cast<DlogFlushFunc>(g_slogFuncInfo[DLOG_FLUSH].handle)();
        return;
    }
    DlogRefreshCache();
}

#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus

// interface for C
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

int32_t DlogSetAttrForC(LogAttr logAttrInfo)
{
    return DlogSetAttr(logAttrInfo);
}

void DlogFlushForC(void)
{
    return DlogFlush();
}

void DlogInnerForC(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, level, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

void DlogWithKVInnerForC(int32_t moduleId, int32_t level,
    const KeyValue *pstKVArray, int32_t kvNum, const char *fmt, ...)
{
    ONE_ACT_ERR_LOG(pstKVArray == nullptr, return, "[input] key-value array is null.");
    ONE_ACT_ERR_LOG(kvNum <= 0, return, "[input] key-value number=%d is invalid.", kvNum);
    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {pstKVArray, kvNum}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

void DlogRecordForC(int32_t moduleId, int32_t level, const char *fmt, ...)
{
    if (g_slogFuncInfo[DLOG_VA_LIST].handle != nullptr) {
        va_list list;
        va_start(list, fmt);
        reinterpret_cast<DlogVaListFunc>(g_slogFuncInfo[DLOG_VA_LIST].handle)(moduleId, level, fmt, list);
        va_end(list);
        return;
    }

    if ((moduleId < 0) || (fmt == nullptr)) {
        return;
    }

    LogMsgArg msgArg = {
        static_cast<uint32_t>(moduleId) & MODULE_ID_MASK,
        static_cast<uint32_t>(moduleId) & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {nullptr, 0}
    };

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

#ifdef __cplusplus
}
#endif
#endif // LOG_CPP

// the code for stub
#if (!defined PROCESS_LOG && !defined PLOG_AUTO)
#include "plog.h"

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus
int32_t DlogReportInitialize(void)
{
    return 0;
}

int32_t DlogReportFinalize(void)
{
    return 0;
}

int32_t DlogReportStart(int32_t devId, int32_t mode)
{
    (void)devId;
    (void)mode;
    return SYS_OK;
}

void DlogReportStop(int32_t devId)
{
    (void)devId;
    return;
}

#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus
#endif
