/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_system_api.h"
#include "adiag_print.h"
#include "adiag_utils.h"
#include "trace_types.h"

STATIC int32_t g_timeDst; // daylight saving time

void *TraceDlopen(const char *libPath, int32_t mode)
{
    return mmDlopen(libPath, mode);
}

void *TraceDlsym(void *handle, const char *funcName)
{
    return mmDlsym(handle, funcName);
}

int32_t TraceDlclose(void *handle)
{
    return mmDlclose(handle);
}

int32_t TraceGetPid(void)
{
    return mmGetPid();
}

int32_t TraceRaise(int32_t signo)
{
#if defined _ADIAG_LLT_
    return 0;
#else
    return raise(signo);
#endif
}

int32_t TraceChmod(const char *dirPath, uint32_t mode)
{
    return chmod(dirPath, mode);
}

int32_t TraceChown(const char *dirPath, uint32_t uid, uint32_t gid)
{
    return chown(dirPath, uid, gid);
}

TraStatus TraceMkdir(const char *dirPath, uint32_t mode, uint32_t uid, uint32_t gid)
{
    ADIAG_CHK_NULL_PTR(dirPath, return TRACE_FAILURE);

    if (access(dirPath, F_OK) != 0) {
        if ((mkdir(dirPath, mode) != 0) && access(dirPath, F_OK) != 0) {
            return TRACE_FAILURE;
        }
        if (TraceChmod(dirPath, mode) != 0) {
            return TRACE_FAILURE;
        }
        if (TraceChown(dirPath, uid, gid) != 0) {
            return TRACE_FAILURE;
        }
    }

    return TRACE_SUCCESS;
}

int32_t TraceRmdir(const char *pathName)
{
    return mmRmdir(pathName);
}

int32_t TraceOpen(const char *filePath, int32_t flag, uint32_t mode)
{
    int32_t fd = open(filePath, flag, mode);
    if (fd >= 0) {
        (void)fchmod(fd, mode);
    }
    return fd;
}

void TraceClose(int32_t *fd)
{
    if ((fd == NULL) || (*fd < 0)) {
        return;
    }

    (void)close(*fd);
    *fd = -1;
}

/**
 * @brief      get string of env
 * @param[in]  env:       environment value obtained from the environment variable
 * @param[out] buf:       buffer to save string
 * @param[in]  len:       buffer length
 * @return     TraStatus
 */
TraStatus TraceHandleEnvString(const char *env, char *buf, uint32_t len)
{
    ADIAG_CHK_NULL_PTR(buf, return TRACE_FAILURE);
    if ((env == NULL) || (strlen(env) == 0U) || (strlen(env) > (size_t)len)) {
        ADIAG_WAR("Environment variable is null or the length exceeds %u.", len);
        return TRACE_FAILURE;
    }

    int32_t ret = strcpy_s(buf, (size_t)len, env);
    ADIAG_CHK_EXPR_ACTION(ret != EOK, return TRACE_FAILURE, "strcpy env string failed, ret=%d, strerr=%s.",
        ret, strerror(AdiagGetErrorCode()));
    return TRACE_SUCCESS;
}

int32_t TraceRealPath(const char *path, char *realPath, int32_t realPathLen)
{
    return mmRealPath(path, realPath, realPathLen);
}

int32_t TraceAccess(const char *path, int32_t mode)
{
    return mmAccess2(path, mode);
}

int32_t TraceCreateTaskWithThreadAttr(TraceThread *threadHandle, const TraceUserBlock *funcBlock,
    const TraceThreadAttr *threadAttr)
{
    return mmCreateTaskWithThreadAttr(threadHandle, funcBlock, threadAttr);
}

int32_t TraceJoinTask(TraceThread *threadHandle)
{
    return mmJoinTask(threadHandle);
}

int32_t TraceSetThreadName(const char *threadName)
{
    return mmSetCurrentThreadName(threadName);
}

int32_t TraceGetTimeOfDay(TraceTimeVal *timeVal, TraceTimeZone *timeZone)
{
    return mmGetTimeOfDay(timeVal, timeZone);
}

int32_t TraceLocalTimeR(const time_t *timep, struct tm *result)
{
    return mmLocalTimeR(timep, result);
}

int32_t TraceSocket(int32_t sockFamily, int32_t type, int32_t protocol)
{
    return mmSocket(sockFamily, type, protocol);
}

int32_t TraceBind(int32_t sockFd, TraceSockAddr *addr, size_t addrLen)
{
    return mmBind((mmSockHandle)sockFd, (mmSockAddr *)addr, (mmSocklen_t)addrLen);
}

int32_t TraceCloseSocket(int32_t sockFd)
{
    return mmCloseSocket((mmSockHandle)sockFd);
}

int32_t TraceConnect(int32_t sockFd, struct sockaddr *addr, size_t addrLen)
{
    return mmConnect((mmSockHandle)sockFd, (mmSockAddr *)addr, (mmSocklen_t)addrLen);
}

