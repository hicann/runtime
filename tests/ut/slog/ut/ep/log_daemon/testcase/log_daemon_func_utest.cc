/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <functional>
#include <unistd.h>
#include "self_log_stub.h"
#include "log_drv.h"
#include "msn_config.h"
#include "config_common.h"
#include "log_cmd.h"
#include "msg_queue.h"
#include "log_daemon_stub.h"
#include "ascend_hal.h"
#include "ts_cmd.h"
#include "log_pm.h"
#include "log_pm_sig.h"
#include "log_config_api.h"
#include "cpu_detect_server.h"
#include "server_mgr.h"
#include "sys_monitor_frame.h"
#define RESULT_BUFFER_LEN 1024U

extern "C" {
extern int LogDaemonTest(int argc, char** argv);
}

class EP_LOG_DAEMON_FUNC_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(CpuDetectServerInit).stubs().will(returnValue(LOG_SUCCESS));
        MOCKER(CpuDetectServerExit).stubs().will(ignoreReturnValue());
        MOCKER(SysmonitorProcess).stubs().will(returnValue(LOG_SUCCESS));
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        ResetErrLog();
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test suite");
    }
};

typedef struct {
    int32_t argc;
    char** argv;
} Args;

static void* MainThreadFunc(void* arg)
{
    Args* in = (Args*)arg;
    LogDaemonTest(in->argc, in->argv);
    return NULL;
}

static pthread_t StartThread(Args* arg)
{
    pthread_t tid = 0;
    pthread_attr_t attr;
    (void)pthread_create(&tid, NULL, MainThreadFunc, (void*)arg);
    return tid;
}

#include "server_mgr.h"
#include "adx_component_api_c.h"

static int32_t TestServerStart(ServerHandle handle)
{
    EXPECT_EQ(0, ServerSyncFile(handle, "src", "dts"));
    EXPECT_EQ(0, ServerSendMsg(handle, "message", 6));
    char recvBuf[] = "receive";
    char* msg = recvBuf;
    uint32_t len = 7;
    EXPECT_EQ(0, ServerRecvMsg(handle, (char**)&msg, &len, 10000));
    return 0;
}

static void TestServerStop(void) {}

static int32_t TestFailServerStart(ServerHandle handle)
{
    EXPECT_EQ(-1, ServerSyncFile(nullptr, "src", "dts"));
    EXPECT_EQ(-1, ServerSendMsg(nullptr, "message", 6));
    char recvBuf[] = "receive";
    char* msg = recvBuf;
    uint32_t len = 7;
    EXPECT_EQ(-1, ServerRecvMsg(nullptr, (char**)&msg, &len, 10000));
    return -1;
}

static void TestFailServerStop(void) {}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainCreateThreadFailed)
{
    // 初始化
    ResetErrLog();
    MOCKER(LogPmStart).stubs().will(returnValue(0)); // appmon线程没有控制退出，暂时打桩处理
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogConfInit).stubs().will(returnValue(0));
    MOCKER(ToolSetThreadName).stubs().will(returnValue(-1));
    LogRecordSigNo(0);
    // 运行
    int argc = 2;
    char* argv[] = {"log-daemon", "-n", NULL};
    Args arg = {argc, argv};
    sleep(1);

    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    MOCKER(ToolCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));
    EXPECT_EQ(1, GetErrLogNum());
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);

    // 终止
    LogRecordSigNo(1);
    GlobalMockObject::verify();
}

