/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
extern "C"
{
    #include "log_queue.h"
    #include "log_common.h"
    #include "string.h"
    #include "log_daemon_ut_stub.h"
    #include "log_common.h"
    #include "log_config_api.h"
    #include "slog.h"
    #include "plog.h"
    #include "dlog_common.h"
    #include "dlog_time.h"
    #include "dlog_message.h"
    #include "log_ring_buffer.h"
    #include "log_level_parse.h"
    #include <signal.h>
    #include <execinfo.h>
    typedef struct LogCount {
        uint64_t ctrlLossCount;
        uint64_t coverLossCount;
        uint64_t errLossCount;
    } LogCount;
    void GetModuleLogLevelByIam(void);
    void GetGlobalLogLevelByIam(void);
    void DlogExitForIam(void);
    int CheckLogLevel(int moduleId, int level);
    int32_t DlogIamOpenService(void);
    void DlogGetTime(char *timeStr, unsigned int size);
    void ParseLogMsg(int moduleId, int level, LogMsg *logMsg);
    void *WriteLogByIamPeriodic();
    void DlogBufReInit(void);
    void SafeWritesByIam(void);
    void LogCtrlIncLogic();
    void LogCtrlDecLogic();
    void DlogInitEventLevelByEnv();
    void InitLogLevelByEnv();
    int32_t ConstructBaseMsg(char *msg, uint32_t msgLen, const LogMsgArg *msgArg);
    void dlog_init(void);
    extern void CountLogLoss(void);
    extern int32_t DlogIamOpenServiceFd(int32_t *fd);
    extern int32_t LogToIamLogBuf(const LogMsg *logMsg);
    extern int32_t SlogIamIoctl(int32_t fd, int32_t cmd, struct IAMIoctlArg *arg);
    extern void DlogWriteToBuf(const LogMsg *logMsg);
    extern int32_t DlogChildUnLock(void);
    extern bool DlogCheckBufValid(void);
    extern bool g_errorLogAppear;
    extern bool g_dlogIsInited;
};

#include "log_print.h"
#include "start_single_process.h"
#include "dlog_async_process.h"
#include "dlog_level_mgr.h"
#include "dlog_level_mgr.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

extern enum IAMResourceStatus g_iamResStatus;

using namespace std;
using namespace testing;

class SlogIamUtest : public testing::Test
{
protected:
    virtual void SetUp()
    {
        // a test SetUP
    }
    virtual void TearDown()
    {
        // a test TearDown
        // EXPECT_EQ(0, CheckMutex());
        GlobalMockObject::verify();
    }
};

TEST_F(SlogIamUtest, OpenIamServiceFd01)
{
    EXPECT_EQ(SYS_ERROR, DlogIamOpenService());
    GlobalMockObject::reset();
}

TEST_F(SlogIamUtest, OpenIamServiceFd_NOSUPPORT)
{
    MOCKER(ToolGetErrorCode).stubs().will(returnValue(EPROTONOSUPPORT));
    EXPECT_EQ(SYS_ERROR, DlogIamOpenService());
    GlobalMockObject::reset();
}

TEST_F(SlogIamUtest, DlogChildUnLock)
{
    MOCKER(pthread_mutex_unlock).stubs().will(returnValue(1));
    MOCKER(pthread_mutex_destroy).expects(once()).will(returnValue(0));
    EXPECT_EQ(1, DlogChildUnLock());
    GlobalMockObject::verify();
}

TEST_F(SlogIamUtest, LogBufLost_002)
{
    EXPECT_EQ(0, LogBufLost(NULL));
}

TEST_F(SlogIamUtest, CheckLogLevel01)
{
    MOCKER(DlogGetLogTypeLevelByModuleId).stubs().will(returnValue(DLOG_ERROR));
    EXPECT_EQ(TRUE, CheckLogLevel(10, DLOG_ERROR));
    GlobalMockObject::reset();
}

TEST_F(SlogIamUtest, CheckLogLevel02)
{
    EXPECT_EQ(FALSE, CheckLogLevel(-1, DLOG_ERROR));
    GlobalMockObject::reset();
}

TEST_F(SlogIamUtest, RegisterCallback)
{
    EXPECT_EQ(SUCCESS, RegisterCallback(NULL, LOG_WRITE));
}

TEST_F(SlogIamUtest, DlogSetlevel00) {
    EXPECT_EQ(SYS_OK, dlog_setlevel(0, 1, 1));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(0, 1, -1));
    EXPECT_EQ(SYS_ERROR, dlog_setlevel(0, 5, 1));
    EXPECT_EQ(SYS_OK, dlog_setlevel(-1, 1, 1));
}

TEST_F(SlogIamUtest, DlogReportInitialize)
{
    EXPECT_EQ(0, DlogReportInitialize());
}

TEST_F(SlogIamUtest, DlogReportFinalize)
{
    EXPECT_EQ(0, DlogReportFinalize());
}

TEST_F(SlogIamUtest, ConstructBaseMsg) {
    char msg[100];
    LogAttr attr;
    attr.type = APPLICATION;
    attr.pid = 1;
    attr.deviceId = 0;
    // moduleId: valid; level: valid
    LogMsgArg msgArg = { 0, 0, 3, 1, attr, "12345", nullptr };
    ConstructBaseMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[ERROR] SLOG(1,toolchain_hdclog_host_utest):12345 ", msg);
    // moduleId: valid; level: invalid
    msgArg.level = -1;
    ConstructBaseMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[-1] SLOG(1,toolchain_hdclog_host_utest):12345 ", msg);
    // moduleId: invalid; level: valid
    msgArg.moduleId = 100;
    ConstructBaseMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[-1] 100(1,toolchain_hdclog_host_utest):12345 ", msg);
    // moduleId: invalid; level: invalid
    msgArg.level = 3;
    ConstructBaseMsg(msg, 100, &msgArg);
    EXPECT_STREQ("[ERROR] 100(1,toolchain_hdclog_host_utest):12345 ", msg);
    GlobalMockObject::verify();
}
