/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "server_mgr.h"
#include "ascend_hal.h"
#include "log_print.h"
#include "log_error_code.h"
#include "adx_component_api_c.h"
#include "log_system_api.h"
#include "adcore_api.h"

#define SESSION_MONITOR_THREAD_ATTR { 0, 0, 0, 0, 0, 1, 128 * 1024 } // Default ThreadSize(128KB)
#define SESSION_MONITOR_SLEEP_TIME  100 // 100ms
#define SESSION_THREAD_NAME_LEN     64
#define SESSION_THREAD_PARALLEL_NUM 64
#define SERVER_WAIT_STOP_TIME       64U // 2s (1 + 2 + ... + 64)ms
#define SERVER_REPLY_MAGIC          0xA2A2A2A2U
#define SERVER_REPLY_VERSION        0x1U

#define SERVER_REPLY_SUCCESS              HDC_END_MSG
#define SERVER_REPLY_CONTAINER            "server connect terminated, prohibit container operate"
#define SERVER_REPLY_UNREGISTERED         "server connect terminated, unregistered component type"
#define SERVER_REPLY_OVERLOAD             "server connect terminated, reached max number of parallels"
#define SERVER_REPLY_EXECUTION_ERROR      "server connect terminated, process execution exception"

#define SERVER_RESULT_SUCCESS              0
#define SERVER_RESULT_CONTAINER            1
#define SERVER_RESULT_UNREGISTERED         2
#define SERVER_RESULT_OVERLOAD             3
#define SERVER_RESULT_EXECUTION_ERROR      4

STATIC ServerMgr g_serverMgr[NR_COMPONENTS] = { 0 };

STATIC int32_t ServerWaitStop(ServerHandle handle)
{
    int32_t ret = LOG_FAILURE;
    uint32_t retryTime = 1;
    while (retryTime < SERVER_WAIT_STOP_TIME) {
        if (handle->processFlag) {
            (void)ToolSleep(retryTime++);
        } else {
            ret = LOG_SUCCESS;
            break;
        }
    }
    return ret;
}

STATIC void ServerDestroyCommHandle(const CommHandle *handle)
{
    AdxDestroyCommHandle((AdxCommHandle)handle);
}

