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
#include "trace_system_api.h"
#include "trace_session_mgr.h"
#include "trace_queue.h"
#include "trace_types.h"
#include "trace_node.h"
#include "adcore_api.h"

class TraceSessionUtest: public testing::Test {
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

// session mgr
static void TraceServerFuncStub(SessionNode *sessionNode, int8_t listFlag)
{
    return;
}
 
TEST_F(TraceSessionUtest, KtraceSessionMgr)
{
    // session node init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // insert session node
    void *handle1 = malloc(10);
    int32_t pid1 = 10;
    int32_t devId1 = 0;
    int32_t timeout1 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid1, devId1));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle1, pid1, devId1, timeout1));
    SessionNode *sessionNode = TraceServerGetSessionNode(pid1, devId1);
    EXPECT_EQ(pid1, sessionNode->pid);
    EXPECT_EQ(devId1, sessionNode->devId);
    EXPECT_EQ(timeout1, sessionNode->timeout);
    EXPECT_EQ(false, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());

    void *handle2 = malloc(10);
    int32_t pid2 = 0;
    int32_t devId2 = 0;
    int32_t timeout2 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid2, devId2));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle2, pid2, devId2, timeout2));
 
    // session node handle
    MOCKER(TraceServerFuncStub).expects(exactly(62));
    TraceServerHandleSessionNode(TraceServerFuncStub);
    // delete session node
    EXPECT_EQ(TRACE_SUCCESS, TraceServerDeleteSessionNode(handle1, pid1, devId1));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerDeleteSessionNode(handle2, pid2, devId2));
    for (int32_t i = 0; i < 30; i++) {
        TraceServerHandleDeletedSessionNode(TraceServerFuncStub);
        TraceServerHandleSessionNode(TraceServerFuncStub);
    }
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // session node exit
    TraceServerSessionExit();
}

TEST_F(TraceSessionUtest, KtraceSessionMgrWithNodeLeft)
{
    // session node init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // insert session node
    void *handle = malloc(10);
    int32_t pid = 10;
    int32_t devId = 0;
    int32_t timeout = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid, devId));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle, pid, devId, timeout));
    SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
    EXPECT_EQ(pid, sessionNode->pid);
    EXPECT_EQ(devId, sessionNode->devId);
    EXPECT_EQ(timeout, sessionNode->timeout);
    EXPECT_EQ(false, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // session node exit
    TraceServerSessionExit();
}

TEST_F(TraceSessionUtest, KtraceSessionMgrWithDeletedNodeLeft)
{
    // session node init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // insert session node
    void *handle = malloc(10);
    int32_t pid = 10;
    int32_t devId = 0;
    int32_t timeout = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid, devId));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle, pid, devId, timeout));
    SessionNode *sessionNode = TraceServerGetSessionNode(pid, devId);
    EXPECT_EQ(pid, sessionNode->pid);
    EXPECT_EQ(devId, sessionNode->devId);
    EXPECT_EQ(timeout, sessionNode->timeout);
    EXPECT_EQ(false, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());

    // delete session node
    EXPECT_EQ(TRACE_SUCCESS, TraceServerDeleteSessionNode(handle, pid, devId));
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(false, TraceIsDeletedSessionNodeListNull());
 
    // session node exit
    TraceServerSessionExit();
}

TEST_F(TraceSessionUtest, KtraceSessionMgrHandleInvalid)
{
    // session node init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // insert session node
    void *handle1 = malloc(10);
    int32_t pid1 = 10;
    int32_t devId1 = 0;
    int32_t timeout1 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid1, devId1));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle1, pid1, devId1, timeout1));
    SessionNode *sessionNode = TraceServerGetSessionNode(pid1, devId1);
    EXPECT_EQ(pid1, sessionNode->pid);
    EXPECT_EQ(devId1, sessionNode->devId);
    EXPECT_EQ(timeout1, sessionNode->timeout);
    EXPECT_EQ(false, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());

    void *handle2 = malloc(10);
    int32_t pid2 = 0;
    int32_t devId2 = 0;
    int32_t timeout2 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid2, devId2));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle2, pid2, devId2, timeout2));
 
    // session node handle
    MOCKER(TraceServerFuncStub).expects(exactly(0));
    MOCKER(AdxGetAttrByCommHandle).stubs().will(returnValue(TRACE_FAILURE));
    TraceServerHandleSessionNode(TraceServerFuncStub);
    for (int32_t i = 0; i < 30; i++) {
        TraceServerHandleDeletedSessionNode(TraceServerFuncStub);
        TraceServerHandleSessionNode(TraceServerFuncStub);
    }
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // session node exit
    TraceServerSessionExit();
}

TEST_F(TraceSessionUtest, TraceGetSessionNodeInvalidInput)
{
    EXPECT_EQ(NULL, TraceServerGetSessionNode(-1, -1));
}

TEST_F(TraceSessionUtest, TraceGetSessionNodeInsertFailed)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceServerInsertSessionNode(NULL, -1, -1, -1));
    
    void *handle = malloc(10);
    int32_t timeout = 3000;
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle, 10, 0, timeout));
    EXPECT_EQ(TRACE_FAILURE, TraceServerInsertSessionNode(handle, 10, 0, timeout));

    void *sessionNode = malloc(sizeof(SessionNode));
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL)).then(returnValue(sessionNode)).then(returnValue((void *)NULL));
    EXPECT_EQ(TRACE_FAILURE, TraceServerInsertSessionNode(handle, 0, 0, timeout));
    EXPECT_EQ(TRACE_FAILURE, TraceServerInsertSessionNode(handle, 0, 0, timeout));
    TraceServerSessionExit();
}

