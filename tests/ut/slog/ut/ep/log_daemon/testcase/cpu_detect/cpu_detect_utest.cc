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
#include "log_daemon_stub.h"
#include "cpu_detect.h"
#include "log_drv.h"
#include "adcore_api.h"
#include "library_load.h"
#include "log_common.h"
#include "server_mgr.h"
using namespace std;
using namespace testing;
int32_t g_cpuDetectHandle = 0;
extern "C" {
    void CpuDetectServerDestroyHandle(void);
    int32_t CpuDetectServerStart(const ServerHandle handle);
    void CpuDetectServerStop(void);
}
int32_t CpuDetectStart(uint32_t timeout)
{
    return 0;
}
void CpuDetectStop(void)
{
    return;
}
static int32_t ServerCreateCpuDetectStub(ComponentType type, ServerStart start, ServerStop stop, ServerAttr* attr)
{
    return 0;
}
#define MAP_SIZE 2
static SymbolInfo g_dlMap[MAP_SIZE] = {
    { "CpuDetectStart", (void *)CpuDetectStart },
    { "CpuDetectStop", (void *)CpuDetectStop },
};

void *DlopenStub(const char *fileName, int mode)
{
    return &g_cpuDetectHandle;
}
int DlcloseStub(void *handle)
{
    return 0;
}
void *DlsymStub(void *handle, const char* funcName)
{
    for (int32_t i = 0; i < MAP_SIZE; i++) {
        if (strcmp(funcName, g_dlMap[i].symbol) == 0) {
            return g_dlMap[i].handle;
        }
    }
    return NULL;
}

CpuDetectInfo g_cpuDetectInfo = {CPU_DETECT_MAGIC_NUM, 0, CPU_DETECT_CMD_START, 0, 0, 0};
class CPU_DETECT_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        MOCKER(dlopen).stubs().will(invoke(DlopenStub));
        MOCKER(dlclose).stubs().will(invoke(DlcloseStub));
        MOCKER(dlsym).stubs().will(invoke(DlsymStub));
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
        g_cpuDetectInfo.magic = CPU_DETECT_MAGIC_NUM;
        g_cpuDetectInfo.cmdType = CPU_DETECT_CMD_START;
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


TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectInit)
{
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_SUCCESS);
    CpuDetectServerExit();
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectInitDlopenFailed)
{
    // so is not exist on other soc
    MOCKER(DlopenStub).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_SUCCESS);
    CpuDetectServerExit();
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectInitDlsymFailed)
{
    MOCKER(DlsymStub).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_FAILURE);
    CpuDetectServerExit();
    EXPECT_NE(0, GetErrLogNum());
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectInitServerCreateFailed)
{
    MOCKER(ServerCreateCpuDetectStub).stubs().will(returnValue(1));
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_FAILURE);
    CpuDetectServerExit();
}

int32_t ServerRecvMsgStub(ServerHandle handle, char **msg, uint32_t *msgLen, uint32_t timeout)
{
    CpuDetectInfo *info = *(CpuDetectInfo**)msg;
    info->magic = g_cpuDetectInfo.magic;
    info->cmdType = g_cpuDetectInfo.cmdType;
    ONE_ACT_ERR_LOG(handle == NULL, return LOG_FAILURE, "receive message failed, handle is null");
    return AdxRecvMsg((AdxCommHandle)handle->handle, msg, msgLen, timeout);
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectServerStartInvalidHandle)
{
    ServerHandle handle = NULL;
    EXPECT_EQ(CpuDetectServerStart(handle), DETECT_FAILURE);
    EXPECT_NE(0, GetErrLogNum());
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectServerStartInvalidMagic)
{
    ServerMgr tmp;
    tmp.send = ServerSendMsg;
    tmp.recv = ServerRecvMsg;
    CommHandle comm = {COMM_HDC, 0x12345, COMPONENT_GETD_FILE};
    tmp.handle = &comm;
    ServerHandle handle = &tmp;
    g_cpuDetectInfo.magic = 0;
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(CpuDetectServerStart(handle), DETECT_FAILURE);
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectServerStart)
{
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_SUCCESS);

    ServerMgr tmp;
    tmp.send = ServerSendMsg;
    tmp.recv = ServerRecvMsg;
    CommHandle comm = {COMM_HDC, 0x12345, COMPONENT_GETD_FILE};
    tmp.handle = &comm;
    ServerHandle handle = &tmp;
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(CpuDetectServerStart(handle), DETECT_SUCCESS);
    CpuDetectServerStop();

    CpuDetectServerExit();
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectTestcaseFailed)
{
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_SUCCESS);
    MOCKER(CpuDetectStart).stubs().will(returnValue(100));
    ServerMgr tmp;
    tmp.send = ServerSendMsg;
    tmp.recv = ServerRecvMsg;
    CommHandle comm = {COMM_HDC, 0x12345, COMPONENT_GETD_FILE};
    tmp.handle = &comm;
    ServerHandle handle = &tmp;
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(CpuDetectServerStart(handle), DETECT_SUCCESS);
    CpuDetectServerStop();

    CpuDetectServerExit();
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectTestcaseTimeout)
{
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_SUCCESS);
    MOCKER(CpuDetectStart).stubs().will(returnValue(1000));
    ServerMgr tmp;
    tmp.send = ServerSendMsg;
    tmp.recv = ServerRecvMsg;
    CommHandle comm = {COMM_HDC, 0x12345, COMPONENT_GETD_FILE};
    tmp.handle = &comm;
    ServerHandle handle = &tmp;
    MOCKER(ServerRecvMsg).stubs().will(invoke(ServerRecvMsgStub));
    EXPECT_EQ(CpuDetectServerStart(handle), DETECT_FAILURE);
    CpuDetectServerStop();

    CpuDetectServerExit();
}

TEST_F(CPU_DETECT_EXCP_UTEST, CpuDetectServerStartRecvFailed)
{
    EXPECT_EQ(CpuDetectServerInit(ServerCreateCpuDetectStub), DETECT_SUCCESS);

    ServerMgr tmp;
    tmp.send = ServerSendMsg;
    tmp.recv = ServerRecvMsg;
    CommHandle comm = {COMM_HDC, 0x12345, COMPONENT_GETD_FILE};
    tmp.handle = &comm;
    ServerHandle handle = &tmp;
    MOCKER(ServerRecvMsg).stubs().will(returnValue(-1));
    EXPECT_EQ(CpuDetectServerStart(handle), DETECT_FAILURE);
    CpuDetectServerStop();

    CpuDetectServerExit();
}
