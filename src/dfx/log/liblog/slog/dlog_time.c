/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dlog_time.h"
#include "dlog_common.h"
#include "log_time.h"

#if (OS_TYPE_DEF == LINUX)

#define INVALID_TIME_DST (-2) // invalid daylight saving time

STATIC int32_t g_timeDst = INVALID_TIME_DST;

/**
 * @brief GetTimeDst: get daylight saving time
 */
static int32_t GetTimeDst(void)
{
    if (g_timeDst != INVALID_TIME_DST) {
        return g_timeDst;
    }

    ToolTimeval timeVal = { 0, 0 };
    struct tm tmInfo;
    (void)memset_s(&tmInfo, sizeof(tmInfo), 0, sizeof(tmInfo));
    // sync time zone
    tzset();
    if (ToolGetTimeOfDay(&timeVal, NULL) != SYS_OK) {
        SELF_LOG_ERROR("get time of day failed, errno=%s.", strerror(ToolGetErrorCode()));
        return 0;
    }
    const time_t sec = timeVal.tvSec;
    if (ToolLocalTimeR(&sec, &tmInfo) != SYS_OK) {
        SELF_LOG_ERROR("get local time failed, errno=%s.", strerror(ToolGetErrorCode()));
        return 0;
    }
    g_timeDst = tmInfo.tm_isdst;
    return g_timeDst;
}

static inline int32_t IsLeapYear(int32_t year)
{
    // years can be divisible by 4, but not by 100, or years can be divisible by 400
    return ((((year % 4) == 0) && ((year % 100) != 0)) || ((year % 400) == 0)) ? 1 : 0;
}

/**
 * @brief CalLocalTime: calculate local time
 * @param [in/out]timeInfo: local time struct
 * @param [in]sec: seconds from 1970/1/1
 * @param [in]tzone: current time zone
 * @param [in]dst: daylight time
 * @return: void
 */
static void CalLocalTime(struct tm *timeInfo, time_t sec, time_t tzone, int32_t dst)
{
    const time_t oneMin = 60; // 1m: 60s
    const time_t oneHour = 3600; // 1h: 3600s
    const time_t oneDay = 86400; // 24h: 86400s
    const time_t oneYear = 365; // 365 days

    time_t realSec = sec - tzone; // Adjust for timezone
    realSec += oneHour * dst; // Adjust for daylight time
    time_t days = realSec / oneDay; // Days passed since epoch
    time_t seconds = realSec % oneDay; // Remaining seconds

    timeInfo->tm_isdst = dst;
    timeInfo->tm_hour = (int32_t)(seconds / oneHour);
    timeInfo->tm_min = (int32_t)((seconds % oneHour) / oneMin);
    timeInfo->tm_sec = (int32_t)((seconds % oneHour) % oneMin);

    // 1/1/1970 was a Thursday, that is, day 4 from the POV of the tm structure * where sunday = 0,
    // so to calculate the day of the week we have to add 4 * and take the modulo by 7.
    timeInfo->tm_wday = (int32_t)((days + 4) % 7); // start from Thursday
    // Calculate the current year
    timeInfo->tm_year = 1970; // start from 1970
    while (1) {
        // Leap years have one day more
        time_t yearDays = oneYear + (time_t)IsLeapYear(timeInfo->tm_year);
        if (yearDays > days) {
            break;
        }
        days -= yearDays;
        timeInfo->tm_year++;
    }
    timeInfo->tm_yday = (int32_t)days; // Number of day of the current year

    // We need to calculate in which month and day of the month we are. To do *,
    // so we need to skip days according to how many days there are in each * month,
    // and adjust for the leap year that has one more day in February.
    int32_t mDays[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}; // days of month: 31, 30, 28/29
    mDays[1] += IsLeapYear(timeInfo->tm_year); // leap year

    timeInfo->tm_mon = 0;
    while (days >= mDays[timeInfo->tm_mon]) {
        days -= mDays[timeInfo->tm_mon];
        timeInfo->tm_mon++;
    }

    timeInfo->tm_mon++; // Add 1 since our 'month' is zero-based
    timeInfo->tm_mday = (int32_t)days + 1; // Add 1 since our 'days' is zero-based
}

/**
 * @brief GetLocaltimeR: calculate local time
 * @param [in/out]timeInfo: local time struct
 * @param [in]sec: seconds from 1970/1/1
 * @return: LOG_SUCCESS/LOG_FAILURE
 */
STATIC LogStatus GetLocaltimeR(struct tm *timeInfo, time_t sec)
{
    ONE_ACT_NO_LOG(timeInfo == NULL, return LOG_FAILURE);
    CalLocalTime(timeInfo, sec, (int32_t)timezone, GetTimeDst());
    return LOG_SUCCESS;
}

