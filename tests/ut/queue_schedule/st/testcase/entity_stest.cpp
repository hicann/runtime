/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"

#define private public
#define protected public
#include "entity.h"
#include "simple_entity.h"
#include "client_entity.h"
#include "channel_entity.h"
#include "group_entity.h"
#include "msprof_manager.h"
#include "schedule_config.h"
#include "queue_manager.h"
#include "entity_manager.h"
#include "strategy/strategy_manager.h"
#include "bqs_util.h"
#undef private
#undef protected

#include "driver/ascend_hal.h"

using namespace std;
using namespace dgw;

namespace {
    drvError_t halQueuePeekFake(unsigned int devId, unsigned int qid, uint64_t *buf_len, int timeout)
    {
        *buf_len = 256U;
        return DRV_ERROR_NONE;
    }
}
class EntitySTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        bqs::GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
    }

    static void TearDownTestCase()
    {
        bqs::GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    virtual void SetUp()
    {
        cout << "Before entity_stest" << endl;
    }

    virtual void TearDown()
    {
        cout << "after entity_stest" << endl;
        GlobalMockObject::verify();
    }
};


TEST_F(EntitySTest, GroupCheckTimeout_success)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    material.localInstanceIndex = 1U;
    GroupEntity group(material, 0U);
    group.groupInfo_.timeout = -1;
    EXPECT_EQ(false, group.CheckTimeout(1U));

    group.groupInfo_.timeout = 0;
    EXPECT_EQ(false, group.CheckTimeout(1U));

    group.groupInfo_.timeout = 10;
    group.groupInfo_.lastTimestamp = 0U;
    EXPECT_EQ(true, group.CheckTimeout(1U));

    group.groupInfo_.timeout = INT64_MAX;
    group.groupInfo_.lastTimestamp = 10U;
    EXPECT_EQ(false, group.CheckTimeout(1U));
}


TEST_F(EntitySTest, SdmaCopy_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    SimpleEntity entity(material, 0U);

    MOCKER(halMbufGetDataLen)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    void *srcDataBuf = reinterpret_cast<void*>(1);
    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP(&srcDataBuf))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    uint32_t srcHeadBufSize = 0U;
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP(&srcDataBuf), outBoundP(&srcHeadBufSize))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue((int)DRV_ERROR_NONE))
        .then(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    Mbuf *mbufPtr = reinterpret_cast<Mbuf*>(1);
    MOCKER(halMbufAllocEx)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&mbufPtr))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halSdmaCopy)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    // halMbufGetDataLen fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // halMbufGetBuffAddr fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // halMbufGetPrivInfo fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // halMbufAllocEx fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // halMbufSetDataLen fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // halSdmaCopy fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // halMbufGetPrivInfo fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // halSdmaCopy fail
    EXPECT_EQ(entity.SdmaCopy(nullptr), nullptr);
    // success
    EXPECT_EQ(entity.SdmaCopy(nullptr), 1);
}

TEST_F(EntitySTest, AsyncDeQueue)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);

    // asyncDeque fail
    MOCKER(halQueueGetStatus)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(entity.DoDequeue(), FsmStatus::FSM_KEEP_STATE);
    int32_t tryTimes = 0;
    while (tryTimes++ < 3) {
        if (entity.asyncDataState_ == AsyncDataState::FSM_ASYNC_DATA_INIT) {
            break;
        }
        sleep(1);
    }
    EXPECT_TRUE(tryTimes < 3);

    // dequing
    entity.asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_WAIT;
    EXPECT_EQ(entity.DoDequeue(), FsmStatus::FSM_KEEP_STATE);

    // asyncDeque success
    entity.asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_SENT;
    EXPECT_EQ(entity.DoDequeue(), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, AsyncMemBuffEnQueueEvent)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);
    // asyncEnque fail
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(entity.DoSendData(nullptr), FsmStatus::FSM_KEEP_STATE);
    int32_t tryTimes = 0;
    while (tryTimes++ < 3) {
        if (entity.asyncDataState_ == AsyncDataState::FSM_ASYNC_DATA_INIT) {
            break;
        }
        sleep(1);
    }
    EXPECT_TRUE(tryTimes < 3);

    // enquing
    entity.asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_WAIT;
    EXPECT_EQ(entity.DoSendData(nullptr), FsmStatus::FSM_KEEP_STATE);

    // asyncEnque success
    entity.asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_SENT;
    EXPECT_EQ(entity.DoSendData(nullptr), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(entity.asyncDataState_, AsyncDataState::FSM_ASYNC_DATA_INIT);
}

