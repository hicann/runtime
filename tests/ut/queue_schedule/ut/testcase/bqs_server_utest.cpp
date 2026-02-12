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
#include "easy_comm.h"

#include "bind_relation.h"
#include "queue_manager.h"
#include "bqs_server.h"
#include "bqs_log.h"
#include "bqs_msg.h"
#include "bqs_status.h"
#include "subscribe_manager.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

class BQS_SERVER_UTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
        Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
        std::cout << "BQS_SERVER_UTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        Subscribers::GetInstance().subscribeManagers_.clear();
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
        std::cout << "BQS_SERVER_UTest TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        cout << "Before utest" << endl;
        bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    }

    virtual void TearDown()
    {
        cout << "After utest" << endl;
        DelAllBindRelation();
        GlobalMockObject::verify();
    }

public:
    void NewRequest(const bqs::BQSMsg& bqsMsg, EzcomRequest& req)
    {
        uint32_t msgLength = bqsMsg.ByteSizeLong();
        uint32_t reqLength = msgLength + bqs::BQS_MSG_HEAD_SIZE;
        char* reqData = new char[reqLength];
        (void)memset(reqData, 0, reqLength);
        // Add msg length to check
        *(reinterpret_cast<uint32_t*>(reqData)) = msgLength + bqs::BQS_MSG_HEAD_SIZE;
        (void)bqsMsg.SerializePartialToArray(reqData + bqs::BQS_MSG_HEAD_SIZE, msgLength);
        req.data = reinterpret_cast<uint8_t*>(reqData);
        req.size = reqLength;
    }

    void DelRequest(EzcomRequest& req)
    {
        delete[](char*)(req.data);
    }

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
};

namespace {
typedef void (*MsgProcCallback)(int, EzcomRequest*);
MsgProcCallback g_msgProc;

typedef void (*EzcomCallBack)(int, char*, int);

std::condition_variable g_cv;
std::mutex g_mutex;
bool g_enqueue = false;

int EzcomRegisterServiceHandlerFake(int fd, void (*handler)(int, struct EzcomRequest*))
{
    std::cout << "EzcomRegisterServiceHandler stub begin, fd:" << fd << std::endl;
    // server
    if (fd == 0) {
        std::cout << "server EzcomRegisterServiceHandler stub begin, fd:" << fd << std::endl;
        g_msgProc = handler;
    } else {
        std::cout << "client EzcomRegisterServiceHandler stub begin, fd:" << fd << std::endl;
    }
    return 0;
}

int EzcomCreateServerFake(const struct EzcomServerAttr *attr)
{
    std::cout << "default EzcomCreateServer stub" << std::endl;
    if ((attr != nullptr) && (attr->handler != nullptr)) {
      g_msgProc = attr->handler;
    }
    return 0;
}

bqs::BqsStatus EnqueueRelationEventFake()
{
    std::cout << "EnqueueRelationEvent stub begin" << std::endl;
    std::unique_lock<std::mutex> lock(g_mutex);
    g_enqueue = true;
    g_cv.notify_one();
    std::cout << "EnqueueRelationEvent stub end" << std::endl;
    return bqs::BQS_STATUS_OK;
}

void BqsCheckAssign32UAddStubOverFlow(const uint32_t para1,
    const uint32_t para2, uint32_t &result, bool &onceOverFlow)
{
    onceOverFlow = true;
    return;
}

}  // namespace

