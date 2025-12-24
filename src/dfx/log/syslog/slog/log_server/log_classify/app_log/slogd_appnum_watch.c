/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_appnum_watch.h"
#include "log_pm_sig.h"
#include "log_config_api.h"
#include "log_common.h"
#include "log_to_file.h"
#include "slogd_flush.h"
#include "log_path_mgr.h"
#include "slogd_config_mgr.h"

#define OPERATE_MODE 0750
#define MAX_RETRY_COUNT 3
#define SCAN_INTERVAL 15000
#define WATCH_DEFAULT_THREAD_ATTR {1, 0, 0, 0, 0, 1, 128 * 1024} // Default ThreadSize(128KB)
#define MAX_FILE_NAME_LEN 256

typedef struct {
    ToolStat aStatbuff;
    ToolStat bStatbuff;
    ToolStat aDirStatbuff;
    ToolStat bDirStatbuff;
    ToolDirent **listA;
    ToolDirent **listB;
    char aDirName[MAX_FILE_NAME_LEN];
    char bDirName[MAX_FILE_NAME_LEN];
    char aFileName[MAX_FILE_NAME_LEN];
    char bFileName[MAX_FILE_NAME_LEN];
} SortArg;

typedef struct {
    ToolUserBlock block;
    ToolThread tid;
} ThreadInfo;

typedef struct {
    int logType;
    char appLogPath[CFG_LOGAGENT_PATH_MAX_LENGTH + 1U];
} ThreadArg;

STATIC ThreadArg g_args[LOG_TYPE_NUM];

/**
 * @brief CheckAppDirIfExist: check app log path if existed or not, if not, make dir
 * @param [in]appLogPath: app log path
 * @return: LogRt, SUCCESS/MKDIR_FAILED/ARGV_NULL
 */
STATIC LogRt CheckAppDirIfExist(const char *appLogPath)
{
    ONE_ACT_NO_LOG(appLogPath == NULL, return ARGV_NULL);
    if (access(appLogPath, F_OK) != 0) {
        int ret = ToolMkdir(appLogPath, (toolMode)(OPERATE_MODE));
        if (ret != SYS_OK) {
            SELF_LOG_ERROR("mkdir %s failed, result=%d, strerr=%s.", appLogPath, ret, strerror(ToolGetErrorCode()));
            return MKDIR_FAILED;
        }
        SELF_LOG_INFO("mkdir %s succeed.", appLogPath);
    }
    return SUCCESS;
}

/**
* @brief AppLogDirFilter: scandir filter func
* @param [in]dir: file struct which include the path and filename
* @return: FILTER_NOK/FILTER_OK
*/
STATIC int32_t AppLogDirFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((dir->d_type == DT_DIR) &&
        ((LogStrStartsWith(dir->d_name, DEVICE_APP_HEAD) != false) ||
         (LogStrStartsWith(dir->d_name, AOS_CORE_DEVICE_APP_HEAD) != false))) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

STATIC int32_t AppLogFileFilter(const ToolDirent *dir)
{
    ONE_ACT_NO_LOG(dir == NULL, return FILTER_NOK);
    if ((LogStrStartsWith(dir->d_name, DEVICE_APP_HEAD) != false) ||
        (LogStrStartsWith(dir->d_name, AOS_CORE_DEVICE_APP_HEAD) != false)) {
        return FILTER_OK;
    }
    return FILTER_NOK;
}