TEST_F(EntitySTest, DoClientEnqueue_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);
    uint32_t headBufSize = 256U;
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    uint64_t dataLen = 4UL;
    MOCKER(halMbufGetDataLen)
        .stubs().with(mockcpp::any(), outBoundP(&dataLen))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    uint32_t placeHolder = 0U;
    void *dataPtr = (void*)&placeHolder;
    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP(&dataPtr))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halQueueEnQueueBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_QUEUE_FULL))
        .then(returnValue(DRV_ERROR_NOT_EXIST))
        .then(returnValue(DRV_ERROR_NO_DEVICE));

    // halMbufGetPrivInfo fail
    EXPECT_EQ(entity.DoClientEnqueue(nullptr), dgw::FsmStatus::FSM_FAILED);
    EXPECT_EQ(entity.asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);

    // halMbufGetBuffSize fail
    EXPECT_EQ(entity.DoClientEnqueue(nullptr), dgw::FsmStatus::FSM_FAILED);
    EXPECT_EQ(entity.asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);

    // halMbufGetBuffAddr fail
    EXPECT_EQ(entity.DoClientEnqueue(nullptr), dgw::FsmStatus::FSM_FAILED);
    EXPECT_EQ(entity.asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);

    // halQueueEnQueueBuff success
    EXPECT_EQ(entity.DoClientEnqueue(nullptr), dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(entity.asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_SENT);

    // halQueueEnQueueBuff full
    EXPECT_EQ(entity.DoClientEnqueue(nullptr), dgw::FsmStatus::FSM_DEST_FULL);
    EXPECT_EQ(entity.asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);

    // halQueueEnQueueBuff not exist
    EXPECT_EQ(entity.DoClientEnqueue(nullptr), dgw::FsmStatus::FSM_ERROR_PENDING);
    EXPECT_EQ(entity.asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);

    // halQueueEnQueueBuff other error
    EXPECT_EQ(entity.DoClientEnqueue(nullptr), dgw::FsmStatus::FSM_FAILED);
    EXPECT_EQ(entity.asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
}
    
TEST_F(EntitySTest, ClientDoDequeueMbuf_Fail01)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);
    MOCKER(halQueueGetStatus)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));
    uint64_t deqLen = 256U;
    MOCKER(halQueuePeek)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&deqLen), mockcpp::any())
        .will(returnValue(DRV_ERROR_NOT_EXIST))
        .then(returnValue(DRV_ERROR_NONE));

    Mbuf *stubMbuf = reinterpret_cast<Mbuf*>(1);
    MOCKER(halMbufAlloc)
        .stubs().with(mockcpp::any(), outBoundP(&stubMbuf))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    uint32_t headBufSize = 256U;
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    void *dataPtr = reinterpret_cast<void*>(1);
    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP(&dataPtr))
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halQueueDeQueueBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE))
        .then(returnValue(DRV_ERROR_NONE));

    void *mbuf = nullptr;
    //  halQueueGetStatus fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_FAILED);
    //  halQueuePeek fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_ERROR_PENDING);
    //  halMbufAlloc fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_FAILED);
    //  halMbufSetDataLen fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_FAILED);
    //  halMbufGetPrivInfo fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_FAILED);
    //  halMbufGetBuffAddr fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_FAILED);
    //  halQueueDeQueueBuff fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_FAILED);
    // no fail
    EXPECT_EQ(entity.DoDequeueMbuf(&mbuf), dgw::FsmStatus::FSM_SUCCESS);

    // DoDequeueMbuf success but EnqueueAsynMemBuffEvent fail
    MOCKER_CPP(&bqs::QueueManager::EnqueueAsynMemBuffEvent).stubs().will(returnValue(bqs::BQS_STATUS_DRIVER_ERROR));
    entity.DoClientDequeue();
    EXPECT_EQ(entity.asyncDataState_, AsyncDataState::FSM_ASYNC_DATA_SENT);
}

TEST_F(EntitySTest, ClientDoDequeueMbuf_success)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);
    MOCKER(halQueuePeek)
        .stubs()
        .will(invoke(halQueuePeekFake));
    int32_t temp = 1;
    int32_t *tempPtr = &temp;
    MOCKER(halMbufAlloc)
        .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
        .will(returnValue((int)DRV_ERROR_NONE));
    uint32_t headBufSize = 256U;
    char headBuf[256];
    void *headBufAddr = (void *)(&headBuf[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));
    int32_t mbufValue = 1;
    int32_t *mbuf = &mbufValue;

    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
        .will(returnValue((int)DRV_ERROR_NONE));

    void *mbufHolder = nullptr;
    EXPECT_EQ(entity.DoDequeueMbuf(&mbufHolder), dgw::FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, ClientEntity_DoDeQueue_Fail_ForThrow)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);
    entity.asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
    MOCKER_CPP(&ClientEntity::InvokeDequeThread).stubs().will(throws(std::bad_alloc()));
    EXPECT_EQ(entity.DoDequeue(), FsmStatus::FSM_FAILED);
    EXPECT_EQ(entity.asyncDataState_, AsyncDataState::FSM_ASYNC_DATA_INIT);
    EXPECT_FALSE(entity.IsDataPeeked());
}

TEST_F(EntitySTest, ClientEntity_DoSendData_Fail_ForThrow)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);
    entity.asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_INIT;
    MOCKER_CPP(&ClientEntity::InvokeEnqueThread).stubs().will(throws(std::bad_alloc()));
    EXPECT_EQ(entity.DoSendData(nullptr), FsmStatus::FSM_FAILED);
}

