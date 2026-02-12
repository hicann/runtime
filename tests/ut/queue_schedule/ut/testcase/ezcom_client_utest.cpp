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
#include <securec.h>

#define private public
#define protected public
#include "easy_comm.h"

#include "ezcom_client.h"
#include "bqs_log.h"
#undef private
#undef protected

using namespace std;

class EZCOM_CLIENT_UTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before ezcom_client_utest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After ezcom_client_utest" << endl;
        GlobalMockObject::verify();
    }
};

namespace {
    int EzcomRPCSyncFake(int fd, struct EzcomRequest *req, struct EzcomResponse *resp)
    {
        std::cout << "EzcomRPCSync stub begin" << std::endl;
        resp->size = req->size;
        char *respData = new (std::nothrow) char[req->size];
        memcpy(respData, (char*)req->data, resp->size);
        resp->data = (uint8_t*)respData;
        std::cout << "EzcomRPCSync stub end" << std::endl;
        return 0;
    }

    int EzcomRPCSyncFailedFake(int fd, struct EzcomRequest *req, struct EzcomResponse *resp)
    {
        std::cout << "EzcomRPCSync stub failed begin" << std::endl;
        resp->size = req->size + 1;
        char *respData = new (std::nothrow) char[req->size];
        memcpy(respData, (char*)req->data, req->size);
        resp->data = (uint8_t*)respData;
        std::cout << "EzcomRPCSync stub end" << std::endl;
        return 0;
    }
}

