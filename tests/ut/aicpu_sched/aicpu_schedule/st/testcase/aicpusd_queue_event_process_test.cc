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
#define private public
#include "aicpusd_queue_event_process.h"
#include "aicpusd_event_manager.h"
#undef private

#include "aicpusd_status.h"
#include "qs_client.h"
#include "securec.h"

using namespace AicpuSchedule;
using namespace bqs;
using namespace std;

namespace
{
    QueueRoute queueRoute = {1,2,0,0};
    uint32_t mbufSize = 0;
    constexpr uint32_t MAX_BUFF_SIZE = 1024;
    char mbuffData[MAX_BUFF_SIZE] = {0};
    QsRouteHead routeHeadBase = {1000,2,0,0};
    QueueRoute qRouteArray [] = {{1,2,0,0,0,0,0},{3,4,0,0,0,0,0}};
    char routeListMsgbuff[MAX_BUFF_SIZE] = {0};
}

int halMbufAllocStub(unsigned int size, Mbuf **mbuf) {
    *mbuf = reinterpret_cast<Mbuf *>(mbuffData);
    mbufSize = size;
    return 0;
}

int halMbufFreeStub(Mbuf *mbuf) {
    return 0;
}

int halMbufGetBuffAddrStub(Mbuf *mbuf, void **buf) {
    *buf = mbuf;
    return 0;
}

int halMbufGetDataLenStub(Mbuf *mbuf, uint64_t *len) {
    *len = mbufSize;
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

drvError_t halQueueQueryAllQueues(unsigned int devId, QueueQueryCmdType cmd,
                                 QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    QueueQueryOutput *queueInfoList = reinterpret_cast<QueueQueryOutput *>(outPut->outBuff);
    outPut->outLen = sizeof(queueInfoList->queQueryQuesOfProcInfo[0]);
    queueInfoList->queQueryQuesOfProcInfo[0].qid = 1001;
    queueInfoList->queQueryQuesOfProcInfo[0].attr = {1, 1, 1, 0};
    return DRV_ERROR_NONE;
}

drvError_t halQueueQueryOneWithoutQueueAuth(unsigned int devId, QueueQueryCmdType cmd,
                                 QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    QueueQueryOutput *queueInfoList = reinterpret_cast<QueueQueryOutput *>(outPut->outBuff);
    outPut->outLen = sizeof(queueInfoList->queQueryQueueAttrInfo);
    queueInfoList->queQueryQueueAttrInfo.attr = {0, 0, 0, 0};
    return DRV_ERROR_NONE;
}

drvError_t halQueueQueryOneWithQueueAuth(unsigned int devId, QueueQueryCmdType cmd,
                                 QueueQueryInputPara *inPut, QueueQueryOutputPara *outPut)
{
    QueueQueryOutput *queueInfoList = reinterpret_cast<QueueQueryOutput *>(outPut->outBuff);
    outPut->outLen = sizeof(queueInfoList->queQueryQueueAttrInfo);
    queueInfoList->queQueryQueueAttrInfo.attr = {1, 1, 1, 0};
    return DRV_ERROR_NONE;
}

class AicpusdQueueEventProcessTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "AicpusdQueueEventProcessTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "AicpusdQueueEventProcessTest TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        MOCKER(halMbufAlloc)
            .stubs()
            .will(invoke(halMbufAllocStub));
        MOCKER(halMbufFree)
            .stubs()
            .will(invoke(halMbufFreeStub));
        MOCKER(halMbufGetBuffAddr)
            .stubs()
            .will(invoke(halMbufGetBuffAddrStub));
        MOCKER(halMbufGetDataLen)
            .stubs()
            .will(invoke(halMbufGetDataLenStub));
        (void)memcpy_s(routeListMsgbuff, MAX_BUFF_SIZE, &routeHeadBase, sizeof(routeHeadBase));
        (void)memcpy_s(routeListMsgbuff + sizeof(routeHeadBase), MAX_BUFF_SIZE - sizeof(routeHeadBase),
                       &qRouteArray, sizeof(QueueRoute) * 2);
        AicpuQueueEventProcess::GetInstance().callbacks_.clear();
        std::cout << "AicpusdQueueEventProcessTest SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        AicpuQueueEventProcess::GetInstance().callbacks_.clear();
        std::cout << "AicpusdQueueEventProcessTest TearDown" << std::endl;
    }
};