static bool g_handleStatus = true;
static int32_t AdxGetAttrByCommHandleStub(AdxCommConHandle handle, int32_t attr, int32_t* value)
{
    if (!g_handleStatus) {
        g_handleStatus = true;
        return -1;
    }
    (void)handle;
    if (attr == 6) {        // HDC_SESSION_ATTR_STATUS
        *value = 1;         // connect
    } else if (attr == 2) { // HDC_SESSION_ATTR_RUN_ENV
        *value = 1;         // NON_DOCKER
    } else {
        *value = 0;
    }
    return 0;
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainInvalidHanlde)
{
    // 初始化
    ResetErrLog();
    MOCKER(LogPmStart).stubs().will(returnValue(0)); // appmon线程没有控制退出，暂时打桩处理
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogConfInit).stubs().will(returnValue(0));
    MOCKER(ToolSetThreadName).stubs().will(returnValue(-1));
    LogRecordSigNo(0);
    // 运行
    int argc = 2;
    char* argv[] = {"log-daemon", "-n", NULL};
    Args arg = {argc, argv};
    sleep(1);

    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(AdxGetAttrByCommHandleStub));
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0));
    g_handleStatus = false;
    EXPECT_EQ(0, GetErrLogNum());
    sleep(1);
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);

    // 终止
    LogRecordSigNo(1);
    GlobalMockObject::verify();
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMain)
{
    // 初始化
    ResetErrLog();
    MOCKER(LogPmStart).stubs().will(returnValue(0)); // appmon线程没有控制退出，暂时打桩处理
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(LogConfInit).stubs().will(returnValue(0));
    LogRecordSigNo(0);
    // 运行
    int argc = 2;
    char* argv[] = {"log-daemon", "-n", NULL};
    Args arg = {argc, argv};
    pthread_t tid = StartThread(&arg);
    sleep(1);

    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    MOCKER(ToolSetThreadName).stubs().will(returnValue(-1));
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0));

    sleep(1);
    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);

    EXPECT_EQ(0, GetErrLogNum());

    // 终止
    LogRecordSigNo(1);
    pthread_join(tid, NULL);
    GlobalMockObject::verify();
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainServerCreateFailed)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    EXPECT_EQ(-1, ServerCreate(ComponentType::NR_COMPONENTS, TestServerStart, TestServerStop, &attr));
    MOCKER(AdxRegisterService).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(-1, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));
    EXPECT_EQ(-1, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr)); // repeat

    sleep(1);
    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainServerMonitorAll)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 0;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0));

    sleep(1);
    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainServerMonitorInvalid)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    EXPECT_EQ(-1, ServerCreate(ComponentType::COMPONENT_GETD_FILE, NULL, TestServerStop, &attr));
    attr.num = 1000;
    EXPECT_EQ(-1, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));
    attr.num = 1;
    attr.linkType = 1000;
    EXPECT_EQ(-1, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));
    attr.linkType = 1;
    attr.runEnv = 10;
    EXPECT_EQ(-1, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainAdxGetAttrByCommHandleFaild)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = ENV_NON_DOCKER;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(AdxGetAttrByCommHandleStub)).then(returnValue(-1));
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

// 会话运行在容器内，ServerCheckContainer 必须拦截该请求。
// 该桩与 AdxGetAttrByCommHandleStub 解耦：后者依赖 g_handleStatus 这个由其它用例改写的
// 全局开关，容器用例不能建立在其它用例的执行顺序上
static int32_t AdxGetAttrByCommHandleContainerStub(AdxCommConHandle handle, int32_t attr, int32_t* value)
{
    (void)handle;
    (void)attr;
    *value = RUN_ENV_PHYSICAL_CONTAINER;
    return 0;
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainInvalidRunEnv)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = ENV_NON_DOCKER;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    MOCKER(AdxGetAttrByCommHandle).stubs().will(invoke(AdxGetAttrByCommHandleContainerStub));
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    // 拦截分支尚未接管句柄，必须返回失败：框架侧 AdxServerManager::RunProcessTask 才会
    // Close 并释放本次请求的 CommHandle 与 hdc session。若返回成功，框架会认为组件已持有
    // 句柄而跳过释放，导致泄漏
    EXPECT_EQ(LOG_FAILURE, ServerProcess(&handle, nullptr, 0));
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].handle);
    EXPECT_EQ(0U, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].linkedNum);
    EXPECT_EQ(false, g_serverMgr[ComponentType::COMPONENT_GETD_FILE].monitorRunFlag);

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainServerProcessFailed)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    MOCKER(ToolJoinTask).stubs().will(returnValue(0));
    MOCKER(pthread_create).stubs().will(returnValue(0));
    EXPECT_EQ(0, ServerMgrInit());
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.timeout = 0;
    handle.client = nullptr;
    handle.comp = NR_COMPONENTS;
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));
    handle.comp = COMPONENT_LOG_BACKHAUL;
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));
    handle.comp = COMPONENT_GETD_FILE;
    MOCKER(AdxSendMsg).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));
    MOCKER(AdxRecvMsg).stubs().will(returnValue(0));
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0));
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));

    sleep(1);
    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));
}

static int32_t TestServerStartException(ServerHandle handle)
{
    EXPECT_EQ(-1, ServerSyncFile(handle, "src", "dts"));
    EXPECT_EQ(-1, ServerSendMsg(handle, "message", 6));
    char msg[] = "receive";
    uint32_t len = 7;
    EXPECT_EQ(-1, ServerRecvMsg(handle, (char**)&msg, &len, 10000));
    return 0;
}

