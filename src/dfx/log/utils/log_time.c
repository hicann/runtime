/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_time.h"
#include <stdio.h>
#include <sys/file.h>
#include "log_print.h"
#include "log_system_api.h"

#ifdef GETCLOCK_VIRTUAL
#ifndef BOOTARGS_FILE_PATH
#define BOOTARGS_FILE_PATH      "/proc/cmdline"
#endif
#define BOOTARGS_MAX_SIZE       1024U
#define LOG_DP_CLOCK            "dpclk=100"

/**
 * @brief           : get clock id from BOOTARGS_FILE_PATH
 * @param [in/out]  : clockId      clock id
 * @return          : LOG_SUCCESS: success, others: failure
 */
STATIC LogStatus LogGetDpClock(clockid_t *clockId)
{
    int32_t fd = ToolOpen(BOOTARGS_FILE_PATH, O_RDONLY);
    ONE_ACT_WARN_LOG(fd < 0, return LOG_SUCCESS,
                     "bootargs file is not exist, use default clock id, file=%s.", BOOTARGS_FILE_PATH);
    char bootargs[BOOTARGS_MAX_SIZE + 1U] = { 0 };
    int32_t len = ToolRead(fd, bootargs, BOOTARGS_MAX_SIZE);
    LOG_CLOSE_FD(fd);
    ONE_ACT_WARN_LOG(len == 0, return LOG_SUCCESS, "bootargs file is null, use default clock id, strerr=%s.",
                     strerror(ToolGetErrorCode()));

    const char *target = strstr(bootargs, LOG_DP_CLOCK);
    if (target != NULL) {
        *clockId = LOG_CLOCK_ID_0;
    } else {
        *clockId = LOG_CLOCK_ID_100;
    }
    SELF_LOG_INFO("get clock id success, clock id = %d, pid = %d.", (int32_t)(*clockId), ToolGetPid());
    return LOG_SUCCESS;
}

/**
 * @brief           : get time
 * @param [in/out]  : currentTimeval      current time
 * @param [in/out]  : isInit              clock id init flag
 * @param [in/out]  : clockId             clock id
 * @return          : LOG_SUCCESS: success, others: failure
 */
