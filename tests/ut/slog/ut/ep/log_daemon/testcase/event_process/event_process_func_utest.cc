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
using namespace std;
using namespace testing;

#include "self_log_stub.h"
#include "event_process_core.h"

class EP_EVENT_PROCESS_FUNC_UTEST : public testing::Test
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

void EventProc(void *arg)
{
    (*(int32_t *)arg)++;
    return;
}

TEST_F(EP_EVENT_PROCESS_FUNC_UTEST, EventThreadCreate)
{
    EXPECT_EQ(LOG_SUCCESS, EventThreadCreate());

    // REAL_TIME_EVENT
    EventAttr attr1 = { REAL_TIME_EVENT, 0 };
    int32_t count1 = 0;
    EventHandle handle1 = EventAdd(EventProc, (void *)&count1, &attr1);
    EXPECT_NE(handle1, nullptr);

    // LOOP_TIME_EVENT
    EventAttr attr2 = { LOOP_TIME_EVENT, 100 };
    int32_t count2 = 0;
    EventHandle handle2 = EventAdd(EventProc, (void *)&count2, &attr2);
    EXPECT_NE(handle2, nullptr);

    // DELAY_TIME_EVENT
    EventAttr attr3 = { DELAY_TIME_EVENT, 200 };
    int32_t count3 = 0;
    EventHandle handle3 = EventAdd(EventProc, (void *)&count3, &attr3);
    EXPECT_NE(handle3, nullptr);

    usleep(300000);
    EXPECT_EQ(count1, 1);
    EXPECT_GE(count2, 2);
    EXPECT_EQ(count3, 1);
    EXPECT_EQ(0, GetErrLogNum());
    EventThreadRelease();
}

TEST_F(EP_EVENT_PROCESS_FUNC_UTEST, EventAdd)
{
    // REAL_TIME_EVENT
    EventAttr attr1 = { REAL_TIME_EVENT, 0 };
    int32_t count1 = 0;
    EventHandle handle1 = EventAdd(EventProc, (void *)&count1, &attr1);
    EXPECT_NE(handle1, nullptr);

    // LOOP_TIME_EVENT
    EventAttr attr2 = { LOOP_TIME_EVENT, 1000 };
    int32_t count2 = 0;
    EventHandle handle2 = EventAdd(EventProc, (void *)&count2, &attr2);
    EXPECT_NE(handle2, nullptr);

    // DELAY_TIME_EVENT
    EventAttr attr3 = { DELAY_TIME_EVENT, 1000 };
    int32_t count3 = 0;
    EventHandle handle3 = EventAdd(EventProc, (void *)&count3, &attr3);
    EXPECT_NE(handle3, nullptr);

    EXPECT_EQ(LOG_SUCCESS, EventDelete(handle1));
    EXPECT_EQ(LOG_SUCCESS, EventDelete(handle2));
    EXPECT_EQ(LOG_SUCCESS, EventDelete(handle3));
    EXPECT_EQ(0, GetErrLogNum());
}

TEST_F(EP_EVENT_PROCESS_FUNC_UTEST, EventMulti)
{
    EXPECT_EQ(LOG_SUCCESS, EventThreadCreate());

    // REAL_TIME_EVENT
    int32_t count[100] = { 0 };
    EventHandle handle[100] = { 0 };
    EventAttr attr = { REAL_TIME_EVENT, 0 };
    for (int32_t i = 0; i < 100; i++) {
        handle[i] = EventAdd(EventProc, (void *)&count[i], &attr);
        EXPECT_NE(handle[i], nullptr);
    }
    usleep(200000);
    for (int32_t i = 0; i < 100; i++) {
        EXPECT_EQ(1, count[i]);
        count[i] = 0;
        EXPECT_EQ(LOG_FAILURE, EventDelete(handle[i]));
    }

    attr.type = DELAY_TIME_EVENT;
    attr.periodTime = 100;
    for (int32_t i = 0; i < 100; i++) {
        handle[i] = EventAdd(EventProc, (void *)&count[i], &attr);
        EXPECT_NE(handle[i], nullptr);
    }
    usleep(200000);
    for (int32_t i = 0; i < 100; i++) {
        EXPECT_EQ(1, count[i]);
        count[i] = 0;
        EXPECT_EQ(LOG_FAILURE, EventDelete(handle[i]));
    }

    attr.type = LOOP_TIME_EVENT;
    attr.periodTime = 100;
    for (int32_t i = 0; i < 100; i++) {
        handle[i] = EventAdd(EventProc, (void *)&count[i], &attr);
        EXPECT_NE(handle[i], nullptr);
    }
    usleep(300000);
    for (int32_t i = 0; i < 100; i++) {
        EXPECT_LE(2, count[i]);
        count[i] = 0;
        EXPECT_EQ(LOG_SUCCESS, EventDelete(handle[i]));
    }
    EXPECT_EQ(0, GetErrLogNum());
    EventThreadRelease();
}

TEST_F(EP_EVENT_PROCESS_FUNC_UTEST, EventAddFailed)
{
    EXPECT_EQ(nullptr, EventAdd(nullptr, nullptr, nullptr));
    EXPECT_EQ(LOG_FAILURE, EventDelete(nullptr));
    EventAttr attr = { MAX_EVENT_TYPE, 0 };
    EXPECT_EQ(nullptr, EventAdd(EventProc, nullptr, &attr));
}

TEST_F(EP_EVENT_PROCESS_FUNC_UTEST, EventDelete)
{
    EventAttr attr = { LOOP_TIME_EVENT, 100 };
    EventHandle handle[10] = { 0 };
    int32_t count[10] = { 0 };
    for (int32_t i = 0; i < 10; i++) {
        handle[i] = EventAdd(EventProc, (void *)&count[i], &attr);
        EXPECT_NE(handle[i], nullptr);
    }
    for (int32_t i = 9; i >= 0; i--) {
        EXPECT_EQ(LOG_SUCCESS, EventDelete(handle[i]));
    }
    EXPECT_EQ(0, GetErrLogNum());
}