TEST_F(BQS_SERVER_UTest, InitSuccess1)
{
    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(BQS_SERVER_UTest, RpcHandlerSuccess)
{
    MOCKER(EzcomRegisterServiceHandler).stubs().will(invoke(EzcomRegisterServiceHandlerFake));
    MOCKER(EzcomCreateServer).stubs().will(invoke(EzcomCreateServerFake));

    MOCKER_CPP(&bqs::BqsServer::HandleBqsReqMsg).stubs().will(returnValue(0));

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    bqs::BQSMsg bqsMsg;
    bqsMsg.set_msg_type(bqs::BQSMsg::BIND);
    EzcomRequest req;
    NewRequest(bqsMsg, req);
    g_msgProc(0, &req);
    DelRequest(req);
}

TEST_F(BQS_SERVER_UTest, HandleBqsGetBindMsgSuccess)
{
    MOCKER(EzcomRegisterServiceHandler).stubs().will(invoke(EzcomRegisterServiceHandlerFake));
    MOCKER(EzcomCreateServer).stubs().will(invoke(EzcomCreateServerFake));

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    //MOCKER_CPP(&bqs::BqsServer::ParseGetBindMsg).stubs().will(returnValue(0));

    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    bqs::BQSMsg bqsMsg;
    bqsMsg.set_msg_type(bqs::BQSMsg::GET_BIND);
    EzcomRequest req;
    NewRequest(bqsMsg, req);
    g_msgProc(0, &req);
    DelRequest(req);
}

TEST_F(BQS_SERVER_UTest, HandleBqsGetAllBindMsgSuccess)
{
    MOCKER(EzcomRegisterServiceHandler).stubs().will(invoke(EzcomRegisterServiceHandlerFake));
    MOCKER(EzcomCreateServer).stubs().will(invoke(EzcomCreateServerFake));

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    //MOCKER_CPP(&bqs::BqsServer::ParseGetPagedBindMsg).stubs().will(returnValue(0));

    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    bqs::BQSMsg bqsMsg;
    bqsMsg.set_msg_type(bqs::BQSMsg::GET_ALL_BIND);
    EzcomRequest req;
    NewRequest(bqsMsg, req);
    g_msgProc(0, &req);
    DelRequest(req);
}

TEST_F(BQS_SERVER_UTest, HandleBqsWaitBindMsgSuccess)
{
    MOCKER(EzcomRegisterServiceHandler).stubs().will(invoke(EzcomRegisterServiceHandlerFake));
    MOCKER(EzcomCreateServer).stubs().will(invoke(EzcomCreateServerFake));

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    MOCKER_CPP(&bqs::BqsServer::WaitBindMsgProc).stubs().will(returnValue(0));

    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    bqs::BQSMsg bqsMsg;
    bqsMsg.set_msg_type(bqs::BQSMsg::BIND);
    EzcomRequest req;
    NewRequest(bqsMsg, req);
    g_msgProc(0, &req);
    DelRequest(req);
    MOCKER_CPP(&bqs::QueueManager::EnqueueRelationEvent).stubs().will(invoke(EnqueueRelationEventFake));
    bqs::BqsServer::GetInstance().done_ = false;
    bqs::BqsServer::GetInstance().WaitBindMsgProc();
}

TEST_F(BQS_SERVER_UTest, RpcHandlerCheckFailed)
{
    MOCKER(EzcomRegisterServiceHandler).stubs().will(invoke(EzcomRegisterServiceHandlerFake));
    MOCKER(EzcomCreateServer).stubs().will(invoke(EzcomCreateServerFake));

    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    g_msgProc(0, nullptr);
}

TEST_F(BQS_SERVER_UTest, HandleBqsMsgUnsupportFailed)
{
    MOCKER(EzcomRegisterServiceHandler).stubs().will(invoke(EzcomRegisterServiceHandlerFake));
    MOCKER(EzcomCreateServer).stubs().will(invoke(EzcomCreateServerFake));

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    bqs::BQSMsg bqsMsg;
    bqsMsg.set_msg_type(bqs::BQSMsg::UNUSE);
    EzcomRequest req;
    NewRequest(bqsMsg, req);
    g_msgProc(0, &req);
    DelRequest(req);
}

TEST_F(BQS_SERVER_UTest, HandleBqsMsgCheckSizeFailed)
{
    MOCKER(EzcomRegisterServiceHandler).stubs().will(invoke(EzcomRegisterServiceHandlerFake));
    MOCKER(EzcomCreateServer).stubs().will(invoke(EzcomCreateServerFake));

    //MOCKER_CPP(&bqs::BqsServer::SendRspMsg).stubs().will(ignoreReturnValue());

    bqs::BqsStatus ret = bqs::BqsServer::GetInstance().InitBqsServer("DEFAULT", 0);
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

    bqs::BQSMsg bqsMsg;
    bqsMsg.set_msg_type(bqs::BQSMsg::GET_ALL_BIND);
    EzcomRequest req;
    NewRequest(bqsMsg, req);
    req.size = req.size + 1;
    g_msgProc(0, &req);
    DelRequest(req);
}

TEST_F(BQS_SERVER_UTest, ParseGetBindMsgBySrcSuccess)
{
    bqs::BqsServer::GetInstance().SendRspMsg(0, 0);
    MOCKER(EzcomSendResponse).stubs().will(returnValue(-1));
    bqs::BqsServer::GetInstance().SendRspMsg(0, 0);
    MOCKER(BqsCheckAssign32UAdd)
        .stubs()
        .will(invoke(BqsCheckAssign32UAddStubOverFlow));
    bqs::BqsServer::GetInstance().SendRspMsg(0, 0);
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
    int32_t result = bindRelation.Bind(srcEntity, dstEntity);
    EXPECT_EQ(result, 0);

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 1);

    bqs::BQSBindQueueMsg bqsBindQueueMsg1 = bqsBindQueueMsgs->bind_queue_vec(0);
    uint32_t src = bqsBindQueueMsg1.src_queue_id();
    EXPECT_EQ(src, 5);
    uint32_t dst = bqsBindQueueMsg1.dst_queue_id();
    EXPECT_EQ(dst, 6);
}

