/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "msnpureport_print.h"
#include <stdint.h>
#include "mmpa_api.h"

#ifdef _LOG_UT_
#define STATIC
#define INLINE
#else
#define STATIC static
#define INLINE inline
#endif

struct MsnLogConfig {
    int32_t level;
    int32_t printMode;
};

static struct MsnLogConfig g_msnLogConfig = {LOG_INFO, PRINT_SYSLOG};

#define USEC_MAX        999999
#define NSEC_PER_USEC   1000
#define TIME_MAXLEN     32

void MsnPrintSetLogLevel(int32_t level)
{
    g_msnLogConfig.level = level;
}

int32_t MsnPrintGetLogLevel(void)
{
    return (int32_t)g_msnLogConfig.level;
}

void MsnSetLogPrintMode(int32_t mode)
{
    g_msnLogConfig.printMode = mode;
    if (mode == PRINT_SYSLOG) {
        openlog("msnpureport", LOG_PID, LOG_USER);
    }
}

int32_t MsnGetLogPrintMode(void)
{
    return (int32_t)g_msnLogConfig.printMode;
}

/**
 * @brief       : get local time when print log
 * @return      : string of time
 */
const char *MsnpuGetLocalTimeForLog(void)
{
    static char timeStr[TIME_MAXLEN] = { 0 };
    mmTimeval tv = { 0 };
    struct tm timeInfo = { 0 };

    int32_t ret = mmGetTimeOfDay(&tv, NULL);
    MSNPU_CHK_EXPR_ACT(ret != EN_OK, return timeStr);

    if ((tv.tv_usec < 0) || (tv.tv_usec > USEC_MAX)) {
        tv.tv_usec = 0;
    }

    const time_t sec = tv.tv_sec;
    ret = mmLocalTimeR(&sec, &timeInfo);
    MSNPU_CHK_EXPR_ACT(ret != EN_OK, return timeStr);

    ret = snprintf_s(timeStr, TIME_MAXLEN, TIME_MAXLEN - 1, "%04d-%02d-%02d %02d:%02d:%02d.%03ld",
                     timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday,
                     timeInfo.tm_hour, timeInfo.tm_min, timeInfo.tm_sec, tv.tv_usec / NSEC_PER_USEC);
    MSNPU_CHK_EXPR_ACT(ret == -1, return timeStr);

    return timeStr;
}

#define CONFIG_MAX_NUM 5U
#define MODULE_MAX_NUM 100U   // print up to 100 modules
#define CLOUMN_SIZE 32
#define DEVICE_ID_INFO 16U
#define ITEM_SIZE (CLOUMN_SIZE - 2)

STATIC INLINE void PrintItem(const char *key, const char *value)
{
    (void)fprintf(stdout, "| %*s | %*s |\n", -ITEM_SIZE, key, -ITEM_SIZE, value);
}

STATIC INLINE void PrintLine(const char *lineOne, const char *lineTwo)
{
    (void)fprintf(stdout, "+%s+%s+\n", lineOne, lineTwo);
}

typedef struct {
    const char *key;
    const char *value;
} InfoCache;

typedef struct {
    InfoCache configInfo[CONFIG_MAX_NUM];
    InfoCache logLevel[MODULE_MAX_NUM];
} DeviceInfo;

STATIC DeviceInfo g_deviceInfo;

STATIC void MsnStrSplit(char *info, const char *pattern, InfoCache *infoCache, uint32_t cacheLen)
{
    uint32_t i = 0;
    char *context = NULL;
    char *token = strtok_s(info, pattern, &context);
    while (token != NULL && i < cacheLen) {
        char *value = NULL;
        char *key = strtok_s(token, ":", &value);
        if ((key != NULL) && (value != NULL)) {
            infoCache[i].key = key;
            infoCache[i].value = value;
            i++;
        }

        token = strtok_s(NULL, pattern, &context);
    }
    return;
}

STATIC void MsnPrintConfig(void)
{
    uint32_t i = 0;
    for (; i < CONFIG_MAX_NUM; i++) {
        if ((g_deviceInfo.configInfo[i].key != NULL) && (g_deviceInfo.configInfo[i].value != NULL)) {
            PrintItem(g_deviceInfo.configInfo[i].key, g_deviceInfo.configInfo[i].value);
        }
    }
}

