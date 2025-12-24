/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_flush.h"
#include "slog.h"
#include "log_pm_sig.h"
#include "log_system_api.h"
#include "log_print.h"
#include "log_pm.h"
#include "slogd_compress.h"
#include "slogd_eventlog.h"

#define FLUSH_BUFFER_SIZE (1024 * 1024)     // 1M

STATIC StLogFileList g_fileList;
STATIC SlogdStatus g_slogdStatus = SLOGD_RUNNING;

typedef struct {
    int32_t (*flush)(void *, uint32_t, bool);
    void (*get)(SessionItem *, void*, uint32_t, int32_t);
} FlushNode;

typedef struct {
    struct {
        ComThread comThread;
        FlushNode comNode[LOG_PRIORITY_TYPE_NUM];
        bool isThreadExit;
    } commonMgr;
    struct {
        int32_t devNum;
        bool isRegister;
        DevThread devThread[MAX_DEV_NUM];
        FlushNode devNode[LOG_PRIORITY_TYPE_NUM];
        bool isThreadExit;
    } devThreadMgr;
} FlushMgr;

STATIC FlushMgr g_flushMgr = { 0 };

#ifdef STATIC_BUFFER
#include "log_session_manage.h"
static bool SlogdFlushCheckInvalid(void)
{
    SessionItem item = { NULL, SESSION_CONTINUES_EXPORT };
    if (SessionMgrGetSession(&item) == LOG_SUCCESS) {
        return true;
    } else {
        return false;
    }
}
#else
static bool SlogdFlushCheckInvalid(void)
{
    return true;
}
#endif

STATIC int32_t GetPermissionForAllUserFlag(void)
{
    int32_t flag = 0;

    char val[CONF_VALUE_MAX_LEN + 1] = { 0 };
    LogRt ret = LogConfListGetValue(PERMISSION_FOR_ALL, LogStrlen(PERMISSION_FOR_ALL), val, CONF_VALUE_MAX_LEN);
    if ((ret == SUCCESS) && LogStrCheckNaturalNum((const char *)val)) {
        int64_t tmpL = -1;
        if (LogStrToInt(val, &tmpL) == LOG_SUCCESS) {
            flag = (tmpL == 1) ? 1 : 0;
        } else {
            flag = 0;
        }
    }
    return flag;
}

/**
 * @brief SyncGroupToOther: sync group permission to others, for example, input 0750, return 0755
 * @param [in]perm: current permission
 * @return: new permission
 */
toolMode SyncGroupToOther(toolMode perm)
{
    uint32_t tmpPerm = (uint32_t)perm;
    if (GetPermissionForAllUserFlag() != 0) {
        tmpPerm = ((tmpPerm & (uint32_t)S_IRGRP) != 0) ? (tmpPerm | (uint32_t)S_IROTH) : tmpPerm;
        tmpPerm = ((tmpPerm & (uint32_t)S_IWGRP) != 0) ? (tmpPerm | (uint32_t)S_IWOTH) : tmpPerm;
        tmpPerm = ((tmpPerm & (uint32_t)S_IXGRP) != 0) ? (tmpPerm | (uint32_t)S_IXOTH) : tmpPerm;
    }
    return (toolMode)tmpPerm;
}

/**
 * @brief        : set slogd status
 * @param [in]   : status      current slogd status
 */
void SlogdSetStatus(SlogdStatus status)
{
    g_slogdStatus = status;
}

SlogdStatus SlogdGetStatus(void)
{
    return g_slogdStatus;
}

StLogFileList *GetGlobalLogFileList(void)
{
    return &g_fileList;
}

static void SlogdFlushProcess(void *buffer, uint32_t bufSize, bool flushFlag)
{
    if (!SlogdCompressIsValid()) {
        return;
    }
    for (int32_t i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
        if (g_flushMgr.commonMgr.comNode[i].flush != NULL) {
            g_flushMgr.commonMgr.comNode[i].flush(buffer, bufSize, flushFlag);
        }
    }
}

void SlogdFlushToFile(bool flushFlag)
{
    uint32_t bufSize = FLUSH_BUFFER_SIZE;
    void *buffer = LogMalloc(bufSize);
    if (buffer == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr = %s", strerror(ToolGetErrorCode()));
    }
    SlogdFlushProcess(buffer, bufSize, flushFlag);
    XFREE(buffer);
    return;
}

