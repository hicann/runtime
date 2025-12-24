/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sys_memory_monitor.h"
#include "sys_monitor_print.h"
#include "sys_monitor_common.h"
#include "log_error_code.h"
#include "log_system_api.h"
#include "log_file_info.h"
#include "log_common.h"

#define MONITOR_MEM_FILE_PATH        "/proc/meminfo"
#define MONITOR_MEM_ALARM_VALUE      90U         // 90%
#define MONITOR_MEM_RESUME_VALUE     80U         // 80%
#define MONITOR_MEM_MONITOR_PERIOD   10000U      // 10 seconds
#define MONITOR_MEM_STAT_PERIOD      3600000U    // 1 hour
#define MONITOR_MEM_SILENCE_PERIOD   60000U      // 1 minute
#define MONITOR_MEM_ALARM_MAX        9U
#define MONITOR_MEM_ZERO             0U
#define MONITOR_MEM_INFO_BUFFER      4096U
#define MONITOR_MEM_NAME_MAX         64U
#define MONITOR_MEM_DECIMAL          10

typedef struct MemInfo {
    // in the order of /proc/meminfo
    uint64_t total;
    uint64_t free;
    uint64_t buffers;
    uint64_t cached;
    uint64_t shmem;
    uint64_t slab;
} MemInfo;

typedef struct MemInfoTable {
    const char *name;
    uint64_t *count;
} MemInfoTable;

STATIC MemInfo g_memInfo = { 0 };
STATIC SysmonitorInfo* g_sysmonitorMemInfo = NULL;
STATIC MonitorStatInfo g_memStatInfo = { MONITOR_ONE_HUNDRED_FLOAT, 0.0, 0.0, 0, 0, 0 };
STATIC float g_memTotalUsage = 0.0;
STATIC uint32_t g_memMonitorTime = 0;
STATIC MemInfoTable g_memInfoTable[] = {
    { "Buffers",  &g_memInfo.buffers },
    { "Cached",   &g_memInfo.cached  },
    { "MemFree",  &g_memInfo.free    },
    { "MemTotal", &g_memInfo.total   },
    { "Shmem",    &g_memInfo.shmem   },
    { "Slab",     &g_memInfo.slab    }
};

/**
 * @brief       : compare whether the names of two MemInfoTable are the same
 * @param [in]  : a       one MemInfoTable
 * @param [in]  : b       another MemInfoTable
 * @return      : 0 same; other different
 */
STATIC int32_t SysmonitorMemCompareTable(const void *a, const void *b)
{
    return strcmp(((const MemInfoTable *)a)->name, ((const MemInfoTable *)b)->name);
}

/**
 * @brief       : convert the first word in a string to a number
 * @param [in]  : str      character string before conversion
 * @param [out] : num      number after conversion
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
STATIC int32_t SysmonitorMemStrToUlong(const char *str, uint64_t *num)
{
    if ((str == NULL) || (num == NULL) || (str[0] == '-')) {
        return LOG_FAILURE;
    }
    char *endPtr = NULL;
    errno = 0;
    uint64_t ret = strtoull(str, &endPtr, MONITOR_MEM_DECIMAL);
    int32_t error = LOG_SUCCESS;
    if (endPtr == str) {
        error = LOG_FAILURE;
    } else if (((ret == 0U) || (ret == ULLONG_MAX)) && (errno == ERANGE)) {
        error = LOG_FAILURE;
    } else {
        *num = ret;
    }
    return error;
}

/**
 * @brief       : parse memory info to memory info table g_memInfoTable based on label comparison
 * @param [in]  : data      value of /proc/meminfo in the format of "label: value\n"
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
STATIC int32_t SysmonitorMemParseInfo(char *data)
{
    char *head = data;
    char *tail = NULL;
    char nameBuffer[MONITOR_MEM_NAME_MAX] = { 0 };
    MemInfoTable findName = { nameBuffer, NULL };

    while (true) {
        tail = strchr(head, ':');
        if (tail == NULL) {
            break;
        }
        *tail = '\0';

        errno_t err = strcpy_s(nameBuffer, MONITOR_MEM_NAME_MAX - 1U, head);
        if (err != EOK) {
            MONITOR_LOGE("strcpy_s nameBuffer failed, err=%d, strerr=%s", err, strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
        head = tail + 1;
        MemInfoTable *found = (MemInfoTable *)bsearch(&findName, g_memInfoTable, sizeof(g_memInfoTable) /
            sizeof(g_memInfoTable[0]), sizeof(MemInfoTable), SysmonitorMemCompareTable);
        if (found != NULL) {
            if (SysmonitorMemStrToUlong(head, found->count) != LOG_SUCCESS) {
                MONITOR_LOGE("strtoull value failed, strerr=%s", strerror(ToolGetErrorCode()));
                return LOG_FAILURE;
            }
        }

        tail = strchr(head, '\n');
        if (tail == NULL) {
            break;
        }
        head = tail + 1;
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : get memory info from environment
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
STATIC int32_t SysmonitorMemGetInfo(void)
{
    int32_t fd = ToolOpenWithMode(MONITOR_MEM_FILE_PATH, O_RDONLY, LOG_FILE_ARCHIVE_MODE);
    if (fd < 0) {
        MONITOR_LOGE("open file with mode failed, file=%s, strerr=%s.",
            MONITOR_MEM_FILE_PATH, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    char *buffer =  (char *)LogMalloc(MONITOR_MEM_INFO_BUFFER);
    if (buffer == NULL) {
        MONITOR_LOGE("malloc buf failed, strerr=%s", strerror(ToolGetErrorCode()));
        (void)ToolClose(fd);
        return LOG_FAILURE;
    }
    int32_t ret = ToolRead(fd, buffer, MONITOR_MEM_INFO_BUFFER - 1U);
    if (ret <= 0 || (uint32_t)ret >= MONITOR_MEM_INFO_BUFFER) {
        MONITOR_LOGE("read /proc/meminfo file failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        (void)ToolClose(fd);
        LogFree(buffer);
        return LOG_FAILURE;
    }
    buffer[ret] = '\0';

    ret = SysmonitorMemParseInfo(buffer);
    if (ret != LOG_SUCCESS) {
        (void)ToolClose(fd);
        LogFree(buffer);
        return LOG_FAILURE;
    }
    (void)ToolClose(fd);
    LogFree(buffer);
    return LOG_SUCCESS;
}

/**
 * @brief           : get memory usage by memory info
 * @return          : memory usage
 */
