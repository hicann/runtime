/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sys_fd_monitor.h"
#include "sys_monitor_print.h"
#include "sys_monitor_common.h"
#include "log_error_code.h"
#include "log_system_api.h"
#include "log_file_info.h"
#include "log_common.h"

#define MONITOR_FD_FILE_PATH        "/proc/sys/fs/file-nr"
#define MONITOR_FD_ALARM_VALUE      90U         // 90%
#define MONITOR_FD_RESUME_VALUE     80U         // 80%
#define MONITOR_FD_MONITOR_PERIOD   10000U      // 10 seconds
#define MONITOR_FD_STAT_PERIOD      3600000U    // 1 hour
#define MONITOR_FD_SILENCE_PERIOD   60000U      // 1 minute
#define MONITOR_FD_ALARM_MAX        9U
#define MONITOR_FD_ZERO             0U
#define MONITOR_FD_NAME_MAX         64U
#define MONITOR_FD_DECIMAL          10
#define MONITOR_FD_TOP_NUM          3U
#define MONITOR_FD_PID_LENGTH       20U

typedef struct FdInfo {
    uint64_t cnt;
    uint64_t maxFdNum;
} FdInfo;

STATIC struct FdInfo g_fdInfo = { 0 };
STATIC SysmonitorInfo* g_sysmonitorFdInfo = NULL;
STATIC MonitorStatInfo g_fdStatInfo = { MONITOR_ONE_HUNDRED_FLOAT, 0.0, 0.0, 0, 0, 0 };
STATIC float g_fdTotalUsage = 0.0;
STATIC uint32_t g_fdMonitorTime = 0;

