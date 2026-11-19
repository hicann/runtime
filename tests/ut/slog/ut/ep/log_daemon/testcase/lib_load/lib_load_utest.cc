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

// 这些函数仅作为 dlsym 的返回目标，不能与 cpu_detect_server.c / hbm_detect.c
// 中的同名产品实现重名，否则与本 target 链接时会重复定义。
static int32_t HbmDetectServerInitStub() { return 0; }

static int32_t CpuDetectServerInitStub() { return 0; }

static void CpuDetectServerExitStub() {}

#define MAP_SIZE 3
static SymbolInfo g_dlMap[MAP_SIZE] = {
    {"HbmDetectServerInit", (void*)HbmDetectServerInitStub},
    {"CpuDetectServerInit", (void*)CpuDetectServerInitStub},
    {"CpuDetectServerExit", (void*)CpuDetectServerExitStub},
};

static void* DlopenStub(const char* fileName, int mode) { return &g_libLoadHandle; }

static int32_t g_dlcloseFlag = 100;
static int DlcloseStub(void* handle)
{
    if (g_dlcloseFlag-- <= 0) {
        return -1;
    }
    return 0;
}

static int32_t g_dlsymFlag = 100;
static void* DlsymStub(void* handle, const char* funcName)
{
    if (g_dlsymFlag-- <= 0) {
        return (void*)NULL;
    }
    for (int32_t i = 0; i < MAP_SIZE; i++) {
        if (strcmp(funcName, g_dlMap[i].symbol) == 0) {
            return g_dlMap[i].handle;
        }
    }
    return (void*)NULL;
}

// capture the AdxSendMsg payloads of one lib load request so the reply protocol can be
// asserted per branch: exactly one payload message followed by one HDC_END_MSG
static int32_t g_sendCount = 0;
static char g_sendBuf[2][256];
static int32_t AdxSendMsgCaptureStub(const CommHandle* handle, AdxString data, uint32_t len)
{
    (void)handle;
    if ((g_sendCount < 2) && (data != NULL)) {
        uint32_t copyLen = (len < (sizeof(g_sendBuf[0]) - 1)) ? len : (uint32_t)(sizeof(g_sendBuf[0]) - 1);
        (void)memcpy_s(g_sendBuf[g_sendCount], sizeof(g_sendBuf[0]), data, copyLen);
        g_sendBuf[g_sendCount][copyLen] = '\0';
    }
    g_sendCount++;
    return 0;
}

static void ResetSendCapture(void)
{
    g_sendCount = 0;
    (void)memset_s(g_sendBuf, sizeof(g_sendBuf), 0, sizeof(g_sendBuf));
}

// HDC_END_MSG is defined in src/dfx/adump/external/extra_config.h and reaches this file
// through the existing adcore_api.h include chain
static void ExpectOneReply(const char* expectMsg)
{
    ASSERT_EQ(2, g_sendCount);
    EXPECT_STREQ(expectMsg, g_sendBuf[0]);
    EXPECT_STREQ(HDC_END_MSG, g_sendBuf[1]);
}

class LIB_LOAD_EXCP_UTEST : public testing::Test {
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
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));

    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    // needn't upgrade
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
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
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    g_dlsymFlag = 0;
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    g_dlsymFlag = 1;
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    g_dlsymFlag = 2;
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
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
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    g_dlsymFlag = 0;
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    g_dlsymFlag = 1;
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
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
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));

    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
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
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(NULL, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, NULL, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, 1));
    info.magic = 1;
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    info.magic = 0x0F0F0F0FU;
    info.version = 1;
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    info.version = 0x1000U;
    LibLoadInfo errInfo{0x0F0F0F0FU, 0x1000U, strlen(name), "libtest_detect.so"};
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &errInfo, sizeof(LibLoadInfo));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    // no upgrade package on the device plugin paths is the designed fallback: keep the
    // default library loaded and reply success; the host gates this request on the device
    // driver >= 9 and one-shot per host process, so a missing upgrade package is not an error
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    MOCKER(halGetDeviceInfoByBuff).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));

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
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));

    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
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
    MOCKER(ToolRealPath)
        .stubs()
        .will(returnValue(SYS_OK))
        .then(returnValue(SYS_OK))
        .then(returnValue(SYS_ERROR))
        .then(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));

    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    MOCKER(vsprintf_s).stubs().will(returnValue(-1)).then(returnValue(0)).then(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    MOCKER(strncpy_s).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    MOCKER(DlopenStub).stubs().will(returnValue((void*)NULL));
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadInvalidInputReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, NULL, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("check input validity failed");

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, 1));
    ExpectOneReply("check input validity failed");

    info.magic = 1;
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("check input validity failed");

    info.magic = 0x0F0F0F0FU;
    info.version = 1;
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("check input validity failed");

    info.version = 0x1000U;
    LibLoadInfo errInfo{0x0F0F0F0FU, 0x1000U, strlen(name), "libtest_detect.so"};
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &errInfo, sizeof(LibLoadInfo));
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("check input validity failed");

    LibLoadServerDestroy();
    free(msg);
}

// malicious or corrupted request: the 128-byte name is fully non-NUL with a legitimate
// length, or length walks out of the name array; LibLoadValidateLoadInfo must reject
// both before strcmp or %s ever reads past the buffer
TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadNameNotTerminatedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));

    // all 128 name bytes non-NUL while length matches a legitimate library name:
    // name[length] is not the terminator, so the request must be rejected here
    LibLoadInfo noTermInfo{0x0F0F0F0FU, 0x1000U, strlen("libhbm_detect.so"), ""};
    (void)memset_s(noTermInfo.name, sizeof(noTermInfo.name), 'A', sizeof(noTermInfo.name));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &noTermInfo, sizeof(LibLoadInfo));
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("check input validity failed");

    // length exactly at the array capacity: name[length] must not be read at all
    LibLoadInfo overLenInfo{0x0F0F0F0FU, 0x1000U, LIB_MAX_LENGTH_OF_NAME, "libhbm_detect.so"};
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &overLenInfo, sizeof(LibLoadInfo));
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("check input validity failed");

    // length far beyond the array: the bounds check must reject before any read
    LibLoadInfo hugeLenInfo{0x0F0F0F0FU, 0x1000U, 0xFFFFFFFFU, "libhbm_detect.so"};
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &hugeLenInfo, sizeof(LibLoadInfo));
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("check input validity failed");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadGetDevIdFailedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(halHdcGetSessionAttr).stubs().will(returnValue(1));

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadNotFoundUpgradeReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_ERROR));

    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("load library successfully");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadSprintfFailedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadStatFailedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    // explicitly inject stat failure so this branch does not depend on the host filesystem
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_ERROR));

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadHalGetInfoFailedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    MOCKER(halGetDeviceInfoByBuff).stubs().will(returnValue(1));

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadNeedntUpgradeReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));

    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("load library successfully");

    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("load library successfully");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadUpgradeSuccessReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));

    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("load library successfully");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadUpgradeFailedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_OK));
    MOCKER(ToolStatGet).stubs().will(returnValue(SYS_OK));
    g_dlsymFlag = 0;

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");

    g_dlsymFlag = 100;
    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadNullHandleNoReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(NULL, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    EXPECT_EQ(0, g_sendCount);

    LibLoadServerDestroy();
    free(msg);
}