int64_t DlogTimeDiff(const struct timespec *lastTv)
{
    if (lastTv == NULL) {
        return 0;
    }

    struct timespec currentTv = { 0, 0 };
    LogStatus result = LogGetMonotonicTime(&currentTv);
    ONE_ACT_WARN_LOG(result != LOG_SUCCESS, return 0, "can not get time, strerr=%s.", strerror(ToolGetErrorCode()));

    int64_t timeValue = (int64_t)((currentTv.tv_nsec - lastTv->tv_nsec) / NS_TO_MS);
    timeValue += (int64_t)((currentTv.tv_sec - lastTv->tv_sec) * S_TO_MS);
    return (timeValue > 0) ? timeValue : 0;
}

void DlogGetTime(char *timeStr, uint32_t length)
{
    ONE_ACT_ERR_LOG(timeStr == NULL, return, "[input] time is null.");
    struct timespec currentTimeval = { 0, 0 };
    static bool isTimeInit = false;
    static clockid_t clockId = LOG_CLOCK_ID_DEFAULT;
    ONE_ACT_ERR_LOG(LogGetTime(&currentTimeval, &isTimeInit, &clockId) != LOG_SUCCESS, return, "get log time failed.");

    struct tm timeInfo = { 0 };
    if (GetLocaltimeR(&timeInfo, currentTimeval.tv_sec) != LOG_SUCCESS) {
        SELF_LOG_ERROR("get local time failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return;
    }
    int32_t ret = snprintf_s(timeStr, length, length - 1U, "%04d-%02d-%02d-%02d:%02d:%02d.%03ld.%03ld",
                             timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday, timeInfo.tm_hour, timeInfo.tm_min,
                             timeInfo.tm_sec, (currentTimeval.tv_nsec / TIME_ONE_THOUSAND_MS) / TIME_ONE_THOUSAND_MS,
                             (currentTimeval.tv_nsec / TIME_ONE_THOUSAND_MS) % TIME_ONE_THOUSAND_MS);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf_s time failed, result=%d, strerr=%s.", \
                       ret, strerror(ToolGetErrorCode()));
    }
    return;
}

#else
int64_t DlogTimeDiff(const struct timespec *lastTv)
{
    ONE_ACT_ERR_LOG(lastTv == NULL, return 0, "[input] lastTv is null.");

    ToolTimeval currentTimeval = { 0, 0 };
    int32_t result = ToolGetTimeOfDay(&currentTimeval, NULL);
    ONE_ACT_WARN_LOG(result != 0, return 0, "can not get time of day, errno=%s.", strerror(ToolGetErrorCode()));

    int64_t timeValue = (int64_t)((currentTimeval.tvUsec * US_TO_NS - lastTv->tv_nsec) / NS_TO_MS);
    timeValue += (int64_t)((currentTimeval.tvSec - lastTv->tv_sec) * S_TO_MS);
    return (timeValue > 0) ? timeValue : 0;
}

void DlogGetTime(char *timeStr, uint32_t length)
{
    ToolTimeval currentTimeval = { 0, 0 };
    int32_t pid = ToolGetPid();
    struct tm timInfo;
    (void)memset_s(&timInfo, sizeof(timInfo), 0, sizeof(timInfo));
    ONE_ACT_ERR_LOG(timeStr == NULL, return, "[input] time is null.");

    // sync time zone
    tzset();
    if (ToolGetTimeOfDay(&currentTimeval, NULL) != SYS_OK) {
        SELF_LOG_ERROR("get time of day failed, errno=%s.", strerror(ToolGetErrorCode()));
        return;
    }
    const time_t sec = currentTimeval.tvSec;
    if (ToolLocalTimeR(&sec, &timInfo) != SYS_OK) {
        SELF_LOG_ERROR("get local time failed, errno=%s.", strerror(ToolGetErrorCode()));
        return;
    }

    int32_t err = snprintf_s(timeStr, length, length - 1, "%04d-%02d-%02d-%02d:%02d:%02d.%03ld.%03ld",
                             (timInfo.tm_year), timInfo.tm_mon, timInfo.tm_mday, timInfo.tm_hour, timInfo.tm_min,
                             timInfo.tm_sec, currentTimeval.tvUsec / TIME_ONE_THOUSAND_MS,
                             currentTimeval.tvUsec % TIME_ONE_THOUSAND_MS);
    if (err == -1) {
        SELF_LOG_ERROR("snprintf_s time failed, result=%d, strerr=%s.", err, strerror(ToolGetErrorCode()));
    }
    return;
}
#endif
