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
#include "common/bqs_feature_ctrl.h"
#define private public
#define protected public
#include "easy_comm.h"
#include "qs_client.h"
#include "ezcom_client.h"
#include "bqs_log.h"
#include "bqs_msg.h"
#include "bind_relation.h"
#undef private
#undef protected

using namespace std;


namespace {
    /**
    * Exception function when pipe is broken.
    * @return NA
    */
    void PipBrokenException(int fd, void* data)
    {
        if (data == nullptr) {
            BQS_LOG_ERROR("Pip of client and server has been closed. fd:%d\n", fd);
        }
    }
}

namespace {
    void GetOneRelation(struct EzcomResponse *resp)
    {
        bqs::BQSMsg bqsResp;
        auto bqsBindQueueInfo = bqsResp.mutable_bind_queue_msgs()->add_bind_queue_vec();
        bqsBindQueueInfo->set_src_queue_id(0U);
        bqsBindQueueInfo->set_dst_queue_id(1U);
        bqsResp.mutable_paged_msg()->set_total(1u);

        const uint32_t msgLen = static_cast<uint32_t>(bqsResp.ByteSizeLong());
        const uint32_t respLength = msgLen + bqs::BQS_MSG_HEAD_SIZE;
        char *respData = new (std::nothrow) char[respLength];
        *(reinterpret_cast<uint32_t *>(respData)) = respLength;
        (void)bqsResp.SerializePartialToArray(respData + bqs::BQS_MSG_HEAD_SIZE, static_cast<int>(msgLen));

        resp->size = respLength;
        resp->data = reinterpret_cast<uint8_t *>(respData);
    }


    void GenerateBindResult(struct EzcomResponse *resp, int32_t size)
    {
        bqs::BQSMsg bqsResp;
        for (int32_t i = 0; i < size; ++i) {
            auto bqsBindRes = bqsResp.mutable_resp_msgs()->add_bind_result_vec();
            bqsBindRes->set_bind_result(0);
        }

        const uint32_t msgLen = static_cast<uint32_t>(bqsResp.ByteSizeLong());
        const uint32_t respLength = msgLen + bqs::BQS_MSG_HEAD_SIZE;
        char *respData = new (std::nothrow) char[respLength];
        *(reinterpret_cast<uint32_t *>(respData)) = respLength;
        (void)bqsResp.SerializePartialToArray(respData + bqs::BQS_MSG_HEAD_SIZE, static_cast<int>(msgLen));

        resp->size = respLength;
        resp->data = reinterpret_cast<uint8_t *>(respData);
    }
    int EzcomRPCSyncFake(int fd, struct EzcomRequest *req, struct EzcomResponse *resp)
    {
        std::cout << "EzcomRPCSync stub begin" << std::endl;
        const uint32_t currMsgSize = *(reinterpret_cast<uint32_t *>(req->data));
        char_t * const reqData = reinterpret_cast<char_t *>(req->data);
        const uint32_t parseLength = currMsgSize - bqs::BQS_MSG_HEAD_SIZE;
        bqs::BQSMsg bqsReq;
        (void)bqsReq.ParseFromArray(reinterpret_cast<char_t *>(reqData) + bqs::BQS_MSG_HEAD_SIZE,
            static_cast<int32_t>(parseLength));

        if (bqsReq.msg_type() == bqs::BQSMsg::GET_ALL_BIND) {
            GetOneRelation(resp);
        } else if (bqsReq.msg_type() == bqs::BQSMsg::BIND)  {
            const auto size = bqsReq.bind_queue_msgs().bind_queue_vec_size();
            GenerateBindResult(resp, size);
        }  else if (bqsReq.msg_type() == bqs::BQSMsg::UNBIND)  {
            const auto size = bqsReq.query_msgs().query_msg_vec_size();
            GenerateBindResult(resp, size);
        } else {
            resp->size = req->size;
            char *respData = new (std::nothrow) char[req->size];
            memcpy(respData, (char*)req->data, resp->size);
            resp->data = (uint8_t*)respData;
        }

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

class BQS_CLIENT_UTest :public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before bqs_client_utest" << endl;
    }

