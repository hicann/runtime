/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_file_util.h"
#include "log_file_info.h"
#include "log_print.h"

#define LOG_MAX_RECURSION_DEPTH     6

/**
 * @brief : mkdir log root path
 * @param [in]fullPath: log root path
 * @return SUCCESS: mkdir succeed; Others: failed
 */
LogRt LogMkdirRecur(const char *fullPath)
{
    LogRt err = SUCCESS;
    char *path = (char *)calloc(1, (size_t)(MAX_FILEDIR_LEN + 1U) * sizeof(char));
    if (path == NULL) {
        SELF_LOG_ERROR("calloc failed, strerr=%s.", strerror(ToolGetErrorCode()));
        return MALLOC_FAILED;
    }
    char *newDir = strdup(fullPath);
    if (newDir == NULL) {
        SELF_LOG_ERROR("strdup failed, strerr=%s.", strerror(ToolGetErrorCode()));
        XFREE(path);
        return STR_COPY_FAILED;
    }
    char *tmpNewDir = newDir;
    char *tmpPath   = path;
    char *token = strsep(&newDir, FILE_SEPARATOR);
    while (token != NULL) {
        if (strcmp(token, "") == 0) {
            token = strsep(&newDir, FILE_SEPARATOR);
            continue;
        }
        char nextDir[MAX_FILEDIR_LEN + 1U] = { 0 };
        int32_t ret = snprintf_s(nextDir, MAX_FILEDIR_LEN + 1U, MAX_FILEDIR_LEN, "/%s", token);
        if (ret == -1) {
            SELF_LOG_ERROR("copy data failed, strerr=%s.", strerror(ToolGetErrorCode()));
            err = STR_COPY_FAILED;
            break;
        }
        ret = strncat_s(path, MAX_FILEDIR_LEN + 1U, nextDir, strlen(nextDir));
        if (ret != 0) {
            SELF_LOG_ERROR("strncat_s failed, strerr=%s.", strerror(ToolGetErrorCode()));
            err = STR_COPY_FAILED;
            break;
        }
        err = LogMkdir((const char *)path);
        if (err != SUCCESS) {
            break;
        }
        token = strsep(&newDir, FILE_SEPARATOR);
    }
    XFREE(tmpPath);
    XFREE(tmpNewDir);
    return err;
}

/**
 * @brief : mkdir log path if not exist
 * @param [in]dirPath: log directory path
 * @return: LogRt
 */
LogRt LogMkdir(const char *dirPath)
{
    ONE_ACT_NO_LOG(dirPath == NULL, return ARGV_NULL);

    if (ToolAccess(dirPath) != SYS_OK) {
        int32_t ret = ToolMkdir(dirPath, (toolMode)OPERATE_MODE);
        if ((ret != SYS_OK) && (ToolAccess(dirPath) != SYS_OK)) {
            return MKDIR_FAILED;
        }
        (void)ToolChmod(dirPath, OPERATE_MODE);
        ret = ToolChownPath(dirPath);
        if (ret != SYS_OK) {
            return FAILED;
        }
    }

    return SUCCESS;
}

/**
 * @brief LogGetHomeDir: get user's home directory
 * @param [out]homeDir: buffer to store home dir path
 * @param [in]len: max length of home dir path
 * @return: SYS_OK/SYS_ERROR
 */