static void TestServerStopException(void)
{
    g_serverMgr[COMPONENT_GETD_FILE].monitorRunFlag = false;
    g_serverMgr[COMPONENT_GETD_FILE].linkedNum = 0;
    g_serverMgr[COMPONENT_GETD_FILE].processFlag = true;
    g_serverMgr[COMPONENT_GETD_FILE].linkType = SERVER_LONG_LINK_STOP;
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainServerStop)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.timeout = 0;
    handle.client = nullptr;
    handle.comp = COMPONENT_GETD_FILE;
    MOCKER(AdxRecvMsg).stubs().will(returnValue(0));
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0));

    sleep(1);
    TestServerStopException();
    TestServerStartException((ServerHandle)&g_serverMgr[COMPONENT_GETD_FILE]);
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainServerRegisterInvalidFunc)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestFailServerStart, TestFailServerStop, &attr));

    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(-1, ServerProcess(&handle, nullptr, 0));

    sleep(1);
    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, ServerWaitStop)
{
    struct ServerMgr handle = {0};
    handle.processFlag = true;
    EXPECT_EQ(LOG_FAILURE, ServerWaitStop(&handle));
    handle.processFlag = false;
    EXPECT_EQ(LOG_SUCCESS, ServerWaitStop(&handle));
}

// ---------------------------------------------------------------------------
// CommHandle 所有权回归用例
// 框架侧 AdxServerManager::RunProcessTask 约定：Process 回调返回失败时，由框架 Close
// 并释放本次请求的 CommHandle；返回成功且为持久组件时，句柄所有权交给组件。
// 因此 ServerProcess 的失败分支既不能释放句柄，也不能把句柄留在 g_serverMgr 中，
// 更必须在返回前停止并等待 session monitor 线程退出，否则框架释放句柄后 monitor
// 线程仍会解引用它，缺陷态下两者还会各释放一次，构成 double free。
// ---------------------------------------------------------------------------

static int32_t g_destroyHandleNum = 0;

// 带超时的条件轮询：替代固定 sleep，CI 高负载下线程调度延迟超过 1 秒也不会 flaky
static bool WaitForCond(const std::function<bool()>& cond, uint32_t timeoutMs)
{
    for (uint32_t waited = 0; waited < timeoutMs; waited += 10) {
        if (cond()) {
            return true;
        }
        usleep(10 * 1000); // 10ms
    }
    return cond();
}

// 参数类型必须与 AdxDestroyCommHandle(AdxCommHandle) 完全一致（AdxCommHandle 即 CommHandle*）：
// mockcpp 的 invoke 匹配按函数指针类型做类型检查，写成 AdxCommConHandle 会匹配失败并抛异常，
// 而监控线程内的异常会卡在展开器上不放锁，最终与主线程互等死锁
static void AdxDestroyCommHandleCountStub(AdxCommHandle handle)
{
    (void)handle;
    g_destroyHandleNum++;
}

// 选择性 join 桩：仅对预置的旧 tid 返回假 join 结果（记录调用），
// 其余真实 tid 透传 pthread_join，保证用例收尾时能真正等线程退出
static ToolThread g_joinStubOldTid = 0;
static ToolThread g_joinStubJoinedTid = 0;

static int32_t ToolJoinTaskSelectiveStub(const ToolThread* tid)
{
    if (*tid == g_joinStubOldTid) {
        g_joinStubJoinedTid = *tid;
        return 0;
    }
    return pthread_join(*tid, NULL);
}

// 接管注入桩：join 调用时同步模拟"新请求在锁外 join 期间接管节点"，
// 注入动作等价于新请求在 ServerHandbackHandle 释放锁后写入自己的 handle
static CommHandle* g_takeOverHandle = nullptr;

static int32_t ToolJoinTaskTakeOverStub(const ToolThread* tid)
{
    (void)tid;
    g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].handle = g_takeOverHandle;
    return 0;
}

static int32_t TestServerStartFail(ServerHandle handle)
{
    (void)handle;
    return LOG_FAILURE;
}

static int32_t TestServerStartOk(ServerHandle handle)
{
    (void)handle;
    return LOG_SUCCESS;
}

static CommHandle MakeTestHandle(ComponentType comp)
{
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = comp;
    handle.timeout = 0;
    handle.client = nullptr;
    return handle;
}

