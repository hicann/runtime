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
#include "atrace_types.h"
#include "ktrace_ts.h"
#include "trace_system_api.h"
#include "trace_session_mgr.h"
#include "ascend_hal_stub.h"
#include "trace_types.h"
#include "trace_node.h"

class TraceTsUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        Clear();
        system("mkdir -p " LLT_TEST_DIR );
    }

    void Clear()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
    }
    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

// ktrace ts
TEST_F(TraceTsUtest, KtraceTsMgr)
{
    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_null))
        .then(invoke(log_read_by_type_stub_start))
        .then(invoke(log_read_by_type_stub_middle))
        .then(invoke(log_read_by_type_stub_end))
        .then(invoke(log_read_by_type_stub_null));
    // session init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    // insert session node
    void *handle = malloc(10);
    int32_t pid = 10;
    int32_t devId = 0;
    int32_t timeout = 3000;
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle, pid, devId, timeout));

    // ts thread init
    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    sleep(3);

    // check node
    SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
    TraceNode *node = TraceTsPopNode(sessionNode);
    EXPECT_EQ(ADIAG_INFO_FLAG_START, node->flag);
    XFreeTraceNode(&node);
    node = TraceTsPopNode(sessionNode);
    EXPECT_EQ(ADIAG_INFO_FLAG_MID, node->flag);
    XFreeTraceNode(&node);
    node = TraceTsPopNode(sessionNode);
    EXPECT_EQ(ADIAG_INFO_FLAG_END, node->flag);
    XFreeTraceNode(&node);

    // ts thread exit
    KtraceTsDestroyThread();
    TraceServerSessionExit();
}

// ktrace ts
TEST_F(TraceTsUtest, KtraceTsMgrFailed)
{
    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);
    MOCKER(log_read_by_type).stubs().will(returnValue(-2)).then(returnValue(-1));
    // ts thread init
    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    sleep(3);
    // ts thread exit
    KtraceTsDestroyThread();
}

TEST_F(TraceTsUtest, KtraceTsGetDeviceIdFailed)
{
    uint32_t phyDevId = 1;
    MOCKER(drvGetDevIDByLocalDevID).stubs().with(any(),outBoundP(&phyDevId)).will(returnValue(1)).then(returnValue(DRV_ERROR_NONE));
    // ts thread init
    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);
    MOCKER(log_read_by_type).stubs().will(invoke(log_read_by_type_stub_null));
    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    sleep(3);
    // ts thread exit
    KtraceTsDestroyThread();
}

using TestTsFunc = std::function<void(void)>;
static void TestKtraceTsProcess(TestTsFunc func)
{
    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);
    // session init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    // insert session node
    void *handle = malloc(10);
    int32_t timeout = 3000;
    int32_t pid = 10;
    int32_t devId = 0;
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle, pid, devId, timeout));

    // ts thread init
    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    sleep(3);

    // Check
    func();
    // ts thread exit
    KtraceTsDestroyThread();
    TraceServerSessionExit();
}

TEST_F(TraceTsUtest, KtraceTsMgrProcessSprintfFailed)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_start))
        .then(invoke(log_read_by_type_stub_end))
        .then(invoke(log_read_by_type_stub_null));
    MOCKER(vsprintf_s).stubs().will(returnValue(-1));

    TestKtraceTsProcess([](void) -> void {
        int32_t pid = 10;
        int32_t devId = 0;
        SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
        TraceNode *node = TraceTsPopNode(sessionNode);
        EXPECT_EQ(nullptr, node);
    });
}

TEST_F(TraceTsUtest, KtraceTsMgrProcessStrncpyFailed)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_start))
        .then(invoke(log_read_by_type_stub_end))
        .then(invoke(log_read_by_type_stub_null));
    MOCKER(strncpy_s).stubs().will(returnValue(EOK + 1));
    TestKtraceTsProcess([](void) -> void {
        int32_t pid = 10;
        int32_t devId = 0;
        SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
        TraceNode *node = TraceTsPopNode(sessionNode);
        EXPECT_EQ(nullptr, node);
    });
}

