/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "awatchdog_monitor.h"
#include "adiag_list.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "awatchdog.h"
#include "awatchdog_core.h"
#include "mmpa_api.h"

#define MAX_TIMEOUT_COUNT 0xFFFFFFF
#define AWD_DEFAULT_MONITOR_PERIOD 200000U // 200ms, must be smaller than 1s
#define MAX_THREAD_TASK_PATH_LENGTH 50U
#define ADIAG_NS_TO_US 1000U
#define ADIAG_US_TO_MS 1000U
#define ADIAG_MS_TO_S 1000U
#define AWD_THREAD_STACK_SIZE     128 * 1024

typedef struct AwdMonitorInfo {
    uint32_t watchdogCount;           // monitor loop count
    uint32_t watchdogPeriod;          // watchdogCount * 最大公约数 <= watchdogPeriod，相等时，watchdogCount 归零，执行一次监控
    void (*watchdogFunc)(void);
} AwdMonitorInfo;

#define THREAD_STATUS_INIT          0
#define THREAD_STATUS_RUN           1
#define THREAD_STATUS_WAIT_EXIT     2

static AwdMonitorInfo g_awdMonitorInfo[AWD_WATCHDOG_TYPE_MAX] = {{0}};
static int32_t g_awdMonitorThreadStatus = THREAD_STATUS_INIT;
static uint32_t g_awdMonitorResPeriod = AWD_DEFAULT_MONITOR_PERIOD;
static mmThread g_awdMonitorThreadId = 0;

STATIC INLINE uint32_t AwdGetWatchDogModuleId(uint32_t dogId)
{
    return (dogId & (((uint32_t)1U << WATCHDOG_TYPE_BIT) - 1U));
}

// Maximum common divisor
STATIC INLINE uint32_t AwdMonitorGetCommonDivisor(uint32_t x, uint32_t y)
{
    uint32_t a = x;
    uint32_t b = y;
    while (a != b) {
        if (a > b) {
            a = a - b;
        } else {
            b = b - a;
        }
    }
    return a;
}

STATIC INLINE void AwdMonitorGetPeriod(void)
{
    uint32_t temp = g_awdMonitorInfo[0].watchdogPeriod;
    for (int32_t i = 0; i < (int32_t)AWD_WATCHDOG_TYPE_MAX; i++) {
        temp = AwdMonitorGetCommonDivisor(temp, g_awdMonitorInfo[i].watchdogPeriod);
        ADIAG_DBG("watchdog %d, period %u, resPeriod %u", i, g_awdMonitorInfo[i].watchdogPeriod, temp);
    }
    g_awdMonitorResPeriod = temp;
}

STATIC INLINE void AwdMonitorResItem(void)
{
    for (int32_t i = 0; i < (int32_t)AWD_WATCHDOG_TYPE_MAX; i++) {
        g_awdMonitorInfo[i].watchdogCount++;
        if (g_awdMonitorInfo[i].watchdogCount * g_awdMonitorResPeriod >= g_awdMonitorInfo[i].watchdogPeriod) {
            g_awdMonitorInfo[i].watchdogFunc();
            g_awdMonitorInfo[i].watchdogCount = 0;
        }
    }
}

STATIC void *AwdMonitorProcess(void *arg)
{
    (void)arg;
    AwdMonitorGetPeriod();
    const uint32_t period = g_awdMonitorResPeriod;
    uint64_t start = GetRealTime() / ADIAG_NS_TO_US;
    uint64_t end;
    uint32_t sleepTime;
    (void)mmSetCurrentThreadName("WatchdogMonitor");
    while (g_awdMonitorThreadStatus == THREAD_STATUS_RUN) {
        AwdMonitorResItem();
        end = GetRealTime() / ADIAG_NS_TO_US;
        uint32_t duration = (uint32_t)(end - start);
        if (duration >= period) {
            static bool warningFlag = true;
            if (warningFlag) {
                ADIAG_WAR("awd monitor res period %uus is less than process duration %uus, may need to be increased",
                    period, duration);
                warningFlag = false;
            }
            start = start + duration;
            continue;
        }
        sleepTime = period - duration;
        (void)usleep(sleepTime);
        start = start + sleepTime;
    }
    AwdWatchDog *awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
    (void)AdiagListDestroy(&awd->runList);
    (void)AdiagListDestroy(&awd->newList);
    return NULL;
}

STATIC INLINE AwdStatus AwdCreateMonitorThread(void)
{
    mmUserBlock_t thread;
    thread.procFunc = AwdMonitorProcess;
    thread.pulArg = NULL;
    mmThreadAttr attr = { 0, 0, 0, 0, 0, 0, AWD_THREAD_STACK_SIZE };
    mmThread tid = 0;
    if (mmCreateTaskWithThreadAttr(&tid, &thread, &attr) != 0) {
        ADIAG_ERR("create task failed, strerr=%s.", strerror(errno));
        return AWD_FAILURE;
    }
    g_awdMonitorThreadId = tid;
    ADIAG_INF("create monitor thread successfully, tid :%ld ", tid);
    return AWD_SUCCESS;
}