TEST_F(BQS_SERVER_UTest, ParseGetBindMsgByDstSuccess)
{
    cout << "ParseGetBindMsgByDstSuccess" << endl;
    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_BIND);
    bqs::BQSQueryMsg* bqsQueryMsg = bqsReqMsg.mutable_query_msg();
    EXPECT_NE(bqsQueryMsg, nullptr);

    bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_DST);
    bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
    EXPECT_NE(bqsBindQueueMsg, nullptr);

    bqsBindQueueMsg->set_src_queue_id(0);
    bqsBindQueueMsg->set_dst_queue_id(6);

    auto& bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(0U, 0U);
    for (int32_t i = 0; i < 10; i++) {
        auto dstEntity = bqs::EntityInfo(i + 1, 0U);
        int32_t result = bindRelation.Bind(srcEntity, dstEntity);
        EXPECT_EQ(result, 0);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 1);

    bqs::BQSBindQueueMsg bqsBindQueueMsg1 = bqsBindQueueMsgs->bind_queue_vec(0);
    uint32_t src = bqsBindQueueMsg1.src_queue_id();
    EXPECT_EQ(src, 0);
    uint32_t dst = bqsBindQueueMsg1.dst_queue_id();
    EXPECT_EQ(dst, 6);
}

TEST_F(BQS_SERVER_UTest, ParseGetBindMsgBySrcNoOneSuccess)
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

    auto& bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(0U, 0U);
    for (int32_t i = 0; i < 10; i++) {
        auto dstEntity = bqs::EntityInfo(i + 1, 0U);
        int32_t result = bindRelation.Bind(srcEntity, dstEntity);
        EXPECT_EQ(result, 0);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 0);
}

TEST_F(BQS_SERVER_UTest, ParseGetBindMsgByDstNoOneSuccess)
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

    auto& bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(0U, 0U);
    for (int32_t i = 0; i < 10; i++) {
        auto dstEntity = bqs::EntityInfo(i + 1, 0U);
        int32_t result = bindRelation.Bind(srcEntity, dstEntity);
        EXPECT_EQ(result, 0);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 0);
}

