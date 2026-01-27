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
#include <iostream>
#include <cstdint>
#define private public
#define protected public
#include "driver/ascend_hal.h"
#include "runtime/config.h"
#include "securec.h"
#include "bind_relation.h"
#include "subscribe_manager.h"
#include "queue_manager.h"
#include "router_server.h"
#include "bqs_msg.h"
#include "bqs_status.h"
#include "qs_client.h"
#include "dgw_client.h"
#undef private
#undef protected
#include "queue_schedule_feature_ctrl.h"

using namespace std;
using namespace bqs;

namespace {
    drvError_t halEschedSubmitEventSyncFake(unsigned int devId,
        struct event_summary *event, int timeout, struct event_reply *reply)
    {
        if (reply != nullptr) {
            reply->reply_len = reply->buf_len;
            QsProcMsgRsp *qsProcMsgRsp =  (QsProcMsgRsp*)reply->buf;
            qsProcMsgRsp->retCode = BQS_STATUS_OK;
            qsProcMsgRsp->retValue = 1;
        }
        return DRV_ERROR_NONE;
    }
    drvError_t halEschedSubmitEventSyncFake1(unsigned int devId,
        struct event_summary *event, int timeout, struct event_reply *reply)
    {
        if (reply != nullptr) {
            reply->reply_len = reply->buf_len;
            QsProcMsgRsp *qsProcMsgRsp =  (QsProcMsgRsp*)reply->buf;
            qsProcMsgRsp->retCode = BQS_STATUS_FAILED;
            qsProcMsgRsp->retValue = 1;
        }
        return DRV_ERROR_NONE;
    }
    drvError_t halEschedSubmitEventSyncFake2(unsigned int devId,
        struct event_summary *event, int timeout, struct event_reply *reply)
    {
        return DRV_ERROR_INNER_ERR;
    }
    drvError_t halEschedSubmitEventSyncFake3(unsigned int devId,
        struct event_summary *event, int timeout, struct event_reply *reply)
    {
        return DRV_ERROR_SCHED_WAIT_TIMEOUT;
    }
    drvError_t halEschedSubmitEventSyncFake4(unsigned int devId,
        struct event_summary *event, int timeout, struct event_reply *reply)
    {
        if (reply != nullptr) {
            reply->reply_len = reply->buf_len;
            QsProcMsgRsp *qsProcMsgRsp =  (QsProcMsgRsp*)reply->buf;
            qsProcMsgRsp->retCode = BQS_STATUS_PARAM_INVALID;
            qsProcMsgRsp->retValue = 1;
        }
        return DRV_ERROR_NONE;
    }

    drvError_t fake_drvGetDevNum(uint32_t *num_dev)
    {
        *num_dev = 8;
        return DRV_ERROR_NONE;
    }

    drvError_t halGetDeviceInfoFake1(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t *value)
    {
        if ((moduleType == MODULE_TYPE_SYSTEM) && (infoType == INFO_TYPE_VERSION)) {
            *value = CHIP_ASCEND_910A << 8;
        }
        return DRV_ERROR_NONE;
    } 
}

class DgwClientStest : public testing::Test {
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
        std::cout << "DgwClientStest SetUpTestCase" << std::endl;
        MOCKER_CPP(&QSFeatureCtrl::IsSupportSetVisibleDevices).stubs().will(returnValue(false));
    }

    static void TearDownTestCase()
    {
        std::cout << "DgwClientStest TearDownTestCase" << std::endl;
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
    uint32_t buffer_[1024] = { 0 };
};

TEST_F(DgwClientStest, TestGetInstance)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(10U);
    EXPECT_EQ(BQS_STATUS_OK, dgwClient->Initialize(1, "test"));

    const auto dgwClientGetted = DgwClient::GetInstance(10U);
    EXPECT_TRUE(dgwClientGetted->initFlag_);

    std::shared_ptr<DgwClient> dgwClientWithPid = DgwClient::GetInstance(10U, 2);
    EXPECT_EQ(BQS_STATUS_OK, dgwClientWithPid->Initialize(2, "test"));
    const auto dgwClientGettedWithPid = DgwClient::GetInstance(10U, 2);
    EXPECT_TRUE(dgwClientGettedWithPid->initFlag_);
}

TEST_F(DgwClientStest, TestStubSo)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    EXPECT_EQ(BQS_STATUS_OK, dgwClient->Initialize(1, "test"));
}

void BqsCheckAssign32UAddStub(const uint32_t para1,
    const uint32_t para2, uint32_t &result, bool &onceOverFlow)
{
    onceOverFlow = true;
    return;
}

