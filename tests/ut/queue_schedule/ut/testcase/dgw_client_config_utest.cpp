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
#include <mockcpp/ChainingMockHelper.h>
#include <iostream>
#include <cstdint>
#include "driver/ascend_hal.h"
#include "securec.h"
#include "bqs_msg.h"
#include "bqs_status.h"
// #include "hcom.h"
#include "hccl/hccl_ex.h"

#define private public
#define protected public
#include "dgw_client.h"
#include "router_server.h"
#include "entity_manager.h"
#include "bind_relation.h"
#include "subscribe_manager.h"
#include "bqs_util.h"
#undef private
#undef protected
#include "queue_schedule_feature_ctrl.h"
using namespace std;
using namespace bqs;
using namespace dgw;

namespace {
    // buffer_[0]: record length of used data buffer
    uint64_t g_buffer[1025];
    // retRsp
    QsProcMsgRsp retRsp;
    // hccl handle
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;

    drvError_t halEschedSubmitEventSyncFake(unsigned int devId, struct event_summary *event,
                                            int timeout, struct event_reply *reply)
    {
        ConfigInfo *config = reinterpret_cast<ConfigInfo *>(&g_buffer[1]);

        struct event_info eventInfo;
        eventInfo.comm.event_id = EVENT_QS_MSG;
        eventInfo.comm.subevent_id = event->subevent_id;
        bqs::RouterServer::GetInstance().HandleBqsMsg(eventInfo);
        if (reply != nullptr) {
            memcpy(reply->buf, &retRsp, sizeof(QsProcMsgRsp));
            reply->buf_len = sizeof(QsProcMsgRsp);
            reply->reply_len = sizeof(QsProcMsgRsp);
        }
        return DRV_ERROR_NONE;
    }

    int halMbufSetDataLenFake(Mbuf *mbuf, uint64_t len)
    {
        g_buffer[0] = len;
        return static_cast<int>(DRV_ERROR_NONE);
    }

    int halMbufGetDataLenFake(Mbuf *mbuf, uint64_t *len)
    {
        *len = g_buffer[0];
        return static_cast<int>(DRV_ERROR_NONE);
    }

    errno_t CopyStub(void *dest, size_t destMax, const void *src, size_t count)
    {
        printf("Dst addr:%p, size:%zu, src addr:%p, size:%zu\n", dest, destMax, src, count);
        memcpy(dest, src, count);
        return EOK;
    }

    BqsStatus WaitSyncMsgProcFake()
    {
        printf("Begin to simulate wait sync msg proc.\n");
        bqs::RouterServer::GetInstance().BindMsgProc();
        auto ret = static_cast<BqsStatus>(bqs::RouterServer::GetInstance().retCode_);
        bqs::RouterServer::GetInstance().retCode_ = BQS_STATUS_OK;
        return ret;
    }

    drvError_t halEschedSubmitEventFake(unsigned int devId, struct event_summary *event)
    {
        memcpy(&retRsp, event->msg, event->msg_len);
        cout << "retRsp retCode=" << retRsp.retCode << endl;
        return DRV_ERROR_NONE;
    }

