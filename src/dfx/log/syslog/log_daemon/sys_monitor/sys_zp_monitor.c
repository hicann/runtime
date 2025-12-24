 /**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "sys_zp_monitor.h"
#include "sys_monitor_print.h"
#include "sys_monitor_common.h"
#include "log_error_code.h"
#include "log_system_api.h"
#include "log_file_info.h"
#include "log_common.h"

#define MONITOR_ZP_ALARM_VALUE      5
#define MONITOR_ZP_RESUME_VALUE     3
#define MONITOR_ZP_MONITOR_PERIOD   10000U      // 10 seconds
#define MONITOR_ZP_STAT_PERIOD      3600000U    // 1 hour
#define MONITOR_ZP_SILENCE_PERIOD   60000U      // 1 minute
#define MONITOR_ZP_ALARM_MAX        9U
#define MONITOR_ZP_ZERO             0U
#define MONITOR_ZP_NAME_MAX         64U
#define MONITOR_ZP_DECIMAL          10

STATIC SysmonitorInfo* g_sysmonitorZpInfo = NULL;
STATIC MonitorStatInfo g_zpStatInfo = { MONITOR_ONE_HUNDRED_FLOAT, 0.0, 0.0, 0, 0, 0 };
STATIC uint32_t g_zpTotalCount = 0;
STATIC uint32_t g_zpMonitorTime = 0;

/**
 * @brief       : convert the first word in a string to a number
 * @param [in]  : str      character string before conversion
 * @param [out] : num      number after conversion
 * @return      : LOG_SUCCESS success; LOG_FAILURE fail
 */
STATIC int32_t SysmonitorZpStrToUint(const char *str, uint32_t *num)
{
    if ((str == NULL) || (num == NULL) || (str[0] == '-')) {
        return LOG_FAILURE;
    }
    char *endPtr = NULL;
    errno = 0;
    uint64_t ret = strtoul(str, &endPtr, MONITOR_ZP_DECIMAL);
    int32_t error = LOG_SUCCESS;
    if (endPtr == str) {
        error = LOG_FAILURE;
    } else if (((ret == 0U) || (ret == ULONG_MAX)) && (errno == ERANGE)) {
        error = LOG_FAILURE;
    } else if (ret > UINT_MAX) {
        error = LOG_FAILURE;
    } else {
        *num = (uint32_t)ret;
    }
    return error;
}

STATIC int32_t SysmonitorZpGetInfo(uint32_t *count)
{
    const char command[] = { "ps -o stat|grep -e '^[Zz]'|wc -l" }; // the stat value of zombie process is Z
    FILE *fp = popen(command, "r");
    ONE_ACT_ERR_LOG(fp == NULL, return LOG_FAILURE, "get zp info failed, strerr=%s", strerror(ToolGetErrorCode()));

    char result[MONITOR_ZP_NAME_MAX] = { 0 };
    int32_t ret = LOG_FAILURE;
    if (fgets(result, MONITOR_ZP_NAME_MAX, fp) != NULL) {
        if (SysmonitorZpStrToUint(result, count) != LOG_SUCCESS) {
            MONITOR_LOGE("string to unsigned int failed, str=%s.", result);
        } else {
            ret = LOG_SUCCESS;
        }
    }
    pclose(fp);
    return ret;
}

/**
 * @brief       : reset stat info after each stat
 */
STATIC void SysmonitorZpReset(void)
{
    g_sysmonitorZpInfo->alarmCount = 0;
    g_sysmonitorZpInfo->statCount = 0;
    g_zpStatInfo.avgUsage = 0.0;
    g_zpStatInfo.maxUsage = 0.0;
    g_zpStatInfo.minUsage = MONITOR_ONE_HUNDRED_FLOAT;
    g_zpStatInfo.alarmNum = 0;
    g_zpStatInfo.resumeNum = 0;
    g_zpStatInfo.duration = 0;
    g_zpTotalCount = 0;
    g_zpMonitorTime = 0;
}


/**
 * @brief       : refresh stat info
 * @param [in]  : count       current count
 */
STATIC void SysmonitorZpRecord(uint32_t count)
{
    if ((float)count < g_zpStatInfo.minUsage) {
        g_zpStatInfo.minUsage = (float)count;
    }

    if ((float)count > g_zpStatInfo.maxUsage) {
        g_zpStatInfo.maxUsage = (float)count;
    }

    g_zpTotalCount += count;
    g_zpMonitorTime++;
    g_zpStatInfo.avgUsage = (float)g_zpTotalCount / (float)g_zpMonitorTime;
}

STATIC void SysmonitorZpProcessAlarm(uint32_t count)
{
    MONITOR_RUN("zombie process count alarm: %u", count);
}

