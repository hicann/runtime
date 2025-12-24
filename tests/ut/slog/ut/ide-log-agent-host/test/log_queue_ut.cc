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
};

#include "start_single_process.h"

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

using namespace std;
using namespace testing;

class LogQueueUtest : public testing::Test
{
};

TEST_F(LogQueueUtest, LogQueueInitArgvNull)
{
    EXPECT_EQ(ARGV_NULL, LogQueueInit(NULL, 1));
}

TEST_F(LogQueueUtest, LogQueueInitSuccess)
{
    LogQueue logQueue;
    int deviceId = 0;
    EXPECT_EQ(SUCCESS, LogQueueInit(&logQueue, deviceId));
}

TEST_F(LogQueueUtest, LogQueueFreeSuccess)
{
    LogQueue logQueue;

    logQueue.uiCount = 2;

    LogNode* node1 = (LogNode*)malloc(sizeof(LogNode));
    node1->uiNodeNum = 10;
    node1->uiNodeDataLen = 100;
    node1->stNodeData = (void*)malloc(node1->uiNodeDataLen);
    node1->next = NULL;
    logQueue.stHead = node1;

    LogNode* node2 = (LogNode*)malloc(sizeof(LogNode));
    node2->uiNodeNum = 10;
    node2->uiNodeDataLen = 100;
    node2->stNodeData = (void*)malloc(node2->uiNodeDataLen);
    node2->next = NULL;
    node1->next = node2;
    logQueue.stRear = node2;

    EXPECT_EQ(SUCCESS, LogQueueFree(&logQueue, XFreeLogNode));

    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueFree2)
{
    LogQueue logQueue;

    logQueue.uiCount = 2;

    LogNode* node1 = (LogNode*)malloc(sizeof(LogNode));
    node1->uiNodeNum = 10;
    node1->uiNodeDataLen = 100;
    node1->stNodeData = (void*)malloc(node1->uiNodeDataLen);
    node1->next = NULL;
    logQueue.stHead = node1;

    LogNode* node2 = (LogNode*)malloc(sizeof(LogNode));
    node2->uiNodeNum = 10;
    node2->uiNodeDataLen = 100;
    node2->stNodeData = (void*)malloc(node2->uiNodeDataLen);
    node2->next = NULL;
    node1->next = node2;
    logQueue.stRear = node2;

    MOCKER(LogQueueDequeue).stubs().will(returnValue(LOG_RESERVED));
    EXPECT_EQ(SUCCESS, LogQueueFree(&logQueue, XFreeLogNode));
    free(node1->stNodeData);
    free(node1);
    free(node2->stNodeData);
    free(node2);

    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueDequeueArgvNull)
{
    LogQueue logQueue;
    EXPECT_EQ(ARGV_NULL, LogQueueDequeue(NULL, NULL));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueDequeueQueueIsNull)
{
    LogQueue logQueue;
    LogNode* node;
    logQueue.uiCount = 0;
    EXPECT_EQ(QUEUE_IS_NULL, LogQueueDequeue(&logQueue, &node));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueFullArgvNull)
{
    LogQueue logQueue;
    EXPECT_EQ(ARGV_NULL, LogQueueFull(NULL));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueFullQueueIsFull)
{
    LogQueue logQueue;
    logQueue.uiCount = MAX_QUEUE_COUNT + 1;
    EXPECT_EQ(QUEUE_IS_FULL, LogQueueFull(&logQueue));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueFullSuccess)
{
    GlobalMockObject::reset();
    LogQueue logQueue;
    logQueue.uiCount = MAX_QUEUE_COUNT - 1;
    logQueue.uiSize  = MAX_QUEUE_SIZE - 1;
    EXPECT_EQ(SUCCESS, LogQueueFull(&logQueue));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueNullArgvNull)
{
    LogQueue logQueue;
    EXPECT_EQ(ARGV_NULL, LogQueueNULL(NULL));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueNullSuccess)
{
    LogQueue logQueue;
    logQueue.uiCount = 1;
    logQueue.uiSize = 1;
    logQueue.stHead = (LogNode*)0x1;
    logQueue.stRear = (LogNode*)0x1;

    EXPECT_EQ(SUCCESS, LogQueueNULL(&logQueue));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueNullQueueIsNull)
{
    LogQueue logQueue;
    logQueue.uiCount = 0;

    EXPECT_EQ(QUEUE_IS_NULL, LogQueueNULL(&logQueue));
    GlobalMockObject::reset();
}


TEST_F(LogQueueUtest, LogQueueFreeArgvNull)
{
    LogNode logQueue;
    EXPECT_EQ(ARGV_NULL, LogQueueFree(NULL, NULL));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueEnqueueArgvNull)
{
    LogQueue logQueue;
    EXPECT_EQ(ARGV_NULL, LogQueueEnqueue(&logQueue, NULL));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueEnqueueQueueIsFull)
{
    LogQueue logQueue;
    logQueue.uiCount = MAX_QUEUE_COUNT + 1;
    LogNode node;
    EXPECT_EQ(QUEUE_IS_FULL, LogQueueEnqueue(&logQueue, &node));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueEnqueueQueueNullSuccess)
{
    LogQueue logQueue;
    LogQueueInit(&logQueue, 0);
    LogNode node;
    EXPECT_EQ(SUCCESS, LogQueueEnqueue(&logQueue, &node));
    GlobalMockObject::reset();
}

TEST_F(LogQueueUtest, LogQueueEnqueueQueueSuccess)
{
    LogQueue logQueue;

    logQueue.uiCount = 1;
    logQueue.uiSize = 1;

    LogNode logNode;
    logNode.uiNodeDataLen = 10;
    logNode.uiNodeNum = 1;
    logNode.stNodeData = NULL;
    logNode.next = NULL;

    logQueue.stRear = &logNode;

    EXPECT_EQ(SUCCESS, LogQueueEnqueue(&logQueue, &logNode));
    free(logNode.stNodeData);
    logNode.stNodeData = NULL;
    GlobalMockObject::reset();
}