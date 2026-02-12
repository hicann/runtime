/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <dlfcn.h>
#include <iostream>
#include <cstdint>
#include <climits>
#include "securec.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mockcpp/ChainingMockHelper.h"
#include "driver/ascend_hal.h"

#define private public
#define protected public
#include "common/bqs_util.h"
#include "hccl/hccl_so_manager.h"
#include "bind_relation.h"
#include "subscribe_manager.h"
#include "queue_manager.h"
#include "router_server.h"
#include "bqs_msg.h"
#include "bqs_status.h"
#include "entity_manager.h"
#include "dgw_client.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

class RouterServerUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        MOCKER(HcclInitComm)
        .stubs()
        .will(returnValue(0));

        MOCKER(HcclFinalizeComm)
        .stubs()
        .will(returnValue(0));
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
    static void SetUpTestCase()
    {
        std::cout << "RouterServerUtest SetUpTestCase" << std::endl;
        GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
        Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
    }

    static void TearDownTestCase()
    {
        std::cout << "RouterServerUtest TearDownTestCase" << std::endl;
        Subscribers::GetInstance().subscribeManagers_.clear();
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

namespace {
    constexpr uint32_t queueNum = 3; // 共三组测试数据
    QueueRoute g_queueRoute[queueNum] = {{100, 101, -1, static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE), static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)},
                                         {100, 103, -1, static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE), static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)},
                                         {9000, 9001, -1,  static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE), static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)}};
    // unbind 消息全部构造不合法的queueid保证handle函数异常返回，不会死等信号量notify
    QueueRoute g_queueRouteUnbind[queueNum] = {{9000, 9001, -1, static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE), static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)},
                                               {9002, 9003, -1, static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE), static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)},
                                               {9004, 9005, -1, static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE), static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)}};

    constexpr uint32_t bindQueueNumBySrc = 2; // 100-101 100-103
    QueueRoute g_queueQuerySrc[bindQueueNumBySrc] = {{0, 0, -1}, {0, 0, -1}};

    constexpr uint32_t bindQueueNumByDst = 1; // 100-101
    QueueRoute g_queueQueryDst[bindQueueNumByDst] = {{0, 0, -1}};

    constexpr uint32_t bindQueueNumBySrcDst = 1; // 100-101
    constexpr uint32_t totalQueueNum = queueNum * 2;
    uint32_t g_totalSize1 = sizeof(QueueRoute) * 1 + sizeof(QsRouteHead) + sizeof(QueueRouteQuery);
    uint32_t g_totalSize2 = sizeof(QueueRoute) * 2 + sizeof(QsRouteHead) + sizeof(QueueRouteQuery);
    uint32_t g_totalSize3 = sizeof(QueueRoute) * 3 + sizeof(QsRouteHead);
    QsRouteHead g_routeHead1 = {g_totalSize1, 1};
    QsRouteHead g_routeHead2 = {g_totalSize2, 2};
    QsRouteHead g_routeHead3 = {g_totalSize3, 3};
    QueueRouteQuery g_QsQuery = {0};

    struct MBuffList1 {
        QsRouteHead qsHead;
        QueueRouteQuery qsQuery;
        QueueRoute queueRouterList[1];
    };
    struct MBuffList2 {
        QsRouteHead qsHead;
        QueueRouteQuery qsQuery;

        QueueRoute queueRouterList[2];
    };
    struct MBuffList3 {
        QsRouteHead qsHead;
        QueueRoute queueRouterList[3];
    };
    struct queueInfoBuff {
        QueQueryQuesOfProcInfo qInfo[2];
    };

    // struct MBuffList4 {
    //     union {
    //         CreateHcomInfo hcomInfo;
    //         HcomHandleAndTag handleAndTag;
    //         CreateHcomTagInfo createHcomTagInfo;
    //     };
    // };

    MBuffList1 mbuffList1 = { 0 };
    MBuffList2 mbuffList2 = { 0 };
    MBuffList3 mbuffList3 = { 0 };
     // 0:bind mbuffList3 1:unbind mbuffList3 2:querybysrc mbuffList2
     // 3:querybydst mbuffList1 4:querybySrc&dst mbuffList1 5 querybysrc|dst mbuffList1
    uint8_t g_getBuffChoice = 0;

    bool gCreateQFailFlag = false;
    drvError_t halQueueCreateFake(unsigned int devid, const QueueAttr *queAttr, unsigned int *qid)
    {
        if (gCreateQFailFlag) {
            gCreateQFailFlag = false;
            return DRV_ERROR_NO_DEVICE;
        }
        *qid = 100;
        return DRV_ERROR_NONE;
    }

    drvError_t halEschedWaitEventFake1(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
    {
        event->comm.event_id = EVENT_QS_MSG;
        RouterServer::GetInstance().running_ = false;
        return DRV_ERROR_NONE;
    }

    drvError_t halEschedWaitEventFake2(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
    {
        RouterServer::GetInstance().running_ = false;
        return DRV_ERROR_NONE;
    }

    drvError_t halEschedWaitEventFake3(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
    {
        RouterServer::GetInstance().running_ = false;
        return DRV_ERROR_SCHED_WAIT_TIMEOUT;
    }

    drvError_t halEschedWaitEventFake4(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
    {
        RouterServer::GetInstance().running_ = false;
        return DRV_ERROR_NO_DEVICE;
    }

    drvError_t halEschedWaitEventParamERR(unsigned int devId, unsigned int grpId,
                    unsigned int threadId, int timeout, struct event_info *event)
    {
        RouterServer::GetInstance().running_ = false;
        return DRV_ERROR_PARA_ERROR;
    }

    drvError_t halQueueDeQueueFakeBindUnbind(unsigned int devId, unsigned int qid, void **mbuf)
    {
        *(QueueRoute**)mbuf = &(g_queueRoute[0]);
        return DRV_ERROR_NONE;
    }

    int halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf)
    {
        switch(g_getBuffChoice) {
            case 0: { // bind
                g_routeHead3.subEventId = ACL_BIND_QUEUE;
                g_routeHead3.userData = 2000;
                mbuffList3.qsHead = g_routeHead3;
                for (uint32_t i = 0; i < queueNum; ++i) {
                    mbuffList3.queueRouterList[i] = g_queueRoute[i];
                }
                *(MBuffList3**)buf = &(mbuffList3);
                return 0;
            }
            case 1: { // query by src
                g_routeHead2.subEventId = bqs::AICPU_QUERY_QUEUE;
                g_routeHead2.userData = 2001;
                mbuffList2.qsHead = g_routeHead2;
                g_QsQuery.syncEventHead = 1001; // 处理事件时应该去userData
                g_QsQuery.queryType = BQS_QUERY_TYPE_SRC;
                g_QsQuery.srcId = 100;
                g_QsQuery.srcType = static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE);
                mbuffList2.qsQuery = g_QsQuery;
                for (uint32_t i = 0; i < bindQueueNumBySrc; ++i) {
                    mbuffList2.queueRouterList[i] = g_queueQuerySrc[i];
                }
                *(MBuffList2**)buf = &(mbuffList2);
                return 0;
            }
            case 2: { // query by dst {0, BQS_QUERY_TYPE_DST, 0, 101};
                g_routeHead1.subEventId = bqs::AICPU_QUERY_QUEUE;
                g_routeHead1.userData = 2002;
                g_QsQuery.syncEventHead = 1001; // 处理事件时应该去userData
                g_QsQuery.queryType = BQS_QUERY_TYPE_DST;
                g_QsQuery.dstId = 101;
                g_QsQuery.dstType = static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE);
                mbuffList1.qsQuery = g_QsQuery;
                mbuffList1.qsHead = g_routeHead1;
                for (uint32_t i = 0; i < bindQueueNumByDst; ++i) {
                    mbuffList1.queueRouterList[i] = g_queueQueryDst[i];
                }
                *(MBuffList1**)buf = &(mbuffList1);
                return 0;
            }
            case 3: { // query by src&dst {0, BQS_QUERY_TYPE_SRC_AND_DST, 100, 101}
                g_routeHead1.subEventId = bqs::AICPU_QUERY_QUEUE;
                g_routeHead1.userData = 2003;
                mbuffList1.qsHead = g_routeHead1;
                g_QsQuery.queryType = BQS_QUERY_TYPE_SRC_AND_DST;
                g_QsQuery.dstId = 101;
                g_QsQuery.dstType = static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE);
                g_QsQuery.srcId = 100;
                g_QsQuery.srcType = static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE);
                mbuffList1.qsQuery = g_QsQuery;
                for (uint32_t i = 0; i < bindQueueNumByDst; ++i) {
                    mbuffList1.queueRouterList[i] = g_queueQueryDst[i];
                }
                *(MBuffList1**)buf = &(mbuffList1);
                return 0;
            }
            case 4: { // query by src or dst
                g_routeHead1.subEventId = bqs::AICPU_QUERY_QUEUE;
                g_routeHead1.userData = 2004;
                mbuffList1.qsHead = g_routeHead1;
                g_QsQuery.queryType = BQS_QUERY_TYPE_SRC_OR_DST;
                g_QsQuery.srcId = 0;
                g_QsQuery.srcType = static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE);
                g_QsQuery.dstId = 103;
                g_QsQuery.dstType = static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE);
                mbuffList1.qsQuery = g_QsQuery;
                for (uint32_t i = 0; i < bindQueueNumByDst; ++i) {
                    mbuffList1.queueRouterList[i] = g_queueQueryDst[i];
                }
                *(MBuffList1**)buf = &(mbuffList1);
                return 0;
            }
            case 5: { // unbind
                g_routeHead3.subEventId = AICPU_UNBIND_QUEUE;
                g_routeHead3.userData = 3000;
                mbuffList3.qsHead = g_routeHead3;
                for (uint32_t i = 0; i < queueNum; ++i) {
                    mbuffList3.queueRouterList[i] = g_queueRouteUnbind[i];
                }
                *(MBuffList3**)buf = &(mbuffList3);
                return 0;
            }
            default:
               std::cout<<"Stub Wrong choice"<<endl;
                return 1;
        }
        return 0;
    }

    int halGrpQueryWithOneGroup(GroupQueryCmdType cmd,
                    void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
    {
        GroupQueryOutput *groupQueryOutput = reinterpret_cast<GroupQueryOutput *>(outBuff);
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[0] = 'g';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[1] = '1';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].groupName[2] = '\0';
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.admin = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.read = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.write = 1;
        groupQueryOutput->grpQueryGroupsOfProcInfo[0].attr.alloc = 1;
        *outLen = sizeof(groupQueryOutput->grpQueryGroupsOfProcInfo[0]);
        return 0;
    }

    int32_t addr = 1234;
    void *dlopenStub(const char *filename, int flags)
    {
        return &addr;
    }
    void *dlsymStub(void *const soHandle, const char_t * const funcName)
    {
        return &addr;
    }
    void *dlopenStubNull(const char *filename, int flags)
    {
        return nullptr;
    }
    void *dlsymStubNull(void *const soHandle, const char_t * const funcName)
    {
        return nullptr;
    }
}