TEST_F(EntitySTest, ClientEntity_ResetSrcState)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    material.queueType = bqs::CLIENT_Q;
    ClientEntity entity(material, 0U);
    entity.curState_ = FsmState::FSM_PEEK_STATE;
    entity.asyncDataState_ = AsyncDataState::FSM_ASYNC_DATA_WAIT;
    EXPECT_EQ(entity.ResetSrcState(), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(entity.curState_, FsmState::FSM_IDLE_STATE);
    EXPECT_EQ(entity.asyncDataState_, AsyncDataState::FSM_ASYNC_DATA_INIT);
}

TEST_F(EntitySTest, ChannelEntity_ProcessReceiveCompletion_success)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    bqs::BqsMsprofManager::GetInstance().isRun_ = true;
    EXPECT_EQ(FsmStatus::FSM_SUCCESS, entity.ProcessReceiveCompletion(nullptr));

    ScheduleConfig::GetInstance().stoppedSchedKeys_.insert(0);
    EXPECT_EQ(FsmStatus::FSM_SUCCESS, entity.ProcessReceiveCompletion(nullptr));
    ScheduleConfig::GetInstance().stoppedSchedKeys_.clear();
    bqs::BqsMsprofManager::GetInstance().isRun_ = false;
}

TEST_F(EntitySTest, ChannelEntity_ProcessReceiveCompletion_fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    MOCKER(halQueueEnQueue).stubs().will(returnValue((int)DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(FsmStatus::FSM_FAILED, entity.ProcessReceiveCompletion(nullptr));
}

TEST_F(EntitySTest, ChannelEntity_ResetSrcState)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    entity.curState_ = FsmState::FSM_PEEK_STATE;
    EXPECT_EQ(entity.ResetSrcState(), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(entity.curState_, FsmState::FSM_IDLE_STATE);
}

TEST_F(EntitySTest, ChannelEntity_AddCachedReqCount)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    ScheduleConfig::GetInstance().stoppedSchedKeys_.insert(0);
    EXPECT_TRUE(entity.AddCachedReqCount());
    ScheduleConfig::GetInstance().stoppedSchedKeys_.clear();
}

TEST_F(EntitySTest, ChannelEntity_AllocMbuf_fail)
{
    bqs::BqsMsprofManager::GetInstance().isRun_ = true;
    MOCKER(halMbufAlloc).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_NO_DEVICE)));
    Mbuf *stubMbuf = nullptr;
    void *stubPtr = nullptr;
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    ChannelEntity entity(material, 0U);
    EXPECT_EQ(entity.Init(FsmState::FSM_WAIT_PUSH_STATE, EntityDirection::DIRECTION_RECV), FsmStatus::FSM_FAILED);
    EXPECT_EQ(entity.AllocMbuf(stubMbuf, stubPtr, stubPtr, 10U), FsmStatus::FSM_FAILED);
    bqs::BqsMsprofManager::GetInstance().isRun_ = false;
}