    drvError_t halQueueQueryFake(unsigned int devId, QueueQueryCmdType cmd,
                                 QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
    {
        QueueQueryOutput *output = reinterpret_cast<QueueQueryOutput *>(outPut->outBuff);
        output->queQueryQueueAttrInfo.attr.read = 1;
        output->queQueryQueueAttrInfo.attr.write = 1;
        return DRV_ERROR_NONE;
    }

    drvError_t fake_drvGetDevNum(uint32_t *num_dev)
    {
        *num_dev = 8;
        return DRV_ERROR_NONE;
    }
}

class DgwClientConfigUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        Mbuf *mbuf = (Mbuf *)g_buffer;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&mbuf))
            .will(returnValue(static_cast<int>(DRV_ERROR_NONE)));

        void *dataAddr = (void *)(&g_buffer[1]);
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(), outBoundP((void **)(&dataAddr)))
            .will(returnValue(static_cast<int>(DRV_ERROR_NONE)));

        MOCKER(halEschedSubmitEventSync)
            .stubs()
            .will(invoke(halEschedSubmitEventSyncFake));

        MOCKER(halMbufSetDataLen)
            .stubs()
            .will(invoke(halMbufSetDataLenFake));

        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&mbuf))
            .will(returnValue(DRV_ERROR_NONE));

        MOCKER(halMbufGetDataLen)
            .stubs()
            .will(invoke(halMbufGetDataLenFake));

        MOCKER(memcpy_s)
            .stubs()
            .will(invoke(CopyStub));

        MOCKER_CPP(&bqs::RouterServer::WaitSyncMsgProc)
            .stubs()
            .will(invoke(WaitSyncMsgProcFake));

        MOCKER(halEschedSubmitEvent)
            .stubs()
            .will(invoke(halEschedSubmitEventFake));

        MOCKER(halQueueQuery)
            .stubs()
            .will(invoke(halQueueQueryFake));

        MOCKER(HcclInitComm)
            .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((HcclComm *)&hcclHandle))
            .will(returnValue(0));

        MOCKER(HcclFinalizeComm)
            .stubs()
            .will(returnValue(0));

        MOCKER(HcclIsend)
            .stubs()
            .will(returnValue((int)HCCL_SUCCESS));
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
    static void SetUpTestCase()
    {
        std::cout << "DgwClientConfigUtest SetUpTestCase" << std::endl;
        bqs::BindRelation::GetInstance().allGroupConfig_.clear();
        bqs::BindRelation::GetInstance().srcToDstRelation_.clear();
        bqs::BindRelation::GetInstance().dstToSrcRelation_.clear();
        dgw::EntityManager::Instance().groupEntityMap_.clear();
        dgw::EntityManager::Instance().idToEntity_.clear();
        RouterServer::GetInstance().cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(0U));
        RouterServer::GetInstance().readyToHandleMsg_ = true;
        GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
        Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
    }

    static void TearDownTestCase()
    {
        std::cout << "DgwClientConfigUtest TearDownTestCase" << std::endl;
        Subscribers::GetInstance().subscribeManagers_.clear();
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(DgwClientConfigUtest, CreateHcomHandle_Success01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    // create hcom handle
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0U;
    auto ret = dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(handle, hcclHandle);
    // destroy hcom handle
    ret = dgwClient->DestroyHcomHandle(handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
}

TEST_F(DgwClientConfigUtest, CreateHcomHandle_Success_RegisterMem)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    // create hcom handle
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0U;
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "grp1, grp2";
    GrpQueryGroupAddrInfo queryResult = {};
    auto resultSize = sizeof(queryResult);
    MOCKER(halGrpQuery)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
            outBoundP(reinterpret_cast<void*>(&queryResult), sizeof(queryResult)),
            outBoundP(reinterpret_cast<unsigned int*>(&resultSize)))
        .will(returnValue(0));
    MOCKER(HcclRegisterMemory)
        .stubs()
        .will(returnValue(HCCL_SUCCESS));
    MOCKER(HcclUnregisterMemory)
        .stubs()
        .will(returnValue(HCCL_SUCCESS));
    auto ret = dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(handle, hcclHandle);
    // destroy hcom handle
    ret = dgwClient->DestroyHcomHandle(handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "";
    bqs::RouterServer::GetInstance().cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(DgwClientConfigUtest, CreateHcomHandle_Failed_RegisterMem)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    // create hcom handle
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0U;
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "grp1, grp2";
    GrpQueryGroupAddrInfo queryResult = {};
    auto resultSize = sizeof(queryResult);
    MOCKER(halGrpQuery)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
            outBoundP(reinterpret_cast<void*>(&queryResult), sizeof(queryResult)),
            outBoundP(reinterpret_cast<unsigned int*>(&resultSize)))
        .will(returnValue(0));
    MOCKER(HcclRegisterMemory)
        .stubs()
        .will(returnValue(HCCL_E_RESERVED));
    auto ret = dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle);
    EXPECT_NE(bqs::BQS_STATUS_OK, ret);
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "";
    bqs::RouterServer::GetInstance().cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(DgwClientConfigUtest, CreateHcomHandle_Success_UnregisterMem)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    // create hcom handle
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0U;
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "grp1, grp2";
    GrpQueryGroupAddrInfo queryResult = {};
    auto resultSize = sizeof(queryResult);
    MOCKER(halGrpQuery)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
            outBoundP(reinterpret_cast<void*>(&queryResult), sizeof(queryResult)),
            outBoundP(reinterpret_cast<unsigned int*>(&resultSize)))
        .will(returnValue(0));
    MOCKER(HcclRegisterMemory)
        .stubs()
        .will(returnValue(HCCL_SUCCESS));
    MOCKER(HcclUnregisterMemory)
        .stubs()
        .will(returnValue(HCCL_E_RESERVED));
    auto ret = dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(handle, hcclHandle);
    // destroy hcom handle
    ret = dgwClient->DestroyHcomHandle(handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "";
    bqs::RouterServer::GetInstance().cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(DgwClientConfigUtest, CreateHcomHandle_Failed_HcclFinalizeComm)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    // create hcom handle
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0U;
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "grp1, grp2";
    GrpQueryGroupAddrInfo queryResult = {};
    auto resultSize = sizeof(queryResult);
    MOCKER(halGrpQuery)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
            outBoundP(reinterpret_cast<void*>(&queryResult), sizeof(queryResult)),
            outBoundP(reinterpret_cast<unsigned int*>(&resultSize)))
        .will(returnValue(0));
    MOCKER(HcclRegisterMemory)
        .stubs()
        .will(returnValue(HCCL_SUCCESS));
    MOCKER(HcclUnregisterMemory)
        .stubs()
        .will(returnValue(HCCL_E_RESERVED));
    MOCKER(HcclFinalizeComm)
        .stubs()
        .will(returnValue(HCCL_E_RESERVED));
    auto ret = dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(handle, hcclHandle);
    // destroy hcom handle
    ret = dgwClient->DestroyHcomHandle(handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    bqs::RouterServer::GetInstance().cfgInfoOperator_->groupNames_ = "";
    bqs::RouterServer::GetInstance().cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(DgwClientConfigUtest, UpdateGroup_Success01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    bqs::Endpoint endpoints[2UL];
    endpoints[0].type = bqs::EndpointType::QUEUE;
    endpoints[0].attr.queueAttr.queueId = 1001;
    endpoints[1].type = bqs::EndpointType::QUEUE;
    endpoints[1].attr.queueAttr.queueId = 1002;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    int32_t groupId = config.cfg.groupCfg.groupId;
    printf("create group id is %d.", groupId);
    bqs::ConfigInfo cfgForDel;
    cfgForDel.cfg.groupCfg.groupId = groupId;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
}

TEST_F(DgwClientConfigUtest, UpdateConfig_Failed00)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = true;

    // create group1
    bqs::Endpoint endpoints[1UL];
    endpoints[0].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[0].attr.memQueueAttr.queueId = 1103;
    endpoints[0].attr.memQueueAttr.queueType = 1;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 1U;
    config.cfg.groupCfg.endpoints = endpoints;

    std::vector<int32_t> cfgRets;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_ENDPOINT_MEM_TYPE_NOT_SUPPORT), dgwClient->UpdateConfig(config, cfgRets));
}

