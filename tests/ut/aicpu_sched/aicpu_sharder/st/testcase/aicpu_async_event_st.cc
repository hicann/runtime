/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_async_event.h"
#include "aicpu_context.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include <stdio.h>


using namespace aicpu;
using namespace std;

class AicpuAsyncEventTest : public ::testing::Test {
public:
    virtual void SetUp()
    {
        AsyncEventManager::GetInstance().Register(notifyWait);
        aicpu::SetAicpuThreadIndex(0);
        SetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_ID, "111");
        SetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_TYPE, "1");
    }

    virtual void TearDown()
    {}
protected:
    static void notifyWait(void *notifyParam, const uint32_t paramLen) {
        notify_cnt++;
    }
protected:
    static uint32_t notify_cnt;
};

uint32_t AicpuAsyncEventTest::notify_cnt = 0;
AsyncNotifyInfo notify_info = {0};


TEST_F(AicpuAsyncEventTest, NotifyWaitTest)
{
    void *param = reinterpret_cast<void *>(&notify_info);
    AsyncEventManager::GetInstance().NotifyWait(param, sizeof(AsyncNotifyInfo));
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 1);
}

TEST_F(AicpuAsyncEventTest, RegEventCbSuccess)
{
    auto cb = [](void *param){
        AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };
    EXPECT_TRUE(AsyncEventManager::GetInstance().RegEventCb(1, 111, cb));
    AsyncEventManager::GetInstance().ProcessEvent(1, 111);
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 2);
}

TEST_F(AicpuAsyncEventTest, RegEventCbDuplicate)
{
    auto cb = [](void *param){
        AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };

    EXPECT_TRUE(AsyncEventManager::GetInstance().RegEventCb(2, 111, cb));
    EXPECT_FALSE(AsyncEventManager::GetInstance().RegEventCb(2, 111, cb));
}

TEST_F(AicpuAsyncEventTest, ProcessEventNotFound)
{
    auto cb = [](void *param){
        AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };

    EXPECT_TRUE(AsyncEventManager::GetInstance().RegEventCb(3, 111, cb));
    // not found
    AsyncEventManager::GetInstance().ProcessEvent(3, 112);
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 2);
}

TEST_F(AicpuAsyncEventTest, ProcessEventSuccess)
{
    auto cb = [](void *param){
        AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };

    EXPECT_TRUE(AsyncEventManager::GetInstance().RegEventCb(4, 111, cb));
    AsyncEventManager::GetInstance().ProcessEvent(4, 111);
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 3);
    AsyncEventManager::GetInstance().ProcessEvent(4, 112);
    AsyncEventManager::GetInstance().UnregEventCb(4, 111);
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 3);
}

TEST_F(AicpuAsyncEventTest, AicpuNotifyWaitTest) {
    void *param = reinterpret_cast<void *>(&notify_info);
    AicpuNotifyWait(param, sizeof(AsyncNotifyInfo));
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 4);
}

TEST_F(AicpuAsyncEventTest, AicpuRegEventCbTest) {
    auto cb = [](void *param){
        AicpuNotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };
    EXPECT_TRUE(AicpuRegEventCb(5, 111, cb));
    AsyncEventManager::GetInstance().ProcessEvent(5, 111);
    AicpuUnregEventCb(5, 111);
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 5);
}

TEST_F(AicpuAsyncEventTest, AicpuRegEventCbErrorTest) {
    auto cb = [](void *param){
        AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };

    status_t ret = SetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_ID, "WAIT_ID");
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    bool result = AsyncEventManager::GetInstance().RegEventCb(4, 111, cb);
    EXPECT_EQ(result, false);

    ret = SetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_ID, "111");
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    ret = SetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_TYPE, "WAIT_TYPE");
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
    result = AsyncEventManager::GetInstance().RegEventCb(4, 111, cb);
    EXPECT_EQ(result, false);
    ret = SetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_TYPE, "1");
    EXPECT_EQ(ret, AICPU_ERROR_NONE);
}

TEST_F(AicpuAsyncEventTest, RegOpEventCb)
{
    GlobalMockObject::verify();
    // fail for cb is null
    EXPECT_FALSE(AsyncEventManager::GetInstance().RegOpEventCb(5, 20, nullptr));

    aicpu::SetTaskAndStreamId(1U, 2U);
    aicpu::SetAicpuThreadIndex(0U);

    auto cb = [](void *param){
        AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };
    EXPECT_TRUE(AsyncEventManager::GetInstance().RegOpEventCb(5, 20, cb));

    // fail for repeated register
    EXPECT_FALSE(AsyncEventManager::GetInstance().RegOpEventCb(5, 20, cb));

    // register 2nd one
    aicpu::SetAicpuThreadIndex(1U);
    EXPECT_TRUE(AsyncEventManager::GetInstance().RegOpEventCb(5, 20, cb));

    AsyncEventManager::GetInstance().ProcessOpEvent(5, 20, nullptr);
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 7); // 2 cb

    // unregister the 2nd cb
    AsyncEventManager::GetInstance().UnregOpEventCb(5, 20);
    // unregister unknown cb
    aicpu::SetAicpuThreadIndex(3U);
    AsyncEventManager::GetInstance().UnregOpEventCb(5, 20);
    // unregister the 1st cb
    aicpu::SetAicpuThreadIndex(0U);
    AsyncEventManager::GetInstance().UnregOpEventCb(5, 20);

    AsyncEventManager::GetInstance().ProcessOpEvent(5, 20, nullptr);
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 7);

    // unregister when there's no cbs
    AsyncEventManager::GetInstance().UnregOpEventCb(5, 20);

    AsyncEventManager::GetInstance().ProcessOpEvent(5, 20, nullptr);
    // notify_cnt not change for all cbs hava been unregistered
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 7);
}

TEST_F(AicpuAsyncEventTest, RegOpEventCbInterface)
{
    GlobalMockObject::verify();
    aicpu::SetTaskAndStreamId(1U, 1U);
    aicpu::SetAicpuThreadIndex(0U);
    auto cb = [](void *param){
        AsyncEventManager::GetInstance().NotifyWait(reinterpret_cast<void *>(&notify_info), sizeof(AsyncNotifyInfo));
    };
    EXPECT_TRUE(AicpuRegOpEventCb(5, 20, cb));
    aicpu::SetTaskAndStreamId(2U, 1U);
    EXPECT_TRUE(AicpuRegOpEventCb(5, 20, cb));

    aicpu::SetTaskAndStreamId(2U, 3U);
    EXPECT_TRUE(AicpuRegOpEventCb(5, 20, cb));
    AicpuUnregOpEventCb(5, 20);

    aicpu::SetTaskAndStreamId(2U, 1U);
    AicpuUnregOpEventCb(5, 20);
    aicpu::SetTaskAndStreamId(1U, 1U);
    AicpuUnregOpEventCb(5, 20);
    AsyncEventManager::GetInstance().ProcessOpEvent(5, 20, nullptr);
    // notify_cnt not change for all cbs hava been unregistered
    EXPECT_EQ(AicpuAsyncEventTest::notify_cnt, 7);
}