// ack/start 失败路径的锁外 join 期间，新请求并发接管节点并写入自己的 handle：
// ServerHandbackHandle 重新加锁后必须只在节点仍指向本轮句柄时才置 NULL，
// 无条件清空会把新请求的句柄抹掉（缺陷态：新句柄丢失、泄漏且新监控线程读到 NULL 提前退出）
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, ServerHandbackKeepsTakenOverHandle)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_CPU_DETECT, TestServerStartFail, TestServerStop, &attr));

    MOCKER(ToolSleep).stubs().will(returnValue(0));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));
    CommHandle handle = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);

    // 模拟时序：本轮请求进入 ServerHandbackHandle 释放锁之后、join 返回之前，
    // 新请求已接管节点并写入新句柄（ServerStopMonitor 在桩内不真正阻塞，
    // 接管动作由桩在 join 调用时同步注入，等价于 join 期间发生）
    static CommHandle takenOver;
    takenOver = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    g_takeOverHandle = &takenOver;
    MOCKER(ToolJoinTask).stubs().will(invoke(ToolJoinTaskTakeOverStub));

    EXPECT_EQ(LOG_FAILURE, ServerProcess(&handle, nullptr, 0));

    // 本轮句柄未留存；新请求的句柄未被误清（缺陷态为 NULL）
    EXPECT_EQ(&takenOver, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].handle);
    EXPECT_EQ(0, g_destroyHandleNum);

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_CPU_DETECT);
}

// start 失败：句柄交还框架，组件侧与监控线程都不得释放
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, ServerProcessStartFailedHandbackHandle)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_CPU_DETECT, TestServerStartFail, TestServerStop, &attr));

    MOCKER(ToolSleep).stubs().will(returnValue(0));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));
    CommHandle handle = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    EXPECT_EQ(LOG_FAILURE, ServerProcess(&handle, nullptr, 0));

    // 框架侧是本次请求句柄的唯一 owner，组件侧一次都不能释放（缺陷态：监控线程释放一次）
    EXPECT_EQ(0, g_destroyHandleNum);
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].handle);
    // 本次请求尚未执行 linkedNum++，监控线程无条件自减会让计数下溢成 UINT32_MAX
    EXPECT_EQ(0U, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].linkedNum);
    EXPECT_EQ((ToolThread)0, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorTid);
    EXPECT_EQ(false, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorRunFlag);
    EXPECT_EQ(false, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].processFlag);

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_CPU_DETECT);
}

// ack 发送失败：监控线程已在本次请求内启动，交还句柄前必须先让它退出
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, ServerProcessAckFailedHandbackHandle)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_CPU_DETECT, TestServerStartOk, TestServerStop, &attr));

    MOCKER(ToolSleep).stubs().will(returnValue(0));
    MOCKER(AdxSendMsg).stubs().will(returnValue(-1));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));
    CommHandle handle = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    EXPECT_EQ(LOG_FAILURE, ServerProcess(&handle, nullptr, 0));

    EXPECT_EQ(0, g_destroyHandleNum);
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].handle);
    EXPECT_EQ(0U, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].linkedNum);
    EXPECT_EQ((ToolThread)0, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorTid);
    EXPECT_EQ(false, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorRunFlag);

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_CPU_DETECT);
}

// start 成功且监控线程仍存活：句柄所有权移交监控线程，断链时由它释放
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, ServerProcessHandOverHandleToMonitor)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK_STOP; // 短连接：start 成功即通知监控线程收尾
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_CPU_DETECT, TestServerStartOk, TestServerStop, &attr));

    // AdxGetAttrByCommHandle 打桩返回会话失效：监控线程跳过轮询直接进入收尾，
    // 避免跨线程高频调用 mock 桩（mockcpp 非线程安全）
    MOCKER(AdxGetAttrByCommHandle).stubs().will(returnValue(-1));
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));
    CommHandle handle = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    EXPECT_EQ(LOG_SUCCESS, ServerProcess(&handle, nullptr, 0));

    // start 成功时监控线程仍在运行（SessionMonitorRelease 之前），所有权移交成立
    // 所有权已移交给监控线程（该标志在 start 成功后置位，后续由监控线程消费）
    EXPECT_EQ(true, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].handleOwned);

    // 监控线程收尾后由它释放句柄并回收计数（轮询替代固定 sleep，避免 CI 高负载 flaky）
    EXPECT_TRUE(WaitForCond([]() { return g_destroyHandleNum == 1; }, 2000));
    EXPECT_EQ(nullptr, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].handle);
    EXPECT_EQ(0U, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].linkedNum);

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_CPU_DETECT);
}