STATIC INLINE int32_t IsLeapYear(int32_t year)
{
    // years can be divisible by 4, but not by 100, or years can be divisible by 400
    return ((((year % 4) == 0) && ((year % 100) != 0)) || ((year % 400) == 0)) ? 1 : 0;
}

/**
 * @brief       get local time string from timestamp, must be reentrant, cannot print msg
 * @param [out] timeInfo:   local time struct
 * @param [in]  sec:        seconds from 1970/1/1
 * @param [in]  timeZone:   current time zone
 * @param [in]  dst:        daylight time
 * @return      void
 */
STATIC void CalLocalTime(struct tm *timeInfo, time_t sec, time_t timeZone, int32_t dst)
{
    const time_t oneMin = 60; // 1m: 60s
    const time_t oneHour = 3600; // 1h: 3600s
    const time_t oneDay = 86400; // 24h: 86400s
    const time_t oneYear = 365; // 365 days

    time_t realSec = sec - timeZone; // Adjust for timezone
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
 * @brief       init daylight saving time
 * @return      TraStatus
 */
TraStatus TraceTimeDstInit(void)
{
    TraceTimeVal timeVal = { 0, 0 };
    struct tm tmInfo;
    (void)memset_s(&tmInfo, sizeof(tmInfo), 0, sizeof(tmInfo));
    // sync time zone
    tzset();
    if (TraceGetTimeOfDay(&timeVal, NULL) != TRACE_SUCCESS) {
        ADIAG_ERR("get time of day failed, errno=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    const time_t sec = timeVal.tv_sec;
    if (TraceLocalTimeR(&sec, &tmInfo) != TRACE_SUCCESS) {
        ADIAG_ERR("get local time failed, errno=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }

    g_timeDst = tmInfo.tm_isdst;
    return TRACE_SUCCESS;
}

/**
 * @brief       get local time string from timestamp, must be reentrant, cannot print msg
 * @param [in]  timestamp:        timestamp
 * @param [out] buffer:           buffer to save timestamp str
 * @param [in]  bufSize:          size of buffer
 * @return      TraStatus
 */
TraStatus TimestampToStr(uint64_t timestamp, char *buffer, uint32_t bufSize)
{
    uint64_t tmpTime = (timestamp / SEC_TO_NS) & (uint64_t)LONG_MAX;
    time_t secTime = (time_t)tmpTime;
    uint64_t microTime = timestamp % SEC_TO_NS;
    struct tm now;
    CalLocalTime(&now, secTime, (time_t)timezone, g_timeDst);

    int32_t err = sprintf_s(buffer, bufSize, "%04ld-%02d-%02d %02d:%02d:%02d.%03llu.%03llu ",
        now.tm_year, now.tm_mon, now.tm_mday, now.tm_hour, now.tm_min, now.tm_sec,
        (microTime / TIME_ONE_THOUSAND_MS) / TIME_ONE_THOUSAND_MS,
        (microTime / TIME_ONE_THOUSAND_MS) % TIME_ONE_THOUSAND_MS);
    if (err == -1) {
        return TRACE_RING_BUFFER_SPRINTF_FAILED;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief       get local time string from timestamp, must be reentrant, cannot print msg
 * @param [in]  timestamp:        timestamp
 * @param [out] buffer:           buffer to save timestamp str
 * @param [in]  bufSize:          size of buffer
 * @return      TraStatus
 */
TraStatus TimestampToFileStr(uint64_t timestamp, char *buffer, uint32_t bufSize)
{
    uint64_t tmpTime = (timestamp / SEC_TO_NS) & (uint64_t)LONG_MAX;
    time_t secTime = (time_t)tmpTime;
    uint64_t microTime = timestamp % SEC_TO_NS;
    struct tm now;
    CalLocalTime(&now, secTime, (time_t)timezone, g_timeDst);

    int32_t err = sprintf_s(buffer, bufSize, "%04ld%02d%02d%02d%02d%02d%03llu%03llu",
        now.tm_year, now.tm_mon, now.tm_mday, now.tm_hour, now.tm_min, now.tm_sec,
        (microTime / TIME_ONE_THOUSAND_MS) / TIME_ONE_THOUSAND_MS,
        (microTime / TIME_ONE_THOUSAND_MS) % TIME_ONE_THOUSAND_MS);
    if (err == -1) {
        return TRACE_RING_BUFFER_SPRINTF_FAILED;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief       get the offset between local time and UTC
 * @param [out] offset:         offset, unit:minute
 * @return      TraStatus
 */
TraStatus TraceGetTimeOffset(int32_t *offset)
{
    TraceTimeVal tv = { 0 };
    struct tm localTime = { 0 };
 
    if (TraceGetTimeOfDay(&tv, NULL) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    time_t utcTime = tv.tv_sec;
    if (localtime_r(&utcTime, &localTime) == NULL) {
        return TRACE_FAILURE;
    }
    const int32_t secToMin = 60;
    *offset = (int32_t)(localTime.tm_gmtoff / secToMin);
    return TRACE_SUCCESS;
}