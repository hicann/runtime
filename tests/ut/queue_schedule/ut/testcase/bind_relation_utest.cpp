/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sstream>
#define private public
#define protected public
#include "server/bind_relation.h"
#include "hccl_process.h"
#include "subscribe_manager.h"
#include "client_entity.h"
#undef protected
#undef private

#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "state_define.h"
#include "entity_manager.h"

namespace bqs {
    class BindRelationUTest : public testing::Test {
    protected:
        static void SetUpTestCase()
        {
            GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
            Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
            std::cout << "BindRelationUTest SetUpTestCase" << std::endl;
        }

        static void TearDownTestCase()
        {
            Subscribers::GetInstance().subscribeManagers_.clear();
            GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
            std::cout << "BindRelationUTest TearDownTestCase" << std::endl;
        }

        virtual void SetUp()
        {
        }

        virtual void TearDown()
        {
            GlobalMockObject::verify();
        }

    protected:
        BindRelation relation_;
    };

    drvError_t halQueueSubscribeFail(struct QueueSubPara *subPara) {
        return (subPara->eventType == QUEUE_ENQUE_EVENT) ? DRV_ERROR_QUEUE_INNER_ERROR : DRV_ERROR_NONE;
    }

    drvError_t halQueueUnSubscribeFail(struct QueueUnsubPara *unsubPara) {
        return (unsubPara->eventType == QUEUE_ENQUE_EVENT) ? DRV_ERROR_QUEUE_INNER_ERROR : DRV_ERROR_NONE;
    }