TEST_F(AicpusdQueueEventProcessTest, DriverEventSuccessed_01)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_PEEK_MSG;
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, DriverEventFailed_03)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ENQUEUE_MSG;
    MOCKER(halEventProc)
        .stubs()
        .will(returnValue(1));
    auto ret = AicpuQueueEventProcess::GetInstance().ProcessDrvMsg(event);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, DriverEventSuccessed_02)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ENQUEUE_MSG;
    MOCKER(halEventProc)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, DriverEventFailed_02)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_QUEUE_INIT_MSG;
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup)
        .stubs()
        .will(returnValue(int32_t(AICPU_SCHEDULE_ERROR_DRV_ERR)));
    auto ret = AicpuQueueEventProcess::GetInstance().ProcessDrvMsg(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdQueueEventProcessTest, GetOrCreateGroupFail)
{
    AicpuQueueEventProcess inst;
    std::string grpName;
    MOCKER_CPP(&AicpuDrvManager::QueryProcBuffInfo).stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));
    const auto ret = inst.GetOrCreateGroup(grpName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpusdQueueEventProcessTest, AttachGroupForSlave_Success_01)
{
    MOCKER(halGrpAttach).stubs().will(returnValue(int32_t(DRV_ERROR_NONE)));
    MOCKER(halBuffInit).stubs().will(returnValue(int32_t(DRV_ERROR_NONE)));

    std::map<std::string, GroupShareAttr> grpInfos = {
        {"aicpusd_1", {0}}
    };

    std::string outGroupName;
    auto ret = AicpuQueueEventProcess::GetInstance().AttachGroupForSlave(grpInfos, outGroupName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, AttachGroupForSlaveFail)
{
    MOCKER(halGrpAttach).stubs().will(returnValue(int32_t(DRV_ERROR_INNER_ERR)));
    MOCKER(halBuffInit).stubs().will(returnValue(int32_t(DRV_ERROR_NONE)));

    std::map<std::string, GroupShareAttr> grpInfos = {
        {"aicpusd_1", {0}}
    };

    std::string outGroupName;
    auto ret = AicpuQueueEventProcess::GetInstance().AttachGroupForSlave(grpInfos, outGroupName);
    EXPECT_EQ(ret, DRV_ERROR_INNER_ERR);
}

/*
TEST_F(AicpusdQueueEventProcessTest, DriverEventFailed_InitFailed)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_CREATE_MSG;
    MOCKER(halQueueInit)
        .stubs()
        .will(returnValue(DRV_ERROR_QUEUE_INNER_ERROR));
    auto ret = AicpuQueueEventProcess::GetInstance().ProcessDrvMsg(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}
*/
TEST_F(AicpusdQueueEventProcessTest, DriverEventSuccessed_03)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_GRANT_MSG;

    QueueGrantPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueGrantPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueGrantPara), &msg, sizeof(QueueGrantPara));
    EXPECT_EQ(retMem, EOK);
    AicpuQueueEventProcess::GetInstance().type_ = CpType::MASTER;
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, DriverEventSuccessed_04)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ATTACH_MSG;
    AicpuQueueEventProcess::GetInstance().type_ = CpType::SLAVE;
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, DriverEventSuccessed_05)
{
    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = 10000;
    auto ret = AicpuQueueEventProcess::GetInstance().ProcessDrvMsg(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, ProcessQsMsg_Failed)
{
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = 10000;
    uint32_t msgLen = sizeof(QsBindInit);
    QsBindInit qsBindInit = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &qsBindInit, msgLen);
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuQueueEventProcess::GetInstance().ProcessQsMsg(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_NOT_FOUND_QUEUE_SUB_EVENT_ID);
}