TEST_F(RouterServerUtest, ManageQsEventFail_halEschedAttachDevice)
{
    MOCKER(halEschedAttachDevice)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    RouterServer::GetInstance().ManageQsEvent();
    RouterServer::GetInstance().Destroy();
    EXPECT_EQ(RouterServer::GetInstance().manageThreadStatus_, ThreadStatus::INIT_FAIL);
}


TEST_F(RouterServerUtest, ManageQsEventFail00)
{
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(DRV_ERROR_NO_DEVICE));
    RouterServer::GetInstance().ManageQsEvent();
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, ManageQsEventFail01)
{
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halEschedSubscribeEvent)
    .stubs()
    .will(returnValue(DRV_ERROR_NO_DEVICE));
    RouterServer::GetInstance().ManageQsEvent();
    RouterServer::GetInstance().qsRouterQueryPtr_ = nullptr;
    auto ret = RouterServer::GetInstance().ParseGetBindDetailMsg();
    EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, ManageQsEventSucc00)
{
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedSubscribeEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(returnValue(DRV_ERROR_NONE));
    RouterServer::GetInstance().ManageQsEvent();
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, ManageQsEventSucc01)
{
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedSubscribeEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(invoke(halEschedWaitEventFake1));
    MOCKER_CPP(&bqs::GetRunContext)
    .stubs()
    .will(returnValue(bqs::RunContext::DEVICE));
    RouterServer::GetInstance().running_ = true;
    RouterServer::GetInstance().ManageQsEvent();
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, ManageQsEventSucc02)
{
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedSubscribeEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(invoke(halEschedWaitEventFake2));
    RouterServer::GetInstance().running_ = true;
    RouterServer::GetInstance().ManageQsEvent();
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, ManageQsEventSucc03)
{
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedSubscribeEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(invoke(halEschedWaitEventFake3));
    RouterServer::GetInstance().running_ = true;
    RouterServer::GetInstance().ManageQsEvent();
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, ManageQsEventSucc04)
{
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedSubscribeEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(invoke(halEschedWaitEventFake4));
    RouterServer::GetInstance().running_ = true;
    RouterServer::GetInstance().ManageQsEvent();
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, WaitSyncMsgProcSucc00)
{
    MOCKER_CPP(&QueueManager::EnqueueRelationEvent)
    .stubs()
    .will(returnValue(BQS_STATUS_OK));
    MOCKER_CPP(&QueueManager::EnqueueRelationEventExtra)
    .stubs()
    .will(returnValue(BQS_STATUS_PARAM_INVALID));
    RouterServer::GetInstance().numaFlag_ = true;
    auto ret = RouterServer::GetInstance().WaitSyncMsgProc();
    EXPECT_EQ(ret, BQS_STATUS_PARAM_INVALID);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, WaitSyncMsgProcSucc01)
{
    MOCKER_CPP(&QueueManager::EnqueueRelationEvent)
    .stubs()
    .will(returnValue(BQS_STATUS_OK));
    MOCKER_CPP(&QueueManager::EnqueueRelationEventExtra)
    .stubs()
    .will(returnValue(BQS_STATUS_OK));
    RouterServer::GetInstance().numaFlag_ = true;
    RouterServer::GetInstance().done_ = false;
    RouterServer::GetInstance().doneExtra_ = false;
    RouterServer::GetInstance().processing_  = false;
    RouterServer::GetInstance().processingExtra_  = false;
    auto ret = RouterServer::GetInstance().WaitSyncMsgProc();
    EXPECT_EQ(ret, BQS_STATUS_TIMEOUT);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, WaitSyncMsgProcFail00)
{
    MOCKER_CPP(&QueueManager::EnqueueRelationEvent)
    .stubs()
    .will(returnValue(BQS_STATUS_PARAM_INVALID));
    auto ret = RouterServer::GetInstance().WaitSyncMsgProc();
    EXPECT_EQ(ret, BQS_STATUS_PARAM_INVALID);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, HandleMsgIdFailed)
{
    MOCKER_CPP(&RouterServer::ManageQsEvent)
    .stubs()
    .will(ignoreReturnValue());
    event_info event;
    event.comm.event_id = EVENT_QUEUE_ENQUEUE;
    event.comm.subevent_id = bqs::AICPU_BIND_QUEUE_INIT;
    uint32_t msgLen = sizeof(bqs::QsBindInit);
    QsBindInit bindInit = {0, 12345, 0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindInit, msgLen);
    EXPECT_EQ(retMem, EOK);
    InitQsParams params = {};
    params.runMode = bqs::QueueSchedulerRunMode::MULTI_PROCESS;
    RouterServer::GetInstance().manageThreadStatus_ = ThreadStatus::INIT_SUCCESS;
    RouterServer::GetInstance().InitRouterServer(params);
    RouterServer::GetInstance().readyToHandleMsg_ = true;
    // 异常1：处理不支持的EVENTID EVENT_QUEUE_ENQUEUE
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(RouterServer::GetInstance().pipelineQueueId_.load(), MAX_QUEUE_ID_NUM);
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::DRIVER_PROCESS_SPLIT;
    // 异常2：处理不支持的SUBEVENTID DRIVER_PROCESS_SPLIT
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(RouterServer::GetInstance().pipelineQueueId_.load(), MAX_QUEUE_ID_NUM);
    // 异常3：线程模式下不处理AICPU事件
    RouterServer::GetInstance().deployMode_ = QueueSchedulerRunMode::MULTI_THREAD;
    event.comm.subevent_id = bqs::AICPU_BIND_QUEUE_INIT;
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(RouterServer::GetInstance().pipelineQueueId_.load(), MAX_QUEUE_ID_NUM);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, HandleBindInitFail)
{
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithOneGroup));
    MOCKER(halQueueCreate)
    .stubs()
    .will(invoke(halQueueCreateFake));
    MOCKER_CPP(&RouterServer::ManageQsEvent)
    .stubs()
    .will(ignoreReturnValue());
    gCreateQFailFlag = true;
    g_getBuffChoice = 0;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_BIND_QUEUE_INIT;
    uint32_t msgLen = sizeof(bqs::QsBindInit);
    QsBindInit bindInit = {0, 12345, 0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindInit, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().deployMode_ = QueueSchedulerRunMode::MULTI_PROCESS;
    RouterServer::GetInstance().attachedFlag_ = true;
    InitQsParams params = {};
    params.runMode = QueueSchedulerRunMode::MULTI_PROCESS;
    RouterServer::GetInstance().manageThreadStatus_ = ThreadStatus::INIT_SUCCESS;
    RouterServer::GetInstance().InitRouterServer(params);
    RouterServer::GetInstance().readyToHandleMsg_ = true;
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(RouterServer::GetInstance().pipelineQueueId_.load(), MAX_QUEUE_ID_NUM);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, HandleBindInitSucc01)
{
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithOneGroup));
    MOCKER(halQueueCreate)
    .stubs()
    .will(invoke(halQueueCreateFake));
    MOCKER_CPP(&RouterServer::ManageQsEvent)
    .stubs()
    .will(ignoreReturnValue());
    g_getBuffChoice = 0;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_BIND_QUEUE_INIT;
    uint32_t msgLen = sizeof(bqs::QsBindInit);
    QsBindInit bindInit = {0, 12345, 0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindInit, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().deployMode_ = QueueSchedulerRunMode::MULTI_PROCESS;
    InitQsParams params = {};
    params.runMode = QueueSchedulerRunMode::MULTI_PROCESS;
    RouterServer::GetInstance().manageThreadStatus_ = ThreadStatus::INIT_SUCCESS;
    RouterServer::GetInstance().InitRouterServer(params);
    RouterServer::GetInstance().readyToHandleMsg_ = true;
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(RouterServer::GetInstance().pipelineQueueId_.load(), 100);
    // bind init可重入
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(RouterServer::GetInstance().pipelineQueueId_.load(), 100);
    RouterServer::GetInstance().pipelineQueueId_ = 8*1024;
    RouterServer::GetInstance().qsInitGroupName_ = "DEFAULT_GROUP";
    RouterServer::GetInstance().attachedFlag_ = false;
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(RouterServer::GetInstance().pipelineQueueId_.load(), 100);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, HandleBindQueueFail01)
{
    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 0;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::ACL_BIND_QUEUE;
    uint32_t msgLen = sizeof(bqs::QueueRouteList);

    QueueRouteList bindMsg = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(mbuffList3.queueRouterList[0].status, BQS_STATUS_QUEUE_AHTU_ERROR);
    EXPECT_EQ(mbuffList3.queueRouterList[1].status, BQS_STATUS_QUEUE_AHTU_ERROR);
    EXPECT_EQ(mbuffList3.queueRouterList[2].status, BQS_STATUS_QUEUE_ID_ERROR);
}