TEST_F(DgwClientConfigUtest, QueryGroup_Success01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create group1
    bqs::Endpoint endpoints[2UL];
    endpoints[0].type = bqs::EndpointType::QUEUE;
    endpoints[0].attr.queueAttr.queueId = 1003;
    endpoints[1].type = bqs::EndpointType::QUEUE;
    endpoints[1].attr.queueAttr.queueId = 1004;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    int32_t groupId1 = config.cfg.groupCfg.groupId;
    printf("create group id is %d.\n", groupId1);

    // create group2
    bqs::Endpoint endpoints2[3UL];
    endpoints2[0].type = bqs::EndpointType::QUEUE;
    endpoints2[0].attr.queueAttr.queueId = 1005;
    endpoints2[1].type = bqs::EndpointType::QUEUE;
    endpoints2[1].attr.queueAttr.queueId = 1006;
    endpoints2[2].type = bqs::EndpointType::QUEUE;
    endpoints2[2].attr.queueAttr.queueId = 1007;

    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 3U;
    config.cfg.groupCfg.endpoints = endpoints2;

    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    int32_t groupId2 = config.cfg.groupCfg.groupId;
    printf("create group id is %d.\n", groupId2);

    // query group1 num
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId1;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(2, query.qry.groupQry.endpointNum);

    // query group2 num
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId2;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(3, query.qry.groupQry.endpointNum);

    // query group1 info
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId1;
    query.qry.groupQry.endpointNum = 2U;
    bqs::Endpoint qryEndpoints[2UL] = {};
    bqs::ConfigInfo qryConfig;
    qryConfig.cfg.groupCfg.endpoints = qryEndpoints;
    ret = dgwClient->QueryConfig(query, qryConfig);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(qryEndpoints[0].type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryEndpoints[0].attr.queueAttr.queueId, 1003);
    EXPECT_EQ(qryEndpoints[1].type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryEndpoints[1].attr.queueAttr.queueId, 1004);

    // query group2 info
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId2;
    query.qry.groupQry.endpointNum = 3U;
    bqs::Endpoint qryEndpoints2[3UL] = {};
    qryConfig.cfg.groupCfg.endpoints = qryEndpoints2;
    ret = dgwClient->QueryConfig(query, qryConfig);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(qryEndpoints2[0].type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryEndpoints2[0].attr.queueAttr.queueId, 1005);
    EXPECT_EQ(qryEndpoints2[1].type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryEndpoints2[1].attr.queueAttr.queueId, 1006);
    EXPECT_EQ(qryEndpoints2[2].type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryEndpoints2[2].attr.queueAttr.queueId, 1007);

    // delete group1
    bqs::ConfigInfo cfgForDel;
    cfgForDel.cfg.groupCfg.groupId = groupId1;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    // delete group2
    cfgForDel.cfg.groupCfg.groupId = groupId2;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    // query not exist group
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId2;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_GROUP_NOT_EXIST, ret);
    EXPECT_EQ(0, query.qry.groupQry.endpointNum);
}

TEST_F(DgwClientConfigUtest, QueryGroup_Failed01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create group1
    bqs::Endpoint endpoints[3UL];
    endpoints[0].type = bqs::EndpointType::QUEUE;
    endpoints[0].attr.queueAttr.queueId = 1008;
    endpoints[1].type = bqs::EndpointType::QUEUE;
    endpoints[1].attr.queueAttr.queueId = 1009;
    endpoints[2].type = bqs::EndpointType::QUEUE;
    endpoints[2].attr.queueAttr.queueId = 1010;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 3U;
    config.cfg.groupCfg.endpoints = endpoints;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    int32_t groupId = config.cfg.groupCfg.groupId;
    printf("create group id is %d.\n", groupId);

    // query group num
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(3, query.qry.groupQry.endpointNum);

    // query group info
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId;
    query.qry.groupQry.endpointNum = 2U;
    bqs::Endpoint qryEndpoints[2UL];
    bqs::ConfigInfo qryConfig;
    qryConfig.cfg.groupCfg.endpoints = qryEndpoints;
    ret = dgwClient->QueryConfig(query, qryConfig);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret);

    // delete group
    bqs::ConfigInfo cfgForDel;
    cfgForDel.cfg.groupCfg.groupId = groupId;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
}

TEST_F(DgwClientConfigUtest, UpdateRoute_Success01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create routes1
    bqs::Route routes[2UL] = {};
    routes[0].src.type = bqs::EndpointType::QUEUE;
    routes[0].src.attr.queueAttr.queueId = 1011;
    routes[0].dst.type = bqs::EndpointType::QUEUE;
    routes[0].dst.attr.queueAttr.queueId = 1012;
    routes[1].src.type = bqs::EndpointType::QUEUE;
    routes[1].src.attr.queueAttr.queueId = 1013;
    routes[1].dst.type = bqs::EndpointType::QUEUE;
    routes[1].dst.attr.queueAttr.queueId = 1014;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    config.cfg.routesCfg.routeNum = 2U;
    config.cfg.routesCfg.routes = routes;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(2, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);

    // create routes2
    bqs::Route routes2[3UL] = {};
    routes2[0].src.type = bqs::EndpointType::QUEUE;
    routes2[0].src.attr.queueAttr.queueId = 1015;
    routes2[0].dst.type = bqs::EndpointType::QUEUE;
    routes2[0].dst.attr.queueAttr.queueId = 1016;
    routes2[1].src.type = bqs::EndpointType::QUEUE;
    routes2[1].src.attr.queueAttr.queueId = 1017;
    routes2[1].dst.type = bqs::EndpointType::QUEUE;
    routes2[1].dst.attr.queueAttr.queueId = 1018;
    routes2[2].src.type = bqs::EndpointType::QUEUE;
    routes2[2].src.attr.queueAttr.queueId = 1019;
    routes2[2].dst.type = bqs::EndpointType::QUEUE;
    routes2[2].dst.attr.queueAttr.queueId = 1020;

    bqs::ConfigInfo config2;
    config2.cmd = bqs::ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    config2.cfg.routesCfg.routeNum = 3U;
    config2.cfg.routesCfg.routes = routes2;

    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config2, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(3, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[2]);

    // delete routes1
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(2, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);

    // delete routes2
    config2.cmd = bqs::ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config2, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(3, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[2]);
}

