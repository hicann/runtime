/* *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stackcore_file_monitor.h"
#include "file_monitor_common.h"
#include "log_file_util.h"
#include "log_print.h"

#define FILTER_OK 1
#define FILTER_NOK 0
#ifdef LOG_CORETRACE
#define DUMPFILE_NAME_PREFIX "coretrace."
#else
#define DUMPFILE_NAME_PREFIX "stackcore."
#endif
#define STACKCORE_HOST_FILE_PATH "stackcore"
#define MAX_RESERVE_FILE_NUMS 50
#define STACKCORE_DELAY_TIME (10 * 1000)
#define STACKCORE_NOTIFY_INTERVAL (1 * 1000)
#define STACKCORE_SCAN_INTERVAL (30 * 1000)

// stackcore file default path
#ifndef CORE_DEFAULT_PATH
#define CORE_DEFAULT_PATH "/var/log/npu/coredump/"
#endif

static int32_t g_curDirIndex = 0;
static ToolMutex g_curDirIndexLock = TOOL_MUTEX_INITIALIZER;
static char **g_stackcorePath = NULL;
static int32_t g_dirNum = 0;

typedef struct StackcoreFileSyncArg {
    char fileName[MAX_FILENAME_LEN];
    int32_t dirIndex;
    struct StackcoreFileSyncArg *next;
} StackcoreFileSyncArg;

typedef struct StackcoreFileMonitor {
    StackcoreFileSyncArg *argList;
    ToolMutex argListLock;
    MonitorEvent eventMonitor;
} StackcoreFileMonitor;

static StackcoreFileMonitor g_stackcoreMonitor = { 0 };

/* *
 * @brief         : check coredump dir if existed or not, if not, make dir
 * @param [in]    : path     path of coredump dir
 * @return        : LOG_SUCCESS success; LOG_FAILURE failed
 */
static int32_t CheckCoreDirIfExist(const char *path)
{
    if (access(path, F_OK) != 0) {
        // The input path can only be CORE_DEFAULT_PATH, and need not to be verified
        LogRt ret = LogMkdirRecur(path);
        if (ret != SUCCESS) {
            SELF_LOG_ERROR("mkdir %s failed, result=%d, strerr=%s.", path, (int32_t)ret, strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
        SELF_LOG_INFO("mkdir %s succeed.", path);
    }
    return LOG_SUCCESS;
}

/* *
 * @brief        : scandir filter func
 * @param [in]dir: file struct which include the path and filename
 * @return       : FILTER_NOK/FILTER_OK
 */
static int32_t StackCoreFilter(const ToolDirent *dir)
{
    int32_t ret = 0;

    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((LogStrStartsWith(dir->d_name, DUMPFILE_NAME_PREFIX) == true)) {
        char srcFileName[MAX_FILEPATH_LEN] = { 0 };
        ret = snprintf_s(srcFileName, MAX_FILEPATH_LEN, MAX_FILEPATH_LEN - 1U, "%s%s%s", CORE_DEFAULT_PATH,
            g_stackcorePath[g_curDirIndex], dir->d_name);
        ONE_ACT_ERR_LOG(ret == -1, return FILTER_NOK, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));

        ToolStat statbuff = { 0 };
        if (ToolStatGet(srcFileName, &statbuff) == 0) {
            // filesize must be over 0
            if (statbuff.st_size == 0) {
                SELF_LOG_ERROR("%s size is 0 and remove it", dir->d_name);
                (void)remove(srcFileName);
                return FILTER_NOK;
            }

            // only 440 can transfer
            uint32_t modeMask = (uint32_t)S_IRWXU | (uint32_t)S_IRWXG | (uint32_t)S_IRWXO;
            if ((statbuff.st_mode & modeMask) == ((uint32_t)S_IRUSR | (uint32_t)S_IRGRP)) {
                return FILTER_OK;
            }
        }
    }
    return FILTER_NOK;
}

/* *
 * @brief      : sort log files by timestamp in log filename
 * @param [in]a: log file name, log filename
 * @param [in]b: log file name, log filename
 * @return     : TRUE(1) a's timestamp newer than b
 * FALSE(0) a's timestamp older than b
 */
static int32_t SortByCreatetime(const ToolDirent **a, const ToolDirent **b)
{
    int32_t ret = 0;
    ToolStat aStatbuff = { 0 };
    ToolStat bStatbuff = { 0 };
    char aSrcFileName[MAX_FULLPATH_LEN] = { 0 };
    char bSrcFileName[MAX_FULLPATH_LEN] = { 0 };

    if ((a == NULL) || ((*a) == NULL) || (b == NULL) || ((*b) == NULL)) {
        return 1;
    }

    ret = snprintf_s(aSrcFileName, MAX_FULLPATH_LEN, MAX_FULLPATH_LEN - 1U, "%s%s%s", CORE_DEFAULT_PATH,
        g_stackcorePath[g_curDirIndex], (*a)->d_name);
    ONE_ACT_ERR_LOG(ret == -1, return 1, "snprintf_s A file failed, strerr=%s", strerror(ToolGetErrorCode()));

    ret = snprintf_s(bSrcFileName, MAX_FULLPATH_LEN, MAX_FULLPATH_LEN - 1U, "%s%s%s", CORE_DEFAULT_PATH,
        g_stackcorePath[g_curDirIndex], (*b)->d_name);
    ONE_ACT_ERR_LOG(ret == -1, return 1, "snprintf_s B file failed, strerr=%s", strerror(ToolGetErrorCode()));

    ret = ToolStatGet(aSrcFileName, &aStatbuff);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return 1, "get status of A file failed, strerr=%s",
        strerror(ToolGetErrorCode()));

    ret = ToolStatGet(bSrcFileName, &bStatbuff);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return 1, "get status of B file failed, strerr=%s",
        strerror(ToolGetErrorCode()));

    // file create time compare
    if (aStatbuff.st_ctime > bStatbuff.st_ctime) {
        return 1;
    } else {
        return 0;
    }
}

