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

// 监控线程的私有上下文：捕获创建时的请求代际与句柄快照。
// 收尾时仅当节点代际未变（未被新请求接管）才处理节点级状态；
// 句柄用捕获值而非 mgr->handle，避免节点被接管后读到新请求的句柄误销毁。
// UT 构建下该类型经 server_mgr.h 导出（用例直接构造后调线程体），此处不再重复定义
#if !(defined _LOG_UT_ || defined __IDE_UT)
typedef struct {
    ServerHandle mgr;
    uint32_t generation; // 创建本线程时的请求代际
    bool onHeap;         // true: 由 SessionMonitorCreate malloc，线程体内负责 free
} SessionMonitorCtx;
#endif

STATIC void* SessionMonitorProcess(void* arg)
{
    SessionMonitorCtx* ctx = (SessionMonitorCtx*)arg;
    ServerHandle mgr = ctx->mgr;
    // 捕获创建时的代际：收尾时与节点当前代际比对，确认自己是否仍是 owner
    uint32_t myGeneration = ctx->generation;
    // 上下文仅用于启动传参，取完即释放；UT 以栈上 ctx 直接调线程体时不释放
    if (ctx->onHeap) {
        free(ctx);
    }
    char threadName[SESSION_THREAD_NAME_LEN] = {0};
    // 线程名取自节点自身的组件类型：失败路径会先把 mgr->handle 交还框架，监控线程跨线程
    // 解引用 mgr->handle->comp 存在空指针与 use-after-free 风险
    int32_t ret = sprintf_s(threadName, SESSION_THREAD_NAME_LEN, "SessionMonitor%d", (int32_t)mgr->comp);
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
    // 旧 monitor 的收尾只处理自己代际内的节点状态：锁外 join/长轮询期间新请求可能已接管
    // 节点并写入新句柄与新计数，此时销毁句柄会误杀新会话、递减计数会破坏新请求的并发计数
    if (mgr->generation == myGeneration) {
        // 仅当代际一致且句柄所有权已移交组件（start 成功）时才由本线程销毁。
        // 其余情况句柄归框架侧（RunProcessTask 在 Process 返回失败时释放），销毁会 double free
        if ((mgr->handleOwned) && (mgr->handle != NULL)) {
            ServerDestroyCommHandle(mgr->handle);
            mgr->handle = NULL;
        }
        // ack 发送失败时本次请求尚未执行 linkedNum++，此处需防止无符号下溢
        if (mgr->linkedNum > 0U) {
            mgr->linkedNum--;
        } else {
            // 常规路径的普通信息，不打告警通道
            SELF_LOG_INFO("session monitor, linked num is already zero, type: %d", (int32_t)mgr->comp);
        }
    }
    UNLOCK_WARN_LOG(&mgr->lock);
    ret = ServerWaitStop(mgr);
    NO_ACT_WARN_LOG(ret != LOG_SUCCESS, "start process exit exception");

    // monitorTid 不做自清：三个回收点（ServerProcess 的 stale join / ServerHandbackHandle /
    // ServerRelease）都以 monitorTid != 0 为 join 前提，线程自清后 joinable 线程再无人回收，
    // 每次断链泄漏一个 128KB 栈。被新线程接管的场景由回收方在锁内先摘除置 0 保证，
    // 新 tid 由 SessionMonitorCreate 在旧线程 join 完成后才写入，不存在并发覆盖
    SELF_LOG_INFO("session monitor exit, flag: %d", (int32_t)(mgr->monitorRunFlag));
    return NULL;
}