STATIC int32_t SessionMonitorIsHandleValid(const CommHandle *handle)
{
    if (handle == NULL) {
        // this process does not require communication
        return LOG_FAILURE;
    }
    int32_t status = 0;
    int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_STATUS, &status);
    if ((ret != IDE_DAEMON_OK) || (status == HDC_SESSION_STATUS_CLOSE)) {
        SELF_LOG_ERROR("session monitor: get attr failed, ret: %d, status: %d", ret, status);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

STATIC void *SessionMonitorProcess(void *arg)
{
    ServerHandle mgr = (ServerHandle)arg;
    char threadName[SESSION_THREAD_NAME_LEN] = { 0 };
    int32_t ret = sprintf_s(threadName, SESSION_THREAD_NAME_LEN, "SessionMonitor%d", (int32_t)mgr->handle->comp);
    NO_ACT_WARN_LOG(ret == -1, "thread name sprintf_s failed");
    NO_ACT_WARN_LOG(ToolSetThreadName(threadName) != SYS_OK, "can not set thread name(%s).", threadName);

    while (mgr->monitorRunFlag) {
        if (SessionMonitorIsHandleValid(mgr->handle) != LOG_SUCCESS) {
            SELF_LOG_ERROR("session monitor: handle is invalid");
            mgr->monitorRunFlag = false;
            break;
        }
        (void)ToolSleep(SESSION_MONITOR_SLEEP_TIME); // 100ms
    }
    mgr->stop();
    LOCK_WARN_LOG(&mgr->lock);
    ServerDestroyCommHandle(mgr->handle);
    mgr->handle = NULL;
    mgr->linkedNum--;
    UNLOCK_WARN_LOG(&mgr->lock);
    ret = ServerWaitStop(mgr);
    NO_ACT_WARN_LOG(ret != LOG_SUCCESS, "start process exit exception");

    SELF_LOG_INFO("session monitor exit, flag: %d", (int32_t)(mgr->monitorRunFlag));
    return NULL;
}

static int32_t SessionMonitorCreate(ServerHandle handle)
{
    int32_t ret = LOG_SUCCESS;
    // join last thread if needed
    if (handle->monitorTid != 0) {
        ret = ToolJoinTask(&handle->monitorTid);
        NO_ACT_ERR_LOG(ret != 0, "pthread(sessionMonitor) join failed, strerr=%s.", strerror(ToolGetErrorCode()));
    }
    handle->monitorTid = 0;
    // start process
    handle->monitorRunFlag = true;
    ToolThread tid = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = SessionMonitorProcess;
    funcBlock.pulArg = (void *)(handle);
    ToolThreadAttr threadAttr = SESSION_MONITOR_THREAD_ATTR;
    ret = ToolCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
    if (ret != LOG_SUCCESS) {
        handle->monitorRunFlag = false;
        SELF_LOG_ERROR("create thread failed, result=%d.", ret);
        return LOG_FAILURE;
    }
    // record tid
    handle->monitorTid = tid;
    return LOG_SUCCESS;
}

static int32_t SessionMonitorRelease(ServerHandle handle)
{
    if (handle->monitorTid != 0) {
        handle->monitorRunFlag = false;
    }
    return LOG_SUCCESS;
}

static void ServerMgrNodeReset(ComponentType type)
{
    g_serverMgr[type].init = false;
    g_serverMgr[type].monitorRunFlag = false;
    g_serverMgr[type].processFlag = false;
    g_serverMgr[type].monitorTid = 0;
    g_serverMgr[type].handle = NULL;
    g_serverMgr[type].maxNum = 0;
    g_serverMgr[type].linkedNum = 0;
    g_serverMgr[type].linkType = 0;
    g_serverMgr[type].start = NULL;
    g_serverMgr[type].stop = NULL;
}

int32_t ServerMgrInit(void)
{
    for (int32_t i = 0; i < (int32_t)NR_COMPONENTS; ++i) {
        ServerMgrNodeReset(i);
        if (ToolMutexInit(&g_serverMgr[i].lock) != SYS_OK) {
            SELF_LOG_ERROR("init mutex failed, num: %d, strerr: %s", i, strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
    }
    return LOG_SUCCESS;
}

void ServerMgrExit(void)
{
}

STATIC int32_t ServerReplyMsg(const CommHandle *handle, int32_t replyCode, const char *msg)
{
    ServerResultInfo retInfo = { SERVER_REPLY_MAGIC, SERVER_REPLY_VERSION, replyCode, {0}, {0} };
    errno_t err = memcpy_s(retInfo.retMsg, SERVER_MSG_SIZE, msg, strlen(msg));
    ONE_ACT_ERR_LOG(err != EOK, return LOG_FAILURE, "memcpy_s reply failed, ret=%d, replyCode=%d", (int32_t)err,
        replyCode);
    int32_t ret = AdxSendMsg(handle, (const char *)&retInfo, sizeof(retInfo));
    ONE_ACT_ERR_LOG(ret != 0, return LOG_FAILURE, "send reply message failed, ret=%d, replyCode=%d", ret, replyCode);
    return LOG_SUCCESS;
}

STATIC int32_t ServerCheckContainer(const CommHandle *handle, ComponentType type)
{
    if (g_serverMgr[type].runEnv == ENV_ALL) {
        return LOG_SUCCESS;
    }
    if (g_serverMgr[type].runEnv == ENV_NON_DOCKER) {
        int32_t runEnv = 0;
        int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_RUN_ENV, &runEnv);
        if (ret != IDE_DAEMON_OK) {
            SELF_LOG_ERROR("get run env failed, %d.", ret);
            return LOG_FAILURE;
        }
        if (runEnv != RUN_ENV_PHYSICAL && runEnv != RUN_ENV_VIRTUAL) {
            SELF_LOG_WARN("prohibit container operate, type: %d, runEnv: %d.", (int32_t)type, runEnv);
            return LOG_INVALID_PARAM;
        }
        return LOG_SUCCESS;
    }

    SELF_LOG_ERROR("not support run env setting: %d, type: %d", g_serverMgr[type].runEnv, (int32_t)type);
    return LOG_FAILURE;
}

STATIC ComponentType ServerGetComponentType(AdxCommConHandle handle)
{
    return handle->comp;
};

STATIC int32_t ServerProcess(const CommHandle* handle, const void* msg, uint32_t len)
{
    (void)msg;
    (void)len;
    ComponentType type = ServerGetComponentType(handle);
    if (type >= NR_COMPONENTS) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        SELF_LOG_ERROR("server process, invalid type: %d", (int32_t)type);
        ServerDestroyCommHandle(handle);
        return LOG_FAILURE;
    }
    if (!g_serverMgr[type].init) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_UNREGISTERED, SERVER_REPLY_UNREGISTERED);
        SELF_LOG_ERROR("server process, type %d is not init", (int32_t)type);
        ServerDestroyCommHandle(handle);
        return LOG_FAILURE;
    }

    LOCK_WARN_LOG(&g_serverMgr[type].lock);
    uint32_t num = g_serverMgr[type].linkedNum;
    if (num >= g_serverMgr[type].maxNum) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_OVERLOAD, SERVER_REPLY_OVERLOAD);
        SELF_LOG_ERROR("server process, overload, current num: %u, max num: %u", num, g_serverMgr[type].maxNum);
        ServerDestroyCommHandle(handle);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }

    if (g_serverMgr[type].processFlag) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        SELF_LOG_ERROR("server process, type %d process is running", (int32_t)type);
        ServerDestroyCommHandle(handle);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }

    int32_t ret = ServerCheckContainer(handle, type);
    if (ret != LOG_SUCCESS) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_CONTAINER, SERVER_REPLY_CONTAINER);
        ServerDestroyCommHandle(handle);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        if (ret == LOG_FAILURE) {
            return LOG_FAILURE;
        }
        return LOG_SUCCESS;
    }
    g_serverMgr[type].handle = handle;

    ret = SessionMonitorCreate(&g_serverMgr[type]);
    if (ret != LOG_SUCCESS) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        ServerDestroyCommHandle(handle);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }

    if ((g_serverMgr[type].linkType == SERVER_LONG_LINK) || (g_serverMgr[type].linkType == SERVER_LONG_LINK_STOP)) {
        ret = ServerReplyMsg(handle, SERVER_RESULT_SUCCESS, SERVER_REPLY_SUCCESS);
        if (ret != IDE_DAEMON_OK) {
            ServerDestroyCommHandle(handle);
            UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
            SELF_LOG_ERROR("server process, send ack failed, ret: %d", ret);
            return LOG_FAILURE;
        }
    }
    g_serverMgr[type].processFlag = true;
    g_serverMgr[type].linkedNum++;
    UNLOCK_WARN_LOG(&g_serverMgr[type].lock);

    ret = g_serverMgr[type].start(&g_serverMgr[type]);
    if ((ret != LOG_SUCCESS) || (g_serverMgr[type].linkType == SERVER_LONG_LINK_STOP)) {
        (void)SessionMonitorRelease(&g_serverMgr[type]);
    }
    LOCK_WARN_LOG(&g_serverMgr[type].lock);
    g_serverMgr[type].processFlag = false;
    UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
    return ret;
}