TEST_F(EntitySTest, Entity_DEFAULT_FUNCITON)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    material.localInstanceIndex = 1U;
    GroupEntity group(material, 0U);
    EXPECT_EQ(group.ResetSrcState(), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(group.IsDataPeeked(), false);

    material.eType = dgw::EntityType::ENTITY_QUEUE;
    dgw::SimpleEntity simple(material, 0U);
    EXPECT_EQ(simple.AbProcessInTryPush(), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, GroupEntity_ResumeSubscribe_success)
{
    uint32_t groupId = 0U;
    uint32_t resIndex = 0U;
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    material.id = groupId;
    material.localInstanceIndex = 1U;
    GroupEntity group(material, resIndex);

    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.hostGroupId = groupId;
    dgw::EntityPtr entity1 = std::make_shared<dgw::SimpleEntity>(material, 0U);

    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.hostGroupId = groupId;
    material.id = 1U;
    material.channel = &channel;
    dgw::EntityPtr entity2 = std::make_shared<dgw::ChannelEntity>(material, 0U);
    std::vector<EntityPtr> entitiesInGroup = {entity1, entity2};
    EXPECT_EQ(EntityManager::Instance(resIndex).CreateGroup(groupId, entitiesInGroup), FsmStatus::FSM_SUCCESS);

    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.hostGroupId = -1;
    dgw::SimpleEntity entity3(material, 0U);
    EXPECT_EQ(group.ResumeSubscribe(entity3), FsmStatus::FSM_SUCCESS);

    Mbuf *mbuf = nullptr;
    auto dataObj = DataObjManager::Instance().CreateDataObj(entity1.get(), mbuf);
    dataObj->AddRecvEntity(&entity3);
    entity3.AddDataObjToRecvList(dataObj);
    entity1->AddDataObjToSendList(dataObj);
    MOCKER(halQueueDeQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_EMPTY));
    EXPECT_EQ(group.ClearQueue(), FsmStatus::FSM_SUCCESS);

    EXPECT_EQ(EntityManager::Instance(resIndex).DeleteGroup(groupId), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, GroupEntity_SelectSrcEntity_success)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_EMPTY));
    uint32_t groupId = 0U;
    uint32_t resIndex = 0U;
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    material.id = groupId;
    material.localInstanceIndex = 1U;
    GroupEntity group(material, resIndex);
    group.groupInfo_.lastTransId = 1U;
    FsmStatus status = FsmStatus::FSM_FAILED;
    EXPECT_EQ(group.SelectSrcEntity(status), nullptr);
    Mbuf *stubMbuf = reinterpret_cast<Mbuf*>(1);

    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.hostGroupId = groupId;
    dgw::EntityPtr entity1 = std::make_shared<dgw::SimpleEntity>(material, 0U);
    entity1->curState_ = FsmState::FSM_PEEK_STATE;
    entity1->SetRouteLabel(0U);
    entity1->SetTransId(0U);
    entity1->SetMbuf(stubMbuf);

    material.id = 1U;
    dgw::EntityPtr entity2 = std::make_shared<dgw::SimpleEntity>(material, 0U);
    entity2->curState_ = FsmState::FSM_PEEK_STATE;
    entity2->SetRouteLabel(0U);
    entity2->SetTransId(2U);
    std::vector<EntityPtr> entitiesInGroup = {entity1, entity2};
    EXPECT_EQ(EntityManager::Instance(resIndex).CreateGroup(groupId, entitiesInGroup), FsmStatus::FSM_SUCCESS);

    EXPECT_EQ(group.SelectSrcEntity(status), entity2);
    EXPECT_EQ(status, FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(EntityManager::Instance(resIndex).DeleteGroup(groupId), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, ChannelEntity_Init_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 0U, 0U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);

    uint32_t invalidQueueDepth = 8U * 1024U + 1U;
    // localTagDepth 0
    channel.localTagDepth_ = invalidQueueDepth;
    EXPECT_EQ(entity.Init(FsmState::FSM_IDLE_STATE, EntityDirection::DIRECTION_SEND), FsmStatus::FSM_FAILED);
    entity.Uninit();
    channel.localTagDepth_ = 1U;

    // localTagDepth 0
    channel.peerTagDepth_ = invalidQueueDepth;
    EXPECT_EQ(entity.Init(FsmState::FSM_IDLE_STATE, EntityDirection::DIRECTION_SEND), FsmStatus::FSM_FAILED);
    entity.Uninit();
    channel.peerTagDepth_ = 1U;

    // create queue fail
    MOCKER(halQueueCreate).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(entity.Init(FsmState::FSM_IDLE_STATE, EntityDirection::DIRECTION_SEND), FsmStatus::FSM_FAILED);
    entity.Uninit();

    MOCKER(HcclIsend).stubs().will(returnValue(1));
    EXPECT_EQ(entity.Init(FsmState::FSM_WAIT_PUSH_STATE, EntityDirection::DIRECTION_RECV), FsmStatus::FSM_FAILED);

    RequestInfo info = {};
    info.mbuf = (Mbuf*)1;
    RequestInfo *invalidPtr = nullptr;
    MOCKER_CPP(&CommChannelQueue<RequestInfo>::IsEmpty).stubs().will(returnValue(false));
    MOCKER_CPP(&CommChannelQueue<RequestInfo>::Front).stubs().will(returnValue(&info)).then(returnValue(invalidPtr));
    MOCKER_CPP(&CommChannelQueue<RequestInfo>::Pop).stubs().will(returnValue(0));
    entity.Uninit();
}

TEST_F(EntitySTest, ChannelEntity_CreateAndSubscribeCompletedQueue_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    // GetSubscriber fail
    auto &subscribers = bqs::Subscribers::GetInstance();
    subscribers.subscribeManagers_.clear();
    EXPECT_EQ(entity.CreateAndSubscribeCompletedQueue(), FsmStatus::FSM_FAILED);

    // subscribe fail
    subscribers.InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
    MOCKER(halQueueSubscribe).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    MOCKER(halQueueSubEvent).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(entity.CreateAndSubscribeCompletedQueue(), FsmStatus::FSM_FAILED);
    subscribers.subscribeManagers_.clear();
    // fail uninit for GetSubscriber fail
    EXPECT_EQ(entity.Uninit(), FsmStatus::FSM_FAILED);
}

TEST_F(EntitySTest, ChannelEntity_DoProbe_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    int32_t probeFlag = 1;
    MOCKER(HcclImprobe)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&probeFlag), mockcpp::any(), mockcpp::any())
        .will(returnValue(1))
        .then(returnValue(0));
    uint64_t dataCount = 0U;
    HcclMessage msg = {};
    uint64_t probeSuccTick = 0U;
    EXPECT_EQ(entity.DoProbe(dataCount, msg, probeSuccTick), FsmStatus::FSM_FAILED);

    MOCKER(HcclGetCount).stubs().will(returnValue(1));
    EXPECT_EQ(entity.DoProbe(dataCount, msg, probeSuccTick), FsmStatus::FSM_FAILED);
}