TEST_F(DgwClientStest, CreateHcomHandle)
{
    Mbuf *pmbuf = (Mbuf *)&buffer_;
    MOCKER(halMbufAlloc)
        .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&pmbuf))
        .will(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP((void **)&pmbuf))
        .will(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halQueueDeQueue)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
        .will(returnValue((int)DRV_ERROR_NONE));
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0LU;
    EXPECT_EQ(BQS_STATUS_OK,
        dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle));
    MOCKER(BqsCheckAssign32UAdd)
        .stubs()
        .will(invoke(BqsCheckAssign32UAddStub));
    EXPECT_EQ(BQS_STATUS_PARAM_INVALID,
        dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle));
}

TEST_F(DgwClientStest, CreateHcomHandleFailForUninited)
{
    std::shared_ptr<DgwClient> uninitedDgwClient = DgwClient::GetInstance(1U);
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0LU;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_NOT_INIT),
        uninitedDgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle));
}

TEST_F(DgwClientStest, CreateHcomHandleFailForEmptyRankTable)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    std::string rankTable = "";
    uint64_t handle = 0LU;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID),
        dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle));
}

TEST_F(DgwClientStest, DestroyHcomHandle)
{
    Mbuf *pmbuf = (Mbuf *)&buffer_;
    MOCKER(halMbufAlloc)
        .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&pmbuf))
        .will(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP((void **)&pmbuf))
        .will(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halQueueDeQueue)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
        .will(returnValue((int)DRV_ERROR_NONE));
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    uint64_t handle = 0;
    EXPECT_EQ(BQS_STATUS_OK, dgwClient->DestroyHcomHandle(handle));
}

TEST_F(DgwClientStest, DestroyHcomHandleForUninited)
{
    std::shared_ptr<DgwClient> uninitedDgwClient = DgwClient::GetInstance(1U);
    uint64_t handle = 0;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_NOT_INIT), uninitedDgwClient->DestroyHcomHandle(handle));
}

TEST_F(DgwClientStest, DestroyHcomHandle01)
{
    MOCKER(&DgwClient::OperateConfigToServer)
        .stubs()
        .will(returnValue(200));
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    uint64_t handle = 0;
    EXPECT_EQ(static_cast<int32_t>(200), dgwClient->DestroyHcomHandle(handle));
}

TEST_F(DgwClientStest, FinalizeTest)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    EXPECT_EQ(dgwClient->Finalize(), static_cast<int32_t>(BQS_STATUS_OK));
}

TEST_F(DgwClientStest, Initialize_Failed001)
{
    MOCKER(halQueueInit)
        .stubs()
        .will(returnValue(200));

    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    auto retCode = dgwClient->Initialize(1, "test");
    EXPECT_EQ(retCode, BQS_STATUS_DRIVER_ERROR);
}

TEST_F(DgwClientStest, Initialize_Failed002)
{
    MOCKER(halQueueInit)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halQueueAttach)
        .stubs()
        .will(returnValue(200));

    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    auto retCode = dgwClient->Initialize(1, "test");
    EXPECT_EQ(retCode, BQS_STATUS_DRIVER_ERROR);
}

TEST_F(DgwClientStest, Initialize_Failed003)
{
    MOCKER(halQueueInit)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halQueueAttach)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halBuffInit)
        .stubs()
        .will(returnValue(200));
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    auto retCode = dgwClient->Initialize(1, "test");
    EXPECT_EQ(retCode, BQS_STATUS_DRIVER_ERROR);
}

TEST_F(DgwClientStest, Initialize_Failed_For_AttachDeviceFail) {
    MOCKER(halEschedAttachDevice).stubs().will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(DgwClient::GetInstance(0U)->Initialize(1, "test"), BQS_STATUS_DRIVER_ERROR);
}

TEST_F(DgwClientStest, QueryConfigFailForUninited)
{
    ConfigQuery query;
    ConfigInfo cfgInfo;
    std::shared_ptr<DgwClient> uninitedDgwClient = DgwClient::GetInstance(1U);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_NOT_INIT), uninitedDgwClient->QueryConfig(query, cfgInfo));
}

TEST_F(DgwClientStest, QueryConfigNumFailForUninited)
{
    ConfigQuery query;
    ConfigInfo cfgInfo;
    std::shared_ptr<DgwClient> uninitedDgwClient = DgwClient::GetInstance(1U);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_NOT_INIT), uninitedDgwClient->QueryConfigNum(query));
}

TEST_F(DgwClientStest, GetQryConfigNumRetWhenCmdRetError)
{
    ConfigQuery query;
    uintptr_t mbufData = 0UL;
    int32_t cmdRet = static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->GetQryConfigNumRet(query, mbufData, cmdRet));
}

