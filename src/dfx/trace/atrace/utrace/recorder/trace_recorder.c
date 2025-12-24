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

#define TRACE_FILE_ASCEND_PATH  "ascend"
#define TRACE_FILE_SUB_PATH     "atrace"
#define TRACE_DIR_HEAD          "trace"
#define TRACE_DIR_MODE          0750U
#define TRACE_FILE_MODE         0640U
#define FILE_SEPARATOR          "/"

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

STATIC TraStatus TraceGetValidPath(char *envDir, uint32_t len)
{
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

STATIC TraStatus TraceGetEnvDir(char *envDir, uint32_t len)
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
    char *path = (char *)AdiagMalloc(MAX_FILEDIR_LEN);
    ADIAG_CHK_EXPR_ACTION(path == NULL, return TRACE_FAILURE,
        "malloc root path failed, strerr=%s", strerror(AdiagGetErrorCode()));

    TraStatus ret = TraceGetEnvDir(path, MAX_FILEDIR_LEN);
    if (ret == TRACE_SUCCESS) {
        res = snprintf_truncated_s(mgr->rootPath, MAX_FILEDIR_LEN + 1U, "%s", path);
    } else {
        // get process user home path
        ret = TraceGetHomeDir(path, MAX_FILEDIR_LEN);
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

    g_recorderMgr->currIndex = 0;
    return TRACE_SUCCESS;
}

void TraceRecorderExit(void)
{
    if (g_recorderMgr == NULL) {
        ADIAG_WAR("file list is null.");
        return;
    }

    for (uint32_t i = 0; i < MAX_DIR_NUM; i++) {
        if (g_recorderMgr->dirList[i] != NULL) {
            ADIAG_SAFE_FREE(g_recorderMgr->dirList[i]);
        }
    }
    if (g_recorderMgr->exitDir != NULL) {
        ADIAG_SAFE_FREE(g_recorderMgr->exitDir);
    }
    g_recorderMgr->currIndex = 0;
    ADIAG_SAFE_FREE(g_recorderMgr);
}

static bool TraceCheckDirIsExist(const char *dirPath, uint32_t *idx)
{
    for (uint32_t i = 0; i < MAX_DIR_NUM; i++) {
        if (g_recorderMgr->dirList[i] == NULL) {
            continue;
        }
        if (strcmp(dirPath, g_recorderMgr->dirList[i]->dirPath) == 0) {
            *idx = i;
            return true;
        }
    }
    return false;
}

const TraceDirPath *TraceRecorderGetDirPath(const TraceDirInfo *dirInfo)
{
    // ~/ascend/atrace
    int32_t ret = TraceMkdir(g_recorderMgr->rootPath, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("mkdir %s failed, strerr=%s.", g_recorderMgr->rootPath, strerror(AdiagGetErrorCode()));
        return NULL;
    }

    TraceDirPath *dir = (TraceDirPath *)AdiagMalloc(sizeof(TraceDirPath));
    ADIAG_CHK_EXPR_ACTION(dir == NULL, return NULL, "create dir failed.");

    // ~/ascend/atrace
    ret = snprintf_s(dir->dirPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s/%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH);
    if (ret == -1) {
        ADIAG_ERR("snprintf_s dir path failed, ret=%d, strerr=%s.", ret, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(dir);
        return NULL;
    }

    ret = TraceMkdir(dir->dirPath, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("mkdir %s failed, strerr=%s.",  dir->dirPath, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(dir);
        return NULL;
    }

    // ~/ascend/atrace/trace_{attr_group_id}_{attr_pid}_{attr_time}
    ret = snprintf_s(dir->dirPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s/%s/%s_%d_%d_%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH,
        TRACE_DIR_HEAD, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime());
    if (ret == -1) {
        ADIAG_ERR("snprintf_s dir path failed, ret=%d, strerr=%s.", ret, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(dir);
        return NULL;
    }

    ret = TraceMkdir(dir->dirPath, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("mkdir %s failed, strerr=%s.",  dir->dirPath, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(dir);
        return NULL;
    }

    // ~/ascend/atrace/trace_{attr_group_id}_{attr_pid}_{attr_time}/{tracer_name}_event_{pid}_time
    ret = snprintf_s(dir->dirPath, MAX_FILEPATH_LEN + 1U, MAX_FILEPATH_LEN, "%s/%s/%s_%d_%d_%s/%s_event_%d_%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH,
        TRACE_DIR_HEAD, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime(),
        dirInfo->eventName,dirInfo->pid, dirInfo->dirTime);
    if (ret == -1) {
        ADIAG_ERR("snprintf_s dir path failed, ret=%d, strerr=%s.", ret, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(dir);
        return NULL;
    }

    ret = TraceMkdir(dir->dirPath, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        ADIAG_ERR("mkdir %s failed, strerr=%s.",  dir->dirPath, strerror(AdiagGetErrorCode()));
        ADIAG_SAFE_FREE(dir);
        return NULL;
    }

    uint32_t curIdx = 0;
    if (TraceCheckDirIsExist(dir->dirPath, &curIdx)) {
        ADIAG_SAFE_FREE(dir);
        return g_recorderMgr->dirList[curIdx];
    }

    // if exit_event, no need to aging
    if (strncmp(dirInfo->eventName, TRACER_EVENT_EXIT, strlen(TRACER_EVENT_EXIT)) == 0) {
        if (g_recorderMgr->exitDir != NULL) {
            ADIAG_SAFE_FREE(g_recorderMgr->exitDir);
        }
        g_recorderMgr->exitDir = dir;
        return dir;
    }
    curIdx = (g_recorderMgr->currIndex + 1U) % MAX_DIR_NUM;
    if (g_recorderMgr->dirList[curIdx] != NULL) {
        ret = TraceRmdir(g_recorderMgr->dirList[curIdx]->dirPath);
        if (ret != 0) {
            ADIAG_WAR("can not remove dir %s, ret=%d.", g_recorderMgr->dirList[curIdx]->dirPath, ret);
        } else {
            ADIAG_INF("remove dir %s successfully.", g_recorderMgr->dirList[curIdx]->dirPath);
        }
        ADIAG_SAFE_FREE(g_recorderMgr->dirList[curIdx]);
    }
    g_recorderMgr->dirList[curIdx] = dir;
    g_recorderMgr->currIndex = curIdx;
    return dir;
}

TraStatus TraceRecorderGetFd(const TraceDirInfo *dirInfo, const TraceFileInfo *fileInfo, int32_t *fd)
{
    ADIAG_CHK_NULL_PTR(fileInfo, return TRACE_FAILURE);
    ADIAG_CHK_NULL_PTR(dirInfo, return TRACE_FAILURE);
    (void)AdiagLockGet(&g_recorderMgr->lock);
    const TraceDirPath *dir = TraceRecorderGetDirPath(dirInfo);
    if (dir == NULL) {
        ADIAG_ERR("get dir failed.");
        (void)AdiagLockRelease(&g_recorderMgr->lock);
        return TRACE_FAILURE;
    }

    char filePath[MAX_FULLPATH_LEN + 1U] = { 0 };
    int32_t ret = snprintf_s(filePath, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN,
        "%s/%s_tracer_%s%s", dir->dirPath, fileInfo->tracerName, fileInfo->objName, fileInfo->suffix);
    (void)AdiagLockRelease(&g_recorderMgr->lock);
    if (ret == -1) {
        ADIAG_ERR("snprintf_s file path failed, ret=%d, strerr=%s.", ret, strerror(AdiagGetErrorCode()));
        return TRACE_FAILURE;
    }
    int32_t fileFd = TraceOpen(filePath, (uint32_t)O_CREAT | (uint32_t)O_WRONLY | (uint32_t)O_APPEND,
        TRACE_FILE_MODE);
    ADIAG_CHK_EXPR_ACTION(fileFd < 0, return TRACE_FAILURE,
        "open file failed, file=%s, strerr=%s.", filePath, strerror(AdiagGetErrorCode()));

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

TraStatus TraceRecorderSafeMkdirPath(const TraceDirInfo *dirInfo)
{
    int32_t ret = TraceMkdir(g_recorderMgr->rootPath, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    char path[MAX_FULLPATH_LEN + 1U] = { 0 };
    ret = snprintf_s(path, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN, "%s/%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH);
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    ret = TraceMkdir(path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    ret = snprintf_s(path, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN, "%s/%s/%s_%d_%d_%s",
        g_recorderMgr->rootPath, TRACE_FILE_SUB_PATH,
        TRACE_DIR_HEAD, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime());
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    ret = TraceMkdir(path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }

    ret = TraceRecorderSafeGetDirPath(dirInfo, path, MAX_FULLPATH_LEN + 1U);
    if (ret != TRACE_SUCCESS) {
        return TRACE_FAILURE;
    }
    ret = TraceMkdir(path, TRACE_DIR_MODE, TraceAttrGetUid(), TraceAttrGetGid());
    if (ret != TRACE_SUCCESS) {
        return ret;
    }
    return TRACE_SUCCESS;
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
    TraStatus ret = TraceRecorderSafeGetDirPath(dirInfo, path, MAX_FULLPATH_LEN + 1U);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }

    ret = TraceRecorderSafeMkdirPath(dirInfo);
    if (ret != TRACE_SUCCESS) {
        return ret;
    }

    char tmp[MAX_FILEDIR_LEN] = { 0 };
    ret = snprintf_s(tmp, MAX_FILEDIR_LEN, MAX_FULLPATH_LEN - 1U, "/%s_tracer_%s%s",
        fileInfo->tracerName, fileInfo->objName, fileInfo->suffix);
    if (ret == -1) {
        return TRACE_FAILURE;
    }
    errno_t err = strncat_s(path, MAX_FULLPATH_LEN + 1U, tmp, strlen(tmp));
    if (err != EOK) {
        return TRACE_FAILURE;
    }

    err = strncpy_s(g_recorderMgr->corePath, MAX_FULLPATH_LEN + 1U, path, strlen(path));
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