TEST_F(TraceSessionUtest, TraceDeleteSessionNodeInvalidInput)
{
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceServerDeleteSessionNode(NULL, -1, -1));
}

// queue mgr
TEST_F(TraceSessionUtest, KtraceQueueMgr)
{
    // queue init
    TraceQueue *queue = (TraceQueue *)malloc(sizeof(TraceQueue));
    EXPECT_EQ(TRACE_SUCCESS, TraceQueueInit(queue));
 
    // enqueue & dequeue
    TraceNode *nodeDequeue = NULL;
    EXPECT_EQ(TRACE_QUEUE_NULL, TraceQueueDequeue(queue, &nodeDequeue));
    EXPECT_EQ(NULL, nodeDequeue);
 
    TraceNode *nodeEnqueue1 = (TraceNode *)malloc(sizeof(TraceNode));
    nodeEnqueue1->flag = 0;
    void *data1 = malloc(1024);
    char msg1[1024] = "test queue mgr1.";
    memcpy_s(data1, 1024, msg1, 1023);
    nodeEnqueue1->data = data1;
    nodeEnqueue1->dataLen = 1024;
    nodeEnqueue1->next = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceQueueEnqueue(queue, nodeEnqueue1));
 
    TraceNode *nodeEnqueue2 = (TraceNode *)malloc(sizeof(TraceNode));
    nodeEnqueue2->flag = 0;
    void *data2 = malloc(1024);
    char msg2[1024] = "test queue mgr2.";
    memcpy_s(data2, 1024, msg2, 1023);
    nodeEnqueue2->data = data2;
    nodeEnqueue2->dataLen = 1024;
    nodeEnqueue2->next = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceQueueEnqueue(queue, nodeEnqueue2));
 
    EXPECT_EQ(TRACE_SUCCESS, TraceQueueDequeue(queue, &nodeDequeue));
    EXPECT_EQ(nodeEnqueue1->flag, nodeDequeue->flag);
    EXPECT_EQ(nodeEnqueue1->data, nodeDequeue->data);
    EXPECT_EQ(nodeEnqueue1->dataLen, nodeDequeue->dataLen);
    EXPECT_EQ(nodeEnqueue1->next, nodeDequeue->next);
    XFreeTraceNode(&nodeEnqueue1);
 
    // queue free
    EXPECT_EQ(TRACE_SUCCESS, TraceQueueFree(queue));
    free(queue);
    queue = NULL;
}
 
// node mgr
TEST_F(TraceSessionUtest, KtraceNodeMgr)
{
    // init
    SessionNode *sessionNode = (SessionNode *)malloc(sizeof(SessionNode));
    memset_s(sessionNode, sizeof(SessionNode), 0, sizeof(SessionNode));
    sessionNode->queue = (TraceQueue *)malloc(sizeof(TraceQueue));
    memset_s(sessionNode->queue, sizeof(TraceQueue), 0, sizeof(TraceQueue));
    EXPECT_EQ(TRACE_SUCCESS, TraceQueueInit(sessionNode->queue));
 
    TraceNode *node = TraceTsPopNode(sessionNode);
    EXPECT_EQ(NULL, node);
 
    // push node
    int8_t flag = 0;
    char *data = (char *)malloc(1024);
    snprintf_s(data, 1024, 1023, "test node mgr.");
    uint32_t len = 1024;
    EXPECT_EQ(TRACE_SUCCESS, TraceTsPushNode(sessionNode, flag, data, len));
    // pop node
    node = TraceTsPopNode(sessionNode);
    EXPECT_EQ(flag, node->flag);
    EXPECT_EQ(data, node->data);
    EXPECT_EQ(len, node->dataLen);
    EXPECT_EQ(NULL, node->next);
 
    //exit
    XFreeTraceNode(&node);
    free(sessionNode->queue);
    free(sessionNode);
    sessionNode = NULL;
}

TEST_F(TraceSessionUtest, KtraceNodeMgrInputInvalid)
{
    // invalid sessionNode
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceTsPushNode((SessionNode *)NULL, 0, (char *)NULL, 0));
    EXPECT_EQ((TraceNode*)NULL, TraceTsPopNode((SessionNode *)NULL));


    // invalid queue
    SessionNode *sessionNode = (SessionNode *)malloc(sizeof(SessionNode));
    memset_s(sessionNode, sizeof(SessionNode), 0, sizeof(SessionNode));
    char *data = (char *)malloc(1024);
    snprintf_s(data, 1024, 1023, "test node mgr.");
    uint32_t len = 1024;
    EXPECT_EQ(TRACE_FAILURE, TraceTsPushNode(sessionNode, 0, data, len));
    EXPECT_EQ((TraceNode*)NULL, TraceTsPopNode(sessionNode));
    free(data);
    data = NULL;
    free(sessionNode->queue);
    free(sessionNode);
}

TEST_F(TraceSessionUtest, KtraceNodeMgrMallocFailed)
{
    // invalid sessionNode
    SessionNode sessionNode = { 0 };
    char data[10];
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(TRACE_FAILURE, TraceTsPushNode(&sessionNode, 0, data, 0));
    EXPECT_EQ((TraceNode*)NULL, TraceTsPopNode(&sessionNode));
}