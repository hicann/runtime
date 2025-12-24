/* *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "file_device_app_monitor.h"
#include "log_print.h"
#include "log_common.h"
#include "log_path_mgr.h"

#define MAX_DEVICE_APP_FOLDER_DEPTH 1
#define DEVICE_APP_SEND_DELAY (60 * 1000)
#define DEVICE_APP_NOTIFY_INTERVAL 100

typedef struct DeviceAppFileSyncArg {
    char watchPath[MAX_FULLPATH_LEN];   // debug | run
    char fileName[MAX_FILENAME_LEN];    // device-app-xx
    struct DeviceAppFileSyncArg *next;
} DeviceAppFileSyncArg;

static FileMonitor g_devAppMonitor = { 0 };
static const char *g_logType[LOG_TYPE_NUM] = {DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME};
static char g_scanPath[MAX_FULLPATH_LEN] = {0}; // /var/log/npu/slog/(run | debug)

int32_t DeviceAppMonitorInit(FileMonitorSyncFunc func)
{
    if (func == NULL) {
        SELF_LOG_ERROR("file monitor sync function is null.");
        return LOG_FAILURE;
    }

    g_devAppMonitor.eventMonitor.fileSyncFunc = func;
    return LOG_SUCCESS;
}

void DeviceAppMonitorExit(void)
{
    DeviceAppMonitorStop();
    g_devAppMonitor.eventMonitor.fileSyncFunc = NULL;
}

static void DeviceAppArgAddToList(DeviceAppFileSyncArg *node, void **list)
{
    if ((*list) == NULL) {
        *list = (void *)node;
        return;
    }
    DeviceAppFileSyncArg *tmp = (DeviceAppFileSyncArg *)*list;
    while (tmp->next != NULL) {
        tmp = tmp->next;
    }
    tmp->next = node;
}

static void DeviceAppArgDelete(DeviceAppFileSyncArg *arg, void **list)
{
    DeviceAppFileSyncArg *node = (DeviceAppFileSyncArg *)*list;
    DeviceAppFileSyncArg *pre = NULL;
    DeviceAppFileSyncArg *head = node;

    while (node != NULL) {
        if (arg == node) {
            if (pre == NULL) {
                head = node->next;
            } else {
                pre->next = node->next;
            }
            DeviceAppFileSyncArg *tmp = node->next;
            XFREE(node);
            node = tmp;
            break;
        } else {
            pre = node;
            node = node->next;
        }
    }
    *list = (void *)head;
}

static void DeviceAppDeleteArgList(void)
{
    (void)ToolMutexLock(&g_devAppMonitor.argListLock);
    DeviceAppFileSyncArg *node = (DeviceAppFileSyncArg *)g_devAppMonitor.argList;
    DeviceAppFileSyncArg *next = NULL;

    while (node != NULL) {
        next = node->next;
        XFREE(node);
        node = next;
    }
    g_devAppMonitor.argList = NULL;
    (void)ToolMutexUnLock(&g_devAppMonitor.argListLock);
}

static int32_t DeviceAppLogDirFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((dir->d_type == DT_DIR) && (strncmp(dir->d_name, DEVICE_APP_HEAD, strlen(DEVICE_APP_HEAD)) == 0)) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

static int32_t DeviceAppLogDirSort(const struct dirent **a, const struct dirent **b)
{
    ToolStat sbufA, sbufB;
    char fullPath[MAX_FULLPATH_LEN] = {0};
    int32_t ret = 0;
    ret = sprintf_s(fullPath, MAX_FULLPATH_LEN, "%s/%s", g_scanPath, (*a)->d_name);
    ONE_ACT_ERR_LOG(ret == -1, return 0, "sprintf_s for dir %s full path failed", (*a)->d_name);
    ret = ToolStatGet(fullPath, &sbufA);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return 0, "get dir %s stat failed", (*a)->d_name);

    (void)memset_s(fullPath, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
    ret = sprintf_s(fullPath, MAX_FULLPATH_LEN, "%s/%s", g_scanPath, (*b)->d_name);
    ONE_ACT_ERR_LOG(ret == -1, return 0, "sprintf_s for dir %s full path failed", (*b)->d_name);
    ret = ToolStatGet(fullPath, &sbufB);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return 0, "get dir stat %s failed", (*b)->d_name);

    return sbufA.st_ctime > sbufB.st_ctime ? 1 : -1;
}

static void DeviceAppMonitorSendExistFile(const char *type)
{
    char dstFileName[MAX_FILENAME_LEN] = { 0 };     // slog/dev-os-xx/(run | debug)/device-app-xxx
    (void)memset_s(g_scanPath, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
    int32_t ret = 0;
    ret = sprintf_s(g_scanPath, MAX_FULLPATH_LEN, "%s/%s", LogGetRootPath(), type);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s for %s failed.", type);

    ToolDirent **namelist = NULL;
    // get file lists
    int32_t totalNum = ToolScandir(g_scanPath, &namelist, DeviceAppLogDirFilter, DeviceAppLogDirSort);
    if ((totalNum < 0) || ((totalNum > 0) && (namelist == NULL))) {
        SELF_LOG_ERROR("scan directory failed, result=%d, strerr=%s.", totalNum, strerror(ToolGetErrorCode()));
        return;
    }

    char srcFileName[MAX_FULLPATH_LEN] = {0};   // /var/log/npu/slog/(debug | run)/device-app-xxx
    for (int32_t i = 0; i < totalNum; i++) {
        ret = sprintf_s(dstFileName, MAX_FILENAME_LEN, "slog/%s/%s/%s", FileMonitorGetMasterIdStr(), type, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "sprintf_s for %s failed.", type);
        (void)memset_s(srcFileName, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
        ret = sprintf_s(srcFileName, MAX_FULLPATH_LEN, "%s/%s", g_scanPath, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "sprintf_s for %s failed.", namelist[i]->d_name);
        ret = FileMonitorSyncFileList(srcFileName, dstFileName, g_devAppMonitor.eventMonitor.fileSyncFunc,
            MAX_DEVICE_APP_FOLDER_DEPTH);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "sync file failed, file path=%s, ret=%d.", srcFileName, ret);
    }

    ToolScandirFree(namelist, totalNum);
}

static void DeviceAppMonitorAddWatch()
{
    int32_t wd = 0;
    int32_t ret = 0;
    char filePath[MAX_FULLPATH_LEN] = { 0 };

    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        if (g_devAppMonitor.eventMonitor.notifyMonitor.event[i].wd != 0) {
            continue;
        }
        (void)memset_s(filePath, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
        ret = strcpy_s(g_devAppMonitor.eventMonitor.notifyMonitor.event[i].fileName, MAX_FULLPATH_LEN, g_logType[i]);
        ONE_ACT_ERR_LOG(ret != EOK, continue, "strcpy_s for device app %s failed.", g_logType[i]);
        ret = sprintf_s(filePath, MAX_FULLPATH_LEN, "%s/%s", LogGetRootPath(), g_logType[i]);
        ONE_ACT_ERR_LOG(ret == -1, continue, "sprintf_s for device app %s failed.", g_logType[i]);
        ret = FileMonitorAddWatch(filePath, g_devAppMonitor.eventMonitor.notifyMonitor.fd, &wd, IN_CREATE);
        if (ret != LOG_SUCCESS) {
            continue;
        }
        g_devAppMonitor.eventMonitor.notifyMonitor.event[i].wd = wd;
        DeviceAppMonitorSendExistFile(g_logType[i]);
    }
}

static void DeviceAppFileSyncProc(void *arg)
{
    DeviceAppFileSyncArg *syncArg = (DeviceAppFileSyncArg*)arg;
    char srcPath[MAX_FULLPATH_LEN] = { 0 };     // /var/log/npu/slog/(debug | run)/device-app-xxx
    char dstPath[MAX_FULLPATH_LEN] = { 0 };     // slog/dev-os-xx/(debug | run)/device-app-xxx
    int32_t ret = 0;
    ret = sprintf_s(srcPath, MAX_FULLPATH_LEN, "%s/%s/%s", LogGetRootPath(), syncArg->watchPath, syncArg->fileName);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s failed, get notify src path failed.");
    ret = sprintf_s(dstPath, MAX_FULLPATH_LEN, "slog/%s/%s/%s", FileMonitorGetMasterIdStr(), syncArg->watchPath,
        syncArg->fileName);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s failed, get notify dst path failed.");
    ToolStat fileStat = { 0 };
    if ((ToolStatGet(srcPath, &fileStat) == SYS_OK) && S_ISDIR(fileStat.st_mode)) {
        ret = FileMonitorSyncFileList(srcPath, dstPath, g_devAppMonitor.eventMonitor.fileSyncFunc,
            MAX_DEVICE_APP_FOLDER_DEPTH);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "sync file failed, ret = %d.", ret);
    }
    (void)ToolMutexLock(&g_devAppMonitor.argListLock);
    DeviceAppArgDelete(syncArg, &g_devAppMonitor.argList);
    (void)ToolMutexUnLock(&g_devAppMonitor.argListLock);
}

static void DeviceAppNotifyCreateEvent(struct inotify_event *event)
{
    int32_t i = 0;
    for (i = 0; i < MAX_DEV_NUM; i++) {
        if (event->wd == g_devAppMonitor.eventMonitor.notifyMonitor.event[i].wd) {
            break;
        }
    }
    ONE_ACT_ERR_LOG(i == MAX_DEV_NUM, return, "no wd is matched.");

    DeviceAppFileSyncArg *arg = (DeviceAppFileSyncArg *)LogMalloc(sizeof(DeviceAppFileSyncArg));
    ONE_ACT_ERR_LOG(arg == NULL, return, "malloc for device app file sync arg failed, strerr = %s.",
        strerror(ToolGetErrorCode()));

    errno_t err = strcpy_s(arg->watchPath, MAX_FULLPATH_LEN, g_devAppMonitor.eventMonitor.notifyMonitor.event[i].fileName);
    TWO_ACT_ERR_LOG(err != EOK, XFREE(arg), return, "strcpy_s failed for watchPath, err = %d.", (int32_t)err);
    err = strcpy_s(arg->fileName, MAX_FILENAME_LEN, event->name);
    TWO_ACT_ERR_LOG(err != EOK, XFREE(arg), return, "strcpy_s failed for fileName, err = %d.", (int32_t)err);

    EventAttr attr = { DELAY_TIME_EVENT, DEVICE_APP_SEND_DELAY };
    EventHandle handle = EventAdd(DeviceAppFileSyncProc, (void *)arg, &attr);
    TWO_ACT_ERR_LOG(handle == NULL, XFREE(arg), return, "add bbox file sync event failed.");
    (void)ToolMutexLock(&g_devAppMonitor.argListLock);
    DeviceAppArgAddToList(arg, &g_devAppMonitor.argList);
    (void)ToolMutexUnLock(&g_devAppMonitor.argListLock);
}

static void DeviceAppNotifyEventProc(void *arg)
{
    (void)arg;
    DeviceAppMonitorAddWatch();

    char buffer[FILE_MONITOR_EVENT_BUF_LEN] = { 0 };
    int32_t len = ToolRead(g_devAppMonitor.eventMonitor.notifyMonitor.fd, buffer, FILE_MONITOR_EVENT_BUF_LEN);
    if ((len < 0) && ((errno == EINTR) || (errno == EAGAIN))) {
        return;
    }
    ONE_ACT_ERR_LOG(len < 0, return, "read error, strerror = %s.", strerror(ToolGetErrorCode()));
    uint32_t i = 0;
    while (i < (uint32_t)len) {
        struct inotify_event *event = (struct inotify_event *)&buffer[i];
        i += (uint32_t)FILE_MONITOR_EVENT_SIZE + event->len;
        if (event->len == 0) {
            continue;
        }
        if (event->mask & IN_CREATE) {
            DeviceAppNotifyCreateEvent(event);
            continue;
        }
    }
}

static void DeviceAppRmNotifyMonitor(void)
{
    if (g_devAppMonitor.eventMonitor.notifyMonitor.eventHandle != NULL) {
        int32_t ret = EventDelete(g_devAppMonitor.eventMonitor.notifyMonitor.eventHandle);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "delete notify event failed, ret = %d.", ret);
        g_devAppMonitor.eventMonitor.notifyMonitor.eventHandle = NULL;
    }

    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
        if (g_devAppMonitor.eventMonitor.notifyMonitor.event[i].wd != 0) {
            inotify_rm_watch(g_devAppMonitor.eventMonitor.notifyMonitor.fd,
                g_devAppMonitor.eventMonitor.notifyMonitor.event[i].wd);
            g_devAppMonitor.eventMonitor.notifyMonitor.event[i].wd = 0;
        }
    }
    ToolClose(g_devAppMonitor.eventMonitor.notifyMonitor.fd);
    g_devAppMonitor.eventMonitor.notifyMonitor.fd = 0;
}

int32_t DeviceAppMonitorStart(void)
{
    g_devAppMonitor.eventMonitor.notifyMonitor.fd = inotify_init1(IN_NONBLOCK);
    if (g_devAppMonitor.eventMonitor.notifyMonitor.fd == -1) {
        SELF_LOG_ERROR("notify init failed, strerr:%s.", strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    DeviceAppMonitorAddWatch();

    EventAttr attr = { LOOP_TIME_EVENT, DEVICE_APP_NOTIFY_INTERVAL };
    EventHandle handle = EventAdd(DeviceAppNotifyEventProc, NULL, &attr);
    if (handle == NULL) {
        SELF_LOG_ERROR("add device app notify event failed.");
        DeviceAppRmNotifyMonitor();
        return LOG_FAILURE;
    }

    g_devAppMonitor.eventMonitor.notifyMonitor.eventHandle = handle;
    SELF_LOG_INFO("device app add notify monitor success.");
    return LOG_SUCCESS;
}

void DeviceAppMonitorStop(void)
{
    DeviceAppRmNotifyMonitor();
    DeviceAppDeleteArgList();
}