TEST_F(EntitySTest, ChannelEntity_Probe_Fail_Cache)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    int32_t probeFlag = 1;
    MOCKER(HcclImprobe)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP(&probeFlag), mockcpp::any(), mockcpp::any())
        .will(returnValue(0));
    MOCKER(HcclGetCount).stubs().will(returnValue(0));
    uint64_t dataCount = 0U;
    HcclMessage msg = {};
    uint64_t probeSuccTick = 0U;
    EXPECT_EQ(entity.Probe(dataCount, msg, probeSuccTick), FsmStatus::FSM_FAILED);
}

TEST_F(EntitySTest, ChannelEntity_ReceiveDataForLink_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    auto &subscribers = bqs::Subscribers::GetInstance();
    subscribers.InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
    EXPECT_EQ(entity.Init(FsmState::FSM_IDLE_STATE, EntityDirection::DIRECTION_SEND), FsmStatus::FSM_SUCCESS);

    MOCKER(HcclImrecv).stubs().will(returnValue(1)).then(returnValue(0));
    HcclMessage msg = {};
    EXPECT_EQ(entity.ReceiveDataForLink(msg), FsmStatus::FSM_FAILED);

    // push uncompReqQueue_ to full
    EXPECT_EQ(entity.ReceiveDataForLink(msg), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(entity.ReceiveDataForLink(msg), FsmStatus::FSM_SUCCESS);
    // fail for uncompReqQueue_ full
    EXPECT_EQ(entity.ReceiveDataForLink(msg), FsmStatus::FSM_FAILED);
    entity.Uninit();
    subscribers.subscribeManagers_.clear();
}

TEST_F(EntitySTest, ChannelEntity_ReceiveMbufData_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    auto &subscribers = bqs::Subscribers::GetInstance();
    subscribers.InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
    EXPECT_EQ(entity.Init(FsmState::FSM_IDLE_STATE, EntityDirection::DIRECTION_SEND), FsmStatus::FSM_SUCCESS);

    uint32_t placeHolder = 0U;
    void *ptr = (void*)&placeHolder;
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .with(mockcpp::any(), outBoundP(&ptr), mockcpp::any())
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NO_DEVICE)))
        .then(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    MOCKER(halMbufGetBuffAddr).stubs().with(mockcpp::any(), outBoundP(&ptr))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    HcclMessage msg = {};
    // AllocMbuf fail
    entity.procEnvelopeCount_ = 100U;
    EXPECT_EQ(entity.ReceiveData(msg, 1U, 0U), FsmStatus::FSM_FAILED);

    MOCKER(HcclImrecv).stubs().will(returnValue(1)).then(returnValue(1)).then(returnValue(0));
    // HcclImrecv fail
    EXPECT_EQ(entity.ReceiveMbufData(msg), FsmStatus::FSM_FAILED);
    entity.hcclData_.mbuf = (Mbuf*) ptr;
    EXPECT_EQ(entity.ReceiveMbufHead(msg), FsmStatus::FSM_FAILED);

    // push uncompReqQueue_ to full
    EXPECT_EQ(entity.ReceiveMbufData(msg), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(entity.ReceiveMbufHead(msg), FsmStatus::FSM_SUCCESS);
    // fail for uncompReqQueue_ full
    EXPECT_EQ(entity.ReceiveMbufData(msg), FsmStatus::FSM_FAILED);
    EXPECT_EQ(entity.ReceiveMbufHead(msg), FsmStatus::FSM_FAILED);
    entity.Uninit();
    subscribers.subscribeManagers_.clear();
}

TEST_F(EntitySTest, ChannelEntity_DoSendData_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    ChannelEntity entity(material, 0U);
    entity.uncompReqQueue_.Init(1);
    bqs::BqsMsprofManager::GetInstance().isRun_ = true;
    // SendMbufData fail
    EXPECT_EQ(FsmStatus::FSM_DEST_FULL, entity.DoSendData(nullptr));
    // SendMbufHead fail
    entity.mbufDataSend_ = true;
    EXPECT_EQ(FsmStatus::FSM_DEST_FULL, entity.DoSendData(nullptr));

    entity.Uninit();
    bqs::BqsMsprofManager::GetInstance().isRun_ = false;
}

TEST_F(EntitySTest, ChannelEntity_SendDataWithHccl_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    entity.uncompReqQueue_.Init(1);

    MOCKER(HcclIsend)
        .stubs()
        .will(returnValue(20))
        .then(returnValue(1))
        .then(returnValue(0));
    // HcclIsend HCCL_E_AGAIN
    EXPECT_EQ(FsmStatus::FSM_DEST_FULL, entity.SendDataWithHccl(nullptr, 1, nullptr));
    // HcclIsend err
    EXPECT_EQ(FsmStatus::FSM_ERROR_PENDING, entity.SendDataWithHccl(nullptr, 1, nullptr));
    // uncompReqQueue full
    EXPECT_EQ(FsmStatus::FSM_ERROR_PENDING, entity.SendDataWithHccl(nullptr, 1, nullptr));
    entity.Uninit();
}

TEST_F(EntitySTest, ChannelEntity_SendMbufData_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    entity.uncompReqQueue_.Init(1);

    // uncompReqQueue full
    EXPECT_EQ(FsmStatus::FSM_DEST_FULL, entity.SendMbufData(nullptr));

    uint32_t placeHolder = 0U;
    void *dataPtr = (void*)&placeHolder;
    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP(&dataPtr))
        .will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(HcclIsend).stubs().will(returnValue(20));
    entity.uncompReqQueue_.Uninit();
    entity.uncompReqQueue_.Init(2);
    // HcclIsend HCCL_E_AGAIN
    EXPECT_EQ(FsmStatus::FSM_DEST_FULL, entity.SendMbufData(nullptr));
    EXPECT_EQ(FsmStatus::FSM_DEST_FULL, entity.SendMbufHead(nullptr));
    entity.uncompReqQueue_.Uninit();
}