TEST_F(DgwClientConfigUtest, UpdateRoute_WithNuma_Success01)
{
    bqs::GlobalCfg::GetInstance().SetNumaFlag(true);
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create routes1
    bqs::Route routes[1UL];
    routes[0].src.type = bqs::EndpointType::QUEUE;
    routes[0].src.attr.queueAttr.queueId = 1011;
    routes[0].src.resId = 0x8000;
    routes[0].dst.type = bqs::EndpointType::QUEUE;
    routes[0].dst.attr.queueAttr.queueId = 1012;
    routes[0].dst.resId = 0x8000;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    config.cfg.routesCfg.routeNum = 1U;
    config.cfg.routesCfg.routes = routes;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    // delete routes1
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    bqs::GlobalCfg::GetInstance().SetNumaFlag(false);
}

TEST_F(DgwClientConfigUtest, QueryRoute_Success01)
{
    GlobalCfg::GetInstance().SetNumaFlag(true);
    GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create routes
    bqs::Route routes[4UL] = {};
    // route 0
    routes[0].src.type = bqs::EndpointType::QUEUE;
    routes[0].src.attr.queueAttr.queueId = 1021;
    routes[0].dst.type = bqs::EndpointType::QUEUE;
    routes[0].dst.attr.queueAttr.queueId = 1022;
    // route 1
    routes[1].src.type = bqs::EndpointType::QUEUE;
    routes[1].src.attr.queueAttr.queueId = 1023;
    routes[1].dst.type = bqs::EndpointType::QUEUE;
    routes[1].dst.attr.queueAttr.queueId = 1024;
    // route 2
    routes[2].src.type = bqs::EndpointType::QUEUE;
    routes[2].src.attr.queueAttr.queueId = 1025;
    routes[2].dst.type = bqs::EndpointType::QUEUE;
    routes[2].dst.attr.queueAttr.queueId = 1026;

    // route3
    routes[3].src.type = bqs::EndpointType::QUEUE;
    routes[3].src.attr.queueAttr.queueId = 1021;
    routes[3].dst.type = bqs::EndpointType::QUEUE;
    routes[3].dst.attr.queueAttr.queueId = 1027;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    config.cfg.routesCfg.routeNum = 4U;
    config.cfg.routesCfg.routes = routes;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(4, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[2]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[3]);

    // query all routes num
    ConfigQuery query = {};
    query.mode = QueryMode::DGW_QUERY_MODE_ALL_ROUTE;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 4);

    // query routes num by src
    query.mode = QueryMode::DGW_QUERY_MODE_SRC_ROUTE;
    query.qry.routeQry.src.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.src.attr.queueAttr.queueId = 1025;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 1);

    // query routes num by no exist src
    query.mode = QueryMode::DGW_QUERY_MODE_SRC_ROUTE;
    query.qry.routeQry.src.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.src.attr.queueAttr.queueId = 1026;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 0);

    // query routes num by dst
    query.mode = QueryMode::DGW_QUERY_MODE_DST_ROUTE;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1026;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 1);

    // query routs num by no exist dst
    query.mode = QueryMode::DGW_QUERY_MODE_DST_ROUTE;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1025;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 0);

    // query routes num by src and dst
    query.mode = QueryMode::DGW_QUERY_MODE_SRC_DST_ROUTE;
    query.qry.routeQry.src.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.src.attr.queueAttr.queueId = 1025;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1026;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 1);

    // query routes num by src and dst_not exist
    query.mode = QueryMode::DGW_QUERY_MODE_SRC_DST_ROUTE;
    query.qry.routeQry.src.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.src.attr.queueAttr.queueId = 1026;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1024;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 0);

    // query all routes
    query.mode = QueryMode::DGW_QUERY_MODE_ALL_ROUTE;
    query.qry.routeQry.routeNum = 4U;
    ConfigInfo cfgInfo;
    Route qryRoutes[4];
    cfgInfo.cfg.routesCfg.routes = qryRoutes;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(cfgInfo.cfg.routesCfg.routeNum, 4);
    EXPECT_EQ(qryRoutes[0].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[0].src.attr.queueAttr.queueId, 1025);
    EXPECT_EQ(qryRoutes[0].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[0].dst.attr.queueAttr.queueId, 1026);
    EXPECT_EQ(qryRoutes[1].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[1].src.attr.queueAttr.queueId, 1023);
    EXPECT_EQ(qryRoutes[1].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[1].dst.attr.queueAttr.queueId, 1024);
    EXPECT_EQ(qryRoutes[2].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[2].src.attr.queueAttr.queueId, 1021);
    EXPECT_EQ(qryRoutes[2].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[2].dst.attr.queueAttr.queueId, 1027);
    EXPECT_EQ(qryRoutes[3].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[3].src.attr.queueAttr.queueId, 1021);
    EXPECT_EQ(qryRoutes[3].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[3].dst.attr.queueAttr.queueId, 1022);

    // qry routes by src
    query.mode = QueryMode::DGW_QUERY_MODE_SRC_ROUTE;
    query.qry.routeQry.routeNum = 2U;
    query.qry.routeQry.src.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.src.attr.queueAttr.queueId = 1021;
    Route qryRoutes2[2];
    cfgInfo.cfg.routesCfg.routes = qryRoutes2;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(cfgInfo.cfg.routesCfg.routeNum, 2);
    EXPECT_EQ(qryRoutes2[0].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes2[0].src.attr.queueAttr.queueId, 1021);
    EXPECT_EQ(qryRoutes2[0].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes2[0].dst.attr.queueAttr.queueId, 1027);
    EXPECT_EQ(qryRoutes2[1].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes2[1].src.attr.queueAttr.queueId, 1021);
    EXPECT_EQ(qryRoutes2[1].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes2[1].dst.attr.queueAttr.queueId, 1022);

    // qry routes by dst
    query.mode = QueryMode::DGW_QUERY_MODE_DST_ROUTE;
    query.qry.routeQry.routeNum = 1U;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1027;
    Route qryRoutes3[1];
    cfgInfo.cfg.routesCfg.routes = qryRoutes3;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(cfgInfo.cfg.routesCfg.routeNum, 1);
    EXPECT_EQ(qryRoutes3[0].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes3[0].src.attr.queueAttr.queueId, 1021);
    EXPECT_EQ(qryRoutes3[0].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes3[0].dst.attr.queueAttr.queueId, 1027);

    // qry routes by src and dst
    query.mode = QueryMode::DGW_QUERY_MODE_SRC_DST_ROUTE;
    query.qry.routeQry.routeNum = 1U;
    query.qry.routeQry.src.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.src.attr.queueAttr.queueId = 1023;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1024;
    Route qryRoutes4[1];
    cfgInfo.cfg.routesCfg.routes = qryRoutes4;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(cfgInfo.cfg.routesCfg.routeNum, 1);
    EXPECT_EQ(qryRoutes4[0].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes4[0].src.attr.queueAttr.queueId, 1023);
    EXPECT_EQ(qryRoutes4[0].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes4[0].dst.attr.queueAttr.queueId, 1024);

    // qry not exist route
    query.mode = QueryMode::DGW_QUERY_MODE_DST_ROUTE;
    query.qry.routeQry.routeNum = 1U;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1029;
    Route qryRoutes5[1];
    cfgInfo.cfg.routesCfg.routes = qryRoutes5;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret);

    // delete routes
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(4, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[2]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[3]);

    // query all routes num
    query.mode = QueryMode::DGW_QUERY_MODE_ALL_ROUTE;
    ret = dgwClient->QueryConfigNum(query);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(query.qry.routeQry.routeNum, 0);

    // query defalut
    query.mode = QueryMode::DGW_QUERY_MODE_RESERVED;
    query.qry.routeQry.routeNum = 1U;
    query.qry.routeQry.src.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.src.attr.queueAttr.queueId = 1023;
    query.qry.routeQry.dst.type = bqs::EndpointType::QUEUE;
    query.qry.routeQry.dst.attr.queueAttr.queueId = 1024;
    Route qryRoutes6[1];
    cfgInfo.cfg.routesCfg.routes = qryRoutes6;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret);
    GlobalCfg::GetInstance().SetNumaFlag(false);
    GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
}

