/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "mergeslog.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "log_iam_pub.h"
#include "iam.h"
#include "log_print.h"
#include "log_platform.h"
#include "log_file_info.h"
#include "slog.h"

#define OUTPUT_LOG_FILE         "/ascendmerge.log"
#define OUTPUT_GZ_LOG_FILE      "/ascendmerge.log.gz"
#define GENERAL_LOG_NUM         3U           // genenal log = deviece-os + device-app + aos-core-app
#define GROUP_MAP_SIZE          (INVLID_MOUDLE_ID + 1)
#define GZIP_SUFFIX             ".gz"

typedef struct {
    char rootPath[PATH_MAX];
    char groupPath[PATH_MAX];
    char groupName[GROUP_MAP_SIZE][NAME_MAX];
} LogConfigInfo;

typedef struct {
    char path[PATH_MAX];
    char dirName[NAME_MAX];
    char fileName[NAME_MAX];
    char activeSuffix[NAME_MAX];
    char rotateSuffix[NAME_MAX];
} LogPathPattern;

/**
 * @brief       : ioctl to slogd to collect log
 * @param [in]  : dir                   directory to save log file
 * @param [in]  : mode                  permission type
 * @return      : SYS_OK success; SYS_ERROR failure
 */
STATIC int32_t MergeCheckDir(const char *dir, int32_t mode)
{
    if ((ToolAccessWithMode(dir, F_OK) != SYS_OK) || (ToolAccessWithMode(dir, mode) != SYS_OK)) {
        SELF_LOG_ERROR("dir has no permission, dir=%s.", dir);
        return SYS_ERROR;
    }
    return SYS_OK;
}

/**
 * @brief       : ioctl to slogd to collect log
 * @param [out] : fd                    iam service fd
 * @return      : SYS_OK success; SYS_ERROR failure
 */
STATIC int32_t MergeOpenIamService(int32_t *fd)
{
    *fd = INVALID;
    int32_t retry = 0;
    while ((*fd == INVALID) && (retry < IAM_RETRY_TIMES)) {
        *fd = open(LOGOUT_IAM_SERVICE_PATH, O_RDWR);
        retry++;
    }
    return (*fd == INVALID) ? SYS_ERROR : SYS_OK;
}

STATIC INLINE bool MergeIsBusy(int32_t err)
{
    return ((err) == ETIMEDOUT) || ((err) == EAGAIN) || ((err) == EBUSY);
}

/**
 * @brief       : ioctl to slogd to collect log
 * @param [in]  : fd                    iam service fd
 * @param [in]  : arg                   ioctl argument
 * @param [in]  : cmd                   ioctl cmdline
 * @return      : SYS_OK success; SYS_ERROR failure
 */
STATIC int32_t MergeIoctlCollect(int32_t fd, struct IAMIoctlArg *arg, uint32_t cmd)
{
    int32_t retry = 0;
    int32_t ret = 0;
    int32_t err = 0;
    do {
        ret = ioctl(fd, cmd, arg);
        retry++;
        err = ToolGetErrorCode();
    } while ((ret == SYS_ERROR) && (retry <= IAM_RETRY_TIMES) && (MergeIsBusy(err)));
    return ret;
}

STATIC int32_t MergeGetRealPath(char *dir, char *validPath, int32_t length, int32_t mode)
{
    if ((dir == NULL) || (validPath == NULL) || (length <= 0)) {
        return SYS_ERROR;
    }
    if ((ToolRealPath(dir, validPath, length) != SYS_OK) && (ToolGetErrorCode() != ENOENT)) {
        SELF_LOG_WARN("can not get realpath, file=%s, pid = %d, strerr=%s.",
                      dir, ToolGetPid(), strerror(ToolGetErrorCode()));
        return SYS_ERROR;
    }
    ONE_ACT_ERR_LOG(MergeCheckDir(validPath, mode) != SYS_OK, return SYS_ERROR,
                    "dir[%s] is invalid, pid = %d.", validPath, ToolGetPid());
    return SYS_OK;
}

/**
 * @brief       : collect new log and compress to dir
 * @param [in]  : dir                   directory to save log file
 * @param [in]  : len                   length of dir
 * @return      : MERGE_SUCCESS:        success;
 *                MERGE_ERROR:          error;
 *                MERGE_INVALID_ARGV:   input invalid;
 *                MERGE_NO_PERMISSION:  path no permission
 */