TEST_F(EntitySTest, ChannelEntity_SendDataForLink_Fail)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    ChannelEntity entity(material, 0U);
    EXPECT_EQ(entity.GetCommChannel(), &channel);
    entity.uncompReqQueue_.Init(1);

    MOCKER(HcclIsend).stubs().will(returnValue(1)).then(returnValue(0));
    // hccl send fail
    EXPECT_EQ(entity.SendDataForLink(), FsmStatus::FSM_FAILED);
    // uncompReqQueue full
    EXPECT_EQ(entity.SendDataForLink(), FsmStatus::FSM_FAILED);

    HcclRequest req = {};
    EXPECT_EQ(entity.ProcessLinkRequest(req, 1.0), FsmStatus::FSM_FAILED);
    entity.uncompReqQueue_.Uninit();
}

TEST_F(EntitySTest, ChannelEntity_ProcessCompReq_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    ChannelEntity entity(material, 0U);
    entity.uncompReqQueue_.Init(1);
    EXPECT_EQ(entity.ProcessCompReq(), FsmStatus::FSM_FAILED);
    entity.uncompReqQueue_.Uninit();
}

TEST_F(EntitySTest, ChannelEntity_ProcessCompReq_Success)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    ChannelEntity entity(material, 0U);
    entity.compReqCount_ = 100;
    RequestInfo info = {};
    MOCKER_CPP(&CommChannelQueue<RequestInfo>::Front).stubs().will(returnValue(&info));
    MOCKER_CPP(&CommChannelQueue<RequestInfo>::Pop).stubs().will(returnValue(0));
    EXPECT_EQ(entity.ProcessCompReq(), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, ChannelEntity_ProcessSendCompletion_Error)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    ChannelEntity entity(material, 0U);
    MOCKER(halMbufGetBuffSize)
        .stubs()
        .will(returnValue((int)DRV_ERROR_NO_DEVICE))
        .then(returnValue((int)DRV_ERROR_NONE));
    // return for halMbufGetBuffSize fail
    EXPECT_EQ(entity.ProcessSendCompletion(nullptr), FsmStatus::FSM_SUCCESS);

    MbufTypeInfo typeInfo = {};
    typeInfo.type = static_cast<uint32_t>(MBUF_CREATE_BY_BUILD);
    void *ptr = reinterpret_cast<void*>(&typeInfo);
    MOCKER(halBuffGetInfo)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
              outBoundP(ptr, sizeof(MbufTypeInfo)), mockcpp::any())
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halMbufUnBuild).stubs().will(returnValue((int)DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(entity.ProcessSendCompletion(nullptr), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, Entity_AllowDeque)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    SimpleEntity entity(material, 0U);
    entity.scheduleCount_ = 100U;
    EXPECT_EQ(entity.AllowDeque(), FsmStatus::FSM_FAILED);

    DynamicRequestPtr requests = nullptr;
    uint32_t schedCfgKey = 0U;
    entity.ReprocessInTryPush(entity, requests, schedCfgKey);
}

TEST_F(EntitySTest, Entity_SendData)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    material.localInstanceIndex = 1U;
    dgw::EntityPtr group = std::make_shared<dgw::GroupEntity>(material, 0U);
    EXPECT_EQ(group->SendData(nullptr), FsmStatus::FSM_SUCCESS);

    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    dgw::EntityPtr entity = std::make_shared<dgw::SimpleEntity>(material, 0U);
    EXPECT_FALSE(entity->UpdateSendObject(group, entity));
}

