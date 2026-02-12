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
#include "channel_entity.h"
#include "entity_manager.h"
#undef protected
#undef private

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "state_define.h"

namespace bqs {
    class BindRelationSTest : public testing::Test {
    protected:
        virtual void SetUp()
        {
        }

        virtual void TearDown()
        {
            GlobalMockObject::verify();
        }

        static void SetUpTestCase()
        {
            GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
            Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
            std::cout << "BindRelationSTest SetUpTestCase" << std::endl;
        }

        static void TearDownTestCase()
        {
            Subscribers::GetInstance().subscribeManagers_.clear();
            GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
            std::cout << "BindRelationSTest TearDownTestCase" << std::endl;
        }

        BindRelation relation_;
    };

    TEST_F(BindRelationSTest, BindRelation_DeleteEntity_Success_NonExsist) {
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo info(0U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, relation_.DeleteEntity(info, true));
    }

    TEST_F(BindRelationSTest, BindRelation_DuplicateEntity_fail) {
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
        EXPECT_EQ(relation_.Bind(group1, entity4), BQS_STATUS_PARAM_INVALID);

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
        EXPECT_EQ(relation_.Bind(entity5, entity8), BQS_STATUS_PARAM_INVALID);

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
        EXPECT_EQ(relation_.Bind(entity14, group11), BQS_STATUS_PARAM_INVALID);

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
        EXPECT_EQ(relation_.Bind(entity18, entity15), BQS_STATUS_PARAM_INVALID);

        EXPECT_EQ(relation_.UnBind(entity1, entity2), BQS_STATUS_OK);
        EXPECT_EQ(relation_.UnBind(group2, entity7), BQS_STATUS_OK);
        EXPECT_EQ(relation_.UnBind(entity11, entity12), BQS_STATUS_OK);
        EXPECT_EQ(relation_.UnBind(entity17, group12), BQS_STATUS_OK);
    }

    TEST_F(BindRelationSTest, CheckMultiLayerBind_success)
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

    TEST_F(BindRelationSTest, CreateEntity_SUCCESS)
    {
        auto src = EntityInfo(1U, 0U);
        auto dst = EntityInfo(2U, 0U);
        EXPECT_EQ(relation_.CreateEntity(src, dst), BQS_STATUS_OK);
    }

    TEST_F(BindRelationSTest, CreateEntity_FAIL)
    {
        dgw::EntityPtr entity = nullptr;
        MOCKER_CPP(&dgw::EntityManager::GetEntityById).stubs().will(returnValue(entity));
        auto src = EntityInfo(1U, 0U);
        auto dst = EntityInfo(2U, 0U);
        EXPECT_EQ(relation_.CreateEntity(src, dst), BQS_STATUS_INNER_ERROR);
    }

    TEST_F(BindRelationSTest, channelSendData_failed)
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

    TEST_F(BindRelationSTest, PreProcessLinkSetUp)
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

    TEST_F(BindRelationSTest, ClearInputQueue_Client_Empty)
    {
        OptionalArg args = {};
        args.queueType = 1U;
        EntityInfo entity5(5U, 0U, &args);
        EntityInfo entity7(7U, 0U);
        EXPECT_EQ(relation_.Bind(entity5, entity7), BQS_STATUS_OK);
        relation_.Order(0U);

        std::unordered_set<uint32_t> rootModelSet;
        rootModelSet.insert(0U);
        rootModelSet.insert(1U);

        int32_t srcStatus = 1;
        MOCKER(halQueueGetStatus)
            .stubs()
            .with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(),
                  outBoundP((void*)&srcStatus, sizeof(int32_t)))
            .will(returnValue(DRV_ERROR_NO_DEVICE))
            .then(returnValue(DRV_ERROR_NONE));

        EXPECT_EQ(relation_.ClearInputQueue(0U, rootModelSet), BQS_STATUS_INNER_ERROR);
        EXPECT_EQ(relation_.ClearInputQueue(0U, rootModelSet), BQS_STATUS_OK);
        EXPECT_EQ(relation_.UnBind(entity5, entity7), BQS_STATUS_OK);
        relation_.Order(0U);
    }

    TEST_F(BindRelationSTest, ClearInputQueue_tag_Empty)
    {
        uint64_t hcclHandle = 100UL;
        HcclComm hcclComm = &hcclHandle;
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo entity6(6U, 0U, &args);
        EntityInfo entity7(7U, 0U);
        EXPECT_EQ(relation_.Bind(entity6, entity7), BQS_STATUS_OK);
        relation_.Order(0U);

        std::unordered_set<uint32_t> rootModelSet;
        rootModelSet.insert(0U);
        rootModelSet.insert(1U);

        MOCKER(halQueueDeQueue)
            .stubs()
            .will(returnValue(DRV_ERROR_NO_DEVICE))
            .then(returnValue(DRV_ERROR_QUEUE_EMPTY));
        EXPECT_EQ(relation_.ClearInputQueue(0U, rootModelSet), BQS_STATUS_INNER_ERROR);
        EXPECT_EQ(relation_.ClearInputQueue(0U, rootModelSet), BQS_STATUS_OK);

        EXPECT_EQ(relation_.UnBind(entity6, entity7), BQS_STATUS_OK);
        relation_.Order(0U);
    }

    TEST_F(BindRelationSTest, BindRelation_MakeSureOutputCompletion)
    {
        MOCKER(HcclIsend).stubs().will(returnValue(0));
        std::vector<EntityInfoPtr> entitiesForG2;
        EntityInfoPtr entityPtr5 = std::make_shared<EntityInfo>(5U, 0U);
        uint64_t hcclHandle = 100UL;
        HcclComm hcclComm = &hcclHandle;
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfoPtr entityPtr6 = std::make_shared<EntityInfo>(6U, 0U, &args);
        entitiesForG2.emplace_back(entityPtr5);
        entitiesForG2.emplace_back(entityPtr6);
        uint32_t groupId2 = 0U;
        EXPECT_EQ(relation_.CreateGroup(entitiesForG2, groupId2), BQS_STATUS_OK);
        args.eType = dgw::EntityType::ENTITY_GROUP;
        args.channelPtr = nullptr;
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

    TEST_F(BindRelationSTest, BindRelation_Repeated_success) {
        dgw::EntityManager::Instance(0U).idToEntity_.clear();
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
        EXPECT_EQ(relation_.Bind(entity4, group1), BQS_STATUS_OK);
        relation_.Order();

        // repeated bind
        EXPECT_EQ(relation_.Bind(entity4, group1), BQS_STATUS_OK);
        relation_.Order();

        EXPECT_EQ(relation_.UnBind(entity4, group1), BQS_STATUS_OK);
        relation_.Order();

        uint32_t groupId2 = 0U;
        EXPECT_EQ(relation_.CreateGroup(entitiesForG1, groupId2), BQS_STATUS_OK);
        auto group2 = EntityInfo(groupId2, 0U, &args);
        EXPECT_EQ(relation_.Bind(group2, entity4), BQS_STATUS_OK);
        relation_.Order();

        // repeated bind
        EXPECT_EQ(relation_.Bind(group2, entity4), BQS_STATUS_OK);
        relation_.Order();

        EXPECT_EQ(relation_.UnBind(group2, entity4), BQS_STATUS_OK);
        relation_.Order();
    }
}