// 所有权未移交（start 未成功保留句柄）时，监控线程不得销毁句柄
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, SessionMonitorKeepHandleWhenNotOwned)
{
    MOCKER(ToolSetThreadName).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));

    struct ServerMgr mgr = {0};
    mgr.comp = ComponentType::COMPONENT_CPU_DETECT;
    mgr.stop = TestServerStop;
    mgr.monitorRunFlag = false; // 跳过轮询，直接走收尾
    mgr.linkedNum = 1U;
    mgr.handleOwned = false;
    // 句柄上的 comp 与节点 comp 故意不同：监控线程必须使用节点上的 comp 取线程名，
    // 不能跨线程解引用 mgr->handle
    CommHandle handle = MakeTestHandle(ComponentType::COMPONENT_GETD_FILE);
    mgr.handle = &handle;
    SessionMonitorCtx ctx = {&mgr, mgr.generation, false};

    EXPECT_EQ(nullptr, SessionMonitorProcess(&ctx));
    EXPECT_EQ(0, g_destroyHandleNum);
    EXPECT_EQ(&handle, mgr.handle); // 所有权未移交，监控线程不得销毁或置空句柄
    EXPECT_EQ(0U, mgr.linkedNum);   // linkedNum 已为 1，自减后为 0
}

// 所有权已移交时，监控线程负责销毁句柄
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, SessionMonitorDestroyHandleWhenOwned)
{
    MOCKER(ToolSetThreadName).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));

    struct ServerMgr mgr = {0};
    mgr.comp = ComponentType::COMPONENT_CPU_DETECT;
    mgr.stop = TestServerStop;
    mgr.monitorRunFlag = false;
    mgr.linkedNum = 1U;
    mgr.handleOwned = true;
    CommHandle handle = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    mgr.handle = &handle;
    SessionMonitorCtx ctx = {&mgr, mgr.generation, false};

    EXPECT_EQ(nullptr, SessionMonitorProcess(&ctx));
    EXPECT_EQ(1, g_destroyHandleNum);
    EXPECT_EQ(nullptr, mgr.handle);
    EXPECT_EQ(0U, mgr.linkedNum);
}

// 句柄已交还框架并置空、监控线程尚未退出时，监控线程需容忍空句柄且不释放
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, SessionMonitorTolerateHandedBackHandle)
{
    MOCKER(ToolSetThreadName).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));

    struct ServerMgr mgr = {0};
    mgr.comp = ComponentType::COMPONENT_CPU_DETECT;
    mgr.stop = TestServerStop;
    mgr.monitorRunFlag = true;
    mgr.linkedNum = 1U;
    mgr.handle = nullptr;
    SessionMonitorCtx ctx = {&mgr, mgr.generation, false};

    EXPECT_EQ(nullptr, SessionMonitorProcess(&ctx));
    EXPECT_EQ(0, g_destroyHandleNum);
    EXPECT_EQ(nullptr, mgr.handle);
    EXPECT_EQ(0U, mgr.linkedNum);
    EXPECT_EQ(false, mgr.monitorRunFlag);
}

// 旧监控线程不得触碰新请求的节点状态：创建后节点被新请求接管（generation 递增）、
// 写入新句柄并置 handleOwned=true，旧线程收尾时按自己的旧代际识别已非 owner，
// 不销毁新句柄、不递减新请求的计数（缺陷态：新句柄被误销毁 + 计数被破坏）
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, SessionMonitorSkipsTakenOverNode)
{
    MOCKER(ToolSetThreadName).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));

    // 节点：旧线程创建时 generation 为 1，随后新请求接管递增到 2 并写入自己的状态
    struct ServerMgr mgr = {0};
    mgr.comp = ComponentType::COMPONENT_CPU_DETECT;
    mgr.stop = TestServerStop;
    mgr.monitorRunFlag = false;
    mgr.generation = 2U;                       // 新请求已接管
    mgr.linkedNum = 1U;                        // 新请求的计数
    mgr.handleOwned = true;                    // 新请求 start 成功，所有权归新请求
    CommHandle newHandle = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    mgr.handle = &newHandle;                   // 新请求的句柄
    SessionMonitorCtx ctx = {&mgr, 1U, false}; // 旧线程捕获的是接管前的代际

    EXPECT_EQ(nullptr, SessionMonitorProcess(&ctx));
    // 旧线程不是 owner：不销毁新句柄、不清空节点、不动新请求的计数
    EXPECT_EQ(0, g_destroyHandleNum);
    EXPECT_EQ(&newHandle, mgr.handle);
    EXPECT_EQ(1U, mgr.linkedNum);
}

