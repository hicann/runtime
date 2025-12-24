/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "awatchdog_core.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "awatchdog_monitor.h"
#include "ascend_hal.h"

#define DRIVER_GET_PLATFORM_INFO_API "drvGetPlatformInfo"
#define DRIVER_LIBRARY_NAME "libascend_hal.so"
#define DRIVER_PLATFORM_DEVICE_SIDE 0
#define DRIVER_PLATFORM_HOST_SIDE 1

static AwdWatchdogMgr g_awdWatchdogMgr = {0};
static bool g_forking = false;
typedef void (*ThreadAtFork)(void);

STATIC void AwdGetAllLock(void)
{
    for (int32_t i = 0; i < (int32_t)AWD_WATCHDOG_TYPE_MAX; i++) {
        (void)AdiagLockGet(&g_awdWatchdogMgr.awd[i].runList.lock);
        (void)AdiagLockGet(&g_awdWatchdogMgr.awd[i].newList.lock);
    }
}

STATIC void AwdReleaseAllLock(void)
{
    for (int32_t i = 0; i < (int32_t)AWD_WATCHDOG_TYPE_MAX; i++) {
        (void)AdiagLockRelease(&g_awdWatchdogMgr.awd[i].runList.lock);
        (void)AdiagLockRelease(&g_awdWatchdogMgr.awd[i].newList.lock);
    }
}

STATIC void AwdSubProcessInit(void)
{
    ADIAG_DBG("[fork] watchdog subprocess init");
    if (!g_forking) {
        // sub process has been initialized
        return;
    }
    AwdMonitorReset();  // reset thread id
    g_awdWatchdogMgr.monitorStarted = false;  // set monitorStarted to false to restart monitor thread when create
    AwdReleaseAllLock();
    g_forking = false;
}

STATIC void AwdProcessUnInit(void)
{
    g_forking = true; // set forking to true to avoid repeat uninit and init
    ADIAG_DBG("[fork] watchdog process uninit");
    AwdGetAllLock();
}

STATIC void AwdProcessInit(void)
{
    ADIAG_DBG("[fork] watchdog process init");
    AwdReleaseAllLock();
    g_forking = false;
}

STATIC void AwdPrepareForFork(void)
{
    int32_t ret = pthread_atfork((ThreadAtFork)AwdProcessUnInit, (ThreadAtFork)AwdProcessInit,
        (ThreadAtFork)AwdSubProcessInit);
    if (ret != 0) {
        ADIAG_WAR("can not call pthread_atfork, ret=%d", ret);
    }
}

typedef drvError_t (*DrvGetPlatformInfo)(uint32_t *);
STATIC bool AwdCheckIsOnDeviceSide(void)
{
    void *handle = mmDlopen(DRIVER_LIBRARY_NAME, RTLD_LAZY);
    if (handle == NULL) {
        ADIAG_WAR("can not dlopen lib %s, reason:%s", DRIVER_LIBRARY_NAME, strerror(errno));
        return false;
    }
    void* getPlatFormInfoFunc = mmDlsym(handle, DRIVER_GET_PLATFORM_INFO_API);
    if (getPlatFormInfoFunc == NULL) {
        ADIAG_WAR("can not find symbol %s in %s.", DRIVER_GET_PLATFORM_INFO_API, DRIVER_LIBRARY_NAME);
        (void)mmDlclose(handle);
        return false;
    }
    uint32_t platform = DRIVER_PLATFORM_HOST_SIDE;
    drvError_t ret = ((DrvGetPlatformInfo)getPlatFormInfoFunc)(&platform);
    if (ret == DRV_ERROR_NONE && platform == DRIVER_PLATFORM_DEVICE_SIDE) {
        ADIAG_INF("watchdog get platform device side");
        (void)mmDlclose(handle);
        return true;
    }
    ADIAG_INF("watchdog get platform host side");
    (void)mmDlclose(handle);
    return false;
}