int32_t DlogCollectLog(char *dir, uint32_t len)
{
    if ((dir == NULL) || (len == 0) || (len > PATH_MAX) || (strlen(dir) > len)) {
        SELF_LOG_ERROR("collect failed, input args is invalid, pid = %d.", ToolGetPid());
        return MERGE_INVALID_ARGV;
    }
    // get real path
    char validPath[PATH_MAX] = { 0 };
    ONE_ACT_ERR_LOG(MergeGetRealPath(dir, validPath, PATH_MAX, W_OK) != SYS_OK, return MERGE_NO_PERMISSION,
                    "get dir real path failed, pid = %d.", ToolGetPid());
    errno_t err = strcat_s(validPath, (size_t)PATH_MAX - 1U, OUTPUT_GZ_LOG_FILE);
    if (err != EOK) {
        SELF_LOG_ERROR("make log path failed, ret = %d, errno = %d, pid = %d.",
            (int32_t)err, ToolGetErrorCode(), ToolGetPid());
        return MERGE_ERROR;
    }

    // open iam service
    int32_t fd = INVALID;
    ONE_ACT_ERR_LOG(MergeOpenIamService(&fd) != SYS_OK, return MERGE_ERROR,
                    "open iam service failed, errno = %d, pid = %d.", ToolGetErrorCode(), ToolGetPid());
    SELF_LOG_INFO("open iam service succeed, pid = %d.", ToolGetPid());
    struct IAMIoctlArg arg;
    arg.size = PATH_MAX;
    arg.argData = (void *)validPath;
    int32_t ret = MergeIoctlCollect(fd, &arg, IAM_CMD_COLLECT_LOG);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("iam service ioctl failed, ret = %d, errno = %d, pid = %d.",
                       ret, ToolGetErrorCode(), ToolGetPid());
        (void)close(fd);
        return MERGE_ERROR;
    }
    SELF_LOG_INFO("iam service ioctl collect succeed, pid = %d.", ToolGetPid());
    (void)close(fd);
    return MERGE_SUCCESS;
}

/**
 * @brief       : check if new log file exist
 * @param [in]  : dir                   directory to save log file
 * @param [in]  : len                   length of dir
 * @return      : MERGE_SUCCESS:        success;
 *                MERGE_ERROR:          error;
 *                MERGE_NOT_FOUND:      not found;
 *                MERGE_INVALID_ARGV:   input invalid;
 *                MERGE_NO_PERMISSION:  path no permission
 */
int32_t DlogCheckCollectStatus(char *dir, uint32_t len)
{
    if ((dir == NULL) || (len == 0) || (len > PATH_MAX) || (strlen(dir) > len)) {
        SELF_LOG_ERROR("check failed, input args is invalid, pid = %d.", ToolGetPid());
        return MERGE_INVALID_ARGV;
    }
    // get real path
    char validPath[PATH_MAX] = { 0 };
    ONE_ACT_ERR_LOG(MergeGetRealPath(dir, validPath, PATH_MAX, R_OK) != SYS_OK, return MERGE_NO_PERMISSION,
                    "get dir real path failed, pid = %d.", ToolGetPid());
    errno_t err = strcat_s(validPath, (size_t)PATH_MAX - 1U, OUTPUT_GZ_LOG_FILE);
    if (err != EOK) {
        SELF_LOG_ERROR("make log path failed, ret = %d, errno = %d, pid = %d.",
            (int32_t)err, ToolGetErrorCode(), ToolGetPid());
        return MERGE_ERROR;
    }
    int32_t ret = ToolAccess(validPath);
    if (ret != 0) {
        return MERGE_NOT_FOUND;
    }
    return MERGE_SUCCESS;
}

/**
 * @brief           : get group log name pattern's num
 * @return          : group log nums
 */
STATIC uint32_t DlogGetGroupFilePatternsNum(const LogConfigInfo *info)
{
    int32_t num = 0;
    for (; num < GROUP_MAP_SIZE; num++) {
        if (strlen(info->groupName[num]) == 0U) {
            break;
        }
    }
    return (uint32_t)num;
}

/**
 * @brief           : construct log name patterns
 * @param [out]     : pattern      log name patterns
 * @param [in/out]  : num          log index
 * @param [in]      : path         log path pattern
 */
