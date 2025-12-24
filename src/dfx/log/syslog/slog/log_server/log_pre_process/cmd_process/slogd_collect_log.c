/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_collect_log.h"
#include "slogd_group_log.h"
#include "log_pm_sig.h"
#include "log_pm.h"
#include "slogd_flush.h"
#include "log_recv.h"
#include "slogd_config_mgr.h"
#include "slogd_syslog.h"
#include "slogd_applog_flush.h"
#include "slogd_eventlog.h"
#include "slogd_compress.h"
#include "log_path_mgr.h"

#ifdef SLOGD_COLLECT
#define COLLECT_SCAN_INTERVAL           15000U
#define COLLECT_LOG_BUFFER_SIZE         (3 * 1024 * 1024)
#define COLLECT_GROUP_LOG_SIZE          ((1024U + 512U) * 1024U)   // 1.5M
#define COLLECT_DEBUG_OS_LOG_SIZE       0.0
#define COLLECT_SECURITY_OS_LOG_SIZE    (0.1 * 1024 * 1024)
#define COLLECT_RUN_OS_LOG_SIZE         (0.2 * 1024 * 1024)
#define COLLECT_RUN_EVENT_LOG_SIZE      (1024U * 1024U / 5U) // 0.2M
#define COLLECT_MAX_CONCURRENT_NUM      10U
#define COLLECT_FULL_RATIO              100U
#define MIN(a, b) (((a) < (b)) ? (a) : (b))

// newest log collect
typedef struct {
    ToolMutex mutex;
    ToolCond cond;
    ToolThread tid;
} ThreadCondInfo;

typedef struct {
    uint32_t current;
    uint32_t last;
    char collectLogPath[COLLECT_MAX_CONCURRENT_NUM][PATH_MAX];
} CollectLogPath;

typedef struct {
    ThreadCondInfo thread;
    bool collectWait;
    uint32_t collectStatus;
    CollectLogPath path;
} CollectInfo;

STATIC CollectInfo g_collectInfo = {
    { PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0 },
    true,
    0,
    { 0, 0, { 0 } }
};

STATIC double g_sysLogRatio[LOG_TYPE_NUM] = {
    COLLECT_DEBUG_OS_LOG_SIZE,
    COLLECT_SECURITY_OS_LOG_SIZE,
    COLLECT_RUN_OS_LOG_SIZE
}; // pre-allocation ratio for syslog

/**
 * @brief           : set log path to g_collectInfo
 * @param[in]       : path          log path to collect newest log
 * @param[in]       : len           log path length
 */
STATIC void SlogdSetCollectLogPath(const char *path, uint32_t len)
{
    ONE_ACT_ERR_LOG((path == NULL) || (len == 0) || (len > PATH_MAX), return,
                    "collect log path len is invalid, len = %u.", len);
    errno_t ret = memset_s(g_collectInfo.path.collectLogPath[g_collectInfo.path.last], PATH_MAX, 0, PATH_MAX);
    ONE_ACT_ERR_LOG(ret != EOK, return, "memset failed, newest log buffer init failed, ret = %d.", ret);
    ret = memcpy_s(g_collectInfo.path.collectLogPath[g_collectInfo.path.last], PATH_MAX, path, len);
    if (ret != EOK) {
        SELF_LOG_ERROR("set collect log path failed, ret = %d, errno = %d.", ret, ToolGetErrorCode());
        return;
    }
    if (g_collectInfo.path.last + 1U >= COLLECT_MAX_CONCURRENT_NUM) {
        g_collectInfo.path.last = 0;
    } else {
        g_collectInfo.path.last++;
    }
    g_collectInfo.collectStatus++; // only when log path set success, count++
}

void SlogdCollectNotify(const char *path, uint32_t len)
{
    (void)ToolMutexLock(&g_collectInfo.thread.mutex);
    g_collectInfo.collectWait = false;
    SlogdSetCollectLogPath(path, len);
    (void)ToolCondNotify(&g_collectInfo.thread.cond);
    (void)ToolMutexUnLock(&g_collectInfo.thread.mutex);
}

/**
 * @brief           : collect newest log from logBuf of firmware
 * @param[out]      : logBuf        buffer to store newest log
 * @param[in]       : bufSize       buffer size
 * @param[out]      : pos           buffer offset
 */
STATIC void SlogdCollectFirmwareBufferLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    int32_t deviceId[MAX_DEV_NUM] = { 0 };
    int32_t deviceNum = 0;
    int32_t ret = log_get_device_id(deviceId, &deviceNum, MAX_DEV_NUM);
    if ((ret != SYS_OK) || (deviceNum > MAX_DEV_NUM) || (deviceNum <= 0)) {
        SELF_LOG_ERROR("get device id failed, result=%d, device_number=%d.", ret, deviceNum);
        return;
    }
    uint32_t size = 0;
    GroupInfo *group = GetGroupListHead();
    const GeneralGroupInfo *info = LogConfGroupGetInfo();
    ONE_ACT_ERR_LOG((group == NULL) || (info == NULL), return, "groupinfo is null, collect group log failed.");
    while (group != NULL) {
        if (strcmp(group->groupName, "device-0") == 0) { // firmware log
            size = (uint32_t)info->map[group->groupId].fileRatio * COLLECT_GROUP_LOG_SIZE / COLLECT_FULL_RATIO;
            break;
        }
        group = group->next;
    }
    size = size / (uint32_t)deviceNum;
    for (int32_t i = 0; i < deviceNum; i++) {
        int32_t devId = deviceId[i];
        ONE_ACT_WARN_LOG((devId < 0) || (devId >= MAX_DEV_NUM), continue,
                         "device id is invalid, device_id=%d, max_device_id=%d.", devId, MAX_DEV_NUM - 1);
        void *handle = SlogdBufferHandleOpen(FIRM_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, (uint32_t)devId);
        if (handle == NULL) {
            SELF_LOG_ERROR("get firmware log[device id = %d] buffer handle failed.", devId);
            continue;
        }
        ret = SlogdBufferCollectNewest(logBuf, bufSize, pos, handle, size);
        SlogdBufferHandleClose(&handle);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "collect firmware[%d] log failed.", devId);
    }
}

/**
 * @brief           : collect newest log from logBuf of group
 * @param[out]      : logBuf        buffer to store newest log
 * @param[in]       : bufSize       buffer size
 * @param[out]      : pos           buffer offset
 */
STATIC void SlogdCollectGroupBufferLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    GroupInfo *group = GetGroupListHead();
    const GeneralGroupInfo *info = LogConfGroupGetInfo();
    ONE_ACT_ERR_LOG((group == NULL) || (info == NULL), return, "groupinfo is null, collect group log failed.");
    LogStatus ret = LOG_SUCCESS;
    while (group != NULL) {
        // firmware log data is null, skip it
        if (strcmp(group->groupName, "device-0") == 0) {
            group = group->next;
            continue;
        }
        void *handle = SlogdBufferHandleOpen(GROUP_LOG_TYPE, (void *)group, LOG_BUFFER_WRITE_MODE, 0);
        if (handle == NULL) {
            SELF_LOG_ERROR("get group log[group name = %s] buffer handle failed.", group->groupName);
            group = group->next;
            continue;
        }
        uint32_t size = (uint32_t)info->map[group->groupId].fileRatio * COLLECT_GROUP_LOG_SIZE / COLLECT_FULL_RATIO;
        uint32_t logSize = MIN(size, bufSize - *pos);
        ret = SlogdBufferCollectNewest(logBuf, bufSize, pos, handle, logSize);
        SlogdBufferHandleClose(&handle);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "collect group[%s] log failed.", group->groupName);
        group = group->next;
    }
}

/**
 * @brief           : collect newest log from logBuf of os
 * @param[out]      : logBuf        buffer to store newest log
 * @param[in]       : bufSize       buffer size
 * @param[out]      : pos           buffer offset
 */
STATIC void SlogdCollectOsBufferLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; ++i) {
        void *handle = SlogdBufferHandleOpen(DEBUG_SYS_LOG_TYPE + i, NULL, LOG_BUFFER_WRITE_MODE, 0);
        if (handle == NULL) {
            SELF_LOG_ERROR("get syslog[%u] buffer handle failed.", i);
            continue;
        }
        uint32_t size = (uint32_t)g_sysLogRatio[i];
        uint32_t logSize = MIN(size, bufSize - *pos);
        LogStatus ret = SlogdBufferCollectNewest(logBuf, bufSize, pos, handle, logSize);
        SlogdBufferHandleClose(&handle);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "collect os[%u] log failed.", i);
    }
}