TEST_F(DgwClientConfigUtest, UpdateRouteWithGroup_Success01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create group1
    bqs::Endpoint endpoints[2UL] = {};
    endpoints[0].type = bqs::EndpointType::QUEUE;
    endpoints[0].attr.queueAttr.queueId = 1030;
    endpoints[1].type = bqs::EndpointType::QUEUE;
    endpoints[1].attr.queueAttr.queueId = 1031;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    int32_t groupId1 = config.cfg.groupCfg.groupId;
    printf("create group id is %d.\n", groupId1);

    // create group2
    bqs::Endpoint endpoints2[3UL] = {};
    endpoints2[0].type = bqs::EndpointType::QUEUE;
    endpoints2[0].attr.queueAttr.queueId = 1032;
    endpoints2[1].type = bqs::EndpointType::QUEUE;
    endpoints2[1].attr.queueAttr.queueId = 1033;
    endpoints2[2].type = bqs::EndpointType::QUEUE;
    endpoints2[2].attr.queueAttr.queueId = 1034;

    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 3U;
    config.cfg.groupCfg.endpoints = endpoints2;

    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    int32_t groupId2 = config.cfg.groupCfg.groupId;
    printf("create group id is %d.\n", groupId2);

    auto &allGroupConfig = bqs::BindRelation::GetInstance().allGroupConfig_;
    EXPECT_EQ(2, allGroupConfig.size());

    // create routes
    bqs::Route routes[2UL] = {};
    // route 0
    routes[0].src.type = bqs::EndpointType::QUEUE;
    routes[0].src.attr.queueAttr.queueId = 1035;
    routes[0].dst.type = bqs::EndpointType::GROUP;
    routes[0].dst.attr.groupAttr.groupId = groupId1;
    // route 1
    routes[1].src.type = bqs::EndpointType::GROUP;
    routes[1].src.attr.groupAttr.groupId = groupId2;
    routes[1].dst.type = bqs::EndpointType::QUEUE;
    routes[1].dst.attr.queueAttr.queueId = 1036;

    bqs::ConfigInfo config2;
    config2.cmd = bqs::ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    config2.cfg.routesCfg.routeNum = 2U;
    config2.cfg.routesCfg.routes = routes;

    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config2, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(2, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);

    auto &groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    EXPECT_EQ(groupEntityMap.size(), 2);

    // query all route
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_ALL_ROUTE;
    query.qry.routeQry.routeNum = 2U;
    ConfigInfo cfgInfo;
    Route qryRoutes[2] = {};
    cfgInfo.cfg.routesCfg.routes = qryRoutes;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(cfgInfo.cfg.routesCfg.routeNum, 2);
    EXPECT_EQ(qryRoutes[0].src.type, bqs::EndpointType::GROUP);
    EXPECT_EQ(qryRoutes[0].src.attr.groupAttr.groupId, groupId2);
    EXPECT_EQ(qryRoutes[0].dst.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[0].dst.attr.queueAttr.queueId, 1036);
    EXPECT_EQ(qryRoutes[1].src.type, bqs::EndpointType::QUEUE);
    EXPECT_EQ(qryRoutes[1].src.attr.queueAttr.queueId, 1035);
    EXPECT_EQ(qryRoutes[1].dst.type, bqs::EndpointType::GROUP);
    EXPECT_EQ(qryRoutes[1].dst.attr.groupAttr.groupId, groupId1);

    // check entity number
    auto &idToEntityMap = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 2);
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 7);

    /* create group2
    bqs::Endpoint endpoints3[2UL];
    endpoints3[0].type = bqs::EndpointType::QUEUE;
    endpoints3[0].attr.queueAttr.queueId = 1030;
    endpoints3[1].type = bqs::EndpointType::QUEUE;
    endpoints3[1].attr.queueAttr.queueId = 1037;

    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints3;

    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    // check entity number
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 2);
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 7);*/

    // delete group
    bqs::ConfigInfo cfgForDel;
    cfgForDel.cfg.groupCfg.groupId = groupId1;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_NE(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_GROUP_EXIST_IN_ROUTE), cfgRets[0]);

    // delete route
    config2.cmd = bqs::ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config2, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(2, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[1]);

    // check entity number
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 0);
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 0);
    EXPECT_EQ(groupEntityMap.size(), 0);

    // delete group
    cfgForDel.cfg.groupCfg.groupId = groupId1;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(1, allGroupConfig.size());

    cfgForDel.cfg.groupCfg.groupId = groupId2;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    EXPECT_EQ(0, allGroupConfig.size());
}