TEST_F(EntitySTest, EntityManager_RepeatedCreateGroup)
{
    EntityManager entityManager(0U);
    uint32_t groupId = 0U;
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    dgw::EntityPtr entity1 = std::make_shared<dgw::SimpleEntity>(material, 0U);

    material.id = 1002U;
    dgw::EntityPtr entity2 = std::make_shared<dgw::SimpleEntity>(material, 0U);
    std::vector<EntityPtr> entitiesInGroup = {entity1, entity2};
    EXPECT_EQ(entityManager.CreateGroup(groupId, entitiesInGroup), FsmStatus::FSM_SUCCESS);

    // repeated create
    EXPECT_EQ(entityManager.CreateGroup(groupId, entitiesInGroup), FsmStatus::FSM_SUCCESS);

    EXPECT_EQ(entityManager.DeleteGroup(groupId), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, EntityManager_RepeatedCreateEntity)
{
    EntityManager entityManager(0U);
    EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    EXPECT_NE(entityManager.CreateEntity(material), nullptr);

    // repeated create
    EXPECT_NE(entityManager.CreateEntity(material), nullptr);

    EXPECT_EQ(FsmStatus::FSM_SUCCESS, entityManager.DeleteEntity(
        material.queueType, material.resId, material.eType, material.id, material.direction));

    material.direction = EntityDirection::DIRECTION_RECV;
    EXPECT_NE(entityManager.CreateEntity(material), nullptr);

    EXPECT_EQ(FsmStatus::FSM_SUCCESS, entityManager.DeleteEntity(
        material.queueType, material.resId, material.eType, material.id, material.direction));
    EXPECT_EQ(FsmStatus::FSM_SUCCESS, entityManager.DeleteEntity(
        material.queueType, material.resId, material.eType, material.id, EntityDirection::DIRECTION_SEND));
}

TEST_F(EntitySTest, EntityManager_CreateEntity_Fail_For_Init)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 8U * 1024U + 1U, 1U);
    EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    EXPECT_EQ(EntityManager::Instance(0U).CreateEntity(material), nullptr);
}

TEST_F(EntitySTest, EntityManager_CreateEntity_Fail_For_AllocEntity)
{
    EntityManager entityManager(0U);
    EntityMaterial material = {};
    EntityPtr nullEntity = nullptr;
    MOCKER_CPP(&EntityManager::AllocEntity).stubs().will(returnValue(nullEntity));
    EXPECT_EQ(entityManager.CreateEntity(material), nullptr);
}

TEST_F(EntitySTest, EntityManager_CreateEntity_AllocEntity_throw)
{
    EntityManager entityManager(0U);
    EntityMaterial material = {};
    std::bad_alloc badAllocException;
    MOCKER_CPP(&EntityManager::DoAllocEntity).stubs().will(throws(badAllocException));
    EXPECT_EQ(entityManager.AllocEntity(material), nullptr);
}

TEST_F(EntitySTest, EntityManager_SupplyEvent)
{
    EntityManager entityManager(1U);
    EXPECT_EQ(FsmStatus::FSM_SUCCESS, entityManager.SupplyEvent(static_cast<uint32_t>(EVENT_RECV_REQUEST_MSG)));
    MOCKER(halEschedSubmitEvent).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(FsmStatus::FSM_FAILED, entityManager.SupplyEvent(static_cast<uint32_t>(EVENT_RECV_REQUEST_MSG)));
}

TEST_F(EntitySTest, SupplyEventForRecvRequest)
{
    EntityManager entityManager(0U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    auto entity = std::make_shared<dgw::ChannelEntity>(material, 0U);
    entityManager.srcCommChannels_.entities.emplace_back(entity);
    MOCKER_CPP(&ChannelEntity::CheckRecvReqEventContinue).stubs().will(returnValue(true));
    EXPECT_EQ(FsmStatus::FSM_SUCCESS,
        entityManager.SupplyEventForRecvRequest(static_cast<uint32_t>(EVENT_RECV_REQUEST_MSG)));
}

TEST_F(EntitySTest, GroupEntity_SelectSrcEntity_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    GroupEntity group(material, 0U);
    FsmStatus status = FsmStatus::FSM_SUCCESS;
    EXPECT_EQ(group.SelectSrcEntity(status), nullptr);

    auto &entityManager = EntityManager::Instance(0U);
    uint32_t groupId = 0U;
    std::vector<EntityPtr> entitiesInGroup = {nullptr};
    EXPECT_EQ(entityManager.CreateGroup(groupId, entitiesInGroup), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(group.SelectSrcEntity(status), nullptr);

    EXPECT_EQ(entityManager.DeleteGroup(groupId), FsmStatus::FSM_SUCCESS);

    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    dgw::EntityPtr entity1 = std::make_shared<dgw::SimpleEntity>(material, 0U);

    material.id = 1002U;
    dgw::EntityPtr entity2 = std::make_shared<dgw::SimpleEntity>(material, 0U);
    std::vector<EntityPtr> entitiesInGroup1 = {entity1, entity2};
    EXPECT_EQ(entityManager.CreateGroup(groupId, entitiesInGroup1), FsmStatus::FSM_SUCCESS);
    entity1->curState_ = FsmState::FSM_PEEK_STATE;
    entity1->transId_ = 2U;
    int32_t srcStatus = 1;
    MOCKER(halQueueGetStatus)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(),
              outBoundP((void*)&srcStatus, sizeof(int32_t)))
        .will(returnValue(DRV_ERROR_NONE));
    group.groupInfo_.timeout = 1;
    EXPECT_NE(group.SelectSrcEntity(status), nullptr);

    MOCKER(halQueueDeQueue).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(group.ClearQueue(), FsmStatus::FSM_FAILED);
    EXPECT_EQ(entityManager.DeleteGroup(groupId), FsmStatus::FSM_SUCCESS);

    DynamicRequestPtr dynamicRequest = nullptr;
    uint32_t schedCfgKey = 0U;
    group.ReprocessInTryPush(*entity1, dynamicRequest, schedCfgKey);
}

TEST_F(EntitySTest, GroupEntity_SelectDstEntities_Fail_For_UnknownStrategy)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_GROUP;
    GroupEntity group(material, 0U);
    Strategy *strategy = nullptr;
    MOCKER_CPP(&StrategyManager::GetStrategy).stubs().will(returnValue(strategy));
    std::vector<Entity*> entityVec;
    group.SelectDstEntities(0U, entityVec, entityVec, entityVec);
    EXPECT_TRUE(entityVec.empty());
}