STATIC float SysmonitorMemGetUsage(void)
{
    return (float)(g_memInfo.total - g_memInfo.free - g_memInfo.buffers - g_memInfo.cached - g_memInfo.slab +
        g_memInfo.shmem) * MONITOR_ONE_HUNDRED_FLOAT / (float)g_memInfo.total;
}

/**
 * @brief       : reset stat info after each stat
 */
STATIC void SysmonitorMemReset(void)
{
    g_sysmonitorMemInfo->alarmCount = 0;
    g_sysmonitorMemInfo->statCount = 0;
    g_memStatInfo.avgUsage = 0.0;
    g_memStatInfo.maxUsage = 0.0;
    g_memStatInfo.minUsage = MONITOR_ONE_HUNDRED_FLOAT;
    g_memStatInfo.alarmNum = 0;
    g_memStatInfo.resumeNum = 0;
    g_memStatInfo.duration = 0;
    g_memTotalUsage = 0.0;
    g_memMonitorTime = 0;
}

/**
 * @brief       : refresh stat info
 * @param [in]  : usage       current mem usage
 */
STATIC void SysmonitorMemRecordUsage(float usage)
{
    if (usage < g_memStatInfo.minUsage) {
        g_memStatInfo.minUsage = usage;
    }

    if (usage > g_memStatInfo.maxUsage) {
        g_memStatInfo.maxUsage = usage;
    }

    g_memTotalUsage += usage;
    g_memMonitorTime++;
    g_memStatInfo.avgUsage = g_memTotalUsage / (float)g_memMonitorTime;
}

STATIC void SysmonitorMemProcessTopTen(void)
{
    const char command[] = { "top -mbn1|tail -n +4|head" };
    FILE *fp = popen(command, "r");
    ONE_ACT_ERR_LOG(fp == NULL, return, "print top ten process failed, strerr=%s", strerror(ToolGetErrorCode()));

    char *result = (char *)LogMalloc(MONITOR_MESSAGE_MAX_SIZE);
    if (result == NULL) {
        MONITOR_LOGE("malloc result failed, strerr=%s", strerror(ToolGetErrorCode()));
        pclose(fp);
        return;
    }
    while (fgets(result, MONITOR_MESSAGE_MAX_SIZE, fp) != NULL) {
        MONITOR_RUN("%s", result);
    }

    LogFree(result);
    pclose(fp);
}

STATIC void SysmonitorMemProcessAlarm(float usage)
{
    MONITOR_RUN("memory usage alarm: %4.1f%%", usage);
    SysmonitorMemProcessTopTen();
}