STATIC void DlogConstructPatterns(struct DlogPattern *pattern, int32_t *num, LogPathPattern *path)
{
    int32_t ret, retActive, retRotate;
    ret = snprintf_s(pattern[*num].path, PATH_MAX, (size_t)PATH_MAX - 1U, "%s/%s/",
                     path->path, path->dirName);
    retActive = snprintf_s(pattern[*num].active, NAME_MAX, (size_t)NAME_MAX - 1U, "%s%s",
                           path->fileName, path->activeSuffix);
    retRotate = snprintf_s(pattern[*num].rotate, NAME_MAX, (size_t)NAME_MAX - 1U, "%s%s",
                           path->fileName, path->rotateSuffix);
    if ((ret != -1) && (retActive != -1) && (retRotate != -1)) {
        (*num)++;
    } else {
        SELF_LOG_ERROR("snprintf failed, construct log dir[%s/%s] failed, pid = %d.",
                       path->dirName, path->fileName, ToolGetPid());
        (void)memset_s(&(pattern[*num]), sizeof(struct DlogPattern), 0, sizeof(struct DlogPattern));
    }
}

/**
 * @brief           : get group log name patterns
 * @param [out]     : pattern      log name patterns
 * @param [in/out]  : num          log index
 * @param [in]      : rootPath     log root path
 */
STATIC void DlogGetGroupLogPatterns(struct DlogPattern *pattern, int32_t *num,
                                    LogPathPattern *pathPattern, const LogConfigInfo *info)
{
    (void)memset_s(pathPattern->path, PATH_MAX, 0, PATH_MAX);
    errno_t err = strncpy_s(pathPattern->path, PATH_MAX, info->groupPath, PATH_MAX);
    if (err != EOK) {
        SELF_LOG_ERROR("strncpy_s failed, get group path failed, path = %s.", info->groupPath);
        return;
    }
    for (int32_t groupId = 0; groupId < GROUP_MAP_SIZE; groupId++) {
        if (strlen(info->groupName[groupId]) == 0U) {
            break;
        }
        (void)memset_s(pathPattern->dirName, NAME_MAX, 0, NAME_MAX);
        (void)memset_s(pathPattern->fileName, NAME_MAX, 0, NAME_MAX);
        // device-0 has different directory suructure
        if (strncmp(info->groupName[groupId], "device-0", strlen(info->groupName[groupId])) == 0) {
            int32_t ret = snprintf_s(pathPattern->dirName, NAME_MAX, (size_t)NAME_MAX - 1U, "%s/%s",
                DEBUG_DIR_NAME, info->groupName[groupId]);
            if (ret == -1) {
                SELF_LOG_ERROR("snprintf failed, construct dirName[%s/%s] failed, pid = %d.",
                    DEBUG_DIR_NAME, info->groupName[groupId], ToolGetPid());
                    continue;
            }
        } else {
            int32_t ret = snprintf_s(pathPattern->dirName, NAME_MAX, (size_t)NAME_MAX - 1U, "%s", DEBUG_DIR_NAME);
            if (ret  == -1) {
                SELF_LOG_ERROR("snprintf failed, construct dirName[%s] failed, pid = %d.",
                               DEBUG_DIR_NAME, ToolGetPid());
                continue;
            }
        }
        err = memcpy_s(pathPattern->fileName, NAME_MAX, info->groupName[groupId], NAME_MAX);
        if (err != EOK) {
            SELF_LOG_ERROR("memcpy failed, get group filename failed, filename = %s, pid = %d.",
                info->groupName[groupId], ToolGetPid());
        }
        
        DlogConstructPatterns(pattern, num, pathPattern);
    }
}

/**
 * @brief           : get general log name patterns
 * @param [out]     : pattern      log name patterns
 * @param [in/out]  : num          log index
 * @param [in]      : rootPath     log root path
 */