STATIC int32_t ServerCheckCreateParam(ServerStart start, ServerStop stop, ServerAttr *attr)
{
    if ((start == NULL) || (stop == NULL)) {
        SELF_LOG_ERROR("server create param error, null func");
        return LOG_FAILURE;
    }

    if (attr->num > SESSION_THREAD_PARALLEL_NUM) {
        SELF_LOG_ERROR("server create param error, invalid parallel num: %u", attr->num);
        return LOG_FAILURE;
    }

    if (attr->linkType >= SERVER_LINK_TYPE_MAX) {
        SELF_LOG_ERROR("server create param error, invalid link type: %u", attr->linkType);
        return LOG_FAILURE;
    }

    if (attr->runEnv >= ENV_TYPE_MAX) {
        SELF_LOG_ERROR("server create param error, invalid run env: %d", attr->runEnv);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

int32_t ServerCreate(ComponentType type, ServerStart start, ServerStop stop, ServerAttr *attr)
{
    if (type >= NR_COMPONENTS) {
        SELF_LOG_ERROR("server create, invalid type: %d", (int32_t)type);
        return LOG_FAILURE;
    }

    int32_t ret = ServerCheckCreateParam(start, stop, attr);
    ONE_ACT_ERR_LOG(ret != LOG_SUCCESS, return LOG_FAILURE, "server create failed, invalid param input");

    if (g_serverMgr[type].init) {
        SELF_LOG_ERROR("server create, %d init is used", (int32_t)type);
        return LOG_FAILURE;
    }

    ret = AdxRegisterService(HDC_SERVICE_TYPE_IDE_FILE_TRANS, type, NULL, ServerProcess, NULL);
    if (ret != IDE_DAEMON_OK) {
        SELF_LOG_ERROR("register service failed, type: %d", (int32_t)type);
        return LOG_FAILURE;
    }

    g_serverMgr[type].start = start;
    g_serverMgr[type].stop = stop;
    g_serverMgr[type].linkType = attr->linkType;
    g_serverMgr[type].maxNum = attr->num;
    g_serverMgr[type].runEnv = attr->runEnv;
    g_serverMgr[type].init = true;

    return LOG_SUCCESS;
}

void ServerRelease(ComponentType type)
{
    if (g_serverMgr[type].init) {
        g_serverMgr[type].init = false;
        (void)SessionMonitorRelease(&g_serverMgr[type]);
        int32_t ret = LOG_SUCCESS;
        if (g_serverMgr[type].monitorTid != 0) {
            ret = ToolJoinTask(&g_serverMgr[type].monitorTid);
            NO_ACT_ERR_LOG(ret != 0, "pthread(sessionMonitor) join failed, strerr=%s.", strerror(ToolGetErrorCode()));
        }
        g_serverMgr[type].monitorTid = 0;
        ret = ServerWaitStop(&g_serverMgr[type]);
        NO_ACT_WARN_LOG(ret != LOG_SUCCESS, "start process exit exception when release");
        ServerMgrNodeReset(type);
    }
}

int32_t ServerCreateEx(ComponentType type, ServerComponentInit init, ServerComponentProcess process,
    ServerComponentUnInit uninit)
{
    return AdxRegisterService(HDC_SERVICE_TYPE_IDE_FILE_TRANS, type, init, process, uninit);
}

static int32_t ServerCheckHandle(ServerHandle handle)
{
    ONE_ACT_ERR_LOG(handle == NULL, return LOG_FAILURE, "check handle failed, handle is null");
    ONE_ACT_ERR_LOG(handle->handle == NULL, return LOG_FAILURE, "check handle failed, comm handle is null");
    ComponentType type = ServerGetComponentType(handle->handle);
    ONE_ACT_ERR_LOG(type >= NR_COMPONENTS , return LOG_FAILURE, "check handle failed, invalid type %d", (int32_t)type);
    if (!g_serverMgr[type].monitorRunFlag) {
        SELF_LOG_ERROR("check handle failed, process is stopped");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

int32_t ServerSyncFile(ServerHandle handle, const char *srcFileName, const char *dstFileName)
{
    ONE_ACT_ERR_LOG(ServerCheckHandle(handle) != LOG_SUCCESS, return LOG_FAILURE, "sync file check handle failed");
    return AdxSendFileByHandle(handle->handle, IDE_FILE_REPORT_REQ, srcFileName, dstFileName, SEND_FILE_TYPE_TMP_FILE);
}

int32_t ServerSendMsg(ServerHandle handle, const char *msg, uint32_t msgLen)
{
    ONE_ACT_ERR_LOG(ServerCheckHandle(handle) != LOG_SUCCESS, return LOG_FAILURE, "send message check handle failed");
    return AdxSendMsg(handle->handle, msg, msgLen);
}

int32_t ServerRecvMsg(ServerHandle handle, char **msg, uint32_t *msgLen, uint32_t timeout)
{
    ONE_ACT_ERR_LOG(ServerCheckHandle(handle) != LOG_SUCCESS, return LOG_FAILURE, "receive message check handle failed");
    return AdxRecvMsg((AdxCommHandle)handle->handle, msg, msgLen, timeout);
}

int32_t ServersStart(void)
{
    ServerInitInfo serverInfo;
    serverInfo.serverType = HDC_SERVICE_TYPE_IDE_FILE_TRANS;
    serverInfo.mode = 0;
    serverInfo.deviceId = -1;
    return AdxServiceStartup(serverInfo);
}
