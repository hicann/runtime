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

#define SESSION_MONITOR_THREAD_ATTR  \
    {                                \
        0, 0, 0, 0, 0, 1, 128 * 1024 \
    }                                  // Default ThreadSize(128KB)
#define SESSION_MONITOR_SLEEP_TIME 100 // 100ms
#define SESSION_THREAD_NAME_LEN 64
#define SESSION_THREAD_PARALLEL_NUM 64
#define SERVER_WAIT_STOP_TIME 64U // 2s (1 + 2 + ... + 64)ms
#define SERVER_REPLY_MAGIC 0xA2A2A2A2U
#define SERVER_REPLY_VERSION 0x1U

#define SERVER_REPLY_SUCCESS HDC_END_MSG
#define SERVER_REPLY_CONTAINER "server connect terminated, prohibit container operate"
#define SERVER_REPLY_UNREGISTERED "server connect terminated, unregistered component type"
#define SERVER_REPLY_OVERLOAD "server connect terminated, reached max number of parallels"
#define SERVER_REPLY_EXECUTION_ERROR "server connect terminated, process execution exception"

#define SERVER_RESULT_SUCCESS 0
#define SERVER_RESULT_CONTAINER 1
#define SERVER_RESULT_UNREGISTERED 2
#define SERVER_RESULT_OVERLOAD 3
#define SERVER_RESULT_EXECUTION_ERROR 4

STATIC ServerMgr g_serverMgr[NR_COMPONENTS] = {0};

STATIC int32_t ServerWaitStop(ServerHandle handle)
{
    int32_t ret = LOG_FAILURE;
    uint32_t retryTime = 1;
    while (retryTime < SERVER_WAIT_STOP_TIME) {
        if (handle->processFlag) {
            (void)ToolSleep(retryTime);
            retryTime++;
        } else {
            ret = LOG_SUCCESS;
            break;
        }
    }
    return ret;
}

STATIC void ServerDestroyCommHandle(const CommHandle* handle) { AdxDestroyCommHandle((AdxCommHandle)handle); }

STATIC ComponentType ServerGetComponentType(AdxCommConHandle handle) { return handle->comp; }

// caller must hold handle->stateLock; monitorRunFlag is read unguarded on purpose:
// it is a fast-fail hint only, the monitor loop reads it the same way
STATIC bool ServerCommNodeAcquirableLocked(ServerHandle handle, const ServerCommNode* node, bool checkRunFlag)
{
    if ((node == NULL) || node->dying) {
        return false;
    }
    return !checkRunFlag || handle->monitorRunFlag;
}

/*
 * Take a reference on the manager's current session node under stateLock.
 * The returned node (and its comm handle) is guaranteed to stay alive until the matching
 * ServerReleaseCommNode, even if the session monitor detaches it concurrently. When
 * checkRunFlag is false the monitorRunFlag state is ignored: only the owner (session
 * monitor thread) acquires this way. Only stateLock is taken: this path must never wait
 * for lock, whose holder may be joining the session monitor thread.
 * References are counted per generation (per node): a concurrent new session publishes its
 * own node, in-flight references of different sessions never mix into one counter.
 */
STATIC ServerCommNode* ServerAcquireCommNode(ServerHandle handle, bool checkRunFlag)
{
    LOCK_WARN_LOG(&handle->stateLock);
    ServerCommNode* node = handle->current;
    if (!ServerCommNodeAcquirableLocked(handle, node, checkRunFlag)) {
        node = NULL;
    } else {
        node->refs++;
    }
    UNLOCK_WARN_LOG(&handle->stateLock);
    return node;
}

/*
 * Drop a reference taken by ServerAcquireCommNode. Nodes are referenced by pointer, each
 * generation is destroyed by its own last releaser: references held on other sessions are
 * counted on their own nodes and can neither delay nor trigger this node's destroy.
 * Destroy happens outside of stateLock.
 */
