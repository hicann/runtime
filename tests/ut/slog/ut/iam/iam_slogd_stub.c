/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <stdio.h>
#include <string.h>

#include "iam.h"
#include "log_config_list.h"
#include "log_file_util.h"
#include "log_level_parse.h"
#include "log_print_syslog.h"
#include "log_to_file.h"
#include "slogd_collect_log.h"
#include "slogd_flush.h"
#include "securec.h"

static int32_t g_eventLevel = 1;
static int32_t g_globalLevel = DLOG_DEBUG;
static int32_t g_moduleLevel = DLOG_DEBUG;
static bool g_collectValid;
static SlogdStatus g_slogdStatus = SLOGD_EXIT;
static int32_t g_collectNotifyCount;
static int32_t g_flushCount;
static int32_t g_fsyncCount;
static StLogFileList g_fileList;

void IamSlogdStubReset(void)
{
    g_eventLevel = 1;
    g_globalLevel = DLOG_DEBUG;
    g_moduleLevel = DLOG_DEBUG;
    g_collectValid = false;
    g_slogdStatus = SLOGD_EXIT;
    g_collectNotifyCount = 0;
    g_flushCount = 0;
    g_fsyncCount = 0;
    (void)memset(&g_fileList, 0, sizeof(g_fileList));
    (void)strcpy_s(g_fileList.aucFilePath, sizeof(g_fileList.aucFilePath), "/tmp");
    for (int32_t type = 0; type < (int32_t)LOG_TYPE_NUM; type++) {
        (void)strcpy_s(g_fileList.sortDeviceOsLogList[type].fileName,
                       sizeof(g_fileList.sortDeviceOsLogList[type].fileName), "device-os.log");
    }
}

void IamSlogdStubSetLevels(int32_t globalLevel, int32_t moduleLevel, int32_t eventLevel)
{
    g_globalLevel = globalLevel;
    g_moduleLevel = moduleLevel;
    g_eventLevel = eventLevel;
}

void IamSlogdStubSetCollectValid(bool valid) { g_collectValid = valid; }

void IamSlogdStubSetStatus(SlogdStatus status) { g_slogdStatus = status; }

int32_t IamSlogdStubGetCollectNotifyCount(void) { return g_collectNotifyCount; }

int32_t IamSlogdStubGetFlushCount(void) { return g_flushCount; }

int32_t IamSlogdStubGetFsyncCount(void) { return g_fsyncCount; }

void LogPrintSys(int32_t priority, const char* format, ...)
{
    (void)priority;
    (void)format;
}

unsigned int FilePathSplice(const StSubLogFileList* subInfo, char* fileName, size_t maxLen)
{
    (void)subInfo;
    int ret = snprintf(fileName, maxLen, "/tmp/device-os.log");
    return (ret > 0) ? OK : NOK;
}

void FsyncLogToDisk(const char* logPath)
{
    (void)logPath;
    g_fsyncCount++;
}

StLogFileList* GetGlobalLogFileList(void) { return &g_fileList; }

int32_t SlogdGetEventLevel(void) { return g_eventLevel; }

int32_t SlogdGetGlobalLevel(uint32_t typeMask)
{
    (void)typeMask;
    return g_globalLevel;
}

int32_t SlogdGetModuleLevel(int32_t moduleId, uint32_t typeMask)
{
    (void)moduleId;
    (void)typeMask;
    return g_moduleLevel;
}

const ModuleInfo* GetModuleInfos(void)
{
    static const ModuleInfo moduleInfos[] = {
        {"SLOG", SLOG, false, DLOG_INFO, {-1, -1, -1, -1}, -1},
        {NULL, -1, false, -1, {-1, -1, -1, -1}, -1}
    };
    return moduleInfos;
}

LogRt LogConfListGetValue(const char* confName, uint32_t nameLen, char* confValue, uint32_t valueLen)
{
    (void)confName;
    (void)nameLen;
    int ret = snprintf(confValue, valueLen, "%d", DLOG_INFO);
    return (ret > 0) ? SUCCESS : FAILED;
}

SlogdStatus SlogdGetStatus(void) { return g_slogdStatus; }

void SlogdFlushToFile(bool flushFlag)
{
    (void)flushFlag;
    g_flushCount++;
}

bool SlogdCheckCollectValid(const char* path, uint32_t len)
{
    (void)path;
    (void)len;
    return g_collectValid;
}

void SlogdCollectNotify(const char* path, uint32_t len)
{
    (void)path;
    (void)len;
    g_collectNotifyCount++;
}

LogStatus SlogdGetLogPatterns(LogConfigInfo* info)
{
    (void)info;
    return LOG_SUCCESS;
}

void SlogdStartCollectThread(void) {}

void SlogdCollectThreadExit(void) {}

int32_t IAMRegisterService(const struct IAMFileConfig* config)
{
    (void)config;
    return SYS_OK;
}
