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
#include "lib_load.h"
#include "log_drv.h"
#include "adcore_api.h"
#include "library_load.h"
#include "log_common.h"
#include "server_mgr.h"
using namespace std;
using namespace testing;

int32_t g_libLoadHandle = 0;

int32_t HbmDetectServerInit()
{
    return 0;
}

int32_t CpuDetectServerInit()
{
    return 0;
}

void CpuDetectServerExit()
{

}

#define MAP_SIZE 3
static SymbolInfo g_dlMap[MAP_SIZE] = {
    { "HbmDetectServerInit", (void *)HbmDetectServerInit },
    { "CpuDetectServerInit", (void *)CpuDetectServerInit },
    { "CpuDetectServerExit", (void *)CpuDetectServerExit },
};

static void *DlopenStub(const char *fileName, int mode)
{
    return &g_libLoadHandle;
}

static int32_t g_dlcloseFlag = 100;
static int DlcloseStub(void *handle)
{
    if (g_dlcloseFlag-- <= 0) {
        return -1;
    }
    return 0;
}

static int32_t g_dlsymFlag = 100;
static void *DlsymStub(void *handle, const char* funcName)
{
    if (g_dlsymFlag-- <= 0) {
        return (void *)NULL;
    }
    for (int32_t i = 0; i < MAP_SIZE; i++) {
        if (strcmp(funcName, g_dlMap[i].symbol) == 0) {
            return g_dlMap[i].handle;
        }
    }
    return (void *)NULL;
}

class LIB_LOAD_EXCP_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        MOCKER(dlopen).stubs().will(invoke(DlopenStub));
        MOCKER(dlclose).stubs().will(invoke(DlcloseStub));
        MOCKER(dlsym).stubs().will(invoke(DlsymStub));
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
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


TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadHbmDetect)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));

    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    // needn't upgrade
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadCpuDlsymFailed)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libcpu_detect_server.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libcpu_detect_server.so"};
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    g_dlsymFlag = 0;
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    g_dlsymFlag = 1;
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    g_dlsymFlag = 2;
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    g_dlsymFlag = 100;
    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadHbmDlsymFailed)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    g_dlsymFlag = 0;
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    g_dlsymFlag = 1;
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    g_dlsymFlag = 100;
    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadCpuDetect)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libcpu_detect_server.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libcpu_detect_server.so"};
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));

    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadException)
{
    EXPECT_EQ(LOG_FAILURE, LibLoadServerInit());
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(NULL, msg, sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, NULL, sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, 1));
    info.magic = 1;
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    info.magic = 0x0F0F0F0FU;
    info.version = 1;
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    info.version = 0x1000U;
    LibLoadInfo errInfo{0x0F0F0F0FU, 0x1000U, strlen(name), "libtest_detect.so"};
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &errInfo, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    MOCKER(halGetDeviceInfoByBuff).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadSystemFunc)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));

    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadInitFailed)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    g_dlcloseFlag = 0;
    MOCKER(ToolMutexInit).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerInit());
    g_dlcloseFlag = 100;
    MOCKER(vsprintf_s).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerInit());
    MOCKER(DlopenStub).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadProcessFailed)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK)).then(returnValue(SYS_OK)).then(returnValue(SYS_ERROR)).then(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg *msg = (LogDataMsg *)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    MOCKER(vsprintf_s).stubs().will(returnValue(-1)).then(returnValue(0)).then(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    MOCKER(strncpy_s).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    MOCKER(DlopenStub).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LibLoadInfo)));
    free(msg);
}