    virtual void TearDown()
    {
        cout << "After bqs_client_utest" << endl;
        GlobalMockObject::verify();
    }

public:
    void AddBindRelation(const std::multimap<uint32_t, uint32_t>& srcDstMap, const int32_t expectRet,
        std::vector<bqs::BQSBindQueueResult>& bindResultVec)
    {
        std::vector<bqs::BQSBindQueueItem> bindQueueVec;
        for (auto iter = srcDstMap.begin(); iter != srcDstMap.end(); ++iter) {
            bqs::BQSBindQueueItem tmp = {
                srcQueueId_: iter->first,
                dstQueueId_: iter->second
            };
            bindQueueVec.push_back(tmp);
        }

        uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            BindQueue(bindQueueVec, bindResultVec);
        EXPECT_EQ(result, expectRet);
    }

    void DelBindRelation(const std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem>& keySrcDstMap, const int32_t expectRet,
        std::vector<bqs::BQSBindQueueResult>& bindResultVec)
    {
        std::vector<bqs::BQSQueryPara> bqsQueryParaVec;
        for (auto iter = keySrcDstMap.begin(); iter != keySrcDstMap.end(); ++iter) {
            bqs::BQSBindQueueItem tmpItem = iter->second;
            bqs::BQSQueryPara tmpPara = {
                keyType_: iter->first,
                bqsBindQueueItem_: tmpItem
            };
            bqsQueryParaVec.push_back(tmpPara);
        }
        uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            UnbindQueue(bqsQueryParaVec, bindResultVec);
        EXPECT_EQ(result, expectRet);
    }

    void GetBindRelation(const std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem>& keySrcDstMap, const int32_t expectRet,
        std::vector<bqs::BQSBindQueueItem>& getBindQueueResult)
    {
        std::vector<bqs::BQSQueryPara> bqsQueryParaVec;
        for (auto iter = keySrcDstMap.begin(); iter != keySrcDstMap.end(); ++iter) {
            bqs::BQSBindQueueItem tmpItem = iter->second;
            bqs::BQSQueryPara tmpPara = {
                keyType_: iter->first,
                bqsBindQueueItem_: tmpItem
            };
            bqsQueryParaVec.push_back(tmpPara);
        }

        uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            GetBindQueue(bqsQueryParaVec[0], getBindQueueResult);
        EXPECT_EQ(getBindQueueResult.size(), expectRet);
        EXPECT_EQ(result, expectRet);
    }

    void GetAllBindRelation(const int32_t expectRet, std::vector<bqs::BQSBindQueueItem>& getBindQueueResult)
    {
        uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            GetAllBindQueue(getBindQueueResult);
        EXPECT_EQ(result, expectRet);
        EXPECT_EQ(getBindQueueResult.size(), expectRet);
    }
};

TEST_F(BQS_CLIENT_UTest, GetInstanceCheckFailed)
{
    bqs::BqsClient* bqsClient = bqs::BqsClient::GetInstance(nullptr, 4, PipBrokenException);
    EXPECT_EQ(bqsClient, nullptr);
}

TEST_F(BQS_CLIENT_UTest, GetInstanceConnectFailed)
{
    MOCKER(EzcomCreateClient)
    .stubs()
    .will(returnValue(-1));
    bqs::BqsClient* bqsClient = bqs::BqsClient::GetInstance("test", 4, PipBrokenException);
    EXPECT_EQ(bqsClient, nullptr);
}