TEST_F(TraceTsUtest, KtraceTsMgrProcessMemcpyFailed)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_start))
        .then(invoke(log_read_by_type_stub_end))
        .then(invoke(log_read_by_type_stub_null));
    MOCKER(memcpy_s).stubs().will(returnValue(EOK + 1));
    TestKtraceTsProcess([](void) -> void {
        int32_t pid = 10;
        int32_t devId = 0;
        SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
        TraceNode *node = TraceTsPopNode(sessionNode);
        EXPECT_EQ(nullptr, node);
    });
}

TEST_F(TraceTsUtest, KtraceTsMgrProcessLocalIdFailed)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_null));
    MOCKER(drvGetDevIDByLocalDevID).stubs().will(returnValue(DRV_ERROR_NONE + 1));
    MOCKER(mmSetCurrentThreadName).stubs().will(returnValue(TRACE_FAILURE));
    TestKtraceTsProcess([](void) -> void {
        int32_t pid = 10;
        int32_t devId = 0;
        SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
        TraceNode *node = TraceTsPopNode(sessionNode);
        EXPECT_EQ(nullptr, node);
    });
}

TEST_F(TraceTsUtest, KtraceTsMgrProcessSnprintfFailed)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_start))
        .then(invoke(log_read_by_type_stub_end))
        .then(invoke(log_read_by_type_stub_null));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    TestKtraceTsProcess([](void) -> void {
        int32_t pid = 10;
        int32_t devId = 0;
        SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
        TraceNode *node = TraceTsPopNode(sessionNode);
        EXPECT_EQ(nullptr, node);
    });
}

TEST_F(TraceTsUtest, KtraceTsMgrProcessNodeFull)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_size_over));

    TestKtraceTsProcess([](void) -> void {
        int32_t pid = 10;
        int32_t devId = 0;
        SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
        TraceNode *node;
        for (int32_t i = 0; i < MAX_QUEUE_COUNT; i++) {
            node = TraceTsPopNode(sessionNode);
            EXPECT_EQ(ADIAG_INFO_FLAG_END, node->flag);
            XFreeTraceNode(&node);
        }
        node = TraceTsPopNode(sessionNode);
        EXPECT_EQ(nullptr, node);
    });
}

TEST_F(TraceTsUtest, KtraceTsMgrThreadMallocFailed)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_size_over))
        .then(invoke(log_read_by_type_stub_size_over))
        .then(invoke(log_read_by_type_stub_null));
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));

    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);

    EXPECT_EQ(TRACE_FAILURE, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
}

TEST_F(TraceTsUtest, KtraceTsMgrNotSupport)
{
    MOCKER(log_read_by_type).stubs().will(returnValue((int32_t)LOG_NOT_SUPPORT));

    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);

    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    sleep(1);

    // ts thread exit
    KtraceTsDestroyThread();
}

TEST_F(TraceTsUtest, KtraceTsMgrThreadExist)
{
    MOCKER(log_read_by_type).stubs().will(invoke(log_read_by_type_stub_null));

    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);

    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    EXPECT_EQ(TRACE_FAILURE, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    sleep(1);

    // ts thread exit
    KtraceTsDestroyThread();
}

TEST_F(TraceTsUtest, KtraceTsMgrThreadReadInvalid)
{
    MOCKER(log_read_by_type).stubs()
        .will(invoke(log_read_by_type_stub_null))
        .then(invoke(log_read_by_type_stub_invalid))
        .then(invoke(log_read_by_type_stub_null));

    uint32_t devNum = 0;
    uint32_t deviceId[64] = { 0 };
    (void)halGetDevNumEx(0, &devNum);
    (void)halGetDevIDsEx(0, deviceId, 64);

    EXPECT_EQ(TRACE_SUCCESS, KtraceTsCreateThread((uint32_t)devNum, (uint32_t *)deviceId));
    sleep(1);

    // ts thread exit
    KtraceTsDestroyThread();
}