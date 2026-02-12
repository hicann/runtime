/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <thread>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"

#include "driver/ascend_hal.h"

#define private public
#define protected public
#include "bind_relation.h"
#include "subscribe_manager.h"
#include "queue_manager.h"
#include "bqs_server.h"
#include "bqs_msg.h"
#include "bqs_status.h"
#undef private
#undef protected

using namespace std;

constexpr uint32_t mbufSize = 1024;
char allocFakeMBuf[mbufSize] = {0};

class BQS_QUEUE_MANAGER_STest : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
        qsInitGroupName = "DEFAULT";
        instance.NotifyInitSuccess(0U);
    }

    virtual void TearDown()
    {
        DelAllBindRelation();
        GlobalMockObject::verify();
    }

public:
    void DelAllBindRelation()
    {
        std::vector<std::tuple<bqs::EntityInfo, bqs::EntityInfo>> allRelation;
        auto& bindRelation = bqs::BindRelation::GetInstance();
        auto& dstToSrcRelation = bindRelation.GetDstToSrcRelation();
        for (auto& relation : dstToSrcRelation) {
            const auto &dstId = relation.first;
            for (auto srcId : relation.second){
                allRelation.emplace_back(std::make_tuple(srcId, dstId));
            }
        }

        for (auto& relation : allRelation) {
            auto &srcId = std::get<0>(relation);
            auto &dstId = std::get<1>(relation);
            bqs::BqsStatus ret = bindRelation.UnBind(srcId, dstId);
            EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
        }
    }

    bqs::QueueManager instance;
    std::string qsInitGroupName;
};

namespace {
uint32_t* g_queueId = nullptr;

void NewQueueId(const uint32_t queueId)
{
    g_queueId = new uint32_t(queueId);
    std::cout << "g_queueId:" << *g_queueId << std::endl;
}

void DeleteQueueId()
{
    delete g_queueId;
}

int MbufAllocFake(unsigned int size, Mbuf **mbuf)
{
    *(char**)mbuf = allocFakeMBuf;
    return DRV_ERROR_NONE;
}

int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf)
{
    std::cout << "queue_schedule_stub halMbufGetBuffAddr stub begin" << std::endl;
    *(int32_t **)buf = (int32_t *)mbuf;
    std::cout << "queue_schedule_stub halMbufGetBuffAddr stub end" << std::endl;
    return DRV_ERROR_NONE;
}
}  // namespace

TEST_F(BQS_QUEUE_MANAGER_STest, InitSuccess1)
{
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InitSuccess2)
{
    MOCKER(halQueueGetQidbyName).stubs().will(returnValue(0));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InitUnsubscribeSucc)
{
    MOCKER(halQueueGetQidbyName).stubs().will(returnValue(0));
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InitBuffQueueInitFailed)
{
    MOCKER(halQueueInit).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InithalQueueCreateFailed)
{
    MOCKER(halQueueCreate).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InithalQueueSubEventFailed)
{
    MOCKER(halQueueSubEvent).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InithalQueueCreate2Failed)
{
    MOCKER(halQueueCreate).stubs().will(returnValue(0)).then(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InithalQueueSubEvent2Failed)
{
    MOCKER(halQueueSubEvent).stubs().will(returnValue(0)).then(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
    instance.Destroy();
    MOCKER(halQueueSubEvent).stubs().will(returnValue(0)).then(returnValue(200));
    ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
    MOCKER(halQueueDestroy).stubs().will(returnValue(200));
    instance.Destroy();
    ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
    MOCKER(halQueueDestroy).stubs().will(returnValue(0)).then(returnValue(200));
    instance.Destroy();
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueRelationEventSuccess)
{
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueRelationEventMbufAllocFailed)
{
    MOCKER(halMbufAlloc).stubs().will(returnValue(300));
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueRelationEventEnBuffQueueFailed)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueRelationEventWhenStopped)
{
    instance.stopped_ = true;
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    instance.stopped_ = false;
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueRelationEventOnNotify)
{
    instance.stopped_ = false;
    instance.initialized_ = false;
    auto th = std::thread {[&] {sleep(1); instance.NotifyInitSuccess(0); }};
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    if (th.joinable()) {
        th.join();
    }
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueFullToNotFullEventSuccess)
{
    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    NewQueueId(0);
    bqs::BqsStatus ret = instance.EnqueueFullToNotFullEvent(0U);
    DeleteQueueId();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueFullToNotFullEventEnBuffQueueFailed)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));

    NewQueueId(0);
    instance.mbufForF2nf_ = (Mbuf*)allocFakeMBuf;
    bqs::BqsStatus ret = instance.EnqueueFullToNotFullEvent(0U);
    instance.mbufForF2nf_ = nullptr;
    DeleteQueueId();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, EnqueueFullToNotFullEventExtraSuccess)
{
    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    instance.f2nfQueueEmptyFlagExtra_ = false;
    EXPECT_EQ(instance.EnqueueFullToNotFullEvent(1U), bqs::BQS_STATUS_OK);
    instance.Clear();
}

TEST_F(BQS_QUEUE_MANAGER_STest, MakeUpMbuf_Fail)
{
    MOCKER(halMbufAlloc).stubs().will(returnValue(1)).then(returnValue(0));
    MOCKER(halMbufSetDataLen).stubs().will(returnValue(1));
    Mbuf *mbuf = nullptr;
    // fail for alloc
    instance.MakeUpMbuf(&mbuf);
    EXPECT_EQ(mbuf, nullptr);
    // fail for setlen
    instance.MakeUpMbuf(&mbuf);
    EXPECT_EQ(mbuf, nullptr);
}

TEST_F(BQS_QUEUE_MANAGER_STest, InitQueueExtraFailed2)
{
    MOCKER(halQueueInit).stubs().will(returnValue(0));
    MOCKER(&bqs::QueueManager::CreateAndSubscribeQueueExtra)
        .stubs()
        .will(returnValue(bqs::BQS_STATUS_DRIVER_ERROR))
        .then(returnValue(bqs::BQS_STATUS_OK))
        .then(returnValue(bqs::BQS_STATUS_DRIVER_ERROR));

    // fail for init extra relation queue
    bqs::BqsStatus ret = instance.InitQueueExtra();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);

    // fail for init extra f2nf queue
    EXPECT_EQ(instance.InitQueueExtra(), bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_STest, HandleFullToNotFullEventDeBuffQueueFailed)
{
    GlobalMockObject::verify();
    MOCKER(halQueueDeQueue).stubs().will(returnValue(200));
    EXPECT_FALSE(instance.HandleFullToNotFullEvent(0U));
}