/* *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "file_slogdlog_monitor.h"
#include "event_process_core.h"
#include "log_print.h"
#include "log_time.h"
#include "log_path_mgr.h"

#define SLOGDLOG_SCAN_INTERVAL (60 * 1000)
#define SLOGDLOG_NOTIFY_INTERVAL 1000
#define SLOGDLOG_FILE       "slogdlog"
#define SLOGDLOG_OLD_FILE   "slogdlog.old"

static MonitorEvent g_slogdLogMonitor = { 0 };

int32_t SlogdlogMonitorInit(FileMonitorSyncFunc func)
{
    if (func == NULL) {
        SELF_LOG_WARN("file monitor sync function is null.");
        return LOG_FAILURE;
    }
    g_slogdLogMonitor.fileSyncFunc = func;
    return LOG_SUCCESS;
}

void SlogdlogMonitorExit(void)
{
    SlogdlogMonitorStop();
    g_slogdLogMonitor.fileSyncFunc = NULL;
}

static void SlogdLogSyncActiveFile(void)
{
    if (ToolAccess(g_slogdLogMonitor.notifyMonitor.event[0].fileName) != LOG_SUCCESS) {
        return;
    }
    char dstFileName[MAX_FILENAME_LEN] = { 0 };     // slog/dev-os-id/slogd/slogdlog
    int32_t ret = 0;
    ret = sprintf_s(dstFileName, MAX_FILENAME_LEN, "slog/%s/slogd/%s", FileMonitorGetMasterIdStr(), SLOGDLOG_FILE);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf failed, get slogdlog file name failed.");
    ret = g_slogdLogMonitor.fileSyncFunc(g_slogdLogMonitor.notifyMonitor.event[0].fileName, dstFileName);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("file %s sync failed, ret = %d.", g_slogdLogMonitor.notifyMonitor.event[0].fileName, ret);
    }
}

static void SlogdLogSyncOldFile(void)
{
    if (ToolAccess(g_slogdLogMonitor.notifyMonitor.event[1].fileName) != LOG_SUCCESS) {
        return;
    }
    ToolStat fileStat = { 0 };
    int32_t ret = ToolStatGet(g_slogdLogMonitor.notifyMonitor.event[1].fileName, &fileStat);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return, "get file stat failed, file=%s, ret=%d, strerr=%s.",
        g_slogdLogMonitor.notifyMonitor.event[1].fileName, ret, strerror(ToolGetErrorCode()));
    struct tm timeInfo = { 0 };
    ret = ToolLocalTimeR(&fileStat.st_mtim.tv_sec, &timeInfo);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return, "convert mtime to local time failed");

    char dstFileName[MAX_FILENAME_LEN] = { 0 };     // slog/dev-os-id/slogd/slogdlog_{mtime}
    ret = sprintf_s(dstFileName, MAX_FILENAME_LEN, "slog/%s/slogd/%s_%04d%02d%02d%02d%02d%02d%03ld",
        FileMonitorGetMasterIdStr(), SLOGDLOG_FILE, timeInfo.tm_year, timeInfo.tm_mon, timeInfo.tm_mday,
        timeInfo.tm_hour, timeInfo.tm_min, timeInfo.tm_sec, fileStat.st_mtim.tv_nsec / MS_TO_NS);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf failed, get slogdlog_{mtime} file name failed.");

    ret = g_slogdLogMonitor.fileSyncFunc(g_slogdLogMonitor.notifyMonitor.event[1].fileName, dstFileName);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("file %s send failed, ret=%d.", g_slogdLogMonitor.notifyMonitor.event[1].fileName, ret);
    }
}

static void SlogdLogNotifyEventProc(void *arg)
{
    (void)arg;
    int32_t ret = 0;
    if (g_slogdLogMonitor.notifyMonitor.event[0].wd == 0) {
        char slogdPath[MAX_FULLPATH_LEN] = {0};
        ret = sprintf_s(slogdPath, MAX_FULLPATH_LEN, "%s/slogd", LogGetRootPath());
        ONE_ACT_ERR_LOG(ret == -1, return, "sprintf failed, get slogd path failed.");
        FileMonitorAddWatch(slogdPath, g_slogdLogMonitor.notifyMonitor.fd,
            &g_slogdLogMonitor.notifyMonitor.event[0].wd, IN_CREATE | IN_MOVED_TO);
    }
    char buffer[FILE_MONITOR_EVENT_BUF_LEN] = { 0 };
    int32_t len = ToolRead(g_slogdLogMonitor.notifyMonitor.fd, buffer, FILE_MONITOR_EVENT_BUF_LEN);
    if (len < 0) {
        return;
    }
    uint32_t i = 0;
    while (i < (uint32_t)len) {
        struct inotify_event *event = (struct inotify_event *)&buffer[i];
        i += FILE_MONITOR_EVENT_SIZE + event->len;
        if (((event->mask & IN_CREATE) != 0) && (strcmp(event->name, SLOGDLOG_FILE) == 0)) {
            SlogdLogSyncActiveFile();
            continue;
        }
        if (((event->mask & IN_MOVED_TO) != 0) && (strcmp(event->name, SLOGDLOG_OLD_FILE) == 0)) {
            SlogdLogSyncOldFile();
            continue;
        }
    }
}

// 事件监控
static int32_t SlogdlogMonitorNotifyStart(void)
{
    int32_t fd = inotify_init1(IN_NONBLOCK);
    if (fd == -1) {
        SELF_LOG_ERROR("notify init failed, strerr:%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    int32_t ret = 0;
    ret = sprintf_s(g_slogdLogMonitor.notifyMonitor.event[0].fileName, MAX_FULLPATH_LEN, "%s/slogd/%s",
        LogGetRootPath(), SLOGDLOG_FILE);
    ONE_ACT_ERR_LOG(ret == -1, return LOG_FAILURE, "sprintf failed, get slogdlog file path failed.");
    ret = sprintf_s(g_slogdLogMonitor.notifyMonitor.event[1].fileName, MAX_FULLPATH_LEN, "%s/slogd/%s",
        LogGetRootPath(), SLOGDLOG_OLD_FILE);
    ONE_ACT_ERR_LOG(ret == -1, return LOG_FAILURE, "sprintf failed, get slogdlog.old file path failed.");

    int32_t wd = 0;
    char slogdPath[MAX_FULLPATH_LEN] = {0};
    ret = sprintf_s(slogdPath, MAX_FULLPATH_LEN, "%s/slogd", LogGetRootPath());
    ONE_ACT_ERR_LOG(ret == -1, return LOG_FAILURE, "sprintf failed, get slogdlog file path failed.");
    (void)FileMonitorAddWatch(slogdPath, fd, &wd, IN_CREATE | IN_MOVED_TO);

    SlogdLogSyncActiveFile();
    SlogdLogSyncOldFile();

    EventAttr attr = { LOOP_TIME_EVENT, SLOGDLOG_NOTIFY_INTERVAL };
    EventHandle handle = EventAdd(SlogdLogNotifyEventProc, NULL, &attr);
    if (handle == NULL) {
        SELF_LOG_ERROR("add slogdlog notify event failed.");
        inotify_rm_watch(fd, wd);
        ToolClose(fd);
        return LOG_FAILURE;
    }
    g_slogdLogMonitor.notifyMonitor.fd = fd;
    g_slogdLogMonitor.notifyMonitor.event[0].wd = wd;
    g_slogdLogMonitor.notifyMonitor.eventHandle = handle;
    SELF_LOG_INFO("slogdlog add notify monitor success.");
    return LOG_SUCCESS;
}

static void SlogdLogScanEventProc(void *arg)
{
    (void)arg;
    if (ToolAccess(g_slogdLogMonitor.notifyMonitor.event[0].fileName) != SYS_OK) {
        return;
    }
    static time_t mtime = 0;
    ToolStat fileStat = { 0 };
    int32_t ret = ToolStatGet(g_slogdLogMonitor.notifyMonitor.event[0].fileName, &fileStat);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return, "get file stat failed, file=%s, ret=%d, strerr=%s.",
        g_slogdLogMonitor.notifyMonitor.event[0].fileName, ret, strerror(ToolGetErrorCode()));

    if (fileStat.st_mtime == mtime) {
        return;
    }
    mtime = fileStat.st_mtime;
    SlogdLogSyncActiveFile();
}

// 定时同步
static int32_t SlogdlogMonitorScanStart(void)
{
    EventAttr attr = { LOOP_TIME_EVENT, SLOGDLOG_SCAN_INTERVAL };
    EventHandle handle = EventAdd(SlogdLogScanEventProc, NULL, &attr);
    if (handle == NULL) {
        SELF_LOG_ERROR("add slogdlog notify event failed.");
        return LOG_FAILURE;
    }
    g_slogdLogMonitor.scanMonitor.eventHandle = handle;
    SELF_LOG_INFO("slogdlog add scan monitor success.");
    return LOG_SUCCESS;
}

int32_t SlogdlogMonitorStart(void)
{
    int32_t ret = SlogdlogMonitorNotifyStart();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    ret = SlogdlogMonitorScanStart();
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

static void SlogdlogMonitorNotifyStop(void)
{
    if (g_slogdLogMonitor.notifyMonitor.eventHandle == NULL) {
        return;
    }
    int32_t ret = EventDelete(g_slogdLogMonitor.notifyMonitor.eventHandle);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("delete slogdlog notify event failed, ret = %d.", ret);
    }
    g_slogdLogMonitor.notifyMonitor.eventHandle = NULL;
    inotify_rm_watch(g_slogdLogMonitor.notifyMonitor.fd, g_slogdLogMonitor.notifyMonitor.event[0].wd);
    g_slogdLogMonitor.notifyMonitor.event[0].wd = 0;
    ToolClose(g_slogdLogMonitor.notifyMonitor.fd);
    g_slogdLogMonitor.notifyMonitor.fd = 0;
}

static void SlogdlogMonitorScanStop(void)
{
    if (g_slogdLogMonitor.scanMonitor.eventHandle == NULL) {
        SELF_LOG_WARN("no scan monitor is need to stop.");
        return;
    }
    int32_t ret = EventDelete(g_slogdLogMonitor.scanMonitor.eventHandle);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("delete slogdlog scan event failed, ret = %d.", ret);
    }
    g_slogdLogMonitor.scanMonitor.eventHandle = NULL;
}

void SlogdlogMonitorStop(void)
{
    SlogdlogMonitorNotifyStop();
    SlogdlogMonitorScanStop();
}