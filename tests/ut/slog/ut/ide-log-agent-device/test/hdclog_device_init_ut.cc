/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
extern "C" {
#include "log_common.h"
#include "hdclog_device_init.h"
#include "hdclog_com.h"
#include "msg_queue.h"
#include "log_config_api.h"
#include "log_path_mgr.h"
#include "adcore_api.h"
#include "log_drv.h"
HdclogErr LogCmdRespSettingResult(HDC_SESSION session, const char* errMsg, unsigned int errLen);
HdclogErr ParseDeviceLogCmd(HDC_SESSION session, const LogDataMsg *msg);
bool JudgeIfComputePowerGroup(HDC_SESSION session, int vfId);
int DrvDevIdGetBySession(HDC_SESSION session, int attr, int *value);
bool IsContainsStr(const char *str, const char *subStr);
}
#include <malloc.h>
#include <unistd.h>
#include <sys/msg.h>
#include <sys/shm.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "config_common.h"
#include "log_cmd.h"
using namespace std;
using namespace testing;

class HDCLOG_DEVICE_INIT_TEST : public testing::Test{
    protected:
        static void SetupTestCase()
        {
            cout << "HDCLOG_DEVICE_INIT_TEST SetUP" <<endl;
        }
        static void TearDownTestCase()
        {
            cout << "DTRACE_DECODE_TEST TearDown" << endl;
        }
        virtual void SetUP()
        {
            cout << "a test SetUP" << endl;
        }
        virtual void TearDown()
        {
            cout << "a test TearDown" << endl;
        }
};

extern HDC_SESSION g_hdclogSession;