static int32_t SessionMonitorCreate(ServerHandle handle)
{
    int32_t ret = LOG_SUCCESS;
    // start process
    handle->monitorRunFlag = true;
    // 私有上下文捕获当前请求代际：收尾时与节点代际比对判断自己是否仍是 owner
    SessionMonitorCtx* ctx = (SessionMonitorCtx*)malloc(sizeof(SessionMonitorCtx));
    ONE_ACT_ERR_LOG(ctx == NULL, return LOG_FAILURE, "malloc for session monitor ctx failed");
    ctx->mgr = handle;
    ctx->generation = handle->generation;
    ctx->onHeap = true;
    ToolThread tid = 0;
    ToolUserBlock funcBlock;
    funcBlock.procFunc = SessionMonitorProcess;
    funcBlock.pulArg = (void*)(ctx);
    ToolThreadAttr threadAttr = SESSION_MONITOR_THREAD_ATTR;
    ret = ToolCreateTaskWithThreadAttr(&tid, &funcBlock, &threadAttr);
    if (ret != LOG_SUCCESS) {
        handle->monitorRunFlag = false;
        SELF_LOG_ERROR("create thread failed, result=%d.", ret);
        free(ctx);
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

// 通知监控线程收尾并等待其退出，用于所有需要让监控线程停止访问句柄的路径：
// ServerProcess 失败返回前（句柄交还框架），以及回收上一请求遗留的监控线程。
// 持锁完成"判空+摘除"再锁外 join（监控线程退出路径需要同一把锁，锁内 join 会互等死锁），
// 避免与其他回收点对同一 pthread_t 二次 join（未定义行为）
STATIC void ServerStopMonitor(ServerHandle mgr)
{
    LOCK_WARN_LOG(&mgr->lock);
    mgr->monitorRunFlag = false;
    ToolThread monitorTid = mgr->monitorTid;
    mgr->monitorTid = 0;
    UNLOCK_WARN_LOG(&mgr->lock);
    if (monitorTid == 0) {
        return;
    }
    // 打印 ToolJoinTask 返回值而非 errno：pthread_join 通过返回值报错且不设置 errno
    int32_t ret = ToolJoinTask(&monitorTid);
    NO_ACT_ERR_LOG(ret != 0, "pthread(sessionMonitor) join failed, ret: %d.", ret);
}

static void ServerMgrNodeReset(ComponentType type)
{
    g_serverMgr[type].init = false;
    g_serverMgr[type].monitorRunFlag = false;
    g_serverMgr[type].processFlag = false;
    g_serverMgr[type].handleOwned = false;
    g_serverMgr[type].monitorTid = 0;
    g_serverMgr[type].comp = type;
    g_serverMgr[type].handle = NULL;
    g_serverMgr[type].maxNum = 0;
    g_serverMgr[type].linkedNum = 0;
    g_serverMgr[type].linkType = 0;
    g_serverMgr[type].start = NULL;
    g_serverMgr[type].stop = NULL;
    g_serverMgr[type].send = ServerSendMsg;
    g_serverMgr[type].recv = ServerRecvMsg;
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

STATIC ComponentType ServerGetComponentType(AdxCommConHandle handle) { return handle->comp; };

// 组件注册状态校验：非法 type / 未注册分支不带锁直接失败
STATIC int32_t ServerCheckEntry(const CommHandle* handle, ComponentType type)
{
    if (type >= NR_COMPONENTS) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        SELF_LOG_ERROR("server process, invalid type: %d", (int32_t)type);
        return LOG_FAILURE;
    }
    if (!g_serverMgr[type].init) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_UNREGISTERED, SERVER_REPLY_UNREGISTERED);
        SELF_LOG_ERROR("server process, type %d is not init", (int32_t)type);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

// 失败路径统一收口：把 CommHandle 的所有权交还框架侧。
// 框架侧 AdxServerManager::RunProcessTask 在 Process 回调返回失败时会 Close 并释放本次请求的
// CommHandle，因此组件侧既不能释放它，也不能把它留在 g_serverMgr 中；并且必须等监控线程彻底退出
// 后再返回，否则监控线程会访问框架即将释放的句柄。
// 前置条件：持有 g_serverMgr[type].lock；返回时锁已释放
STATIC void ServerHandbackHandle(ComponentType type, const CommHandle* handle)
{
    // 必须先清零 processFlag，监控线程退出时会等待该标志，否则 join 期间互相等待
    g_serverMgr[type].processFlag = false;
    UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
    ServerStopMonitor(&g_serverMgr[type]);
    LOCK_WARN_LOG(&g_serverMgr[type].lock);
    // 锁外 join 期间新请求可能已接管节点并写入自己的 handle，仅当节点仍指向本轮句柄时
    // 才置 NULL；无条件清空会把新请求的句柄抹掉，导致其监控线程提前退出、句柄泄漏
    if (g_serverMgr[type].handle == handle) {
        g_serverMgr[type].handle = NULL;
    }
    UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
}

// 持锁状态下的并发与运行环境校验：过载 / 已有进程在跑 / 容器拦截。
// 返回失败时锁已释放，且拦截分支必须让框架 Close 本次请求的句柄
STATIC int32_t ServerCheckLinkState(const CommHandle* handle, ComponentType type)
{
    uint32_t num = g_serverMgr[type].linkedNum;
    if (num >= g_serverMgr[type].maxNum) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_OVERLOAD, SERVER_REPLY_OVERLOAD);
        SELF_LOG_ERROR("server process, overload, current num: %u, max num: %u", num, g_serverMgr[type].maxNum);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }

    if (g_serverMgr[type].processFlag) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        SELF_LOG_ERROR("server process, type %d process is running", (int32_t)type);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }

    int32_t ret = ServerCheckContainer(handle, type);
    if (ret != LOG_SUCCESS) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_CONTAINER, SERVER_REPLY_CONTAINER);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        // 拦截分支尚未接管句柄，必须返回失败让框架侧释放本次请求的 CommHandle 与 hdc session；
        // 若返回成功，框架会认为组件已持有句柄而跳过释放，导致泄漏
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