TEST_F(AicpusdQueueEventProcessTest, BindQueueInitSuccessed)
{
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = ACL_BIND_QUEUE_INIT;
    uint32_t msgLen = sizeof(QsBindInit);
    QsBindInit qsBindInit = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &qsBindInit, msgLen);
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, BindQueueInitRetSuccessed)
{
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_BIND_QUEUE_INIT_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    AicpuQueueEventProcess::GetInstance().CreateAndAddCallbackMsg(event, mbuf, userData, callbackMsg);
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    halMbufFreeStub(mbuf);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, BindQueueSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen = sizeof(QueueRouteList);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &queueRouteList, msgLen);
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, UnBindQueueSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = ACL_UNBIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen = sizeof(QueueRouteList);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &queueRouteList, msgLen);
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, BindQueueRetSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_BIND_QUEUE_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    EXPECT_EQ(retMem, EOK);

    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(1, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    AicpuQueueEventProcess::GetInstance().CreateAndAddCallbackMsg(event1, mbuf, userData, callbackMsg);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, UnBindQueueRetSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_UNBIND_QUEUE_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    EXPECT_EQ(retMem, EOK);

    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(1, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    AicpuQueueEventProcess::GetInstance().CreateAndAddCallbackMsg(event1, mbuf, userData, callbackMsg);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueNumSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = ACL_QUERY_QUEUE_NUM;
    QueueRouteQuery msg = {1, 1, 1, 1, reinterpret_cast<uintptr_t>(&queueRoute)};
    uint32_t msgLen = sizeof(QueueRouteQuery);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msg, msgLen);
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueNumRetSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_QUERY_QUEUE_NUM_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    EXPECT_EQ(retMem, EOK);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    AicpuQueueEventProcess::GetInstance().CreateAndAddCallbackMsg(event, mbuf, userData, callbackMsg);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = ACL_QUERY_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen = sizeof(QueueRouteList);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &queueRouteList, msgLen);
    EXPECT_EQ(retMem, EOK);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueRetSuccessed)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_QUERY_QUEUE_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    EXPECT_EQ(retMem, EOK);
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(1, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    AicpuQueueEventProcess::GetInstance().CreateAndAddCallbackMsg(event1, mbuf, userData, callbackMsg);
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    AicpuQueueEventProcess::GetInstance().callbacks_.clear();
}