TEST_F(BQS_CLIENT_UTest, BindQueueSuccess1)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::multimap<uint32_t, uint32_t> srcDstMap;
    for (int32_t i = 0; i < 10; ++i) {
        srcDstMap.insert(std::make_pair(i, i + 1));
    }

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 10, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, BindQueuePagedSuccess1)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::multimap<uint32_t, uint32_t> srcDstMap;
    for (int32_t i = 0; i < 500; ++i) {
        srcDstMap.insert(std::make_pair(i, i + 1));
    }

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 500, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, BindQueuePagedSuccess2)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::multimap<uint32_t, uint32_t> srcDstMap;

    srcDstMap.insert(std::make_pair(1, 2));
    srcDstMap.insert(std::make_pair(1, 3));
    srcDstMap.insert(std::make_pair(4, 5));
    srcDstMap.insert(std::make_pair(4, 6));
    srcDstMap.insert(std::make_pair(7, 8));
    srcDstMap.insert(std::make_pair(4, 2));
    srcDstMap.insert(std::make_pair(7, 3));

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 7, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, BindQueueSerializeBindMsgFailed)
{
    std::multimap<uint32_t, uint32_t> srcDstMap;
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 0, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, BindQueueSendBqsMsgFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFailedFake));

    std::multimap<uint32_t, uint32_t> srcDstMap;
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 0, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, UnbindQueueSuccess1)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    DelBindRelation(keySrcDstMap, 1, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, UnbindQueuePagedSuccess1)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    for (int32_t i = 0; i < 500; ++i) {
        keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    }
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    DelBindRelation(keySrcDstMap, 500, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, UnbindQueueSerializeUnbindMsgFailed)
{
    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    DelBindRelation(keySrcDstMap, 0, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, UnbindQueueSendBqsMsgFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFailedFake));

    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    DelBindRelation(keySrcDstMap, 0, bindResultVec);
}

TEST_F(BQS_CLIENT_UTest, GetBindQueueSuccess1)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);
}

TEST_F(BQS_CLIENT_UTest, GetBindQueueSerializeGetBindMsgFailed)
{
    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);
}

TEST_F(BQS_CLIENT_UTest, GetBindQueueSendBqsMsgFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFailedFake));

    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);
}

TEST_F(BQS_CLIENT_UTest, GetAllBindQueueSuccess1)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetAllBindRelation(1, getBindQueueResult);
}

TEST_F(BQS_CLIENT_UTest, GetAllBindQueueSerializeGetBindMsgFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFailedFake));

    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetAllBindRelation(0, getBindQueueResult);
}

TEST_F(BQS_CLIENT_UTest, GetAllBindQueueOverflowFailed)
{
    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            GetAllBindQueue(getBindQueueResult);
    EXPECT_EQ(result, 1);
}

TEST_F(BQS_CLIENT_UTest, DestroySuccess)
{
    bqs::BqsClient* bqsClient = bqs::BqsClient::GetInstance("test", 4, PipBrokenException);
    EXPECT_NE(bqsClient, nullptr);
    int32_t ret = bqsClient->Destroy();
    EXPECT_EQ(ret, 0);
}

TEST_F(BQS_CLIENT_UTest, GetInstanceConnectFailedServerNotCreate)
{
    MOCKER(nanosleep).stubs().will(returnValue(0));
    MOCKER(EzcomCreateClient).stubs().will(returnValue(-2));
    bqs::BqsClient* bqsClient = bqs::BqsClient::GetInstance("test", 4, PipBrokenException);
    EXPECT_EQ(bqsClient, nullptr);
}

TEST_F(BQS_CLIENT_UTest, GetInstance_001)
{
    MOCKER(nanosleep).stubs().will(returnValue(0));
    MOCKER(EzcomCreateClient).stubs().will(returnValue(-2));
    MOCKER_CPP(&bqs::FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    bqs::BqsClient* bqsClient = bqs::BqsClient::GetInstance("test", 4, PipBrokenException);
    EXPECT_EQ(bqsClient, nullptr);
}

TEST_F(BQS_CLIENT_UTest, BindQueueMbufPool)
{
    std::vector<bqs::BQSBindQueueMbufPoolItem> bindQueueVec;
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            BindQueueMbufPool(bindQueueVec, bindResultVec);
    EXPECT_EQ(result, 0);
}

TEST_F(BQS_CLIENT_UTest, UnbindQueueMbufPool)
{
    std::vector<bqs::BQSUnbindQueueMbufPoolItem> bindQueueVec;
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            UnbindQueueMbufPool(bindQueueVec, bindResultVec);
    EXPECT_EQ(result, 0);
}

TEST_F(BQS_CLIENT_UTest, BindQueueInterChip)
{
    bqs::BindQueueInterChipInfo interChipInfo;
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            BindQueueInterChip(interChipInfo);
    EXPECT_EQ(result, 0);
}

TEST_F(BQS_CLIENT_UTest, UnbindQueueInterChip)
{
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            UnbindQueueInterChip(0);
    EXPECT_EQ(result, 0);
}