void SlogdFlushGet(SessionItem *handle)
{
    uint32_t bufferLen = FLUSH_BUFFER_SIZE;
    void *buffer = LogMalloc(bufferLen);
    if (buffer == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr = %s", strerror(ToolGetErrorCode()));
    }

    // common get
    for (int32_t i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
        if (g_flushMgr.commonMgr.comNode[i].get != NULL) {
            g_flushMgr.commonMgr.comNode[i].get(handle, buffer, bufferLen, 0);
        }
    }

    // device get
    for (int32_t i = 0; i < g_flushMgr.devThreadMgr.devNum; i++) {
        for (int32_t j = 0; j < (int32_t)LOG_PRIORITY_TYPE_NUM; j++) {
            if (g_flushMgr.devThreadMgr.devNode[j].get != NULL) {
                g_flushMgr.devThreadMgr.devNode[j].get(handle, buffer, bufferLen,
                                                       g_flushMgr.devThreadMgr.devThread[i].deviceId);
            }
        }
    }

    LogFree(buffer);
}

STATIC void *SlogdFlushCommonProcess(void *args)
{
    (void)(args);
    static uint32_t printNum = 0;
    NO_ACT_WARN_LOG(ToolSetThreadName("LogFlushCommon") != SYS_OK, "can not set thread name(LogFlushCommon).");

    uint32_t bufSize = 1 * 1024 * 1024;
    void *buffer = LogMalloc(bufSize);
    if (buffer == NULL) {
        SELF_LOG_ERROR("malloc failed, strerr = %s", strerror(ToolGetErrorCode()));
    }
    while (!g_flushMgr.commonMgr.isThreadExit) {
        if (buffer == NULL) {
            buffer = LogMalloc(bufSize);
            if (buffer == NULL) {
                SELF_LOG_ERROR_N(&printNum, GENERAL_PRINT_NUM,
                                 "malloc for data flush failed, strerr=%s, print once every %u times.",
                                 strerror(ToolGetErrorCode()), GENERAL_PRINT_NUM);
                (void)ToolSleep(ONE_SECOND);
                continue;
            }
        }
        SlogdFlushProcess(buffer, bufSize, false);
        (void)ToolSleep(ONE_SECOND);    // EP 场景需测试 sleep 时间合理性
    }
    // force to flush when thread is to exit
    SlogdFlushProcess(buffer, bufSize, true);
    SELF_LOG_ERROR("Thread(flushCommonLog) quit, signal=%d.", LogGetSigNo());
    XFREE(buffer);
    return (void *)NULL;
}

STATIC void *SlogdFlushDeviceProcess(void *args)
{
    ONE_ACT_ERR_LOG(args == NULL, return (void *)NULL, "args is NULL.");
    int32_t devId = *(int32_t *)args;
    char threadName[THREAD_NAME_MAX_LEN] = { 0 };
    int32_t ret = 0;
    ret = sprintf_s(threadName, THREAD_NAME_MAX_LEN, "LogFlushDev%d", devId);
    ONE_ACT_ERR_LOG(ret == -1, return (void *)NULL, "generate flush thread name for device %d failed.", devId);
    if (ToolSetThreadName(threadName) != SYS_OK) {
        SELF_LOG_WARN("can not set thread_name(%s).", threadName);
    }

    int32_t i = 0;
    while (!g_flushMgr.devThreadMgr.isThreadExit) {
        if ((!SlogdFlushCheckInvalid()) || (!SlogdCompressIsValid())) {
            (void)ToolSleep(ONE_SECOND);
            continue;
        }
        for (i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
            if (g_flushMgr.devThreadMgr.devNode[i].flush != NULL) {
                g_flushMgr.devThreadMgr.devNode[i].flush(args, sizeof(uint32_t), false);
            }
        }
    }
    for (i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
        if (g_flushMgr.devThreadMgr.devNode[i].flush != NULL) {
            g_flushMgr.devThreadMgr.devNode[i].flush(args, sizeof(uint32_t), true);
        }
    }

    SELF_LOG_ERROR("Thread(%s) quit, signal=%d", threadName, LogGetSigNo());
    return (void *)NULL;
}

/**
 * @brief       : create thread to flush log
 * @return      : LOG_SUCCESS  success; others  failure
 */