TEST_F(AicpusdQueueEventProcessTest, ProxyEvent_CreateGroup_Success)
{
    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_CREATE_GROUP;

    event.priv.msg_len = sizeof(ProxyMsgCreateGroup) + sizeof(event_sync_msg);
    ProxyMsgCreateGroup *msg =  reinterpret_cast<ProxyMsgCreateGroup*>(&event.priv.msg[sizeof(event_sync_msg)]);
    msg->size = 1024U;
    char_t groupName[] = "DEFAULT";
    ASSERT_EQ(memcpy_s(&msg->groupName[0], 16, &groupName[0], sizeof(groupName)), EOK);

    MOCKER_CPP(&AicpuQueueEventProcess::CreateGroupForMaster)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER(halGrpCacheAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_NONE));
    AicpuQueueEventProcess::GetInstance().grpName_ = "";
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, ProxyEvent_AllocMbuf_Success)
{
    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_ALLOC_MBUF;

    event.priv.msg_len = sizeof(ProxyMsgAllocMbuf) + sizeof(event_sync_msg);
    ProxyMsgAllocMbuf *msg =  reinterpret_cast<ProxyMsgAllocMbuf*>(&event.priv.msg[sizeof(event_sync_msg)]);
    msg->size = 1024U;

    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, ProxyEvent_FreeMbuf_Success)
{
    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_FREE_MBUF;

    event.priv.msg_len = sizeof(ProxyMsgFreeMbuf) + sizeof(event_sync_msg);
    ProxyMsgFreeMbuf *msg =  reinterpret_cast<ProxyMsgFreeMbuf*>(&event.priv.msg[sizeof(event_sync_msg)]);
    msg->mbufAddr = 1U;

    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, ProxyEvent_CopyQMbuf_Success)
{
    GlobalMockObject::verify();

    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_COPY_QMBUF;

    event.priv.msg_len = sizeof(ProxyMsgCopyQMbuf) + sizeof(event_sync_msg);
    ProxyMsgCopyQMbuf *msg =  reinterpret_cast<ProxyMsgCopyQMbuf*>(&event.priv.msg[sizeof(event_sync_msg)]);
    msg->destLen = 1024U;

    void *stubMbuf = 1;
    MOCKER(halQueueDeQueue)
        .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP(&stubMbuf))
        .will(returnValue(DRV_ERROR_NONE));
    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(), outBoundP(&stubMbuf))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    uint64_t mbufSize = 1024U;
    MOCKER(halMbufGetBuffSize)
        .stubs().with(mockcpp::any(), outBoundP(&mbufSize))
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(0));

    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, ProxyEvent_AddGroup_Success)
{
    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_ADD_GROUP;

    event.priv.msg_len = sizeof(ProxyMsgAddGroup) + sizeof(event_sync_msg);

    MOCKER(halGrpAddProc)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, ProxyCreateGroup_Fail_Alloc)
{
    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_CREATE_GROUP;

    event.priv.msg_len = sizeof(ProxyMsgCreateGroup) + sizeof(event_sync_msg);
    ProxyMsgCreateGroup *msg =  reinterpret_cast<ProxyMsgCreateGroup*>(&event.priv.msg[sizeof(event_sync_msg)]);
    msg->size = 1024U;
    char_t groupName[] = "DEFAULT";
    ASSERT_EQ(memcpy_s(&msg->groupName[0], 16, &groupName[0], sizeof(groupName)), EOK);

    AicpuQueueEventProcess instance;
    MOCKER_CPP(&AicpuQueueEventProcess::CreateGroupForMaster)
        .stubs()
        .will(returnValue(AICPU_SCHEDULE_OK));
    MOCKER(halGrpCacheAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_NO_DEVICE));
    EXPECT_EQ(instance.ProxyCreateGroup(event), AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdQueueEventProcessTest, CopyResultSuccess)
{
    std::shared_ptr<CallbackMsg> callback = make_shared<CallbackMsg>();
    if (callback == nullptr) {
        FAIL();
    }

    // set event
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    event1.priv.msg_len = sizeof(QueueRouteList);
    QsRouteHead routeHead = {.length=10, .routeNum=1, .subEventId=1, .userData=1};
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(&routeHead)};
    auto retMem = memcpy_s(event1.priv.msg, sizeof(QueueRouteList), &queueRouteList, sizeof(QueueRouteList));
    EXPECT_EQ(retMem, EOK);
    callback->event = event1;

    // set mbuf
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    callback->buff = mbuf;

    auto ret = AicpuQueueEventProcess::GetInstance().CopyResult(callback);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, CopyResultMemcpyFail)
{
    std::shared_ptr<CallbackMsg> callback = make_shared<CallbackMsg>();
    if (callback == nullptr) {
        FAIL();
    }

    // set event
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    event1.priv.msg_len = sizeof(QueueRouteList);
    QsRouteHead routeHead = {.length=10, .routeNum=1, .subEventId=1, .userData=1};
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(&routeHead)};
    auto retMem = memcpy_s(event1.priv.msg, sizeof(QueueRouteList), &queueRouteList, sizeof(QueueRouteList));
    EXPECT_EQ(retMem, EOK);
    callback->event = event1;

    // set mbuf
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    callback->buff = mbuf;

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    auto ret = AicpuQueueEventProcess::GetInstance().CopyResult(callback);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpusdQueueEventProcessTest, ProcessBindQueueInitParseMsgFailed)
{
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    auto retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::ParseQueueEventMessage).stubs().will(returnValue(1));
    AicpuQueueEventProcess inst;
    const int32_t ret = inst.ProcessBindQueueInit(event1);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, ProcessBindQueueInitQueryQsPidFailed)
{
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    auto retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::QueryQsPid).stubs().will(returnValue(1));
    AicpuQueueEventProcess inst;
    const int32_t ret = inst.ProcessBindQueueInit(event1);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, ProcessBindQueueInitGetOrCreateGroupFailed)
{
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    auto retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(1));
    AicpuQueueEventProcess inst;
    const int32_t ret = inst.ProcessBindQueueInit(event1);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, ProcessBindQueueInitShareGroupWithProcessFailed)
{
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    auto retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::ShareGroupWithProcess).stubs().will(returnValue(1));
    AicpuQueueEventProcess inst;
    const int32_t ret = inst.ProcessBindQueueInit(event1);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, ProcessBindQueueInitCreateAndAddCallbackMsgFailed)
{
    event_info event1 = {{EVENT_QS_MSG},{0}};
    event1.comm.event_id = EVENT_QS_MSG;
    event1.comm.subevent_id = ACL_BIND_QUEUE;
    QueueRouteList queueRouteList = {1, reinterpret_cast<uintptr_t>(routeListMsgbuff)};
    uint32_t msgLen1 = sizeof(QueueRouteList);
    event1.priv.msg_len = msgLen1;
    auto retMem = memcpy_s(event1.priv.msg, msgLen1, &queueRouteList, msgLen1);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::CreateAndAddCallbackMsg).stubs().will(returnValue(1));
    AicpuQueueEventProcess inst;
    const int32_t ret = inst.ProcessBindQueueInit(event1);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueNumRetGetCbkFail)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_QUERY_QUEUE_NUM_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    EXPECT_EQ(retMem, EOK);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_GET_CALLBACK_FAILED);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueNumRetParseFail)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_QUERY_QUEUE_NUM_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = 0;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    EXPECT_EQ(retMem, EOK);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueNumParseFail)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = ACL_QUERY_QUEUE_NUM;
    QueueRouteQuery msg = {1, 1, 1, 1, reinterpret_cast<uintptr_t>(&queueRoute)};
    uint32_t msgLen = sizeof(QueueRouteQuery);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msg, msgLen);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::ParseQueueEventMessage).stubs().will(returnValue(1));
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, QueryQueueNumParseCreateCbkFail)
{
    AicpuQueueEventProcess::GetInstance().initPipeline_ = BindQueueInitStatus::INITED;
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = ACL_QUERY_QUEUE_NUM;
    QueueRouteQuery msg = {1, 1, 1, 1, reinterpret_cast<uintptr_t>(&queueRoute)};
    uint32_t msgLen = sizeof(QueueRouteQuery);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msg, msgLen);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::CreateAndAddCallbackMsg).stubs().will(returnValue(1));
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, BindQueueInitRetProcessQsRetFailed)
{
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_BIND_QUEUE_INIT_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    AicpuQueueEventProcess::GetInstance().CreateAndAddCallbackMsg(event, mbuf, userData, callbackMsg);
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::ProcessQsRet).stubs().will(returnValue(1));
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    halMbufFreeStub(mbuf);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, BindQueueInitRethalQueueInitFailed)
{
    event_info event = {{EVENT_QS_MSG},{0}};
    event.comm.event_id = EVENT_QS_MSG;
    event.comm.subevent_id = AICPU_BIND_QUEUE_INIT_RES;
    uint32_t msgLen = sizeof(QsProcMsgRspDstAicpu);
    QsProcMsgRspDstAicpu msgRsp = {0};
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, msgLen, &msgRsp, msgLen);
    Mbuf *mbuf = nullptr;
    halMbufAllocStub(10, &mbuf);
    shared_ptr<CallbackMsg> callbackMsg;
    uint64_t userData = 0;
    AicpuQueueEventProcess::GetInstance().CreateAndAddCallbackMsg(event, mbuf, userData, callbackMsg);
    EXPECT_EQ(retMem, EOK);
    MOCKER(halQueueInit).stubs().will(returnValue(DRV_ERROR_PARA_ERROR));
    auto ret = AicpuEventManager::GetInstance().ProcessEvent(event, 0);
    halMbufFreeStub(mbuf);
    EXPECT_EQ(ret, 0);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessProxyMsg_AddGroup_ParseMsg_Fail)
{
    GlobalMockObject::verify();

    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_ADD_GROUP;

    event.priv.msg_len = 0;

    MOCKER(halGrpAddProc)
        .stubs()
        .will(returnValue(static_cast<int32_t>(DRV_ERROR_NONE)));

    AicpuQueueEventProcess instance;
    ProxyMsgRsp rsp = {};
    instance.DoProcessProxyMsg(event, rsp);

    EXPECT_EQ(rsp.retCode, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpusdQueueEventProcessTest, ProcessProxyMsg)
{
    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = 10U;

    AicpuQueueEventProcess instance;
    ProxyMsgRsp rsp = {};
    const int32_t ret = instance.ProcessProxyMsg(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgAttachMsgGetGrpFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ATTACH_MSG;
    
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(1));
    bool needRes = false;
    instance.type_ = CpType::SLAVE;
    auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgAttachMsgParseFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ATTACH_MSG;
    
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuQueueEventProcess::ParseQueueEventMessage).stubs().will(returnValue(1));
    bool needRes = false;
    instance.type_ = CpType::SLAVE;
    const auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgAttachMsgQueInitFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ATTACH_MSG;
    
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER(halQueueInit).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    bool needRes = false;
    instance.type_ = CpType::SLAVE;
    const auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, DRV_ERROR_INNER_ERR);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgAttachMsgQueAttachFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ATTACH_MSG;
    
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER(halQueueAttach).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    bool needRes = false;
    instance.type_ = CpType::SLAVE;
    const auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, DRV_ERROR_INNER_ERR);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgAttachMsgTypeFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_ATTACH_MSG;
    
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER(halQueueAttach).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    bool needRes = false;
    instance.type_ = CpType::MASTER;
    const auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

