/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "dlog_drv.h"
#include "dlog_core.h"
#include "dlog_level_mgr.h"
#include "library_load.h"
#include "log_print.h"
#include "log_platform.h"
#include "ascend_hal.h"
#include "slog.h"
#include <pthread.h>

#define DRV_HDC_LIBRARY_NAME "libascend_hal.so"
#define DRV_HAL_CTL "halCtl"
#define DRV_SET_MODULE_LOG_LEVEL "drv_log_set_module_log_level"
typedef drvError_t (*DrvHalCtlFunc)(int32_t, void*, size_t, void*, size_t*);
typedef int32_t (*DrvSetModuleLogLevelFunc)(int32_t, int32_t*, int32_t);

/* Modules whose log level is owned by the driver: DRV and UNIFIEDBUS. */
#define DRV_LEVEL_MOD_NUM 2

/*
 * Registration latch: at most one registration attempt per init cycle. A
 * mutex latch rather than pthread_once is deliberate - DlogResetDriverLog
 * re-arms it for the next cycle, and resetting a pthread_once control that
 * another thread may still be blocked on is undefined behaviour, while a
 * mutex-serialized reset is well defined.
 */
static pthread_mutex_t g_dlogDrvRegMutex = PTHREAD_MUTEX_INITIALIZER;
static bool g_dlogDrvRegDone = false; /* under g_dlogDrvRegMutex */
/* Set when this library's own registration succeeded; the unregister path
 * must not touch the driver's handle otherwise (another library - the one
 * this process delegated its write path to - owns it). Under
 * g_dlogDrvRegMutex. */
static bool g_dlogDrvRegistered = false;

/*
 * Driver library handle lifecycle: the lazy load (level dispatch can run
 * before registration) and the unload in DlogResetDriverLog must not race
 * the concurrent level dispatch - the dlog_setlevel thread and the shmem
 * level watcher both reach DlogSetDriverLogLevel. Lock order:
 * g_dlogDrvRegMutex -> g_drvLibMutex, never reversed.
 */
static pthread_mutex_t g_drvLibMutex = PTHREAD_MUTEX_INITIALIZER;
static ArgPtr g_drvLibHandle = NULL; /* under g_drvLibMutex */

/* Same-thread re-entrancy guard for DlogInitDriverLog, see there. */
static LOG_THREAD_LOCAL bool g_dlogInDrvRegister = false;

/*
 * Resolve a symbol from the driver library, loading the library on first
 * use. Both the load and the resolution run under the handle mutex, so a
 * concurrent DlogResetDriverLog (unload) cannot race them. NULL means the
 * library is absent or the symbol has not shipped yet - both expected on
 * machines without the new driver.
 */
STATIC ArgPtr DlogDrvLibFunc(const char* symbol)
{
    ArgPtr func = NULL;
    (void)pthread_mutex_lock(&g_drvLibMutex);
    if (g_drvLibHandle == NULL) {
        g_drvLibHandle = LoadRuntimeDll(DRV_HDC_LIBRARY_NAME);
    }
    if (g_drvLibHandle != NULL) {
        func = LoadDllFuncSingle(g_drvLibHandle, symbol);
    }
    (void)pthread_mutex_unlock(&g_drvLibMutex);
    return func;
}

/*
 * Driver log sink: receives a log line from the driver and pushes it onto the
 * normal write path. Signature is fixed by struct log_out_handle in
 * ascend_hal_define.h.
 *
 * The init guard matters: the driver may call back while DlogInit is still
 * running (DlogInitServerType -> halGetDeviceInfo), and re-entering the write
 * path then would deadlock on the attr lock DlogInitGlobalAttr still holds.
 * The probe the driver prints synchronously inside halCtl registration passes
 * this guard: registration runs from the end of DlogInit, after the init flag
 * is set, and never under the write lock.
 */
STATIC void DlogDriverLog(int moduleId, int level, const char* fmt, ...)
{
    if (!DlogIsInited()) {
        return;
    }
    if ((moduleId < 0) || (fmt == NULL)) {
        return;
    }

    LogMsgArg msgArg = {
        (uint32_t)moduleId & MODULE_ID_MASK,
        (uint32_t)moduleId & LOG_TYPE_MASK,
        level,
        0,
        {APPLICATION, 0, 0, 0, {'\0'}},
        {'\0'},
        {NULL, 0}};

    va_list list;
    va_start(list, fmt);
    (void)DlogWriteInner(&msgArg, fmt, list);
    va_end(list);
}

/*
 * Initial level handed to the driver at registration. Registration runs at the
 * end of DlogInit, after the level state has been initialized from shmem
 * (system processes) or env (application processes) - read the level that is
 * actually in effect now, so the driver starts filtering at the same level
 * this process applies, instead of re-deriving it from the environment and
 * overwriting whatever the level init just dispatched.
 */
STATIC uint32_t DlogGetInitLogLevel(void)
{
    int32_t level = DlogGetLogTypeLevelByModuleId(ALL_MODULE, DEBUG_LOG_MASK);
    if ((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL)) {
        return GLOABLE_DEFAULT_LOG_LEVEL;
    }
    return (uint32_t)level;
}

