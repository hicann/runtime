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
#include "cpu_detect.h"
#include "server_mgr.h"
#include "sys_monitor_frame.h"
#define RESULT_BUFFER_LEN   1024U

extern "C" {
extern int LogDaemonTest(int argc, char **argv);
extern int32_t ServerProcess(const CommHandle* handle, const void* msg, uint32_t len);
extern int32_t ServerWaitStop(ServerHandle handle);
extern ServerMgr g_serverMgr[NR_COMPONENTS];
}

class EP_LOG_DAEMON_FUNC_UTEST : public testing::Test
{
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
    char **argv;
} Args;

static void *MainThreadFunc(void *arg)
{
    Args *in = (Args *)arg;
    LogDaemonTest(in->argc, in->argv);
    return NULL;
}

static pthread_t StartThread(Args *arg)
{
    pthread_t tid = 0;
    pthread_attr_t attr;
    (void)pthread_create(&tid, NULL, MainThreadFunc, (void *)arg);
    return tid;
}

#include "server_mgr.h"
#include "adx_component_api_c.h"

static int32_t TestServerStart(ServerHandle handle)
{
    EXPECT_EQ(0, ServerSyncFile(handle, "src", "dts"));
    EXPECT_EQ(0, ServerSendMsg(handle, "message", 6));
    char msg[] = "receive";
    uint32_t len = 7;
    EXPECT_EQ(0, ServerRecvMsg(handle, (char **)&msg, &len, 10000));
    return 0;
}

static void TestServerStop(void)
{
}

static int32_t TestFailServerStart(ServerHandle handle)
{
    EXPECT_EQ(-1, ServerSyncFile(nullptr, "src", "dts"));
    EXPECT_EQ(-1, ServerSendMsg(nullptr, "message", 6));
    char msg[] = "receive";
    uint32_t len = 7;
    EXPECT_EQ(-1, ServerRecvMsg(nullptr, (char **)&msg, &len, 10000));
    return -1;
}

static void TestFailServerStop(void)
{
}

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
    char *argv[] = { "log-daemon", "-n", NULL };
    Args arg = { argc, argv };
    sleep(1);

    ServerAttr attr = { 0 };
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
static int32_t AdxGetAttrByCommHandleStub(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    if (!g_handleStatus) {
        g_handleStatus = true;
        return -1;
    }
    (void)handle;
    if (attr == 6) { // HDC_SESSION_ATTR_STATUS
        *value = 1; // connect
    } else if (attr == 2) { // HDC_SESSION_ATTR_RUN_ENV
        *value = 1; // NON_DOCKER
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
    char *argv[] = { "log-daemon", "-n", NULL };
    Args arg = { argc, argv };
    sleep(1);

    ServerAttr attr = { 0 };
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = 1;
    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(invoke(AdxGetAttrByCommHandleStub));
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
    char *argv[] = { "log-daemon", "-n", NULL };
    Args arg = { argc, argv };
    pthread_t tid = StartThread(&arg);
    sleep(1);

    ServerAttr attr = { 0 };
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
    ServerAttr attr = { 0 };
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
    ServerAttr attr = { 0 };
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
    ServerAttr attr = { 0 };
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
    ServerAttr attr = { 0 };
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = ENV_NON_DOCKER;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(invoke(AdxGetAttrByCommHandleStub))
        .then(returnValue(-1));
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


int32_t AdxGetAttrByCommHandleStub2(AdxCommConHandle handle, int32_t attr, int32_t *value)
{
    *value = RUN_ENV_PHYSICAL_CONTAINER;
    return 0;
}
TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainInvalidRunEnv)
{
    ServerAttr attr = { 0 };
    attr.num = 1;
    attr.linkType = 0;
    attr.runEnv = ENV_NON_DOCKER;
    EXPECT_EQ(0, ServerCreate(ComponentType::COMPONENT_GETD_FILE, TestServerStart, TestServerStop, &attr));

    MOCKER(AdxGetAttrByCommHandle)
        .stubs()
        .will(invoke(AdxGetAttrByCommHandleStub))
        .then(invoke(AdxGetAttrByCommHandleStub2));
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345;
    handle.comp = COMPONENT_GETD_FILE;
    handle.timeout = 0;
    handle.client = nullptr;
    EXPECT_EQ(0, ServerProcess(&handle, nullptr, 0));

    ServerMgrExit();
    ServerRelease(ComponentType::COMPONENT_GETD_FILE);
}

TEST_F(EP_LOG_DAEMON_FUNC_UTEST, LogDaemonMainServerProcessFailed)
{
    ServerAttr attr = { 0 };
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
    EXPECT_EQ(-1, ServerRecvMsg(handle, (char **)&msg, &len, 10000));
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
    ServerAttr attr = { 0 };
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
    ServerAttr attr = { 0 };
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