STATIC void DlogGetGeneralLogPatterns(struct DlogPattern *pattern, int32_t *num,
                                      LogPathPattern *pathPattern, const LogConfigInfo *info)
{
    (void)memset_s(pathPattern->path, PATH_MAX, 0, PATH_MAX);
    errno_t err = strncpy_s(pathPattern->path, PATH_MAX, info->rootPath, PATH_MAX);
    if (err != EOK) {
        SELF_LOG_ERROR("strncpy_s failed, get group path failed, path = %s.", info->rootPath);
        return;
    }
    char *sortDirName[(int32_t)LOG_TYPE_NUM] = { DEBUG_DIR_NAME, SECURITY_DIR_NAME, RUN_DIR_NAME };
    const char *logDir[GENERAL_LOG_NUM] = { DEVICE_OS_HEAD, DEVICE_APP_HEAD, AOS_CORE_DEVICE_APP_HEAD };
    const char *logName[GENERAL_LOG_NUM] = { DEVICE_OS_HEAD, DEVICE_APP_HEAD, AOS_CORE_DEVICE_APP_HEAD };
    for (uint32_t type = (uint32_t)DEBUG_LOG; type < (uint32_t)LOG_TYPE_NUM; type++) {
        for (uint32_t i = 0; i < GENERAL_LOG_NUM; i++) {
            (void)memset_s(pathPattern->dirName, NAME_MAX, 0, NAME_MAX);
            int32_t ret = snprintf_s(pathPattern->dirName, NAME_MAX, (size_t)NAME_MAX - 1U, "%s/%s*",
                                     sortDirName[type], logDir[i]);
            if (ret == -1) {
                SELF_LOG_ERROR("snprintf failed, construct dirName[%s/%s] failed, pid = %d.",
                               sortDirName[type], logDir[i], ToolGetPid());
                continue;
            }
            (void)memset_s(pathPattern->fileName, NAME_MAX, 0, NAME_MAX);
            err = memcpy_s(pathPattern->fileName, (size_t)NAME_MAX - 1U, logName[i], strlen(logName[i]));
            if (err != EOK) {
                SELF_LOG_ERROR("memcpy failed, get filename failed, filename = %s, pid = %d.",
                    logName[i], ToolGetPid());
            }
            DlogConstructPatterns(pattern, num, pathPattern);
        }
    }
}

/**
 * @brief           : get event log name patterns
 * @param [out]     : pattern      log name patterns
 * @param [in/out]  : num          log index
 * @param [in]      : rootPath     log root path
 */
STATIC void DlogGetEventLogPatterns(struct DlogPattern *pattern, int32_t *num,
                                    LogPathPattern *pathPattern, const LogConfigInfo *info)
{
    (void)memset_s(pathPattern->path, PATH_MAX, 0, PATH_MAX);
    errno_t err = strncpy_s(pathPattern->path, PATH_MAX, info->rootPath, PATH_MAX);
    if (err != EOK) {
        SELF_LOG_ERROR("strncpy_s failed, get group path failed, path = %s.", info->rootPath);
        return;
    }
    (void)memset_s(pathPattern->dirName, NAME_MAX, 0, NAME_MAX);
    int32_t ret = snprintf_s(pathPattern->dirName, NAME_MAX, (size_t)NAME_MAX - 1U, "%s/%s",
                             RUN_DIR_NAME, EVENT_DIR_NAME);
    if (ret == -1) {
        SELF_LOG_ERROR("snprintf failed, construct dirName[%s/%s] failed, pid = %d.",
                       RUN_DIR_NAME, EVENT_DIR_NAME, ToolGetPid());
    }
    (void)memset_s(pathPattern->fileName, NAME_MAX, 0, NAME_MAX);
    err = memcpy_s(pathPattern->fileName, (size_t)NAME_MAX - 1U, EVENT_HEAD, strlen(EVENT_HEAD));
    if (err != EOK) {
        SELF_LOG_ERROR("memcpy failed, get filename failed, filename = %s, pid = %d.",
            EVENT_HEAD, ToolGetPid());
    }
    DlogConstructPatterns(pattern, num, pathPattern);
}

/**
 * @brief           : get self log name patterns
 * @param [out]     : pattern      log name patterns
 * @param [in/out]  : num          log index
 * @param [in]      : rootPath     log root path
 */
STATIC void DlogGetSelfLogPatterns(struct DlogPattern *pattern, int32_t *num, const char *rootPath, uint32_t pathLen)
{
    (void)pathLen;
    int32_t ret = snprintf_s(pattern[*num].path, PATH_MAX, (size_t)PATH_MAX - 1U,
        "%s%s/", rootPath, LOG_DIR_FOR_SELF_LOG);
    int32_t retActive = snprintf_s(pattern[*num].active, NAME_MAX, (size_t)NAME_MAX - 1U, "slogdlog");
    int32_t retRotate = snprintf_s(pattern[*num].rotate, NAME_MAX, (size_t)NAME_MAX - 1U, "slogdlog.old");
    if ((ret != -1) && (retActive != -1) && (retRotate != -1)) {
        (*num)++;
    } else {
        SELF_LOG_ERROR("snprintf failed, construct log dir[slogd] failed, pid = %d.", ToolGetPid());
        (void)memset_s(&(pattern[*num]), sizeof(struct DlogPattern), 0, sizeof(struct DlogPattern));
    }
}

/**
 * @brief       : get log name patterns
 * @param [out] : logs      log name patterns
 * @param [in]  : info      log config info
 * @return      : MERGE_SUCCESS: success; MERGE_ERROR:   failed
 */
