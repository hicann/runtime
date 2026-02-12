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
#include "mockcpp/ChainingMockHelper.h"

#define private public
#define protected public
#include "driver/ascend_hal.h"
#include "subscribe_manager.h"
#include "bqs_util.h"
#undef private
#undef protected

using namespace std;

class SUBSCRIBE_MANAGER_UTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before bqs_client_utest" << endl;
        instance.InitSubscribeManager(0, 0, 0, 0);
    }

    virtual void TearDown()
    {
        cout << "After bqs_client_utest" << endl;
        GlobalMockObject::verify();
    }

    bqs::SubscribeManager instance;
};

TEST_F(SUBSCRIBE_MANAGER_UTest, SubscribeSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, SubscribeRepeatSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, SubscribeFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(200));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ReSubscribeSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue((int)DRV_ERROR_QUEUE_RE_SUBSCRIBED))
    .then(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ReSubscribehalQueueUnsubscribeFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue((int)DRV_ERROR_QUEUE_RE_SUBSCRIBED))
    .then(returnValue(0));
     MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(200));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ReSubscribehalQueueSubscribeFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue((int)DRV_ERROR_QUEUE_RE_SUBSCRIBED))
    .then(returnValue(200));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UnsubscribeSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.Unsubscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, NoneedUnsubscribeSuccess)
{
    bqs::BqsStatus ret = instance.Unsubscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UnsubscribeFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(200));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.Unsubscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UnsubscribeAlreadyPauseSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.Unsubscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, SubscribeFullToNotFullSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, SubscribeFullToNotFullFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(200));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ReSubscribeFullToNotFullSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue((int)DRV_ERROR_QUEUE_RE_SUBSCRIBED))
    .then(returnValue(0));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ReSubscribeFullToNotFullhalQueueUnsubF2NFEventFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue((int)DRV_ERROR_QUEUE_RE_SUBSCRIBED))
    .then(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(200));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ReSubscribeFullToNotFullhalQueueSubF2NFEventFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue((int)DRV_ERROR_QUEUE_RE_SUBSCRIBED))
    .then(returnValue(200));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UnsubscribeFullToNotFullSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.UnsubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, NoneedUnsubscribeFullToNotFullSuccess)
{
    bqs::BqsStatus ret = instance.UnsubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UnsubscribeFullToNotFullFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(200));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.UnsubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, PauseSubscribeSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, PauseAndUpdateSubscribeSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    ret = instance.UpdateSubscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UpdateSubscribeFail)
{
    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_OK);
    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED))
        .then(returnValue(DRV_ERROR_NO_DEVICE));

    // fail for Resubscribe
    EXPECT_EQ(instance.UpdateSubscribe(0), bqs::BQS_STATUS_DRIVER_ERROR);
    // fail for EnhancedSubscribe
    EXPECT_EQ(instance.UpdateSubscribe(0), bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, NoneedPauseSubscribeSuccess1)
{
    bqs::BqsStatus ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, NoneedPauseSubscribeSuccess2)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, PauseSubscribeRepeatedSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, PauseSubscribeFailed)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(200));
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ResumeSubscribeSuccess)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.ResumeSubscribe(0, 1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ResumeSubscribeRepeatedSuccess)
{
    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(0));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.ResumeSubscribe(0, 1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    ret = instance.ResumeSubscribe(0, 1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ResumeSubscribeFailed1)
{
    bqs::BqsStatus ret = instance.ResumeSubscribe(0, 1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_PARAM_INVALID);

    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_OK);
    EXPECT_EQ(instance.PauseSubscribe(0, 1, true), bqs::BQS_STATUS_OK);

    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(instance.ResumeSubscribe(0, 1), bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, ResumeSubscribeSuccess2)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0))
    .then(returnValue(0))
    .then(returnValue(0))
    .then(returnValue(0))
    .then(returnValue(200));
    bqs::BqsStatus ret = instance.Subscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    ret = instance.SubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(0));
    ret = instance.PauseSubscribe(0, 1, true);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);


    ret = instance.ResumeSubscribe(0, 1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}


