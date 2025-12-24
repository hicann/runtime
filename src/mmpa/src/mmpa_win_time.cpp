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
#if __cplusplus
extern "C" {
#endif /* __cpluscplus */
#endif /* __cpluscplus */

const INT32 MMPA_MSEC_TO_USEC = 1000;
const INT32 MMPA_SECOND_TO_MSEC = 1000;
const INT32 MMPA_MSEC_TO_NSEC = 1000000;

/*
 * 描述:获取本地时间
 * 参数:sysTime -- 指向mmSystemTime_t 结构的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetLocalTime(mmSystemTime_t *sysTimePtr)
{
    if (sysTimePtr == nullptr) {
        return EN_INVALID_PARAM;
    } else {
        GetLocalTime(sysTimePtr);
    }
    return EN_OK;
}

/*
 * 描述:获取系统时间
 * 参数:sysTime -- 指向mmSystemTime_t 结构的指针
 * 返回值:执行成功返回EN_OK, 执行错误返回EN_ERROR, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmGetSystemTime(mmSystemTime_t *sysTimePtr)
{
    if (sysTimePtr == nullptr) {
        return EN_INVALID_PARAM;
    } else {
        GetSystemTime(sysTimePtr);
    }
    return EN_OK;
}

/*
 * 描述:睡眠指定时间
 * 参数:milliSecond -- 睡眠时间 单位ms
 * 返回值:执行成功返回EN_OK, 入参检查错误返回EN_INVALID_PARAM
 */
INT32 mmSleep(UINT32 milliSecond)
{
    if (milliSecond == MMPA_ZERO) {
        return EN_INVALID_PARAM;
    }

    Sleep((DWORD)milliSecond);
    return EN_OK;
}

/*
 * 描述:获取当前系统时间和时区信息, windows不支持时区获取
 * 参数:timeVal--当前系统时间, 不能为nullptr
        timeZone--当前系统设置的时区信息, 可以为nullptr, 表示不需要获取时区信息
 * 返回值:执行成功返回EN_OK, 失败返回EN_ERROR，入参错误返回EN_INVALID_PARAM
 */
INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone)
{
    struct tm nowTime;
    SYSTEMTIME sysTime;
    if (timeVal == nullptr) {
        return EN_INVALID_PARAM;
    }
    GetLocalTime(&sysTime);
    nowTime.tm_year = sysTime.wYear - MMPA_COMPUTER_BEGIN_YEAR;
    // tm.tm_mon is [0, 11], wtm.wMonth is [1, 12]
    nowTime.tm_mon = sysTime.wMonth - 1;
    nowTime.tm_mday = sysTime.wDay;
    nowTime.tm_hour = sysTime.wHour;
    nowTime.tm_min = sysTime.wMinute;
    nowTime.tm_sec = sysTime.wSecond;

    nowTime.tm_isdst = SUMMER_TIME_OR_NOT;
    // 将时间转换为自1970年1月1日以来逝去时间的秒数
    time_t seconds = mktime(&nowTime);
    if (seconds == EN_ERROR) {
        return EN_ERROR;
    }
    timeVal->tv_sec = seconds;
    timeVal->tv_usec = sysTime.wMilliseconds * MMPA_MSEC_TO_USEC;

    return EN_OK;
}

/*
 * 描述:获取系统开机到现在经过的时间
 * 返回值:执行成功返回类型mmTimespec结构的时间
 */
mmTimespec mmGetTickCount()
{
    mmTimespec rts;
    ULONGLONG milliSecond = GetTickCount64();
    rts.tv_sec = (MM_LONG)milliSecond / MMPA_SECOND_TO_MSEC;
    rts.tv_nsec = (MM_LONG)(milliSecond % MMPA_SECOND_TO_MSEC) * MMPA_MSEC_TO_NSEC;
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
    INT32 ret = EN_OK;
    if (timep == nullptr || result == nullptr) {
        ret = EN_INVALID_PARAM;
    } else {
        time_t time = *timep;
        struct tm nowtTime;
        if (localtime_s(&nowtTime, &time) != MMPA_ZERO) {
            return EN_ERROR;
        }
        result->tm_year = nowtTime.tm_year + MMPA_COMPUTER_BEGIN_YEAR;
        result->tm_mon = nowtTime.tm_mon + 1;
        result->tm_mday = nowtTime.tm_mday;
        result->tm_hour = nowtTime.tm_hour;
        result->tm_min = nowtTime.tm_min;
        result->tm_sec = nowtTime.tm_sec;
    }
    return ret;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */

