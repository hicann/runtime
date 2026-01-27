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
#include <thread>
#include <chrono>

#define private public
#define protected public
//#include "easy_comm.h"

#include "bind_relation.h"
//#include "queue_manager.h"
#include "bqs_server.h"
//#include "bqs_log.h"
#include "bqs_msg.h"
//#include "bqs_status.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

class BQS_SERVER_STest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before stest" << endl;
        bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    }

    virtual void TearDown()
    {
        cout << "After stest" << endl;
        auto& bindRelation = bqs::BindRelation::GetInstance();
        bindRelation.srcToDstRelation_.clear();
        bindRelation.abnormalSrcToDst_.clear();
        bindRelation.dstToSrcRelation_.clear();
        bindRelation.abnormalDstToSrc_.clear();
        GlobalMockObject::verify();
    }
};

void BqsCheckAssign32UAddStubOverFlow(const uint32_t para1,
    const uint32_t para2, uint32_t &result, bool &onceOverFlow)
{
    onceOverFlow = true;
    return;
}

TEST_F(BQS_SERVER_STest, ParseGetBindMsgBySrcSuccess)
{
    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_BIND);
    bqs::BQSQueryMsg* bqsQueryMsg = bqsReqMsg.mutable_query_msg();
    EXPECT_NE(bqsQueryMsg, nullptr);

    bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC);
    bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
    EXPECT_NE(bqsBindQueueMsg, nullptr);

    bqsBindQueueMsg->set_src_queue_id(5);
    bqsBindQueueMsg->set_dst_queue_id(6);

    auto& bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(5U, 0U);
    auto dstEntity = bqs::EntityInfo(6U, 0U);
    auto abnormalDst = bqs::EntityInfo(7U, 0U);
    bindRelation.srcToDstRelation_[srcEntity].emplace(dstEntity);
    bindRelation.abnormalSrcToDst_[srcEntity].emplace(abnormalDst);

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 2);
}

TEST_F(BQS_SERVER_STest, ParseGetBindMsgByDstSuccess)
{
    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_BIND);
    bqs::BQSQueryMsg* bqsQueryMsg = bqsReqMsg.mutable_query_msg();
    EXPECT_NE(bqsQueryMsg, nullptr);

    bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_DST);
    bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
    EXPECT_NE(bqsBindQueueMsg, nullptr);

    bqsBindQueueMsg->set_src_queue_id(0);
    bqsBindQueueMsg->set_dst_queue_id(6);

    auto &bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(5U, 0U);
    auto dstEntity = bqs::EntityInfo(6U, 0U);
    auto abnormalSrc = bqs::EntityInfo(7U, 0U);
    bindRelation.dstToSrcRelation_[dstEntity].emplace(srcEntity);
    bindRelation.abnormalDstToSrc_[dstEntity].emplace(abnormalSrc);

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 2);
}

TEST_F(BQS_SERVER_STest, ParseGetBindMsgBySrcNoOneSuccess)
{
    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_BIND);
    bqs::BQSQueryMsg* bqsQueryMsg = bqsReqMsg.mutable_query_msg();
    EXPECT_NE(bqsQueryMsg, nullptr);

    bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC);
    bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
    EXPECT_NE(bqsBindQueueMsg, nullptr);

    bqsBindQueueMsg->set_src_queue_id(15);
    bqsBindQueueMsg->set_dst_queue_id(16);

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 0);
}

TEST_F(BQS_SERVER_STest, ParseGetBindMsgByDstNoOneSuccess)
{
    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_BIND);
    bqs::BQSQueryMsg* bqsQueryMsg = bqsReqMsg.mutable_query_msg();
    EXPECT_NE(bqsQueryMsg, nullptr);

    bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_DST);
    bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
    EXPECT_NE(bqsBindQueueMsg, nullptr);

    bqsBindQueueMsg->set_src_queue_id(15);
    bqsBindQueueMsg->set_dst_queue_id(16);

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 0);
}

TEST_F(BQS_SERVER_STest, ParseGetPagedBindMsgSuccess)
{
    bqs::BQSMsg bqsReqMsg;
    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_ALL_BIND);
    bqs::BQSPagedMsg* bqsPagedMsg = bqsReqMsg.mutable_paged_msg();
    EXPECT_NE(bqsPagedMsg, nullptr);
    bqsPagedMsg->set_offset(0);
    bqsPagedMsg->set_limit(20);

    auto &bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(5U, 0U);
    auto dstEntity = bqs::EntityInfo(6U, 0U);
    auto dstEntity1 = bqs::EntityInfo(7U, 0U);
    auto abnormalSrc = bqs::EntityInfo(8U, 0U);
    auto abnormalDst = bqs::EntityInfo(9U, 0U);
    auto abnormalDst1 = bqs::EntityInfo(10U, 0U);
    bindRelation.srcToDstRelation_[srcEntity].emplace(dstEntity);
    bindRelation.srcToDstRelation_[srcEntity].emplace(dstEntity1);
    bindRelation.abnormalSrcToDst_[abnormalSrc].emplace(abnormalDst);
    bindRelation.abnormalSrcToDst_[abnormalSrc].emplace(abnormalDst1);

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetPagedBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 4U);
    MOCKER(BqsCheckAssign32UAdd)
        .stubs()
        .will(invoke(BqsCheckAssign32UAddStubOverFlow));
    bqs::BqsServer::GetInstance().SendRspMsg(0, 0);
}

TEST_F(BQS_SERVER_STest, SendRspMsgFailForPbSerialize)
{
    MOCKER_CPP(&BQSMsg::SerializePartialToArray).stubs().will(returnValue(false));
    bqs::BqsServer::GetInstance().SendRspMsg(0, 0);
}