//

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgGrantMsgGetGrpFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_GRANT_MSG;
    
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(1));
    bool needRes = false;
    instance.type_ = CpType::SLAVE;
    auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgGrantMsgParseFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_GRANT_MSG;
    
    QueueAttachPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueAttachPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuQueueEventProcess::ParseQueueEventMessage).stubs().will(returnValue(1));
    bool needRes = false;
    instance.type_ = CpType::MASTER;
    const auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgGrantMsgShareFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_GRANT_MSG;
    
    QueueGrantPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueGrantPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuQueueEventProcess::ShareGroupWithProcess).stubs().will(returnValue(1));
    bool needRes = false;
    instance.type_ = CpType::MASTER;
    const auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, 1);
}


TEST_F(AicpusdQueueEventProcessTest, DoProcessDrvMsgGrantMsgQueGrantFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_GRANT_MSG;
    
    QueueGrantPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueGrantPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER(halQueueGrant).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    bool needRes = false;
    instance.type_ = CpType::MASTER;
    const auto ret = instance.DoProcessDrvMsg(event, needRes);
    EXPECT_EQ(ret, DRV_ERROR_INNER_ERR);
}

TEST_F(AicpusdQueueEventProcessTest, GrantQueueFail)
{
    AicpuQueueEventProcess instance;

    event_info event = {{EVENT_DRV_MSG},{0}};
    event.comm.event_id = EVENT_DRV_MSG;
    event.comm.subevent_id = DRV_SUBEVENT_GRANT_MSG;
    
    QueueGrantPara msg = {2000, 6, 10001};
    event_sync_msg head;
    uint32_t msgLen = sizeof(QueueGrantPara) + sizeof(event_sync_msg);
    event.priv.msg_len = msgLen;
    int retMem = memcpy_s(event.priv.msg, sizeof(event_sync_msg), &head, sizeof(event_sync_msg));
    EXPECT_EQ(retMem, EOK);
    retMem = memcpy_s(event.priv.msg + sizeof(event_sync_msg), sizeof(QueueAttachPara), &msg, sizeof(QueueAttachPara));
    EXPECT_EQ(retMem, EOK);
    MOCKER_CPP(&AicpuQueueEventProcess::GetOrCreateGroup).stubs().will(returnValue(0));
    MOCKER(halQueueGrant).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    bool needRes = false;
    instance.type_ = CpType::SLAVE;
    const auto ret = instance.GrantQueue(event);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_GRANT_QUEUE_FAILED);
}