TEST_F(EZCOM_CLIENT_UTest, SerializeBindMsgSuccess1)
{
    std::vector<bqs::BQSBindQueueItem> bindQueueVec;
    for (uint32_t i = 0; i < 10; i++) {
        bqs::BQSBindQueueItem tmp = {
            srcQueueId_: i,
            dstQueueId_: i + 1
        };
        bindQueueVec.push_back(tmp);
    }
    
    bqs::BQSMsg bqsReqMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SerializeBindMsg(bindQueueVec, bqsReqMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    EXPECT_EQ(bqsReqMsg.msg_type(), bqs::BQSMsg::BIND);


    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsReqMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    for (int32_t i = 0; i < bqsBindQueueMsgs->bind_queue_vec_size(); i++) {
        bqs::BQSBindQueueMsg bqsBindQueueMsg = bqsBindQueueMsgs->bind_queue_vec(i);
        uint32_t src = bqsBindQueueMsg.src_queue_id();
        uint32_t dst = bqsBindQueueMsg.dst_queue_id();

        EXPECT_EQ(src, i);
        EXPECT_EQ(dst, i + 1);
    }
}

TEST_F(EZCOM_CLIENT_UTest, SerializeBindMsgFailed1)
{
    std::vector<bqs::BQSBindQueueItem> bindQueueVec;

    bqs::BQSMsg bqsReqMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SerializeBindMsg(bindQueueVec, bqsReqMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_PARAM_INVALID);
}

TEST_F(EZCOM_CLIENT_UTest, SerializeUnbindMsgSuccess1)
{
    std::vector<bqs::BQSQueryPara> bqsQueryParaVec;
    for (uint32_t i = 0; i < 10; i++) {
        bqs::BQSBindQueueItem tmp = {
            srcQueueId_: i,
            dstQueueId_: i + 1
        };
        bqs::BQSQueryPara tmpPara = {
            keyType_: bqs::BQS_QUERY_TYPE_SRC,
            bqsBindQueueItem_: tmp
        };
        bqsQueryParaVec.push_back(tmpPara);
    }
    
    bqs::BQSMsg bqsReqMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SerializeUnbindMsg(bqsQueryParaVec, bqsReqMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    EXPECT_EQ(bqsReqMsg.msg_type(), bqs::BQSMsg::UNBIND);

    bqs::BQSQueryMsgs* bqsQueryMsgs = bqsReqMsg.mutable_query_msgs();
    EXPECT_NE(bqsQueryMsgs, nullptr);

    for (int i = 0; i < bqsQueryMsgs->query_msg_vec_size(); i++) {
        bqs::BQSQueryMsg bqsQueryMsg = bqsQueryMsgs->query_msg_vec(i);
        bqs::BQSQueryMsg::QsQueryType keyType = bqsQueryMsg.key_type();
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg.mutable_bind_queue_item();
        EXPECT_NE(bqsBindQueueMsg, nullptr);

        uint32_t src = bqsBindQueueMsg->src_queue_id();
        uint32_t dst = bqsBindQueueMsg->dst_queue_id();

        EXPECT_EQ(keyType, bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC);
        EXPECT_EQ(static_cast<size_t>(src), i);
        EXPECT_EQ(static_cast<size_t>(dst), i + 1);
    }
}

TEST_F(EZCOM_CLIENT_UTest, SerializeUnbindMsgFailed1)
{
    std::vector<bqs::BQSQueryPara> bqsQueryParaVec;

    bqs::BQSMsg bqsReqMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SerializeUnbindMsg(bqsQueryParaVec, bqsReqMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_PARAM_INVALID);
}

TEST_F(EZCOM_CLIENT_UTest, SerializeGetBindMsgSuccess1)
{
    bqs::BQSBindQueueItem tmp = {
        srcQueueId_: 5,
        dstQueueId_: 6
    };
    bqs::BQSQueryPara bqsQueryPara = {
        keyType_: bqs::BQS_QUERY_TYPE_SRC,
        bqsBindQueueItem_: tmp
    };

    bqs::BQSMsg bqsReqMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SerializeGetBindMsg(bqsQueryPara, bqsReqMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    EXPECT_EQ(bqsReqMsg.msg_type(), bqs::BQSMsg::GET_BIND);

    bqs::BQSQueryMsg* bqsQueryMsg = bqsReqMsg.mutable_query_msg();
    EXPECT_NE(bqsQueryMsg, nullptr);

    bqs::BQSQueryMsg::QsQueryType keyType = bqsQueryMsg->key_type();
    bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
    EXPECT_NE(bqsBindQueueMsg, nullptr);

    uint32_t src = bqsBindQueueMsg->src_queue_id();
    uint32_t dst = bqsBindQueueMsg->dst_queue_id();

    EXPECT_EQ(keyType, bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC);
    EXPECT_EQ(src, 5);
    EXPECT_EQ(dst, 6);
}

TEST_F(EZCOM_CLIENT_UTest, SerializeGetPagedBindMsgSuccess1)
{
    bqs::BQSMsg bqsReqMsg;
    bqs::EzcomClient::GetInstance(0)->SerializeGetPagedBindMsg(0, 0, bqsReqMsg);
    EXPECT_EQ(bqsReqMsg.msg_type(), bqs::BQSMsg::GET_ALL_BIND);
}

TEST_F(EZCOM_CLIENT_UTest, ParseBindRespMsgSuccess1)
{
    bqs::BQSMsg bqsRespMsg;
    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < 10; i++) {
        bqs::BQSBindQueueRsp* bqsBindQueueRsp = bqsBindQueueRsps->add_bind_result_vec();
        EXPECT_NE(bqsBindQueueRsp, nullptr);
        bqsBindQueueRsp->set_bind_result(0);
    }

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    uint32_t ret = bqs::EzcomClient::GetInstance(0)->ParseBindRespMsg(bqsRespMsg, bindResultVec);
    EXPECT_EQ(ret, 10);
}

TEST_F(EZCOM_CLIENT_UTest, ParseBindRespMsgSuccess2)
{
    bqs::BQSMsg bqsRespMsg;
    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < 5; i++) {
        bqs::BQSBindQueueRsp* bqsBindQueueRsp = bqsBindQueueRsps->add_bind_result_vec();
        EXPECT_NE(bqsBindQueueRsp, nullptr);
        bqsBindQueueRsp->set_bind_result(0);
    }

    for (int32_t i = 0; i < 5; i++) {
        bqs::BQSBindQueueRsp* bqsBindQueueRsp = bqsBindQueueRsps->add_bind_result_vec();
        EXPECT_NE(bqsBindQueueRsp, nullptr);
        bqsBindQueueRsp->set_bind_result(1);
    }

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    uint32_t ret = bqs::EzcomClient::GetInstance(0)->ParseBindRespMsg(bqsRespMsg, bindResultVec);
    EXPECT_EQ(ret, 5);
}

TEST_F(EZCOM_CLIENT_UTest, ParseGetBindRespMsgSuccess1)
{
    bqs::BQSMsg bqsRespMsg;
    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    for (int32_t i = 0; i < 10; i++) {
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsBindQueueMsgs->add_bind_queue_vec();
        EXPECT_NE(bqsBindQueueMsg, nullptr);
        bqsBindQueueMsg->set_src_queue_id(i);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    std::vector<bqs::BQSBindQueueItem> bindQueueVec;
    uint32_t ret = bqs::EzcomClient::GetInstance(0)->ParseGetBindRespMsg(bqsRespMsg, bindQueueVec);
    EXPECT_EQ(ret, 10);
    EXPECT_EQ(bindQueueVec.size(), 10);

    for (uint32_t i = 0; i < bindQueueVec.size(); i++) {
        EXPECT_EQ(bindQueueVec[i].srcQueueId_, i);
        EXPECT_EQ(bindQueueVec[i].dstQueueId_, i + 1);
    }
}

TEST_F(EZCOM_CLIENT_UTest, SendBqsMsgSuccess1)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(EZCOM_CLIENT_UTest, SendBqsMsgFailForMemCpy)
{
    MOCKER(memset_s).stubs().will(returnValue(EINVAL));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_INNER_ERROR);
}

TEST_F(EZCOM_CLIENT_UTest, SendBqsMsgFailForPbSerialize)
{
    MOCKER_CPP(&bqs::BQSMsg::SerializePartialToArray).stubs().will(returnValue(false));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_INNER_ERROR);
}

