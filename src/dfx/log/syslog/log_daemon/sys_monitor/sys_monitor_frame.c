/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sys_monitor_frame.h"
#include <time.h>
#include "sys_monitor_print.h"
#include "sys_cpu_monitor.h"
#include "sys_memory_monitor.h"
#include "sys_monitor_common.h"
#include "sys_fd_monitor.h"
#include "sys_zp_monitor.h"
#include "log_error_code.h"
#include "log_time.h"
#include "log_system_api.h"
#include "log_common.h"

#define MONITOR_THREAD_STATUS_INIT          0
#define MONITOR_THREAD_STATUS_RUN           1
#define MONITOR_THREAD_STATUS_WAIT_EXIT     2
#define MONITOR_THREAD_STATUS_EXIT          3
#define MONITOR_TIME_NS_TO_MS               1000000
#define MONITOR_TIME_S_TO_MS                1000
#define MONITOR_TIME_US_TO_NS               1000
#define SYS_MONITOR_THREAD_ATTR             { 1, 0, 0, 0, 0, 1, 128 * 1024 } // Default ThreadSize(128KB)

STATIC uint32_t g_threadStatus = MONITOR_THREAD_STATUS_INIT;
STATIC SysmonitorInfo g_sysmonitorInfo[SYS_MONITOR_COUNT] = { 0 };

/**
 * @brief       : get the greatest common divisor of two numbers
 * @param [in]  : a       one number
 * @param [in]  : b       another number
 * @return      : greatest common divisor
 */
STATIC uint32_t SysmonitorGetCommonDivisor(uint32_t x, uint32_t y)
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

/**
 * @brief       : get the system resource monitor period
 * @return      : monitor period
 */
STATIC uint32_t SysmonitorResGetPeriod(void)
{
    uint32_t period = g_sysmonitorInfo[0].monitorPeriod;
    for (int32_t i = 1; i < (int32_t)SYS_MONITOR_COUNT; i++) {
        period = SysmonitorGetCommonDivisor(period, g_sysmonitorInfo[i].monitorPeriod);
    }
    MONITOR_RUN("system resource monitor start, period: %ums", period);
    return period;
}

/**
 * @brief       : try to start monitor every period
 * @param [in]  : period       monitor period
 */
STATIC void SysmonitorResItem(uint32_t period)
{
    for (int32_t i = 0; i < (int32_t)SYS_MONITOR_COUNT; i++) {
        g_sysmonitorInfo[i].monitorCount++;
        if (g_sysmonitorInfo[i].monitorCount * period >= g_sysmonitorInfo[i].monitorPeriod) {
            ONE_ACT_ERR_LOG(g_sysmonitorInfo[i].monitorFunc == NULL, continue, "monitor func %d is null", i);
            g_sysmonitorInfo[i].monitorFunc();
            g_sysmonitorInfo[i].monitorCount = 0;
        }
    }
}

/**
 * @brief       : init all monitors
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
STATIC int32_t SysmonitorResInit(void)
{
    ONE_ACT_WARN_LOG(g_threadStatus == MONITOR_THREAD_STATUS_RUN, return LOG_FAILURE,
        "please don't init while sys monitor is running");
    SysmonitorResInitCpu(&g_sysmonitorInfo[SYS_MONITOR_CPU]);
    SysmonitorResInitMem(&g_sysmonitorInfo[SYS_MONITOR_MEM]);
    SysmonitorResInitFd(&g_sysmonitorInfo[SYS_MONITOR_FD]);
    SysmonitorResInitZp(&g_sysmonitorInfo[SYS_MONITOR_ZP]);
    return LOG_SUCCESS;
}

STATIC void *SysmonitorResProcessThread(void *arg)
{
    (void)arg;
    NO_ACT_WARN_LOG(ToolSetThreadName("SysMonitor") != SYS_OK, "can not set thread name(SysMonitor).");

    uint32_t sysmonitorResPeriod = SysmonitorResGetPeriod();
    uint32_t sleepTime = 0;
    struct timespec start = { 0, 0 };
    struct timespec end = { 0, 0 };
    int64_t duration = 0;
    while (g_threadStatus == MONITOR_THREAD_STATUS_RUN) {
        (void)LogGetMonotonicTime(&start);
        SysmonitorResItem(sysmonitorResPeriod);
        (void)LogGetMonotonicTime(&end);
        duration = (int64_t)((end.tv_nsec - start.tv_nsec) / MONITOR_TIME_NS_TO_MS);
        duration += (int64_t)((end.tv_sec - start.tv_sec) * MONITOR_TIME_S_TO_MS);
        if (duration < 0) {
            duration = 0;
        }
        sleepTime = sysmonitorResPeriod;
        if ((uint32_t)duration >= sleepTime) {
            sleepTime = 0;
            MONITOR_LOGD("time record, start_sec:%ld, start_nsec:%ld, end_sec:%ld, end_nsec:%ld, duration:%ld",
                start.tv_sec, start.tv_nsec, end.tv_sec, end.tv_nsec, duration);
        } else {
            sleepTime = sysmonitorResPeriod - (uint32_t)duration;
        }
        (void)ToolSleep(sleepTime);
    }
    g_threadStatus = MONITOR_THREAD_STATUS_EXIT;
    return NULL;
}

/**
 * @brief       : create sys monitor thread
 * @return      : LOG_SUCCESS success; else fail
 */
STATIC int32_t SysmonitorResProcess(void)
{
    // start process
    g_threadStatus = MONITOR_THREAD_STATUS_RUN;
    ToolThread tid = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = SysmonitorResProcessThread;
    funcBlock.pulArg = (void *)NULL;
    ToolThreadAttr threadAttr = SYS_MONITOR_THREAD_ATTR;
    int32_t ret = ToolCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
    if (ret != LOG_SUCCESS) {
        g_threadStatus = MONITOR_THREAD_STATUS_WAIT_EXIT;
        MONITOR_LOGE("create thread failed, result=%d.", ret);
        return ret;
    }
    return ret;
}

/**
 * @brief       : init sys monitor
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
int32_t SysmonitorInit(void)
{
    return SysmonitorResInit();
}

/**
 * @brief       : start sys monitor process
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
int32_t SysmonitorProcess(void)
{
    return SysmonitorResProcess();
}

/**
 * @brief       : exit sys monitor process
 */
void SysmonitorExit(void)
{
    g_threadStatus = MONITOR_THREAD_STATUS_WAIT_EXIT;
}