TEST_F(AicpusdQueueEventProcessTest, ShareGroupWithProcessSuccess)
{
    AicpuQueueEventProcess instance;

    const std::string grpName = "test";
    const pid_t pid = 555;
    const int32_t ret = instance.ShareGroupWithProcess(grpName, pid);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdQueueEventProcessTest, ShareGroupWithProcessGrpQueryFail)
{
    AicpuQueueEventProcess instance;

    MOCKER(halGrpQuery).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_INNER_ERR)));

    const std::string grpName = "test";
    const pid_t pid = 555;
    const int32_t ret = instance.ShareGroupWithProcess(grpName, pid);
    EXPECT_EQ(ret, DRV_ERROR_INNER_ERR);
}

int halGrpQueryGrpRepeat(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    *outLen = sizeof(GrpQueryGroupsOfProcInfo);

    GroupQueryOutput *grpInfo = PtrToPtr<void, GroupQueryOutput>(outBuff);
    strcpy_s(grpInfo->grpQueryGroupsOfProcInfo[0].groupName, BUFF_GRP_MAX_NUM, "test1\0");
    grpInfo->grpQueryGroupsOfProcInfo[0].attr.admin = 1;

    return 0;
}

TEST_F(AicpusdQueueEventProcessTest, ShareGroupWithProcessGrpNameRepeat)
{
    AicpuQueueEventProcess instance;

    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryGrpRepeat));

    const std::string grpName = "test";
    const pid_t pid = 555;
    const int32_t ret = instance.ShareGroupWithProcess(grpName, pid);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