TEST_F(RouterServerUtest, HandleBindQueueFail02)
{
    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 0;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::ACL_BIND_QUEUE;
    uint32_t msgLen = sizeof(bqs::QueueRouteList);

    QueueRouteList bindMsg = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);
    EXPECT_EQ(mbuffList3.queueRouterList[0].status, BQS_STATUS_QUEUE_AHTU_ERROR);
    EXPECT_EQ(mbuffList3.queueRouterList[1].status, BQS_STATUS_QUEUE_AHTU_ERROR);
    EXPECT_EQ(mbuffList3.queueRouterList[2].status, BQS_STATUS_QUEUE_ID_ERROR);
}

TEST_F(RouterServerUtest, HandleProcessBindSucc01)
{
    RouterServer::GetInstance().subEventId_ = ACL_BIND_QUEUE;
    RouterServer::GetInstance().qsRouterHeadPtr_ = &mbuffList3.qsHead;
    RouterServer::GetInstance().qsRouteListPtr_ = &mbuffList3.queueRouterList[0];
    RouterServer::GetInstance().BindMsgProc();
    for (uint32_t i = 0; i < queueNum; ++i) {
        EXPECT_EQ(mbuffList3.queueRouterList[i].status, 0U);
        // status置为BQS_STATUS_OK后可以实际执行bindqueue操作
        mbuffList3.queueRouterList[i].status = BQS_STATUS_OK;
    }
    RouterServer::GetInstance().BindMsgProc();
    for (uint32_t i = 0; i < queueNum; ++i) {
        EXPECT_EQ(mbuffList3.queueRouterList[i].status, 1U);
        mbuffList3.queueRouterList[i].status = -1;
    }
}

