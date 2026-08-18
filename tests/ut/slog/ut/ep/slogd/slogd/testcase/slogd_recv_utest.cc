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

class SLOGD_RECEIVE_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        ResetErrLog();
        LogRecordSigNo(0);
        // socket 绑定路径所在目录，缺失会导致 bind 失败
        system("mkdir -p " DEFAULT_LOG_WORKSPACE);
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

static bool TestCheckLogType(const LogInfo* info) { return true; }

static int32_t TestWrite(const char* msg, uint32_t msgLen, const LogInfo* info) { return LOG_SUCCESS; }

static void TestReceive(void* args) { g_writeProcess++; }

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

int32_t SlogdRmtServerRecv_stub(uint32_t fileNum, char* buf, uint32_t bufLen, int32_t* logType)
{
    (void)fileNum;
    static int count = 0;
    if (count == 0) {
        const char msg[100] = "H\0\0\0\x03\0\0\0$\0\0\0\x02\0\0\0"
                              "\xFF\xFF\0\0\0\0\0\0)\0\0\0"
                              "SELECT NVR_CODE FROM TBL_NVR_STORAGE_INFO\0\0\x04";
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
    // 本用例只验证收包循环，不依赖真实 socket。
    // sync 后建 socket 从 SlogdRmtServerCreate 合入了 SlogdRmtServerInit，
    // 故不再走 SlogdCommunicationInit，直接分配收包缓冲即可。
    EXPECT_EQ(LOG_SUCCESS, SlogdInitGlobals());
    // slogd接收消息并处理
    MOCKER(LogGetSigNo).stubs().will(invoke(LogGetSigNo_stub));
    // GetFileNum 与 SlogdMessageRecv 同一 TU，打桩会波及调用方，改用真实值
    MOCKER(SlogdRmtServerRecv).stubs().will(invoke(SlogdRmtServerRecv_stub));
    SlogdMessageRecv(0);
    SlogdFreeGlobals();
}

TEST_F(SLOGD_RECEIVE_UTEST, TestLogServiceProcess)
{
    // 需给出返回值，否则桩被调用时 mockcpp 抛异常，在 C 栈上无法展开会导致崩溃；
    // 同时 mock LogGetSigNo 使收包循环能退出，否则会空转挂死
    MOCKER(SlogdRmtServerRecv).stubs().will(returnValue((int32_t)SYS_ERROR));
    MOCKER(LogGetSigNo).stubs().will(returnValue(0)).then(returnValue(1));
    SlogdInitDeviceId();
    LogServiceProcess(-1);
    GlobalMockObject::verify();

    // david pooling
    // 上面的 verify() 已清除全部桩，此处需重新打桩 SlogdRmtServerRecv，
    // 否则真实实现会在 select() 上永久阻塞
    MOCKER_ServerPooling();
    MOCKER(SlogdRmtServerRecv).stubs().will(returnValue((int32_t)SYS_ERROR));
    MOCKER(LogGetSigNo).stubs().will(returnValue(0)).then(returnValue(1));
    SlogdInitDeviceId();
    LogServiceProcess(-1);
    EXPECT_EQ(true, SlogdIsDevicePooling());
}

TEST_F(SLOGD_RECEIVE_UTEST, TestLogServiceInit)
{
    // david pooling
    // LogServiceInit 会拉起收包线程，需打桩收包，
    // 否则线程阻塞在真实 select() 上导致 TearDown 无法 join
    MOCKER_ServerPooling();
    // 真实建 socket 需要 lchown 改属组，UT 非 root 环境下无权限，
    // 故打桩 SlogdRmtServerInit；SlogdInitGlobals 仍由真实实现执行
    MOCKER(SlogdRmtServerInit).stubs().will(returnValue((LogStatus)LOG_SUCCESS));
    MOCKER(SlogdRmtServerRecv).stubs().will(returnValue((int32_t)SYS_ERROR));
    EXPECT_EQ(LOG_SUCCESS, LogServiceInit(-1, 3, false));
    // 必须在本用例内回收线程：TearDown 的 verify() 会解除上述桩，
    // 之后线程若再调用实现会阻塞在 select() 上
    LogServiceExit();
}