TEST_F(EZCOM_CLIENT_UTest, SendBqsMsgEzcomRPCSyncFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(returnValue(-1));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_EASY_COMM_ERROR);
}

TEST_F(EZCOM_CLIENT_UTest, SendBqsMsgCheckRspSizeFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFailedFake));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_EASY_COMM_ERROR);
}

TEST_F(EZCOM_CLIENT_UTest, SendBqsMsgTryAgainFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(returnValue(-EAGAIN));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_EASY_COMM_ERROR);
}

TEST_F(EZCOM_CLIENT_UTest, SendBqsMsgFailForPbParse)
{
    MOCKER(EzcomRPCSync).stubs().will(invoke(EzcomRPCSyncFake));
    MOCKER_CPP(&bqs::BQSMsg::ParseFromArray).stubs().will(returnValue(false));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_INNER_ERROR);
}

TEST_F(EZCOM_CLIENT_UTest, SerializeGetPagedBindMsgSuccess)
{
    bqs::BQSMsg bqsReqMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SerializeGetPagedBindMsg(0, 1, bqsReqMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(EZCOM_CLIENT_UTest, ParseGetPagedBindRespMsgSuccess)
{
    bqs::BQSMsg bqsRespMsg;
    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);
    bqs::BQSPagedMsg* bqsPagedMsg = bqsRespMsg.mutable_paged_msg();
    EXPECT_NE(bqsPagedMsg, nullptr);
    bqsPagedMsg->set_total(10);

    for (uint32_t i = 0; i < 10; i++) {
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsBindQueueMsgs->add_bind_queue_vec();
        EXPECT_NE(bqsBindQueueMsg, nullptr);
        bqsBindQueueMsg->set_src_queue_id(i);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    std::vector<bqs::BQSBindQueueItem> bindQueueVec;
    uint32_t total = 0;
    uint32_t ret = bqs::EzcomClient::GetInstance(0)->ParseGetPagedBindRespMsg(bqsRespMsg, bindQueueVec, total);
    EXPECT_EQ(ret, 10);
    EXPECT_EQ(total, 10);
}