/**
 * @brief           : collect newest log from logBuf of event
 * @param[out]      : logBuf        buffer to store newest log
 * @param[in]       : bufSize       buffer size
 * @param[out]      : pos           buffer offset
 */
STATIC void SlogdCollectEventBufferLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    void *handle = SlogdBufferHandleOpen(EVENT_LOG_TYPE, NULL, LOG_BUFFER_WRITE_MODE, 0);
    if (handle == NULL) {
        SELF_LOG_ERROR("get eventlog buffer handle failed.");
        return;
    }
    uint32_t size = COLLECT_RUN_EVENT_LOG_SIZE;
    uint32_t logSize = MIN(size, bufSize - *pos);
    LogStatus ret = SlogdBufferCollectNewest(logBuf, bufSize, pos, handle, logSize);
    SlogdBufferHandleClose(&handle);
    NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "collect event log failed.");
}

STATIC void SlogdCollectAppCommonLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    for (int32_t i = 0; i < (int32_t)LOG_TYPE_NUM; ++i) {
        void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + i, NULL, LOG_BUFFER_WRITE_MODE, 0);
        if (handle == NULL) {
            continue;
        }
        uint32_t size = SlogdConfigMgrGetBufSize(DEBUG_APP_LOG_TYPE + i);
        uint32_t logSize = MIN(size, bufSize - *pos);
        LogStatus ret = SlogdBufferCollectNewest(logBuf, bufSize, pos, handle, logSize);
        SlogdBufferHandleClose(&handle);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "collect app[%d] log failed.", i);
    }
}

STATIC void SlogdCollectAppPidLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    SlogdAppLogLock();
    AppLogList *bufList = SlogdGetAppLogBufList();
    TWO_ACT_NO_LOG(bufList == NULL, (SlogdAppLogUnLock()), return);
    uint32_t nodeNum = SlogdGetAppNodeNum();
    if (nodeNum == 0) {
        SlogdAppLogUnLock();
        return;
    }
    uint32_t size = (bufSize - *pos) / nodeNum;
    size = MIN(size, SlogdConfigMgrGetBufSize(DEBUG_APP_LOG_TYPE));
    while (bufList != NULL) {
        void *handle = SlogdBufferHandleOpen(DEBUG_APP_LOG_TYPE + (int32_t)bufList->type, (void *)bufList,
            LOG_BUFFER_WRITE_MODE, bufList->deviceId);
        if (handle == NULL) {
            SELF_LOG_ERROR("get applog[%d] buffer handle failed.", bufList->pid);
            bufList = bufList->next;
            continue;
        }
        uint32_t logSize = MIN(size, bufSize - *pos);
        LogStatus ret = SlogdBufferCollectNewest(logBuf, bufSize, pos, handle, logSize);
        SlogdBufferHandleClose(&handle);
        NO_ACT_ERR_LOG(ret != LOG_SUCCESS, "collect app[%u] log failed.", bufList->pid);
        bufList = bufList->next;
    }
    SlogdAppLogUnLock();
}

/**
 * @brief           : collect newest log from logBuf of app
 * @param[out]      : logBuf        buffer to store newest log
 * @param[in]       : bufSize       buffer size
 * @param[out]      : pos           buffer offset
 */
STATIC void SlogdCollectAppBufferLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    SlogdCollectAppCommonLog(logBuf, bufSize, pos);
    SlogdCollectAppPidLog(logBuf, bufSize, pos);
}

STATIC INLINE void SlogdCollectNewestLog(char *logBuf, uint32_t bufSize, uint32_t *pos)
{
    // collect firmware newest log in buffer
    SlogdCollectFirmwareBufferLog(logBuf, bufSize, pos);
    // collect group newest log in buffer
    SlogdCollectGroupBufferLog(logBuf, bufSize, pos);
    // collect os newest log in buffer
    SlogdCollectOsBufferLog(logBuf, bufSize, pos);
    // collect event newest log in buffer
    SlogdCollectEventBufferLog(logBuf, bufSize, pos);
    // collect app newest log in buffer
    SlogdCollectAppBufferLog(logBuf, bufSize, pos);
}

void SlogdCollectThreadExit(void)
{
    if (g_collectInfo.thread.tid != 0) {
        SlogdCollectNotify(NULL, 0);
        (void)ToolJoinTask(&g_collectInfo.thread.tid);
    }
}