TEST_F(EntitySTest, SimpleEntity_RefreshWithData_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.id = 1001U;
    SimpleEntity entity(material, 0U);
    entity.needTransId_ = true;
    MOCKER(halMbufGetPrivInfo).stubs().will(returnValue(1));
    EXPECT_EQ(entity.RefreshWithData(), FsmStatus::FSM_FAILED);
}

TEST_F(EntitySTest, SimpleEntity_SendData_Full)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    SimpleEntity dstEntity1(material, 0U);

    material.id = 1U;
    SimpleEntity dstEntity2(material, 0U);

    material.id = 2U;
    SimpleEntity srcEntity(material, 0U);
    Mbuf *mbuf = (Mbuf*)1;
    auto dataObj = DataObjManager::Instance().CreateDataObj(&srcEntity, mbuf);
    dataObj->AddRecvEntity(&dstEntity1);
    dataObj->AddRecvEntity(&dstEntity2);

    Mbuf *copyMbuf = (Mbuf*)2;
    MOCKER(halMbufCopyRef)
        .stubs()
        .with(mockcpp::any(), outBoundP(&copyMbuf))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(halQueueEnQueue).stubs().will(returnValue(DRV_ERROR_QUEUE_FULL));
    EXPECT_EQ(dstEntity1.SendData(dataObj), FsmStatus::FSM_DEST_FULL);
}

TEST_F(EntitySTest, SimpleEntity_DoSendData_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    SimpleEntity dstEntity1(material, 0U);
    MOCKER(halQueueEnQueue).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(dstEntity1.DoSendData(nullptr), FsmStatus::FSM_FAILED);
}

TEST_F(EntitySTest, SimpleEntity_SdmaCopyData_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    SimpleEntity dstEntity1(material, 0U);
    EXPECT_EQ(dstEntity1.SdmaCopyData(nullptr, 0U, nullptr), FsmStatus::FSM_FAILED);

    EXPECT_EQ(dstEntity1.SdmaCopyHead(nullptr, 1U, nullptr), FsmStatus::FSM_FAILED);
}

TEST_F(EntitySTest, SimpleEntity_PauseSubscribe_Fail)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    SimpleEntity entity(material, 0U);
    entity.subscribeStatus_ = SubscribeStatus::SUBSCRIBE_RESUME;
    EXPECT_EQ(entity.PauseSubscribe(entity), FsmStatus::FSM_FAILED);

    auto &subscribers = bqs::Subscribers::GetInstance();
    subscribers.InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
    entity.subscribeStatus_ = SubscribeStatus::SUBSCRIBE_PAUSE;
    EXPECT_EQ(entity.ResumeSubscribe(entity), FsmStatus::FSM_SUCCESS);
}

TEST_F(EntitySTest, SimpleEntity_ClearQueue_Success)
{
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    SimpleEntity entity(material, 0U);

    material.id = 1U;
    SimpleEntity dstEntity(material, 0U);

    material.id = 2U;
    SimpleEntity entity1(material, 0U);
    void *ptr = (void*)1;
    MOCKER(halQueueDeQueue)
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBoundP(&ptr))
        .will(returnValue(DRV_ERROR_NONE))
        .then(returnValue(DRV_ERROR_QUEUE_EMPTY));

    auto dataObj = DataObjManager::Instance().CreateDataObj(&entity, (Mbuf*)ptr);
    dataObj->AddRecvEntity(&dstEntity);

    auto dataObj1 = DataObjManager::Instance().CreateDataObj(&entity1, (Mbuf*)ptr);
    dataObj1->AddRecvEntity(&dstEntity);
    EXPECT_EQ(entity.AddDataObjToSendList(dataObj), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(dstEntity.AddDataObjToRecvList(dataObj), FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(dstEntity.AddDataObjToRecvList(dataObj1), FsmStatus::FSM_SUCCESS);

    EXPECT_EQ(entity.ClearQueue(), FsmStatus::FSM_SUCCESS);
}