/*
 * Re-assert the per-module levels of the driver-owned modules after
 * registration. Registration carries only the global level; modules that were
 * configured with a different level (per-module shmem/env setting applied
 * before registration) need their own value re-sent.
 */
STATIC void DlogResyncDrvModuleLevels(void)
{
    const int32_t globalLevel = DlogGetLogTypeLevelByModuleId(ALL_MODULE, DEBUG_LOG_MASK);
    const int32_t modIds[DRV_LEVEL_MOD_NUM] = {DRV, UNIFIEDBUS};
    for (int32_t i = 0; i < DRV_LEVEL_MOD_NUM; i++) {
        int32_t level = DlogGetLogTypeLevelByModuleId((uint32_t)modIds[i], DEBUG_LOG_MASK);
        if ((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL)) {
            continue;
        }
        if (level == globalLevel) {
            continue; /* covered by the registration level */
        }
        DlogSetDriverLogLevel(modIds[i], level);
    }
}

/* Register the log callback with the driver, preferring the RUN_LOG handle and
 * falling back to the generic one. Boundary results are observable in selflog:
 * WARN when the driver library or the halCtl entry is unavailable (no driver on
 * this machine, or an older driver without the interface), INFO on success.
 * Called with g_dlogDrvRegMutex held; the halCtl call itself runs without the
 * mutex so a blocking driver cannot stall the level dispatch. */
STATIC void DlogDrvRegister(void)
{
    ArgPtr ctlFunc = DlogDrvLibFunc(DRV_HAL_CTL);
    ONE_ACT_WARN_LOG(
        ctlFunc == NULL, return, "resolve %s from %s failed, skip register driver log callback.", DRV_HAL_CTL,
        DRV_HDC_LIBRARY_NAME);

    struct log_out_handle handle;
    handle.DlogInner = DlogDriverLog;
    handle.logLevel = DlogGetInitLogLevel();
    /* Same two-step as plog: prefer RUN_LOG, fall back to the generic handle.
     * The driver prints a probe line through the new callback from inside this
     * call - it flows onto the write path normally. */
    drvError_t ret =
        ((DrvHalCtlFunc)ctlFunc)((int32_t)HAL_CTL_REGISTER_RUN_LOG_OUT_HANDLE, &handle, sizeof(handle), NULL, NULL);
    if (ret != DRV_ERROR_NONE) {
        ret = ((DrvHalCtlFunc)ctlFunc)((int32_t)HAL_CTL_REGISTER_LOG_OUT_HANDLE, &handle, sizeof(handle), NULL, NULL);
        if (ret != DRV_ERROR_NONE) {
            SELF_LOG_ERROR("register DlogInner to Hal failed, ret=%d.", (int32_t)ret);
            return;
        }
    }
    g_dlogDrvRegistered = true;
    SELF_LOG_INFO("register DlogInner to Hal ok, logLevel=%u.", handle.logLevel);

    /*
     * handle.logLevel carries the GLOBAL level only. If a driver-owned module
     * was configured with its own level (shmem/env per-module setting), re-send
     * it after registration so the module ends up at its configured level no
     * matter whether the driver treats handle.logLevel as a fallback or an
     * overwrite.
     */
    DlogResyncDrvModuleLevels();
}

/*
 * Push a log level change down to the driver, which converts it and forwards it
 * to UNIFIEDBUS. moduleId must be DRV or UNIFIEDBUS; ALL_MODULE fans out to both.
 */
void DlogSetDriverLogLevel(int32_t moduleId, int32_t level)
{
    if ((level < LOG_MIN_LEVEL) || (level > LOG_MAX_LEVEL)) {
        return;
    }

    int32_t moduleIds[DRV_LEVEL_MOD_NUM];
    int32_t size;
    const uint32_t realModuleId = (uint32_t)moduleId & MODULE_ID_MASK;
    if (realModuleId == ALL_MODULE) {
        moduleIds[0] = DRV;
        moduleIds[1] = UNIFIEDBUS;
        size = DRV_LEVEL_MOD_NUM;
    } else if ((realModuleId == (uint32_t)DRV) || (realModuleId == (uint32_t)UNIFIEDBUS)) {
        moduleIds[0] = (int32_t)realModuleId;
        size = 1;
    } else {
        return;
    }

    /*
     * Hold the handle mutex across resolve AND call: a concurrent
     * DlogResetDriverLog (dlclose) between the two would leave the resolved
     * pointer dangling. The level-set call is fast (unlike halCtl in the
     * registration path), so holding the mutex across it is acceptable.
     */
    bool resolved = false;
    int32_t ret = -1;
    (void)pthread_mutex_lock(&g_drvLibMutex);
    if (g_drvLibHandle == NULL) {
        g_drvLibHandle = LoadRuntimeDll(DRV_HDC_LIBRARY_NAME);
    }
    if (g_drvLibHandle != NULL) {
        ArgPtr func = LoadDllFuncSingle(g_drvLibHandle, DRV_SET_MODULE_LOG_LEVEL);
        if (func != NULL) {
            resolved = true;
            ret = ((DrvSetModuleLogLevelFunc)func)(level, moduleIds, size);
        }
    }
    (void)pthread_mutex_unlock(&g_drvLibMutex);

    /* Absent library or symbol means the driver has not shipped the interface
     * yet - both expected on machines without the new driver. */
    ONE_ACT_WARN_LOG(
        !resolved, return, "resolve %s from %s failed, skip set log level to drv.", DRV_SET_MODULE_LOG_LEVEL,
        DRV_HDC_LIBRARY_NAME);
    if (ret != 0) {
        SELF_LOG_WARN("set log level to drv failed, ret=%d, moduleId=%u, level=%d.", ret, realModuleId, level);
        return;
    }
    const char* modName = "unknown";
    if (realModuleId == ALL_MODULE) {
        modName = "ALL_MODULE(DRV+UNIFIEDBUS)";
    } else if (realModuleId == (uint32_t)DRV) {
        modName = "DRV";
    } else if (realModuleId == (uint32_t)UNIFIEDBUS) {
        modName = "UNIFIEDBUS";
    }
    SELF_LOG_INFO("set log level to drv ok, module=%s, level=%d, modNum=%d.", modName, level, size);
}

