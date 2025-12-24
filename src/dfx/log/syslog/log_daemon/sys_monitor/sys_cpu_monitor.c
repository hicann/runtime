/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sys_cpu_monitor.h"
#include "sys_monitor_print.h"
#include "sys_monitor_common.h"
#include "log_error_code.h"
#include "log_system_api.h"
#include "log_file_info.h"
#include "log_common.h"

#define MONITOR_CPU_FILE_PATH        "/proc/stat"
#define MONITOR_CPU_ALARM_VALUE      90U         // 90%
#define MONITOR_CPU_RESUME_VALUE     80U         // 80%
#define MONITOR_CPU_MONITOR_PERIOD   10000U      // 10 seconds
#define MONITOR_CPU_STAT_PERIOD      3600000U    // 1 hour
#define MONITOR_CPU_SILENCE_PERIOD   60000U      // 1 minute
#define MONITOR_CPU_ALARM_MAX        9U
#define MONITOR_CPU_ZERO             0U
#define MONITOR_CPU_RECORD_NUM_MAX   16

typedef struct CpuInfo {
    // in the order of /proc/stat
    uint64_t usrTime;
    uint64_t niceTime;
    uint64_t systemTime;
    uint64_t idleTime;
    uint64_t iowaitTime;
    uint64_t irqTime;
    uint64_t softirqTime;
    uint64_t stealTime;
    // records of the previous round
    uint64_t usrSave;
    uint64_t niceSave;
    uint64_t systemSave;
    uint64_t idleSave;
    uint64_t iowaitSave;
    uint64_t irqSave;
    uint64_t softirqSave;
    uint64_t stealSave;
    // current usage record
    float usage;
} CpuInfo;

STATIC CpuInfo g_cpuInfo[MONITOR_CPU_RECORD_NUM_MAX + 1] = { 0 }; // extra record of total
STATIC SysmonitorInfo* g_sysmonitorCpuInfo = NULL;
STATIC MonitorStatInfo g_cpuStatInfo = {MONITOR_ONE_HUNDRED_FLOAT, 0.0, 0.0, 0, 0, 0};
STATIC float g_totalUsage = 0.0;
STATIC uint32_t g_monitorTime = 0;
STATIC int32_t g_cpuNum = 0;

/**
 * @brief       : get cpu info from environment
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
STATIC int32_t SysmonitorCpuGetInfo(void)
{
    int32_t fd = ToolOpenWithMode(MONITOR_CPU_FILE_PATH, O_RDONLY, LOG_FILE_ARCHIVE_MODE);
    if (fd < 0) {
        MONITOR_LOGE("open file with mode failed, file=%s, strerr=%s.",
            MONITOR_CPU_FILE_PATH, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    char *buf = (char *)LogMalloc(MONITOR_MESSAGE_MAX_SIZE);
    if (buf == NULL) {
        MONITOR_LOGE("malloc buf failed, strerr=%s", strerror(ToolGetErrorCode()));
        (void)ToolClose(fd);
        return LOG_FAILURE;
    }
    int32_t len = ToolRead(fd, buf, MONITOR_MESSAGE_MAX_SIZE);
    if (len <= 0) {
        MONITOR_LOGE("read file failed, file=%s, strerr=%s.",
            MONITOR_CPU_FILE_PATH, strerror(ToolGetErrorCode()));
        (void)ToolClose(fd);
        LogFree(buf);
        return LOG_FAILURE;
    }

    g_cpuNum = 0;
    char *ptr = NULL;
    char *time = strtok_s(buf, "cpu", &ptr);
    while (time != NULL) {
        int32_t num = sscanf_s(time, "%*c %llu %llu %llu %llu %llu %llu %llu %llu",
            &g_cpuInfo[g_cpuNum].usrTime, &g_cpuInfo[g_cpuNum].niceTime, &g_cpuInfo[g_cpuNum].systemTime,
            &g_cpuInfo[g_cpuNum].idleTime, &g_cpuInfo[g_cpuNum].iowaitTime, &g_cpuInfo[g_cpuNum].irqTime,
            &g_cpuInfo[g_cpuNum].softirqTime, &g_cpuInfo[g_cpuNum].stealTime);
        if (num <= 0) {
            break;
        }
        g_cpuNum++;
        if(g_cpuNum > MONITOR_CPU_RECORD_NUM_MAX) {
            MONITOR_LOGW("cpu num exceeds the set maximum value %d", MONITOR_CPU_RECORD_NUM_MAX);
            break;
        }
        time = strtok_s(NULL, "cpu", &ptr);
    }
    g_cpuNum--;
    (void)ToolClose(fd);
    LogFree(buf);
    return LOG_SUCCESS;
}

/**
 * @brief           : get cpu usage by cpu info
 * @return          : cpu usage
 */