STATIC void MsnPrintLogLevel(void)
{
    // Global Level
    if ((g_deviceInfo.logLevel[0].key != NULL) && (g_deviceInfo.logLevel[0].value != NULL) &&
        (strcmp(g_deviceInfo.logLevel[0].key, "Global") == 0)) {
        PrintItem("Global Level", g_deviceInfo.logLevel[0].value);
    }
    // Event Level
    if ((g_deviceInfo.logLevel[1].key != NULL) && (g_deviceInfo.logLevel[1].value != NULL) &&
        (strcmp(g_deviceInfo.logLevel[1].key, "Event") == 0)) {
        PrintItem("Event Level", g_deviceInfo.logLevel[1].value);
    }
    // Module Level
    uint32_t i = 2;
    for (; i < MODULE_MAX_NUM; i++) {
        if ((g_deviceInfo.logLevel[i].key != NULL) && (g_deviceInfo.logLevel[i].value != NULL)) {
            char modleInfo[ITEM_SIZE] = {0};
            int32_t ret = sprintf_s(modleInfo, ITEM_SIZE, "Module [%s]", g_deviceInfo.logLevel[i].key);
            if (ret == -1) {
                SELF_LOG_WARN("sprintf fail for %s", g_deviceInfo.logLevel[i].key);
                continue;
            }
            PrintItem(modleInfo, g_deviceInfo.logLevel[i].value);
        } else {
            break;
        }
    }
}

STATIC int32_t MsnHandleInfo(char *info)
{
    ONE_ACT_WARN_LOG(info == NULL, return EN_ERROR, "info is NULL");

    char *logLevel = strchr(info, '|'); // configInfo and log level are separated by "|"
    if (logLevel != NULL) {
        *logLevel = 0;
        logLevel++;
    }
    MsnStrSplit(info, ",", g_deviceInfo.configInfo, CONFIG_MAX_NUM);
    MsnStrSplit(logLevel, ",", g_deviceInfo.logLevel, MODULE_MAX_NUM);
    return EN_OK;
}

void MsnPrintInfo(uint16_t devId, char *info)
{
    if (MsnHandleInfo(info) != EN_OK) {
        return;
    }

    // create table line
    char lineOne[CLOUMN_SIZE + 1] = {0};
    errno_t ret = memset_s(lineOne, CLOUMN_SIZE, '-', CLOUMN_SIZE);
    ONE_ACT_ERR_LOG(ret != EOK, return, "memset fail for line one");
    char lineTwo[CLOUMN_SIZE + 1] = {0};
    ret = memset_s(lineTwo, CLOUMN_SIZE, '=', CLOUMN_SIZE);
    ONE_ACT_ERR_LOG(ret != EOK, return, "memset fail for line two");
    char lineLog[CLOUMN_SIZE + 1] = {0};
    ret = memset_s(lineLog, CLOUMN_SIZE, '-', CLOUMN_SIZE);
    ONE_ACT_ERR_LOG(ret != EOK, return, "memset fail for line log title");
    const char logLevel[] = " Log Level ";
    uint32_t startIndex = CLOUMN_SIZE / 4;
    ret = memcpy_s(lineLog + startIndex, CLOUMN_SIZE - startIndex, logLevel, strlen(logLevel));
    ONE_ACT_ERR_LOG(ret != EOK, return, "memcpy fail for log line, ret: %d", ret);

    // print head
    PrintLine(lineOne, lineOne);
    char printDeviceId[DEVICE_ID_INFO] = {0};
    ret = sprintf_s(printDeviceId, DEVICE_ID_INFO, "Device ID: %u", devId);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf fail for device id");
    PrintItem(printDeviceId, "Current Configuration");
    PrintLine(lineTwo, lineTwo);

    // print configuration
    MsnPrintConfig();
    if (g_deviceInfo.logLevel[0].key != NULL) {
        PrintLine(lineLog, lineOne);
        MsnPrintLogLevel();
    }
    PrintLine(lineOne, lineOne);
}