void DlogInitDriverLog(void)
{
    /*
     * Same-thread re-entrancy guard: the registration dlopens the driver
     * library, and a constructor of the loaded library may log through this
     * library's write path, which reaches DlogInit and back here while the
     * registration is still running - re-entering would self-deadlock on the
     * latch mutex. Skip instead; the registration in progress completes
     * before the outer call returns.
     */
    if (g_dlogInDrvRegister) {
        return;
    }
    g_dlogInDrvRegister = true;
    (void)pthread_mutex_lock(&g_dlogDrvRegMutex);
    if (!g_dlogDrvRegDone) {
        g_dlogDrvRegDone = true;
        DlogDrvRegister();
    }
    (void)pthread_mutex_unlock(&g_dlogDrvRegMutex);
    g_dlogInDrvRegister = false;
}

/* Tell the driver to stop calling our log callback. Safe to call without a
 * prior successful registration. */
void DlogUnregisterDriverLog(void)
{
    (void)pthread_mutex_lock(&g_dlogDrvRegMutex);
    const bool registered = g_dlogDrvRegistered;
    g_dlogDrvRegistered = false;
    (void)pthread_mutex_unlock(&g_dlogDrvRegMutex);
    if (!registered) {
        /* We never registered (delegated to another library, or registration
         * failed / never ran): the driver's current handle, if any, belongs
         * to someone else and must be left alone. */
        return;
    }
    ArgPtr ctlFunc = DlogDrvLibFunc(DRV_HAL_CTL);
    ONE_ACT_NO_LOG(ctlFunc == NULL, return);
    drvError_t ret = ((DrvHalCtlFunc)ctlFunc)((int32_t)HAL_CTL_UNREGISTER_LOG_OUT_HANDLE, NULL, 0, NULL, NULL);
    if (ret != DRV_ERROR_NONE) {
        SELF_LOG_WARN("unregister DlogInner function to Hal failed, ret=%d.", (int32_t)ret);
        return;
    }
    SELF_LOG_INFO("unregister DlogInner from Hal ok.");
}

/*
 * Reset the registration state so the next DlogInit registers again (e.g.
 * after DlogFree), and release the driver library handle - the lazy load in
 * the level dispatch path owns a reference that nobody else drops. Both steps
 * run under their mutexes, so a concurrent dispatch or registration is
 * serialized instead of racing the reset.
 */
void DlogResetDriverLog(void)
{
    (void)pthread_mutex_lock(&g_dlogDrvRegMutex);
    g_dlogDrvRegDone = false;
    g_dlogDrvRegistered = false;
    (void)pthread_mutex_unlock(&g_dlogDrvRegMutex);

    (void)pthread_mutex_lock(&g_drvLibMutex);
    if (g_drvLibHandle != NULL) {
        (void)UnloadRuntimeDll(g_drvLibHandle);
        g_drvLibHandle = NULL;
    }
    (void)pthread_mutex_unlock(&g_drvLibMutex);
}

/*
 * Fork-child reset: the child inherits a replica of the parent's memory,
 * including mutexes that may have been held by threads that no longer exist -
 * any operation on them would block forever. Re-initialize the mutexes and
 * the latch state directly (single-threaded child, no lock needed), and drop
 * the stale driver-library handle without dlclose - the dlopen reference
 * belongs to the parent process.
 */
void DlogForkResetDriverLog(void)
{
    g_dlogDrvRegMutex = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
    g_drvLibMutex = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
    g_dlogDrvRegDone = false;
    g_dlogDrvRegistered = false;
    g_drvLibHandle = NULL;
    g_dlogInDrvRegister = false;
}