TEST_F(DgwClientStest, GetOperateHcomHandleRetWhenCmdRetError)
{
    QueueSubEventType eventType;
    HcomHandleInfo info;
    uintptr_t mbufData = 0UL;
    int32_t cmdRet = static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR);
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK),
              dgwClient->GetOperateHcomHandleRet(eventType, info, mbufData, 0U, cmdRet));
}

TEST_F(DgwClientStest, CalcConfigInfoLenErr)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    ConfigInfo cfgInfo;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_UNBIND_ROUTE;
    cfgInfo.cfg.routesCfg.routes = nullptr;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    size_t cfgLen = 0U;
    uint32_t routeNum = 1;
    std::unique_ptr<Route[]> myRoutes(new Route[routeNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[routeNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));

    std::unique_ptr<Route> routes(new Route);
    cfgInfo.cfg.routesCfg.routes = routes.get();
    cfgInfo.cfg.routesCfg.routeNum = 0U;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));


    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_QRY_GROUP;
    cfgInfo.cfg.groupCfg.endpoints = nullptr;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));

    std::unique_ptr<Endpoint> endpoints(new Endpoint);
    cfgInfo.cfg.groupCfg.endpoints = endpoints.get();
    cfgInfo.cfg.groupCfg.endpointNum = 0U;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));

    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_RESERVED;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));
}

TEST_F(DgwClientStest, GetOperateConfigRetDefault)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    ConfigInfo cfgInfo;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_RESERVED;
    cfgInfo.cfg.routesCfg.routes = nullptr;
    uintptr_t mbufData = 0UL;
    size_t cfgLen = 0U;
    std::vector<int32_t> cfgRets;
    int32_t cmdRet = 0;
    
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->GetOperateConfigRet(cfgInfo, mbufData, cfgLen, cfgRets, cmdRet));
}

TEST_F(DgwClientStest, CalcResultLenDefault)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    ConfigInfo cfgInfo;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_RESERVED;
    cfgInfo.cfg.routesCfg.routes = nullptr;
    size_t cfgLen = 0U;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->CalcResultLen(cfgInfo, cfgLen));
}

TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueErr001)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    ConfigInfo cfgInfo;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    Route routesClient[1];
    routesClient[0].status = RouteStatus::ACTIVE;
    routesClient[0].src.type = EndpointType::MEM_QUEUE;
    routesClient[0].src.status = EndpointStatus::AVAILABLE;
    routesClient[0].src.peerNum = 1;
    routesClient[0].src.localId = 101;
    routesClient[0].src.globalId = 1;
    routesClient[0].src.modelId = 1;
    routesClient[0].src.attr.memQueueAttr.queueId = 102;
    routesClient[0].src.attr.memQueueAttr.queueType = 1;
 
    routesClient[0].dst.type = EndpointType::MEM_QUEUE;
    routesClient[0].dst.status = EndpointStatus::AVAILABLE;
    routesClient[0].dst.peerNum = 1;
    routesClient[0].dst.localId = 103;
    routesClient[0].dst.globalId = 1;
    routesClient[0].dst.modelId = 1;
    routesClient[0].dst.attr.memQueueAttr.queueId = 103;
    routesClient[0].dst.attr.memQueueAttr.queueType = 1;
 
    cfgInfo.cfg.routesCfg.routes = routesClient;
    cfgInfo.cfg.routesCfg.routeNum = 1U;
    const uint32_t routeNum = 1;
    std::unique_ptr<Route[]> myRoutes(new Route[routeNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[routeNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_ENDPOINT_MEM_TYPE_NOT_SUPPORT), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));
}
 
TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueErr002)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    ConfigInfo cfgInfo;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    Route routesClient[1];
    routesClient[0].status = RouteStatus::ACTIVE;
    routesClient[0].src.type = EndpointType::QUEUE;
    routesClient[0].src.status = EndpointStatus::AVAILABLE;
    routesClient[0].src.peerNum = 1;
    routesClient[0].src.localId = 11;
    routesClient[0].src.globalId = 1;
    routesClient[0].src.modelId = 1;
    routesClient[0].src.attr.memQueueAttr.queueId = 121;
    routesClient[0].src.attr.memQueueAttr.queueType = 0;
 
    routesClient[0].dst.type = EndpointType::QUEUE;
    routesClient[0].dst.status = EndpointStatus::AVAILABLE;
    routesClient[0].dst.peerNum = 1;
    routesClient[0].dst.localId = 103;
    routesClient[0].dst.globalId = 1;
    routesClient[0].dst.modelId = 1;
    routesClient[0].dst.attr.memQueueAttr.queueId = 123;
    routesClient[0].dst.attr.memQueueAttr.queueType = 0;
 
    cfgInfo.cfg.routesCfg.routes = routesClient;
    cfgInfo.cfg.routesCfg.routeNum = 1U;
    const uint32_t routeNum = 1;
    std::unique_ptr<Route[]> myRoutes(new Route[routeNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[routeNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));
}
 
TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueSucc001)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    ConfigInfo cfgInfo;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    Route routesClient[1];
    routesClient[0].status = RouteStatus::ACTIVE;
    routesClient[0].src.type = EndpointType::MEM_QUEUE;
    routesClient[0].src.status = EndpointStatus::AVAILABLE;
    routesClient[0].src.peerNum = 1;
    routesClient[0].src.localId = 11;
    routesClient[0].src.globalId = 1;
    routesClient[0].src.modelId = 1;
    routesClient[0].src.attr.memQueueAttr.queueId = 124;
    routesClient[0].src.attr.memQueueAttr.queueType = 0;
 
    routesClient[0].dst.type = EndpointType::MEM_QUEUE;
    routesClient[0].dst.status = EndpointStatus::AVAILABLE;
    routesClient[0].dst.peerNum = 1;
    routesClient[0].dst.localId = 103;
    routesClient[0].dst.globalId = 1;
    routesClient[0].dst.modelId = 1;
    routesClient[0].dst.attr.memQueueAttr.queueId = 125;
    routesClient[0].dst.attr.memQueueAttr.queueType = 0;
 
    cfgInfo.cfg.routesCfg.routes = routesClient;
    cfgInfo.cfg.routesCfg.routeNum = 1U;
    const uint32_t routeNum = 1;
    std::unique_ptr<Route[]> myRoutes(new Route[routeNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[routeNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));
}
 
TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueSucc002)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    ConfigInfo cfgInfo;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    Route routesClient[1];
    routesClient[0].status = RouteStatus::ACTIVE;
    routesClient[0].src.type = EndpointType::MEM_QUEUE;
    routesClient[0].src.status = EndpointStatus::AVAILABLE;
    routesClient[0].src.peerNum = 1;
    routesClient[0].src.localId = 11;
    routesClient[0].src.globalId = 1;
    routesClient[0].src.modelId = 1;
    routesClient[0].src.attr.memQueueAttr.queueId = 126;
    routesClient[0].src.attr.memQueueAttr.queueType = 0;
 
    routesClient[0].dst.type = EndpointType::GROUP;
    routesClient[0].dst.status = EndpointStatus::AVAILABLE;
    routesClient[0].dst.peerNum = 1;
    routesClient[0].dst.localId = 103;
    routesClient[0].dst.globalId = 1;
    routesClient[0].dst.modelId = 1;
    routesClient[0].dst.attr.groupAttr.groupId = 127;
 
    cfgInfo.cfg.routesCfg.routes = routesClient;
    cfgInfo.cfg.routesCfg.routeNum = 1U;
    const uint32_t routeNum = 1;
    std::unique_ptr<Route[]> myRoutes(new Route[routeNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[routeNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));
}
 
TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueSucc003)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
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
    endpoints[0].attr.channelAttr.handle = 1U;
    endpoints[0].attr.channelAttr.localTagId = groupTagId1;
    endpoints[0].attr.channelAttr.peerTagId = groupTagId1;
    endpoints[0].attr.channelAttr.localRankId = localRankId;
    endpoints[0].attr.channelAttr.peerRankId = peerRankId;
    endpoints[0].attr.channelAttr.localTagDepth = localTagDepth;
    endpoints[0].attr.channelAttr.peerTagDepth = peerTagDepth;
    endpoints[1].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[1].attr.memQueueAttr.queueId = 132;
 
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;
    const uint32_t endpointNum = 2U;
    std::unique_ptr<Route[]> myRoutes(new Route[endpointNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[endpointNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->CalcConfigInfoLen(config, cfgLen, dataList, myRoutes, existing_ptr));
}
 
TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueSucc004)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    // create group
    bqs::Endpoint endpoints[2UL];
    endpoints[0].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[0].attr.memQueueAttr.queueId = 129;
    endpoints[1].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[1].attr.memQueueAttr.queueId = 130;
 
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;
    const uint32_t endpointNum = 2U;
    std::unique_ptr<Route[]> myRoutes(new Route[endpointNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[endpointNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->CalcConfigInfoLen(config, cfgLen, dataList, myRoutes, existing_ptr));
}
 
TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueSucc005)
{
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue((int)BQS_STATUS_OK))
        .then(returnValue((int)BQS_STATUS_OK))
        .then(returnValue((int)1));

    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    // create group
    bqs::Endpoint endpoints[2UL];
    endpoints[0].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[0].attr.memQueueAttr.queueId = 135;
    endpoints[1].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[1].attr.memQueueAttr.queueId = 136;
 
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;
    size_t cfgLen = 0U;
    std::vector<int32_t> cfgRets;
    CfgRetInfo cfgRetInfo = {0};
    uintptr_t cfgRetInfoAddr = reinterpret_cast<uintptr_t>(&cfgRetInfo);
    uintptr_t mbufData = cfgRetInfoAddr - sizeof(ConfigQuery) - cfgLen;
    int32_t cmdRet = 0;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->GetQryGroupRet(config, mbufData, cfgLen, cfgRets, cmdRet));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_INNER_ERROR), dgwClient->GetQryGroupRet(config, mbufData, cfgLen, cfgRets, cmdRet));
}