int halGrpQueryGrpLenError(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    *outLen = 1;

    GroupQueryOutput *grpInfo = PtrToPtr<void, GroupQueryOutput>(outBuff);
    strcpy_s(grpInfo->grpQueryGroupsOfProcInfo[0].groupName, BUFF_GRP_MAX_NUM, "test1\0");
    grpInfo->grpQueryGroupsOfProcInfo[0].attr.admin = 1;

    return 0;
}

TEST_F(AicpusdQueueEventProcessTest, ShareGroupWithProcessGrpNameLenInvalid)
{
    AicpuQueueEventProcess instance;

    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryGrpLenError));

    const std::string grpName = "test";
    const pid_t pid = 555;
    const int32_t ret = instance.ShareGroupWithProcess(grpName, pid);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

int halGrpQueryGrpSlave(GroupQueryCmdType cmd, void *inBuff, unsigned int inLen, void *outBuff, unsigned int *outLen)
{
    *outLen = sizeof(GrpQueryGroupsOfProcInfo);

    GroupQueryOutput *grpInfo = PtrToPtr<void, GroupQueryOutput>(outBuff);
    strcpy_s(grpInfo->grpQueryGroupsOfProcInfo[0].groupName, BUFF_GRP_MAX_NUM, "test1\0");
    grpInfo->grpQueryGroupsOfProcInfo[0].attr.admin = 0;

    return 0;
}

TEST_F(AicpusdQueueEventProcessTest, ShareGroupWithProcessGrpNameSlaveGrp)
{
    AicpuQueueEventProcess instance;

    MOCKER(halGrpQuery).stubs().will(invoke(halGrpQueryGrpSlave));

    const std::string grpName = "test";
    const pid_t pid = 555;
    const int32_t ret = instance.ShareGroupWithProcess(grpName, pid);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_SLAVE_GRP_INVALID);
}

TEST_F(AicpusdQueueEventProcessTest, ShareGroupWithProcessGrpAddFail)
{
    AicpuQueueEventProcess instance;

    MOCKER(halGrpAddProc).stubs().will(returnValue(static_cast<int32_t>(DRV_ERROR_INNER_ERR)));
    const std::string grpName = "test";
    const pid_t pid = 555;
    const int32_t ret = instance.ShareGroupWithProcess(grpName, pid);
    EXPECT_EQ(ret, DRV_ERROR_INNER_ERR);
}

TEST_F(AicpusdQueueEventProcessTest, DoProcessProxyMsg_AllocCache_Success)
{
    GlobalMockObject::verify();

    event_info event = {};
    event.comm.event_id = EVENT_USR_START + 8;
    event.comm.subevent_id = PROXY_SUBEVENT_ALLOC_CACHE;

    AicpuQueueEventProcess instance;
    // parse message fail
    event.priv.msg_len = sizeof(ProxyMsgAllocCache);
    ProxyMsgRsp rspInvalidMsg = {};
    instance.DoProcessProxyMsg(event, rspInvalidMsg);
    EXPECT_EQ(rspInvalidMsg.retCode, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // fail for empty group
    event.priv.msg_len = sizeof(ProxyMsgAllocCache) + sizeof(event_sync_msg);
    ProxyMsgRsp rspEmptyGroup = {};
    instance.DoProcessProxyMsg(event, rspEmptyGroup);
    EXPECT_EQ(rspEmptyGroup.retCode, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);

    // fail for halGrpCacheAlloc
    instance.grpName_ = "Default";
    MOCKER(halGrpCacheAlloc)
        .stubs()
        .will(returnValue(DRV_ERROR_INNER_ERR))
        .then(returnValue(DRV_ERROR_NONE));
    ProxyMsgRsp rspAllocFail = {};
    instance.DoProcessProxyMsg(event, rspAllocFail);
    EXPECT_EQ(rspAllocFail.retCode, AICPU_SCHEDULE_ERROR_DRV_ERR);

    // success
    ProxyMsgRsp rsp = {};
    instance.DoProcessProxyMsg(event, rsp);

    EXPECT_EQ(rsp.retCode, AICPU_SCHEDULE_OK);
}