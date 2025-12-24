/* *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
 
#include "file_bbox_monitor.h"
#include "file_monitor_common.h"
#include "ascend_hal.h"
#include "log_print.h"

#ifndef BBOX_DIR_MONITOR
#define BBOX_DIR_MONITOR "/var/log/npu/hisi_logs/"
#endif
#define BBOX_DIR_HEAD "device-"
#define BBOX_HISTORY_FILE_NAME "history.log"
#define BBOX_HOST_FILE_PATH "hisi_logs"
#define BBOX_SYNC_INTERVAL (60 * 1000)
#define BBOX_NOTIFY_INTERVAL 100

typedef struct BboxFileSyncArg {
    char watchPath[MAX_FULLPATH_LEN];
    char fileName[MAX_FILENAME_LEN];
    struct BboxFileSyncArg *next;
} BboxFileSyncArg;

static FileMonitor g_bboxMonitor = { 0 };

int32_t BboxMonitorInit(FileMonitorSyncFunc func)
{
    if (func == NULL) {
        SELF_LOG_WARN("file monitor sync function is null.");
        return LOG_FAILURE;
    }
    g_bboxMonitor.eventMonitor.fileSyncFunc = func;
    return LOG_SUCCESS;
}

void BboxMonitorExit(void)
{
    BboxMonitorStop();
    g_bboxMonitor.eventMonitor.fileSyncFunc = NULL;
}

static void BboxNotifySyncFile(const char *watchPath, const char *fileName, int32_t depth)
{
    char srcPath[MAX_FULLPATH_LEN] = { 0 };
    char dstPath[MAX_FULLPATH_LEN] = { 0 };
    int32_t ret = 0;
    ret = sprintf_s(srcPath, MAX_FULLPATH_LEN, "%s%s%s", BBOX_DIR_MONITOR, watchPath, fileName);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s failed, get notify src path failed.");
    ret = sprintf_s(dstPath, MAX_FULLPATH_LEN, "%s/%s%s", BBOX_HOST_FILE_PATH, watchPath, fileName);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s failed, get notify dst path failed.");
    int32_t tmpDepth = depth;
    ToolStat fileStat = { 0 };
    if ((ToolStatGet(srcPath, &fileStat) == LOG_SUCCESS) && (!S_ISDIR(fileStat.st_mode))) {
        tmpDepth = 0;
    }
    if (tmpDepth == 0) {
        ret = g_bboxMonitor.eventMonitor.fileSyncFunc(srcPath, dstPath);
    } else {
        ret = FileMonitorSyncFileList(srcPath, dstPath, g_bboxMonitor.eventMonitor.fileSyncFunc, tmpDepth);
    }
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "sync file failed, ret = %d.", ret);
}

static void BboxArgDelete(BboxFileSyncArg *arg, void **list)
{
    BboxFileSyncArg *node = (BboxFileSyncArg *)*list;
    BboxFileSyncArg *pre = NULL;
    BboxFileSyncArg *head = node;

    while (node != NULL) {
        if (arg == node) {
            if (pre == NULL) {
                head = node->next;
            } else {
                pre->next = node->next;
            }
            BboxFileSyncArg *tmp = node->next;
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

static void BboxArgAddToList(BboxFileSyncArg *node, void **list)
{
    if ((*list) == NULL) {
        *list = (void *)node;
        return;
    }
    BboxFileSyncArg *tmp = (BboxFileSyncArg *)*list;
    while (tmp->next != NULL) {
        tmp = tmp->next;
    }
    tmp->next = node;
}

static void BboxFileSyncProc(void *arg)
{
    BboxFileSyncArg *syncArg = (BboxFileSyncArg *)arg;
    BboxNotifySyncFile(syncArg->watchPath, syncArg->fileName, MAX_FOLDER_DEPTH);
    BboxNotifySyncFile(syncArg->watchPath, BBOX_HISTORY_FILE_NAME, 0);
    (void)ToolMutexLock(&g_bboxMonitor.argListLock);
    BboxArgDelete(syncArg, &g_bboxMonitor.argList);
    (void)ToolMutexUnLock(&g_bboxMonitor.argListLock);
}

static void BboxNotifyCreateEvent(struct inotify_event *event)
{
    ONE_ACT_NO_LOG(g_bboxMonitor.eventMonitor.fileSyncFunc == NULL, return);
    int32_t i = 0;
    for (i = 0; i < MAX_DEV_NUM; i++) {
        if (event->wd == g_bboxMonitor.eventMonitor.notifyMonitor.event[i].wd) {
            break;
        }
    }
    ONE_ACT_ERR_LOG(i == MAX_DEV_NUM, return, "no wd is matched.");
    BboxFileSyncArg *arg = (BboxFileSyncArg *)LogMalloc(sizeof(BboxFileSyncArg));
    ONE_ACT_ERR_LOG(arg == NULL, return, "malloc for bbox file sync arg failed, strerr = %s.",
        strerror(ToolGetErrorCode()));
    int32_t ret = 0;
    ret = sprintf_s(arg->watchPath, MAX_FULLPATH_LEN, "%s", g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName);
    TWO_ACT_ERR_LOG(ret == -1, XFREE(arg), return, "sprintf failed, get watch path failed.");
    errno_t err = strcpy_s(arg->fileName, MAX_FILENAME_LEN, event->name);
    if (err != EOK) {
        SELF_LOG_ERROR("strcpy_s failed, err = %d.", (int32_t)err);
        XFREE(arg);
        return;
    }
    EventAttr attr = { DELAY_TIME_EVENT, BBOX_SYNC_INTERVAL };
    EventHandle handle = EventAdd(BboxFileSyncProc, arg, &attr);
    TWO_ACT_ERR_LOG(handle == NULL, XFREE(arg), return, "add bbox file sync event failed.");
    (void)ToolMutexLock(&g_bboxMonitor.argListLock);
    BboxArgAddToList(arg, &g_bboxMonitor.argList);
    (void)ToolMutexUnLock(&g_bboxMonitor.argListLock);
}

static int32_t BboxMonitorAddWd(const char *fileName, int32_t fd, int32_t *wd)
{
    char filePath[MAX_FULLPATH_LEN] = { 0 };
    int32_t ret = sprintf_s(filePath, MAX_FULLPATH_LEN, "%s%s", BBOX_DIR_MONITOR, fileName);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s for file path failed, fileName = %s.", fileName);
        return LOG_FAILURE;
    }
    return FileMonitorAddWatch(filePath, fd, wd, IN_CREATE);
}

static void BboxMonitorRead(void)
{
    errno = 0;
    char buffer[FILE_MONITOR_EVENT_BUF_LEN] = { 0 };
    int32_t len = ToolRead(g_bboxMonitor.eventMonitor.notifyMonitor.fd, buffer, FILE_MONITOR_EVENT_BUF_LEN);
    if ((len < 0) && ((errno == EINTR) || (errno == EAGAIN))) {
        return;
    }
    ONE_ACT_ERR_LOG(len < 0, return, "read error, strerror = %s.", strerror(ToolGetErrorCode()));
    uint32_t i = 0;
    while (i < (uint32_t)len) {
        struct inotify_event *event = (struct inotify_event *)&buffer[i];
        i += FILE_MONITOR_EVENT_SIZE + event->len;
        if (event->len == 0) {
            continue;
        }
        if (event->mask & IN_CREATE) {
            BboxNotifyCreateEvent(event);
            continue;
        }
    }
}

static void BboxNotifyEventProc(void *arg)
{
    (void)arg;
    char filePath[MAX_FULLPATH_LEN] = { 0 };
    char dstPath[MAX_FULLPATH_LEN] = { 0 };
    for (int32_t i = 0; i < MAX_MONITOR_EVENT; i++) {
        if ((strlen(g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName) != 0) &&
            (g_bboxMonitor.eventMonitor.notifyMonitor.event[i].wd == 0)) {
            (void)memset_s(filePath, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
            int32_t ret = sprintf_s(filePath, MAX_FULLPATH_LEN, "%s%s", BBOX_DIR_MONITOR,
                g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName);
            if (ret == -1) {
                SELF_LOG_ERROR("sprintf_s for file path failed, fileName = %s.",
                    g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName);
                continue;
            }
            ret = FileMonitorAddWatch(filePath, g_bboxMonitor.eventMonitor.notifyMonitor.fd,
                &g_bboxMonitor.eventMonitor.notifyMonitor.event[i].wd, IN_CREATE);
            if (ret != LOG_SUCCESS) {
                continue;
            }
            (void)memset_s(dstPath, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
            ret = sprintf_s(dstPath, MAX_FULLPATH_LEN, "%s/%s", BBOX_HOST_FILE_PATH,
                g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName);
            if (ret == -1) {
                SELF_LOG_ERROR("sprintf_s for dst path failed, fileName = %s.",
                    g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName);
                continue;
            }
            LogStrTrimEnd(dstPath, MAX_FULLPATH_LEN);
            ret = FileMonitorSyncFileList(filePath, dstPath, g_bboxMonitor.eventMonitor.fileSyncFunc,
                MAX_FOLDER_DEPTH);
            if (ret != LOG_SUCCESS) {
                SELF_LOG_ERROR("sync file failed, file path = %s, ret = %d.", BBOX_DIR_MONITOR, ret);
            }
        }
    }
    BboxMonitorRead();
}

static uint32_t BboxMonitorGetHostDeviceID(uint32_t deviceId)
{
    uint32_t hostDeviceId = 0;
    drvError_t ret = drvGetDevIDByLocalDevID(deviceId, &hostDeviceId);
    if (ret != DRV_ERROR_NONE) {
        SELF_LOG_WARN("get host side device-id by device device-id=%u, result=%d", deviceId, (int32_t)ret);
        return deviceId;
    }
    return hostDeviceId;
}

static int32_t BboxMonitorGetDevNumIDs(uint32_t *deviceNum, uint32_t *deviceIdArray)
{
    int32_t devNum = 0;
    int32_t devId[MAX_DEV_NUM] = { 0 };
    int32_t ret = log_get_device_id(devId, &devNum, MAX_DEV_NUM);
    if ((ret != LOG_SUCCESS) || (devNum > MAX_DEV_NUM) || (devNum < 0)) {
        SELF_LOG_ERROR("get device id failed, result=%d, device_number=%d.", ret, devNum);
        return LOG_FAILURE;
    }
    *deviceNum = (uint32_t)devNum;
    int32_t idx = 0;
    for (; idx < devNum; idx++) {
        if ((devId[idx] >= 0) && (devId[idx] < MAX_DEV_NUM)) {
            deviceIdArray[idx] = (uint32_t)devId[idx];
        }
    }
    return LOG_SUCCESS;
}

static int32_t BboxMonitorAdd(void)
{
    uint32_t deviceIdArray[MAX_DEV_NUM] = { 0 }; // device-side device id array
    uint32_t devNum = 0;
    int32_t ret = BboxMonitorGetDevNumIDs(&devNum, deviceIdArray);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("get device id failed.");
        return LOG_FAILURE;
    }
    g_bboxMonitor.eventMonitor.notifyMonitor.fd = inotify_init1(IN_NONBLOCK);
    if (g_bboxMonitor.eventMonitor.notifyMonitor.fd < 0) {
        SELF_LOG_ERROR("notify init failed, fd = %d.", g_bboxMonitor.eventMonitor.notifyMonitor.fd);
        g_bboxMonitor.eventMonitor.notifyMonitor.fd = 0;
        return LOG_FAILURE;
    }
    for (uint32_t i = 0; i < devNum; i++) {
        ret = sprintf_s(g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName, MAX_FULLPATH_LEN, "%s%u/",
            BBOX_DIR_HEAD, BboxMonitorGetHostDeviceID(deviceIdArray[i]));
        if (ret == -1) {
            SELF_LOG_ERROR("sprintf_s for file name failed, add watch to device[%u] failed.", deviceIdArray[i]);
            continue;
        }
        BboxMonitorAddWd(g_bboxMonitor.eventMonitor.notifyMonitor.event[i].fileName,
            g_bboxMonitor.eventMonitor.notifyMonitor.fd, &g_bboxMonitor.eventMonitor.notifyMonitor.event[i].wd);
    }
    return LOG_SUCCESS;
}

static void BboxRmNotifyMonitor(void)
{
    if (g_bboxMonitor.eventMonitor.notifyMonitor.eventHandle == NULL) {
        SELF_LOG_WARN("no notify monitor is need to stop.");
        return;
    }
    int32_t ret = EventDelete(g_bboxMonitor.eventMonitor.notifyMonitor.eventHandle);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "delete notify event failed, ret = %d.", ret);
    g_bboxMonitor.eventMonitor.notifyMonitor.eventHandle = NULL;
    for (int32_t i = 0; i < MAX_DEV_NUM; i++) {
        if (g_bboxMonitor.eventMonitor.notifyMonitor.event[i].wd != 0) {
            inotify_rm_watch(g_bboxMonitor.eventMonitor.notifyMonitor.fd,
                g_bboxMonitor.eventMonitor.notifyMonitor.event[i].wd);
            g_bboxMonitor.eventMonitor.notifyMonitor.event[i].wd = 0;
        }
    }
    ToolClose(g_bboxMonitor.eventMonitor.notifyMonitor.fd);
    g_bboxMonitor.eventMonitor.notifyMonitor.fd = 0;
}

int32_t BboxMonitorStart(void)
{
    int32_t ret = BboxMonitorAdd();
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("add bbox monitor failed, ret = %d.", ret);
        return LOG_FAILURE;
    }
    // send existing files in the current path.
    ret = FileMonitorSyncFileList(BBOX_DIR_MONITOR, BBOX_HOST_FILE_PATH, g_bboxMonitor.eventMonitor.fileSyncFunc,
        MAX_FOLDER_DEPTH);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "sync file failed, file path = %s, ret = %d.", BBOX_DIR_MONITOR, ret);
    EventAttr attr = { LOOP_TIME_EVENT, BBOX_NOTIFY_INTERVAL };
    EventHandle handle = EventAdd(BboxNotifyEventProc, NULL, &attr);
    TWO_ACT_ERR_LOG(handle == NULL, BboxRmNotifyMonitor(), return LOG_FAILURE, "add bbox file notify event failed.");
    g_bboxMonitor.eventMonitor.notifyMonitor.eventHandle = handle;
    return LOG_SUCCESS;
}

static void BboxDeleteArgList(void)
{
    (void)ToolMutexLock(&g_bboxMonitor.argListLock);
    BboxFileSyncArg *node = (BboxFileSyncArg *)g_bboxMonitor.argList;
    BboxFileSyncArg *next = NULL;

    while (node != NULL) {
        next = node->next;
        XFREE(node);
        node = next;
    }
    g_bboxMonitor.argList = NULL;
    (void)ToolMutexUnLock(&g_bboxMonitor.argListLock);
}

void BboxMonitorStop(void)
{
    BboxRmNotifyMonitor();
    BboxDeleteArgList();
    return;
}