TEST_F(DgwClientStest, CalcConfigInfoLenMemQueueSucc)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    ConfigInfo cfgInfo;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    Route routesClient[1];
    routesClient[0].status = RouteStatus::ACTIVE;
    routesClient[0].src.type = EndpointType::MEM_QUEUE;
    routesClient[0].src.status = EndpointStatus::AVAILABLE;
    routesClient[0].src.peerNum = 1;
    routesClient[0].src.localId = 104;
    routesClient[0].src.globalId = 1;
    routesClient[0].src.modelId = 1;
    routesClient[0].src.attr.memQueueAttr.queueId = 105;
    routesClient[0].src.attr.memQueueAttr.queueType = 0;
 
    routesClient[0].dst.type = EndpointType::MEM_QUEUE;
    routesClient[0].dst.status = EndpointStatus::AVAILABLE;
    routesClient[0].dst.peerNum = 1;
    routesClient[0].dst.localId = 103;
    routesClient[0].dst.globalId = 1;
    routesClient[0].dst.modelId = 1;
    routesClient[0].dst.attr.memQueueAttr.queueId = 106;
    routesClient[0].dst.attr.memQueueAttr.queueType = 0;
 
    cfgInfo.cfg.routesCfg.routes = routesClient;
    cfgInfo.cfg.routesCfg.routeNum = 1U;
    const uint32_t routeNum = 1;
    std::unique_ptr<Route[]> myRoutes(new Route[routeNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[routeNum]);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));
}

TEST_F(DgwClientStest, WaitConfigEffect001)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = false;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_NOT_INIT), dgwClient->WaitConfigEffect(1U));
}

TEST_F(DgwClientStest, WaitConfigEffect002)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(1U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake));

    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->WaitConfigEffect(1U));
}

TEST_F(DgwClientStest, WaitConfigEffect003)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(2U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake1));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_FAILED), dgwClient->WaitConfigEffect(1U));
}

TEST_F(DgwClientStest, WaitConfigEffect004)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(3U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake2));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR), dgwClient->WaitConfigEffect(1U));
}

TEST_F(DgwClientStest, WaitConfigEffect005)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(4U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake3));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_TIMEOUT), dgwClient->WaitConfigEffect(1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv001)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(5U);
    dgwClient->initFlag_ = false;
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_NOT_INIT), dgwClient->WaitConfigEffect(0, 1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv002)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(6U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake));

    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_OK), dgwClient->WaitConfigEffect(0, 1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv003)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(7U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake1));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_FAILED), dgwClient->WaitConfigEffect(0, 1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv004)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(8U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake2));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_DRIVER_ERROR), dgwClient->WaitConfigEffect(0, 1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv005)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(9U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake3));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_TIMEOUT), dgwClient->WaitConfigEffect(0, 1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv006)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(10U);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->WaitConfigEffect(1, 1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv007)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(11U);
    dgwClient->initFlag_ = true;
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake4));
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_NOT_SUPPORT), dgwClient->WaitConfigEffect(0, 1U));
}

TEST_F(DgwClientStest, WaitConfigEffectRsv008)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(12U);
    EXPECT_EQ(static_cast<int32_t>(BQS_STATUS_PARAM_INVALID), dgwClient->WaitConfigEffect(0, -1));
}

drvError_t halQueueDeQueueBuffStub(unsigned int devId, unsigned int qid, struct buff_iovec *vector, int timeout)
{
    void *dataPtr = vector->ptr[0U].iovec_base;
    uint64_t dataLen = vector->ptr[0U].len;
    std::cout << "memset dataLen: " << dataLen << std::endl;
    memset(dataPtr, 0, dataLen);
    return DRV_ERROR_NONE;
}