TEST_F(BQS_SERVER_UTest, ParseGetBindMsgByUnsupportedFailed)
{
    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_BIND);
    bqs::BQSQueryMsg* bqsQueryMsg = bqsReqMsg.mutable_query_msg();
    EXPECT_NE(bqsQueryMsg, nullptr);

    bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC_AND_DST);
    bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
    EXPECT_NE(bqsBindQueueMsg, nullptr);

    bqsBindQueueMsg->set_src_queue_id(5);
    bqsBindQueueMsg->set_dst_queue_id(6);

    auto& bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(0U, 0U);
    for (int32_t i = 0; i < 10; i++) {
        auto dstEntity = bqs::EntityInfo(i + 1, 0U);
        int32_t result = bindRelation.Bind(srcEntity, dstEntity);
        EXPECT_EQ(result, 0);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 0);
}

TEST_F(BQS_SERVER_UTest, ParseGetPagedBindMsgSuccess)
{
    bqs::BQSMsg bqsReqMsg;
    bqsReqMsg.set_msg_type(bqs::BQSMsg::GET_ALL_BIND);
    bqs::BQSPagedMsg* bqsPagedMsg = bqsReqMsg.mutable_paged_msg();
    EXPECT_NE(bqsPagedMsg, nullptr);
    bqsPagedMsg->set_offset(0);
    bqsPagedMsg->set_limit(20);

    auto& bindRelation = bqs::BindRelation::GetInstance();
    auto srcEntity = bqs::EntityInfo(0U, 0U);
    for (int32_t i = 0; i < 10; i++) {
        auto dstEntity = bqs::EntityInfo(i + 1, 0U);
        int32_t result = bindRelation.Bind(srcEntity, dstEntity);
        EXPECT_EQ(result, 0);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseGetPagedBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsRespMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    uint32_t bindNum = bqsBindQueueMsgs->bind_queue_vec_size();
    EXPECT_EQ(bindNum, 10);
}

TEST_F(BQS_SERVER_UTest, ParseBindMsgSuccess)
{
    MOCKER_CPP(&bqs::BindRelation::Bind).stubs().will(returnValue(0));

    bqs::BQSMsg bqsReqMsg;
    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsReqMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    for (int32_t i = 0; i < 10; i++) {
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsBindQueueMsgs->add_bind_queue_vec();
        EXPECT_NE(bqsBindQueueMsg, nullptr);
        bqsBindQueueMsg->set_src_queue_id(0);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < bqsBindQueueRsps->bind_result_vec_size(); i++) {
        bqs::BQSBindQueueRsp bqsBindQueueRsp = bqsBindQueueRsps->bind_result_vec(i);

        int32_t result = bqsBindQueueRsp.bind_result();
        EXPECT_EQ(result, 0);
    }
}

TEST_F(BQS_SERVER_UTest, ParseBindMsgFailed)
{
    MOCKER_CPP(&bqs::BindRelation::Bind).stubs().will(returnValue(0)).then(returnValue(1)).then(returnValue(0));

    bqs::BQSMsg bqsReqMsg;
    bqs::BQSBindQueueMsgs* bqsBindQueueMsgs = bqsReqMsg.mutable_bind_queue_msgs();
    EXPECT_NE(bqsBindQueueMsgs, nullptr);

    for (int32_t i = 0; i < 3; i++) {
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsBindQueueMsgs->add_bind_queue_vec();
        EXPECT_NE(bqsBindQueueMsg, nullptr);
        bqsBindQueueMsg->set_src_queue_id(0);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseBindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < bqsBindQueueRsps->bind_result_vec_size(); i++) {
        bqs::BQSBindQueueRsp bqsBindQueueRsp = bqsBindQueueRsps->bind_result_vec(i);

        int32_t result = bqsBindQueueRsp.bind_result();
        if (i == 1) {
            EXPECT_EQ(result, 1);
        } else {
            EXPECT_EQ(result, 0);
        }
    }
}

TEST_F(BQS_SERVER_UTest, ParseUnbindMsgBySrcSuccess)
{
    MOCKER_CPP(&bqs::BindRelation::UnBindBySrc).stubs().will(returnValue(0));

    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::UNBIND);
    bqs::BQSQueryMsgs* bqsQueryMsgs = bqsReqMsg.mutable_query_msgs();
    EXPECT_NE(bqsQueryMsgs, nullptr);

    for (uint32_t i = 0; i < 10; i++) {
        bqs::BQSQueryMsg* bqsQueryMsg = bqsQueryMsgs->add_query_msg_vec();
        EXPECT_NE(bqsQueryMsg, nullptr);

        bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC);
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
        EXPECT_NE(bqsBindQueueMsg, nullptr);

        bqsBindQueueMsg->set_src_queue_id(0);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseUnbindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < bqsBindQueueRsps->bind_result_vec_size(); i++) {
        bqs::BQSBindQueueRsp bqsBindQueueRsp = bqsBindQueueRsps->bind_result_vec(i);

        int32_t result = bqsBindQueueRsp.bind_result();
        EXPECT_EQ(result, 0);
    }
}