TEST_F(RouterServerUtest, HandleQueryBySrcSucc01)
{
    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 1;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_QUERY_QUEUE_NUM;
    uint32_t msgLen = sizeof(bqs::QueueRouteQuery);
    QueueRouteQuery queryMsg = {0, BQS_QUERY_TYPE_SRC, 100, 0, static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &queryMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);
    event.comm.subevent_id = AICPU_QUEUE_RELATION_PROCESS;
    RouterServer::GetInstance().srcVersion_ = 1U;
    MOCKER(halQueueEnQueue)
        .stubs()
        .will(returnValue(1));
    RouterServer::GetInstance().HandleBqsMsg(event);

    for (uint32_t i = 0; i < bindQueueNumBySrc; ++i) {
        EXPECT_EQ(mbuffList2.queueRouterList[i].srcId, 100);
        EXPECT_NE(mbuffList2.queueRouterList[i].dstId, -1);
        EXPECT_EQ(mbuffList2.queueRouterList[i].status, 1U);
    }
}

TEST_F(RouterServerUtest, HandleQueryByDstSucc01)
{
    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 2;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_QUERY_QUEUE_NUM;
    uint32_t msgLen = sizeof(bqs::QueueRouteQuery);
    QueueRouteQuery queryMsg = {0, BQS_QUERY_TYPE_DST, 0, 101,
                                static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE),
                                static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &queryMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);
    event.comm.subevent_id = bqs::AICPU_QUEUE_RELATION_PROCESS;
    RouterServer::GetInstance().HandleBqsMsg(event);
    for (uint32_t i = 0; i < bindQueueNumByDst; ++i) {
        EXPECT_EQ(mbuffList1.queueRouterList[i].srcId, 100);
        EXPECT_EQ(mbuffList1.queueRouterList[i].dstId, 101);
        EXPECT_EQ(mbuffList1.queueRouterList[i].status, 1U);
    }
}

TEST_F(RouterServerUtest, HandleQueryBySrcAndDstSucc01)
{
    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 3;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_QUERY_QUEUE_NUM;
    uint32_t msgLen = sizeof(bqs::QueueRouteQuery);
    QueueRouteQuery queryMsg = {0, BQS_QUERY_TYPE_SRC_AND_DST, 100, 101,
                                static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE),
                                static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &queryMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);
    event.comm.subevent_id = bqs::AICPU_QUEUE_RELATION_PROCESS;
    RouterServer::GetInstance().HandleBqsMsg(event);
    for (uint32_t i = 0; i < bindQueueNumByDst; ++i) {
        EXPECT_EQ(mbuffList1.queueRouterList[i].srcId, 100);
        EXPECT_EQ(mbuffList1.queueRouterList[i].dstId, 101);
        EXPECT_EQ(mbuffList1.queueRouterList[i].status, 1U);
    }
}

TEST_F(RouterServerUtest, HandleQueryBySrcOrDstSucc01)
{
    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 4;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_QUERY_QUEUE_NUM;
    uint32_t msgLen = sizeof(bqs::QueueRouteQuery);
    QueueRouteQuery queryMsg = {0, BQS_QUERY_TYPE_SRC_OR_DST, 0, 103,
                                static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE),
                                static_cast<uint16_t>(dgw::EntityType::ENTITY_QUEUE)};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &queryMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);
    event.comm.subevent_id = bqs::AICPU_QUEUE_RELATION_PROCESS;
    RouterServer::GetInstance().HandleBqsMsg(event);
    for (uint32_t i = 0; i < bindQueueNumByDst; ++i) {
        EXPECT_EQ(mbuffList1.queueRouterList[i].srcId, 100);
        EXPECT_EQ(mbuffList1.queueRouterList[i].dstId, 103);
        EXPECT_EQ(mbuffList1.queueRouterList[i].status, 1U);
    }
}

TEST_F(RouterServerUtest, HandleUnbindQueueFail01)
{
    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 5;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_QUEUE_RELATION_PROCESS;
    uint32_t msgLen = sizeof(bqs::QueueRouteList);
    QueueRouteList bindMsg = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);
    for (uint32_t i = 0; i < queueNum; ++i) {
        EXPECT_EQ(mbuffList3.queueRouterList[i].status, BQS_STATUS_QUEUE_ID_ERROR);
        mbuffList3.queueRouterList[i].status = -1;
    }
}

TEST_F(RouterServerUtest, HandleProcessUnBindSucc01)
{
    RouterServer::GetInstance().subEventId_ = AICPU_UNBIND_QUEUE;
    RouterServer::GetInstance().qsRouterHeadPtr_ = &g_routeHead3;
    RouterServer::GetInstance().qsRouteListPtr_ = &g_queueRoute[0];
    RouterServer::GetInstance().BindMsgProc();
    // 模拟失败场景
    for (uint32_t i = 0; i < queueNum; ++i) {
        EXPECT_EQ(g_queueRoute[i].status, 1U);
        g_queueRoute[i].status = 0U;
    }
    // 模拟成功场景
    RouterServer::GetInstance().BindMsgProc();
    for (uint32_t i = 0; i < queueNum; ++i) {
        EXPECT_EQ(g_queueRoute[i].status, 0U);
        g_queueRoute[i].status = -1;
    }
}

TEST_F(RouterServerUtest, PreProcessEventFail)
{
    g_getBuffChoice = -1;
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_QUEUE_RELATION_PROCESS;
    uint32_t msgLen = sizeof(bqs::QueueRouteList);
    QueueRouteList bindMsg = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindMsg, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().HandleBqsMsg(event);

    MOCKER_CPP(&RouterServer::ParseRelationInfo)
    .stubs()
    .will(returnValue(0));
    RouterServer::GetInstance().subEventId_ = AICPU_QUEUE_RELATION_PROCESS;
    RouterServer::GetInstance().PreProcessEvent(event);

    RouterServer::GetInstance().subEventId_ = AICPU_QUEUE_RELATION_PROCESS;
    g_routeHead2.subEventId = 100;
    RouterServer::GetInstance().qsRouterHeadPtr_ = &g_routeHead2;
    RouterServer::GetInstance().PreProcessEvent(event);

    RouterServer::GetInstance().subEventId_ = bqs::AICPU_BIND_QUEUE;
    RouterServer::GetInstance().PreProcessEvent(event);

    RouterServer::GetInstance().subEventId_ = bqs::QUERY_LINKSTATUS_V2;
    RouterServer::GetInstance().PreProcessEvent(event);

    RouterServer::GetInstance().subEventId_ = BIND_HOSTPID;
    RouterServer::GetInstance().PreProcessEvent(event);
}