TEST_F(DgwClientConfigUtest, UpdateRoute_Success02)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create handle
    const std::string rankTable("This is my rank table.");
    uint64_t handle = 0UL;
    int32_t ret = dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(handle, 100UL);

    const uint32_t localRankId = 0U;
    const uint32_t peerRankId = 1U;
    const uint32_t localTagDepth = 128U;
    const uint32_t peerTagDepth = 128U;
    const uint32_t groupTagId1 = 1U;
    const uint32_t groupTagId2 = 2U;
    const uint32_t tagId3 = 3U;
    // create group
    bqs::Endpoint endpoints[2UL] = {};
    endpoints[0].type = bqs::EndpointType::COMM_CHANNEL;
    endpoints[0].attr.channelAttr.handle = handle;
    endpoints[0].attr.channelAttr.localTagId = groupTagId1;
    endpoints[0].attr.channelAttr.peerTagId = groupTagId1;
    endpoints[0].attr.channelAttr.localRankId = localRankId;
    endpoints[0].attr.channelAttr.peerRankId = peerRankId;
    endpoints[0].attr.channelAttr.localTagDepth = localTagDepth;
    endpoints[0].attr.channelAttr.peerTagDepth = peerTagDepth;

    endpoints[1].type = bqs::EndpointType::COMM_CHANNEL;
    endpoints[1].attr.channelAttr.handle = handle;
    endpoints[1].attr.channelAttr.localTagId = groupTagId2;
    endpoints[1].attr.channelAttr.peerTagId = groupTagId2;
    endpoints[1].attr.channelAttr.localRankId = localRankId;
    endpoints[1].attr.channelAttr.peerRankId = peerRankId;
    endpoints[1].attr.channelAttr.localTagDepth = localTagDepth;
    endpoints[1].attr.channelAttr.peerTagDepth = peerTagDepth;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;

    std::vector<int32_t> cfgRets;
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    int32_t groupId = config.cfg.groupCfg.groupId;
    printf("create group id is %d.\n", groupId);

    // bind group with tag error: group bind with tag in group
    bqs::Route routes[1UL] = {};
    routes[0].src.type = bqs::EndpointType::COMM_CHANNEL;
    routes[0].src.attr.channelAttr.handle = handle;
    routes[0].src.attr.channelAttr.localTagId = groupTagId1;
    routes[0].src.attr.channelAttr.peerTagId = groupTagId1;
    routes[0].src.attr.channelAttr.localRankId = localRankId;
    routes[0].src.attr.channelAttr.peerRankId = peerRankId;
    routes[0].src.attr.channelAttr.localTagDepth = localTagDepth;
    routes[0].src.attr.channelAttr.peerTagDepth = peerTagDepth;
    routes[0].dst.type = bqs::EndpointType::GROUP;
    routes[0].dst.attr.groupAttr.groupId = groupId;

    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    config.cfg.routesCfg.routeNum = 1U;
    config.cfg.routesCfg.routes = routes;

    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_FAILED, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_PARAM_INVALID), cfgRets[0]);

    // bind group with tag
    routes[0].src.attr.channelAttr.localTagId = tagId3;
    routes[0].src.attr.channelAttr.peerTagId = tagId3;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    auto &idToEntityMap = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_TAG].size(), 3);

    // query route
    ConfigQuery query = {};
    query.mode = QueryMode::DGW_QUERY_MODE_ALL_ROUTE;
    query.qry.routeQry.routeNum = 1U;
    ConfigInfo cfgInfo;
    Route qryRoutes[1];
    cfgInfo.cfg.routesCfg.routes = qryRoutes;
    ret = dgwClient->QueryConfig(query, cfgInfo);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(cfgInfo.cfg.routesCfg.routeNum, 1);
    EXPECT_EQ(qryRoutes[0].src.type, bqs::EndpointType::COMM_CHANNEL);
    EXPECT_EQ(qryRoutes[0].src.attr.channelAttr.handle, handle);
    EXPECT_EQ(qryRoutes[0].src.attr.channelAttr.localTagId, tagId3);
    EXPECT_EQ(qryRoutes[0].src.attr.channelAttr.peerTagId, tagId3);
    EXPECT_EQ(qryRoutes[0].src.attr.channelAttr.localRankId, localRankId);
    EXPECT_EQ(qryRoutes[0].src.attr.channelAttr.peerRankId, peerRankId);
    EXPECT_EQ(qryRoutes[0].src.attr.channelAttr.localTagDepth, localTagDepth);
    EXPECT_EQ(qryRoutes[0].src.attr.channelAttr.peerTagDepth, peerTagDepth);

    EXPECT_EQ(qryRoutes[0].dst.type, bqs::EndpointType::GROUP);
    EXPECT_EQ(qryRoutes[0].dst.attr.groupAttr.groupId, groupId);

    // query group
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = groupId;
    query.qry.groupQry.endpointNum = 2U;
    bqs::Endpoint qryEndpoints2[2UL] = {};
    bqs::ConfigInfo qryConfig;
    qryConfig.cfg.groupCfg.endpoints = qryEndpoints2;
    ret = dgwClient->QueryConfig(query, qryConfig);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    // check endpoint1
    EXPECT_EQ(qryEndpoints2[0].type, bqs::EndpointType::COMM_CHANNEL);
    EXPECT_EQ(qryEndpoints2[0].attr.channelAttr.handle, handle);
    EXPECT_EQ(qryEndpoints2[0].attr.channelAttr.localRankId, localRankId);
    EXPECT_EQ(qryEndpoints2[0].attr.channelAttr.peerRankId, peerRankId);
    EXPECT_EQ(qryEndpoints2[0].attr.channelAttr.localTagId, groupTagId1);
    EXPECT_EQ(qryEndpoints2[0].attr.channelAttr.peerTagId, groupTagId1);
    EXPECT_EQ(qryEndpoints2[0].attr.channelAttr.localTagDepth, localTagDepth);
    EXPECT_EQ(qryEndpoints2[0].attr.channelAttr.peerTagDepth, peerTagDepth);
    // check endpoint2
    EXPECT_EQ(qryEndpoints2[1].type, bqs::EndpointType::COMM_CHANNEL);
    EXPECT_EQ(qryEndpoints2[1].attr.channelAttr.handle, handle);
    EXPECT_EQ(qryEndpoints2[1].attr.channelAttr.localRankId, localRankId);
    EXPECT_EQ(qryEndpoints2[1].attr.channelAttr.peerRankId, peerRankId);
    EXPECT_EQ(qryEndpoints2[1].attr.channelAttr.localTagId, groupTagId2);
    EXPECT_EQ(qryEndpoints2[1].attr.channelAttr.peerTagId, groupTagId2);
    EXPECT_EQ(qryEndpoints2[1].attr.channelAttr.localTagDepth, localTagDepth);
    EXPECT_EQ(qryEndpoints2[1].attr.channelAttr.peerTagDepth, peerTagDepth);

    // delete route
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);

    // delete group
    bqs::ConfigInfo cfgForDel;
    cfgForDel.cfg.groupCfg.groupId = groupId;
    cfgForDel.cmd = bqs::ConfigCmd::DGW_CFG_CMD_DEL_GROUP;
    cfgRets.clear();
    ret = dgwClient->UpdateConfig(cfgForDel, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);

    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 0);
    EXPECT_EQ(idToEntityMap[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_TAG].size(), 0);

    ret = dgwClient->DestroyHcomHandle(handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
}