TEST_F(BQS_SERVER_UTest, ParseUnbindMsgByDstSuccess)
{
    MOCKER_CPP(&bqs::BindRelation::UnBindByDst).stubs().will(returnValue(0));

    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::UNBIND);
    bqs::BQSQueryMsgs* bqsQueryMsgs = bqsReqMsg.mutable_query_msgs();
    EXPECT_NE(bqsQueryMsgs, nullptr);

    for (uint32_t i = 0; i < 10; i++) {
        bqs::BQSQueryMsg* bqsQueryMsg = bqsQueryMsgs->add_query_msg_vec();
        EXPECT_NE(bqsQueryMsg, nullptr);

        bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_DST);
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
        EXPECT_NE(bqsBindQueueMsg, nullptr);

        bqsBindQueueMsg->set_src_queue_id(0);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseUnbindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < bqsBindQueueRsps->bind_result_vec_size(); i++) {
        bqs::BQSBindQueueRsp bqsBindQueueRsp = bqsBindQueueRsps->bind_result_vec(i);

        int32_t result = bqsBindQueueRsp.bind_result();
        EXPECT_EQ(result, 0);
    }
}

TEST_F(BQS_SERVER_UTest, ParseUnbindMsgBySrcDstSuccess)
{
    MOCKER_CPP(&bqs::BindRelation::UnBind).stubs().will(returnValue(0));

    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::UNBIND);
    bqs::BQSQueryMsgs* bqsQueryMsgs = bqsReqMsg.mutable_query_msgs();
    EXPECT_NE(bqsQueryMsgs, nullptr);

    for (uint32_t i = 0; i < 10; i++) {
        bqs::BQSQueryMsg* bqsQueryMsg = bqsQueryMsgs->add_query_msg_vec();
        EXPECT_NE(bqsQueryMsg, nullptr);

        bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC_AND_DST);
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
        EXPECT_NE(bqsBindQueueMsg, nullptr);

        bqsBindQueueMsg->set_src_queue_id(0);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseUnbindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < bqsBindQueueRsps->bind_result_vec_size(); i++) {
        bqs::BQSBindQueueRsp bqsBindQueueRsp = bqsBindQueueRsps->bind_result_vec(i);

        int32_t result = bqsBindQueueRsp.bind_result();
        EXPECT_EQ(result, 0);
    }
}

TEST_F(BQS_SERVER_UTest, ParseUnbindMsgByUnsupportedFailed)
{
    bqs::BQSMsg bqsReqMsg;

    bqsReqMsg.set_msg_type(bqs::BQSMsg::UNBIND);
    bqs::BQSQueryMsgs* bqsQueryMsgs = bqsReqMsg.mutable_query_msgs();
    EXPECT_NE(bqsQueryMsgs, nullptr);

    for (uint32_t i = 0; i < 10; i++) {
        bqs::BQSQueryMsg* bqsQueryMsg = bqsQueryMsgs->add_query_msg_vec();
        EXPECT_NE(bqsQueryMsg, nullptr);

        bqsQueryMsg->set_key_type(bqs::BQSQueryMsg::BQS_QUERY_TYPE_SRC_OR_DST);
        bqs::BQSBindQueueMsg* bqsBindQueueMsg = bqsQueryMsg->mutable_bind_queue_item();
        EXPECT_NE(bqsBindQueueMsg, nullptr);

        bqsBindQueueMsg->set_src_queue_id(0);
        bqsBindQueueMsg->set_dst_queue_id(i + 1);
    }

    bqs::BQSMsg bqsRespMsg;
    bqs::BqsServer::GetInstance().ParseUnbindMsg(bqsReqMsg, bqsRespMsg);

    bqs::BQSBindQueueRsps* bqsBindQueueRsps = bqsRespMsg.mutable_resp_msgs();
    EXPECT_NE(bqsBindQueueRsps, nullptr);

    for (int32_t i = 0; i < bqsBindQueueRsps->bind_result_vec_size(); i++) {
        bqs::BQSBindQueueRsp bqsBindQueueRsp = bqsBindQueueRsps->bind_result_vec(i);

        int32_t result = bqsBindQueueRsp.bind_result();
        EXPECT_NE(result, 0);
    }
}