TEST_F(RouterServerUtest, AttachInitFailed)
{
    MOCKER(halGrpQuery)
    .stubs()
    .will(invoke(halGrpQueryWithOneGroup));
    MOCKER(halGrpAttach)
    .stubs()
    .will(returnValue(0));
    MOCKER(halBuffInit)
    .stubs()
    .will(returnValue(1));
    RouterServer::GetInstance().qsInitGroupName_.clear();
    EXPECT_EQ(RouterServer::GetInstance().AttachAndInitGroup(), BQS_STATUS_DRIVER_ERROR);
}

TEST_F(RouterServerUtest, HcclSoLoad_fail01)
{
    MOCKER(dlopen)
    .stubs()
    .will(invoke(dlopenStubNull));

    MOCKER(dlsym)
    .stubs()
    .will(invoke(dlsymStub));

    dgw::HcclSoManager::GetInstance()->LoadSo();
    EXPECT_EQ(dgw::HcclSoManager::GetInstance()->funcMap_.empty(), true);
    dgw::HcclSoManager::GetInstance()->UnloadSo();
}

TEST_F(RouterServerUtest, HcclSoLoad_fail02)
{
    MOCKER(dlopen)
    .stubs()
    .will(invoke(dlopenStub));

    MOCKER(dlsym)
    .stubs()
    .will(invoke(dlsymStubNull));

    dgw::HcclSoManager::GetInstance()->LoadSo();
    EXPECT_EQ(dgw::HcclSoManager::GetInstance()->funcMap_.empty(), true);
    dgw::HcclSoManager::GetInstance()->UnloadSo();
}

TEST_F(RouterServerUtest, HcclSoLoad)
{
    MOCKER(dlopen)
    .stubs()
    .will(invoke(dlopenStub));

    MOCKER(dlsym)
    .stubs()
    .will(invoke(dlsymStub));

    dgw::HcclSoManager::GetInstance()->LoadSo();
    void * func = dgw::HcclSoManager::GetInstance()->GetFunc("123");
    EXPECT_EQ(func, nullptr);
}

TEST_F(RouterServerUtest, SubscribeBufEventSuc)
{
    setenv("DGW_NEED_HCCL", "1", 1);
    RouterServer::GetInstance().qsInitGroupName_ = "qsInitGroupName";
    RouterServer::GetInstance().schedPolicy_ = 2;
    MOCKER(halBufEventSubscribe).stubs().will(returnValue(DRV_ERROR_NO_DEVICE)).then(returnValue(DRV_ERROR_NONE));
    EXPECT_EQ(RouterServer::GetInstance().SubscribeBufEvent(), BQS_STATUS_OK);
}

int halMbufFreeStub(Mbuf *mbuf)
{
    return 1;
}

TEST_F(RouterServerUtest, GetAllAbnormalBind)
{
    auto &bindRelation = BindRelation::GetInstance();
    const auto &srcEntity = EntityInfo(200U, 0U);
    const auto &dstEntity = EntityInfo(201U, 0U);
    bindRelation.abnormalSrcToDst_.clear();
    bindRelation.abnormalDstToSrc_.clear();

    bindRelation.abnormalSrcToDst_[srcEntity].emplace(dstEntity);

    auto &routerServer = RouterServer::GetInstance();
    routerServer.GetAllAbnormalBind();
    EXPECT_EQ(routerServer.queueRouteQueryList_.size(), 1U);
    const auto &route = routerServer.queueRouteQueryList_[0];
    EXPECT_EQ(route.srcId, 200U);
    EXPECT_EQ(route.dstId, 201U);
    EXPECT_EQ(route.status, 2);

    bindRelation.abnormalSrcToDst_.erase(srcEntity);
    bindRelation.abnormalDstToSrc_.erase(dstEntity);
    routerServer.queueRouteQueryList_.clear();
}

TEST_F(RouterServerUtest, GetBindRspBySingle)
{
    auto &bindRelation = BindRelation::GetInstance();
    const auto &srcEntity = EntityInfo(200U, 0U);
    const auto &dstEntity = EntityInfo(201U, 0U);
    const auto &normalDstEntity = EntityInfo(202U, 0U);
    const auto &normalSrcEntity = EntityInfo(203U, 0U);
    const auto &normalDstEntityExtra = EntityInfo(204U, 0U);
    const auto &normalSrcEntityExtra = EntityInfo(205U, 0U);

    bindRelation.srcToDstRelation_[srcEntity].emplace(normalDstEntity);
    bindRelation.dstToSrcRelation_[normalDstEntity].emplace(srcEntity);

    bindRelation.abnormalSrcToDst_[srcEntity].emplace(dstEntity);
    bindRelation.abnormalDstToSrc_[dstEntity].emplace(srcEntity);

    bindRelation.srcToDstRelation_[normalSrcEntity].emplace(dstEntity);
    bindRelation.dstToSrcRelation_[dstEntity].emplace(normalSrcEntity);

    bindRelation.srcToDstRelationExtra_[normalSrcEntityExtra].emplace(normalDstEntityExtra);
    bindRelation.dstToSrcRelationExtra_[normalDstEntityExtra].emplace(normalSrcEntityExtra);


    auto &routerServer = RouterServer::GetInstance();
    routerServer.numaFlag_ = true;

    // invalid query type
    routerServer.GetBindRspBySingle(srcEntity, 2U);

    routerServer.GetBindRspBySingle(srcEntity, 0U);
    EXPECT_EQ(routerServer.queueRouteQueryList_.size(), 2U);
    uint32_t hit = 0U;
    for (const auto &route: routerServer.queueRouteQueryList_) {
        if (route.dstId == 201U) {
            EXPECT_EQ(route.status, 2);
            ++hit;
        } else if (route.dstId == 202U) {
            EXPECT_EQ(route.status, 1);
            ++hit;
        }
    }
    EXPECT_EQ(hit, 2U);

    routerServer.GetBindRspBySingle(dstEntity, 1U);
    EXPECT_EQ(routerServer.queueRouteQueryList_.size(), 2U);
    hit = 0U;
    for (const auto &route: routerServer.queueRouteQueryList_) {
        if (route.srcId == 200U) {
            EXPECT_EQ(route.status, 2);
            ++hit;
        } else if (route.srcId == 203U) {
            EXPECT_EQ(route.status, 1);
            ++hit;
        }
    }
    EXPECT_EQ(hit, 2U);

    routerServer.GetBindRspBySingle(normalDstEntityExtra, 1U);
    EXPECT_EQ(routerServer.queueRouteQueryList_.size(), 1U);
    routerServer.GetBindRspBySingle(normalSrcEntityExtra, 0U);
    EXPECT_EQ(routerServer.queueRouteQueryList_.size(), 1U);

    bindRelation.srcToDstRelation_.clear();
    bindRelation.dstToSrcRelation_.clear();
    bindRelation.abnormalSrcToDst_.clear();
    bindRelation.abnormalDstToSrc_.clear();

    bindRelation.srcToDstRelationExtra_.clear();
    bindRelation.dstToSrcRelationExtra_.clear();

    routerServer.queueRouteQueryList_.clear();
    routerServer.numaFlag_ = false;
}

