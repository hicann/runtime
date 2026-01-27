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
#include "driver/ascend_hal.h"

#define private public
#define protected public
#include "subscribe_manager.h"
#undef private
#undef protected

using namespace std;

class SUBSCRIBE_MANAGER_ST :public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before bqs_client_utest" << endl;
        instance.InitSubscribeManager(0, 0, 1, 0);
    }

    virtual void TearDown()
    {
        cout << "After bqs_client_utest" << endl;
        GlobalMockObject::verify();
    }
public:
    bqs::SubscribeManager instance;
};


TEST_F(SUBSCRIBE_MANAGER_ST, UpdateSubscribeFullToNotFullOK)
{
    instance.fullToNotFullQueuesSets_.insert(0U);
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    bqs::BqsStatus ret = instance.UpdateSubscribeFullToNotFull(0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_ST, UpdateSubscribeFullToNotFull_Fail)
{
    // success for not subscribed
    EXPECT_EQ(instance.UpdateSubscribeFullToNotFull(0), bqs::BQS_STATUS_OK);

    EXPECT_EQ(instance.SubscribeFullToNotFull(0), bqs::BQS_STATUS_OK);

    // repeated subscribe success
    EXPECT_EQ(instance.SubscribeFullToNotFull(0), bqs::BQS_STATUS_OK);
    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED))
        .then(returnValue(DRV_ERROR_NO_DEVICE));
    // fail for ResubscribeF2NF
    EXPECT_EQ(instance.UpdateSubscribeFullToNotFull(0), bqs::BQS_STATUS_DRIVER_ERROR);
    // fail for EnhancedSubscribe
    EXPECT_EQ(instance.UpdateSubscribeFullToNotFull(0), bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_ST, Unsubscribefail_01)
{
    MOCKER(halQueueUnsubEvent)
        .stubs()
        .will(returnValue(100))
        .then(returnValue(DRV_ERROR_NOT_EXIST));
    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_OK);
    EXPECT_EQ(instance.Unsubscribe(0), bqs::BQS_STATUS_DRIVER_ERROR);
    EXPECT_EQ(instance.Unsubscribe(0), bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_ST, UnsubscribeFullToNotFullFail_01)
{
    MOCKER(halQueueSubEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halQueueUnsubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NOT_EXIST));
    // success for not subscribed
    EXPECT_EQ(instance.UnsubscribeFullToNotFull(1), bqs::BQS_STATUS_OK);
    EXPECT_EQ(instance.SubscribeFullToNotFull(1), bqs::BQS_STATUS_OK);
    // fail for EnhancedUnSubscribe
    EXPECT_EQ(instance.UnsubscribeFullToNotFull(1), bqs::BQS_STATUS_DRIVER_ERROR);
    // success for not drv exist
    EXPECT_EQ(instance.UnsubscribeFullToNotFull(1), bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_ST, Subscribe_Fail)
{
    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED))
        .then(returnValue(DRV_ERROR_NO_DEVICE));

    // fail for Resubscribe
    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_ST, UpdateSubscribe_Success)
{
    EXPECT_EQ(instance.UpdateSubscribe(0), bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_ST, Unsubscribe_Success)
{
    EXPECT_EQ(instance.Unsubscribe(0), bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_ST, UpdateSubscribe_Fail)
{
    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_OK);
    // repeated subscribe success
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

TEST_F(SUBSCRIBE_MANAGER_ST, ResumeSubscribeFailed1)
{
    bqs::BqsStatus ret = instance.ResumeSubscribe(0, 1);
    EXPECT_EQ(ret, bqs::BQS_STATUS_PARAM_INVALID);

    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_OK);
    EXPECT_EQ(instance.PauseSubscribe(0, 1, true), bqs::BQS_STATUS_OK);

    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(instance.ResumeSubscribe(0, 1), bqs::BQS_STATUS_DRIVER_ERROR);

    // success ResumeSubscribe
    EXPECT_EQ(instance.ResumeSubscribe(0, 1), bqs::BQS_STATUS_OK);
    // success for repeat ResumeSubscribe
    EXPECT_EQ(instance.ResumeSubscribe(0, 1), bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_ST, Resubscribe_Fail)
{
    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_OK);
    MOCKER(halQueueUnsubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));

    // fail for EnhancedUnSubscribe
    EXPECT_EQ(instance.Resubscribe(0), bqs::BQS_STATUS_DRIVER_ERROR);
    // fail for  EnhancedSubscribe
    EXPECT_EQ(instance.Resubscribe(0), bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(SUBSCRIBE_MANAGER_ST, PauseSubscribe)
{
    EXPECT_EQ(instance.PauseSubscribe(0, 1, true), bqs::BQS_STATUS_OK);
    EXPECT_EQ(instance.Subscribe(0), bqs::BQS_STATUS_OK);

    MOCKER(halQueueUnsubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    // fail for EnhancedUnSubscribe
    EXPECT_EQ(instance.PauseSubscribe(0, 1, true), bqs::BQS_STATUS_DRIVER_ERROR);
    // success
    EXPECT_EQ(instance.PauseSubscribe(0, 1, true), bqs::BQS_STATUS_OK);
    // success for repeate pause
    EXPECT_EQ(instance.PauseSubscribe(0, 1, true), bqs::BQS_STATUS_OK);
}

TEST_F(SUBSCRIBE_MANAGER_ST, DefalutSubscribe_Fail)
{
    bqs::SubscribeManager instanceCross;
    instanceCross.InitSubscribeManager(0, 0, 0, 1);
    EXPECT_EQ(instanceCross.DefalutSubscribe(0, 0), DRV_ERROR_NOT_SUPPORT);

    instanceCross.InitSubscribeManager(0, 0, 0, 0);
    EXPECT_EQ(instanceCross.DefalutSubscribe(0, QUEUE_EVENT_TYPE_MAX), DRV_ERROR_INVALID_VALUE);
    EXPECT_EQ(instanceCross.DefalutUnSubscribe(0, QUEUE_EVENT_TYPE_MAX), DRV_ERROR_INVALID_VALUE);
}

TEST_F(SUBSCRIBE_MANAGER_ST, SubscribeFullToNotFull_Fail)
{
    MOCKER(halQueueSubEvent)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_RE_SUBSCRIBED))
        .then(returnValue(DRV_ERROR_NO_DEVICE));
    // fail for ResubscribeF2NF
    EXPECT_EQ(instance.SubscribeFullToNotFull(0), bqs::BQS_STATUS_DRIVER_ERROR);
    // fail for EnhancedSubscribe
    EXPECT_EQ(instance.SubscribeFullToNotFull(0), bqs::BQS_STATUS_DRIVER_ERROR);
}