STATIC void ServerReleaseCommNode(ServerHandle handle, ServerCommNode* node)
{
    if (node == NULL) {
        return;
    }
    LOCK_WARN_LOG(&handle->stateLock);
    node->refs--;
    ServerCommNode* dying = NULL;
    if (node->dying && (node->refs == 0)) {
        ServerCommNode** slot = &handle->commList;
        while (*slot != NULL) {
            if (*slot == node) {
                dying = *slot;
                *slot = dying->next;
                break;
            }
            slot = &(*slot)->next;
        }
    }
    UNLOCK_WARN_LOG(&handle->stateLock);
    if (dying != NULL) {
        ServerDestroyCommHandle(dying->comm);
        XFREE(dying);
    }
}

STATIC int32_t SessionMonitorIsHandleValid(const CommHandle* handle)
{
    if (handle == NULL) {
        // this process does not require communication
        return LOG_FAILURE;
    }
    int32_t status = 0;
    int32_t ret = AdxGetAttrByCommHandle(handle, HDC_SESSION_ATTR_STATUS, &status);
    if ((ret != IDE_DAEMON_OK) || (status == (int32_t)HDC_SESSION_STATUS_CLOSE)) {
        SELF_LOG_ERROR("session monitor: get attr failed, ret: %d, status: %d", ret, status);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

// thread startup argument: binds the monitor to the exact generation node published by
// its own ServerProcess, so the thread can never pick up a newer session from mgr->current
// within the scheduling window between thread creation and its first instruction
typedef struct {
    ServerHandle mgr;
    ServerCommNode* node;
} SessionMonitorArg;

STATIC void* SessionMonitorProcess(void* arg)
{
    SessionMonitorArg* ctx = (SessionMonitorArg*)arg;
    ServerHandle mgr = ctx->mgr;
    ServerCommNode* mine = ctx->node;
    XFREE(ctx);
    // hold a lifetime reference on our own session node, so the comm handle stays valid
    // during the whole thread; the node pointer belongs to this generation alone, no
    // reference of any other session is ever counted on it
    LOCK_WARN_LOG(&mgr->stateLock);
    if (mine->dying) {
        // unreachable with the current call sequence (only this thread or the rolled-back
        // create path mark its own node dying), kept as a defensive fast bail-out
        mine = NULL;
    } else {
        mine->refs++;
    }
    UNLOCK_WARN_LOG(&mgr->stateLock);
    if (mine == NULL) {
        SELF_LOG_ERROR("session monitor: acquire comm node failed");
        // roll back the link slot reserved by ServerProcess for this monitor: nobody else
        // decrements it on this path, a leaked slot would reject every later connection
        LOCK_WARN_LOG(&mgr->stateLock);
        if (mgr->linkedNum > 0) {
            mgr->linkedNum--;
        }
        UNLOCK_WARN_LOG(&mgr->stateLock);
        return NULL;
    }
    AdxCommConHandle comm = mine->comm;
    char threadName[SESSION_THREAD_NAME_LEN] = {0};
    int32_t ret = sprintf_s(threadName, SESSION_THREAD_NAME_LEN, "SessionMonitor%d", (int32_t)comm->comp);
    NO_ACT_WARN_LOG(ret == -1, "thread name sprintf_s failed");
    NO_ACT_WARN_LOG(ToolSetThreadName(threadName) != SYS_OK, "can not set thread name(%s).", threadName);

    while (mgr->monitorRunFlag) {
        if (SessionMonitorIsHandleValid(comm) != LOG_SUCCESS) {
            SELF_LOG_ERROR("session monitor: handle is invalid");
            mgr->monitorRunFlag = false;
            break;
        }
        (void)ToolSleep(SESSION_MONITOR_SLEEP_TIME); // 100ms
    }

    // detach the session: new sync/send/recv requests fail fast from now on instead of
    // racing with the destroy (use-after-free). The whole tail takes stateLock ONLY and
    // never waits for lock: a new connection may be joining this very thread under lock
    // (SessionMonitorCreate), sharing that lock here would deadlock the session turnover.
    // After dying is set, the handle is destroyed as soon as the last reference drops,
    // refs already counts only this generation's holders (monitor + in-flight requests).
    LOCK_WARN_LOG(&mgr->stateLock);
    if (mgr->current == mine) {
        mgr->current = NULL;
    }
    if (mgr->linkedNum > 0) {
        // roll back the slot reserved by our own ServerProcess even when a newer session
        // already replaced the handle: each generation owns exactly one slot
        mgr->linkedNum--;
    }
    mine->dying = true;
    UNLOCK_WARN_LOG(&mgr->stateLock);

    mgr->stop();
    ret = ServerWaitStop(mgr);
    NO_ACT_WARN_LOG(ret != LOG_SUCCESS, "start process exit exception");
    ServerReleaseCommNode(mgr, mine); // drops our lifetime reference, destroys when last

    SELF_LOG_INFO("session monitor exit, flag: %d", (int32_t)(mgr->monitorRunFlag));
    return NULL;
}

static int32_t SessionMonitorCreate(ServerHandle handle, ServerCommNode* node)
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
    // the argument binds the new monitor to this exact generation node: taking it from
    // mgr->current instead would race with a concurrent publish inside the scheduling
    // window and could make this monitor operate on (and detach) the wrong session
    SessionMonitorArg* arg = (SessionMonitorArg*)LogMalloc(sizeof(SessionMonitorArg));
    if (arg == NULL) {
        handle->monitorRunFlag = false;
        SELF_LOG_ERROR("alloc monitor arg failed");
        return LOG_FAILURE;
    }
    arg->mgr = handle;
    arg->node = node;
    ToolThread tid = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = SessionMonitorProcess;
    funcBlock.pulArg = (void*)(arg);
    ToolThreadAttr threadAttr = SESSION_MONITOR_THREAD_ATTR;
    ret = ToolCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
    if (ret != LOG_SUCCESS) {
        handle->monitorRunFlag = false;
        SELF_LOG_ERROR("create thread failed, result=%d.", ret);
        XFREE(arg);
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
    // commList is deliberately preserved across the reset: ServerRelease callers may drain
    // in-flight requests only AFTER the release (lib_load upgrade path), so a pending dying
    // node must survive and let its own last releaser destroy the handle. Clearing the list
    // here would leak the handle and drop the pending references.
    LOCK_WARN_LOG(&g_serverMgr[type].stateLock);
    g_serverMgr[type].current = NULL;
    g_serverMgr[type].linkedNum = 0;
    UNLOCK_WARN_LOG(&g_serverMgr[type].stateLock);
    g_serverMgr[type].init = false;
    g_serverMgr[type].monitorRunFlag = false;
    g_serverMgr[type].processFlag = false;
    g_serverMgr[type].monitorTid = 0;
    g_serverMgr[type].maxNum = 0;
    g_serverMgr[type].linkType = 0;
    g_serverMgr[type].start = NULL;
    g_serverMgr[type].stop = NULL;
    g_serverMgr[type].send = ServerSendMsg;
    g_serverMgr[type].recv = ServerRecvMsg;
}

int32_t ServerMgrInit(void)
{
    for (int32_t i = 0; i < (int32_t)NR_COMPONENTS; ++i) {
        if (ToolMutexInit(&g_serverMgr[i].lock) != SYS_OK) {
            SELF_LOG_ERROR("init mutex failed, num: %d, strerr: %s", i, strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
        if (ToolMutexInit(&g_serverMgr[i].stateLock) != SYS_OK) {
            SELF_LOG_ERROR("init state mutex failed, num: %d, strerr: %s", i, strerror(ToolGetErrorCode()));
            return LOG_FAILURE;
        }
        ServerMgrNodeReset(i);
        // a fresh manager start drops every leftover generation node: NodeReset keeps them
        // for release-then-drain callers (lib_load), but no legitimate in-flight user can
        // exist at a fresh init, so pending nodes here are only stale state
        LOCK_WARN_LOG(&g_serverMgr[i].stateLock);
        ServerCommNode** slot = &g_serverMgr[i].commList;
        while (*slot != NULL) {
            ServerCommNode* node = *slot;
            if (node->refs != 0) {
                // never free a node with live holders: that would turn a leak into a UAF
                SELF_LOG_ERROR("server mgr init: pending comm node leaked, refs: %u", node->refs);
                slot = &node->next;
                continue;
            }
            *slot = node->next;
            XFREE(node);
        }
        UNLOCK_WARN_LOG(&g_serverMgr[i].stateLock);
    }
    return LOG_SUCCESS;
}

void ServerMgrExit(void) {}

STATIC int32_t ServerReplyMsg(const CommHandle* handle, int32_t replyCode, const char* msg)
{
    ServerResultInfo retInfo = {SERVER_REPLY_MAGIC, SERVER_REPLY_VERSION, replyCode, {0}, {0}};
    errno_t err = memcpy_s(retInfo.retMsg, SERVER_MSG_SIZE, msg, strlen(msg));
    ONE_ACT_ERR_LOG(
        err != EOK, return LOG_FAILURE, "memcpy_s reply failed, ret=%d, replyCode=%d", (int32_t)err, replyCode);
    int32_t ret = AdxSendMsg(handle, (const char*)&retInfo, (uint32_t)sizeof(retInfo));
    ONE_ACT_ERR_LOG(ret != 0, return LOG_FAILURE, "send reply message failed, ret=%d, replyCode=%d", ret, replyCode);
    return LOG_SUCCESS;
}

STATIC int32_t ServerCheckContainer(const CommHandle* handle, ComponentType type)
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
    // linkedNum/handle live under stateLock (nested under lock, never the other way round);
    // stateLock is NOT held across SessionMonitorCreate below: its join must not share a
    // lock with the old monitor tail, which takes stateLock only
    LOCK_WARN_LOG(&g_serverMgr[type].stateLock);
    uint32_t num = g_serverMgr[type].linkedNum;
    UNLOCK_WARN_LOG(&g_serverMgr[type].stateLock);
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
    // publish the session as a new generation node: every reference taken from now on
    // (monitor lifetime + in-flight requests) is counted on this node alone, references
    // of concurrent sessions land on their own nodes and never mix into one counter
    ServerCommNode* node = (ServerCommNode*)LogMalloc(sizeof(ServerCommNode));
    if (node == NULL) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        SELF_LOG_ERROR("server process, alloc comm node failed");
        ServerDestroyCommHandle(handle); // nothing was published, release the framework handle
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }
    node->comm = handle;
    node->refs = 0;
    node->dying = false;
    LOCK_WARN_LOG(&g_serverMgr[type].stateLock);
    node->next = g_serverMgr[type].commList;
    g_serverMgr[type].commList = node;
    g_serverMgr[type].current = node;
    // reserve the link slot before creating the monitor thread, so a concurrent connect
    // is rejected by the overload check while this session is being set up.
    g_serverMgr[type].linkedNum++;
    UNLOCK_WARN_LOG(&g_serverMgr[type].stateLock);

    ret = SessionMonitorCreate(&g_serverMgr[type], node);
    if (ret != LOG_SUCCESS) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        // hand the node over to the reference machinery: pending in-flight users, if any,
        // release it to zero and the last ServerReleaseCommNode destroys the handle
        LOCK_WARN_LOG(&g_serverMgr[type].stateLock);
        if (g_serverMgr[type].current == node) {
            g_serverMgr[type].current = NULL;
        }
        g_serverMgr[type].linkedNum--; // rollback the reserved slot
        node->dying = true;
        bool destroyNow = (node->refs == 0);
        if (destroyNow) {
            // no monitor and no in-flight user: node is still the list head (mgr->lock is
            // held, no other publish can precede)
            g_serverMgr[type].commList = node->next;
        }
        UNLOCK_WARN_LOG(&g_serverMgr[type].stateLock);
        if (destroyNow) {
            ServerDestroyCommHandle(handle);
            XFREE(node);
        }
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }

    if ((g_serverMgr[type].linkType == SERVER_LONG_LINK) || (g_serverMgr[type].linkType == SERVER_LONG_LINK_STOP)) {
        ret = ServerReplyMsg(handle, SERVER_RESULT_SUCCESS, SERVER_REPLY_SUCCESS);
        if (ret != IDE_DAEMON_OK) {
            // the monitor thread owns the session node now: it marks the node dying and
            // rolls back the slot on exit, no extra rollback is needed here.
            (void)SessionMonitorRelease(&g_serverMgr[type]);
            UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
            SELF_LOG_ERROR("server process, send ack failed, ret: %d", ret);
            return LOG_FAILURE;
        }
    }
    g_serverMgr[type].processFlag = true;
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

STATIC int32_t ServerCheckCreateParam(ServerStart start, ServerStop stop, ServerAttr* attr)
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

int32_t ServerCreate(ComponentType type, ServerStart start, ServerStop stop, ServerAttr* attr)
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
    g_serverMgr[type].send = ServerSendMsg;
    g_serverMgr[type].recv = ServerRecvMsg;

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
    (void)AdxUnRegisterService(HDC_SERVICE_TYPE_IDE_FILE_TRANS, type);
}

int32_t ServerCreateEx(
    ComponentType type, ServerComponentInit init, ServerComponentProcess process, ServerComponentUnInit uninit)
{
    return AdxRegisterService(HDC_SERVICE_TYPE_IDE_FILE_TRANS, type, init, process, uninit);
}

int32_t ServerSyncFile(ServerHandle handle, const char* srcFileName, const char* dstFileName)
{
    ONE_ACT_ERR_LOG(handle == NULL, return LOG_FAILURE, "sync file check handle failed, handle is null");
    ServerCommNode* node = ServerAcquireCommNode(handle, true);
    ONE_ACT_ERR_LOG(node == NULL, return LOG_FAILURE, "sync file check handle failed, comm handle is invalid");
    AdxCommConHandle comm = node->comm;
    int32_t ret = SessionMonitorIsHandleValid(comm);
    if (ret != LOG_SUCCESS) {
        SELF_LOG_ERROR("sync file session invalid, skip send");
    } else {
        ret = AdxSendFileByHandle(comm, IDE_FILE_REPORT_REQ, srcFileName, dstFileName, SEND_FILE_TYPE_TMP_FILE);
    }
    ServerReleaseCommNode(handle, node);
    return ret;
}

int32_t ServerSendMsg(ServerHandle handle, const char* msg, uint32_t msgLen)
{
    ONE_ACT_ERR_LOG(handle == NULL, return LOG_FAILURE, "send message check handle failed, handle is null");
    ServerCommNode* node = ServerAcquireCommNode(handle, true);
    ONE_ACT_ERR_LOG(node == NULL, return LOG_FAILURE, "send message check handle failed, comm handle is invalid");
    int32_t ret = AdxSendMsg(node->comm, msg, msgLen);
    ServerReleaseCommNode(handle, node);
    return ret;
}

int32_t ServerRecvMsg(ServerHandle handle, char** msg, uint32_t* msgLen, uint32_t timeout)
{
    ONE_ACT_ERR_LOG(handle == NULL, return LOG_FAILURE, "receive message check handle failed, handle is null");
    ServerCommNode* node = ServerAcquireCommNode(handle, true);
    ONE_ACT_ERR_LOG(node == NULL, return LOG_FAILURE, "receive message check handle failed, comm handle is invalid");
    int32_t ret = AdxRecvMsg((AdxCommHandle)node->comm, msg, msgLen, timeout);
    ServerReleaseCommNode(handle, node);
    return ret;
}

int32_t ServersStart(void)
{
    ServerInitInfo serverInfo;
    serverInfo.serverType = HDC_SERVICE_TYPE_IDE_FILE_TRANS;
    serverInfo.mode = 0;
    serverInfo.deviceId = -1;
    return AdxServiceStartup(serverInfo);
}