LogStatus LogGetTime(struct timespec *currentTimeval, bool *isInit, clockid_t *clockId)
{
    ONE_ACT_ERR_LOG(currentTimeval == NULL, return LOG_FAILURE, "input timeval is null.");
    ONE_ACT_ERR_LOG(isInit == NULL, return LOG_FAILURE, "input init flag is null.");
    ONE_ACT_ERR_LOG(clockId == NULL, return LOG_FAILURE, "input clockId is null.");
    if ((!(*isInit)) && (LogGetDpClock(clockId) == LOG_SUCCESS)) {
        *isInit = true;
    }
    if (clock_gettime(*clockId, currentTimeval) != SYS_OK) {
        SELF_LOG_ERROR("get time failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

#else
/**
 * @brief           : get time
 * @param [in/out]  : currentTimeval      current time
 * @param [in/out]  : isInit              clock id init flag
 * @param [in/out]  : clockId             clock id
 * @return          : LOG_SUCCESS: success, others: failure
 */
LogStatus LogGetTime(struct timespec *currentTimeval, bool *isInit, clockid_t *clockId)
{
    ONE_ACT_ERR_LOG(currentTimeval == NULL, return LOG_FAILURE, "input timeval is null.");
    ONE_ACT_ERR_LOG(isInit == NULL, return LOG_FAILURE, "input init flag is null.");
    ONE_ACT_ERR_LOG(clockId == NULL, return LOG_FAILURE, "input clockId is null.");
    ToolTimeval timeval = { 0, 0 };
    if (ToolGetTimeOfDay(&timeval, NULL) != SYS_OK) {
        SELF_LOG_ERROR("get time of day failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    currentTimeval->tv_sec = timeval.tvSec;
    currentTimeval->tv_nsec = timeval.tvUsec * US_TO_MS_SIGNED;
    return LOG_SUCCESS;
}
#endif

/**
 * @brief           : get MONOTONIC time, absolute time, which cannot be changed
 * @param [in/out]  : currentTimeval      current time
 * @return          : LOG_SUCCESS: success, others: failure
 */
LogStatus LogGetMonotonicTime(struct timespec *currentTimeval)
{
    ONE_ACT_ERR_LOG(currentTimeval == NULL, return LOG_FAILURE, "input timeval is null.");
    if (clock_gettime(CLOCK_MONOTONIC_RAW, currentTimeval) != EOK) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

LogStatus LogGetTimeStr(char *timeStr, uint32_t len)
{
    ONE_ACT_ERR_LOG((timeStr == NULL) || (len < TIME_STR_SIZE), return LOG_FAILURE,
        "get time str failed, input is invalid.");
    struct timespec currentTimeval = { 0, 0 };
    static bool isTimeInit = false;
    static clockid_t clockId = LOG_CLOCK_ID_DEFAULT;
    ONE_ACT_ERR_LOG(LogGetTime(&currentTimeval, &isTimeInit, &clockId) != LOG_SUCCESS, return LOG_FAILURE,
                    "get log time failed.");
    struct tm timeInfo = { 0 };
    if (ToolLocalTimeR((&currentTimeval.tv_sec), &timeInfo) != SYS_OK) {
        SELF_LOG_ERROR("get local time failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    int32_t ret = snprintf_s(timeStr, len, (size_t)len - 1U, "%04d%02d%02d%02d%02d%02d%03ld",
        timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday, timeInfo.tm_hour,
        timeInfo.tm_min, timeInfo.tm_sec, currentTimeval.tv_nsec / MS_TO_NS);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s time buffer failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

/**
 * @brief       get monotonic time, absolute time, which cannot be changed
 * @return      monotonic time, ns
 */
STATIC uint64_t GetMonotonicTime(void)
{
    struct timespec now = {0, 0};
    (void)clock_gettime(CLOCK_MONOTONIC_RAW, &now);
    return ((uint64_t)now.tv_sec * SEC_TO_NS) + (uint64_t)now.tv_nsec;
}

/**
 * @brief       get cpu frequency
 * @return      cpu frequency, kHz
 */
uint64_t LogGetCpuFrequency(void)
{
    static uint64_t freq = UINT64_MAX;
    if (freq == UINT64_MAX) {
        uint64_t startTime = GetMonotonicTime();
        uint64_t startCycle = LogGetCpuCycleCounter();
        (void)usleep(US_TO_MS); // sleep 1ms
        uint64_t endCycle = LogGetCpuCycleCounter();
        uint64_t endTime = GetMonotonicTime();
        if ((endCycle - startCycle != 0) && (endTime - startTime != 0)) {
            freq = (endCycle - startCycle) * FREQ_GHZ_TO_KHZ / (endTime - startTime);
        }
    }
    return freq;
}

/**
 * @brief       get cycle counter
 * @return      cpu cycles
 */
uint64_t LogGetCpuCycleCounter(void)
{
    uint64_t cycles;
#ifdef CPU_CYCLE_NO_SUPPORT
    cycles = 0; // just for tiny compile(without mrrc), will not be executed when running
#else
#if defined(__aarch64__)
    asm volatile("mrs %0, cntvct_el0" : "=r" (cycles));
#elif defined(__x86_64__)
    const int uint32Bits = 32;  // 32 is uint bit count
    uint32_t hi = 0;
    uint32_t lo = 0;
    __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
    cycles = ((uint64_t)lo) | (((uint64_t)hi) << uint32Bits);
#elif defined(__arm__)
    const int uint32Bits = 32;  // 32 is uint bit count
    uint32_t hi = 0;
    uint32_t lo = 0;
    asm volatile("mrrc p15, 1, %0, %1, c14" : "=r"(lo), "=r"(hi));
    cycles = ((uint64_t)lo) | (((uint64_t)hi) << uint32Bits);
#else
    cycles = 0;
#endif
#endif // CPU_CYCLE_NO_SUPPORT
    return cycles;
}