    TEST_F(BindRelationUTest, BindRelation_TEST_SUCCESS)
    {
        auto entity1 = EntityInfo(1U, 0U);
        auto entity12 = EntityInfo(12U, 0U);
        auto bqsStatus = relation_.Bind(entity1, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity13 = EntityInfo(13U, 0U);
        bqsStatus = relation_.Bind(entity1, entity13);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity2 = EntityInfo(2U, 0U);
        auto entity21 = EntityInfo(21U, 0U);
        bqsStatus = relation_.Bind(entity2, entity21);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity22 = EntityInfo(22U, 0U);
        bqsStatus = relation_.Bind(entity2, entity22);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        // Queue scheduling n to 1
        auto entity4 = EntityInfo(4U, 0U);
        bqsStatus = relation_.Bind(entity4, entity22);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity5 = EntityInfo(5U, 0U);
        bqsStatus = relation_.Bind(entity5, entity22);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        // repeat bind
        bqsStatus = relation_.Bind(entity1, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity16 = EntityInfo(16U, 0U);
        bqsStatus = relation_.Bind(entity12, entity16);
        EXPECT_EQ(bqsStatus, BQS_STATUS_PARAM_INVALID);

        auto entity19 = EntityInfo(19U, 0U);
        bqsStatus = relation_.Bind(entity19, entity1);
        EXPECT_EQ(bqsStatus, BQS_STATUS_PARAM_INVALID);

        auto entity3 = EntityInfo(3U, 0U);
        bqsStatus = relation_.Bind(entity3, entity3);
        EXPECT_EQ(bqsStatus, BQS_STATUS_PARAM_INVALID);

        bqsStatus = relation_.Bind(entity2, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBind(entity2, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBind(entity1, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        // repeat
        bqsStatus = relation_.UnBind(entity1, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBindByDst(entity13);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        // repeat
        bqsStatus = relation_.UnBindByDst(entity13);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBindByDst(entity22);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBindBySrc(entity2);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        // repeat
        bqsStatus = relation_.UnBindBySrc(entity2);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
    }

    TEST_F(BindRelationUTest, BindRelation_halQueueSubscribe_FAILED)
    {
        auto entity1 = EntityInfo(1U, 0U);
        auto entity11 = EntityInfo(11U, 0U);
        auto bqsStatus = relation_.Bind(entity1, entity11);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        MOCKER(halQueueSubEvent).stubs().will(invoke(halQueueSubscribeFail));
        auto entity12 = EntityInfo(12U, 0U);
        bqsStatus = relation_.Bind(entity1, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        auto entity2 = EntityInfo(2U, 0U);
        auto entity21 = EntityInfo(21U, 0U);
        bqsStatus = relation_.Bind(entity2, entity21);
        EXPECT_EQ(bqsStatus, BQS_STATUS_DRIVER_ERROR);
    }

    TEST_F(BindRelationUTest, CheckMultiLayerBind_success)
    {
        GlobalMockObject::verify();
        EntityInfo src(6U, 0U);
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        EntityInfo dest(31U, 0U, &args);
        relation_.srcToDstRelation_[src] = {dest};
        EntityInfo src2(5U, 0U);
        EntityInfo dst2(6U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, relation_.CheckMultiLayerBind(src2, dst2, 0));
    }

    TEST_F(BindRelationUTest, BindRelation_halQueueUnsubscribe_FAILED)
    {
        MOCKER(halQueueUnsubEvent).stubs().will(invoke(halQueueUnSubscribeFail));

        auto entity1 = EntityInfo(1U, 0U);
        auto entity11 = EntityInfo(11U, 0U);
        auto bqsStatus = relation_.Bind(entity1, entity11);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        auto entity2 = EntityInfo(2U, 0U);
        auto entity21 = EntityInfo(21U, 0U);
        auto entity22 = EntityInfo(22U, 0U);
        bqsStatus = relation_.Bind(entity2, entity21);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        bqsStatus = relation_.Bind(entity2, entity22);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBindBySrc(EntityInfo(1U, 0U));
        EXPECT_EQ(bqsStatus, BQS_STATUS_DRIVER_ERROR);

        bqsStatus = relation_.UnBindByDst(EntityInfo(21U, 0U));
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        bqsStatus = relation_.UnBindByDst(EntityInfo(22U, 0U));
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
    }

    TEST_F(BindRelationUTest, BindRelation_MULTI_BIND)
    {
        relation_.srcToDstRelation_[EntityInfo(1U, 0U)] = {EntityInfo(3U, 0U)};
        relation_.srcToDstRelation_[EntityInfo(2U, 0U)] = {EntityInfo(3U, 0U)};
        relation_.srcToDstRelation_[EntityInfo(3U, 0U)] = {EntityInfo(4U, 0U)};

        relation_.dstToSrcRelation_[EntityInfo(3U, 0U)] = {EntityInfo(1U, 0U)};
        relation_.dstToSrcRelation_[EntityInfo(4U, 0U)] = {EntityInfo(3U, 0U)};

        relation_.Order();
        EXPECT_EQ(relation_.srcToDstRelation_.size(), 3);
    }

    TEST_F(BindRelationUTest, UpdateSubscribe_Success01)
    {
        std::vector<EntityInfoPtr> entities;
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(1001U, 0U, &args);
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(2001U, 0U);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);

        auto &allGroupConfig = BindRelation::GetInstance().allGroupConfig_;
        allGroupConfig.emplace(std::make_pair(1, entities));

        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo subscribeEntity(1U, 0U, &args);
        auto ret = BindRelation::GetInstance().UpdateSubscribeEvent(subscribeEntity, EventType::ENQUEUE);
        EXPECT_EQ(ret, BQS_STATUS_OK);

        ret = BindRelation::GetInstance().UpdateSubscribeEvent(subscribeEntity, EventType::F2NF);
        EXPECT_EQ(ret, BQS_STATUS_OK);
    }

    TEST_F(BindRelationUTest, BindRelation_DeleteEntity_Success_NonExsist) {
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo info(0U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, BindRelation::GetInstance().DeleteEntity(info, true));
    }

    TEST_F(BindRelationUTest, CheckEntityExistInGroup_fail) {
        // 1.bind q1 -> q2 success
        auto entity1 = EntityInfo(1U, 0U);
        auto entity2 = EntityInfo(2U, 0U);
        EXPECT_EQ(relation_.Bind(entity1, entity2), BQS_STATUS_OK);

        // 2.bind g1{q1, q3} -> q4 fail
        std::vector<EntityInfoPtr> entitiesForG1;
        EntityInfoPtr entityPtr1 = std::make_shared<EntityInfo>(1U, 0U);
        EntityInfoPtr entityPtr3 = std::make_shared<EntityInfo>(3U, 0U);
        entitiesForG1.emplace_back(entityPtr1);
        entitiesForG1.emplace_back(entityPtr3);
        uint32_t groupId1 = 0U;
        EXPECT_EQ(relation_.CreateGroup(entitiesForG1, groupId1), BQS_STATUS_OK);
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        auto group1 = EntityInfo(groupId1, 0U, &args);
        auto entity4 = EntityInfo(4U, 0U);
        EXPECT_EQ(relation_.CheckEntityExistInGroup(group1, entity4), BQS_STATUS_PARAM_INVALID);

        // 3. bind g2{q5, q6} -> q7 success
        std::vector<EntityInfoPtr> entitiesForG2;
        EntityInfoPtr entityPtr5 = std::make_shared<EntityInfo>(5U, 0U);
        EntityInfoPtr entityPtr6 = std::make_shared<EntityInfo>(6U, 0U);
        entitiesForG2.emplace_back(entityPtr5);
        entitiesForG2.emplace_back(entityPtr6);
        uint32_t groupId2 = 0U;
        EXPECT_EQ(relation_.CreateGroup(entitiesForG2, groupId2), BQS_STATUS_OK);
        auto group2 = EntityInfo(groupId2, 0U, &args);
        auto entity7 = EntityInfo(7U, 0U);
        EXPECT_EQ(relation_.Bind(group2, entity7), BQS_STATUS_OK);

        // 4. bind q5 -> q8 fail
        auto entity5 = EntityInfo(5U, 0U);
        auto entity8 = EntityInfo(8U, 0U);
        EXPECT_EQ(relation_.CheckEntityExistInGroup(entity5, entity8), BQS_STATUS_PARAM_INVALID);

        // 5.bind q11 -> q12 success
        auto entity11 = EntityInfo(11U, 0U);
        auto entity12 = EntityInfo(12U, 0U);
        EXPECT_EQ(relation_.Bind(entity11, entity12), BQS_STATUS_OK);

        // 6.bind q14 -> g1{q12, q13} fail
        std::vector<EntityInfoPtr> entitiesForG11;
        EntityInfoPtr entityPtr12 = std::make_shared<EntityInfo>(12U, 0U);
        EntityInfoPtr entityPtr13 = std::make_shared<EntityInfo>(13U, 0U);
        entitiesForG11.emplace_back(entityPtr12);
        entitiesForG11.emplace_back(entityPtr13);
        uint32_t groupId11 = 0U;
        EXPECT_EQ(relation_.CreateGroup(entitiesForG11, groupId11), BQS_STATUS_OK);
        auto group11 = EntityInfo(groupId11, 0U, &args);
        auto entity14 = EntityInfo(14U, 0U);
        EXPECT_EQ(relation_.CheckEntityExistInGroup(entity14, group11), BQS_STATUS_PARAM_INVALID);

        // 7. bind q17 -> g12{q15, q16} success
        std::vector<EntityInfoPtr> entitiesForG12;
        EntityInfoPtr entityPtr15 = std::make_shared<EntityInfo>(15U, 0U);
        EntityInfoPtr entityPtr16 = std::make_shared<EntityInfo>(16U, 0U);
        entitiesForG12.emplace_back(entityPtr15);
        entitiesForG12.emplace_back(entityPtr16);
        uint32_t groupId12 = 0U;
        EXPECT_EQ(relation_.CreateGroup(entitiesForG12, groupId12), BQS_STATUS_OK);
        auto group12 = EntityInfo(groupId12, 0U, &args);
        auto entity17 = EntityInfo(17U, 0U);
        EXPECT_EQ(relation_.Bind(entity17, group12), BQS_STATUS_OK);

        // 8. bind q18 -> q15 fail
        auto entity15 = EntityInfo(15U, 0U);
        auto entity18 = EntityInfo(18U, 0U);
        EXPECT_EQ(relation_.CheckEntityExistInGroup(entity18, entity15), BQS_STATUS_PARAM_INVALID);
    }

    TEST_F(BindRelationUTest, CreateEntity_SUCCESS)
    {
        auto src = EntityInfo(1U, 0U);
        auto dst = EntityInfo(2U, 0U);
        EXPECT_EQ(relation_.CreateEntity(src, dst), BQS_STATUS_OK);
    }

    TEST_F(BindRelationUTest, CreateEntity_FAIL)
    {
        dgw::EntityPtr entity = nullptr;
        MOCKER_CPP(&dgw::EntityManager::GetEntityById).stubs().will(returnValue(entity));
        auto src = EntityInfo(1U, 0U);
        auto dst = EntityInfo(2U, 0U);
        EXPECT_EQ(relation_.CreateEntity(src, dst), BQS_STATUS_INNER_ERROR);
    }

    TEST_F(BindRelationUTest, channelSendData_failed)
    {
        uint64_t hcclHandle = 100UL;
        HcclComm hcclComm = &hcclHandle;
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        dgw::EntityMaterial material = {};
        material.eType = dgw::EntityType::ENTITY_TAG;
        material.channel = &channel;
        auto entityPtr1 = std::make_shared<dgw::ChannelEntity>(material, 0U);
        entityPtr1->linkStatus_ = dgw::ChannelLinkStatus::ABNORMAL;
        auto ret = entityPtr1->DoSendData(nullptr);
        EXPECT_EQ(ret, dgw::FsmStatus::FSM_ERROR_PENDING);
    }

    TEST_F(BindRelationUTest, ClientQSendData_failed)
    {
        dgw::EntityMaterial material = {};
        material.eType = dgw::EntityType::ENTITY_QUEUE;
        material.queueType = bqs::CLIENT_Q;
        material.id = 10U;
        auto entityPtr = std::make_shared<dgw::ClientEntity>(material, 0U);
        entityPtr->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_DATA_SENT;
        auto ret = entityPtr->DoSendData(2);
        EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    }

    TEST_F(BindRelationUTest, PreProcessLinkSetUp)
    {
        auto &hcclProcessInstance = dgw::HcclProcess::GetInstance();
        dgw::RequestInfo hcclReq;
        hcclReq.startTick = 0;
        auto ret = hcclProcessInstance.PreProcessSetUplinkReq(&hcclReq);
        EXPECT_EQ(ret, dgw::FsmStatus::FSM_FAILED);
        hcclReq.startTick = 0xFFFFFFFFFFFFFFFF;
        ret = hcclProcessInstance.PreProcessSetUplinkReq(&hcclReq);
        EXPECT_EQ(ret, dgw::FsmStatus::FSM_FAILED);
    }

    TEST_F(BindRelationUTest, ClearInputQueue_Success)
    {
        std::unordered_set<uint32_t> rootModelSet;
        rootModelSet.insert(0U);
        rootModelSet.insert(1U);
        auto ret = BindRelation::GetInstance().ClearInputQueue(0U, rootModelSet);
        EXPECT_EQ(ret, BQS_STATUS_OK);
    }
    
    TEST_F(BindRelationUTest, BindRelation_TEST_NUMA_SUCCESS)
    {
        GlobalCfg::GetInstance().SetNumaFlag(true);
        GlobalCfg::GetInstance().RecordDeviceId(1U, 1U, 0U);
        Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{1U}, 0U);
        Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{1U}, 1U);
        dgw::EntityManager::Instance(0U).idToEntity_.clear();
        dgw::EntityManager::Instance(1U).idToEntity_.clear();
        auto entity1 = EntityInfo(1U, 0U);
        auto entity12 = EntityInfo(12U, 0U);
        auto bqsStatus = relation_.Bind(entity1, entity12, 0U);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity13 = EntityInfo(13U, 1U);
        bqsStatus = relation_.Bind(entity1, entity13, 0U);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity2 = EntityInfo(2U, 1U);
        bqsStatus = relation_.Bind(entity2, entity13, 0U);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        auto entity3 = EntityInfo(3U, 1U);
        auto entity14 = EntityInfo(14U, 1U);
        bqsStatus = relation_.Bind(entity3, entity14, 1U);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        relation_.Order(0U);
        relation_.Order(1U);

        auto entity = dgw::EntityManager::Instance(0U).GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 1,
            dgw::EntityDirection::DIRECTION_SEND);
        ASSERT_TRUE(entity != nullptr);
        EXPECT_EQ(entity->GetResIndex(), 0U);
        EXPECT_EQ(entity->GetDeviceId(), 0U);
        entity = dgw::EntityManager::Instance(0U).GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 12,
            dgw::EntityDirection::DIRECTION_RECV);
        ASSERT_TRUE(entity != nullptr);
        EXPECT_EQ(entity->GetResIndex(), 0U);
        EXPECT_EQ(entity->GetDeviceId(), 0U);
        entity = dgw::EntityManager::Instance(0U).GetEntityById(bqs::LOCAL_Q, 1, dgw::EntityType::ENTITY_QUEUE, 13,
            dgw::EntityDirection::DIRECTION_RECV);
        ASSERT_TRUE(entity != nullptr);
        EXPECT_EQ(entity->GetResIndex(), 0U);
        EXPECT_EQ(entity->GetDeviceId(), 1U);
        entity = dgw::EntityManager::Instance(0U).GetEntityById(bqs::LOCAL_Q, 1, dgw::EntityType::ENTITY_QUEUE, 2,
            dgw::EntityDirection::DIRECTION_SEND);
        ASSERT_TRUE(entity != nullptr);
        EXPECT_EQ(entity->GetResIndex(), 0U);
        EXPECT_EQ(entity->GetDeviceId(), 1U);
        entity = dgw::EntityManager::Instance(1U).GetEntityById(bqs::LOCAL_Q, 1, dgw::EntityType::ENTITY_QUEUE, 3,
            dgw::EntityDirection::DIRECTION_SEND);
        ASSERT_TRUE(entity != nullptr);
        EXPECT_EQ(entity->GetResIndex(), 1U);
        EXPECT_EQ(entity->GetDeviceId(), 1U);
        entity = dgw::EntityManager::Instance(1U).GetEntityById(bqs::LOCAL_Q, 1, dgw::EntityType::ENTITY_QUEUE, 14,
            dgw::EntityDirection::DIRECTION_RECV);
        ASSERT_TRUE(entity != nullptr);
        EXPECT_EQ(entity->GetResIndex(), 1U);
        EXPECT_EQ(entity->GetDeviceId(), 1U);

        bqsStatus = relation_.UnBind(entity1, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        // repeat
        bqsStatus = relation_.UnBind(entity1, entity12);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBind(entity1, entity13);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBindBySrc(entity2);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        // repeat
        bqsStatus = relation_.UnBind(entity3, entity14, 1U);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        bqsStatus = relation_.UnBindByDst(entity14);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);
        // repeat
        bqsStatus = relation_.UnBindByDst(entity14);
        EXPECT_EQ(bqsStatus, BQS_STATUS_OK);

        relation_.Order(0U);
        relation_.Order(1U);

        GlobalCfg::GetInstance().SetNumaFlag(false);
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    TEST_F(BindRelationUTest, BindRelation_MakeSureOutputCompletion)
    {
        MOCKER(HcclIsend).stubs().will(returnValue(0));
        std::vector<EntityInfoPtr> entitiesForG2;
        EntityInfoPtr entityPtr5 = std::make_shared<EntityInfo>(5U, 0U);
        uint64_t hcclHandle = 100UL;
        HcclComm hcclComm = &hcclHandle;
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        OptionalArg argsTag = {};
        argsTag.eType = dgw::EntityType::ENTITY_TAG;
        argsTag.channelPtr = &channel;
        EntityInfoPtr entityPtr6 = std::make_shared<EntityInfo>(6U, 0U, &argsTag);
        entitiesForG2.emplace_back(entityPtr5);
        entitiesForG2.emplace_back(entityPtr6);
        uint32_t groupId2 = 0U;
        EXPECT_EQ(relation_.CreateGroup(entitiesForG2, groupId2), BQS_STATUS_OK);
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        auto group2 = EntityInfo(groupId2, 0U, &args);
        auto entity7 = EntityInfo(7U, 0U);
        EXPECT_EQ(relation_.Bind(entity7, group2), BQS_STATUS_OK);
        relation_.Order();

        dgw::ChannelEntityPtr channelEntity = std::dynamic_pointer_cast<dgw::ChannelEntity>(
            dgw::EntityManager::Instance(0U).GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, 6,
            dgw::EntityDirection::DIRECTION_RECV));
        ASSERT_TRUE(channelEntity != nullptr);
        dgw::RequestInfo req = {};
        channelEntity->uncompReqQueue_.Push(req);

        std::unordered_set<uint32_t> rootModelSet;
        rootModelSet.insert(0U);
        relation_.MakeSureOutputCompletion(0U, rootModelSet);

        EXPECT_EQ(relation_.UnBind(entity7, group2), BQS_STATUS_OK);
        relation_.Order();
    }

    TEST_F(BindRelationUTest, DeleteUnknownGroup)
    {
        BindRelation relation;
        EntityInfo groupEntity(0U, 0U);
        EXPECT_EQ(relation.CreateEntityForGroup(groupEntity, true, 0U), BQS_STATUS_INNER_ERROR);

        EXPECT_EQ(relation.DeleteGroup(0U), BQS_STATUS_OK);
    }
}