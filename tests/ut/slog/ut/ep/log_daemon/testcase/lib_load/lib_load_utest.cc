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

// configurable HDC_SESSION_ATTR_RUN_ENV / HDC_SESSION_ATTR_VFID answers for the lib_load peer
// gate; the defaults mirror the C stub (physical machine, directly connected), DEV_ID resolves
static int32_t g_utRunEnv = RUN_ENV_PHYSICAL;
static int32_t g_utVfId = 0;
static drvError_t HalGetSessionAttrRunEnvStub(HDC_SESSION session, int attr, int* value)
{
    (void)session;
    *value = 0;
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = g_utRunEnv;
        return DRV_ERROR_NONE;
    }
    if (attr == HDC_SESSION_ATTR_VFID) {
        *value = g_utVfId;
        return DRV_ERROR_NONE;
    }
    if (attr == HDC_SESSION_ATTR_DEV_ID) {
        *value = 0;
        return DRV_ERROR_NONE;
    }
    return DRV_ERROR_NONE;
}

// the run environment and the vfId resolve, but the device id does not: keeps the devId
// retrieval branch of LibLoadServerProcess covered although the peer gate queries the
// same api first
static drvError_t HalGetSessionAttrDevIdFailedStub(HDC_SESSION session, int attr, int* value)
{
    (void)session;
    *value = 0;
    if (attr == HDC_SESSION_ATTR_DEV_ID) {
        return DRV_ERROR_NO_DEVICE;
    }
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = RUN_ENV_PHYSICAL;
    }
    if (attr == HDC_SESSION_ATTR_VFID) {
        *value = 0;
    }
    return DRV_ERROR_NONE;
}

// the run environment does not resolve: the gate must fail closed instead of letting an
// unreported environment pass as an allowed one
static drvError_t HalGetSessionAttrRunEnvFailedStub(HDC_SESSION session, int attr, int* value)
{
    (void)session;
    *value = 0;
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        return DRV_ERROR_NO_DEVICE;
    }
    return DRV_ERROR_NONE;
}

// the run environment resolves, but the vfId does not: the gate must fail closed instead
// of treating an unreported vfId as directly connected
static drvError_t HalGetSessionAttrVfIdFailedStub(HDC_SESSION session, int attr, int* value)
{
    (void)session;
    *value = 0;
    if (attr == HDC_SESSION_ATTR_VFID) {
        return DRV_ERROR_NO_DEVICE;
    }
    if (attr == HDC_SESSION_ATTR_RUN_ENV) {
        *value = RUN_ENV_PHYSICAL;
    }
    return DRV_ERROR_NONE;
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

    // the gate queries run env and vfId before the devId: keep this case on the devId
    // failure branch with a stub that answers both gate queries successfully
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(HalGetSessionAttrDevIdFailedStub));
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
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(HalGetSessionAttrDevIdFailedStub));

    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadContainerProhibitedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(HalGetSessionAttrRunEnvStub));
    g_utAdxDrainCallCount = 0;
    g_utAdxUnregisterCount = 0;

    // a container inside a virtual machine is not directly connected to the device: the request
    // must be refused and must never reach the upgrade path, whose ServerRelease plus drain
    // would make every detect service on slogd unavailable
    g_utRunEnv = RUN_ENV_VIRTUAL_CONTAINER;
    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("prohibit container operate lib load");
    EXPECT_EQ(0, g_utAdxUnregisterCount);
    EXPECT_EQ(0, g_utAdxDrainCallCount);

    // an unreported environment is treated like a container and refused as well
    g_utRunEnv = RUN_ENV_UNKNOW;
    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("prohibit container operate lib load");
    EXPECT_EQ(0, g_utAdxUnregisterCount);
    EXPECT_EQ(0, g_utAdxDrainCallCount);

    g_utRunEnv = RUN_ENV_PHYSICAL;
    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadRunEnvGetFailedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(HalGetSessionAttrRunEnvFailedStub));
    g_utAdxDrainCallCount = 0;
    g_utAdxUnregisterCount = 0;

    // the driver cannot report the run environment: fail closed, never let the request through
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");
    EXPECT_EQ(0, g_utAdxUnregisterCount);
    EXPECT_EQ(0, g_utAdxDrainCallCount);

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadVfIdGetFailedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(HalGetSessionAttrVfIdFailedStub));
    g_utAdxDrainCallCount = 0;
    g_utAdxUnregisterCount = 0;

    // the driver cannot report the vfId: fail closed, an unreported vfId must never pass
    // as directly connected
    ResetSendCapture();
    EXPECT_EQ(LOG_FAILURE, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("system function failed");
    EXPECT_EQ(0, g_utAdxUnregisterCount);
    EXPECT_EQ(0, g_utAdxDrainCallCount);

    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadPowerGroupProhibitedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(HalGetSessionAttrRunEnvStub));
    g_utAdxDrainCallCount = 0;
    g_utAdxUnregisterCount = 0;

    // a compute power group session (vfId != 0) shares the device with other hosts: an
    // otherwise allowed environment must still be refused, the upgrade would release and
    // drain the detect services for every host of the group
    g_utRunEnv = RUN_ENV_VIRTUAL;
    g_utVfId = 1;
    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("prohibit compute power group operate lib load");
    EXPECT_EQ(0, g_utAdxUnregisterCount);
    EXPECT_EQ(0, g_utAdxDrainCallCount);

    g_utRunEnv = RUN_ENV_PHYSICAL;
    g_utVfId = 0;
    LibLoadServerDestroy();
    free(msg);
}

TEST_F(LIB_LOAD_EXCP_UTEST, LibLoadDirectEnvAllowedReply)
{
    MOCKER(ToolRealPath).stubs().will(returnValue(SYS_OK));
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerInit());
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char name[] = {"libhbm_detect.so"};
    LibLoadInfo info{0x0F0F0F0FU, 0x1000U, strlen(name), "libhbm_detect.so"};
    LogDataMsg* msg = (LogDataMsg*)malloc(sizeof(LogDataMsg) + sizeof(LibLoadInfo));
    (void)memcpy_s(msg->data, sizeof(LibLoadInfo), &info, sizeof(LibLoadInfo));
    MOCKER(AdxSendMsg).stubs().will(invoke(AdxSendMsgCaptureStub));
    MOCKER(halHdcGetSessionAttr).stubs().will(invoke(HalGetSessionAttrRunEnvStub));
    // no upgrade package on the device plugin paths is the designed success fallback
    MOCKER(ToolAccess).stubs().will(returnValue(SYS_ERROR));

    // the container deployed directly on the physical machine and the virtual machine stay
    // allowed for detection
    g_utRunEnv = RUN_ENV_PHYSICAL_CONTAINER;
    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("load library successfully");

    g_utRunEnv = RUN_ENV_VIRTUAL;
    ResetSendCapture();
    EXPECT_EQ(LOG_SUCCESS, LibLoadServerProcess(&handle, msg, sizeof(LogDataMsg) + sizeof(LibLoadInfo)));
    ExpectOneReply("load library successfully");

    g_utRunEnv = RUN_ENV_PHYSICAL;
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