STATIC int32_t SysmonitorFdGetInfo(void)
{
    int32_t fd = ToolOpenWithMode(MONITOR_FD_FILE_PATH, O_RDONLY, LOG_FILE_ARCHIVE_MODE);
    if (fd < 0) {
        MONITOR_LOGE("open file with mode failed, file=%s, strerr=%s.",
            MONITOR_FD_FILE_PATH, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    char cntBuf[MONITOR_FD_NAME_MAX] = { 0 };
    int32_t ret = ToolRead(fd, cntBuf, MONITOR_FD_NAME_MAX);
    if (ret <= 0) {
        MONITOR_LOGE("read file failed, file=%s, strerr=%s.", MONITOR_FD_FILE_PATH, strerror(ToolGetErrorCode()));
        (void)ToolClose(fd);
        return LOG_FAILURE;
    }

    uint64_t nrFreeFiles;
    ret = sscanf_s(cntBuf, "%lu %lu %lu", &g_fdInfo.cnt, &nrFreeFiles, &g_fdInfo.maxFdNum);
    if (ret <= 0) {
        MONITOR_LOGE("sscanf_s file handle info failed, strerr=%s.", strerror(ToolGetErrorCode()));
        (void)ToolClose(fd);
        return LOG_FAILURE;
    }
    (void)ToolClose(fd);
    return LOG_SUCCESS;
}

/**
 * @brief           : get fd usage by fd info
 * @return          : fd usage
 */
STATIC float SysmonitorFdGetUsage(void)
{
    return (float)g_fdInfo.cnt * MONITOR_ONE_HUNDRED_FLOAT / (float)g_fdInfo.maxFdNum;
}

/**
 * @brief       : reset stat info after each stat
 */
STATIC void SysmonitorFdReset(void)
{
    g_sysmonitorFdInfo->alarmCount = 0;
    g_sysmonitorFdInfo->statCount = 0;
    g_fdStatInfo.avgUsage = 0.0;
    g_fdStatInfo.maxUsage = 0.0;
    g_fdStatInfo.minUsage = MONITOR_ONE_HUNDRED_FLOAT;
    g_fdStatInfo.alarmNum = 0;
    g_fdStatInfo.resumeNum = 0;
    g_fdStatInfo.duration = 0;
    g_fdTotalUsage = 0.0;
    g_fdMonitorTime = 0;
}

/**
 * @brief       : refresh stat info
 * @param [in]  : usage       current fd usage
 */
STATIC void SysmonitorFdRecordUsage(float usage)
{
    if (usage < g_fdStatInfo.minUsage) {
        g_fdStatInfo.minUsage = usage;
    }

    if (usage > g_fdStatInfo.maxUsage) {
        g_fdStatInfo.maxUsage = usage;
    }

    g_fdTotalUsage += usage;
    g_fdMonitorTime++;
    g_fdStatInfo.avgUsage = g_fdTotalUsage / (float)g_fdMonitorTime;
}

STATIC int32_t SysmonitorFdGetMinIndexOfArray(int32_t *array, uint32_t size)
{
    int32_t min = array[0];
    int32_t index = 0;
    for (uint32_t i = 1; i < size; i++) {
        if (array[i] < min) {
            min = array[i];
            index = (int32_t)i;
        }
    }
    return index;
}

/**
 * @brief       : judge if the number is in the array by traversing
 * @param [in]  : array     checked array
 * @param [in]  : size      size of numbers in array
 * @param [in]  : num       checked number
 * @return      : true  number in array; false  number not in array
 */
STATIC bool SysmonitorFdIsNumInArray(const uint32_t *array, uint32_t size, uint32_t num)
{
    for (uint32_t i = 0; i < size; i++) {
        if (array[i] == num) {
            return true;
        }
    }
    return false;
}

/**
 * @brief       : print the contents of the array in descending order of num
 * @param [in]  : pid      pid value array
 * @param [in]  : num      pid used number array
 * @param [in]  : size     array size
 */
STATIC void SysmonitorFdPrintTopMessage(const char (*pid)[MONITOR_FD_PID_LENGTH], const int32_t *num, uint32_t size)
{
    uint32_t usedNum[MONITOR_FD_TOP_NUM] = { 0 };
    for (uint32_t i = 0; i < size; ++i) {
        int32_t max = 0;
        for (uint32_t j = 0; j < size; ++j) {
            if (!SysmonitorFdIsNumInArray(usedNum, i, j) && num[j] > max) {
                max = num[j];
                usedNum[i] = j;
            }
        }
        MONITOR_RUN("pid: %s, fd used: %d", pid[usedNum[i]], num[usedNum[i]]);
    }
}

/**
 * @brief       : process command lsof executing result, record the values of top used pid num and used times
 * @param [in]  : fp         file pointer of popen executing result
 * @param [in]  : result     record executing result
 * @param [in]  : size       size of result
 */
STATIC void SysmonitorFdProcessTopResult(FILE *fp, char *result, size_t size)
{
    char pidTop[MONITOR_FD_TOP_NUM][MONITOR_FD_PID_LENGTH] = { 0 };
    int32_t numTop[MONITOR_FD_TOP_NUM] = { 0 };
    char pidCurrent[MONITOR_FD_PID_LENGTH] = { 0 };
    int32_t numCurrent = 0;
    while (fgets(result, size, fp) != NULL) {
        char *ptr = NULL;
        char *pid = strtok_s(result, "\t", &ptr);
        if (pid == NULL) {
            MONITOR_LOGE("strtok_s fd used times failed");
            return;
        }

        if (strncmp(pid, pidCurrent, MONITOR_FD_PID_LENGTH) == 0) {
            numCurrent++;
        } else {
            int32_t min = SysmonitorFdGetMinIndexOfArray(numTop, MONITOR_FD_TOP_NUM);
            if (numCurrent > numTop[min]) {
                numTop[min] = numCurrent;
                errno_t err = strncpy_s(pidTop[min], MONITOR_FD_PID_LENGTH, pidCurrent, strlen(pidCurrent));
                ONE_ACT_ERR_LOG(err != EOK, return, "strncpy_s pid failed, strerr=%s", strerror(ToolGetErrorCode()));
            }
            // set the result of this round as the current operation
            errno_t err = strncpy_s(pidCurrent, MONITOR_FD_PID_LENGTH, pid, strlen(pid));
            if (err != EOK) {
                MONITOR_LOGE("strncpy_s current pid failed, strerr=%s", strerror(ToolGetErrorCode()));
                return;
            }
            numCurrent = 1;
        }
    }

    // process the last pid
    int32_t min = SysmonitorFdGetMinIndexOfArray(numTop, MONITOR_FD_TOP_NUM);
    if (numCurrent > numTop[min]) {
        numTop[min] = numCurrent;
        errno_t err = strncpy_s(pidTop[min], MONITOR_FD_PID_LENGTH, pidCurrent, strlen(pidCurrent));
        ONE_ACT_ERR_LOG(err != EOK, return, "strncpy_s end pid failed, strerr=%s", strerror(ToolGetErrorCode()));
    }

    SysmonitorFdPrintTopMessage(pidTop, numTop, MONITOR_FD_TOP_NUM);
}

STATIC void SysmonitorFdProcessTopThree(void)
{
    const char command[] = { "/usr/sbin/lsof" };
    FILE *fp = popen(command, "r");
    ONE_ACT_ERR_LOG(fp == NULL, return, "print top three process failed, strerr=%s", strerror(ToolGetErrorCode()));

    char *result = (char *)LogMalloc(MONITOR_MESSAGE_MAX_SIZE);
    if (result == NULL) {
        MONITOR_LOGE("malloc result failed, strerr=%s", strerror(ToolGetErrorCode()));
        pclose(fp);
        return;
    }

    MONITOR_RUN("sysmonitor fd process top three");
    SysmonitorFdProcessTopResult(fp, result, MONITOR_MESSAGE_MAX_SIZE);

    pclose(fp);
    LogFree(result);
}

STATIC void SysmonitorFdProcessAlarm(float usage)
{
    MONITOR_RUN("fd total: %lu, used: %lu, fd usage alarm: %4.1f%%", g_fdInfo.maxFdNum, g_fdInfo.cnt, usage);
    SysmonitorFdProcessTopThree();
}

STATIC void SysmonitorFdProcessStat(void)
{
    const char statHead[] = {"fd usage stat:"};
    char *statInfo = (char *)LogMalloc(MONITOR_MESSAGE_MAX_SIZE);
    ONE_ACT_ERR_LOG(statInfo == NULL, return, "malloc stat info failed, strerr=%s", strerror(ToolGetErrorCode()));
    int32_t ret = sprintf_s(statInfo, MONITOR_MESSAGE_MAX_SIZE,
        "%s minUsage=%4.1f%%, maxUsage=%4.1f%%, avgUsage=%4.1f%%, alarmNum=%u, resumeNum=%u, duration=%ums",
        statHead, g_fdStatInfo.minUsage, g_fdStatInfo.maxUsage, g_fdStatInfo.avgUsage,
        g_fdStatInfo.alarmNum, g_fdStatInfo.resumeNum, g_fdStatInfo.duration * g_sysmonitorFdInfo->monitorPeriod);
    if (ret == -1) {
        MONITOR_LOGE("sprintf_s stat info failed");
        LogFree(statInfo);
        return;
    }
    MONITOR_LOGI("%s", statInfo);
    if (g_fdStatInfo.alarmNum != 0) {
        MONITOR_RUN("%s", statInfo);
    }
    LogFree(statInfo);
}

STATIC void SysmonitorFdProcessUsage(float usage)
{
    SysmonitorFdRecordUsage(usage);
    if ((usage >= g_sysmonitorFdInfo->alarmValue) && !g_sysmonitorFdInfo->thresholdFlag) {
        MONITOR_LOGI("fd total: %lu, used: %lu, fd usage alarm: %4.1f%%", g_fdInfo.maxFdNum, g_fdInfo.cnt, usage);
        g_sysmonitorFdInfo->thresholdFlag = true;
        if (g_sysmonitorFdInfo->silenceCount == MONITOR_SILENCE_DISABLE) {
            g_sysmonitorFdInfo->silenceCount = 0;
            if (g_sysmonitorFdInfo->alarmCount < g_sysmonitorFdInfo->alarmMaxCount) {
                SysmonitorFdProcessAlarm(usage);
                g_sysmonitorFdInfo->alarmCount++;
            }
        }
        g_fdStatInfo.alarmNum++;
    } else if ((usage < g_sysmonitorFdInfo->resumeValue) && g_sysmonitorFdInfo->thresholdFlag) {
        g_sysmonitorFdInfo->thresholdFlag = false;
        MONITOR_LOGI("fd total: %lu, used: %lu, usage resume: %4.1f%%", g_fdInfo.maxFdNum, g_fdInfo.cnt, usage);
        g_fdStatInfo.resumeNum++;
    }

    g_sysmonitorFdInfo->statCount++;

    if (g_sysmonitorFdInfo->thresholdFlag) {
        g_fdStatInfo.duration++;
    }

    if (g_sysmonitorFdInfo->silenceCount != MONITOR_SILENCE_DISABLE) {
        g_sysmonitorFdInfo->silenceCount++;
    }

    if ((g_sysmonitorFdInfo->silenceCount >= 0) &&
        (((uint32_t)g_sysmonitorFdInfo->silenceCount * g_sysmonitorFdInfo->monitorPeriod) >=
        g_sysmonitorFdInfo->silencePeriod)) {
        g_sysmonitorFdInfo->silenceCount = MONITOR_SILENCE_DISABLE;
    }

    if ((g_sysmonitorFdInfo->statCount * g_sysmonitorFdInfo->monitorPeriod) >= g_sysmonitorFdInfo->statPeriod) {
        // print stat info
        SysmonitorFdProcessStat();
        // reset stat info
        SysmonitorFdReset();
    }
}

STATIC void SysmonitorFd(void)
{
    // 1.get file handle information
    errno_t err = memset_s(&g_fdInfo, sizeof(struct FdInfo), 0, sizeof(struct FdInfo));
    if (err != EOK) {
        MONITOR_LOGE("memset_s fd info failed, err=%d, strerr=%s", err, strerror(ToolGetErrorCode()));
        return;
    }
    int32_t ret = SysmonitorFdGetInfo();
    if (ret != 0 || g_fdInfo.cnt == 0 || g_fdInfo.maxFdNum == 0) {
        return;
    }

    // 2.calculate file handle usage
    float usage = SysmonitorFdGetUsage();
    
    // 3.disposal file handle information
    SysmonitorFdProcessUsage(usage);
}

void SysmonitorResInitFd(SysmonitorInfo* info)
{
    info->alarmValue = MONITOR_FD_ALARM_VALUE;
    info->resumeValue = MONITOR_FD_RESUME_VALUE;
    info->monitorCount = MONITOR_FD_ZERO;
    info->monitorPeriod = MONITOR_FD_MONITOR_PERIOD;
    info->statCount = MONITOR_FD_ZERO;
    info->statPeriod = MONITOR_FD_STAT_PERIOD;
    info->alarmCount = MONITOR_FD_ZERO;
    info->alarmMaxCount = MONITOR_FD_ALARM_MAX;
    info->silenceCount = MONITOR_SILENCE_DISABLE;
    info->silencePeriod = MONITOR_FD_SILENCE_PERIOD;
    info->thresholdFlag= false;
    info->monitorFunc = SysmonitorFd;
    g_sysmonitorFdInfo = info;
}