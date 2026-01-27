/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mmpa_api.h"

#ifdef __cplusplus
#if    __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif

#define MMPA_MSEC_TO_USEC                       1000
#define MMPA_MAX_SLEEP_MILLSECOND_USING_USLEEP  1000
#define MMPA_MAX_SLEEP_MICROSECOND_USING_USLEEP 1000000

/*
 * 描述:获取本地时间
 * 参数: sysTimePtr -- 指向mmSystemTime_t 结构的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetLocalTime(mmSystemTime_t *sysTimePtr)
{
    if (sysTimePtr == NULL) {
        return EN_INVALID_PARAM;
    }

    struct timeval timeVal;
    (VOID)memset_s(&timeVal, sizeof(timeVal), 0, sizeof(timeVal)); /* unsafe_function_ignore: memset */

    INT32 ret = gettimeofday(&timeVal, NULL);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    struct tm nowTime;
    (VOID)memset_s(&nowTime, sizeof(nowTime), 0, sizeof(nowTime)); /* unsafe_function_ignore: memset */

    const struct tm *tmp = localtime_r(&timeVal.tv_sec, &nowTime);
    if (tmp == NULL) {
        return EN_ERROR;
    }

    sysTimePtr->wSecond = nowTime.tm_sec;
    sysTimePtr->wMinute = nowTime.tm_min;
    sysTimePtr->wHour = nowTime.tm_hour;
    sysTimePtr->wDay = nowTime.tm_mday;
    sysTimePtr->wMonth = nowTime.tm_mon + 1; // in localtime month is [0, 11], but in fact month is [1, 12]
    sysTimePtr->wYear = nowTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
    sysTimePtr->wDayOfWeek = nowTime.tm_wday;
    sysTimePtr->tm_yday = nowTime.tm_yday;
    sysTimePtr->tm_isdst = nowTime.tm_isdst;
    sysTimePtr->wMilliseconds = timeVal.tv_usec / MMPA_MSEC_TO_USEC;

    return EN_OK;
}

/*
 * 描述:获取系统时间
 * 参数:sysTime -- 指向mmSystemTime_t 结构的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetSystemTime(mmSystemTime_t *sysTimePtr)
{
    if (sysTimePtr == NULL) {
        return EN_INVALID_PARAM;
    }

    struct timeval timeVal;
    (VOID)memset_s(&timeVal, sizeof(timeVal), 0, sizeof(timeVal)); /* unsafe_function_ignore: memset */

    INT32 ret = gettimeofday(&timeVal, NULL);
    if (ret != EN_OK) {
        return EN_ERROR;
    }

    struct tm nowTime;
    (VOID)memset_s(&nowTime, sizeof(nowTime), 0, sizeof(nowTime)); /* unsafe_function_ignore: memset */

    const struct tm *tmp = gmtime_r(&timeVal.tv_sec, &nowTime);
    if (tmp == NULL) {
        return EN_ERROR;
    }

    sysTimePtr->wSecond = nowTime.tm_sec;
    sysTimePtr->wMinute = nowTime.tm_min;
    sysTimePtr->wHour = nowTime.tm_hour;
    sysTimePtr->wDay = nowTime.tm_mday;
    sysTimePtr->wMonth = nowTime.tm_mon + 1; // in localtime month is [0, 11], but in fact month is [1, 12]
    sysTimePtr->wYear = nowTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
    sysTimePtr->wDayOfWeek = nowTime.tm_wday;
    sysTimePtr->tm_yday = nowTime.tm_yday;
    sysTimePtr->tm_isdst = nowTime.tm_isdst;
    sysTimePtr->wMilliseconds = timeVal.tv_usec / MMPA_MSEC_TO_USEC;

    return EN_OK;
}

/*
 * 描述:睡眠指定时间
 * 参数: milliSecond -- 睡眠时间 单位ms, linux下usleep函数microSecond入参必须小于1000000
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSleep(UINT32 milliSecond)
{
    if (milliSecond == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }
    UINT32 microSecond;

    // 防止截断
    if (milliSecond <= MMPA_MAX_SLEEP_MILLSECOND_USING_USLEEP) {
        microSecond = milliSecond * (UINT32)MMPA_MSEC_TO_USEC;
    } else {
        microSecond = MMPA_MAX_SLEEP_MICROSECOND_USING_USLEEP;
    }

    INT32 ret = usleep(microSecond);
    if (ret != EN_OK) {
        return EN_ERROR;
    }
    return EN_OK;
}

/*
 * 描述:获取当前系统时间和时区信息, windows不支持时区获取
 * 参数:timeVal--当前系统时间, 不能为NULL
 *      timeZone--当前系统设置的时区信息, 可以为NULL, 表示不需要获取时区信息
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR，入参错误返回EN_INVALID_PARAM
 */
INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    if (timeVal == NULL) {
        return EN_INVALID_PARAM;
    }
    INT32 ret = gettimeofday((struct timeval *)timeVal, (struct timezone *)timeZone);
    if (ret != EN_OK) {
        ret = EN_ERROR;
    }
    return ret;
}

/*
 * 描述:获取系统开机到现在经过的时间
 * 返回值:执行成功返回类型mmTimespec结构的时间
 */
mmTimespec mmGetTickCount(VOID)
{
    mmTimespec rts = {0};
    struct timespec ts = {0};
    (VOID)clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    rts.tv_sec = ts.tv_sec;
    rts.tv_nsec = ts.tv_nsec;
    return rts;
}

/*
 * 描述:转换时间为本地时间格式
 * 参数:timep--待转换的time_t类型的时间
 *      result--struct tm格式类型的时间
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmLocalTimeR(const time_t *timep, struct tm *result)
{
    if ((timep == NULL) || (result == NULL)) {
        return EN_INVALID_PARAM;
    } else {
        time_t ts = *timep;
        struct tm nowTime = {0};
        const struct tm *tmp = localtime_r(&ts, &nowTime);
        if (tmp == NULL) {
            return EN_ERROR;
        }

        result->tm_year = nowTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
        result->tm_mon = nowTime.tm_mon + 1;
        result->tm_mday = nowTime.tm_mday;
        result->tm_hour = nowTime.tm_hour;
        result->tm_min = nowTime.tm_min;
        result->tm_sec = nowTime.tm_sec;
    }
    return EN_OK;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