TEST_F(DgwClientConfigUtest, UpdateConfig_Failed01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = false;
    dgwClient->isServerOldVersion_ = false;

    ConfigInfo cfgInfo;
    std::vector<int32_t> cfgRets;
    auto ret = dgwClient->UpdateConfig(cfgInfo, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_NOT_INIT, ret);
}

TEST_F(DgwClientConfigUtest, UpdateRoute_Failed02)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    // create handle
    const std::string rankTable("This is my rank table.");
    uint64_t handle = 0UL;
    int32_t ret = dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(handle, 100UL);

    // rankId error: localRankId == peerRankId
    uint32_t localRankId = 0U;
    uint32_t peerRankId = 0U;
    uint32_t localTagDepth = 128U;
    uint32_t peerTagDepth = 128U;
    uint32_t localTagId1 = 1U;
    uint32_t peerTagId1 = 1U;
    uint32_t localTagId2 = 2U;
    uint32_t peerTagId2 = 2U;
    // create group
    bqs::Endpoint endpoints[2UL];
    endpoints[0].type = bqs::EndpointType::COMM_CHANNEL;
    endpoints[0].attr.channelAttr.handle = handle;
    endpoints[0].attr.channelAttr.localTagId = localTagId1;
    endpoints[0].attr.channelAttr.peerTagId = peerTagId1;
    endpoints[0].attr.channelAttr.localRankId = localRankId;
    endpoints[0].attr.channelAttr.peerRankId = peerRankId;
    endpoints[0].attr.channelAttr.localTagDepth = localTagDepth;
    endpoints[0].attr.channelAttr.peerTagDepth = peerTagDepth;

    endpoints[1].type = bqs::EndpointType::COMM_CHANNEL;
    endpoints[1].attr.channelAttr.handle = handle;
    endpoints[1].attr.channelAttr.localTagId = localTagId2;
    endpoints[1].attr.channelAttr.peerTagId = peerTagId2;
    endpoints[1].attr.channelAttr.localRankId = localRankId;
    endpoints[1].attr.channelAttr.peerRankId = peerRankId;
    endpoints[1].attr.channelAttr.localTagDepth = localTagDepth;
    endpoints[1].attr.channelAttr.peerTagDepth = peerTagDepth;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;

    std::vector<int32_t> cfgRets;
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_PARAM_INVALID, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_PARAM_INVALID), cfgRets[0]);

    localRankId = 0U;
    peerRankId = 1U;
    endpoints[0].attr.channelAttr.localRankId = localRankId;
    endpoints[0].attr.channelAttr.peerRankId = peerRankId;
    endpoints[1].attr.channelAttr.localRankId = localRankId;
    endpoints[1].attr.channelAttr.peerRankId = peerRankId;
    // tagId error: localTagId != peerTagId
    localTagId1 = 1U;
    peerTagId1 = 3U;
    endpoints[0].attr.channelAttr.localTagId = localTagId1;
    endpoints[0].attr.channelAttr.peerTagId = peerTagId1;

    std::vector<int32_t> cfgRets2;
    ret = dgwClient->UpdateConfig(config, cfgRets2);
    EXPECT_EQ(bqs::BQS_PARAM_INVALID, ret);
    EXPECT_EQ(1, cfgRets2.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_PARAM_INVALID), cfgRets2[0]);

    localTagId1 = 1U;
    peerTagId1 = 1U;
    endpoints[0].attr.channelAttr.localTagId = localTagId1;
    endpoints[0].attr.channelAttr.peerTagId = peerTagId1;
    // tagDepth error: localTagDepth > 8 * 1024
    localTagDepth = 8U * 1024U + 1U;
    endpoints[0].attr.channelAttr.localTagDepth = localTagDepth;
    std::vector<int32_t> cfgRets3;
    ret = dgwClient->UpdateConfig(config, cfgRets3);
    EXPECT_EQ(bqs::BQS_PARAM_INVALID, ret);
    EXPECT_EQ(1, cfgRets3.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_PARAM_INVALID), cfgRets3[0]);

    ret = dgwClient->DestroyHcomHandle(handle);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
}