TEST_F(DgwClientStest, CreateHcomHandleOnOtherSide)
{
    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(4U);
    dgwClient->initFlag_ = true;
    dgwClient->isProxy_ = true;
    std::string rankTable = "This is my rank table.";
    uint64_t handle = 0LU;

    MOCKER(halQueueEnQueueBuff)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halEschedSubmitEventSync)
        .stubs()
        .will(invoke(halEschedSubmitEventSyncFake));
    uint64_t respLen = sizeof(HcomHandleInfo) + rankTable.length() + sizeof(CfgRetInfo);
    MOCKER(halQueuePeek)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&respLen), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halQueueDeQueueBuff)
        .stubs()
        .will(invoke(halQueueDeQueueBuffStub));
    EXPECT_EQ(BQS_STATUS_OK,
        dgwClient->CreateHcomHandle(rankTable, 0, nullptr, handle));
}

TEST_F(DgwClientStest, UpdateConfig_01)
{
    MOCKER(&DgwClient::CalcConfigInfoLen)
        .stubs()
        .will(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_PARAM_INVALID)))
        .then(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_OK)));
    MOCKER(&DgwClient::CalcResultLen)
        .stubs()
        .will(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_PARAM_INVALID)));
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
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret);
    int32_t ret1 = dgwClient->UpdateConfig(config, cfgRets);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret1);
}

TEST_F(DgwClientStest, OperateToServerOnSameSide_Fail)
{
    Mbuf *pmbuf = (Mbuf *)&buffer_;
    MOCKER(halMbufAlloc)
        .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&pmbuf))
        .will(returnValue(300))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)));
    int32_t buf = 1;
    int32_t *pmbuf1 = &buf;
    MOCKER(halQueueDeQueue)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf1))
        .will(returnValue(static_cast<int>(DRV_ERROR_RESERVED)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)));
    ConfigQuery query1;
    ConfigQuery *pmbuf2 = &query1;
    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP((void **)&pmbuf2))
        .will(returnValue(static_cast<int>(DRV_ERROR_RESERVED)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)));
    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue(static_cast<int>(DRV_ERROR_RESERVED)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)));

    MOCKER(halQueueEnQueue)
        .stubs()
        .will(returnValue(static_cast<int>(DRV_ERROR_RESERVED)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)));

    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;
    // query group num
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = 0;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    const size_t qryLen = sizeof(ConfigQuery);
    dataList.emplace_back(std::make_pair(PtrToValue(&query), sizeof(ConfigQuery)));
    constexpr size_t retLen = sizeof(CfgRetInfo);

    std::list<std::pair<uintptr_t, size_t>> dataList2;
    dataList2.emplace_back(std::make_pair(PtrToValue(&query), 3 * sizeof(ConfigQuery)));

    // operate config to server
    ConfigInfo unusedParam;
    const DgwClient::ConfigParams cfgParams = {
        .info = nullptr,
        .query = &query,
        .cfgInfo = &unusedParam,
        .cfgLen = 0UL,
        .totalLen = qryLen + retLen,
    };
    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->OperateToServerOnSameSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret);
    std::list<std::pair<uintptr_t, size_t>> dataList1;
    int32_t ret1 = dgwClient->OperateToServerOnSameSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList1, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret1);
    int32_t ret2 = dgwClient->OperateToServerOnSameSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret2);
    int32_t ret3 = dgwClient->OperateToServerOnSameSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret3);
    int32_t ret4 = dgwClient->OperateToServerOnSameSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret4);
    int32_t ret5 = dgwClient->OperateToServerOnSameSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList2, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret5);
}