STATIC float SysmonitorCpuGetUsage(void)
{
    float usageTop = 0.0;
    for (int32_t i = 0; i <= g_cpuNum; ++i) {
        int64_t usrFrame = (int64_t)g_cpuInfo[i].usrTime - (int64_t)g_cpuInfo[i].usrSave;
        int64_t niceFrame = (int64_t)g_cpuInfo[i].niceTime - (int64_t)g_cpuInfo[i].niceSave;
        int64_t systemFrame = (int64_t)g_cpuInfo[i].systemTime - (int64_t)g_cpuInfo[i].systemSave;
        int64_t idleFrame = (int64_t)((g_cpuInfo[i].idleTime < g_cpuInfo[i].idleSave) ?
            0 : (g_cpuInfo[i].idleTime - g_cpuInfo[i].idleSave));
        int64_t iowaitFrame = (int64_t)g_cpuInfo[i].iowaitTime - (int64_t)g_cpuInfo[i].iowaitSave;
        int64_t irqFrame = (int64_t)g_cpuInfo[i].irqTime - (int64_t)g_cpuInfo[i].irqSave;
        int64_t softirqFrame = (int64_t)g_cpuInfo[i].softirqTime - (int64_t)g_cpuInfo[i].softirqSave;
        int64_t stealFrame = (int64_t)g_cpuInfo[i].stealTime - (int64_t)g_cpuInfo[i].stealSave;
        int64_t totalFrame = usrFrame + niceFrame + systemFrame + idleFrame + iowaitFrame +
            irqFrame +softirqFrame + stealFrame;
        if (totalFrame < 1) {
            totalFrame = 1;
        }

        // remember for next time around
        g_cpuInfo[i].usrSave = g_cpuInfo[i].usrTime;
        g_cpuInfo[i].niceSave = g_cpuInfo[i].niceTime;
        g_cpuInfo[i].systemSave = g_cpuInfo[i].systemTime;
        g_cpuInfo[i].idleSave = g_cpuInfo[i].idleTime;
        g_cpuInfo[i].iowaitSave = g_cpuInfo[i].iowaitTime;
        g_cpuInfo[i].irqSave = g_cpuInfo[i].irqTime;
        g_cpuInfo[i].softirqSave = g_cpuInfo[i].softirqTime;
        g_cpuInfo[i].stealSave = g_cpuInfo[i].stealTime;

        float curUsage = (float)(totalFrame - idleFrame) / (float)totalFrame * MONITOR_ONE_HUNDRED_FLOAT;
        g_cpuInfo[i].usage = curUsage;
        if (curUsage > usageTop) {
            usageTop = curUsage;
        }
    }

    return usageTop;
}

/**
 * @brief       : reset stat info after each stat
 */
STATIC void SysmonitorCpuReset(void)
{
    g_sysmonitorCpuInfo->alarmCount = 0;
    g_sysmonitorCpuInfo->statCount = 0;
    g_cpuStatInfo.avgUsage = 0.0;
    g_cpuStatInfo.maxUsage = 0.0;
    g_cpuStatInfo.minUsage = MONITOR_ONE_HUNDRED_FLOAT;
    g_cpuStatInfo.alarmNum = 0;
    g_cpuStatInfo.resumeNum = 0;
    g_cpuStatInfo.duration = 0;
    g_totalUsage = 0.0;
    g_monitorTime = 0;
}

/**
 * @brief       : refresh stat info
 * @param [in]  : usage       current cpu usage
 */
STATIC void SysmonitorCpuRecordUsage(float usage)
{
    if (usage < g_cpuStatInfo.minUsage) {
        g_cpuStatInfo.minUsage = usage;
    }

    if (usage > g_cpuStatInfo.maxUsage) {
        g_cpuStatInfo.maxUsage = usage;
    }

    g_totalUsage += usage;
    g_monitorTime++;
    g_cpuStatInfo.avgUsage = g_totalUsage / (float)g_monitorTime;
}

STATIC void SysmonitorCpuProcessTopTen(void)
{
    const char command[] = {"top -bn1|tail -n +4|head -11"};
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

    pclose(fp);
    LogFree(result);
}

STATIC void SysmonitorCpuProcessAlarm(void)
{
    char message[MONITOR_MESSAGE_MAX_SIZE] = { 0 };
    int32_t ret = 0;
    ret = sprintf_s(message, MONITOR_MESSAGE_MAX_SIZE, "cpu usage alarm, total: %4.1f%%", g_cpuInfo[0].usage);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s cpu alarm head failed");
    for (int32_t i = 1; i <= g_cpuNum; ++i) {
        ret = sprintf_s(message, MONITOR_MESSAGE_MAX_SIZE, "%s, cpu%d: %4.1f%%", message, i - 1, g_cpuInfo[i].usage);
        ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s cpu alarm value failed");
    }
    MONITOR_RUN("%s", message);
    SysmonitorCpuProcessTopTen();
}

