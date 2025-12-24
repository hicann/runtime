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
#include "msn_config.h"
#include "log_cmd.h"
#include "ts_cmd.h"
#include "msnpureport_common.h"
#include "config_common.h"
#include "log_drv.h"
#include "msg_queue.h"
#include "driver_api.h"
#include "task_scheduler_error.h"
#include "self_log_stub.h"
#include "log_daemon_stub.h"

using namespace std;
using namespace testing;

extern "C" {
extern int32_t LogCmdSendLogMsg(LogCmdMsg *rcvMsg, const char *msg, uint16_t devId);
extern int32_t CheckEnvSupport(const CommHandle *handle);
extern int32_t ParseDeviceCmd(const CommHandle *handle, MsnReq *req, uint16_t devId);
extern int32_t CmdRespSettingResult(const CommHandle *handle, const char *resultBuf, size_t resultLen, bool isError);
extern void HandleErrorCode(int32_t drvRet, ts_error_t tsRet, const char **result);
extern int32_t SaveToResult(char *resultBuf, uint32_t bufLen, const char *value);
}

class EP_LOG_DAEMON_CONFIG_CMD_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
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

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, MsnCmdInit)
{
    EXPECT_EQ(CONFIG_OK, MsnCmdInit());
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, MsnCmdDestory)
{
    EXPECT_EQ(CONFIG_OK, MsnCmdInit());
    EXPECT_EQ(CONFIG_OK, MsnCmdDestory());
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, CheckEnvSupport)
{
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345678;
    int runEnv = 4;
    MOCKER(halHdcGetSessionAttr)
        .stubs()
        .with(any(), any(), outBoundP(&runEnv, sizeof(runEnv)))
        .will(returnValue(1))
        .then(returnValue(0));
    EXPECT_EQ(CONFIG_ERROR, CheckEnvSupport(&handle));
    EXPECT_EQ(CONFIG_ERROR, CheckEnvSupport(&handle));

    GlobalMockObject::verify();
    int vfid = 1;
    MOCKER(halHdcGetSessionAttr)
        .stubs()
        .with(any(), any(), outBoundP(&vfid, sizeof(vfid)))
        .will(returnValue(0))
        .then(returnValue(1))
        .then(returnValue(0));
    EXPECT_EQ(CONFIG_ERROR, CheckEnvSupport(&handle));
    EXPECT_EQ(CONFIG_ERROR, CheckEnvSupport(&handle));
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, CmdRespSettingResult)
{
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345678;
    char result[] = "success";
    MOCKER(AdxSendMsgByHandle)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    EXPECT_EQ(CONFIG_ERROR, CmdRespSettingResult(&handle, result, strlen(result), false));
    EXPECT_EQ(CONFIG_OK, CmdRespSettingResult(&handle, result, strlen(result), false));
    EXPECT_EQ(CONFIG_OK, CmdRespSettingResult(&handle, result, strlen(result), true));
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, ReportHandle)
{
    CommHandle handle;
    handle.type = COMM_HDC;
    handle.session = (OptHandle)0x12345678;


    MOCKER(log_set_dfx_param)
        .stubs()
        .will(returnValue((int)LOG_OK))
        .then(returnValue((int)LOG_NOT_SUPPORT))
        .then(returnValue((int)LOG_ERROR));

    MsnReq msnReq = {REPORT, 0, 0};
    EXPECT_EQ(CONFIG_OK, ParseDeviceCmd(&handle, &msnReq, 0));
    EXPECT_EQ(CONFIG_OK, ParseDeviceCmd(&handle, &msnReq, 0));
    EXPECT_EQ(CONFIG_OK, ParseDeviceCmd(&handle, &msnReq, 0));
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, SetLogLevel)
{
    EXPECT_EQ(CONFIG_OK, LogCmdInitMutex());

    char *value = "SetLogLevel(1)[FMK:debug]";
    MOCKER(MsgQueueOpen).stubs().will(returnValue(-1)).then(returnValue(0));
    MOCKER(ToolGetErrorCode).stubs().will(repeat(0, 3)).then(returnValue(ENOMSG));
    EXPECT_EQ(CONFIG_ERROR, LogCmdSetLogLevel(value, 0));
    MOCKER(MsgQueueRecv).stubs().will(repeat(-1, 3)).then(returnValue(0));
    MOCKER(MsgQueueSend).stubs().will(returnValue(-1)).then(returnValue(0));
    EXPECT_EQ(CONFIG_ERROR, LogCmdSetLogLevel(value, 0));
    EXPECT_EQ(CONFIG_ERROR, LogCmdSetLogLevel(value, 0));

    EXPECT_EQ(CONFIG_OK, LogCmdDestoryMutex());
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, GetLogLevel)
{
    EXPECT_EQ(CONFIG_OK, LogCmdInitMutex());

    char resultBuf[1024] = {0};
    uint32_t resultLen = 0;

    MOCKER(LogCmdSendLogMsg)
        .stubs()
        .will(returnValue(CONFIG_LOG_MSGQUEUE_FAILED))
        .then(returnValue(CONFIG_OK));
    EXPECT_EQ(CONFIG_LOG_MSGQUEUE_FAILED, LogCmdGetLogLevel(resultBuf, &resultLen, 0));
    EXPECT_EQ(CONFIG_OK, LogCmdGetLogLevel(resultBuf, &resultLen, 0));

    EXPECT_EQ(CONFIG_OK, LogCmdDestoryMutex());
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, MsnCmdProcessConfigGet)
{
    EXPECT_EQ(CONFIG_OK, MsnCmdInit());
    CommHandle command = {COMM_HDC, (OptHandle)0x12345678};
    size_t len = sizeof(LogDataMsg) + sizeof(MsnReq);
    LogDataMsg *logDataMsg = (LogDataMsg *)malloc(len);
    logDataMsg->devId = 0;
    logDataMsg->sliceLen = sizeof(MsnReq);
    MsnReq *msnReq = (MsnReq *)logDataMsg->data;
    msnReq->cmdType = CONFIG_GET;
    msnReq->subCmd = 0;
    msnReq->valueLen = 0;

    MOCKER(LogCmdGetLogLevel).stubs().will(returnValue(0));
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));
    EXPECT_EQ(CONFIG_OK, MsnCmdDestory());
    free(logDataMsg);
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, SaveToResultError)
{
    char resultBuf[8] = {0};
    uint32_t resultLen = strlen(resultBuf);
    char *value = "1,2,3,4,5,6,7,8,9,10,11";
    EXPECT_EQ(CONFIG_BUFFER_NOT_ENOUGH, SaveToResult(resultBuf, 8, value));

    MOCKER(strcat_s).stubs().will(returnValue(-1));
    value = "1,2,3";
    EXPECT_EQ(CONFIG_MEM_WRITE_FAILED, SaveToResult(resultBuf, 8, value));
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, MsnCmdProcessConfigSet)
{
    EXPECT_EQ(CONFIG_OK, MsnCmdInit());
    CommHandle command = {COMM_HDC, (OptHandle)0x12345678};
    size_t len = sizeof(LogDataMsg) + sizeof(MsnReq) + sizeof(DfxCommon);
    LogDataMsg *logDataMsg = (LogDataMsg *)malloc(len);
    memset_s(logDataMsg, len, 0, len);
    logDataMsg->devId = 0;
    logDataMsg->sliceLen = sizeof(MsnReq) + sizeof(DfxCommon);
    MsnReq *msnReq = (MsnReq *)logDataMsg->data;
    msnReq->cmdType = CONFIG_SET;
    msnReq->subCmd = INVALID_TYPE;
    msnReq->valueLen = sizeof(DfxCommon);
    DfxCommon *common = (DfxCommon*)msnReq->value;
    common->value = 1;

    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len)); // COMMAND_INFO_ERROR_MSG
    msnReq->subCmd = LOG_LEVEL;
    MOCKER(LogCmdSetLogLevel).stubs().will(returnValue(CONFIG_ERROR)).then(returnValue(CONFIG_OK));
    EXPECT_EQ(CONFIG_ERROR, MsnCmdProcess(&command, logDataMsg, len));
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));

    msnReq->subCmd = ICACHE_RANGE;
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));
#ifndef CONFIG_EXPAND
    common->value = 999999999999;
    EXPECT_EQ(CONFIG_INVALID_PARAM, MsnCmdProcess(&command, logDataMsg, len));