TEST_F(DgwClientStest, OperateToServerOnOtherSide_Fail)
{
    MOCKER(memcpy_s)
            .stubs()
            .will(returnValue(-1))
            .then(returnValue((int)BQS_STATUS_OK))
            .then(returnValue((int)BQS_STATUS_OK))
            .then(returnValue((int)BQS_STATUS_OK))
            .then(returnValue((int)BQS_STATUS_OK));
    Mbuf *pmbuf = (Mbuf *)&buffer_;
    MOCKER(halQueueEnQueueBuff)
        .stubs()
        .will(returnValue(300))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)))
        .then(returnValue(static_cast<int>(DRV_ERROR_NONE)));

    MOCKER(&DgwClient::InformServer)
        .stubs()
        .will(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_PARAM_INVALID)))
        .then(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_OK)))
        .then(returnValue(static_cast<int32_t>(bqs::BQS_STATUS_OK)));
    int32_t buf = 1;
    int32_t *pmbuf1 = &buf;
    MOCKER(halQueuePeek)
        .stubs()
        .will(returnValue(static_cast<int>(DRV_ERROR_RESERVED)));

    std::shared_ptr<bqs::DgwClient> dgwClient = bqs::DgwClient::GetInstance(0U);
    dgwClient->initFlag_ = true;
    dgwClient->isServerOldVersion_ = false;
    // query group num
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_GROUP;
    query.qry.groupQry.groupId = 0;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    const size_t qryLen = sizeof(ConfigQuery);
    dataList.emplace_back(std::make_pair(PtrToValue(&query), sizeof(ConfigQuery)));
    constexpr size_t retLen = sizeof(CfgRetInfo);

    // operate config to server
    ConfigInfo unusedParam;
    const DgwClient::ConfigParams cfgParams = {
        .info = nullptr,
        .query = &query,
        .cfgInfo = &unusedParam,
        .cfgLen = 0UL,
        .totalLen = qryLen + retLen,
    };
    std::vector<int32_t> cfgRets;
    int32_t ret = dgwClient->OperateToServerOnOtherSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_INNER_ERROR, ret);
    int32_t ret1 = dgwClient->OperateToServerOnOtherSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret1);
    int32_t ret2 = dgwClient->OperateToServerOnOtherSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_PARAM_INVALID, ret2);
    int32_t ret3 = dgwClient->OperateToServerOnOtherSide(QueueSubEventType::QUERY_CONFIG_NUM, cfgParams, dataList, cfgRets, -1);
    EXPECT_EQ(bqs::BQS_STATUS_DRIVER_ERROR, ret3);
}

TEST_F(DgwClientStest, GetQryRouteRet_Fail)
{
    MOCKER(memcpy_s)
            .stubs()
            .will(returnValue(-1));

    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U);
    dgwClient->isServerOldVersion_ = true;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    // create group
    bqs::Endpoint endpoints[2UL];
    endpoints[0].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[0].attr.memQueueAttr.queueId = 135;
    endpoints[1].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[1].attr.memQueueAttr.queueId = 136;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;
    size_t cfgLen = 0U;
    std::vector<int32_t> cfgRets;
    CfgRetInfo cfgRetInfo = {0};
    uintptr_t cfgRetInfoAddr = reinterpret_cast<uintptr_t>(&cfgRetInfo);
    uintptr_t mbufData = cfgRetInfoAddr - sizeof(ConfigQuery) - cfgLen;
    int32_t cmdRet = 0;
    int32_t ret = dgwClient->GetQryRouteRet(config, mbufData, cfgLen, cfgRets, cmdRet);
    EXPECT_EQ(bqs::BQS_STATUS_INNER_ERROR, ret);
}

TEST_F(DgwClientStest, TestChangeUserDeviceIdToLogicDeviceIdSuccess001)
{
    char_t *env = "7,6,5,4";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    uint32_t userDevId = 1;
    uint32_t logicDevId;
    auto ret = DgwClient::ChangeUserDeviceIdToLogicDeviceId(userDevId, logicDevId);
    EXPECT_EQ(logicDevId, 6U);
    
    userDevId = 4;
    ret = DgwClient::ChangeUserDeviceIdToLogicDeviceId(userDevId, logicDevId);
    EXPECT_EQ(ret, 1);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices01)
{
    char_t *env = "";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, false);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices02)
{
    char_t *env = nullptr;
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, false);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices03)
{
    char_t *env = "4,5a,&6,7!";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices04)
{
    char_t *env = ",4,5a,&6,7!";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices05)
{
    char_t *env = "4,5,";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices06)
{
    char_t *env = "4,5,5,7";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices07)
{
    char_t *env = "4,5,6,7,8";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices08)
{
    char_t *env = "4,5,6,7";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices09)
{
    char_t *env = "4,5,2147483648,7";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(invoke(fake_drvGetDevNum));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetVisibleDevices10)
{
    char_t *env = "4,5,6,7";
    MOCKER(getenv).stubs().will(returnValue(env));
    MOCKER(drvGetDevNum).stubs().will(returnValue(1));
    auto ret = DgwClient::GetVisibleDevices();
    EXPECT_EQ(ret, true);
}
 
TEST_F(DgwClientStest, TestGetPlatformInfo1)
{
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_NONE));
    auto ret = DgwClient::GetPlatformInfo(0U);
    EXPECT_EQ(ret, 0);
}
 
TEST_F(DgwClientStest, TestGetPlatformInfo2)
{
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(1));
    auto ret = DgwClient::GetPlatformInfo(0U);
    EXPECT_EQ(ret, 11);
}
 
TEST_F(DgwClientStest, IsSupportSetVisibleDevices1)
{
    auto ret = QSFeatureCtrl::IsSupportSetVisibleDevices(0);
    EXPECT_EQ(ret, false);
}
 