STATIC void SysmonitorZpProcessStat(void)
{
    const char statHead[] = {"zombie process count stat:"};
    char statInfo[MONITOR_MESSAGE_MAX_SIZE] = { 0 };
    int32_t ret = sprintf_s(statInfo, MONITOR_MESSAGE_MAX_SIZE,
        "%s minCount=%u, maxCount=%u, avgCount=%u, alarmNum=%u, resumeNum=%u, duration=%ums",
        statHead, (uint32_t)g_zpStatInfo.minUsage, (uint32_t)g_zpStatInfo.maxUsage, (uint32_t)g_zpStatInfo.avgUsage,
        g_zpStatInfo.alarmNum, g_zpStatInfo.resumeNum, g_zpStatInfo.duration * g_sysmonitorZpInfo->monitorPeriod);
    if (ret == -1) {
        MONITOR_LOGE("sprintf_s stat info failed");
        return;
    }
    MONITOR_LOGI("%s", statInfo);
    if (g_zpStatInfo.alarmNum != 0) {
        MONITOR_RUN("%s", statInfo);
    }
}

STATIC void SysmonitorZpProcess(uint32_t count)
{
    SysmonitorZpRecord(count);
    if ((count >= (uint32_t)g_sysmonitorZpInfo->alarmValue) && !g_sysmonitorZpInfo->thresholdFlag) {
        g_sysmonitorZpInfo->thresholdFlag = true;
        MONITOR_LOGI("zombie process count alarm: %u", count);
        if (g_sysmonitorZpInfo->silenceCount == MONITOR_SILENCE_DISABLE) {
            g_sysmonitorZpInfo->silenceCount = 0;
            if (g_sysmonitorZpInfo->alarmCount < g_sysmonitorZpInfo->alarmMaxCount) {
                SysmonitorZpProcessAlarm(count);
                g_sysmonitorZpInfo->alarmCount++;
            }
        }
        g_zpStatInfo.alarmNum++;
    } else if ((count < (uint32_t)g_sysmonitorZpInfo->resumeValue) && g_sysmonitorZpInfo->thresholdFlag) {
        MONITOR_LOGI("zombie process count resume: %u", count);
        g_sysmonitorZpInfo->thresholdFlag = false;
        g_zpStatInfo.resumeNum++;
    }

    g_sysmonitorZpInfo->statCount++;

    if (g_sysmonitorZpInfo->thresholdFlag) {
        g_zpStatInfo.duration++;
    }

    if (g_sysmonitorZpInfo->silenceCount != MONITOR_SILENCE_DISABLE) {
        g_sysmonitorZpInfo->silenceCount++;
    }

    if ((g_sysmonitorZpInfo->silenceCount >= 0) &&
        (((uint32_t)g_sysmonitorZpInfo->silenceCount * g_sysmonitorZpInfo->monitorPeriod) >=
        g_sysmonitorZpInfo->silencePeriod)) {
        g_sysmonitorZpInfo->silenceCount = MONITOR_SILENCE_DISABLE;
    }

    if ((g_sysmonitorZpInfo->statCount * g_sysmonitorZpInfo->monitorPeriod) >= g_sysmonitorZpInfo->statPeriod) {
        // print stat info
        SysmonitorZpProcessStat();
        // reset stat info
        SysmonitorZpReset();
    }
}

STATIC void SysmonitorZp(void)
{
    // 1.get zombie process information
    uint32_t count = 0;
    int32_t ret = SysmonitorZpGetInfo(&count);
    if (ret == LOG_FAILURE) {
        MONITOR_LOGE("get zombie process info failed");
        return;
    }
    // 2. disposal zombie process information
    SysmonitorZpProcess(count);
}

void SysmonitorResInitZp(SysmonitorInfo* info)
{
    info->alarmValue = MONITOR_ZP_ALARM_VALUE;
    info->resumeValue = MONITOR_ZP_RESUME_VALUE;
    info->monitorCount = MONITOR_ZP_ZERO;
    info->monitorPeriod = MONITOR_ZP_MONITOR_PERIOD;
    info->statCount = MONITOR_ZP_ZERO;
    info->statPeriod = MONITOR_ZP_STAT_PERIOD;
    info->alarmCount = MONITOR_ZP_ZERO;
    info->alarmMaxCount = MONITOR_ZP_ALARM_MAX;
    info->silenceCount = MONITOR_SILENCE_DISABLE;
    info->silencePeriod = MONITOR_ZP_SILENCE_PERIOD;
    info->thresholdFlag= false;
    info->monitorFunc = SysmonitorZp;
    g_sysmonitorZpInfo = info;
}