// 上一请求的监控线程可能尚未退出（会话断开后仍在收尾），必须先回收再创建新线程。
// 调用前持有 g_serverMgr[type].lock；锁内 join 会与旧线程收尾路径互等死锁，
// 因此锁外 join 后需重新确认本轮请求仍持有处理权。返回失败时锁已释放
STATIC int32_t ServerRecycleStaleMonitor(const CommHandle* handle, ComponentType type)
{
    if (g_serverMgr[type].monitorTid == 0) {
        return LOG_SUCCESS;
    }
    UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
    ServerStopMonitor(&g_serverMgr[type]);
    LOCK_WARN_LOG(&g_serverMgr[type].lock);
    if ((!g_serverMgr[type].init) || (g_serverMgr[type].handle != handle)) {
        // 补发响应：其余失败分支均有应答，该竞态分支也回执，客户端不必依赖连接关闭感知失败
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        SELF_LOG_ERROR("server process, state changed during join, type: %d", (int32_t)type);
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

// start 成功后的句柄去向：监控线程仍存活时移交所有权，已提前退出（start 期间断链）
// 则兜底销毁防泄漏——框架对成功 + 持久组件会跳过释放。调用前持有锁，返回时锁已释放
STATIC void ServerFinishStart(ComponentType type, int32_t startRet, const CommHandle* handle)
{
    if (startRet != LOG_SUCCESS) {
        // start 失败：句柄交还框架，监控线程退出后由框架侧释放（ServerHandbackHandle 已解锁）
        ServerHandbackHandle(type, handle);
        return;
    }
    if (g_serverMgr[type].monitorRunFlag) {
        // start 成功且监控线程仍在运行：句柄所有权移交给它，会话断开时由它释放
        g_serverMgr[type].handleOwned = true;
    } else if (g_serverMgr[type].handle != NULL) {
        // 监控线程在 start 执行期间已因断链退出：框架侧对成功请求不再释放，此处兜底防泄漏
        ServerDestroyCommHandle(g_serverMgr[type].handle);
        g_serverMgr[type].handle = NULL;
    }
    if (g_serverMgr[type].linkType == SERVER_LONG_LINK_STOP) {
        // 短生命周期组件（如 cpu_detect）：start 成功即完成一次交互，通知监控线程收尾
        (void)SessionMonitorRelease(&g_serverMgr[type]);
    }
    // 尾部清零前校验本轮仍持有节点：ServerHandbackHandle 的失败路径在锁外 join 期间，
    // 新请求可能已接管并把 processFlag 重新置 true，无条件清零会误伤新请求，
    // 让第三个请求绕过"process is running"检查并发执行 start
    if (g_serverMgr[type].handle == handle) {
        g_serverMgr[type].processFlag = false;
    }
    UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
}

STATIC int32_t ServerProcess(const CommHandle* handle, const void* msg, uint32_t len)
{
    (void)msg;
    (void)len;
    ComponentType type = ServerGetComponentType(handle);
    if (ServerCheckEntry(handle, type) != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    LOCK_WARN_LOG(&g_serverMgr[type].lock);
    if (ServerCheckLinkState(handle, type) != LOG_SUCCESS) {
        return LOG_FAILURE;
    }
    g_serverMgr[type].handle = handle;
    // 新请求接管节点：递增请求代际，旧监控线程收尾时据此识别自己已被替代，
    // 只做自身退出、不触碰本请求的句柄与计数；同时复位所有权标志，
    // 上一请求残留的 true 会让本轮监控线程销毁本应交还框架的句柄，double free 复活
    g_serverMgr[type].generation++;
    g_serverMgr[type].handleOwned = false;
    // 锁外回收上一请求遗留的监控线程后，本轮请求再创建新线程接管
    if (ServerRecycleStaleMonitor(handle, type) != LOG_SUCCESS) {
        return LOG_FAILURE;
    }

    int32_t ret = SessionMonitorCreate(&g_serverMgr[type]);
    if (ret != LOG_SUCCESS) {
        (void)ServerReplyMsg(handle, SERVER_RESULT_EXECUTION_ERROR, SERVER_REPLY_EXECUTION_ERROR);
        g_serverMgr[type].handle = NULL;
        UNLOCK_WARN_LOG(&g_serverMgr[type].lock);
        return LOG_FAILURE;
    }

    if ((g_serverMgr[type].linkType == SERVER_LONG_LINK) || (g_serverMgr[type].linkType == SERVER_LONG_LINK_STOP)) {
        ret = ServerReplyMsg(handle, SERVER_RESULT_SUCCESS, SERVER_REPLY_SUCCESS);
        if (ret != IDE_DAEMON_OK) {
            // 监控线程已在本次请求内启动，交还句柄前必须先让它退出
            ServerHandbackHandle(type, handle);
            SELF_LOG_ERROR("server process, send ack failed, ret: %d", ret);
            return LOG_FAILURE;
        }
    }
    g_serverMgr[type].processFlag = true;
    g_serverMgr[type].linkedNum++;
    UNLOCK_WARN_LOG(&g_serverMgr[type].lock);

    ret = g_serverMgr[type].start(&g_serverMgr[type]);
    LOCK_WARN_LOG(&g_serverMgr[type].lock);
    ServerFinishStart(type, ret, handle);
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
        // 通知并等待监控线程退出，避免其退出后访问已重置的节点
        ServerStopMonitor(&g_serverMgr[type]);
        int32_t ret = ServerWaitStop(&g_serverMgr[type]);
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

static int32_t ServerCheckHandle(ServerHandle handle)
{
    ONE_ACT_ERR_LOG(handle == NULL, return LOG_FAILURE, "check handle failed, handle is null");
    ONE_ACT_ERR_LOG(handle->handle == NULL, return LOG_FAILURE, "check handle failed, comm handle is null");
    ComponentType type = ServerGetComponentType(handle->handle);
    ONE_ACT_ERR_LOG(type >= NR_COMPONENTS, return LOG_FAILURE, "check handle failed, invalid type %d", (int32_t)type);
    if (!g_serverMgr[type].monitorRunFlag) {
        SELF_LOG_ERROR("check handle failed, process is stopped");
        return LOG_FAILURE;
    }
    return LOG_SUCCESS;
}

int32_t ServerSyncFile(ServerHandle handle, const char* srcFileName, const char* dstFileName)
{
    ONE_ACT_ERR_LOG(ServerCheckHandle(handle) != LOG_SUCCESS, return LOG_FAILURE, "sync file check handle failed");
    ONE_ACT_ERR_LOG(
        SessionMonitorIsHandleValid(handle->handle) != LOG_SUCCESS, return LOG_FAILURE,
        "sync file session invalid, skip send");
    return AdxSendFileByHandle(handle->handle, IDE_FILE_REPORT_REQ, srcFileName, dstFileName, SEND_FILE_TYPE_TMP_FILE);
}

int32_t ServerSendMsg(ServerHandle handle, const char* msg, uint32_t msgLen)
{
    ONE_ACT_ERR_LOG(ServerCheckHandle(handle) != LOG_SUCCESS, return LOG_FAILURE, "send message check handle failed");
    return AdxSendMsg(handle->handle, msg, msgLen);
}

int32_t ServerRecvMsg(ServerHandle handle, char** msg, uint32_t* msgLen, uint32_t timeout)
{
    ONE_ACT_ERR_LOG(
        ServerCheckHandle(handle) != LOG_SUCCESS, return LOG_FAILURE, "receive message check handle failed");
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
