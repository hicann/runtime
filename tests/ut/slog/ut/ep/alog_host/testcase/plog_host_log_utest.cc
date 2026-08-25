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
#include "plog_host_log.h"
#include "plog_buffer_mgr.h"
#include "dlog_common.h"

extern "C" {
extern ToolThread g_alogFlushTid;
extern bool g_alogFlushStarting;
extern ToolMutex g_plogMutex;
void PlogAtForkCallback(int32_t type);
void PlogForkCallback(void);
int32_t PlogWriteCallback(const char* data, uint32_t dataLen, LogType type);
int32_t ToolCreateTaskWithThreadAttr(
    ToolThread* threadHandle, const ToolUserBlock* funcBlock, const ToolThreadAttr* threadAttr);
int32_t ToolJoinTask(const ToolThread* threadHandle);
}

static int32_t ToolCreateTaskWithThreadAttrStub(
    ToolThread* threadHandle, const ToolUserBlock* funcBlock, const ToolThreadAttr* threadAttr)
{
    (void)funcBlock;
    (void)threadAttr;
    *threadHandle = static_cast<ToolThread>(1);
    return SYS_OK;
}

static bool g_plogLockHeldDuringThreadCreate = false;

static int32_t ToolCreateTaskWithoutPlogLockStub(
    ToolThread* threadHandle, const ToolUserBlock* funcBlock, const ToolThreadAttr* threadAttr)
{
    (void)funcBlock;
    (void)threadAttr;
    int32_t ret = pthread_mutex_trylock(&g_plogMutex);
    g_plogLockHeldDuringThreadCreate = (ret == EBUSY);
    if (ret == SYS_OK) {
        (void)pthread_mutex_unlock(&g_plogMutex);
    }
    *threadHandle = static_cast<ToolThread>(1);
    return SYS_OK;
}

using namespace std;
using namespace testing;
class EP_PLOG_HOST_LOG_UTEST : public testing::Test {
protected:
    virtual void SetUp()
    {
        g_plogLockHeldDuringThreadCreate = false;
        system("rm -rf " PATH_ROOT "/*");
        ResetErrLog();
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test case");
    }

    virtual void TearDown()
    {
        system("rm -rf " PATH_ROOT "/*");
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test case");
        GlobalMockObject::verify();
    }

    static void SetUpTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("mkdir -p " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] Start exception test suite");
    }

    static void TearDownTestCase()
    {
        system("rm -rf " PATH_ROOT);
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End exception test suite");
    }

public:
};

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogHostLog_AsyncWrite)
{
    MOCKER(PlogBuffCheckFull).stubs().will(returnValue(true));
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    char msg[1024] = "test for sync write.";
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogHostMgrInitDoesNotStartFlushThread)
{
    MOCKER(ToolCreateTaskWithThreadAttr).expects(never()).will(returnValue(SYS_OK));

    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogWriteCallbackStartsFlushThreadOnlyOnce)
{
    MOCKER(ToolCreateTaskWithThreadAttr).expects(once()).will(invoke(ToolCreateTaskWithThreadAttrStub));
    MOCKER(ToolJoinTask).expects(once()).will(returnValue(SYS_OK));
    MOCKER(PlogBuffCheckFull).stubs().will(returnValue(false));
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    char msg[1024] = "test for async write.";
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogWriteCallbackStartsFlushThreadWithoutPlogLock)
{
    MOCKER(ToolCreateTaskWithThreadAttr).expects(once()).will(invoke(ToolCreateTaskWithoutPlogLockStub));
    MOCKER(ToolJoinTask).expects(once()).will(returnValue(SYS_OK));
    MOCKER(PlogBuffCheckFull).stubs().will(returnValue(false));
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    char msg[1024] = "test async write without plog lock.";
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    EXPECT_FALSE(g_plogLockHeldDuringThreadCreate);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogWriteCallbackRetriesAfterFlushThreadStartFailure)
{
    MOCKER(ToolCreateTaskWithThreadAttr)
        .expects(exactly(2))
        .will(returnValue(SYS_ERROR))
        .then(invoke(ToolCreateTaskWithThreadAttrStub));
    MOCKER(ToolJoinTask).expects(once()).will(returnValue(SYS_OK));
    MOCKER(PlogBuffCheckFull).stubs().will(returnValue(false));
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    char msg[1024] = "test async write retry after start failure.";
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogWriteCallbackSkipsStartWhenFlushThreadIsStarting)
{
    MOCKER(ToolCreateTaskWithThreadAttr).expects(never()).will(returnValue(SYS_OK));
    MOCKER(PlogBuffCheckFull).stubs().will(returnValue(false));
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    (void)__sync_lock_test_and_set(&g_alogFlushStarting, true);
    char msg[1024] = "test async write while flush thread is starting.";
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    EXPECT_TRUE(g_alogFlushStarting);
    (void)__sync_lock_test_and_set(&g_alogFlushStarting, false);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogForkCallbackResetsFlushThreadStartState)
{
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    g_alogFlushTid = static_cast<ToolThread>(1);
    (void)__sync_lock_test_and_set(&g_alogFlushStarting, true);
    PlogForkCallback();
    EXPECT_EQ(static_cast<ToolThread>(0), g_alogFlushTid);
    EXPECT_FALSE(g_alogFlushStarting);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, AtForkChildResetsFlushThreadStartState)
{
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    PlogAtForkCallback(ATFORK_PREPARE);
    g_alogFlushTid = static_cast<ToolThread>(1);
    (void)__sync_lock_test_and_set(&g_alogFlushStarting, true);
    PlogAtForkCallback(ATFORK_CHILD);
    EXPECT_EQ(static_cast<ToolThread>(0), g_alogFlushTid);
    EXPECT_FALSE(g_alogFlushStarting);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, AtForkAfterFlushThreadLazyStartDoesNotDeadlock)
{
    MOCKER(ToolCreateTaskWithThreadAttr).expects(once()).will(invoke(ToolCreateTaskWithThreadAttrStub));
    MOCKER(ToolJoinTask).expects(once()).will(returnValue(SYS_OK));
    MOCKER(PlogBuffCheckFull).stubs().will(returnValue(false));
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    char msg[1024] = "test fork after async write.";
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);

    PlogAtForkCallback(ATFORK_PREPARE);
    PlogAtForkCallback(ATFORK_PARENT);
    PlogHostMgrExit();
}

TEST_F(EP_PLOG_HOST_LOG_UTEST, PlogStartFlushThreadOnceDoubleCheckPreventsDuplicateThread)
{
    /* Simulate the TOCTOU race: Thread A passes first check, Thread B completes init,
     * Thread A's CAS succeeds but double-check on g_alogFlushTid should prevent duplicate thread. */
    MOCKER(ToolCreateTaskWithThreadAttr).expects(never()).will(returnValue(SYS_OK));
    MOCKER(PlogBuffCheckFull).stubs().will(returnValue(false));
    auto ret = PlogHostMgrInit();
    EXPECT_EQ(LOG_SUCCESS, ret);

    /* Pre-set g_alogFlushTid to simulate another thread completing init */
    g_alogFlushTid = static_cast<ToolThread>(1);
    char msg[1024] = "test TOCTOU double-check.";
    ret = PlogWriteCallback(msg, strlen(msg), DEBUG_LOG);
    EXPECT_EQ(LOG_SUCCESS, ret);
    EXPECT_EQ(static_cast<ToolThread>(1), g_alogFlushTid);
    g_alogFlushTid = static_cast<ToolThread>(0);
    PlogHostMgrExit();
}