TEST_F(BQS_SERVER_UTest, SerializeGetBindRspBySrc)
{
    auto &bindRelation = bqs::BindRelation::GetInstance();
    auto src = bqs::EntityInfo(1U, 0U);
    auto dst = bqs::EntityInfo(2U, 0U);
    auto abnormalDst = bqs::EntityInfo(3U, 0U);
    bindRelation.srcToDstRelation_[src].emplace(dst);
    bindRelation.abnormalSrcToDst_[src].emplace(abnormalDst);

    bqs::BQSMsg responseMsg;
    bqs::BqsServer::GetInstance().SerializeGetBindRspBySrc(1U, responseMsg);
    const auto &bindQueMsg = responseMsg.bind_queue_msgs();
    EXPECT_EQ(bindQueMsg.bind_queue_vec().size(), 2);
    bindRelation.srcToDstRelation_.clear();
    bindRelation.abnormalSrcToDst_.clear();
}

TEST_F(BQS_SERVER_UTest, SerializeGetBindRspByDst)
{
    auto &bindRelation = bqs::BindRelation::GetInstance();
    auto dst = bqs::EntityInfo(1U, 0U);
    auto src = bqs::EntityInfo(2U, 0U);
    auto abnormalSrc = bqs::EntityInfo(3U, 0U);
    bindRelation.dstToSrcRelation_[dst].emplace(src);
    bindRelation.abnormalDstToSrc_[dst].emplace(abnormalSrc);

    bqs::BQSMsg responseMsg;
    bqs::BqsServer::GetInstance().SerializeGetBindRspByDst(1U, responseMsg);
    const auto &bindQueMsg = responseMsg.bind_queue_msgs();
    EXPECT_EQ(bindQueMsg.bind_queue_vec().size(), 2);
    bindRelation.dstToSrcRelation_.clear();
    bindRelation.abnormalDstToSrc_.clear();
}

TEST_F(BQS_SERVER_UTest, AppendRelations)
{
    std::vector<std::tuple<uint32_t, uint32_t>> relations;
    relations.emplace_back(std::make_pair(1U, 2U));

    std::unordered_map<bqs::EntityInfo,
        std::unordered_set<bqs::EntityInfo, bqs::EntityInfoHash>, bqs::EntityInfoHash> srcMap;
    auto src1 = bqs::EntityInfo(3U, 0U);
    auto dst1 = bqs::EntityInfo(4U, 0U);
    auto src2 = bqs::EntityInfo(5U, 0U);
    auto dst2 = bqs::EntityInfo(6U, 0U);
    auto dst3 = bqs::EntityInfo(7U, 0U);
    srcMap[src1].emplace(dst1);
    srcMap[src2].emplace(dst2);
    srcMap[src2].emplace(dst3);

    bqs::BqsServer::GetInstance().AppendRelations(relations, srcMap);
    EXPECT_EQ(relations.size(), 4U);
}

TEST_F(BQS_SERVER_UTest, SendRspMsgFailForPbSerialize)
{
    MOCKER_CPP(&BQSMsg::SerializePartialToArray).stubs().will(returnValue(false));
    bqs::BqsServer::GetInstance().SendRspMsg(0, 0);
}