TEST_F(HDCLOG_DEVICE_INIT_TEST, HdclogDeviceInitTest)
{
    MOCKER(ToolMutexInit).stubs().will(returnValue(-1));
    EXPECT_EQ(HDCLOG_MUTEX_INIT_FAILED, HdclogDeviceInit());
    GlobalMockObject::reset();

    MOCKER(ToolMutexInit).stubs().will(returnValue(0));
    EXPECT_EQ(HDCLOG_SUCCESSED, HdclogDeviceInit());
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, HdclogDeviceDestroyTest)
{
    EXPECT_EQ(HDCLOG_SUCCESSED, HdclogDeviceDestroy());
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, JudgeIfComputePowerGroupTest1)
{
    HDC_SESSION session = (void*)100;
    int vfId = 1;
    EXPECT_EQ(true, JudgeIfComputePowerGroup(session, vfId));
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, JudgeIfComputePowerGroupTest2)
{
    HDC_SESSION session = (void*)100;
    int vfId = 0;
    EXPECT_EQ(false, JudgeIfComputePowerGroup(session, vfId));
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IdeDeviceLogProcessTest1)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char value[] = "data";
    uint len = sizeof(LogDataMsg)+strlen(value)+1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = strlen(value);

    EXPECT_EQ(HDCLOG_EMPTY_QUEUE, IdeDeviceLogProcess(NULL, NULL, 0));

    MOCKER(DrvDevIdGetBySession).stubs().will(returnValue(-1));
    EXPECT_EQ(HDCLOG_IDE_GET_EVN_OR_VFID_FAILED, IdeDeviceLogProcess(&handle, tmp, len));
    free(tmp);
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IdeDeviceLogProcessTest2)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char value[] = "data";
    uint len = sizeof(LogDataMsg)+strlen(value)+1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = strlen(value);

    MOCKER(DrvDevIdGetBySession).stubs().will(returnValue(0));
    MOCKER(JudgeIfComputePowerGroup).stubs().will(returnValue(true));
    EXPECT_EQ(HDCLOG_COMPUTE_POWER_GROUP, IdeDeviceLogProcess(&handle, tmp, len));
    free(tmp);
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IdeDeviceLogProcessTest3)
{
    CommHandle handle{COMM_HDC, NULL};
    char value[] = "data";
    uint len = sizeof(LogDataMsg)+strlen(value)+1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = strlen(value);

    MOCKER(DrvDevIdGetBySession).stubs().will(returnValue(0));
    MOCKER(JudgeIfComputePowerGroup).stubs().will(returnValue(false));
    EXPECT_EQ(HDCLOG_EMPTY_QUEUE, IdeDeviceLogProcess(&handle, tmp, len));
    free(tmp);
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IdeDeviceLogProcessTes4)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char value[] = "data";
    uint len = sizeof(LogDataMsg)+strlen(value)+1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = strlen(value);

    cout<<tmp<<value<<endl;

    MOCKER(LogCmdRespSettingResult).stubs().will(returnValue(HDCLOG_SUCCESSED));
    MOCKER(ParseDeviceLogCmd).stubs().will(returnValue(HDCLOG_SUCCESSED));
    EXPECT_EQ(HDCLOG_SUCCESSED, IdeDeviceLogProcess(&handle, tmp, len));
    GlobalMockObject::reset();

    free(tmp);
    tmp=NULL;
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IdeDeviceLogProcessTestGetEnvFailed)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char value[] = "data";
    uint len = sizeof(LogDataMsg)+strlen(value)+1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = strlen(value);

    MOCKER(DrvDevIdGetBySession).stubs().will(returnValue(-1));
    MOCKER(LogCmdRespSettingResult).stubs().will(returnValue(HDCLOG_SUCCESSED));
    EXPECT_EQ(HDCLOG_IDE_GET_EVN_OR_VFID_FAILED, IdeDeviceLogProcess(&handle, tmp, len));
    free(tmp);
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IdeDeviceLogProcessTestVirtualEnv)
{
    CommHandle handle{COMM_HDC, (OptHandle)0x12345678};
    char value[] = "data";
    uint len = sizeof(LogDataMsg)+strlen(value)+1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = strlen(value);

    int runEnv = 4;
    MOCKER(DrvDevIdGetBySession).stubs().with(any(), any(), outBoundP(&runEnv)).will(returnValue(0));
    MOCKER(LogCmdRespSettingResult).stubs().will(returnValue(HDCLOG_SUCCESSED));
    EXPECT_EQ(HDCLOG_SETTING_LEVEL_FAILED, IdeDeviceLogProcess(&handle, tmp, len));
    free(tmp);
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, ParseDeviceLogCmdTest1)
{
    HDC_SESSION session = (void*)100;
    char value[] = "data";
    uint len = sizeof(LogDataMsg)+strlen(value)+1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = MSG_MAX_LEN;

    cout<<tmp<<value<<endl;

    MOCKER(LogCmdRespSettingResult).stubs().will(returnValue(HDCLOG_SUCCESSED));
    EXPECT_EQ(HDCLOG_INIT_FAILED, ParseDeviceLogCmd(session, tmp));
    GlobalMockObject::reset();

    tmp->sliceLen = 0;
    MOCKER(LogCmdRespSettingResult).stubs().will(returnValue(HDCLOG_SUCCESSED));
    EXPECT_EQ(HDCLOG_INIT_FAILED, ParseDeviceLogCmd(session, tmp));
    GlobalMockObject::reset();

    free(tmp);
    tmp=NULL;
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, ParseDeviceLogCmdTest2)
{
    char value[] = "data";
    uint len = sizeof(LogDataMsg) + strlen(value) + 1;

    LogDataMsg* tmp = (LogDataMsg*)malloc(len);

    memcpy_s(tmp->data, strlen(value)+1, value, strlen(value)+1);
    tmp->reqType = IDE_LOG_LEVEL_REQ;
    tmp->devId = 0;
    tmp->sliceLen = strlen(value);

    HDC_SESSION session = (void*)100;

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    MOCKER(LogCmdRespSettingResult).stubs().will(returnValue(HDCLOG_SUCCESSED));
    EXPECT_EQ(HDCLOG_MSGQUEUE_RECV_FAILED, ParseDeviceLogCmd(session, tmp));
    GlobalMockObject::reset();

    MOCKER(memcpy_s).stubs().will(returnValue(EOK));
    MOCKER(LogCmdRespSettingResult).stubs().will(returnValue(HDCLOG_SUCCESSED));
    MOCKER(LogCmdSendLogMsg).stubs().will(returnValue(CONFIG_OK));
    EXPECT_EQ(HDCLOG_SUCCESSED, ParseDeviceLogCmd(session, tmp));
    GlobalMockObject::reset();

    free(tmp);
    tmp = NULL;
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IsContainsStr0)
{
    EXPECT_EQ(true, IsContainsStr("abcdef", "def"));
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, IsContainsStr1)
{
    EXPECT_EQ(false, IsContainsStr("abcdef", "efg"));
    GlobalMockObject::reset();
}

TEST_F(HDCLOG_DEVICE_INIT_TEST, RespSettingResultTest)
{
    HDC_SESSION session = (void*)100;
    const char* errMsg = "OK";

    MOCKER(AdxSendMsgByHandle).stubs().will(returnValue(-1));
    EXPECT_EQ(HDCLOG_WRITE_FAILED, LogCmdRespSettingResult(session, errMsg, strlen(errMsg)));
    GlobalMockObject::reset();

    MOCKER(AdxSendMsgByHandle).stubs().will(returnValue(0));
    EXPECT_EQ(HDCLOG_SUCCESSED, LogCmdRespSettingResult(session, errMsg, strlen(errMsg)));
    GlobalMockObject::reset();
}