// 监控线程退出不得自清 monitorTid：三个回收点（stale join / ServerHandbackHandle /
// ServerRelease）都以 monitorTid != 0 为 join 前提，自清后 joinable 线程再无人回收，
// 每次断链泄漏一个 128KB 线程栈（缺陷态为该字段被清 0）
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, SessionMonitorKeepsTidAfterExit)
{
    MOCKER(ToolSetThreadName).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolSleep).stubs().will(returnValue(0));

    struct ServerMgr mgr = {0};
    mgr.comp = ComponentType::COMPONENT_CPU_DETECT;
    mgr.stop = TestServerStop;
    mgr.monitorRunFlag = false;          // 跳过轮询，直接走收尾
    mgr.linkedNum = 0U;
    mgr.monitorTid = (ToolThread)0x1234; // 假定为本线程的 tid
    SessionMonitorCtx ctx = {&mgr, mgr.generation, false};

    EXPECT_EQ(nullptr, SessionMonitorProcess(&ctx));
    // 线程退出路径保留 monitorTid：joinable 线程的回收权留给回收方
    EXPECT_EQ((ToolThread)0x1234, mgr.monitorTid);
    EXPECT_EQ(nullptr, mgr.handle);
}

// 真实线程自然退出后的重连回收路径：先让监控线程自然退出（monitorTid 保留），
// 再发起 ServerProcess，断言旧线程被 ServerStopMonitor 真正 join（不泄漏、不二次 join）
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, ServerProcessJoinsExitedMonitor)
{
    ServerAttr attr = {0};
    attr.num = 1;
    attr.linkType = SERVER_LONG_LINK;
    attr.runEnv = ENV_ALL;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_CPU_DETECT, TestServerStartOk, TestServerStop, &attr));

    // AdxGetAttrByCommHandle 打桩返回会话失效：监控线程创建后即退出，
    // 模拟长连接断链场景，也避免跨线程高频调用 mock 桩
    MOCKER(AdxGetAttrByCommHandle).stubs().will(returnValue(-1));
    MOCKER(ToolSleep).stubs().will(returnValue(0));
    // 第一步：正常处理一次请求，创建真实监控线程
    CommHandle handle1 = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    EXPECT_EQ(LOG_SUCCESS, ServerProcess(&handle1, nullptr, 0));
    EXPECT_NE((ToolThread)0, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorTid);

    // 等监控线程真正退出（monitorTid 保留非 0，由回收方 join）
    g_destroyHandleNum = 0;
    MOCKER(AdxDestroyCommHandle).stubs().will(invoke(AdxDestroyCommHandleCountStub));
    EXPECT_TRUE(WaitForCond([]() { return g_destroyHandleNum == 1; }, 2000)); // start 成功，所有权已移交

    // 第二步：重连。ServerProcess 必须对已退出的旧线程执行真实 join（回收线程栈），
    // 再创建新监控线程；join 计数桩仅在旧 tid 上生效，新 tid 透传真实 pthread_join
    g_joinStubOldTid = g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorTid;
    g_joinStubJoinedTid = 0;
    MOCKER(ToolJoinTask).stubs().will(invoke(ToolJoinTaskSelectiveStub));
    ToolThread oldTid = g_joinStubOldTid;
    CommHandle handle2 = MakeTestHandle(ComponentType::COMPONENT_CPU_DETECT);
    EXPECT_EQ(LOG_SUCCESS, ServerProcess(&handle2, nullptr, 0));

    // 旧线程被 join 回收（不泄漏），新监控线程接管
    EXPECT_EQ(oldTid, g_joinStubJoinedTid);
    EXPECT_NE(oldTid, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorTid);
    EXPECT_NE((ToolThread)0, g_serverMgr[ComponentType::COMPONENT_CPU_DETECT].monitorTid);

    // 收尾：新监控线程也已退出（AdxGetAttr 桩返回失效），等它释放句柄后释放节点
    EXPECT_TRUE(WaitForCond([]() { return g_destroyHandleNum == 2; }, 2000));
    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_CPU_DETECT);
}