int32_t LogGetHomeDir(char *const homedir, uint32_t len)
{
    ONE_ACT_WARN_LOG(homedir == NULL, return SYS_ERROR, "[input] home directory path is null.");
    ONE_ACT_WARN_LOG((len == 0) || (len > (unsigned int)(TOOL_MAX_PATH + 1)), return SYS_ERROR,
                      "[input] path length is invalid, length=%u, max_length=%d.", len, TOOL_MAX_PATH);

    errno_t ret;
#if (OS_TYPE_DEF == LINUX)
    const struct passwd *secuWord = getpwuid(getuid());
    if (secuWord != NULL) {
        ret = strcpy_s(homedir, len, secuWord->pw_dir);
    } else {
        ret = strcpy_s(homedir, len, "");
    }
    if (ret != EOK) {
        SELF_LOG_ERROR("strcpy_s home directory failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }

    SELF_LOG_INFO("home_directory=%s.", homedir);
    return SYS_OK;
#else
    ret = strcpy_s(homedir, len, LOG_HOME_DIR);
    if (ret != EOK) {
        SELF_LOG_ERROR("strcpy_s failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }
    return SYS_OK;
#endif
}

/**
 * @brief       : check path exists or not, create path if not exists
 * @param [in]  : ppath     string of path
 * @return      : true: succeed; false: failed
 */
STATIC bool CheckPathValid(const char *ppath)
{
    if (ppath == NULL) {
        return false;
    }
    // dir exists and has write permission, use path;
    if ((ToolAccessWithMode(ppath, F_OK) == SYS_OK) && (ToolAccessWithMode(ppath, W_OK) == SYS_OK)) {
        return true;
    }

    // dir not exists and mkdir succeed, use path;
    if ((ToolAccessWithMode(ppath, F_OK) != SYS_OK) && (LogMkdirRecur(ppath) == SUCCESS)) {
        return true;
    }

    SELF_LOG_ERROR("path set is not available.");
    return false;
}

int32_t GetValidPath(char *path, int32_t pathLen, char *validPath, int32_t validPathLen)
{
    if ((path == NULL) || (validPath == NULL) || (validPathLen < TOOL_MAX_PATH)) {
        return SYS_ERROR;
    }

    if (!CheckPathValid(path)) {
        return SYS_ERROR;
    }

    LogStrTrimEnd(path, pathLen);
    if ((ToolRealPath(path, validPath, validPathLen) != SYS_OK) && (ToolGetErrorCode() != ENOENT)) {
        SELF_LOG_WARN("can not get realpath, file=%s, strerr=%s.", path, strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief       : rename dir, filter file by func
 * @param [in]  : srcDir        src dir path
 * @param [in]  : dstDir        dst dir path
 * @param [in]  : filterFunc    func to filter file
 * @return      : LOG_SUCCESS  success; others  failed
 */
int32_t LogRenameDir(const char *srcDir, const char *dstDir, ToolFilter filterFunc)
{
    ONE_ACT_NO_LOG(srcDir == NULL, return LOG_FAILURE);
    ONE_ACT_NO_LOG(dstDir == NULL, return LOG_FAILURE);

    if (LogMkdirRecur(dstDir) != SUCCESS) {
        SELF_LOG_ERROR("dir %s is not exist, strerr=%s", dstDir, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    // move file and delete dir after move dir failed
    LogStatus result = LOG_SUCCESS;
    ToolDirent **namelist = NULL;
    int32_t totalNum = ToolScandir(srcDir, &namelist, filterFunc, NULL);
    for (int32_t i = 0; i < totalNum; i++) {
        char srcFile[MAX_FILEPATH_LEN] = { 0 };
        int32_t ret = snprintf_s(srcFile, MAX_FILEPATH_LEN, MAX_FILEPATH_LEN - 1U,
                                 "%s/%s", srcDir, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));

        char dstFile[MAX_FILEPATH_LEN] = { 0 };
        ret = snprintf_s(dstFile, MAX_FILEPATH_LEN, MAX_FILEPATH_LEN - 1U, "%s/%s", dstDir, namelist[i]->d_name);
        ONE_ACT_ERR_LOG(ret == -1, continue, "snprintf_s failed, strerr=%s", strerror(ToolGetErrorCode()));
        if (ToolRename(srcFile, dstFile) != SYS_OK) {
            SELF_LOG_ERROR("rename file failed, fileName=%s, strerr=%s", dstFile, strerror(ToolGetErrorCode()));
            result = LOG_FAILURE;
        }
    }

    if (ToolRmdir(srcDir) != SYS_OK) {
        SELF_LOG_ERROR("remove dir failed, dir=%s, strerr=%s", srcDir, strerror(ToolGetErrorCode()));
        result = LOG_FAILURE;
    }
    ToolScandirFree(namelist, totalNum);
    return result;
}

/**
 * @brief : sync buffer to disk
 * @param [in]logPath: log absolute path
 * @return : NA
 */
void FsyncLogToDisk(const char *logPath)
{
    if (logPath == NULL) {
        return;
    }

    int32_t fd = ToolOpenWithMode(logPath, (uint32_t)O_WRONLY | (uint32_t)O_APPEND, LOG_FILE_RDWR_MODE);
    if (fd < 0) {
        SELF_LOG_WARN("can not open file, file=%s.", logPath);
        return;
    }

    int32_t ret = ToolFsync(fd);
    if (ret != SYS_OK) {
        SELF_LOG_WARN("can not fsync, file=%s, ret=%d, strerr=%s.", logPath, ret, strerror(ToolGetErrorCode()));
    }

    (void)ToolClose(fd);
}

/*
 * @brief: free subdirectory path list memory
 * @param [in]pathList: directory path structure pointer
 * @param [in]count: subdirectory size
 */
void ToolPathListFree(char **pathList, int32_t count)
{
    if (pathList == NULL) {
        return;
    }

    int32_t j;
    for (j = 0; j < count; j++) {
        if (pathList[j] != NULL) {
            XFREE(pathList[j]);
        }
    }
    XFREE(pathList);
}

uint32_t LogGetDirSize(const char *dirPath, int32_t level)
{
    if ((dirPath == NULL) || (level > LOG_MAX_RECURSION_DEPTH)) {
        return 0;
    }
    DIR *dir = NULL;
    if ((dir = opendir(dirPath)) == NULL) {
        return 0;
    }
    uint32_t totalSize = 0;
    ToolStat statBuf = { 0 };
    ToolDirent *entry = NULL;
    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }

        char fullPath[MAX_FULLPATH_LEN + 1U] = { 0 };
        int32_t ret = snprintf_s(fullPath, MAX_FULLPATH_LEN + 1U, MAX_FULLPATH_LEN, "%s/%s", dirPath, entry->d_name);
        if (ret == -1) {
            SELF_LOG_ERROR("copy data failed, strerr=%s.", strerror(ToolGetErrorCode()));
            continue;
        }

        if (ToolStatGet(fullPath, &statBuf) != LOG_SUCCESS) {
            continue;
        }

        if (S_ISDIR(statBuf.st_mode)) {
            uint32_t dirSize = LogGetDirSize(fullPath, level + 1);
            if (dirSize == 0) {
                continue;
            }
            totalSize += dirSize;
        } else {
            totalSize += (uint32_t)statBuf.st_size;
        }
    }

    (void)closedir(dir);
    return totalSize;
}

int32_t LogRemoveDir(const char *dirName, int32_t level)
{
    if ((dirName == NULL) || (level > LOG_MAX_RECURSION_DEPTH)) {
        return LOG_FAILURE;
    }
    DIR *dir = NULL;
    ToolDirent *entry;
    ToolStat statBuf;
    if ((dir = opendir(dirName)) == NULL) {
        return LOG_FAILURE;
    }
    int32_t ret = 0;
    char path[TOOL_MAX_PATH] = {0};
    while ((entry = readdir(dir)) != NULL) {
        if ((strcmp(entry->d_name, ".") == 0) || (strcmp(entry->d_name, "..") == 0)) {
            continue;
        }
        ret = snprintf_s(path, TOOL_MAX_PATH, TOOL_MAX_PATH - 1, "%s/%s", dirName, entry->d_name);
        if (ret == -1) {
            SELF_LOG_ERROR("copy data failed, strerr=%s.", strerror(ToolGetErrorCode()));
            break;
        }

        if (ToolStatGet(path, &statBuf) != LOG_SUCCESS) {
            SELF_LOG_ERROR("get path stat failed, path = %s, strerr=%s.", path, strerror(ToolGetErrorCode()));
            break;
        }
        if (S_ISDIR(statBuf.st_mode)) {
            ret = LogRemoveDir(path, level + 1);
        } else {
            ret = remove(path);
        }
        if (ret != LOG_SUCCESS) {
            SELF_LOG_ERROR("remove %s failed, strerr: %s", path, strerror(ToolGetErrorCode()));
        }
    }
    (void)closedir(dir);
    if (ToolRmdir(dirName) != LOG_SUCCESS) {
        SELF_LOG_ERROR("rmdir %s failed, strerr: %s", dirName, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    return ret;
}

LogStatus LogFileGets(char *buf, int32_t len, FILE *fp)
{
    ONE_ACT_ERR_LOG(fp == NULL, return LOG_FAILURE, "fp is null.");
    ONE_ACT_ERR_LOG(buf == NULL, return LOG_FAILURE, "buf is null.");
    ONE_ACT_ERR_LOG(len <= 0, return LOG_FAILURE, "len is invalid.");
    if (fgets(buf, len, fp) != NULL) {
        return LOG_SUCCESS;
    }
    return LOG_FAILURE;
}

int64_t LogFileTell(FILE *fp)
{
    ONE_ACT_ERR_LOG(fp == NULL, return -1, "fp is null.");
    errno = 0;
    int64_t offset = ftell(fp);
    if ((offset == -1) && (errno != 0)) {
        SELF_LOG_ERROR( "ftell error, strerr: %s", strerror(errno));
    }
    return offset;
}