TEST_F(DgwClientStest, GetInstanceFailed)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&QSFeatureCtrl::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&DgwClient::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(1));
    MOCKER_CPP(&DgwClient::GetPlatformInfo).stubs().will(returnValue(0));
    EXPECT_EQ(nullptr, DgwClient::GetInstance(106, 1234, true));
}

TEST_F(DgwClientStest, IsSupportSetVisibleDevices2)
{
    auto supRet = QSFeatureCtrl::IsSupportSetVisibleDevices(1);
    EXPECT_EQ(supRet, true);
}

TEST_F(DgwClientStest, ProcessEndpointDeviceId01)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&QSFeatureCtrl::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    bqs::Endpoint endpoints = {};
    endpoints.resId = 1U;
    auto instance = DgwClient::GetInstance(0U, 123, true);
    auto ret = instance->ProcessEndpointDeviceId(endpoints);
    EXPECT_EQ(ret, 0);

    MOCKER_CPP(&DgwClient::ChangeUserDeviceIdToLogicDeviceId).stubs().will(returnValue(1));
    ret = instance->ProcessEndpointDeviceId(endpoints);
    EXPECT_EQ(ret, 1);
}

TEST_F(DgwClientStest, CalcConfigInfoLenIsSupportSetVisibleDevices01)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&QSFeatureCtrl::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&DgwClient::ProcessEndpointDeviceId).stubs().will(returnValue(1));

    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U, 123, true);
    dgwClient->isServerOldVersion_ = true;
    ConfigInfo cfgInfo;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    cfgInfo.cmd = ConfigCmd::DGW_CFG_CMD_BIND_ROUTE;
    Route routesClient[1];
    routesClient[0].status = RouteStatus::ACTIVE;
    routesClient[0].src.type = EndpointType::MEM_QUEUE;
    routesClient[0].src.status = EndpointStatus::AVAILABLE;
    routesClient[0].src.peerNum = 1;
    routesClient[0].src.localId = 104;
    routesClient[0].src.globalId = 1;
    routesClient[0].src.modelId = 1;
    routesClient[0].src.attr.memQueueAttr.queueId = 105;
    routesClient[0].src.attr.memQueueAttr.queueType = 0;

    routesClient[0].dst.type = EndpointType::MEM_QUEUE;
    routesClient[0].dst.status = EndpointStatus::AVAILABLE;
    routesClient[0].dst.peerNum = 1;
    routesClient[0].dst.localId = 103;
    routesClient[0].dst.globalId = 1;
    routesClient[0].dst.modelId = 1;
    routesClient[0].dst.attr.memQueueAttr.queueId = 106;
    routesClient[0].dst.attr.memQueueAttr.queueType = 0;

    cfgInfo.cfg.routesCfg.routes = routesClient;
    cfgInfo.cfg.routesCfg.routeNum = 1U;
    const uint32_t routeNum = 1;
    std::unique_ptr<Route[]> myRoutes(new Route[routeNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[routeNum]);
    EXPECT_EQ(1, dgwClient->CalcConfigInfoLen(cfgInfo, cfgLen, dataList, myRoutes, existing_ptr));
}

TEST_F(DgwClientStest, CalcConfigInfoLenIsSupportSetVisibleDevices02)
{
    GlobalMockObject::verify();
    GlobalMockObject::reset();
    MOCKER_CPP(&QSFeatureCtrl::IsSupportSetVisibleDevices).stubs().will(returnValue(true));
    MOCKER_CPP(&DgwClient::ProcessEndpointDeviceId).stubs().will(returnValue(1));

    std::shared_ptr<DgwClient> dgwClient = DgwClient::GetInstance(0U, 123, true);
    dgwClient->isServerOldVersion_ = true;
    size_t cfgLen = 0U;
    std::list<std::pair<uintptr_t, size_t>> dataList;
    // create group
    bqs::Endpoint endpoints[2UL];
    endpoints[0].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[0].attr.memQueueAttr.queueId = 129;
    endpoints[1].type = bqs::EndpointType::MEM_QUEUE;
    endpoints[1].attr.memQueueAttr.queueId = 130;

    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    config.cfg.groupCfg.endpointNum = 2U;
    config.cfg.groupCfg.endpoints = endpoints;
    const uint32_t endpointNum = 2U;
    std::unique_ptr<Route[]> myRoutes(new Route[endpointNum]);
    std::unique_ptr<Endpoint[]> existing_ptr(new Endpoint[endpointNum]);
    EXPECT_EQ(1, dgwClient->CalcConfigInfoLen(config, cfgLen, dataList, myRoutes, existing_ptr));
}