STATIC void SysmonitorMemProcessStat(void)
{
    const char statHead[] = {"memory usage stat:"};
    char *statInfo = (char *)LogMalloc(MONITOR_MESSAGE_MAX_SIZE);
    ONE_ACT_ERR_LOG(statInfo == NULL, return, "malloc stat info failed, strerr=%s", strerror(ToolGetErrorCode()));
    int32_t ret = sprintf_s(statInfo, MONITOR_MESSAGE_MAX_SIZE,
        "%s minUsage=%4.1f%%, maxUsage=%4.1f%%, avgUsage=%4.1f%%, alarmNum=%u, resumeNum=%u, duration=%ums",
        statHead, g_memStatInfo.minUsage, g_memStatInfo.maxUsage, g_memStatInfo.avgUsage,
        g_memStatInfo.alarmNum, g_memStatInfo.resumeNum, g_memStatInfo.duration * g_sysmonitorMemInfo->monitorPeriod);
    if (ret == -1) {
        MONITOR_LOGE("sprintf_s stat info failed");
        LogFree(statInfo);
        return;
    }
    MONITOR_LOGI("%s", statInfo);
    if (g_memStatInfo.alarmNum != 0) {
        MONITOR_RUN("%s", statInfo);
    }
    LogFree(statInfo);
}


STATIC void SysmonitorMemProcessUsage(float usage)
{
    SysmonitorMemRecordUsage(usage);
    if ((usage >= g_sysmonitorMemInfo->alarmValue) && !g_sysmonitorMemInfo->thresholdFlag) {
        g_sysmonitorMemInfo->thresholdFlag = true;
        MONITOR_LOGI("memory total: %lukB, memory usage alarm: %4.1f%%", g_memInfo.total, usage);
        if (g_sysmonitorMemInfo->silenceCount == MONITOR_SILENCE_DISABLE) {
            g_sysmonitorMemInfo->silenceCount = 0;
            if (g_sysmonitorMemInfo->alarmCount < g_sysmonitorMemInfo->alarmMaxCount) {
                SysmonitorMemProcessAlarm(usage);
                g_sysmonitorMemInfo->alarmCount++;
            }
        }
        g_memStatInfo.alarmNum++;
    } else if ((usage <= g_sysmonitorMemInfo->resumeValue) && g_sysmonitorMemInfo->thresholdFlag) {
        g_sysmonitorMemInfo->thresholdFlag = false;
        MONITOR_LOGI("memory total: %lukB, memory usage resume: %4.1f%%", g_memInfo.total, usage);
        g_memStatInfo.resumeNum++;
    }

    g_sysmonitorMemInfo->statCount++;

    if (g_sysmonitorMemInfo->thresholdFlag) {
        g_memStatInfo.duration++;
    }

    if (g_sysmonitorMemInfo->silenceCount != MONITOR_SILENCE_DISABLE) {
        g_sysmonitorMemInfo->silenceCount++;
    }

    if ((g_sysmonitorMemInfo->silenceCount >= 0) &&
        (((uint32_t)g_sysmonitorMemInfo->silenceCount * g_sysmonitorMemInfo->monitorPeriod) >=
        g_sysmonitorMemInfo->silencePeriod)) {
        g_sysmonitorMemInfo->silenceCount = MONITOR_SILENCE_DISABLE;
    }

    if ((g_sysmonitorMemInfo->statCount * g_sysmonitorMemInfo->monitorPeriod) >= g_sysmonitorMemInfo->statPeriod) {
        // print stat info
        SysmonitorMemProcessStat();
        // reset stat info
        SysmonitorMemReset();
    }
}

 /**
 * @brief       : memory monitor execute once
 */
STATIC void SysmonitorMem(void)
{
    // 1.get memory information
    errno_t err = memset_s(&g_memInfo, sizeof(MemInfo), 0, sizeof(MemInfo));
    if (err != EOK) {
        MONITOR_LOGE("memset_s mem info failed, err=%d, strerr=%s", err, strerror(ToolGetErrorCode()));
        return;
    }

    int32_t ret = SysmonitorMemGetInfo();
    if (ret != LOG_SUCCESS || g_memInfo.total == 0U) {
        return;
    }

    // 2.calculate memory usage
    float usage = SysmonitorMemGetUsage();

    // 3.disposal memory usage
    SysmonitorMemProcessUsage(usage);
}

void SysmonitorResInitMem(SysmonitorInfo* info)
{
    info->alarmValue = MONITOR_MEM_ALARM_VALUE;
    info->resumeValue = MONITOR_MEM_RESUME_VALUE;
    info->monitorCount = MONITOR_MEM_ZERO;
    info->monitorPeriod = MONITOR_MEM_MONITOR_PERIOD;
    info->statCount = MONITOR_MEM_ZERO;
    info->statPeriod = MONITOR_MEM_STAT_PERIOD;
    info->alarmCount = MONITOR_MEM_ZERO;
    info->alarmMaxCount = MONITOR_MEM_ALARM_MAX;
    info->silenceCount = MONITOR_SILENCE_DISABLE;
    info->silencePeriod = MONITOR_MEM_SILENCE_PERIOD;
    info->thresholdFlag= false;
    info->monitorFunc = SysmonitorMem;
    g_sysmonitorMemInfo = info;
}