TEST_F(RouterServerUtest, GetBindRspByDouble)
{
    auto &bindRelation = BindRelation::GetInstance();
    const auto &srcEntity = EntityInfo(200U, 0U);
    const auto &dstEntity = EntityInfo(201U, 0U);
    bindRelation.abnormalSrcToDst_[srcEntity].emplace(dstEntity);

    auto &routerServer = RouterServer::GetInstance();
    routerServer.numaFlag_ = true;
    routerServer.GetBindRspByDouble(srcEntity, dstEntity, 2U);
    EXPECT_EQ(routerServer.queueRouteQueryList_.size(), 1U);
    const auto &route = routerServer.queueRouteQueryList_[0];
    EXPECT_EQ(route.srcId, 200U);
    EXPECT_EQ(route.dstId, 201U);
    EXPECT_EQ(route.status, 2);

    bindRelation.abnormalSrcToDst_.erase(srcEntity);
    bindRelation.abnormalDstToSrc_.erase(dstEntity);
    routerServer.queueRouteQueryList_.clear();
    routerServer.numaFlag_ = false;
}

TEST_F(RouterServerUtest, ProcessConfigEvent_DequeFail)
{
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(returnValue(1));
    RouterServer::GetInstance().srcVersion_ = 1U;
    RouterServer::GetInstance().ProcessConfigEvent(QsOperType::CREATE_HCOM_HANDLE);
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
}

TEST_F(RouterServerUtest, ProcessConfigEvent_EnqueFail)
{
    MOCKER(halQueueDeQueue)
        .stubs()
        .will(invoke(halQueueDeQueueFakeBindUnbind));
    MOCKER(halQueueEnQueue)
        .stubs()
        .will(returnValue(1));
    MOCKER_CPP(&ConfigInfoOperator::ParseConfigEvent)
        .stubs()
        .will(returnValue(BQS_STATUS_OK));
    RouterServer::GetInstance().srcVersion_ = 1U;
    RouterServer::GetInstance().ProcessConfigEvent(QsOperType::CREATE_HCOM_HANDLE);
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
}

TEST_F(RouterServerUtest, CreateHcomHandleUT_Fail_CfgLenOverflow)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    HcomHandleInfo cusValue;
    HcomHandleInfo * info = &cusValue;
    info->rankTableLen = UINT_MAX;
    uintptr_t mbufData = reinterpret_cast<uintptr_t>(&cusValue);
    uint64_t dataLen = 1U;
    EXPECT_EQ(cfgInfoOperator_->CreateHcomHandle(mbufData, dataLen), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest, DestroyHcomHandle_Fail_Overflow)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));

    HcomHandleInfo info = {};
    info.rankTableLen = UINT64_MAX;
    uint64_t dataLen = sizeof(HcomHandleInfo) + sizeof(CfgRetInfo);
    std::cout << "dataLen is " << dataLen << std::endl;

    EXPECT_EQ(
        cfgInfoOperator_->DestroyHcomHandle(reinterpret_cast<uintptr_t>(&info), dataLen), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest, ParseConfigEvent_Fail01)
{
    MOCKER(halMbufGetBuffAddr)
        .stubs()
        .will(returnValue(1));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    uint32_t subEventId = 0U;
    uint32_t queueId = 0U;
    void *mbuf = nullptr;
    uint16_t clientVersion = 0U;
    EXPECT_EQ(cfgInfoOperator_->ParseConfigEvent(subEventId, queueId, mbuf, clientVersion), BQS_STATUS_DRIVER_ERROR);
}

TEST_F(RouterServerUtest, ParseConfigEvent_Fail02)
{
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    MOCKER(halMbufGetDataLen)
        .stubs()
        .will(returnValue(1));
    g_getBuffChoice = 1;
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    uint32_t subEventId = 0U;
    uint32_t queueId = 0U;
    void *mbuf = nullptr;
    uint16_t clientVersion = 0U;
    EXPECT_EQ(cfgInfoOperator_->ParseConfigEvent(subEventId, queueId, mbuf, clientVersion), BQS_STATUS_DRIVER_ERROR);
}

TEST_F(RouterServerUtest, ParseConfigEvent_default)
{
    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));
    g_getBuffChoice = 1;
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    uint32_t subEventId = 100;
    uint32_t queueId = 0U;
    void *mbuf = nullptr;
    uint16_t clientVersion = 0U;
    EXPECT_EQ(cfgInfoOperator_->ParseConfigEvent(subEventId, queueId, mbuf, clientVersion), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,QueryGroup_fail)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    uintptr_t mbufData = 0U;
    uint64_t datalen = sizeof(ConfigQuery) - 1;
    bool onlyQryNum = false;
    EXPECT_EQ(cfgInfoOperator_->QueryGroup(mbufData, datalen, onlyQryNum), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,ConvertToEndpoint_default)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_INVALID;
    EntityInfo entity(1U, 0U, &args);
    bqs::Endpoint endpoint;
    EXPECT_EQ(cfgInfoOperator_->ConvertToEndpoint(entity, endpoint), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,CreateEntityInfo_default)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::Endpoint endpoint;
    endpoint.type = static_cast<EndpointType>(5);
    bool isQry = false;
    EXPECT_EQ(cfgInfoOperator_->CreateEntityInfo(endpoint, isQry), nullptr);
}

TEST_F(RouterServerUtest,CreateEntityInfo_MEM_QUEUE)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::Endpoint endpoint;
    endpoint.type = bqs::EndpointType::MEM_QUEUE;
    bool isQry = false;
    EXPECT_NE(cfgInfoOperator_->CreateEntityInfo(endpoint, isQry), nullptr);
}

TEST_F(RouterServerUtest,AttachQueue_default)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_INVALID;
    EntityInfo entity(1U, 0U, &args);
    EXPECT_EQ(cfgInfoOperator_->AttachQueue(entity), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,QueryRoutes_default)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_RESERVED;
    query.qry.groupQry.groupId = 0;
    uintptr_t cfgRetInfoAddr = reinterpret_cast<uintptr_t>(&query);
    uintptr_t mbufData = cfgRetInfoAddr;
    uint64_t datalen = sizeof(ConfigQuery) + sizeof(CfgRetInfo);
    EXPECT_EQ(cfgInfoOperator_->QueryRoutes(mbufData, datalen, true), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,QueryRoutes_error)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_RESERVED;
    query.qry.groupQry.groupId = 0;
    uintptr_t cfgRetInfoAddr = reinterpret_cast<uintptr_t>(&query);
    uintptr_t mbufData = cfgRetInfoAddr;
    uint64_t datalen = sizeof(ConfigQuery) + sizeof(CfgRetInfo) - 1;
    EXPECT_EQ(cfgInfoOperator_->QueryRoutes(mbufData, datalen, true), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,QueryGroup_error)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_RESERVED;
    query.qry.groupQry.groupId = 0;
    uintptr_t cfgRetInfoAddr = reinterpret_cast<uintptr_t>(&query);
    uintptr_t mbufData = cfgRetInfoAddr;
    uint64_t datalen = sizeof(ConfigQuery) + sizeof(CfgRetInfo) - 1;
    EXPECT_EQ(cfgInfoOperator_->QueryGroup(mbufData, datalen, true), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,SaveQueryResult_error)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    ConfigQuery query;
    query.mode = QueryMode::DGW_QUERY_MODE_RESERVED;
    query.qry.groupQry.groupId = 0;
    query.qry.routeQry.routeNum = 1;
    uintptr_t mbufData = reinterpret_cast<uintptr_t>(&query);
    std::list<std::pair<const EntityInfo *, const EntityInfo *>> routeList;
    EXPECT_EQ(cfgInfoOperator_->SaveQueryResult(routeList, mbufData, false), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,AttachQueue_error)
{
    MOCKER(halQueueAttach).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    EntityInfo entity(1U, 0U);
    EXPECT_EQ(cfgInfoOperator_->AttachQueue(entity), BQS_STATUS_DRIVER_ERROR);
}