/**
* @brief ScanAndGetDirFile: scan and get dir and file info
* @param [in]sortArg: sort args
* @param [in]path: log path
* @param [in]a: log file name, log filename
* @param [in]b: log file name, log filename
* @return: 0:success 1/2:failed
*/
STATIC int32_t ScanAndGetDirFile(SortArg *sortArg, const char *path, const ToolDirent **a, const ToolDirent **b)
{
    int32_t ret = snprintf_s(sortArg->aDirName, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s", path, (*a)->d_name);
    ONE_ACT_ERR_LOG(ret == -1, return SYS_ERROR, "snprintf_s A dir failed, strerr=%s", strerror(ToolGetErrorCode()));
    ret = snprintf_s(sortArg->bDirName, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s", path, (*b)->d_name);
    ONE_ACT_ERR_LOG(ret == -1, return SYS_ERROR, "snprintf_s B dir failed, strerr=%s", strerror(ToolGetErrorCode()));
    ret = ToolStatGet(sortArg->aDirName, &sortArg->aDirStatbuff);
    ONE_ACT_ERR_LOG(ret != SYS_OK,  return SYS_ERROR, "get status %s failed, strerr=%s",
                    sortArg->aDirName, strerror(ToolGetErrorCode()));
    ret = ToolStatGet(sortArg->bDirName, &sortArg->bDirStatbuff);
    ONE_ACT_ERR_LOG(ret != SYS_OK, return SYS_ERROR, "get status %s failed, strerr=%s",
                    sortArg->aDirName, strerror(ToolGetErrorCode()));
    return SYS_OK;
}

/**
* @brief FreeDir: free dir
* @param [in]listA: file lists of dir a
* @param [in]numA: num of files in dir a
* @param [in]listB: file lists of dir b
* @param [in]numB: num of files in dir b
* @return: void
*/
STATIC void FreeDir(ToolDirent **listA, int numA, ToolDirent **listB, int numB)
{
    ToolScandirFree(listA, numA);
    ToolScandirFree(listB, numB);
}

/**
* @brief GetSortResult: get sort result accord to time
* @param [in]sortArg: sort args
* @param [in]type: 0, numA <= 0 and numB > 0; 1, numA > 0 and numB <= 0
* @param [in]numA: num of files in dir a
* @param [in]numB: num of files in dir b
* @return: TRUE(1) a's timestamp newer than b
*          FALSE(0) a's timestamp older than b
*/
STATIC int32_t GetSortResult(SortArg *sortArg, int type, int numA, int numB)
{
    if (type == 0) {
        int ret = snprintf_s(sortArg->bFileName, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s",
                             sortArg->bDirName, sortArg->listB[numB - 1]->d_name);
        if (ret == -1) {
            SELF_LOG_ERROR("snprintf_s B dir failed, strerr=%s", strerror(ToolGetErrorCode()));
            return SYS_ERROR;
        }
        ONE_ACT_ERR_LOG(ToolStatGet(sortArg->bFileName, &sortArg->bStatbuff) != SYS_OK, return SYS_ERROR,
                        "get status %s failed, strerr=%s", sortArg->bFileName, strerror(ToolGetErrorCode()));
        FreeDir(sortArg->listA, numA, sortArg->listB, numB);
        return (sortArg->aDirStatbuff.st_mtime > sortArg->bStatbuff.st_mtime) ? 1 : 0;
    } else {
        int ret = snprintf_s(sortArg->aFileName, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s",
                             sortArg->aDirName, sortArg->listA[numA - 1]->d_name);
        if (ret == -1) {
            SELF_LOG_ERROR("snprintf_s A dir failed, strerr=%s", strerror(ToolGetErrorCode()));
            return SYS_ERROR;
        }
        ONE_ACT_ERR_LOG(ToolStatGet(sortArg->aFileName, &sortArg->aStatbuff) != SYS_OK, return SYS_ERROR,
                        "get status %s failed, strerr=%s", sortArg->aFileName, strerror(ToolGetErrorCode()));
        FreeDir(sortArg->listA, numA, sortArg->listB, numB);
        return (sortArg->aStatbuff.st_mtime > sortArg->bDirStatbuff.st_mtime) ? 1 : 0;
    }
}

STATIC bool IsNULLDirOrFile(const char *path, const ToolDirent **a, const ToolDirent **b)
{
    return (path == NULL) || (a == NULL) || ((*a) == NULL) || (b == NULL) || ((*b) == NULL);
}

/**
* @brief SlogdApplogSortFileFunc: sort log files by timestamp in log filename
* @param [in]path: log dir
* @param [in]a: log file name, log filename
* @param [in]b: log file name, log filename
* @return: TRUE(1) a's timestamp newer than b
*          FALSE(0) a's timestamp older than b
*/
int32_t SlogdApplogSortFileFunc(const char *path, const ToolDirent **a, const ToolDirent **b)
{
    SortArg sortArg;
    (void)memset_s(&sortArg, sizeof(sortArg), 0, sizeof(sortArg));
    if (IsNULLDirOrFile(path, a, b)) {
        return 1;
    }

    int ret = ScanAndGetDirFile(&sortArg, path, a, b);
    ONE_ACT_NO_LOG(ret == SYS_ERROR, return 1);
    int numA = ToolScandir(sortArg.aDirName, &sortArg.listA, AppLogFileFilter, alphasort);
    int numB = ToolScandir(sortArg.bDirName, &sortArg.listB, AppLogFileFilter, alphasort);
    if ((numA <= 0) && (numB <= 0)) {
        FreeDir(sortArg.listA, numA, sortArg.listB, numB);
        return (sortArg.aDirStatbuff.st_mtime > sortArg.bDirStatbuff.st_mtime) ? 1 : 0;
    }

    if ((numA <= 0) && (numB > 0)) {
        ret = GetSortResult(&sortArg, 0, numA, numB);
        ONE_ACT_NO_LOG(ret == SYS_ERROR, goto SORTEXIT);
        return ret;
    }

    if ((numA > 0) && (numB <= 0)) {
        ret = GetSortResult(&sortArg, 1, numA, numB);
        ONE_ACT_NO_LOG(ret == SYS_ERROR, goto SORTEXIT);
        return ret;
    }

    // find newest log file in dir to judge dir new or old
    ret = snprintf_s(sortArg.aFileName, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s",
                     sortArg.aDirName, sortArg.listA[numA - 1]->d_name);
    ONE_ACT_ERR_LOG(ret == -1, goto SORTEXIT, "snprintf_s A dir failed, strerr=%s", strerror(ToolGetErrorCode()));
    ret = snprintf_s(sortArg.bFileName, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s",
                     sortArg.bDirName, sortArg.listB[numB - 1]->d_name);
    ONE_ACT_ERR_LOG(ret == -1, goto SORTEXIT, "snprintf_s B dir failed, strerr=%s", strerror(ToolGetErrorCode()));

    ONE_ACT_ERR_LOG(ToolStatGet(sortArg.aFileName, &sortArg.aStatbuff) != SYS_OK,
                    goto SORTEXIT, "get status %s failed, strerr=%s", sortArg.aFileName, strerror(ToolGetErrorCode()));
    ONE_ACT_ERR_LOG(ToolStatGet(sortArg.bFileName, &sortArg.bStatbuff) != SYS_OK,
                    goto SORTEXIT, "get status %s failed, strerr=%s", sortArg.bFileName, strerror(ToolGetErrorCode()));
    FreeDir(sortArg.listA, numA, sortArg.listB, numB);
    return (sortArg.aStatbuff.st_mtime > sortArg.bStatbuff.st_mtime) ? 1 : 0;
SORTEXIT:
    FreeDir(sortArg.listA, numA, sortArg.listB, numB);
    return 1;
}

STATIC int32_t RemoveDir(const char *dir)
{
    int res = SYS_OK;
    ToolDirent **namelist = NULL;
    int totalNum = ToolScandir(dir, &namelist, AppLogFileFilter, NULL);
    for (int32_t i = 0; i < totalNum; i++) {
        char fileName[MAX_FILE_NAME_LEN] = { 0 };
        int ret = snprintf_s(fileName, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s", dir, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));
        if (remove(fileName) != SYS_OK) {
            SELF_LOG_INFO("remove app log file, fileName=%s.", fileName);
            res = SYS_ERROR;
        }
    }
    (void)rmdir(dir);
    ToolScandirFree(namelist, totalNum);
    return res;
}

STATIC void RemoveAppLogDir(int logType, const char *dir)
{
    int ret;
    ONE_ACT_NO_LOG(dir == NULL, return);
    char dstDir[MAX_FILE_NAME_LEN] = { 0 };

    if ((logType < (int)LOG_TYPE_NUM) && (logType >= (int)DEBUG_LOG)) {
        ret = snprintf_s(dstDir, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s",
                         g_args[logType].appLogPath, dir);
    } else {
        ret = snprintf_s(dstDir, MAX_FILE_NAME_LEN, MAX_FILE_NAME_LEN - 1, "%s/%s",
                         g_args[DEBUG_LOG].appLogPath, dir);
    }

    ONE_ACT_ERR_LOG(ret == -1, return, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));
    if (access(dstDir, F_OK) != 0) {
        return;
    }
    int retryCnt = 0;
    do {
        retryCnt++;
        ret = RemoveDir(dstDir);
        if (ret == SYS_OK) {
            break;
        }
    } while (retryCnt != MAX_RETRY_COUNT);

    if (ret != SYS_OK) {
        SELF_LOG_ERROR("remove app log dir failed, dir=%s, result=%d, strerr=%s.",
                       dstDir, ret, strerror(ToolGetErrorCode()));
    } else {
        SELF_LOG_INFO("remove app log dir succeed, dir=%s.", dstDir);
    }
}

/**
* @brief RemoveOldAppDirs: remove older files and keep max file number
* @param [in]logType: log type, include debug, security, run
* @param [in]namelist: all device-app directory
* @param [in]totalNum: app directory number
* @return: void
*/
STATIC void RemoveOldAppDirs(int logType, ToolDirent **namelist, int totalNum)
{
    ONE_ACT_NO_LOG(namelist == NULL, return);

    int32_t start = 0;
    const char *path = g_args[logType].appLogPath;
    int32_t deleteNum = totalNum - SlogdConfigMgrGetDeviceAppDirNums();
    while (start < deleteNum) {
        // find the oldest directory
        int32_t point = start;
        for (int32_t i = start; i < totalNum; i++) {
            const ToolDirent *cur = namelist[point];
            const ToolDirent *new = namelist[i];
            point = (SlogdApplogSortFileFunc(path, &cur, &new) == 0) ? point : i;
        }
        if (point != start) {
            // switch the oldest item to [start]
            ToolDirent *temp = namelist[point];
            namelist[point] = namelist[start];
            namelist[start] = temp;
        }
        RemoveAppLogDir(logType, namelist[start]->d_name);
        start++;
    }
}

/**
* @brief ScanAndTrans: scan dir and remove older files
* @return: SUCCESS/MKDIR_FAILED/CHANGE_OWNER_FAILED/SCANDIR_DIR_FAILED
*/
STATIC LogRt ScanAppLog(const char *path, int logType)
{
    ToolDirent **namelist = NULL;
    // get file lists
    int32_t totalNum = ToolScandir(path, &namelist, AppLogDirFilter, NULL);
    if ((totalNum < 0) || ((totalNum > 0) && (namelist == NULL))) {
        SELF_LOG_ERROR("scan directory failed, result=%d, strerr=%s.", totalNum, strerror(ToolGetErrorCode()));
        return SCANDIR_DIR_FAILED;
    }
    if (totalNum <= SlogdConfigMgrGetDeviceAppDirNums()) {
        ToolScandirFree(namelist, totalNum);
        return SUCCESS;
    }
    RemoveOldAppDirs(logType, namelist, totalNum);
    ToolScandirFree(namelist, totalNum);
    return SUCCESS;
}

STATIC void *AppLogWatcher(const ArgPtr arg)
{
    const ThreadArg *input = (ThreadArg *)arg;

    NO_ACT_WARN_LOG(ToolSetThreadName("LogAppDirAging") != SYS_OK, "can not set thread name(LogAppDirAging)");

    while (LogGetSigNo() == 0) {
        for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; i++) {
            if (strlen((input + i)->appLogPath) != 0) {
                const char *path = (input + i)->appLogPath;
                int32_t logType = (input + i)->logType;
                ONE_ACT_ERR_LOG(CheckAppDirIfExist(path) != SUCCESS, continue, "path %s is not exist.", path);
                LogRt ret = ScanAppLog(path, logType);
                NO_ACT_WARN_LOG(ret != SUCCESS, "can not scan directory but continue, result=%d.", (int32_t)ret);
            }
        }
        (void)ToolSleep(SCAN_INTERVAL);
    }

    SELF_LOG_ERROR("Thread(AppLogWatcher) quit, signal=%d.", LogGetSigNo());
    return NULL;
}

STATIC void CreateThread(void)
{
    ToolThread appLogWatchThreadID = 0;
    ToolUserBlock appLogWatchThreadInfo;
    appLogWatchThreadInfo.procFunc = AppLogWatcher;
    appLogWatchThreadInfo.pulArg = g_args;
    ToolThreadAttr threadAttr = WATCH_DEFAULT_THREAD_ATTR;
    if (ToolCreateTaskWithThreadAttr(&appLogWatchThreadID, &appLogWatchThreadInfo, &threadAttr) != SYS_OK) {
        SELF_LOG_ERROR("create thread(AppLogWatcher) failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return;
    }
    SELF_LOG_INFO("create thread(AppLogWatcher) succeed.");
    return;
}

void CreateAppLogWatchThread(void)
{
    // get config
    char *rootPath = LogGetRootPath();
    ONE_ACT_ERR_LOG(rootPath == NULL, return, "Root path is null and Thread(AppLogWatcher) quit.");

    g_args[(int32_t)DEBUG_LOG].logType = (int32_t)DEBUG_LOG;
    int ret = snprintf_s(g_args[DEBUG_LOG].appLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U, CFG_LOGAGENT_PATH_MAX_LENGTH,
                         "%s/%s", rootPath, DEBUG_DIR_NAME);
    ONE_ACT_ERR_LOG(ret == -1, return, "get debug app path failed and Thread(AppLogWatcher) quit.");

    g_args[(int32_t)SECURITY_LOG].logType = (int32_t)SECURITY_LOG;
    ret = snprintf_s(g_args[SECURITY_LOG].appLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U, CFG_LOGAGENT_PATH_MAX_LENGTH,
                     "%s/%s", rootPath, SECURITY_DIR_NAME);
    ONE_ACT_ERR_LOG(ret == -1, return, "get security app path failed and Thread(AppLogWatcher) quit.");

    g_args[(int32_t)RUN_LOG].logType = (int32_t)RUN_LOG;
    ret = snprintf_s(g_args[RUN_LOG].appLogPath, CFG_LOGAGENT_PATH_MAX_LENGTH + 1U, CFG_LOGAGENT_PATH_MAX_LENGTH,
                     "%s/%s", rootPath, RUN_DIR_NAME);
    ONE_ACT_ERR_LOG(ret == -1, return, "get run app path failed and Thread(AppLogWatcher) quit.");
    CreateThread();
}
