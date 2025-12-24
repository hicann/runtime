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
#include "log_system_api.h"
#include "log_session_manage.h"
#include "log_drv.h"
#include "log_common.h"
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
}

#include "log_print.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "slogd_flush.h"
#include "log_file_util.h"

class SlogdLogSessionManage : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};

void SlogdLogSessionManage::SetUp()
{
}

void SlogdLogSessionManage::TearDown()
{
}

TEST_F(SlogdLogSessionManage, HandleSessionNode)
{

    MOCKER(ToolMutexInit).stubs().will(returnValue(-1));
    int ret = InitSessionList();
    EXPECT_EQ(51, ret);
    GlobalMockObject::reset();

    ret = InitSessionList();
    EXPECT_EQ(0, ret);
    uintptr_t session = 123;
    int pid = 100;
    int devId = 0;
    int invalidDevId = GLOBAL_MAX_DEV_NUM;
    uintptr_t session1 = 176;
    int pid1 = 101;
    int devId1 = 0;
    uintptr_t session2 = 134;
    int pid2 = 102;
    int devId2 = 0;
    uintptr_t session3 = 144;
    int pid3 = 103;
    int devId3 = 0;

    ret = DeleteSessionNode(session, pid, devId);
    EXPECT_EQ(1, ret);

    ret = InsertSessionNode(session3, pid3, devId3);
    EXPECT_EQ(0, ret);

    EXPECT_EQ(false, IsSessionNodeListNull());

    ret = InsertSessionNode(session2, pid2, devId2);
    EXPECT_EQ(0, ret);

    ret = InsertSessionNode(session1, pid1, devId1);
    EXPECT_EQ(0, ret);

    ret = InsertSessionNode(session, pid, devId);
    EXPECT_EQ(0, ret);

    ret = InsertSessionNode(session, pid, invalidDevId);
    EXPECT_EQ(1, ret);

    MOCKER(malloc).stubs().will(returnValue((void*)NULL));
    ret = InsertSessionNode(session, pid, devId);
    EXPECT_EQ(4, ret);
    GlobalMockObject::reset();

    SessionNode* node = GetSessionNode(pid, invalidDevId);
    EXPECT_EQ(NULL, node);
    node = GetSessionNode(pid, devId);
    EXPECT_EQ(node->session, 123);

    ret = DeleteSessionNode(session, pid, invalidDevId);
    EXPECT_EQ(1, ret);
    ret = DeleteSessionNode(session1, pid1, devId1);
    EXPECT_EQ(0, ret);
    ret = DeleteSessionNode(session, pid, devId);
    EXPECT_EQ(0, ret);

    SessionNode* deleteNode = GetDeletedSessionNode(pid, devId);
    EXPECT_EQ(deleteNode->session, 123);

    deleteNode = PopDeletedSessionNode();
    EXPECT_EQ(deleteNode->session, session);
    EXPECT_EQ(deleteNode->next->session, session1);

    ret = DeleteSessionNode(session2, pid2, devId2);
    EXPECT_EQ(0, ret);
    ret = DeleteSessionNode(session3, pid3, devId3);
    EXPECT_EQ(0, ret);

    PushDeletedSessionNode(deleteNode);
    FreeSessionList();
}

TEST_F(SlogdLogSessionManage, HandleInvalidSessionNode01)
{
    int ret = InitSessionList();
    EXPECT_EQ(0, ret);

    uintptr_t session1 = 176;
    int pid1 = 101;
    int devId1 = 0;
    uintptr_t session2 = 134;
    int pid2 = 102;
    int devId2 = 0;
    uintptr_t session3 = 144;
    int pid3 = 103;
    int devId3 = 0;

    ret = InsertSessionNode(session3, pid3, devId3);
    EXPECT_EQ(0, ret);

    ret = InsertSessionNode(session2, pid2, devId2);
    EXPECT_EQ(0, ret);

    ret = InsertSessionNode(session1, pid1, devId1);
    EXPECT_EQ(0, ret);

    MOCKER(DrvBufWrite).stubs().will(returnValue(0));
    ret = SendDataToSessionNode(101, 0, "value", 5);
    EXPECT_EQ(0, ret);

    MOCKER(DrvDevIdGetBySession).stubs().will(returnValue(1)).then(returnValue(0));
    HandleInvalidSessionNode();
    FreeSessionList();
    GlobalMockObject::reset();
}

TEST_F(SlogdLogSessionManage, HandleInvalidSessionNode02)
{
    int ret = InitSessionList();
    EXPECT_EQ(0, ret);

    uintptr_t session1 = 176;
    int pid1 = 101;
    int devId1 = 0;
    uintptr_t session2 = 134;
    int pid2 = 102;
    int devId2 = 0;
    uintptr_t session3 = 144;
    int pid3 = 103;
    int devId3 = 0;

    ret = InsertSessionNode(session3, pid3, devId3);
    EXPECT_EQ(0, ret);

    ret = InsertSessionNode(session2, pid2, devId2);
    EXPECT_EQ(0, ret);

    ret = InsertSessionNode(session1, pid1, devId1);
    EXPECT_EQ(0, ret);

    MOCKER(DrvDevIdGetBySession).stubs().will(returnValue(0)).then(returnValue(1));
    HandleInvalidSessionNode();
    FreeSessionList();
    GlobalMockObject::reset();
}