TEST_F(SUBSCRIBE_MANAGER_UTest, Unsubscribefail_01)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(100));
    bqs::BqsStatus ret = instance.Subscribe(0);
    ret = instance.Unsubscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, Unsubscribefail_02)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(11));
    bqs::BqsStatus ret = instance.Subscribe(0);
    ret = instance.Unsubscribe(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UnsubscribeFullToNotFullFail_01)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(returnValue(100));
    bqs::BqsStatus ret = instance.SubscribeFullToNotFull(1);
    ret = instance.UnsubscribeFullToNotFull(1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, EnhancedSubscribe_With_Common_Driver)
{
    MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
    bqs::SubscribeManager localInstance;
    localInstance.InitSubscribeManager(0, 0, 0, 0);
    EXPECT_EQ(localInstance.EnhancedSubscribe(1U, QUEUE_ENQUE_EVENT), DRV_ERROR_NONE);
    EXPECT_EQ(localInstance.EnhancedSubscribe(1U, QUEUE_F2NF_EVENT), DRV_ERROR_NONE);
    EXPECT_EQ(localInstance.EnhancedSubscribe(1U, QUEUE_EVENT_TYPE_MAX), DRV_ERROR_INVALID_VALUE);

    EXPECT_EQ(localInstance.EnhancedUnSubscribe(1U, QUEUE_ENQUE_EVENT), DRV_ERROR_NONE);
    EXPECT_EQ(localInstance.EnhancedUnSubscribe(1U, QUEUE_F2NF_EVENT), DRV_ERROR_NONE);
    EXPECT_EQ(localInstance.EnhancedUnSubscribe(1U, QUEUE_EVENT_TYPE_MAX), DRV_ERROR_INVALID_VALUE);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, EnhancedSubscribe_With_Extend_Driver)
{
    MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
    bqs::GlobalCfg::GetInstance().SetNumaFlag(true);
    bqs::SubscribeManager localInstance;
    localInstance.InitSubscribeManager(0, 0, 0, 0);
    EXPECT_EQ(localInstance.EnhancedSubscribe(1U, QUEUE_ENQUE_EVENT), DRV_ERROR_NONE);
    EXPECT_EQ(localInstance.EnhancedSubscribe(1U, QUEUE_F2NF_EVENT), DRV_ERROR_NONE);

    EXPECT_EQ(localInstance.EnhancedUnSubscribe(1U, QUEUE_ENQUE_EVENT), DRV_ERROR_NONE);
    EXPECT_EQ(localInstance.EnhancedUnSubscribe(1U, QUEUE_F2NF_EVENT), DRV_ERROR_NONE);
    bqs::GlobalCfg::GetInstance().SetNumaFlag(false);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UpdateSubscribeFullToNotFull_Fail)
{
    EXPECT_EQ(instance.SubscribeFullToNotFull(1), bqs::BQS_STATUS_OK);
    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED))
        .then(returnValue(DRV_ERROR_NO_DEVICE));

    // fail for ResubscribeF2NF
    EXPECT_EQ(instance.UpdateSubscribeFullToNotFull(1), bqs::BQS_STATUS_DRIVER_ERROR);
    // fail for EnhancedSubscribe
    EXPECT_EQ(instance.UpdateSubscribeFullToNotFull(1), bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, UnsubscribeFullToNotFull_Success)
{
    EXPECT_EQ(instance.SubscribeFullToNotFull(1), bqs::BQS_STATUS_OK);
    MOCKER(halQueueUnsubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NOT_EXIST));

    EXPECT_EQ(instance.UnsubscribeFullToNotFull(1), bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_UTest, DefalutSubscribe_Fail)
{
    bqs::SubscribeManager instanceCross;
    instanceCross.InitSubscribeManager(0, 0, 0, 1);
    EXPECT_EQ(instanceCross.DefalutSubscribe(0, QUEUE_ENQUE_EVENT), DRV_ERROR_NOT_SUPPORT);
}