/* *
 * @brief        : scandir filter func
 * @param [in]   : dir   file struct which include the path and filename
 * @return       : FILTER_OK success; FILTER_NOK failed
 */
static int32_t StackCoreDirFilter(const ToolDirent *dir)
{
    int32_t ret = 0;

    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if (dir->d_type == (uint8_t)DT_DIR && strcmp(dir->d_name, "..") != 0) {
        char srcPathName[MAX_FILEPATH_LEN] = { 0 };
        ret = snprintf_s(srcPathName, MAX_FILEPATH_LEN, MAX_FILEPATH_LEN - 1U, "%s%s", CORE_DEFAULT_PATH, dir->d_name);
        ONE_ACT_ERR_LOG(ret == -1, return FILTER_NOK, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));

        if (access(srcPathName, (uint32_t)R_OK | (uint32_t)W_OK | (uint32_t)X_OK) == 0) {
            return FILTER_OK;
        }
    }
    return FILTER_NOK;
}

/* *
 * @brief        : add all subdir in CORE_DEFAULT_PATH to the list
 * @return       : LOG_SUCCESS success; LOG_FAILURE failed
 */
static int32_t InitStackCoreDir(void)
{
    int32_t i = 0;
    int32_t ret = 0;
    ToolDirent **namelist = NULL;
    char srcDirName[MAX_FILEPATH_LEN] = { 0 };
    int32_t stackcorePathNum = 0;

    ONE_ACT_NO_LOG(CheckCoreDirIfExist(CORE_DEFAULT_PATH) != LOG_SUCCESS, return LOG_FAILURE);

    // get filepath list
    int32_t totalNum = ToolScandir((const char *)CORE_DEFAULT_PATH, &namelist, StackCoreDirFilter, NULL);
    if ((totalNum <= 0) || ((totalNum > 0) && (namelist == NULL)) || (totalNum > MAX_MONITOR_EVENT)) {
        SELF_LOG_ERROR("scan directory failed, directory=%s, result=%d, strerr=%s.", CORE_DEFAULT_PATH, totalNum,
            strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    g_stackcorePath = (char **)LogMalloc((size_t)totalNum * sizeof(char *));
    if (g_stackcorePath == NULL) {
        ToolScandirFree(namelist, totalNum);
        SELF_LOG_ERROR("malloc failed, size=%zu, strerr=%s.", (size_t)totalNum * sizeof(char *),
            strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    for (i = 0; i < totalNum; ++i) {
        g_stackcorePath[i] = (char *)LogMalloc(MAX_FILEPATH_LEN * sizeof(char));
        if (g_stackcorePath[i] == NULL) {
            ToolScandirFree(namelist, totalNum);
            SELF_LOG_ERROR("malloc failed, size=%zu, strerr=%s.", MAX_FILEPATH_LEN * sizeof(char),
                strerror(ToolGetErrorCode()));

            // Release the memory that has been applied
            ToolPathListFree(g_stackcorePath, i);
            g_stackcorePath = NULL;
            return LOG_FAILURE;
        }
    }

    for (i = 0; i < totalNum; i++) {
        ONE_ACT_WARN_LOG(namelist[i] == NULL, continue, "namelist[%d] is invalid.", i);

        (void)memset_s(srcDirName, MAX_FILEPATH_LEN, 0, MAX_FILEPATH_LEN);
        ret = snprintf_s(srcDirName, MAX_FILEPATH_LEN, MAX_FILEPATH_LEN - 1U, "%s/", namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s filename failed, result=%d, strerr=%s.", ret,
            strerror(ToolGetErrorCode()));

        ret = strncpy_s(g_stackcorePath[stackcorePathNum], MAX_FILEPATH_LEN, srcDirName, strlen(srcDirName));
        ONE_ACT_ERR_LOG(ret == -1, continue, "strncpy_s failed, strerr=%s", strerror(ToolGetErrorCode()));
        stackcorePathNum++;
    }
    ToolScandirFree(namelist, totalNum);
    return stackcorePathNum;
}

#ifdef LOG_CORETRACE
static int32_t StackcoreMonitorScanStart(void)
{
    return LOG_SUCCESS;
}

static void StackcoreMonitorScanStop(void)
{
    return;
}
#else
static void RemoveStackCoreFile(const char *srcFileName)
{
    ONE_ACT_NO_LOG(srcFileName == NULL, return );
    int32_t ret;
    int32_t retryCnt = 0;
    const int32_t retryMax = 3;
    do {
        retryCnt++;
        ret = remove(srcFileName);
        if (ret == LOG_SUCCESS) {
            break;
        }
    } while (retryCnt != retryMax);

    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("remove source file failed, source_file=%s, result=%d, strerr=%s.", srcFileName, ret,
            strerror(ToolGetErrorCode()));
    } else {
        SELF_LOG_INFO("remove source file succeed, source_file=%s.", srcFileName);
    }
}

/* *
 * @brief        : scan dir and remove older files
 * @param [in]   : dirIndex     the index of the stackcore directory
 * @return       : -
 */
static void Scan(const int32_t dirIndex)
{
    int32_t i = 0;
    int32_t ret = 0;
    ToolDirent **namelist = NULL;
    char srcFileName[MAX_FULLPATH_LEN] = { 0 }; // include filepath and filename
    char path[MAX_FILEPATH_LEN] = { 0 };        // only the filepath

    ret = sprintf_s(path, MAX_FILEPATH_LEN, "%s%s", CORE_DEFAULT_PATH, g_stackcorePath[dirIndex]);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s failed, get the current path failed.");
        return;
    }

    (void)ToolMutexLock(&g_curDirIndexLock);
    g_curDirIndex = dirIndex;
    // get file lists
    int32_t totalNum = ToolScandir(path, &namelist, StackCoreFilter, SortByCreatetime);
    (void)ToolMutexUnLock(&g_curDirIndexLock);
    if ((totalNum < 0) || (totalNum > 0 && namelist == NULL)) {
        SELF_LOG_ERROR("scan directory failed, directory=%s, result=%d, strerr=%s.", path, totalNum,
            strerror(ToolGetErrorCode()));
        return;
    }

    if (totalNum <= MAX_RESERVE_FILE_NUMS) {
        ToolScandirFree(namelist, totalNum);
        return;
    }
    for (i = 0; i < totalNum - MAX_RESERVE_FILE_NUMS; i++) {
        ONE_ACT_WARN_LOG(namelist[i] == NULL, continue, "namelist[%d] is invalid.", i);
        (void)memset_s(srcFileName, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
        ret = snprintf_s(srcFileName, MAX_FULLPATH_LEN, MAX_FULLPATH_LEN - 1U, "%s%s", path, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s filename failed, result=%d, strerr=%s.", ret,
            strerror(ToolGetErrorCode()));

        // check file can access or not
        if (access(srcFileName, R_OK) != 0) {
            SELF_LOG_WARN("file cannot be accessed, file=%s, strerr=%s.", srcFileName, strerror(ToolGetErrorCode()));
            continue;
        }
        RemoveStackCoreFile(srcFileName);
    }
    ToolScandirFree(namelist, totalNum);
    return;
}

/* *
 * @brief        : Aging stackcore files
 * @param [in]arg: currently no use
 * @return       : LOG_SUCCESS success; LOG_FAILURE failed
 */
static void StackcoreScanEventProc(void *arg)
{
    (void)arg;

    // Traverse all subdirectories
    for (int32_t i = 0; i < g_dirNum; ++i) {
        (void)Scan(i);
    }
}

/* *
 * @brief         : Register a periodic event to age stackcore files
 * @param [in]    : -
 * @return        : LOG_SUCCESS success; LOG_FAILURE failed
 */
static int32_t StackcoreMonitorScanStart(void)
{
    EventAttr attr = { LOOP_TIME_EVENT, STACKCORE_SCAN_INTERVAL };
    EventHandle handle = EventAdd(StackcoreScanEventProc, NULL, &attr);
    if (handle == NULL) {
        SELF_LOG_ERROR("add stackcore scan event failed.");
        return LOG_FAILURE;
    }
    g_stackcoreMonitor.eventMonitor.scanMonitor.eventHandle = handle;
    return LOG_SUCCESS;
}

/* *
 * @brief         : Delete the periodic event for aging stackcore files
 * @param [in]    : -
 * @return        : LOG_SUCCESS success; LOG_FAILURE failed
 */
static void StackcoreMonitorScanStop(void)
{
    int32_t ret = 0;

    if (g_stackcoreMonitor.eventMonitor.scanMonitor.eventHandle == NULL) {
        SELF_LOG_WARN("no scan monitor is need to stop.");
        return;
    }
    ret = EventDelete(g_stackcoreMonitor.eventMonitor.scanMonitor.eventHandle);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("delete scan event failed, ret = %d.", ret);
        return;
    }
}
#endif
/* *
 * @brief             : Synchronize a single stackcore file to the host
 * @param [in]dirIndex: the index of stackcore directory
 * @param [in]fileName: file name of the stackcore file
 * @return            : LOG_SUCCESS success; LOG_FAILURE failed
 */
static void StackcoreSyncSingleFile(const int32_t dirIndex, const char *fileName)
{
    char srcPath[MAX_FULLPATH_LEN] = { 0 };
    char dstPath[MAX_FULLPATH_LEN] = { 0 };
    int32_t ret = 0;

    ret = sprintf_s(srcPath, MAX_FULLPATH_LEN, "%s%s%s", CORE_DEFAULT_PATH, g_stackcorePath[dirIndex], fileName);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s failed, get notify src path failed.");

    // the format of the host path: stackcore/dev-os-{id}
    ret = sprintf_s(dstPath, MAX_FULLPATH_LEN, "%s/%s/%s%s", STACKCORE_HOST_FILE_PATH, FileMonitorGetMasterIdStr(),
        g_stackcorePath[dirIndex], fileName);
    ONE_ACT_ERR_LOG(ret == -1, return, "sprintf_s failed, get notify dst path failed.");

    if (g_stackcoreMonitor.eventMonitor.fileSyncFunc != NULL) {
        g_stackcoreMonitor.eventMonitor.fileSyncFunc(srcPath, dstPath);
    }
}

/* *
 * @brief             : Synchronize files in the specified directory
 * @param [in]dirIndex: the index of the stackcore directory
 * @return            : LOG_SUCCESS success; LOG_FAILURE failed
 */
static int32_t StackcoreSyncSubDirExistFile(const int32_t dirIndex)
{
    int32_t i = 0;
    int32_t ret = 0;
    ToolDirent **namelist = NULL;
    char srcFileName[MAX_FULLPATH_LEN] = { 0 }; // include filepath and filename
    char path[MAX_FILEPATH_LEN] = { 0 };        // only the filepath

    ret = sprintf_s(path, MAX_FILEPATH_LEN, "%s%s", CORE_DEFAULT_PATH, g_stackcorePath[dirIndex]);
    if (ret == -1) {
        SELF_LOG_ERROR("sprintf_s failed, get the current path failed.");
        return LOG_FAILURE;
    }

    (void)ToolMutexLock(&g_curDirIndexLock);
    g_curDirIndex = dirIndex;
    // get file lists
    int32_t totalNum = ToolScandir(path, &namelist, StackCoreFilter, SortByCreatetime);
    (void)ToolMutexUnLock(&g_curDirIndexLock);
    if ((totalNum < 0) || (totalNum > 0 && namelist == NULL)) {
        SELF_LOG_ERROR("scan directory failed, directory=%s, result=%d, strerr=%s.", path, totalNum,
            strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    for (i = 0; i < totalNum; i++) {
        ONE_ACT_WARN_LOG(namelist[i] == NULL, continue, "namelist[%d] is invalid.", i);
        (void)memset_s(srcFileName, MAX_FULLPATH_LEN, 0, MAX_FULLPATH_LEN);
        ret = snprintf_s(srcFileName, MAX_FULLPATH_LEN, MAX_FULLPATH_LEN - 1U, "%s%s", path, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s filename failed, result=%d, strerr=%s.", ret,
            strerror(ToolGetErrorCode()));

        // check file can access or not
        if (access(srcFileName, R_OK) != 0) {
            SELF_LOG_WARN("file cannot be accessed, file=%s, strerr=%s.", srcFileName, strerror(ToolGetErrorCode()));
            continue;
        }

        // Synchronize a stackcore file
        StackcoreSyncSingleFile(dirIndex, namelist[i]->d_name);
    }

    ToolScandirFree(namelist, totalNum);
    return LOG_SUCCESS;
}

/* *
 * @brief         : Synchronize existing files after the session is established.
 * @param [in]    : -
 * @return        : -
 */
static void StackcoreSyncAllExistFile(void)
{
    for (int32_t i = 0; i < g_dirNum; ++i) {
        (void)StackcoreSyncSubDirExistFile(i);
    }
}

/* *
 * @brief          : delete the stackcore file sync arg from the list.
 * @param [in]node : arg to be deleted
 * @param [in]list : the arg list of the stackcore file inotify event
 * @return         : -
 */
static void StackcoreArgDelete(StackcoreFileSyncArg *arg, StackcoreFileSyncArg **list)
{
    StackcoreFileSyncArg *node = *list;
    StackcoreFileSyncArg *pre = NULL;
    StackcoreFileSyncArg *head = node;

    while (node != NULL) {
        if (arg == node) {
            if (pre == NULL) {
                head = node->next;
            } else {
                pre->next = node->next;
            }
            StackcoreFileSyncArg *tmp = node->next;
            XFREE(node);
            node = tmp;
            break;
        } else {
            pre = node;
            node = node->next;
        }
    }
    *list = head;
}

/* *
 * @brief          : Add the stackcore file sync arg to the list.
 * @param [in]node : arg to be saved
 * @param [in]list : the arg list of the stackcore file inotify event
 * @return         : -
 */
static void StackcoreArgAddToList(StackcoreFileSyncArg *node, StackcoreFileSyncArg **list)
{
    if ((*list) == NULL) {
        *list = node;
        return;
    }
    StackcoreFileSyncArg *tmp = *list;
    while (tmp->next != NULL) {
        tmp = tmp->next;
    }
    tmp->next = node;
}

/* *
 * @brief          : Release the arg list of the stackcore file inotify event
 * @param [in]     : -
 * @return         : -
 */
static void StackcoreDeleteArgList(void)
{
    (void)ToolMutexLock(&g_stackcoreMonitor.argListLock);
    StackcoreFileSyncArg *node = g_stackcoreMonitor.argList;
    StackcoreFileSyncArg *next = NULL;

    while (node != NULL) {
        next = node->next;
        XFREE(node);
        node = next;
    }
    g_stackcoreMonitor.argList = NULL;
    (void)ToolMutexUnLock(&g_stackcoreMonitor.argListLock);
}

/* *
 * @brief          : Synchronize the newly created file.
 * @param [in]arg  : the inotify_event parameter, include the newly created file name
 * @return         : LOG_SUCCESS success; LOG_FAILURE failed
 */
static void StackcoreFileSyncProc(void *arg)
{
    StackcoreFileSyncArg *syncArg = (StackcoreFileSyncArg *)arg;

    // Upload the newly created stackcore file
    StackcoreSyncSingleFile(syncArg->dirIndex, syncArg->fileName);

    (void)ToolMutexLock(&g_stackcoreMonitor.argListLock);
    StackcoreArgDelete(syncArg, &g_stackcoreMonitor.argList);
    (void)ToolMutexUnLock(&g_stackcoreMonitor.argListLock);
}

/* *
 * @brief          : Process the file creation event, register a delay event
 * @param [in]event: notify parameters, include the newly created file name
 * @return         : LOG_SUCCESS success; LOG_FAILURE failed
 */
static void StackcoreNotifyCreateEvent(struct inotify_event *event)
{
    int32_t i = 0;

    ONE_ACT_NO_LOG(g_stackcoreMonitor.eventMonitor.fileSyncFunc == NULL, return);

    for (i = 0; i < MAX_MONITOR_EVENT; i++) {
        if (event->wd == g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].wd) {
            break;
        }
    }

    ONE_ACT_ERR_LOG(i == MAX_MONITOR_EVENT, return, "no wd is matched.");

    StackcoreFileSyncArg *arg = (StackcoreFileSyncArg *)LogMalloc(sizeof(StackcoreFileSyncArg));
    ONE_ACT_ERR_LOG(arg == NULL, return, "malloc for bbox file sync arg failed, strerr = %s.",
        strerror(ToolGetErrorCode()));

    errno_t err = EOK;
    err = strcpy_s(arg->fileName, MAX_FILENAME_LEN, event->name);
    TWO_ACT_ERR_LOG(err != EOK, XFREE(arg), return, "strcpy_s failed, err = %d.", (int32_t)err);

    arg->dirIndex = i;

    // this event handle will be released immediately after trigger and no need to be saved.
    EventAttr attr = { DELAY_TIME_EVENT, STACKCORE_DELAY_TIME };
    EventHandle handle = EventAdd(StackcoreFileSyncProc, (void *)arg, &attr);
    if (handle == NULL) {
        SELF_LOG_ERROR("add stackcore file sync event failed.");

        // release the dynamic memory of arg
        XFREE(arg);
        return;
    }

    (void)ToolMutexLock(&g_stackcoreMonitor.argListLock);
    StackcoreArgAddToList(arg, &g_stackcoreMonitor.argList);
    (void)ToolMutexUnLock(&g_stackcoreMonitor.argListLock);
}


/* *
 * @brief          : process the stackcore file creation event
 * @param [in]arg  : currently no use
 * @return         : -
 */
static void StackcoreNotifyEventProc(void *arg)
{
    (void)arg;
    char buffer[FILE_MONITOR_EVENT_BUF_LEN];

    int32_t len = ToolRead(g_stackcoreMonitor.eventMonitor.notifyMonitor.fd, buffer, FILE_MONITOR_EVENT_BUF_LEN);
    if (len < 0) {
        return;
    }

    uint32_t i = 0;
    while (i < (uint32_t)len) {
        struct inotify_event *event = (struct inotify_event *)&buffer[i];
        i += (uint32_t)FILE_MONITOR_EVENT_SIZE + event->len;
        if (event->len == 0) {
            continue;
        }
        if ((event->mask & (uint32_t)IN_CREATE) != 0) {
            StackcoreNotifyCreateEvent(event);
            continue;
        }
    }
}

/* *
 * @brief          : Stop the created notify monitors.
 * @param [in]num  : the number of created notify monitors
 * @return         : -
 */
static void StackcoreStopNotifyMonitor(const int32_t num)
{
    for (int32_t i = 0; i < num; ++i) {
        if (g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].wd != 0) {
            (void)inotify_rm_watch(g_stackcoreMonitor.eventMonitor.notifyMonitor.fd,
                g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].wd);
            g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].wd = 0;
        }
    }

    (void)ToolClose(g_stackcoreMonitor.eventMonitor.notifyMonitor.fd);
    g_stackcoreMonitor.eventMonitor.notifyMonitor.fd = 0;
}