STATIC LogStatus SlogdFlushCreateThread(void)
{
    g_flushMgr.commonMgr.isThreadExit = false;
    int32_t ret = SlogdThreadMgrCreateCommonThread(&g_flushMgr.commonMgr.comThread, SlogdFlushCommonProcess);
    if (ret != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    g_flushMgr.devThreadMgr.isThreadExit = false;
    if (g_flushMgr.devThreadMgr.isRegister) {
        ret = SlogdThreadMgrCreateDeviceThread(g_flushMgr.devThreadMgr.devThread, MAX_DEV_NUM,
            &g_flushMgr.devThreadMgr.devNum, SlogdFlushDeviceProcess);
        ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "create device thread failed.");
        return LOG_SUCCESS;
    }

    SELF_LOG_INFO("No device node is registered. No thread needs to be created.");
    return LOG_SUCCESS;
}

STATIC void SlogdFlushThreadExit(void)
{
    g_flushMgr.commonMgr.isThreadExit = true;
    g_flushMgr.devThreadMgr.isThreadExit = true;
    ThreadManage threadManage = { 1, &g_flushMgr.commonMgr.comThread, g_flushMgr.devThreadMgr.devNum,
        g_flushMgr.devThreadMgr.devThread };
    SlogdThreadMgrExit(&threadManage);
}

LogStatus SlogdFlushInit(void)
{
    LogStatus ret = LogAgentInitDeviceOs(&g_fileList);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("init log file info failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    ret = SlogdEventMgrInit(&g_fileList);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("init log file info failed, result=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    ret = LogAgentInitDeviceApplication(&g_fileList);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("init app log file info failed, result=%d.", ret);
        return LOG_FAILURE;
    }

    // create thread to flush log
    ret = SlogdFlushCreateThread();
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("create flush thread failed, ret=%d, strerr=%s.", ret, strerror(ToolGetErrorCode()));
        return LOG_FAILURE;
    }

    ret = SlogdCompressInit();
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("init compress resource failed, ret=%d.", ret);
        SlogdFlushThreadExit();
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}

void SlogdFlushExit(void)
{
    SlogdFlushThreadExit();
    for (int32_t i = 0 ; i < (int32_t)LOG_TYPE_NUM; ++i) {
        WriteFileLimitUnInit(&g_fileList.sortDeviceOsLogList[i].limit);
        WriteFileLimitUnInit(&g_fileList.sortDeviceAppLogList[i].limit);
        for (uint32_t j = 0; j < g_fileList.ucDeviceNum; j++) {
            if (g_fileList.deviceLogList[i] != NULL) {
                if (g_fileList.deviceLogList[i][j].limit == NULL) {
                    continue;
                }
                WriteFileLimitUnInit(&g_fileList.deviceLogList[i][j].limit);
            }
        }
    }
    WriteFileLimitUnInit(&g_fileList.eventLogList.limit);
    SlogdCompressExit();
    LogAgentCleanUpDevice(&g_fileList);
    return;
}

/**
 * @brief       : 各类日志注册 flush node 接口
 * @param[in]   : node          struct LogFlushNode pointer
 * @return      : LOG_SUCCESS   success; LOG_FAILURE failure
 */
int32_t SlogdFlushRegister(const LogFlushNode *flushNode)
{
    if (flushNode == NULL) {
        SELF_LOG_ERROR("flush node pointer is NULL.");
        return LOG_FAILURE;
    }
    if (flushNode->flush == NULL) {
        SELF_LOG_ERROR("flush function pointer is NULL.");
        return LOG_FAILURE;
    }

    if (flushNode->type == COMMON_THREAD_TYPE) {
        g_flushMgr.commonMgr.comNode[(int32_t)flushNode->priority].flush = flushNode->flush;
        g_flushMgr.commonMgr.comNode[(int32_t)flushNode->priority].get = flushNode->get;
    } else if (flushNode->type == DEVICE_THREAD_TYPE) {
        g_flushMgr.devThreadMgr.isRegister = true;
        g_flushMgr.devThreadMgr.devNode[(int32_t)flushNode->priority].flush = flushNode->flush;
        g_flushMgr.devThreadMgr.devNode[(int32_t)flushNode->priority].get = flushNode->get;
    } else {
        SELF_LOG_ERROR("threadType is invalid.");
        return LOG_FAILURE;
    }

    return LOG_SUCCESS;
}