STATIC void SysmonitorCpuProcessStat(void)
{
    const char statHead[] = {"cpu usage stat:"};

    char *statInfo = (char *)LogMalloc(MONITOR_MESSAGE_MAX_SIZE);
    ONE_ACT_ERR_LOG(statInfo == NULL, return, "malloc stat info failed, strerr=%s", strerror(ToolGetErrorCode()));
    int32_t ret = sprintf_s(statInfo, MONITOR_MESSAGE_MAX_SIZE,
        "%s minUsage=%4.1f%%, maxUsage=%4.1f%%, avgUsage=%4.1f%%, alarmNum=%u, resumeNum=%u, duration=%ums",
        statHead, g_cpuStatInfo.minUsage, g_cpuStatInfo.maxUsage, g_cpuStatInfo.avgUsage,
        g_cpuStatInfo.alarmNum, g_cpuStatInfo.resumeNum, g_cpuStatInfo.duration * g_sysmonitorCpuInfo->monitorPeriod);
    if (ret == -1) {
        MONITOR_LOGE("sprintf_s stat info failed");
        LogFree(statInfo);
        return;
    }
    MONITOR_LOGI("%s", statInfo);
    if (g_cpuStatInfo.alarmNum != 0) {
        MONITOR_RUN("%s", statInfo);
    }
    LogFree(statInfo);
}

STATIC void SysmonitorCpuProcessUsage(float usage)
{
    SysmonitorCpuRecordUsage(usage);
    if ((usage >= g_sysmonitorCpuInfo->alarmValue) && !g_sysmonitorCpuInfo->thresholdFlag) {
        g_sysmonitorCpuInfo->thresholdFlag = true;
        MONITOR_LOGI("cpu usage alarm: %4.1f%%", usage);
        if (g_sysmonitorCpuInfo->silenceCount == MONITOR_SILENCE_DISABLE) {
            g_sysmonitorCpuInfo->silenceCount = 0;
            if (g_sysmonitorCpuInfo->alarmCount < g_sysmonitorCpuInfo->alarmMaxCount) {
                SysmonitorCpuProcessAlarm();
                g_sysmonitorCpuInfo->alarmCount++;
            }
        }
        g_cpuStatInfo.alarmNum++;
    } else if ((usage <= g_sysmonitorCpuInfo->resumeValue) &&
        g_sysmonitorCpuInfo->thresholdFlag) {
        g_sysmonitorCpuInfo->thresholdFlag = false;
        MONITOR_LOGI("cpu usage resume: %4.1f%%", usage);
        g_cpuStatInfo.resumeNum++;
    }

    g_sysmonitorCpuInfo->statCount++;

    if (g_sysmonitorCpuInfo->thresholdFlag) {
        g_cpuStatInfo.duration++;
    }

    if (g_sysmonitorCpuInfo->silenceCount != MONITOR_SILENCE_DISABLE) {
        g_sysmonitorCpuInfo->silenceCount++;
    }

    if ((g_sysmonitorCpuInfo->silenceCount >= 0) &&
        (((uint32_t)g_sysmonitorCpuInfo->silenceCount * g_sysmonitorCpuInfo->monitorPeriod) >=
        g_sysmonitorCpuInfo->silencePeriod)) {
        g_sysmonitorCpuInfo->silenceCount = MONITOR_SILENCE_DISABLE;
    }

    if ((g_sysmonitorCpuInfo->statCount * g_sysmonitorCpuInfo->monitorPeriod) >=
        g_sysmonitorCpuInfo->statPeriod) {
        // print stat info
        SysmonitorCpuProcessStat();
        // reset stat info
        SysmonitorCpuReset();
    }
}

 /**
 * @brief       : cpu monitor execute once
 */
STATIC void SysmonitorCpu(void)
{
    // 1.get cpu information
    if (SysmonitorCpuGetInfo() != LOG_SUCCESS) {
        return;
    }

    // 2.calculate cpu usage
    float usage = SysmonitorCpuGetUsage();

    // 3.disposal cpu usage
    SysmonitorCpuProcessUsage(usage);
}

void SysmonitorResInitCpu(SysmonitorInfo* info)
{
    info->alarmValue = MONITOR_CPU_ALARM_VALUE;
    info->resumeValue = MONITOR_CPU_RESUME_VALUE;
    info->monitorCount = MONITOR_CPU_ZERO;
    info->monitorPeriod = MONITOR_CPU_MONITOR_PERIOD;
    info->statCount = MONITOR_CPU_ZERO;
    info->statPeriod = MONITOR_CPU_STAT_PERIOD;
    info->alarmCount = MONITOR_CPU_ZERO;
    info->alarmMaxCount = MONITOR_CPU_ALARM_MAX;
    info->silenceCount = MONITOR_SILENCE_DISABLE;
    info->silencePeriod = MONITOR_CPU_SILENCE_PERIOD;
    info->thresholdFlag= false;
    info->monitorFunc = SysmonitorCpu;
    g_sysmonitorCpuInfo = info;
}