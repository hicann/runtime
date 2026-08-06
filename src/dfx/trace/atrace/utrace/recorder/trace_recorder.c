/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "trace_recorder.h"
#include "adiag_print.h"
#include "trace_system_api.h"
#include "trace_attr.h"
#include "trace_types.h"
#include <stdarg.h>

#define TRACE_FILE_ASCEND_PATH  "ascend"
#define TRACE_FILE_SUB_PATH     "atrace"
#define TRACE_DIR_HEAD          "trace"
#define TRACE_DIR_MODE          0750U
#define TRACE_FILE_MODE         0640U
#define FILE_SEPARATOR          "/"

#define TRACE_DIR_NUM_DEFAULT   10
#define TRACE_DIR_NUM_MIN       10
#define TRACE_DIR_NUM_MAX       1000

STATIC TraceRecorderMgr *g_recorderMgr = NULL;

#ifndef ATRACE_ROOT_PATH
STATIC TraStatus TraceGetHomeDir(char *const homedir, uint32_t len)
{
    ADIAG_CHK_NULL_PTR(homedir, return TRACE_FAILURE);

    int32_t ret;
    const struct passwd *userInfo = getpwuid(getuid());
    if (userInfo != NULL) {
        ret = strcpy_s(homedir, len, userInfo->pw_dir);
    } else {
        ret = strcpy_s(homedir, len, "");
    }
    ADIAG_CHK_EXPR_ACTION(ret != EOK, return TRACE_FAILURE,
        "strcpy_s home directory failed, result=%d, strerr=%s.", ret, strerror(AdiagGetErrorCode()));

    ADIAG_INF("home_directory=%s.", homedir);
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceMkdirRecur(const char *dirPath)
{
    TraStatus err = TRACE_SUCCESS;
    char *newDir = strdup(dirPath);
    if (newDir == NULL) {
        ADIAG_ERR("strdup failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    char *path = (char *)AdiagMalloc(MAX_FILEDIR_LEN + 1U);
    ADIAG_CHK_EXPR_ACTION(path == NULL, return TRACE_FAILURE,
        "malloc path failed, strerr=%s", strerror(AdiagGetErrorCode()));

    char *tmpNewDir = newDir;
    char *tmpPath = path;
    char *token = strsep(&newDir, FILE_SEPARATOR);
    while (token != NULL) {
        if (strcmp(token, "") == 0) {
            token = strsep(&newDir, FILE_SEPARATOR);
            continue;
        }
        char nextDir[MAX_FILEDIR_LEN + 1U] = { 0 };
        int32_t ret = snprintf_s(nextDir, MAX_FILEDIR_LEN + 1U, MAX_FILEDIR_LEN, "/%s", token);
        if (ret == -1) {
            ADIAG_ERR("copy data failed, strerr=%s.", strerror(AdiagGetErrorCode()));
            err = TRACE_FAILURE;
            break;
        }
        ret = strncat_s(path, MAX_FILEDIR_LEN + 1U, nextDir, strlen(nextDir));
        if (ret != 0) {
            ADIAG_ERR("strncat_s failed, strerr=%s.", strerror(AdiagGetErrorCode()));
            err = TRACE_FAILURE;
            break;
        }
        err = TraceMkdir((const char *)path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
        if (err != TRACE_SUCCESS) {
            ADIAG_ERR("mkdir failed, strerr=%s.", strerror(AdiagGetErrorCode()));
            break;
        }
        token = strsep(&newDir, FILE_SEPARATOR);
    }
    ADIAG_SAFE_FREE(tmpPath);
    ADIAG_SAFE_FREE(tmpNewDir);
    return err;
}

STATIC TraStatus TraceNormalizeEnvPath(char *envDir, uint32_t len)
{
    if ((envDir == NULL) || (len == 0U) || (envDir[0] == '\0')) {
        ADIAG_WAR("ASCEND_WORK_PATH is invalid.");
        return TRACE_FAILURE;
    }
    if (envDir[0] == '/') {
        return TRACE_SUCCESS;
    }

    char cwd[MAX_FILEDIR_LEN + 1U] = { 0 };
    if (getcwd(cwd, sizeof(cwd)) == NULL) {
        ADIAG_WAR("get current directory failed, strerr=%s.", strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }

    char absPath[MAX_FILEDIR_LEN + 1U] = { 0 };
    int32_t ret = snprintf_s(absPath, sizeof(absPath), sizeof(absPath) - 1U, "%s/%s", cwd, envDir);
    if (ret == -1) {
        ADIAG_WAR("build ASCEND_WORK_PATH absolute path failed, path may exceed %u bytes, cwd=%s, env=%s.",
            MAX_FILEDIR_LEN, cwd, envDir);
        return TRACE_FAILURE;
    }
    ret = strcpy_s(envDir, len, absPath);
    if (ret != EOK) {
        ADIAG_WAR("copy ASCEND_WORK_PATH absolute path failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceGetValidPath(char *envDir, uint32_t len)
{
    if (TraceNormalizeEnvPath(envDir, len) != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    if ((TraceAccess(envDir, F_OK) != EN_OK) && (TraceMkdirRecur(envDir) != EN_OK)) {
        ADIAG_WAR("path %s doesn't exist.", envDir);
        return TRACE_FAILURE;
    }
    if (TraceAccess(envDir, W_OK) != EN_OK) {
        ADIAG_WAR("path %s doesn't have write permission.", envDir);
        return TRACE_FAILURE;
    }

    char *realPath = (char *)AdiagMalloc(TRACE_MAX_PATH);
    ADIAG_CHK_EXPR_ACTION(realPath == NULL, return TRACE_FAILURE,
        "malloc real path failed, strerr=%s", strerror(AdiagGetErrorCode()));

    if ((TraceRealPath(envDir, realPath, TRACE_MAX_PATH) != EN_OK) && (AdiagGetErrorCode() != ENOENT)) {
        ADIAG_WAR("can not get realpath, path=%s, strerr=%s.", envDir, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(realPath);
        return TRACE_FAILURE;
    }
    int32_t res = snprintf_truncated_s(envDir, len, "%s", realPath);
    if (res < 0) {
        ADIAG_ERR("get path failed, ret=%d.", res);
        ADIAG_SAFE_FREE(realPath);
        return TRACE_FAILURE;
    }
    ADIAG_SAFE_FREE(realPath);
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceGetEnvPath(char *envDir, uint32_t len)
{
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_WORK_PATH, (env));
    TraStatus ret = TraceHandleEnvString(env, envDir, len);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    ADIAG_RUN_INF("get path by env ASCEND_WORK_PATH: %s", envDir);

    ret = TraceGetValidPath(envDir, len);
    if (ret != TRACE_SUCCESS) {
        ADIAG_RUN_INF("can not use ASCEND_WORK_PATH, please check the warning logs.");
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}
#endif

/**
* @brief      get dir num by env
* @param [in] mgr: recorder manager
* @return     void
*/
STATIC void TraceInitDirNum(TraceRecorderMgr *mgr)
{
    mgr->maxDirNum = TRACE_DIR_NUM_DEFAULT;
    const char *env = NULL;
    MM_SYS_GET_ENV(MM_ENV_ASCEND_TRACE_RECORD_NUM, (env));
    if (env == NULL) {
        ADIAG_INF("doesn't set env ASCEND_TRACE_RECORD_NUM, use default dir num=%d.", mgr->maxDirNum);
        return;
    }

    ADIAG_RUN_INF("get dir num by env ASCEND_TRACE_RECORD_NUM: %s", env);
    int32_t value = -1;
    if ((AdiagStrToInt(env, &value) == TRACE_SUCCESS) && (value <= TRACE_DIR_NUM_MAX) && (value >= TRACE_DIR_NUM_MIN)) {
        ADIAG_INF("set dir num=%d by env ASCEND_TRACE_RECORD_NUM.", value);
        mgr->maxDirNum = value;
    } else {
        ADIAG_WAR("invalid value [%s] for ASCEND_TRACE_RECORD_NUM, expected range: [10, 1000]. Use default dir num=%d.", env, mgr->maxDirNum);
    }
}

/**
* @brief      get root path
* @param [in] mgr: recorder manager
* @return     TraStatus
*/
STATIC TraStatus TraceInitRootPath(TraceRecorderMgr *mgr)
{
    ADIAG_CHK_NULL_PTR(mgr, return TRACE_FAILURE);
    int32_t res;

#ifdef ATRACE_ROOT_PATH
    res = snprintf_truncated_s(mgr->rootPath, MAX_FILEDIR_LEN + 1U, "%s", ATRACE_ROOT_PATH);
    if (res < 0) {
        ADIAG_ERR("snprintf_truncated_s failed, ret=%d.", res);
        return TRACE_FAILURE;
    }
#else
    char *path = (char *)AdiagMalloc(MAX_FILEDIR_LEN + 1U);
    ADIAG_CHK_EXPR_ACTION(path == NULL, return TRACE_FAILURE,
        "malloc root path failed, strerr=%s", strerror(AdiagGetErrorCode()));

    TraStatus ret = TraceGetEnvPath(path, MAX_FILEDIR_LEN + 1U);
    if (ret == TRACE_SUCCESS) {
        res = snprintf_truncated_s(mgr->rootPath, MAX_FILEDIR_LEN + 1U, "%s", path);
    } else {
        // get process user home path
        ret = TraceGetHomeDir(path, MAX_FILEDIR_LEN + 1U);
        if (ret != TRACE_SUCCESS) {
            ADIAG_SAFE_FREE(path);
            ADIAG_ERR("get home directory failed, ret=%d.", ret);
            return TRACE_FAILURE;
        }
        res = snprintf_truncated_s(mgr->rootPath, MAX_FILEDIR_LEN + 1U, "%s/%s",
            path, TRACE_FILE_ASCEND_PATH);
    }

    if (res < 0) {
        ADIAG_SAFE_FREE(path);
        ADIAG_ERR("snprintf_truncated_s failed, ret=%d.", res);
        return TRACE_FAILURE;
    }
    ADIAG_SAFE_FREE(path);
#endif
    ADIAG_INF("use root path: %s", mgr->rootPath);
    return TRACE_SUCCESS;
}

STATIC void TraceRecorderClearList(TraceDirList *list)
{
    TraceDirNode *curNode = list->head;
    TraceDirNode *next = NULL;
    while (curNode != NULL) {
        next = curNode->next;
        ADIAG_SAFE_FREE(curNode);
        curNode = next;
    }
    list->count = 0;
}

TraStatus TraceRecorderInit(void)
{
    g_recorderMgr = (TraceRecorderMgr *)AdiagMalloc(sizeof(TraceRecorderMgr));
    ADIAG_CHK_EXPR_ACTION(g_recorderMgr == NULL, return TRACE_FAILURE, "init recorder mgr failed.");

    TraStatus ret = TraceInitRootPath(g_recorderMgr);
    if (ret != TRACE_SUCCESS) {
        ADIAG_SAFE_FREE(g_recorderMgr);
        ADIAG_ERR("init file root path failed, ret=%d.", ret);
        return TRACE_FAILURE;
    }

    TraceInitDirNum(g_recorderMgr);

    return TRACE_SUCCESS;
}

void TraceRecorderExit(void)
{
    if (g_recorderMgr == NULL) {
        ADIAG_WAR("file list is null.");
        return;
    }

    TraceRecorderClearList(&g_recorderMgr->hostDirList);
    TraceRecorderClearList(&g_recorderMgr->deviceDirList);
    if (g_recorderMgr->exitDir != NULL) {
        ADIAG_SAFE_FREE(g_recorderMgr->exitDir);
    }
    ADIAG_SAFE_FREE(g_recorderMgr);
}

STATIC TraceDirNode *TraceRecorderListPopHead(TraceDirList *dirList)
{
    (void)AdiagLockGet(&dirList->lock);
    TraceDirNode *dirNode = dirList->head;
    dirList->head = dirNode->next;
    if (dirList->head != NULL) {
        dirList->head->prev = NULL;
    } else {
        dirList->tail = NULL;
    }
    dirNode->next = NULL;
    dirNode->prev = NULL;
    dirList->count--;
    (void)AdiagLockRelease(&dirList->lock);
    return dirNode;
}

STATIC void TraceRecorderListAppend(TraceDirList *dirList, TraceDirNode *newNode)
{
    (void)AdiagLockGet(&dirList->lock);
    newNode->prev = dirList->tail;
    newNode->next = NULL;
    if (dirList->tail != NULL) {
        dirList->tail->next = newNode;
    } else {
        dirList->head = newNode;
    }
    dirList->tail = newNode;
    dirList->count++;
    (void)AdiagLockRelease(&dirList->lock);
}

STATIC TraceDirNode *TraceRecorderListFind(TraceDirList *dirList, const char *dirPath)
{
    (void)AdiagLockGet(&dirList->lock);
    TraceDirNode *curNode = dirList->head;
    while (curNode != NULL) {
        if (strcmp(curNode->dirPath, dirPath) == 0) {
            (void)AdiagLockRelease(&dirList->lock);
            return curNode;
        }
        curNode = curNode->next;
    }
    (void)AdiagLockRelease(&dirList->lock);
    return NULL;
}

STATIC void TraceRecorderSaveNode(const TraceDirInfo *dirInfo, TraceDirNode *dirNew)
{
    // if exit_event, no need to aging
    if (strncmp(dirInfo->eventName, TRACER_EVENT_EXIT, strlen(TRACER_EVENT_EXIT)) == 0) {
        if (g_recorderMgr->exitDir != NULL) {
            ADIAG_SAFE_FREE(g_recorderMgr->exitDir);
        }
        g_recorderMgr->exitDir = dirNew;
        return;
    }

    TraceDirList *dirList = (dirInfo->isDevice) ? &g_recorderMgr->deviceDirList : &g_recorderMgr->hostDirList;
    // delete node and age the dir
    if (dirList->count >= g_recorderMgr->maxDirNum) {
        TraceDirNode *deleteNode = TraceRecorderListPopHead(dirList);
        TraStatus ret = TraceRmdir(deleteNode->dirPath);
        if (ret != 0) {
            ADIAG_WAR("can not remove dir %s, ret=%d, strerr=%s.", deleteNode->dirPath, ret, strerror(AdiagGetErrorCode()));
        } else {
            ADIAG_INF("remove dir %s successfully.", deleteNode->dirPath);
        }
        ADIAG_SAFE_FREE(deleteNode);
    }
    // append new node
    TraceRecorderListAppend(dirList, dirNew);
}

STATIC TraStatus TraceRecorderCreateDirWithCheck(const char *path, int32_t *errCode)
{
    TraStatus ret = TraceMkdir(path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        int32_t code = AdiagGetErrorCode();
        if (errCode != NULL) {
            *errCode = code;
        }
        ADIAG_ERR("mkdir %s failed, strerr=%s.", path, strerror(code));
        return TRACE_FAILURE;
    }
    return ret;
}

STATIC void TraceRecorderLogBuildFailure(const char *label, const char *stage, const TraceDirInfo *dirInfo,
    int32_t errCode)
{
    ADIAG_ERR("create trace %s failed, stage=%s, reason=snprintf_s, rootPath=%s, "
        "eventName=%s, pid=%d, dirTime=%s, limit=%zu, strerr=%s.",
        label, stage, g_recorderMgr->rootPath, dirInfo->eventName, dirInfo->pid, dirInfo->dirTime,
        (size_t)MAX_FILEPATH_LEN, strerror(errCode));
}

STATIC void TraceRecorderLogMkdirFailure(const char *label, const char *stage, const char *dirPath, int32_t errCode)
{
    ADIAG_ERR("create trace %s failed, stage=%s, reason=mkdir, "
        "rootPath=%s, dirPath=%s, dirPathLen=%zu, limit=%zu, strerr=%s.",
        label, stage, g_recorderMgr->rootPath, dirPath, strlen(dirPath),
        (size_t)MAX_FILEPATH_LEN, strerror(errCode));
}

STATIC TraStatus TraceRecorderCreateRootDir(void)
{
    TraStatus ret = TraceMkdir(g_recorderMgr->rootPath, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        int32_t errCode = AdiagGetErrorCode();
        ADIAG_ERR("create trace root directory failed, stage=root_dir, reason=mkdir, "
            "rootPath=%s, rootPathLen=%zu, limit=%zu, strerr=%s.",
            g_recorderMgr->rootPath, strlen(g_recorderMgr->rootPath), (size_t)MAX_FILEPATH_LEN,
            strerror(errCode));
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceRecorderCreateFormattedDir(TraceDirNode *dirNew, const char *label, const char *stage,
    const TraceDirInfo *dirInfo, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    int32_t ret = vsnprintf_s(dirNew->dirPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, format, args);
    va_end(args);
    if (ret == -1) {
        int32_t errCode = AdiagGetErrorCode();
        TraceRecorderLogBuildFailure(label, stage, dirInfo, errCode);
        return TRACE_FAILURE;
    }
    int32_t errCode = 0;
    if (TraceRecorderCreateDirWithCheck(dirNew->dirPath, &errCode) != TRACE_SUCCESS) {
        TraceRecorderLogMkdirFailure(label, stage, dirNew->dirPath, errCode);
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraceDirNode *TraceRecorderFindExistingDir(const TraceDirInfo *dirInfo, TraceDirNode *dirNew)
{
    if (strncmp(dirInfo->eventName, TRACER_EVENT_EXIT, strlen(TRACER_EVENT_EXIT)) == 0) {
        return NULL;
    }
    TraceDirList *dirList = (dirInfo->isDevice) ? &g_recorderMgr->deviceDirList : &g_recorderMgr->hostDirList;
    return TraceRecorderListFind(dirList, dirNew->dirPath);
}

const TraceDirNode *TraceRecorderGetDirPath(const TraceDirInfo *dirInfo)
{
    // ~/ascend
    if (TraceRecorderCreateRootDir() != TRACE_SUCCESS) {
        return NULL;
    }

    TraceDirNode *dirNew = (TraceDirNode *)AdiagMalloc(sizeof(TraceDirNode));
    ADIAG_CHK_EXPR_ACTION(dirNew == NULL, return NULL, "create dir failed.");

    // ~/ascend/atrace
    if (TraceRecorderCreateFormattedDir(dirNew, "atrace directory", "atrace_dir", dirInfo, "%s/%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH) != TRACE_SUCCESS) {
        goto failed;
    }

    // ~/ascend/atrace/trace_{attr_group_id}_{attr_pid}_{attr_time}
    if (TraceRecorderCreateFormattedDir(dirNew, "first directory", "first_trace_dir", dirInfo, "%s/%s/%s_%d_%d_%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH,
        TRACE_DIR_HEAD, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime()) != TRACE_SUCCESS) {
        goto failed;
    }

    // ~/ascend/atrace/trace_{attr_group_id}_{attr_pid}_{attr_time}/{tracer_name}_event_{pid}_time
    if (TraceRecorderCreateFormattedDir(dirNew, "second directory", "second_event_dir", dirInfo,
        "%s/%s/%s_%d_%d_%s/%s_event_%d_%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH,
        TRACE_DIR_HEAD, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime(),
        dirInfo->eventName, dirInfo->pid, dirInfo->dirTime) != TRACE_SUCCESS) {
        goto failed;
    }

    TraceDirNode *existNode = TraceRecorderFindExistingDir(dirInfo, dirNew);
    if (existNode != NULL) {
        ADIAG_SAFE_FREE(dirNew);
        return existNode;
    }

    TraceRecorderSaveNode(dirInfo, dirNew);
    return dirNew;

failed:
    ADIAG_SAFE_FREE(dirNew);
    return NULL;
}

TraStatus TraceRecorderGetFd(const TraceDirInfo *dirInfo, const TraceFileInfo *fileInfo, int32_t *fd)
{
    ADIAG_CHK_NULL_PTR(fileInfo, return TRACE_FAILURE);
    ADIAG_CHK_NULL_PTR(dirInfo, return TRACE_FAILURE);
    (void)AdiagLockGet(&g_recorderMgr->lock);
    const TraceDirNode *dir = TraceRecorderGetDirPath(dirInfo);
    if (dir == NULL) {
        ADIAG_ERR("get dir failed.");
        (void)AdiagLockRelease(&g_recorderMgr->lock);
        return TRACE_FAILURE;
    }

    char filePath[MAX_FULLPATH_LEN + 1U] = { 0 };
    int32_t ret = snprintf_s(filePath, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN,
        "%s/%s_tracer_%s%s", dir->dirPath, fileInfo->tracerName, fileInfo->objName, fileInfo->suffix);
    if (ret == -1) {
        int32_t errCode = AdiagGetErrorCode();
        (void)AdiagLockRelease(&g_recorderMgr->lock);
        ADIAG_ERR("snprintf_s file path failed, ret=%d, strerr=%s.", ret, strerror(errCode));
        return TRACE_FAILURE;
    }
    int32_t fileFd = TraceOpen(filePath, (uint32_t)O_CREAT | (uint32_t)O_WRONLY | (uint32_t)O_APPEND,
        TRACE_FILE_MODE);
    int32_t errCode = (fileFd < 0) ? AdiagGetErrorCode() : 0;
    (void)AdiagLockRelease(&g_recorderMgr->lock);
    ADIAG_CHK_EXPR_ACTION(fileFd < 0, return TRACE_FAILURE,
        "open file failed, file=%s, strerr=%s.", filePath, strerror(errCode));

    *fd = fileFd;
    return TRACE_SUCCESS;
}

TraStatus TraceRecorderWrite(int32_t fd, const char *msg, uint32_t len)
{
    int32_t ret = (int32_t)write(fd, msg, len);
    if ((ret < 0) || ((uint32_t)ret != len)) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

STATIC TraStatus TraceRecorderSafeMkdirPathWithBuffer(const TraceDirInfo *dirInfo, char *path, size_t len)
{
    if ((path == NULL) || (len == 0)) {
        return TRACE_INVALID_PARAM;
    }
    int32_t ret = TraceMkdir(g_recorderMgr->rootPath, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    ret = snprintf_s(path, len, len - 1U, "%s/%s", g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH);
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    ret = TraceMkdir(path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    ret = snprintf_s(path, len, len - 1U, "%s/%s/%s_%d_%d_%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH,
        TRACE_DIR_HEAD, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime());
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    ret = TraceMkdir(path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    ret = TraceRecorderSafeGetDirPath(dirInfo, path, len);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    ret = TraceMkdir(path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return ret;
    }
    return TRACE_SUCCESS;
}

TraStatus TraceRecorderSafeMkdirPath(const TraceDirInfo *dirInfo)
{
    char path[MAX_FULLPATH_LEN + 1U] = { 0 };
    return TraceRecorderSafeMkdirPathWithBuffer(dirInfo, path, MAX_FULLPATH_LEN + 1U);
}

TraStatus TraceRecorderSafeGetDirPath(const TraceDirInfo *dirInfo, char *path, size_t len)
{
    if ((dirInfo == NULL) || (path == NULL) || (len == 0)) {
        return TRACE_INVALID_PARAM;
    }
    int32_t ret = snprintf_s(path, len, len - 1U, "%s/%s/%s_%d_%d_%s/%s_event_%d_%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH,
        TRACE_DIR_HEAD, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime(),
        dirInfo->eventName, dirInfo->pid, dirInfo->dirTime);
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    return TRACE_SUCCESS;
}

/**
 * @brief       get file fd to write
                use for signal_callback_func, only call reentrant function
 * @param [in]  dirInfo:        dir info, for dir name
 * @param [in]  fileInfo:       file info, for file name
 * @param [out] fd:             file handle
 * @return      TraStatus
 */
TraStatus TraceRecorderSafeGetFd(const TraceDirInfo *dirInfo, const TraceFileInfo *fileInfo, int32_t *fd)
{
    if ((dirInfo == NULL) || (fileInfo == NULL) || (fd == NULL)) {
        return TRACE_INVALID_PARAM;
    }

    char path[MAX_FULLPATH_LEN + 1U] = { 0 };
    TraStatus ret = TraceRecorderSafeMkdirPathWithBuffer(dirInfo, path, MAX_FULLPATH_LEN + 1U);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }

    size_t pathLen = strlen(path);
    if (pathLen >= MAX_FULLPATH_LEN) {
        return TRACE_FAILURE;
    }
    ret = snprintf_s(path + pathLen, MAX_FULLPATH_LEN + 1U - pathLen, MAX_FULLPATH_LEN - pathLen,
        "/%s_tracer_%s%s",
        fileInfo->tracerName, fileInfo->objName, fileInfo->suffix);
    if (ret == -1) {
        return TRACE_FAILURE;
    }

    errno_t err = strncpy_s(g_recorderMgr->corePath, MAX_FULLPATH_LEN + 1U, path, strlen(path));
    if (err != EOK) {
        return TRACE_FAILURE;
    }

    int32_t fileFd = TraceOpen(path, (uint32_t)O_CREAT | (uint32_t)O_WRONLY | (uint32_t)O_APPEND, TRACE_FILE_MODE);
    if (fileFd < 0) {
        return TRACE_FAILURE;
    }

    *fd = fileFd;
    return TRACE_SUCCESS;
}

const char* TraceRecorderSafeGetFilePath(void)
{
    return g_recorderMgr->corePath;
}
