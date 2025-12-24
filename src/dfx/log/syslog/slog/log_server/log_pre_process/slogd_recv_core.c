/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "slogd_recv_core.h"
#include "log_print.h"
#include "slogd_flush.h"
#include "log_pm_sig.h"

struct LogRecFuncNode {
    void (*receive)(void *);
};

typedef struct {
    struct {
        LogDistributeNode distributeNode[LOG_PRIORITY_TYPE_NUM];
    } distributeMgr;
    struct {
        int32_t devNum;
        DevThread devThread[MAX_DEV_NUM];
        struct LogRecFuncNode devNode[LOG_PRIORITY_TYPE_NUM];
        bool isThreadExit;
    } devThreadMgr;
    struct {
        int32_t priority[LOG_PRIORITY_TYPE_NUM];
        ComThread comThread[LOG_PRIORITY_TYPE_NUM];
        struct LogRecFuncNode comNode[LOG_PRIORITY_TYPE_NUM];
        bool isThreadExit;
    } comThreadMgr;
} ReceiveMgr;

// 优先级由LogPriority确定，不同类型线程优先级一致
STATIC ReceiveMgr g_receiveMgr = { 0 };

void SlogdWriteToBuffer(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    ONE_ACT_WARN_LOG((msg == NULL) || (info == NULL), return, "[input] null message or null info");
    ONE_ACT_WARN_LOG((info->type < DEBUG_LOG) || (info->type >= LOG_TYPE_NUM),
                     return, "[input] wrong log type=%d", (int32_t)info->type);

    for (int32_t i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
        if (g_receiveMgr.distributeMgr.distributeNode[i].checkLogType == NULL) {
            continue;
        }
        if (g_receiveMgr.distributeMgr.distributeNode[i].checkLogType(info)) {
            if (g_receiveMgr.distributeMgr.distributeNode[i].write != NULL) {
                g_receiveMgr.distributeMgr.distributeNode[i].write(msg, msgLen, info);
            }
            break;
        }
    }
}

static void *SlogdDevReceiveProc(void *args)
{
    ONE_ACT_ERR_LOG(args == NULL, return (void *)NULL, "args is NULL.");
    int32_t devId = *(int32_t *)args;
    char threadName[THREAD_NAME_MAX_LEN] = { 0 };
    int32_t ret = sprintf_s(threadName, THREAD_NAME_MAX_LEN, "LogRecvDev%d", devId);
    if (ret == -1) {
        SELF_LOG_ERROR("generate receive thread name for device %d failed.", devId);
        return (void *)NULL;
    }
    if (ToolSetThreadName(threadName) != SYS_OK) {
        SELF_LOG_WARN("can not set thread_name(%s).", threadName);
    }

    while (!g_receiveMgr.devThreadMgr.isThreadExit) {
        for (int32_t i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
            if (g_receiveMgr.devThreadMgr.devNode[i].receive != NULL) {
                g_receiveMgr.devThreadMgr.devNode[i].receive(args);
            }
        }
    }

    SELF_LOG_ERROR("Thread(%s) quit, signal=%d", threadName, LogGetSigNo());
    return (void *)NULL;
}

static void *SlogdComReceiveProc(void *args)
{
    ONE_ACT_ERR_LOG(args == NULL, return NULL, "args is NULL.");
    int32_t priority = *(int32_t *)args;
    ONE_ACT_ERR_LOG((priority < 0) || (priority >= (int32_t)LOG_PRIORITY_TYPE_NUM), return NULL, "priority %d is invalid.", priority);
    char threadName[THREAD_NAME_MAX_LEN] = { 0 };
    int32_t ret = sprintf_s(threadName, THREAD_NAME_MAX_LEN, "LogRecvCom%d", priority);
    if (ret == -1) {
        SELF_LOG_ERROR("generate common thread name for priority %d failed.", priority);
        return NULL;
    }

    NO_ACT_WARN_LOG(ToolSetThreadName(threadName) != SYS_OK,
        "can not set thread_name(%s).", threadName);

    while (!g_receiveMgr.comThreadMgr.isThreadExit && LogGetSigNo() == 0) {
        if (g_receiveMgr.comThreadMgr.comNode[priority].receive != NULL) {
            g_receiveMgr.comThreadMgr.comNode[priority].receive(args);
        }
    }

    SELF_LOG_ERROR("Thread(%s) quit, signal=%d", threadName, LogGetSigNo());
    return NULL;
}