TEST_F(RouterServerUtest,AttachAndCheckQueue_error)
{
    MOCKER(halQueueAttach).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    EntityInfo srcEntity(1U, 0U);
    EntityInfo dstEntity(1U, 0U);
    EXPECT_EQ(cfgInfoOperator_->AttachAndCheckQueue(srcEntity, dstEntity), BQS_STATUS_DRIVER_ERROR);
}

TEST_F(RouterServerUtest,AttachQueueInGroup_error)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    const uint32_t groupId = 0;
    EXPECT_EQ(cfgInfoOperator_->AttachQueueInGroup(groupId), BQS_STATUS_GROUP_NOT_EXIST);
}

TEST_F(RouterServerUtest,CheckAndRecordUpdateCfgInfo_error)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_ = nullptr;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    const uintptr_t mbufData = 0U;
    EXPECT_EQ(cfgInfoOperator_->CheckAndRecordUpdateCfgInfo(mbufData, 0), BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,SplitStringWithDelimeter_error)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    std::vector<std::string> results;
    cfgInfoOperator_->SplitStringWithDelimeter("",',',results);
    EXPECT_EQ(results.size(), 0);
}

TEST_F(RouterServerUtest,ProcessUpdateConfig_error)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_ADD_GROUP;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    auto ret = cfgInfoOperator_->ProcessUpdateConfig(1);
    EXPECT_EQ(ret, BQS_STATUS_OK);
}

TEST_F(RouterServerUtest,ProcessUpdateConfig_default)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    auto ret = cfgInfoOperator_->ProcessUpdateConfig(0);
    EXPECT_EQ(ret, BQS_STATUS_PARAM_INVALID);
}

TEST_F(RouterServerUtest,QueryGroupAllocInfo_queryinfo_empty)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    GrpQueryGroupAddrInfo queryResults;
    cfgInfoOperator_->grpAllocInfos_.push_back(queryResults);
    cfgInfoOperator_->groupNames_ = "grp1, grp2";
    EXPECT_EQ(cfgInfoOperator_->QueryGroupAllocInfo(), BQS_STATUS_OK);
    cfgInfoOperator_->groupNames_ = "";
    cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(RouterServerUtest,QueryGroupAllocInfo_memcpy_fail)
{
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(EOK + 1));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    cfgInfoOperator_->groupNames_ = "grp1, grp2";
    EXPECT_EQ(cfgInfoOperator_->QueryGroupAllocInfo(), BQS_STATUS_INNER_ERROR);
    cfgInfoOperator_->groupNames_ = "";
}

TEST_F(RouterServerUtest,QueryGroupAllocInfo_halGrpQuery_fail)
{
    MOCKER(halGrpQuery)
        .stubs()
        .will(returnValue(1));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    cfgInfoOperator_->groupNames_ = "grp1, grp2";
    EXPECT_EQ(cfgInfoOperator_->QueryGroupAllocInfo(), BQS_STATUS_DRIVER_ERROR);
    cfgInfoOperator_->groupNames_ = "";
}

TEST_F(RouterServerUtest,QureySelfMemGroup_fail01)
{
    MOCKER(halGrpQuery)
        .stubs()
        .will(returnValue(1));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    std::vector<std::string> groupNames;
    groupNames.push_back("test");
    EXPECT_EQ(cfgInfoOperator_->QureySelfMemGroup(groupNames), BQS_STATUS_DRIVER_ERROR);
    cfgInfoOperator_->groupNames_ = "";
}


TEST_F(RouterServerUtest,QureySelfMemGroup_fail02)
{
    GrpQueryGroupAddrInfo queryResult = {};
    auto resultSize = sizeof(queryResult);
    MOCKER(halGrpQuery)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
            outBoundP(reinterpret_cast<void*>(&queryResult), sizeof(queryResult)),
            outBoundP(reinterpret_cast<unsigned int*>(&resultSize)))
        .will(returnValue(0));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    std::vector<std::string> groupNames;
    groupNames.push_back("test");
    EXPECT_EQ(cfgInfoOperator_->QureySelfMemGroup(groupNames), BQS_STATUS_DRIVER_ERROR);
    cfgInfoOperator_->groupNames_ = "";
}

TEST_F(RouterServerUtest,QureySelfMemGroup)
{
    GroupQueryOutput queryResult = {};
    auto resultSize = sizeof(queryResult);
    MOCKER(halGrpQuery)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(),
            outBoundP(reinterpret_cast<void*>(&queryResult), sizeof(queryResult)),
            outBoundP(reinterpret_cast<unsigned int*>(&resultSize)))
        .will(returnValue(0));
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    std::vector<std::string> groupNames;
    groupNames.push_back("test");
    EXPECT_EQ(cfgInfoOperator_->QureySelfMemGroup(groupNames), BQS_STATUS_OK);
    cfgInfoOperator_->groupNames_ = "";
}

TEST_F(RouterServerUtest,CheckAndRecordAddGrpInfo_fail01)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    config.cfg.groupCfg.endpointNum = 0;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    GrpQueryGroupAddrInfo queryResults;
    cfgInfoOperator_->grpAllocInfos_.push_back(queryResults);
    cfgInfoOperator_->groupNames_ = "grp1, grp2";
    EXPECT_EQ(cfgInfoOperator_->CheckAndRecordAddGrpInfo(), BQS_STATUS_PARAM_INVALID);
    cfgInfoOperator_->groupNames_ = "";
    cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(RouterServerUtest,CheckAndRecordAddGrpInfo_fail02)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    config.cfg.groupCfg.endpointNum = 1;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    updateCfgInfo->dataLen = 0;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    GrpQueryGroupAddrInfo queryResults;
    cfgInfoOperator_->grpAllocInfos_.push_back(queryResults);
    cfgInfoOperator_->groupNames_ = "grp1, grp2";
    EXPECT_EQ(cfgInfoOperator_->CheckAndRecordAddGrpInfo(), BQS_STATUS_PARAM_INVALID);
    cfgInfoOperator_->groupNames_ = "";
    cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(RouterServerUtest,CheckAndRecordCommonCfg_fail)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    bqs::ConfigInfo config;
    config.cmd = bqs::ConfigCmd::DGW_CFG_CMD_RESERVED;
    config.cfg.groupCfg.endpointNum = 1;
    std::unique_ptr<bqs::ConfigInfoOperator::UpdateCfgInfo> updateCfgInfo = nullptr;
    updateCfgInfo.reset(new (std::nothrow) bqs::ConfigInfoOperator::UpdateCfgInfo());
    // record cfgInfo
    updateCfgInfo->cfgInfo = &config;
    updateCfgInfo->dataLen = 0;
    cfgInfoOperator_->updateCfgInfo_ = std::move(updateCfgInfo);
    GrpQueryGroupAddrInfo queryResults;
    cfgInfoOperator_->grpAllocInfos_.push_back(queryResults);
    cfgInfoOperator_->groupNames_ = "grp1, grp2";
    EXPECT_EQ(cfgInfoOperator_->CheckAndRecordCommonCfg(0), BQS_STATUS_PARAM_INVALID);
    cfgInfoOperator_->groupNames_ = "";
    cfgInfoOperator_->grpAllocInfos_.clear();
}