/* *
 * @brief         : Initialize the global variable and register a periodic event to age stackcore files
 * @param [in]func: the function pointer for synchronizing files
 * @return        : LOG_SUCCESS success; LOG_FAILURE failed
 */
int32_t StackcoreMonitorInit(FileMonitorSyncFunc func)
{
    int32_t ret = 0;

    // Save the function pointer for synchroning files to the host
    if (func == NULL) {
        SELF_LOG_WARN("file monitor sync function is null.");
    }
    g_stackcoreMonitor.eventMonitor.fileSyncFunc = func;

    // Get the subdirectory information, initialize  the global variable
    int32_t dirNum = InitStackCoreDir();
    if ((dirNum <= 0) || (dirNum > MAX_MONITOR_EVENT)) {
        SELF_LOG_ERROR("init stackcore directory failed, invalid dirNum(%d).", dirNum);

        g_stackcoreMonitor.eventMonitor.fileSyncFunc = NULL;
        return LOG_FAILURE;
    }

    g_dirNum = dirNum;

    // Register a periodic event to age stackcore files
    ret = StackcoreMonitorScanStart();
    if (ret != LOG_SUCCESS) {
        g_stackcoreMonitor.eventMonitor.fileSyncFunc = NULL;
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

/* *
 * @brief         : Delete the event for aging stackcore files and release the dynamic memory
 * @param [in]    : -
 * @return        : -
 */
void StackcoreMonitorExit(void)
{
    // first delete the event for aging stackcore files
    StackcoreMonitorScanStop();

    // then release the dynamic memory
    ToolPathListFree(g_stackcorePath, g_dirNum);
    g_stackcorePath = NULL;
}

/* *
 * @brief          : start the stackcore file monitor after the session is established.
 * @param [in]     : -
 * @return         : LOG_SUCCESS success; LOG_FAILURE failed
 */
int32_t StackcoreMonitorStart(void)
{
    int32_t tmpWd = 0;
    int32_t ret = 0;

    // Synchronize existing stackcore files
    StackcoreSyncAllExistFile();

    // Initialize the stackcore file creation notify monitor and event.
    g_stackcoreMonitor.eventMonitor.notifyMonitor.fd = inotify_init1(IN_NONBLOCK);
    if (g_stackcoreMonitor.eventMonitor.notifyMonitor.fd < 0) {
        SELF_LOG_ERROR("notify init failed, fd = %d.", g_stackcoreMonitor.eventMonitor.notifyMonitor.fd);
        g_stackcoreMonitor.eventMonitor.notifyMonitor.fd = 0;
        return LOG_FAILURE;
    }

    for (int32_t i = 0; i < g_dirNum; ++i) {
        ret = sprintf_s(g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].fileName, MAX_FULLPATH_LEN, "%s%s/",
            CORE_DEFAULT_PATH, g_stackcorePath[i]);
        if (ret == -1) {
            SELF_LOG_ERROR("sprintf_s for file name failed, add watch %d failed.", i);
            StackcoreStopNotifyMonitor(i);
            return LOG_FAILURE;
        }

        // Check whether the monitored directory exists.
        if (ToolAccess(g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].fileName) != LOG_SUCCESS) {
            SELF_LOG_ERROR("dir is not exist, add watch %d failed, filePath = %s.", i, g_stackcorePath[i]);
            StackcoreStopNotifyMonitor(i);
            return LOG_FAILURE;
        }

        tmpWd = inotify_add_watch(g_stackcoreMonitor.eventMonitor.notifyMonitor.fd,
            g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].fileName, IN_CREATE);
        if (tmpWd < 0) {
            SELF_LOG_ERROR("notify add watch %d failed, filePath = %s, tmpWd = %d.", i, g_stackcorePath[i], tmpWd);
            StackcoreStopNotifyMonitor(i);
            return LOG_FAILURE;
        }

        g_stackcoreMonitor.eventMonitor.notifyMonitor.event[i].wd = tmpWd;
    }

    EventAttr attr = { LOOP_TIME_EVENT, STACKCORE_NOTIFY_INTERVAL };
    EventHandle handle = EventAdd(StackcoreNotifyEventProc, NULL, &attr);
    if (handle == NULL) {
        SELF_LOG_ERROR("add stackcore notify event failed.");
        StackcoreStopNotifyMonitor(g_dirNum);
        return LOG_FAILURE;
    }
    g_stackcoreMonitor.eventMonitor.notifyMonitor.eventHandle = handle;

    return LOG_SUCCESS;
}

/* *
 * @brief          : stop the stackcore file monitor after the session is disconnected.
 * @param [in]     : -
 * @return         : LOG_SUCCESS success; LOG_FAILURE failed
 */
int32_t StackcoreMonitorStop(void)
{
    int32_t ret = 0;

    if (g_stackcoreMonitor.eventMonitor.notifyMonitor.eventHandle == NULL) {
        SELF_LOG_WARN("no notify monitor is need to stop.");
        return LOG_FAILURE;
    }
    ret = EventDelete(g_stackcoreMonitor.eventMonitor.notifyMonitor.eventHandle);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("delete notify event failed, ret = %d.", ret);
    }
    g_stackcoreMonitor.eventMonitor.notifyMonitor.eventHandle = NULL;

    StackcoreStopNotifyMonitor(g_dirNum);

    StackcoreDeleteArgList();

    return LOG_SUCCESS;
}