TEST_F(DgwClientConfigUtest, GetEntitiesInGroup_Success01)
{
    uint32_t groupId = 1U;
    auto entities = EntityManager::Instance().GetEntitiesInGroup(groupId);
    EXPECT_EQ(entities.size(), 0UL);

    std::vector<EntityPtr> entitiesInGroup;
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_QUEUE;
    material.hostGroupId = groupId;
    material.id = 1001U;
    EntityPtr entity = std::make_shared<SimpleEntity>(material, 0U);
    entitiesInGroup.emplace_back(entity);
    auto ret = EntityManager::Instance().CreateGroup(groupId, entitiesInGroup);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    entities = EntityManager::Instance().GetEntitiesInGroup(groupId);
    EXPECT_EQ(entities.size(), 1UL);
}

TEST_F(DgwClientConfigUtest, GetEntitiesInGroup_Success02)
{
    uint32_t groupId = 2U;
    std::vector<EntityInfoPtr> entitiesForG1;
    bqs::OptionalArg args = {};
    args.queueType = bqs::CLIENT_Q;
    EntityInfoPtr entityPtr1 = std::make_shared<EntityInfo>(123U, 0U, &args);
    EntityInfoPtr entityPtr3 = std::make_shared<EntityInfo>(231U, 0U, &args);
    entitiesForG1.emplace_back(entityPtr1);
    entitiesForG1.emplace_back(entityPtr3);
    EXPECT_EQ(bqs::BindRelation::GetInstance().CreateGroup(entitiesForG1, groupId), BQS_STATUS_OK);

    bqs::RouterServer::GetInstance().cfgInfoOperator_->CheckQueueAuthForGroup(groupId, false);
}

TEST_F(DgwClientConfigUtest, UpdateProfiling_Success01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_UPDATE_PROFILING;
    config.cfg.profCfg.profMode = ProfilingMode::PROFILING_OPEN;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
}

TEST_F(DgwClientConfigUtest, UpdateHcclProtocol_Success01)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL;
    config.cfg.hcclProtocolCfg.protocol = HcclProtocolType::RDMA;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
}

TEST_F(DgwClientConfigUtest, UpdateHcclProtocol_Success02)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL;
    config.cfg.hcclProtocolCfg.protocol = HcclProtocolType::TCP;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
}

TEST_F(DgwClientConfigUtest, UpdateHcclProtocol_Success03)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_SET_HCCL_PROTOCOL;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_PARAM_INVALID), cfgRets[0]);
}

TEST_F(DgwClientConfigUtest, InitDynamicSched_Success01)
{
    bqs::GlobalCfg::GetInstance().SetNumaFlag(true);
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    DynamicSchedConfigV2 dynamicConfigV2 = {};
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE;
    config.cfg.dynamicSchedCfgV2 = &dynamicConfigV2;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
    bqs::GlobalCfg::GetInstance().SetNumaFlag(false);
}

TEST_F(DgwClientConfigUtest, InitDynamicSched_Success02)
{
    bqs::GlobalCfg::GetInstance().SetNumaFlag(true);
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    DynamicSchedConfigV2 dynamicConfigV2 = {};
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE;
    config.cfg.dynamicSchedCfgV2 = &dynamicConfigV2;

    MOCKER(halQueueAttach)
        .expects(exactly(3))
        .will(returnObjectList(DRV_ERROR_QUEUE_INNER_ERROR, DRV_ERROR_NONE, DRV_ERROR_QUEUE_INNER_ERROR));
    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_DRIVER_ERROR), cfgRets[0]);
    ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret);
    bqs::GlobalCfg::GetInstance().SetNumaFlag(false);
}

TEST_F(DgwClientConfigUtest, InitDynamicSched03)
{
    char_t *env = "7,6,5,4";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    MOCKER_CPP(&QSFeatureCtrl::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    bqs::GlobalCfg::GetInstance().SetNumaFlag(true);
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U, 1234, true);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;

    DynamicSchedConfigV2 dynamicConfigV2 = {};
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_INIT_DYNAMIC_SCHEDULE;
    config.cfg.dynamicSchedCfgV2 = &dynamicConfigV2;

    MOCKER(halQueueAttach).stubs().will(returnObjectList(DRV_ERROR_QUEUE_INNER_ERROR));
    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret);
    bqs::GlobalCfg::GetInstance().SetNumaFlag(false);
}

TEST_F(DgwClientConfigUtest, StopSchedule_Success)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;
    ReDeployConfig reDeployCfg = {};
    reDeployCfg.rootModelNum = 1;
    uint32_t modelIds[1] = {0};
    reDeployCfg.rootModelIdsAddr = PtrToValue(&modelIds[0]);
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_STOP_SCHEDULE;
    config.cfg.reDeployCfg = reDeployCfg;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
}

TEST_F(DgwClientConfigUtest, RestartSchedule_Success)
{
    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;
    ReDeployConfig reDeployCfg = {};
    reDeployCfg.rootModelNum = 1;
    uint32_t modelIds[1] = {0};
    reDeployCfg.rootModelIdsAddr = PtrToValue(&modelIds[0]);
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_CLEAR_AND_RESTART_SCHEDULE;
    config.cfg.reDeployCfg = reDeployCfg;

    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_OK, ret);
    EXPECT_EQ(1, cfgRets.size());
    EXPECT_EQ(static_cast<int32_t>(bqs::BQS_STATUS_OK), cfgRets[0]);
}