#endif
    common->value = 1;
    msnReq->subCmd = ACCELERATOR_RECOVER;
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));
    msnReq->subCmd = SINGLE_COMMIT;
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));
#ifndef CONFIG_EXPAND
    common->value = 324;
    EXPECT_EQ(CONFIG_INVALID_PARAM, MsnCmdProcess(&command, logDataMsg, len));
#endif
    common->value = 1;

    msnReq->subCmd = AIC_SWITCH;
    DfxCoreSetMask * coreMask = (DfxCoreSetMask*)msnReq->value;
    coreMask->coreSwitch = 1;
    coreMask->configNum = 2;
    coreMask->coreId[0] = 1;
    coreMask->coreId[1] = 2;
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));
    msnReq->subCmd = AIV_SWITCH;
    coreMask->coreSwitch = 2;
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));
    MOCKER(TsCmdSetConfig).stubs().will(returnValue(CONFIG_ERROR)).then(returnValue(CONFIG_OK));
    EXPECT_EQ(CONFIG_ERROR, MsnCmdProcess(&command, logDataMsg, len));
    EXPECT_EQ(CONFIG_OK, MsnCmdProcess(&command, logDataMsg, len));

    EXPECT_EQ(CONFIG_OK, MsnCmdDestory());
    free(logDataMsg);
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, HandleErrorCode)
{
    const char *result = SET_SUCCESS_MSG;
    HandleErrorCode(LOG_OK, TS_SUCCESS, &result);
    EXPECT_EQ(0, strcmp(SET_SUCCESS_MSG, result));
    HandleErrorCode(LOG_ERROR, TS_SUCCESS, &result);
    EXPECT_EQ(0, strcmp(DRV_ERROR, result));
    HandleErrorCode(LOG_NOT_READY, TS_SUCCESS, &result);
    EXPECT_EQ(0, strcmp(DRV_NOT_READY, result));
    HandleErrorCode(LOG_NOT_SUPPORT, TS_SUCCESS, &result);
    EXPECT_EQ(0, strcmp(TS_NOT_SUPPORT, result));
    HandleErrorCode(DRV_ERROR_NO_DEVICE, TS_SUCCESS, &result);
    EXPECT_EQ(0, strcmp(DRV_ERROR, result));

    HandleErrorCode(LOG_OK, TS_ERROR_FEATURE_NOT_SUPPORT, &result);
    EXPECT_EQ(0, strcmp(TS_NOT_SUPPORT, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_RESET_ACC_SWITCH_INVALID, &result);
    EXPECT_EQ(0, strcmp(DRV_ERROR, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_CORE_SWITCH_INVALID, &result);
    EXPECT_EQ(0, strcmp(DRV_ERROR, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_CORE_ID_INVALID, &result);
    EXPECT_EQ(0, strcmp(TS_CORE_ID_INVALID, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_NO_VALID_CORE_ID, &result);
    EXPECT_EQ(0, strcmp(TS_CORE_ID_INVALID, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_CORE_ID_PG_DOWN, &result);
    EXPECT_EQ(0, strcmp(TS_CORE_ID_PF_DOWN, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_NOT_SUPPORT_CORE_MASK, &result);
    EXPECT_EQ(0, strcmp(TS_NOT_SUPPORT_CORE, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_SINGLE_COMMIT_INVALID, &result);
    EXPECT_EQ(0, strcmp(DRV_ERROR, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_NOT_SUPPORT_AIV_CORE_MASK, &result);
    EXPECT_EQ(0, strcmp(TS_NOT_SUPPORT_AIV_CORE, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_NOT_IN_POOL, &result);
    EXPECT_EQ(0, strcmp(TS_CORE_NOT_IN_POOL, result));
    HandleErrorCode(LOG_OK, TS_LOG_DEAMON_CORE_POOLING_STATUS_FAIL, &result);
    EXPECT_EQ(0, strcmp(TS_POOLING_STATUS_FAIL, result));
    HandleErrorCode(LOG_OK, TS_ERROR_UNKNOWN, &result);
    EXPECT_EQ(0, strcmp(DRV_ERROR, result));
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, TsCmdGetConfig)
{
    char resultBuf[1024] = {0};
    TsCmdGetConfig(resultBuf, 1024, 0);
    std::string result(resultBuf);
    auto startPos = result.find("Aic Coremask:");
    auto stopPos = result.find(",", startPos);
    EXPECT_LE(8*3+1, stopPos - startPos);
    startPos = result.find("Aiv Coremask:");
    stopPos = result.find(",", startPos);
    EXPECT_LE(8*3+1, stopPos - startPos);
}

TEST_F(EP_LOG_DAEMON_CONFIG_CMD_UTEST, TsCmdGetConfigErrorFailed)
{
    char resultBuf[1024] = {0};
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    TsCmdGetConfig(resultBuf, 1024, 0);
    EXPECT_EQ(0, strlen(resultBuf));

    MOCKER(log_get_dfx_param).stubs().will(returnValue(-1));
    TsCmdGetConfig(resultBuf, 1024, 0);
    EXPECT_EQ(0, strlen(resultBuf));
}