TEST_F(RouterServerUtest, ProcessQueryLinkStatusEvent)
{
    RouterServer::GetInstance().ProcessQueryLinkStatusEvent();
    EXPECT_EQ(RouterServer::GetInstance().deviceId_, 0U);
}

TEST_F(RouterServerUtest, CheckLinkStatus001)
{
    EXPECT_EQ(dgw::EntityManager::Instance().CheckLinkStatus(), dgw::FsmStatus::FSM_SUCCESS);
}

TEST_F(RouterServerUtest, CheckLinkStatus002)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    dgw::ChannelEntityPtr entity = std::make_shared<dgw::ChannelEntity>(material, 0U);
    entity->linkStatus_ = dgw::ChannelLinkStatus::CONNECTED;
    dgw::EntityManager::Instance().srcCommChannels_.entities.push_back(entity);
    EXPECT_EQ(dgw::EntityManager::Instance().CheckLinkStatus(), dgw::FsmStatus::FSM_SUCCESS);
    dgw::EntityManager::Instance().EraseCommChannel(entity, true);
}

TEST_F(RouterServerUtest, CheckLinkStatus003)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    dgw::ChannelEntityPtr entity = std::make_shared<dgw::ChannelEntity>(material, 0U);
    entity->linkStatus_ = dgw::ChannelLinkStatus::UNCONNECTED;
    dgw::EntityManager::Instance().srcCommChannels_.entities.push_back(entity);
    EXPECT_EQ(dgw::EntityManager::Instance().CheckLinkStatus(), dgw::FsmStatus::FSM_FAILED);
    dgw::EntityManager::Instance().EraseCommChannel(entity, true);
}

TEST_F(RouterServerUtest, CheckLinkStatus004)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    dgw::ChannelEntityPtr entity = std::make_shared<dgw::ChannelEntity>(material, 0U);
    entity->linkStatus_ = dgw::ChannelLinkStatus::CONNECTED;
    dgw::EntityManager::Instance().dstCommChannels_.entities.push_back(entity);
    EXPECT_EQ(dgw::EntityManager::Instance().CheckLinkStatus(), dgw::FsmStatus::FSM_SUCCESS);
    dgw::EntityManager::Instance().EraseCommChannel(entity, false);
}

TEST_F(RouterServerUtest, CheckLinkStatus005)
{
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    dgw::ChannelEntityPtr entity = std::make_shared<dgw::ChannelEntity>(material, 0U);
    entity->linkStatus_ = dgw::ChannelLinkStatus::UNCONNECTED;
    dgw::EntityManager::Instance().dstCommChannels_.entities.push_back(entity);
    EXPECT_EQ(dgw::EntityManager::Instance().CheckLinkStatus(), dgw::FsmStatus::FSM_FAILED);
    dgw::EntityManager::Instance().EraseCommChannel(entity, false);
}

TEST_F(RouterServerUtest, CheckEntityTypeMemQueue)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    auto entiyInfo = bqs::EntityInfo(102U, 0U);
    bqs::Endpoint endpoint[1UL];
    endpoint[0].type = bqs::EndpointType::MEM_QUEUE;
    endpoint[0].attr.memQueueAttr.queueId = 1003;
    EXPECT_EQ(cfgInfoOperator_->ConvertToEndpoint(entiyInfo, endpoint[0]), BQS_STATUS_OK);
    cfgInfoOperator_->CreateEntityInfo(endpoint[0], false);
    entiyInfo.optionalArgs_.queueType = 1; // clientQ
    cfgInfoOperator_->CheckQueueAuth(entiyInfo, true);
}

TEST_F(RouterServerUtest, CheckEntityTypeMemQueueFailed)
{
    std::unique_ptr<ConfigInfoOperator> cfgInfoOperator_;
    cfgInfoOperator_.reset(new (std::nothrow) ConfigInfoOperator(1));
    auto entiyInfo = bqs::EntityInfo(105U, 0U);
    bqs::Endpoint endpoint[1UL];
    endpoint[0].type = bqs::EndpointType::MEM_QUEUE;
    endpoint[0].resId = 0x8001;
    endpoint[0].attr.memQueueAttr.queueId = 1203;
    endpoint[0].attr.memQueueAttr.queueType = 0;
    EXPECT_EQ(cfgInfoOperator_->ConvertToEndpoint(entiyInfo, endpoint[0]), BQS_STATUS_OK);
    MOCKER(drvGetLocalDevIDByHostDevID)
        .stubs()
        .will(returnValue(1));
    MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
    cfgInfoOperator_->CreateEntityInfo(endpoint[0], false);
}

TEST_F(RouterServerUtest, InitRouterServer_FailForManageQsEvent)
{
    InitQsParams params = {};
    params.qsInitGrpName = "Default";
    params.needAttachGroup = true;
    RouterServer::GetInstance().manageThreadStatus_ = ThreadStatus::NOT_INIT;
    MOCKER(&bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::HOST));
    MOCKER(halGrpAttach).stubs().will(returnValue(1));
    EXPECT_EQ(RouterServer::GetInstance().InitRouterServer(params), BQS_STATUS_INNER_ERROR);
    RouterServer::GetInstance().Destroy();
}

TEST_F(RouterServerUtest, HandleBqsMsg_FailForNotReady)
{
    event_info event;
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = bqs::AICPU_BIND_QUEUE_INIT;
    uint32_t msgLen = sizeof(bqs::QsBindInit);
    QsBindInit bindInit = {0, 12345, 0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &bindInit, msgLen);
    EXPECT_EQ(retMem, EOK);
    RouterServer::GetInstance().readyToHandleMsg_ = false;
    RouterServer::GetInstance().HandleBqsMsg(event);
}


TEST_F(RouterServerUtest, ManageQsEventParmERR)
{
    RouterServer curServer;
    MOCKER(halEschedCreateGrp)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedSubscribeEvent)
    .stubs()
    .will(returnValue(0));
    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(invoke(halEschedWaitEventParamERR));
    curServer.running_ = true;
    curServer.ManageQsEvent();
    EXPECT_EQ(curServer.deviceId_, 0U);
    curServer.Destroy();
}