STATIC LogStatus SlogdCollectWriteToFile(const char *fileName, const char *logBuf, uint32_t bufLen)
{
    int32_t fd = ToolOpenWithMode(fileName, (uint32_t)O_CREAT | (uint32_t)O_TRUNC | (uint32_t)O_WRONLY,
        LOG_FILE_RDWR_MODE);
    if (fd < 0) {
        SELF_LOG_ERROR("open file failed with mode, file=%s, strerr=%s.", fileName, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    int32_t ret = ToolWrite(fd, logBuf, bufLen);
    if ((ret < 0) || ((size_t)ret != bufLen)) {
        LOG_CLOSE_FD(fd);
        SELF_LOG_ERROR("write to file failed, file=%s, data_length=%u, write_length=%d, strerr=%s.",
                       fileName, bufLen, ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }
    int32_t err = ToolFChownPath(fd);
    if (err != SYS_OK) {
        SELF_LOG_ERROR("change file owner failed, file=%s, log_err=%d, strerr=%s.",
                       fileName, err, strerror(ToolGetErrorCode()));
    }
    LOG_CLOSE_FD(fd);
    return LOG_SUCCESS;
}

/**
 * @brief           : collect newest log
 * @return          : == LOG_SUCCESS success; others failure
 */
STATIC LogStatus SlogdCollectBufferLog(void)
{
    char *logBuf = (char *)LogMalloc(COLLECT_LOG_BUFFER_SIZE + 1);
    if (logBuf == NULL) {
        SELF_LOG_ERROR("malloc failed, newest log buffer init failed.");
        return LOG_FAILURE;
    }
    uint32_t pos = 0;
    // collect newest log in buffer
    SlogdCollectNewestLog(logBuf, COLLECT_LOG_BUFFER_SIZE, &pos);

    // write to file
    char *fileName = g_collectInfo.path.collectLogPath[g_collectInfo.path.current];
    char *zippedBuf = NULL;
    uint32_t zippedBufLen = 0;
    LogStatus ret = SlogdCompress(logBuf, pos, &zippedBuf, &zippedBufLen);
    XFREE(logBuf);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("compress failed, collect newest log failed, ret = %d.", ret);
        return LOG_FAILURE;
    }
    ret = SlogdCollectWriteToFile(fileName, zippedBuf, zippedBufLen);
    XFREE(zippedBuf);

    if (g_collectInfo.path.current + 1U >= COLLECT_MAX_CONCURRENT_NUM) {
        g_collectInfo.path.current = 0;
    } else {
        g_collectInfo.path.current++;
    }
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "collect newest log failed, file name = %s.", fileName);
    SELF_LOG_INFO("collect newest log success, file name = %s.", fileName);
    return LOG_SUCCESS;
}

STATIC void *SlogdCollectLog(ArgPtr arg)
{
    (void)arg;
    NO_ACT_WARN_LOG(ToolSetThreadName("LogCollect") != SYS_OK, "can not set thread name(LogCollect).");

    while (LogGetSigNo() == 0) {
        // collect log
        if (g_collectInfo.collectStatus > 0) {
            SELF_LOG_INFO("slogd start collect newest log.");
            LogStatus ret = SlogdCollectBufferLog();
            if (ret != LOG_SUCCESS) {
                SELF_LOG_ERROR("slogd collect newest log failed, ret = %d.", ret);
            }
            g_collectInfo.collectStatus--;
            if (g_collectInfo.collectStatus > 0) {
                g_collectInfo.collectWait = false;
            }
        }
        // sleep when no need to collect log
        (void)ToolMutexLock(&g_collectInfo.thread.mutex);
        // if notify, continue
        if (g_collectInfo.collectWait) {
            (void)ToolCondTimedWait(&g_collectInfo.thread.cond, &g_collectInfo.thread.mutex, COLLECT_SCAN_INTERVAL);
        }
        g_collectInfo.collectWait = true;
        (void)ToolMutexUnLock(&g_collectInfo.thread.mutex);
    }
    SELF_LOG_INFO("slogd collect thread exit, g_gotSignal = %d.", LogGetSigNo());
    return NULL;
}

/**
 * @brief           : start thread to collect newest log
 */
void SlogdStartCollectThread(void)
{
    // start thread
    ToolUserBlock thread;
    thread.procFunc = SlogdCollectLog;
    thread.pulArg = NULL;
    (void)ToolCondInit(&g_collectInfo.thread.cond);
    (void)ToolMutexInit(&g_collectInfo.thread.mutex);
    ToolThreadAttr attr = { 0, 0, 0, 0, 0, 0, 0 };
    ToolThread tid = 0;
    ONE_ACT_ERR_LOG(ToolCreateTaskWithThreadAttr(&tid, &thread, &attr) != SYS_OK, return,
                    "create task failed, strerr=%s.", strerror(ToolGetErrorCode()));
    g_collectInfo.thread.tid = tid;
}

STATIC LogStatus SlogdCheckDir(const char *path, uint32_t len)
{
    ONE_ACT_ERR_LOG((path == NULL) || (len <= 0) || (len > PATH_MAX), return LOG_INVALID_PARAM, "input is invalid.");
    char dir[PATH_MAX] = { 0 };
    errno_t err = strncpy_s(dir, PATH_MAX, path, len);
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "strncpy failed, path = %s.", path);
    char *find = strrchr(dir, '/'); // find dir and check dir permission
    if (find == NULL) {
        SELF_LOG_ERROR("get collect dir failed, path = %s.", path);
        return LOG_FAILURE;
    }
    *find = '\0';
    if ((ToolAccessWithMode(dir, F_OK) != SYS_OK) || (ToolAccessWithMode(dir, W_OK) != SYS_OK)) {
        SELF_LOG_ERROR("dir has no permission, dir = %s.", dir);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

bool SlogdCheckCollectValid(const char *path, uint32_t len)
{
    ONE_ACT_ERR_LOG(SlogdCheckDir(path, len) != LOG_SUCCESS, return false, "input is invalid");
    ONE_ACT_ERR_LOG(g_collectInfo.collectStatus >= COLLECT_MAX_CONCURRENT_NUM, return false,
        "collect concurrent max, path=%s.", path);
    return true;
}

LogStatus SlogdGetLogPatterns(LogConfigInfo *info)
{
    // get rootPath
    ONE_ACT_ERR_LOG(info == NULL, return LOG_FAILURE, "input args is null, get log patterns failed.");
    (void)memset_s(info, sizeof(LogConfigInfo), 0, sizeof(LogConfigInfo));
    char *rootPath = LogGetRootPath();
    ONE_ACT_ERR_LOG(rootPath == NULL, return LOG_FAILURE, "root path is null.");
    errno_t err = strncpy_s(info->rootPath, PATH_MAX, rootPath, CFG_LOGAGENT_PATH_MAX_LENGTH);
    if (err != EOK) {
        SELF_LOG_ERROR("strncpy_s failed, log_path=%s, strerr=%s.\n", rootPath, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    // get group path
    const GeneralGroupInfo *groupInfo = LogConfGroupGetInfo();
    ONE_ACT_ERR_LOG(groupInfo == NULL, return LOG_FAILURE, "group info is null, get log patterns failed.");
    err = strncpy_s(info->groupPath, PATH_MAX, groupInfo->agentFileDir, SLOG_AGENT_FILE_DIR);
    if (err != EOK) {
        SELF_LOG_ERROR("strncpy_s failed, get group path failed.");
        return LOG_FAILURE;
    }

    // get group name
    for (int32_t groupId = 0; groupId < GROUP_MAP_SIZE; groupId++) {
        if (groupInfo->map[groupId].isInit == 0) {
            break;
        }
        err = strncpy_s(info->groupName[groupId], NAME_MAX, groupInfo->map[groupId].name, GROUP_NAME_MAX_LEN);
        if (err != EOK) {
            SELF_LOG_ERROR("strncpy_s failed, get group name failed, groupname=%s.", groupInfo->map[groupId].name);
            return LOG_FAILURE;
        }
    }
    return LOG_SUCCESS;
}

#else
void SlogdStartCollectThread(void)
{
    return;
}

void SlogdCollectNotify(const char *path, uint32_t len)
{
    (void)path;
    (void)len;
}

void SlogdCollectThreadExit(void)
{
    return;
}

bool SlogdCheckCollectValid(const char *path, uint32_t len)
{
    (void)path;
    (void)len;
    return true;
}

LogStatus SlogdGetLogPatterns(LogConfigInfo *info)
{
    (void)info;
    return LOG_SUCCESS;
}
#endif