static int32_t SlogdCreateDevThread(void)
{
    g_receiveMgr.devThreadMgr.isThreadExit = false;
    for (int32_t i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
        if (g_receiveMgr.devThreadMgr.devNode[i].receive != NULL) {     // devNode 有log注册才创建device线程
            return SlogdThreadMgrCreateDeviceThread(g_receiveMgr.devThreadMgr.devThread, MAX_DEV_NUM,
                &g_receiveMgr.devThreadMgr.devNum, SlogdDevReceiveProc);
        }
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : init receive thread
 * @return      : LOG_SUCCESS success; LOG_FAILURE failure
 */
int32_t SlogdReceiveInit(void)
{
    int32_t ret = SlogdCreateDevThread();
    if (ret != LOG_SUCCESS) {
        return ret;
    }

    g_receiveMgr.comThreadMgr.isThreadExit = false;
    for (int32_t i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
        g_receiveMgr.comThreadMgr.priority[i] = i;
        if (g_receiveMgr.comThreadMgr.comNode[i].receive != NULL) {     // 有日志注册才创建common线程
            g_receiveMgr.comThreadMgr.comThread[i].threadInfo.pulArg = (void *)&g_receiveMgr.comThreadMgr.priority[i];
            (void)SlogdThreadMgrCreateCommonThread(&g_receiveMgr.comThreadMgr.comThread[i], SlogdComReceiveProc);
        }
    }
    return LOG_SUCCESS;
}

/**
 * @brief       : 各类日志注册通用 distribute node 接口
 * @param[in]   : node          struct LogDistributeNode pointer
 * @return      : LOG_SUCCESS   success; LOG_FAILURE failure
 */
int32_t SlogdDistributeRegister(const LogDistributeNode *node)
{
    ONE_ACT_ERR_LOG(node == NULL, return LOG_FAILURE, "node pointer is NULL.");
    ONE_ACT_ERR_LOG((node->checkLogType == NULL) || (node->write == NULL), return LOG_FAILURE,
        "checkLogType or write function pointer is NULL.");
    g_receiveMgr.distributeMgr.distributeNode[(int32_t)node->priority].checkLogType = node->checkLogType;
    g_receiveMgr.distributeMgr.distributeNode[(int32_t)node->priority].write = node->write;
    return LOG_SUCCESS;
}

/**
 * @brief       : 各类日志注册独立 receive node 接口
 * @param[in]   : node          struct LogReceiveNode pointer
 * @return      : LOG_SUCCESS   success; LOG_FAILURE failure
 */
int32_t SlogdDevReceiveRegister(const LogReceiveNode *node)
{
    ONE_ACT_ERR_LOG(node == NULL, return LOG_FAILURE, "node pointer is NULL.");
    ONE_ACT_ERR_LOG(node->receive == NULL, return LOG_FAILURE, "receive function pointer is NULL.");
    g_receiveMgr.devThreadMgr.devNode[(int32_t)node->priority].receive = node->receive;
    return LOG_SUCCESS;
}

/**
 * @brief       : 日志注册common线程 receive node 接口
 * @param[in]   : node          struct LogReceiveNode pointer
 * @return      : LOG_SUCCESS   success; LOG_FAILURE failure
 */
int32_t SlogdComReceiveRegister(const LogReceiveNode *node)
{
    ONE_ACT_ERR_LOG(node == NULL, return LOG_FAILURE, "node pointer is NULL.");
    ONE_ACT_ERR_LOG(node->receive == NULL, return LOG_FAILURE, "receive function pointer is NULL.");
    g_receiveMgr.comThreadMgr.comNode[(int32_t)node->priority].receive = node->receive;
    return LOG_SUCCESS;
}

/**
 * @brief       : receive thread exit
 * @return      : void
 */
void SlogdReceiveExit(void)
{
    // join 线程
    g_receiveMgr.devThreadMgr.isThreadExit = true;
    g_receiveMgr.comThreadMgr.isThreadExit = true;
    ThreadManage threadManage = { LOG_PRIORITY_TYPE_NUM, g_receiveMgr.comThreadMgr.comThread,
        g_receiveMgr.devThreadMgr.devNum, g_receiveMgr.devThreadMgr.devThread };
    SlogdThreadMgrExit(&threadManage);

    // clean register
    for (int32_t i = 0; i < (int32_t)LOG_PRIORITY_TYPE_NUM; i++) {
        g_receiveMgr.distributeMgr.distributeNode[i].checkLogType = NULL;
        g_receiveMgr.distributeMgr.distributeNode[i].write = NULL;
        g_receiveMgr.devThreadMgr.devNode[i].receive = NULL;
        g_receiveMgr.comThreadMgr.comNode[i].receive = NULL;
    }
}