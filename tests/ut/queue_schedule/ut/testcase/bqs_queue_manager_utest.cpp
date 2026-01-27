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
#include "bind_relation.h"
#include "subscribe_manager.h"
#include "queue_manager.h"
#include "bqs_server.h"
#include "bqs_msg.h"
#include "bqs_status.h"
#include "queue_schedule_stub.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

constexpr uint32_t mbufSize = 1024;
char allocFakeMBuf[mbufSize] = {0};

class BQS_QUEUE_MANAGER_UTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
        bqs::Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
        std::cout << "BQS_QUEUE_MANAGER_UTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        bqs::Subscribers::GetInstance().subscribeManagers_.clear();
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
        std::cout << "BQS_QUEUE_MANAGER_UTest TearDownTestCase" << std::endl;
    }
    virtual void SetUp()
    {
        cout << "Before utest" << endl;
        bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
        qsInitGroupName = "DEFAULT";
        instance.NotifyInitSuccess(0);
    }

    virtual void TearDown()
    {
        cout << "After utest" << endl;
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
uint32_t *g_queueId = nullptr;

void NewQueueId(const uint32_t queueId)
{
    g_queueId = new uint32_t(queueId);
    std::cout << "g_queueId:" << *g_queueId << std::endl;
}

void DeleteQueueId()
{
    delete g_queueId;
}
int halMbufGetBuffAddrFake2(Mbuf *mbuf, void **buf)
{
    *(char **)buf = allocFakeMBuf;
    return DRV_ERROR_NONE;
}
}  // namespace

TEST_F(BQS_QUEUE_MANAGER_UTest, InitSuccess1)
{
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InitSuccess2)
{
    MOCKER(halQueueGetQidbyName).stubs().will(returnValue(0));
    MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InitUnsubscribeSucc)
{
    MOCKER(halQueueGetQidbyName).stubs().will(returnValue(0));
    MOCKER(halQueueUnsubEvent).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InitBuffQueueInitFailed)
{
    MOCKER(halQueueInit).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InithalQueueCreateFailed)
{
    MOCKER(halQueueCreate).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InithalQueueSubEventFailed)
{
    MOCKER(halQueueSubEvent).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InithalQueueCreate2Failed)
{
    MOCKER(halQueueCreate).stubs().will(returnValue(0)).then(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InithalQueueSubEvent2Failed)
{
    MOCKER(halQueueSubEvent).stubs().will(returnValue(0)).then(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, CreateQueueFailed)
{
    MOCKER(halQueueCreate).stubs().will(returnValue(0));
    MOCKER(halQueueAttach).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    uint32_t queueId = 2;
    const char_t *const name = "tmp";
    bqs::BqsStatus ret = instance.CreateQueue(name, 0, queueId, 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, CreateAndSubscribeQueueExtraFailed)
{
    MOCKER(&QueueManager::CreateQueue,
        bqs::BqsStatus(QueueManager::*)(
            const char_t *const name, const uint32_t depth, uint32_t &queueId, uint32_t deviceId) const)
        .stubs()
        .will(returnValue(bqs::BQS_STATUS_DRIVER_ERROR));
    uint32_t queueId = 2;
    const char_t *const name = "tmp";
    bqs::BqsStatus ret = instance.CreateAndSubscribeQueueExtra(name, 0, queueId);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, CreateAndSubscribeQueueExtraFailed2)
{
    MOCKER(&QueueManager::CreateQueue,
        bqs::BqsStatus(QueueManager::*)(
            const char_t *const name, const uint32_t depth, uint32_t &queueId, uint32_t deviceId) const)
        .stubs()
        .will(returnValue(0));
    MOCKER(halQueueSubscribe).stubs().will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    uint32_t queueId = 2;
    const char_t *const name = "tmp";
    bqs::BqsStatus ret = instance.CreateAndSubscribeQueueExtra(name, 0, queueId);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, UnsubscribeQueueFailed)
{
    MOCKER(halQueueUnsubEvent).stubs().will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    MOCKER(halQueueUnsubscribe).stubs().will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    const QUEUE_EVENT_TYPE eventType;
    bqs::BqsStatus ret = instance.UnsubscribeQueue(0, eventType);
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InitExtraFailed)
{
    MOCKER(&QueueManager::InitQueueExtra).stubs().will(returnValue(bqs::BQS_STATUS_DRIVER_ERROR));
    instance.InitExtra(0, 0);
    EXPECT_EQ(instance.deviceIdExtra_, 0);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InitQueueExtraFailed)
{
    MOCKER(halQueueInit).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.InitQueueExtra();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InitQueueExtraFailed2)
{
    MOCKER(halQueueInit).stubs().will(returnValue(0));
    MOCKER(&QueueManager::CreateAndSubscribeQueueExtra)
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

TEST_F(BQS_QUEUE_MANAGER_UTest, InitQueueFailed)
{
    MOCKER(halQueueInit).stubs().will(returnValue(0));
    MOCKER(&QueueManager::CreateAndSubscribeQueue)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_DRIVER_ERROR)));
    bqs::BqsStatus ret = instance.InitQueue();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, InitQueueFailed2)
{
    MOCKER(halQueueInit).stubs().will(returnValue(0));
    MOCKER(&QueueManager::CreateAndSubscribeQueue)
        .stubs()
        .will(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_DRIVER_ERROR)));
    bqs::BqsStatus ret = instance.InitQueue();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, Clear_MbufForF2nfNull)
{
    instance.mbufForF2nf_ = (Mbuf *)allocFakeMBuf;
    instance.Clear();
    EXPECT_EQ(instance.mbufForF2nf_, nullptr);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueRelationEventExtraSuccess2)
{
    MOCKER(&QueueManager::EnqueueRelationEventToQ).stubs().will(returnValue(0));
    instance.initiallizedExtra_ = false;
    instance.stopped_ = true;
    bqs::BqsStatus ret = instance.EnqueueRelationEventExtra();
    EXPECT_EQ(ret, 0);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueFullToNotFullEventFailed)
{
    MOCKER(halMbufAlloc).stubs().will(returnValue(-1));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    NewQueueId(0);
    instance.mbufForF2nf_ = nullptr;
    bqs::BqsStatus ret = instance.EnqueueFullToNotFullEvent(0U);
    instance.mbufForF2nf_ = nullptr;
    DeleteQueueId();
    EXPECT_EQ(ret, bqs::BQS_STATUS_INNER_ERROR);
    instance.Destroy();
}

