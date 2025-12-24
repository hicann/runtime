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

#include "slogd_recv_core.h"
#include "log_pm_sig.h"
#include "slogd_communication.h"
#include "slogd_recv_msg.h"
#include "slogd_dev_mgr.h"
#include "slogd_service.h"

#include "self_log_stub.h"
#include "ascend_hal_stub.h"
#include "slogd_stub.h"

static int32_t g_writeProcess = 0;

#ifdef __cplusplus
extern "C" {
#endif
extern ReceiveMgr g_receiveMgr;
#ifdef __cplusplus
}
#endif

class SLOGD_RECEIVE_UTEST : public testing::Test
{
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        LogRecordSigNo(0);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start test case");
    }

    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        LogRecordSigNo(0);
        g_writeProcess = 0;
        memset(&g_receiveMgr, 0, sizeof(ReceiveMgr));
    }
};

static bool TestCheckLogType(const LogInfo *info)
{
    return true;
}

static int32_t TestWrite(const char *msg, uint32_t msgLen, const LogInfo *info)
{
    return LOG_SUCCESS;
}

static void TestReceive(void *args)
{
    g_writeProcess++;
}

static void MOCKER_ServerPooling(void)
{
    MOCKER(SlogdIsDevicePooling).stubs().will(returnValue(true));
    MOCKER(halGetDeviceInfo).stubs().will(invoke(halGetDeviceInfo_stub));
}

TEST_F(SLOGD_RECEIVE_UTEST, ReceiveDevice)
{
    LogReceiveNode receiveNode = {FIRMWARE_LOG_PRIORITY, TestReceive};
    EXPECT_EQ(LOG_SUCCESS, SlogdDevReceiveRegister(&receiveNode));
    EXPECT_EQ(LOG_SUCCESS, SlogdReceiveInit());
    usleep(10 * 1000);
    LogRecordSigNo(15);
    SlogdReceiveExit();
    EXPECT_NE(0, g_writeProcess);
}

TEST_F(SLOGD_RECEIVE_UTEST, ReceiveCommon)
{
    LogReceiveNode recvNode = {SYS_LOG_PRIORITY, TestReceive};
    EXPECT_EQ(LOG_SUCCESS, SlogdComReceiveRegister(&recvNode));
    EXPECT_EQ(LOG_SUCCESS, SlogdReceiveInit());
    usleep(10 * 1000);
    LogRecordSigNo(15);
    SlogdReceiveExit();
    EXPECT_NE(0, g_writeProcess);
}

TEST_F(SLOGD_RECEIVE_UTEST, ReceiveCommon_snprintf_failed)
{
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));
    LogReceiveNode recvNode = {SYS_LOG_PRIORITY, TestReceive};
    EXPECT_EQ(LOG_SUCCESS, SlogdComReceiveRegister(&recvNode));
    EXPECT_EQ(LOG_SUCCESS, SlogdReceiveInit());
    usleep(1 * 1000);
    LogRecordSigNo(15);
    SlogdReceiveExit();
    EXPECT_NE(0, GetErrLogNum());
    EXPECT_EQ(0, g_writeProcess);
}

TEST_F(SLOGD_RECEIVE_UTEST, SlogdDistributeRegisterError)
{
    EXPECT_EQ(LOG_FAILURE, SlogdDistributeRegister(nullptr));
    LogDistributeNode distributeNode = {FIRMWARE_LOG_PRIORITY, NULL, NULL};
    EXPECT_EQ(LOG_FAILURE, SlogdDistributeRegister(&distributeNode));
    distributeNode.checkLogType = TestCheckLogType;
    distributeNode.write = TestWrite;
    EXPECT_EQ(LOG_SUCCESS, SlogdDistributeRegister(&distributeNode));
}

int32_t SlogdRmtServerRecv_stub(uint32_t fileNum, char *buf, uint32_t bufLen, int32_t *logType)
{
    (void)fileNum;
    static int count = 0;
    if (count == 0) {
        char msg[100] = "H\0\0\0\0\0\0$\0\0\0\0\0\0\0\0\0\0\0\0)\0\0\0SELECT NVR_CODE FROM TBL_NVR_STORAGE_INFO\0\0";
        memcpy(buf, msg, 100);
        *logType = 0;
        count++;
        return 72;
    }
    count++;
    return -2;
}

TEST_F(SLOGD_RECEIVE_UTEST, RecvMsgTest)
{
    // 初始化
    EXPECT_EQ(LOG_SUCCESS, SlogdCommunicationInit());
    // slogd接收消息并处理
    MOCKER(LogGetSigNo).stubs().will(invoke(LogGetSigNo_stub));
    MOCKER(SlogdRmtServerCreate).stubs().will(returnValue(0));
    MOCKER(SlogdRmtServerRecv).stubs().will(invoke(SlogdRmtServerRecv_stub));
    SlogdMessageRecv(0);
    SlogdCommunicationExit();
}

TEST_F(SLOGD_RECEIVE_UTEST, TestLogServiceProcess)
{
    MOCKER(SlogdRmtServerRecv).stubs();
    SlogdInitDeviceId();
    LogServiceProcess(-1);
    GlobalMockObject::verify();

    // david pooling
    MOCKER_ServerPooling();
    MOCKER(LogGetSigNo).stubs().will(returnValue(0)).then(returnValue(1));
    SlogdInitDeviceId();
    LogServiceProcess(-1);
    EXPECT_EQ(true, SlogdIsDevicePooling());
}

TEST_F(SLOGD_RECEIVE_UTEST, TestLogServiceInit)
{
    // david pooling
    MOCKER_ServerPooling();
    EXPECT_EQ(LOG_SUCCESS, LogServiceInit(-1, 3, false));
}