STATIC INLINE bool CheckThreadExist(AwdThreadWatchdog *node)
{
    char dir[MAX_THREAD_TASK_PATH_LENGTH] = {0};
    int ret = sprintf_s(dir, MAX_THREAD_TASK_PATH_LENGTH, "/proc/%d/task/%d", node->pid, node->tid);
    if (ret == -1) {
        ADIAG_ERR("sprintf thread dir failed", strerror(errno));
        return true;
    }
    if (access(dir, F_OK) != 0) {
        return false;
    }
    return true;
}

STATIC void AwdProcessTimeout(AwdThreadWatchdog *node)
{
    AWD_ATOMIC_TEST_AND_SET(&node->startCount, AWD_STATUS_INIT);
    // record timeout log to run info
    ADIAG_RUN_INF("watchdog timeout, moduleId %u, timeout : %us", AwdGetWatchDogModuleId(node->dogId), node->timeout);
    if (node->callback != NULL) {
        node->callback(NULL);
    }
}

STATIC AdiagStatus AwdMonitorThreadWatchdogPro(void *data)
{
    AwdThreadWatchdog *node = (AwdThreadWatchdog *)data;
    int32_t startCount = node->startCount;
    if (!CheckThreadExist(node)) {
        ADIAG_DBG("thread %d does not exist", node->tid);
        AWD_ATOMIC_TEST_AND_SET(&node->startCount, AWD_STATUS_DESTROYED);
        return AWD_SUCCESS;
    }
    if (startCount == AWD_STATUS_INIT) {
        return AWD_SUCCESS;
    }
    // process runCount
    int32_t runCount = node->runCount + 1;
    if (runCount == MAX_TIMEOUT_COUNT) {
        runCount = 0;
    }
    AWD_ATOMIC_TEST_AND_SET(&node->runCount, runCount);
    // calculate duration time
    uint64_t duration;
    if (runCount < startCount) {
        duration = (uint64_t)runCount + (uint64_t)MAX_TIMEOUT_COUNT - (uint64_t)startCount;
    } else {
        duration = (uint64_t)runCount - (uint64_t)startCount;
    }
    // add 1 second to compensate the time of start
    duration = (duration + 1U) * (uint64_t)g_awdMonitorInfo[AWD_WATCHDOG_TYPE_THREAD].watchdogPeriod / ADIAG_US_TO_MS;
    if (duration / ADIAG_MS_TO_S >= node->timeout) {
        AwdProcessTimeout(node);
    }
    return AWD_SUCCESS;
}

STATIC INLINE AdiagStatus CheckNodeDestroyed(const void *nodeData, const void *data)
{
    (void)data;
    const AwdThreadWatchdog *dog = (const AwdThreadWatchdog *)nodeData;
    if (dog->startCount == AWD_STATUS_DESTROYED) {
        return ADIAG_SUCCESS;
    }
    return ADIAG_FAILURE;
}

STATIC INLINE void AwdMonitorThreadWatchdog(void)
{
    AwdWatchDog *awd = AwdGetWatchDog(AWD_WATCHDOG_TYPE_THREAD);
    // move watchdog node from newList to runList
    AdiagListMove(&awd->newList, &awd->runList);

    (void)AdiagListClearAndProcessNoLock(&awd->runList, CheckNodeDestroyed, NULL, AwdMonitorThreadWatchdogPro);
}

void AwdMonitorReset(void)
{
    g_awdMonitorThreadStatus = THREAD_STATUS_WAIT_EXIT;
}

void AwdMonitorInit(void)
{
    g_awdMonitorInfo[AWD_WATCHDOG_TYPE_THREAD].watchdogPeriod = AWD_DEFAULT_MONITOR_PERIOD;
    g_awdMonitorInfo[AWD_WATCHDOG_TYPE_THREAD].watchdogCount = 0;
    g_awdMonitorInfo[AWD_WATCHDOG_TYPE_THREAD].watchdogFunc = AwdMonitorThreadWatchdog;

    g_awdMonitorThreadStatus = THREAD_STATUS_RUN;
    AwdStatus ret = AwdCreateMonitorThread();
    if (ret != AWD_SUCCESS) {
        g_awdMonitorThreadId = 0;
        ADIAG_ERR("Create monitor thread failed");
        return;
    }
    ADIAG_INF("AwdMonitorInit");
}

void AwdMonitorExit(void)
{
    if (g_awdMonitorThreadStatus != THREAD_STATUS_RUN) {
        return;
    }
    ADIAG_INF("AwdMonitorExit");
    g_awdMonitorThreadStatus = THREAD_STATUS_WAIT_EXIT;
    if (g_awdMonitorThreadId != 0) {
        (void)mmJoinTask(&g_awdMonitorThreadId);
        g_awdMonitorThreadId = 0;
    }
}