STATIC int32_t DlogGetAllLogPatterns(struct DlogNamePatterns *logs, const LogConfigInfo *info)
{
    int32_t logNum = 0;
    LogPathPattern pathPattern;
    (void)memset_s(&pathPattern, sizeof(LogPathPattern), 0, sizeof(LogPathPattern));
    int32_t retActive = snprintf_s(pathPattern.activeSuffix, NAME_MAX, (size_t)NAME_MAX - 1U, ".*%s",
        LOG_ACTIVE_FILE_GZ_SUFFIX);
    int32_t retRotate = snprintf_s(pathPattern.rotateSuffix, NAME_MAX, (size_t)NAME_MAX - 1U, "(?!.*%s).*%s",
        LOG_ACTIVE_STR, GZIP_SUFFIX);
    if ((retActive == -1) || (retRotate  == -1)) {
        SELF_LOG_ERROR("get log patterns failed, pid = %d.", ToolGetPid());
        return MERGE_ERROR;
    }
    // group
    DlogGetGroupLogPatterns(logs->patterns, &logNum, &pathPattern, info);
    // device-os + device-app + aos-core-app
    DlogGetGeneralLogPatterns(logs->patterns, &logNum, &pathPattern, info);
    // event
    DlogGetEventLogPatterns(logs->patterns, &logNum, &pathPattern, info);
    // slogdlog
    DlogGetSelfLogPatterns(logs->patterns, &logNum, info->rootPath, LogStrlen(info->rootPath));
    return MERGE_SUCCESS;
}

STATIC int32_t DlogGetConfigInfo(LogConfigInfo *info)
{
    // open iam service
    int32_t fd = INVALID;
    ONE_ACT_ERR_LOG(MergeOpenIamService(&fd) != SYS_OK, return SYS_ERROR,
                    "open iam service failed, errno = %d, pid = %d.", ToolGetErrorCode(), ToolGetPid());
    SELF_LOG_INFO("open iam service succeed, pid = %d.", ToolGetPid());
    struct IAMIoctlArg arg;
    arg.size = sizeof(LogConfigInfo);
    arg.argData = (void *)info;
    int32_t ret = MergeIoctlCollect(fd, &arg, IAM_CMD_COLLECT_LOG_PATTERN);
    if (ret != SYS_OK) {
        SELF_LOG_ERROR("iam service ioctl failed, ret = %d, errno = %d, pid = %d.",
                       ret, ToolGetErrorCode(), ToolGetPid());
        (void)close(fd);
        return SYS_ERROR;
    }
    SELF_LOG_INFO("iam service ioctl collect succeed, pid = %d.", ToolGetPid());
    (void)close(fd);
    LogStrTrimEnd(info->rootPath, PATH_MAX);
    LogStrTrimEnd(info->groupPath, PATH_MAX);
    return SYS_OK;
}

/**
 * @brief       : get hisi log configuration log name patterns, free patterns dynamic buffer by caller is required
 * @param [out] : logs      log name patterns
 * @return      : 0: success; others:   failed
 */
int32_t DlogGetLogPatterns(struct DlogNamePatterns *logs)
{
    ONE_ACT_ERR_LOG(logs == NULL, return MERGE_INVALID_ARGV, "input logs is null, pid = %d.", ToolGetPid());
    // get config file
    LogConfigInfo *info = (LogConfigInfo *)LogMalloc(sizeof(LogConfigInfo));
    ONE_ACT_ERR_LOG(info == NULL, return MERGE_ERROR,
        "malloc log config info failed, errno = %d, pid = %d.", ToolGetErrorCode(), ToolGetPid());
    int32_t ret = DlogGetConfigInfo(info);
    TWO_ACT_ERR_LOG(ret != SYS_OK, LogFree(info), return MERGE_ERROR,
        "get log config info failed, pid = %d.", ToolGetPid());

    // construct log patterns
    // get log num, GROUP + (genenal log) * LOG_TYPE_NUM + event + slogdlog
    logs->logNum = DlogGetGroupFilePatternsNum(info) + GENERAL_LOG_NUM * (uint32_t)LOG_TYPE_NUM + 1U + 1U;
    logs->patterns = (struct DlogPattern *)LogMalloc(sizeof(struct DlogPattern) * logs->logNum);
    TWO_ACT_ERR_LOG(logs->patterns == NULL, LogFree(info), return MERGE_ERROR,
        "malloc log patterns failed, errno = %d, pid = %d.", ToolGetErrorCode(), ToolGetPid());
    ret = DlogGetAllLogPatterns(logs, info);
    LogFree(info);
    return ret;
}