TEST_F(BQS_QUEUE_MANAGER_UTest, DestroyWhenQueueCreatedSuccess)
{
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    instance.Destroy();
}

TEST_F(BQS_QUEUE_MANAGER_UTest, DestroyRelationBuffQueueFailed)
{
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    MOCKER(halQueueDestroy).stubs().will(returnValue(200));
    instance.Destroy();
}

TEST_F(BQS_QUEUE_MANAGER_UTest, DestroyFullToNotFullBuffQueueFailed)
{
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    MOCKER(halQueueDestroy).stubs().will(returnValue(0)).then(returnValue(200));
    instance.Destroy();
}

TEST_F(BQS_QUEUE_MANAGER_UTest, DestroyRecvHcclBuffQueueFailed)
{
    bqs::BqsStatus ret = instance.InitQueueManager(0, 0, true, qsInitGroupName);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    MOCKER(halQueueDestroy).stubs().will(returnValue(0)).then(returnValue(0)).then(returnValue(200));
    instance.Destroy();
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueRelationEventSuccess)
{
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueRelationEventMbufAllocFailed)
{
    MOCKER(halMbufAlloc).stubs().will(returnValue(-1));
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueRelationEventEnBuffQueueFailed)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueRelationEventWhenStopped)
{
    instance.stopped_ = true;
    bqs::BqsStatus ret = instance.EnqueueRelationEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    instance.stopped_ = false;
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueRelationEventOnNotify)
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

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleRelationEventSuccess)
{
    MOCKER_CPP(&bqs::BqsServer::BindMsgProc).stubs().will(returnValue(0));
    MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_NONE)).then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    bool ret = instance.HandleRelationEvent();
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleRelationEventDeBuffQueueSuccess)
{
    MOCKER_CPP(&bqs::BqsServer::BindMsgProc).stubs().will(returnValue(0));

    MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

    bool ret = instance.HandleRelationEvent();
    EXPECT_EQ(ret, false);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleRelationEventDeBuffQueueFailed)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(200));
    bool ret = instance.HandleRelationEvent();
    EXPECT_EQ(ret, false);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleRelationEventMbufFreeFailed)
{
    MOCKER(halMbufFree).stubs().will(returnValue(-1));
    MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_NONE)).then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    bool ret = instance.HandleRelationEvent();
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueFullToNotFullEventSuccess)
{
    NewQueueId(0);
    instance.mbufForF2nf_ = (Mbuf*)allocFakeMBuf;
    bqs::BqsStatus ret = instance.EnqueueFullToNotFullEvent(0U);
    instance.mbufForF2nf_ = nullptr;
    DeleteQueueId();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueFullToNotFullEventEnBuffQueueFailed)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));
    NewQueueId(0);
    instance.mbufForF2nf_ = (Mbuf*)allocFakeMBuf;
    bqs::BqsStatus ret = instance.EnqueueFullToNotFullEvent(0U);
    instance.mbufForF2nf_ = nullptr;
    DeleteQueueId();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleFullToNotFullEventUnsubscribeSuccess)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(0)).then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

    MOCKER_CPP(&bqs::SubscribeManager::UnsubscribeFullToNotFull).stubs().will(returnValue(0));

    MOCKER_CPP(&bqs::SubscribeManager::ResumeSubscribe).stubs().will(returnValue(0));

    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));

    NewQueueId(0);
    bool ret = instance.HandleFullToNotFullEvent(0U);
    DeleteQueueId();
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueAsynMemBuffEventBuffFailed01)
{
    MOCKER(halMbufAlloc).stubs().will(returnValue(200));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    instance.asyncMemDequeueBuffQId_ = 103;
    instance.isTriggeredByAsyncMemDequeue_ = true;
    bqs::BqsStatus ret = instance.EnqueueAsynMemBuffEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueAsynMemBuffEventBuffFailed02)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    instance.asyncMemDequeueBuffQId_ = 103;
    instance.isTriggeredByAsyncMemDequeue_ = true;
    bqs::BqsStatus ret = instance.EnqueueAsynMemBuffEvent();
    instance.isTriggeredByAsyncMemDequeue_ = false;
    instance.isTriggeredByAsyncMemEnqueue_ = true;
    ret = instance.EnqueueAsynMemBuffEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueAsynMemBuffEventBuffSuccess)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(0));
    instance.asyncMemDequeueBuffQId_ = 103;
    instance.isTriggeredByAsyncMemDequeue_ = true;
    instance.isTriggeredByAsyncMemEnqueue_ = true;
    bqs::BqsStatus ret = instance.EnqueueAsynMemBuffEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleAsynMemBuffEventFailed01)
{
    MOCKER(halQueueDeQueue).stubs()
        .will(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue((int)DRV_ERROR_PARA_ERROR));
    MOCKER(halMbufFree).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    instance.isTriggeredByAsyncMemDequeue_ = true;
    instance.isTriggeredByAsyncMemEnqueue_ = true;
    instance.asyncMemDequeueBuffQId_ = 101;
    bool ret = instance.HandleAsynMemBuffEvent(0);
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleAsynMemBuffEventFailed02)
{
    MOCKER(halQueueDeQueue).stubs()
        .will(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue((int)DRV_ERROR_PARA_ERROR));
    MOCKER(halMbufFree).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    instance.isTriggeredByAsyncMemDequeue_ = true;
    instance.isTriggeredByAsyncMemEnqueue_ = true;
    instance.asyncMemDequeueBuffQId_ = 101;
    bool ret = instance.HandleAsynMemBuffEvent(0);
    ret = instance.HandleAsynMemBuffEvent(0);
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleAsynMemBuffEventSuccess)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_NONE)).then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    MOCKER(halMbufFree).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    instance.isTriggeredByAsyncMemDequeue_ = true;
    instance.isTriggeredByAsyncMemEnqueue_ = true;
    instance.asyncMemDequeueBuffQId_ = 101;
    bool ret = instance.HandleAsynMemBuffEvent(0);
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleFullToNotFullEventResumeSuccess)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(0)).then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

    MOCKER_CPP(&bqs::SubscribeManager::UnsubscribeFullToNotFull).stubs().will(returnValue(0));

    MOCKER_CPP(&bqs::SubscribeManager::ResumeSubscribe).stubs().will(returnValue(0));

    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));

    auto &bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(0U, 0U);
    auto dstEntity = bqs::EntityInfo(1U, 0U);
    int32_t result = bindRelation.Bind(srcEntity, dstEntity);
    EXPECT_EQ(result, 0);

    NewQueueId(0);
    bool ret = instance.HandleFullToNotFullEvent(0U);
    DeleteQueueId();
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleFullToNotFullEventDeBuffQueueFailed)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(0)).then(returnValue(200));

    bool ret = instance.HandleFullToNotFullEvent(0U);
    EXPECT_EQ(ret, false);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleFullToNotFullEventMbufGetDataPtrFailed)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

    MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(-1));

    bool ret = instance.HandleFullToNotFullEvent(0U);
    EXPECT_EQ(ret, false);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, HandleFullToNotFullEventMbufFreeFailed)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(0)).then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake2));

    MOCKER(halMbufFree).stubs().will(returnValue(-1));

    auto &bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(0U, 0U);
    auto dstEntity = bqs::EntityInfo(1U, 0U);
    int32_t result = bindRelation.Bind(srcEntity, dstEntity);
    EXPECT_EQ(result, 0);

    NewQueueId(1);
    bool ret = instance.HandleFullToNotFullEvent(0U);
    DeleteQueueId();
    EXPECT_EQ(ret, true);
}

TEST_F(BQS_QUEUE_MANAGER_UTest, EnqueueFullToNotFullEventExtraSuccess)
{
    MOCKER(halMbufAlloc).stubs().will(invoke(MbufAllocFake));
    instance.f2nfQueueEmptyFlagExtra_ = false;
    EXPECT_EQ(instance.EnqueueFullToNotFullEvent(1U), bqs::BQS_STATUS_OK);
    instance.Clear();
}

TEST_F(BQS_QUEUE_MANAGER_UTest, MakeUpMbuf_Fail)
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