STATIC bool AwdCheckFeatureEnable(void)
{
    if (!AwdCheckIsOnDeviceSide()) {
        return true;
    }
    return false;
}

STATIC CONSTRUCTOR void AwatchdogInit(void)
{
    g_awdWatchdogMgr.enable = AwdCheckFeatureEnable();
    if (!g_awdWatchdogMgr.enable) {
        ADIAG_WAR("watchdog is not enable on current platform");
        return;
    }
    for (int32_t i = 0; i < (int32_t)AWD_WATCHDOG_TYPE_MAX; i++) {
        (void)AdiagListInit(&g_awdWatchdogMgr.awd[i].runList);
        (void)AdiagListInit(&g_awdWatchdogMgr.awd[i].newList);
    }
    g_awdWatchdogMgr.monitorStarted = true;
    AwdMonitorInit();
    AwdPrepareForFork();
}

STATIC DESTRUCTOR void AwatchdogExit(void)
{
    if (!g_awdWatchdogMgr.enable) {
        return;
    }
    AwdMonitorExit();
    g_awdWatchdogMgr.monitorStarted = false;
    for (int32_t i = 0; i < (int32_t)AWD_WATCHDOG_TYPE_MAX; i++) {
        (void)AdiagListDestroy(&g_awdWatchdogMgr.awd[i].runList);
        (void)AdiagListDestroy(&g_awdWatchdogMgr.awd[i].newList);
    }
}

/**
 * @brief       Create watchdog handle.
 * @param [in]  dogId:         dog id get from DEFINE_THREAD_WATCHDOG_ID(moduleId)
 * @param [in]  timeout:       timeout, s
 * @param [in]  callback:      callback function
 * @param [in]  type:          watchdog type
 * @return      atrace handle
 */
AwdThreadWatchdog* AwdWatchdogCreate(uint32_t dogId, uint32_t timeout, AwatchdogCallbackFunc callback,
    enum AwdWatchdogType type)
{
    if (!g_awdWatchdogMgr.enable) {
        return NULL;
    }
    if (g_awdWatchdogMgr.monitorStarted == false) {
        // judge initialized first to avoid using atomic operations every time
        if (AWD_ATOMIC_CMP_AND_SWAP(&g_awdWatchdogMgr.monitorStarted, false,  true)) {
            /* Prevent duplicate initialization.
               Dog create may finished before monitor thread start, but timeout must be more than 1s.
               When watchdog timeout, monitor thread must have been started, so ignored. */
            AwdMonitorInit();
        }
    }
    AwdThreadWatchdog *dog = (AwdThreadWatchdog *)AdiagMalloc(sizeof(AwdThreadWatchdog));
    if (dog == NULL) {
        return NULL;
    }
    dog->tid = (int32_t)syscall(SYS_gettid);
    dog->pid = (int32_t)getpid();
    dog->dogId = dogId;
    dog->timeout = timeout;
    dog->callback = callback;
    AWD_ATOMIC_TEST_AND_SET(&dog->runCount, 0);
    AWD_ATOMIC_TEST_AND_SET(&dog->startCount, AWD_STATUS_INIT);
    ADIAG_INF("create watchdog for id : %u, tid : %d, timeout : %us", dog->dogId, dog->tid, timeout);
    // add to list after node init finished
    AwdStatus ret = AdiagListInsert(&(g_awdWatchdogMgr.awd[type].newList), (void *)dog);
    if (ret != ADIAG_SUCCESS) {
        ADIAG_SAFE_FREE(dog);
        ADIAG_ERR("add watchdog node for module : %u to new list failed", dogId);
        return NULL;
    }
    return dog;
}

/**
 * @brief       Get watchdog manager ptr by type
 * @param [in]  type:   watchdog type
 * @return      watchdog manager ptr
 */
struct AwdWatchDog* AwdGetWatchDog(enum AwdWatchdogType type)
{
    return &g_awdWatchdogMgr.awd[type];
}