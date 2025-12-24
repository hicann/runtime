/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acl/acl_base.h"
#include "acl/acl.h"
#include "acl/acl_tdt_queue.h"
#include "common/log_inner.h"

#include "acl_tdt_queue/queue.h"
#include "acl_tdt_queue/queue_manager.h"
#include "acl_tdt_queue/queue_process.h"
#include "acl_tdt_queue/queue_process_sp.h"
#include "acl_tdt_queue/queue_process_host.h"
#include "acl_tdt_queue/queue_process_ccpu.h"
#include "aicpu/queue_schedule/qs_client.h"
#include "base.h"
#include "acl_tdt_queue/toolchain/prof_api_reg.h"

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <memory>

#include "acl_stub.h"

#define protected public
#define private public
#undef private
#undef protected

using namespace testing;
using namespace std;
using namespace acl;

namespace acl {
    extern aclError CheckQueueRouteQueryInfo(const acltdtQueueRouteQueryInfo *queryInfo);
}

class UTEST_QUEUE : public testing::Test
{
    public:
        UTEST_QUEUE(){}
    protected:
        void SetUp() override
        {
            MockFunctionTest::aclStubInstance().ResetToDefaultMock();
        }
        void TearDown() override
        {
            Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
        }
};

TEST_F(UTEST_QUEUE, MsprofRegisterCallbackTest)
{
    rtProfCommandHandle_t command;
    command.profSwitch = 1;
    command.devNums = 1;
    command.devIdList[0] = 0;
    command.type = 1; // START_PROFILING
    auto ret = AclTdtQueueProfCtrlHandle(RT_PROF_CTRL_SWITCH, static_cast<void *>(&command), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(ret, ACL_SUCCESS);

    command.type = 2; // STOP_PROFILING
    ret = AclTdtQueueProfCtrlHandle(RT_PROF_CTRL_SWITCH, static_cast<void *>(&command), sizeof(rtProfCommandHandle_t));
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtCreateQueueAttr_acltdtDestroyQueueAttr)
{
    acltdtQueueAttr* attr = acltdtCreateQueueAttr();
    EXPECT_NE(attr, nullptr);
    EXPECT_EQ(string(attr->name).empty(), true);
    EXPECT_EQ(attr->depth, 8);
    EXPECT_EQ(attr->workMode, RT_MQ_MODE_DEFAULT);
    EXPECT_EQ(attr->flowCtrlFlag, false);
    EXPECT_EQ(attr->flowCtrlDropTime, 0);
    EXPECT_EQ(attr->overWriteFlag, false);
    auto ret = acltdtDestroyQueueAttr(attr);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtSetQueueAttr)
{
    size_t len = sizeof(size_t);
    const char* name = "123456789";
    auto ret = acltdtSetQueueAttr(nullptr, ACL_TDT_QUEUE_NAME_PTR, len, &name);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    acltdtQueueAttr attr = {};
    ret = acltdtSetQueueAttr(&attr, ACL_TDT_QUEUE_NAME_PTR, len, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = acltdtSetQueueAttr(&attr, ACL_TDT_QUEUE_NAME_PTR, len, &name);
    std::string oriName(name);
    std::string tmpName(attr.name);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(tmpName, oriName);

    char nameVec[] = "222";
    char *nameVecPtr = &nameVec[0];
    ret = acltdtSetQueueAttr(&attr, ACL_TDT_QUEUE_NAME_PTR, len, &nameVecPtr);
    oriName = std::string(nameVec);
    tmpName = std::string(attr.name);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(tmpName, oriName);

    // 129 bytes
    const char* nameFake = "66666666666666666666669666668888866666666666666666666668888888888888888844444444444444444444444444444444488888888888888888888888";
    
    ret = acltdtSetQueueAttr(&attr, ACL_TDT_QUEUE_NAME_PTR, len, &nameFake);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    len = sizeof(uint32_t);
    uint32_t depth = 3;
    ret = acltdtSetQueueAttr(&attr, ACL_TDT_QUEUE_DEPTH_UINT32, len, &depth);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(depth, attr.depth);
}

TEST_F(UTEST_QUEUE, acltdtGetQueueAttr)
{
    size_t len = sizeof(size_t);
    const char* name = nullptr;
    size_t retSize = 0;
    auto ret = acltdtGetQueueAttr(nullptr, ACL_TDT_QUEUE_NAME_PTR, len, &retSize, &name);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    acltdtQueueAttr attr = {};
    ret = acltdtGetQueueAttr(&attr, ACL_TDT_QUEUE_NAME_PTR, len, nullptr, &name);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acltdtGetQueueAttr(&attr, ACL_TDT_QUEUE_NAME_PTR, len, &retSize, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    const char *preName = "1234";
    memcpy_s(attr.name, 128, preName, strlen(preName) + 1);
    string copyName = string(attr.name);
    EXPECT_EQ(copyName, "1234");
    ret = acltdtGetQueueAttr(&attr, ACL_TDT_QUEUE_NAME_PTR, len, &retSize, &name);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(string(name), copyName);
    EXPECT_EQ(retSize, len);

    attr.depth = 5;
    uint32_t depth = 9999;
    len = sizeof(uint32_t);
    ret = acltdtGetQueueAttr(&attr, ACL_TDT_QUEUE_DEPTH_UINT32, len, &retSize, &depth);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(depth, 5);
    EXPECT_EQ(retSize, len);
}

TEST_F(UTEST_QUEUE, QueueRoute_create_destroy)
{
    acltdtQueueRoute *route =  acltdtCreateQueueRoute(1, 2);
    EXPECT_NE(route, nullptr);
    EXPECT_EQ(route->srcId, 1);
    EXPECT_EQ(route->dstId, 2);
    EXPECT_EQ(route->status, 0);
    auto ret = acltdtDestroyQueueRoute(route);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtGetQueueRouteParam)
{
    size_t len = sizeof(size_t);
    uint32_t src = 9999;
    size_t retSize = 0;
    auto ret = acltdtGetQueueRouteParam(nullptr, ACL_TDT_QUEUE_ROUTE_SRC_UINT32, len, &retSize, &src);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    acltdtQueueRoute route = {};
    ret = acltdtGetQueueRouteParam(&route, ACL_TDT_QUEUE_ROUTE_SRC_UINT32, len, nullptr, &src);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acltdtGetQueueRouteParam(&route, ACL_TDT_QUEUE_ROUTE_SRC_UINT32, len, &retSize, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    route.srcId = 666;
    route.dstId = 999;
    route.status = 1;
    ret = acltdtGetQueueRouteParam(&route, ACL_TDT_QUEUE_ROUTE_SRC_UINT32, len, &retSize, &src);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(retSize, 4);
    EXPECT_EQ(src, 666);

    uint32_t dst = 888;
    ret = acltdtGetQueueRouteParam(&route, ACL_TDT_QUEUE_ROUTE_DST_UINT32, len, &retSize, &dst);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(retSize, 4);
    EXPECT_EQ(dst, 999);

    int32_t status = 0;
    ret = acltdtGetQueueRouteParam(&route, ACL_TDT_QUEUE_ROUTE_STATUS_INT32, len, &retSize, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(retSize, 4);
    EXPECT_EQ(status, 1);
}

TEST_F(UTEST_QUEUE, QueueRouteList_create_destroy)
{
    acltdtQueueRouteList *routeList =  acltdtCreateQueueRouteList();
    EXPECT_NE(routeList, nullptr);
    EXPECT_EQ(routeList->routeList.size(), 0);
    auto ret = acltdtDestroyQueueRouteList(routeList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtAddQueueRoute)
{
    acltdtQueueRouteList routeList;
    acltdtQueueRoute route = {};
    auto ret = acltdtAddQueueRoute(nullptr, &route);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acltdtAddQueueRoute(&routeList, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    route.srcId = 111;
    route.dstId = 222;
    ret = acltdtAddQueueRoute(&routeList, &route);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(routeList.routeList.size(), 1);
    EXPECT_EQ(routeList.routeList[0].srcId, 111);
    EXPECT_EQ(routeList.routeList[0].dstId, 222);
    ret = acltdtAddQueueRoute(&routeList, &route);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(routeList.routeList.size(), 2);
}

TEST_F(UTEST_QUEUE, acltdtGetQueueRoute)
{
    acltdtQueueRouteList routeList;
    acltdtQueueRoute route = {};
    auto ret = acltdtGetQueueRoute(nullptr, 0, &route);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acltdtGetQueueRoute(&routeList, 0, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acltdtGetQueueRoute(&routeList, 0, &route);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    acltdtQueueRoute tmpRoute = {111, 222, 0};
    routeList.routeList.push_back(tmpRoute);
    ret = acltdtGetQueueRoute(&routeList, 0, &route);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(route.srcId, 111);
    EXPECT_EQ(route.dstId, 222);
    EXPECT_EQ(route.status, 0);
    size_t size = acltdtGetQueueRouteNum(nullptr);
    EXPECT_EQ(size, 0);
    size = acltdtGetQueueRouteNum(&routeList);
    EXPECT_EQ(size, 1);
}

TEST_F(UTEST_QUEUE, CheckQueueRouteQueryInfo)
{
    acltdtQueueRouteQueryInfo queryInfo = {};
    queryInfo.srcId = 0;
    queryInfo.dstId = 1;
    queryInfo.isConfigMode = false;
    auto ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    queryInfo.mode = ACL_TDT_QUEUE_ROUTE_QUERY_SRC;
    queryInfo.isConfigMode = true;
    ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    queryInfo.isConfigSrc = false;
    ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    queryInfo.isConfigSrc = true;
    ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_SUCCESS);

    queryInfo.mode = ACL_TDT_QUEUE_ROUTE_QUERY_DST;
    queryInfo.isConfigDst = false;
    ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    queryInfo.isConfigDst = true;
    ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_SUCCESS);
    
    queryInfo.mode = ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST;
    queryInfo.isConfigDst = false;
    ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    queryInfo.isConfigDst = true;
    queryInfo.isConfigSrc = true;
    ret = CheckQueueRouteQueryInfo(&queryInfo);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, QueryQueueRoute_create_destroy)
{
    acltdtQueueRouteQueryInfo *info = acltdtCreateQueueRouteQueryInfo();
    EXPECT_NE(info, nullptr);
    EXPECT_EQ(info->isConfigSrc, false);
    EXPECT_EQ(info->isConfigDst, false);
    EXPECT_EQ(info->isConfigMode, false);
    auto ret = acltdtDestroyQueueRouteQueryInfo(info);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtSetQueueRouteQueryInfo)
{
    size_t len = sizeof(uint32_t);
    uint32_t src = 999;
    auto ret = acltdtSetQueueRouteQueryInfo(nullptr, ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32, len, &src);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    acltdtQueueRouteQueryInfo *info = acltdtCreateQueueRouteQueryInfo();
    EXPECT_NE(info, nullptr);
    ret = acltdtSetQueueRouteQueryInfo(info, ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32, len, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = acltdtSetQueueRouteQueryInfo(info, ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32, len, &src);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(info->srcId, 999);
    EXPECT_EQ(info->isConfigSrc, true);

    uint32_t dst = 888;
    ret = acltdtSetQueueRouteQueryInfo(info, ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32, len, &dst);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(info->dstId, 888);
    EXPECT_EQ(info->isConfigDst, true);

    acltdtQueueRouteQueryMode mode = ACL_TDT_QUEUE_ROUTE_QUERY_DST;
    ret = acltdtSetQueueRouteQueryInfo(info, ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM, sizeof(mode), &mode);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(info->mode, ACL_TDT_QUEUE_ROUTE_QUERY_DST);
    EXPECT_EQ(info->isConfigMode, true);

    ret = acltdtDestroyQueueRouteQueryInfo(info);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtEnqueueData)
{
    void* ptr = nullptr;
    size_t size = 100;
    aclrtMalloc(&ptr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillRepeatedly(Return(ACL_RT_SUCCESS));

    QueueProcessorHost phost;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueueBuff(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_FULL))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_EMPTY))
        .WillOnce(Return(RT_ERROR_NONE));
    int ret = phost.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_FULL);

    ret = phost.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_EMPTY);

    ret = phost.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    QueueProcessorSp psp;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueueBuff(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_FULL))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_EMPTY))
        .WillOnce(Return(RT_ERROR_NONE));
    ret = psp.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_FULL);

    ret = psp.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_EMPTY);

    ret = psp.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    QueueProcessorCcpu pccpu;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGrpQuery(_, _))
        .WillRepeatedly(Return(ACL_RT_SUCCESS));

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGrpCreate(_, _))
        .WillRepeatedly(Return(ACL_RT_SUCCESS));

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGrpAddProc(_, _, _))
        .WillRepeatedly(Return(ACL_RT_SUCCESS));

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGrpAttach(_, _))
        .WillRepeatedly(Return(ACL_RT_SUCCESS));

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueueBuff(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_FULL))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_EMPTY))
        .WillOnce(Return(RT_ERROR_NONE));
    ret = pccpu.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_FULL);

    ret = pccpu.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_EMPTY);

    ret = pccpu.acltdtEnqueueData(-1, ptr, size, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);


    aclrtFree(ptr);
}

TEST_F(UTEST_QUEUE, acltdtEnqueueDataTest)
{
    auto ret = acltdtEnqueueData(-1, (void*)0x1, 1, nullptr, 0, 0, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtDequeueData)
{
    void* ptr = nullptr;
    size_t size = 100;
    size_t retSize = 1;
    aclrtMalloc(&ptr, size, ACL_MEM_MALLOC_HUGE_FIRST);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueuePeek(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_FULL))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_EMPTY))
        .WillOnce(Return(RT_ERROR_NONE));

    auto ret = acltdtDequeueData(-1, ptr, size, &retSize, nullptr, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_FULL);

    ret = acltdtDequeueData(-1, ptr, size, &retSize, nullptr, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_EMPTY);

    ret = acltdtDequeueData(-1, ptr, size, &retSize, nullptr, 0, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    aclrtFree(ptr);
}

TEST_F(UTEST_QUEUE, GetDstInfo)
{
    QueueProcessorHost processor;
    int32_t dstPid = 0;
    auto ret = processor.GetDstInfo(0, CP_PID, dstPid);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtQueryDevPid(_, _))
        .WillOnce(Return((ACL_ERROR_RT_REPEATED_INIT)))
        .WillRepeatedly(Return((ACL_RT_SUCCESS)));
    ret = processor.GetDstInfo(0, CP_PID, dstPid);
    EXPECT_EQ(ret, ACL_ERROR_RT_REPEATED_INIT);
}

// host chip default
TEST_F(UTEST_QUEUE, acltdtAllocBuf_host)
{
    acltdtBuf buf = nullptr;
    size_t size = 100;
    QueueProcessorHost processor;
    auto ret = processor.acltdtAllocBuf(size, 0, &buf);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = acltdtAllocBuf(size, 2, &buf);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_QUEUE, acltdtFreeBuf_host)
{
    acltdtBuf buf = nullptr;
    QueueProcessorHost processor;
    auto ret = processor.acltdtFreeBuf(buf);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(UTEST_QUEUE, aclmBufApi)
{
    acltdtBuf buf1 = nullptr;
    acltdtBuf buf2 = nullptr;
    size_t size = 100;
    QueueProcessorHost processor;
    auto ret = processor.acltdtAllocBuf(size, 0, &buf1);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = processor.acltdtAllocBuf(size, 0, &buf2);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = processor.acltdtSetBufDataLen(buf1, 99);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    size_t len = 0;
    ret = processor.acltdtGetBufDataLen(buf1, &len);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = processor.acltdtAppendBufChain(buf1, buf2);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    uint32_t num = 0;
    ret = processor.acltdtGetBufChainNum(buf1, &num);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    acltdtBuf buf3 = nullptr;
    ret = processor.acltdtGetBufFromChain(buf1, 1, &buf3);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = processor.acltdtFreeBuf(buf1);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = processor.acltdtFreeBuf(buf2);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(UTEST_QUEUE, acltdtGrantQueue)
{
    auto ret = acltdtGrantQueue(0, 0, 0, 0);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(UTEST_QUEUE, acltdtAttachQueue)
{
    uint32_t flag = 0;
    auto ret = acltdtAttachQueue(0, 0, &flag);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(UTEST_QUEUE, acltdtGetBufData_host)
{
    acltdtBuf buf = nullptr;
    void *dataPtr = nullptr;
    size_t size = 0;
    QueueProcessorHost processor;
    auto ret = processor.acltdtGetBufData(buf, &dataPtr, &size);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(UTEST_QUEUE, acltdtEnqueue_host)
{
    acltdtBuf buf = nullptr;
    uint32_t qid = 0;
    int32_t timeout = 3000;
    QueueProcessorHost processor;
    auto ret = processor.acltdtEnqueue(qid, buf, timeout);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(UTEST_QUEUE, acltdtDequeue_host)
{
    acltdtBuf buf = nullptr;
    uint32_t qid = 0;
    int32_t timeout = 3000;
    QueueProcessorHost processor;
    auto ret = processor.acltdtDequeue(qid, &buf, timeout);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

TEST_F(UTEST_QUEUE, acltdtCreateQueue_host)
{
    uint32_t qid = 0;
    acltdtQueueAttr attr{};
    auto ret = acltdtCreateQueue(&attr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acltdtCreateQueue(nullptr, &qid);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueInit(_))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueCreate(_,_,_))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    ret = acltdtCreateQueue(&attr, &qid);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtDestroyQueue_host)
{
    uint32_t qid = 0;
    auto ret = acltdtDestroyQueue(qid);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtBindQueueRoutes_host)
{
    acltdtQueueRouteList qRouteList;
    acltdtQueueRoute route = {};
    qRouteList.routeList.push_back(route);
    auto ret = acltdtBindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_INVALID_HANDLE)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    ret = acltdtBindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(UTEST_QUEUE, acltdtUnbindQueueRoutes_host)
{
    acltdtQueueRouteList qRouteList;
    acltdtQueueRoute route = {};
    qRouteList.routeList.push_back(route);
    
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpy(_, _, _, _, _))
        .WillRepeatedly(Return((ACL_RT_SUCCESS)));

    auto ret = acltdtUnbindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = acltdtUnbindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = acltdtUnbindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = acltdtUnbindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtQueryQueueRoutes_host)
{
    acltdtQueueRouteList qRouteList;
    acltdtQueueRouteQueryInfo queryInfo;
    queryInfo.isConfigMode = false;
    acltdtQueueRoute route = {};
    qRouteList.routeList.push_back(route);
    auto ret = acltdtQueryQueueRoutes(&queryInfo, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    queryInfo.mode = ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST;
    queryInfo.srcId = 0;
    queryInfo.dstId = 1;
    queryInfo.isConfigDst = true;
    queryInfo.isConfigMode = true;
    queryInfo.isConfigSrc = true;
    ret = acltdtQueryQueueRoutes(&queryInfo, &qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, QueryQueueRoutes_host)
{
    QueueProcessorHost queueProcess;
    acltdtQueueRouteList qRouteList;
    acltdtQueueRouteQueryInfo queryInfo;
    rtEschedEventSummary_t eventSum = {};
    rtEschedEventReply_t ack = {};
    bqs::QsProcMsgRsp qsRsp = {};
    ack.buf = reinterpret_cast<char *>(&qsRsp);
    ack.bufLen = sizeof(qsRsp);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_INVALID_HANDLE)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    auto ret = queueProcess.QueryQueueRoutes(0, &queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpy(_, _, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_TS_ERROR)))
        .WillOnce(Return((ACL_SUCCESS)))
        .WillOnce(Return((ACL_ERROR_RT_TS_ERROR)))
        .WillOnce(Return((ACL_SUCCESS)))
        .WillOnce(Return((ACL_SUCCESS)))
        .WillOnce(Return((ACL_ERROR_RT_TS_ERROR)))
        .WillRepeatedly(Return((ACL_RT_SUCCESS)));
    ret = queueProcess.QueryQueueRoutes(0, &queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_TS_ERROR);
    ret = queueProcess.QueryQueueRoutes(0, &queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_TS_ERROR);
    ret = queueProcess.QueryQueueRoutes(0, &queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_TS_ERROR);
    ret = queueProcess.QueryQueueRoutes(0, &queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
    // for cov
    qsRsp.retCode = 1;
    ret = queueProcess.QueryQueueRoutes(0, &queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
}

TEST_F(UTEST_QUEUE, acltdtMbufNotSupport_host)
{
    acltdtBuf buf = nullptr;
    void *dataPtr = nullptr;
    size_t size = 0U;
    size_t offset = 0U;
    QueueProcessorHost queueProcess;
    auto ret = queueProcess.acltdtGetBufUserData(buf, dataPtr, size, offset);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = queueProcess.acltdtSetBufUserData(buf, dataPtr, size, offset);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);

    ret = queueProcess.acltdtCopyBufRef(buf, &buf);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
}

rtError_t rtMemGrpQuery_Invoke(const rtMemGrpQueryInput_t *input, rtMemGrpQueryOutput_t *output)
{
    (void) input;
    rtMemGrpShareAttr_t attr;
    attr.admin = 1U;
    attr.read = 1U;
    attr.alloc = 1U;
    attr.rsv = 1U;
    rtMemGrpOfProc_t outputInfo;
    outputInfo.attr = attr;

    static rtMemGrpOfProc_t outputInfos[1];
    outputInfos[0] = outputInfo;
    output->groupsOfProc = &outputInfos[0];
    output->maxNum = 1U;
    output->resultNum = 1U;
    return RT_ERROR_NONE;
}

TEST_F(UTEST_QUEUE, acltdtMbufApiRC)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGrpQuery(_, _))
        .WillRepeatedly(Invoke(rtMemGrpQuery_Invoke));
    QueueProcessorSp queueProcess;
    acltdtBuf buf1 = nullptr;
    acltdtBuf buf2 = nullptr;
    size_t size = 100;
    auto ret = queueProcess.acltdtAllocBuf(size, 0, &buf1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtAllocBuf(size, 0, &buf2);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtSetBufDataLen(buf1, 99);
    EXPECT_EQ(ret, ACL_SUCCESS);

    size_t len = 0;
    ret = queueProcess.acltdtGetBufDataLen(buf1, &len);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtAppendBufChain(buf1, buf2);
    EXPECT_EQ(ret, ACL_SUCCESS);

    uint32_t num = 0;
    ret = queueProcess.acltdtGetBufChainNum(buf1, &num);
    EXPECT_EQ(ret, ACL_SUCCESS);

    acltdtBuf buf3 = nullptr;
    ret = queueProcess.acltdtGetBufFromChain(buf1, 1, &buf3);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtFreeBuf(buf1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtFreeBuf(buf2);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtCopyBufRef_sp)
{
    acltdtBuf buf = nullptr;
    size_t size = 96U;
    size_t offset = 0U;
    uint32_t type = 0U;
    void *dataPtr = nullptr;
    QueueProcessorSp queueProcess;
    auto ret = queueProcess.acltdtGetBufData(buf, &dataPtr, &size);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    uint32_t invalidType = 2U;
    ret = queueProcess.acltdtAllocBuf(size, invalidType, &buf);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtAllocBuf(size, type, &buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(buf, nullptr);

    ret = queueProcess.acltdtGetBufUserData(buf, buf, size, offset);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtSetBufUserData(buf, buf, size, offset);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtCopyBufRef(buf, &buf);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = queueProcess.acltdtFreeBuf(buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

// sp chip
TEST_F(UTEST_QUEUE, acltdtAllocBuf_sp)
{
    acltdtBuf buf = nullptr;
    size_t size = 100;
    uint32_t type = 0U;
    void *dataPtr = nullptr;
    QueueProcessorSp queueProcess;
    auto ret = queueProcess.acltdtGetBufData(buf, &dataPtr, &size);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = queueProcess.acltdtAllocBuf(size, type, &buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(buf, nullptr);

    ret = queueProcess.acltdtGetBufData(buf, &dataPtr, &size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(dataPtr, nullptr);

    ret = queueProcess.acltdtFreeBuf(buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtEnqueue_sp)
{
    QueueProcessorSp queueProcess;
    acltdtBuf buf = nullptr;
    uint32_t qid = 0;
    int32_t timeout = 30;
    auto ret = queueProcess.acltdtEnqueue(qid, buf, timeout);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    size_t size = 10;
    uint32_t type = 0U;
    ret = queueProcess.acltdtAllocBuf(size, type, &buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(buf, nullptr);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueue(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillOnce(Return((RT_ERROR_NONE)))
        .WillRepeatedly(Return((ACL_ERROR_RT_QUEUE_FULL)));
    ret = queueProcess.acltdtEnqueue(qid, buf, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = queueProcess.acltdtEnqueue(qid, buf, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = queueProcess.acltdtEnqueue(qid, buf, timeout);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    ret = queueProcess.acltdtFreeBuf(buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtDequeue_sp)
{
    QueueProcessorSp queueProcess;
    acltdtBuf buf = nullptr;
    uint32_t qid = 0;
    int32_t timeout = 30;
    auto ret = queueProcess.acltdtDequeue(qid, &buf, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueDeQueue(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return((ACL_ERROR_RT_QUEUE_EMPTY)));
    ret = queueProcess.acltdtDequeue(qid, &buf, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = queueProcess.acltdtDequeue(qid, &buf, timeout);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
}

TEST_F(UTEST_QUEUE, acltdtCreateQueue_sp)
{
    QueueProcessorSp queueProcess;
    uint32_t qid = 0;
    acltdtQueueAttr attr;
    auto ret = queueProcess.acltdtCreateQueue(&attr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = queueProcess.acltdtCreateQueue(nullptr, &qid);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
    ret = queueProcess.acltdtCreateQueue(&attr, &qid);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtDestroyQueue_sp)
{
    QueueProcessorSp queueProcess;
    uint32_t qid = 0;
    auto ret = queueProcess.acltdtDestroyQueue(qid);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtGrantQueue_sp)
{
    QueueProcessorSp queueProcess;
    uint32_t qid = 0;
    int32_t pid = 888;
    uint32_t permission = 2;
    int32_t timeout = 0;
    auto ret = queueProcess.acltdtGrantQueue(qid, pid, permission, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtAttachQueue_sp)
{
    QueueProcessorSp queueProcess;
    uint32_t qid = 0;
    uint32_t permission = 1;
    int32_t timeout = 0;
    auto ret = queueProcess.acltdtAttachQueue(qid, timeout, &permission);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtBindQueueRoutes_sp)
{
    QueueProcessorSp queueProcess;
    acltdtQueueRouteList qRouteList;
    acltdtQueueRoute route = {};
    qRouteList.routeList.push_back(route);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueue(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_INTERNAL_ERROR)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    auto ret = queueProcess.acltdtBindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_INVALID_HANDLE)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    ret = queueProcess.acltdtBindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);
}

TEST_F(UTEST_QUEUE, acltdtUnbindQueueRoutes_sp)
{
    QueueProcessorSp queueProcess;
    acltdtQueueRouteList qRouteList;
    acltdtQueueRoute route = {};
    qRouteList.routeList.push_back(route);
    auto ret = queueProcess.acltdtUnbindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtQueryQueueRoutes_sp)
{
    QueueProcessorSp queueProcess;
    acltdtQueueRouteList qRouteList;
    acltdtQueueRouteQueryInfo queryInfo;
    auto ret = queueProcess.acltdtQueryQueueRoutes(&queryInfo, &qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, QueryQueueRoutes_sp)
{
    QueueProcessorSp queueProcess;
    acltdtQueueRouteList qRouteList;
    acltdtQueueRouteQueryInfo queryInfo;
    rtEschedEventSummary_t eventSum = {};
    rtEschedEventReply_t ack = {};
    bqs::QsProcMsgRsp qsRsp = {};
    ack.buf = reinterpret_cast<char *>(&qsRsp);
    ack.bufLen = sizeof(qsRsp);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueue(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_INTERNAL_ERROR)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    auto ret = queueProcess.QueryQueueRoutesOnDevice(&queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_INVALID_HANDLE)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    ret = queueProcess.QueryQueueRoutesOnDevice(&queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_HANDLE);
    ret = queueProcess.QueryQueueRoutesOnDevice(&queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
    // for cov
    qsRsp.retCode = 1;
    ret = queueProcess.QueryQueueRoutesOnDevice(&queryInfo, 1, eventSum, ack, &qRouteList);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
}

// ccpu chip
TEST_F(UTEST_QUEUE, acltdtDestroyQueue_ccpu)
{
    QueueProcessorCcpu queueProcess;
    uint32_t qid = 0;
    auto ret = queueProcess.acltdtDestroyQueue(qid);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtBindQueueRoutes_ccpu)
{
    QueueProcessorCcpu queueProcess;
    acltdtQueueRouteList qRouteList;
    auto ret = queueProcess.acltdtBindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtUnbindQueueRoutes_ccpu)
{
    QueueProcessorCcpu queueProcess;
    acltdtQueueRouteList qRouteList;
    auto ret = queueProcess.acltdtUnbindQueueRoutes(&qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtQueryQueueRoutes_ccpu)
{
    QueueProcessorCcpu queueProcess;
    acltdtQueueRouteList qRouteList;
    acltdtQueueRouteQueryInfo queryInfo;
    auto ret = queueProcess.acltdtQueryQueueRoutes(&queryInfo, &qRouteList);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, acltdtAllocBuf_ccpu)
{
    acltdtBuf buf = nullptr;
    size_t size = 100;
    uint32_t type = 0U;
    void *dataPtr = nullptr;
    QueueProcessorCcpu queueProcess;
    auto ret = queueProcess.acltdtGetBufData(buf, &dataPtr, &size);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = queueProcess.acltdtAllocBuf(size, type, &buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(buf, nullptr);

    ret = queueProcess.acltdtFreeBuf(buf);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

rtError_t rtGetRunModeInvoke(rtRunMode *mode)
{
    *mode = RT_RUN_MODE_OFFLINE;
    return RT_ERROR_NONE;
}

TEST_F(UTEST_QUEUE, GetRunningEnvTest)
{
    RunEnv runningEnv = ACL_ACL_ENV_UNKNOWN;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    QueueManager manage;
    aclError ret = manage.GetRunningEnv(runningEnv);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillOnce(Invoke(rtGetRunModeInvoke));
    ret = manage.GetRunningEnv(runningEnv);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_QUEUE, GetQueueProcessorTest)
{
    QueueManager manage;
    RunEnv runningEnv = ACL_ACL_ENV_UNKNOWN;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillOnce(Invoke(rtGetRunModeInvoke));
    manage.GetRunningEnv(runningEnv);
    QueueProcessor *ret = manage.GetQueueProcessor();
    EXPECT_EQ(ret, nullptr);
}

TEST_F(UTEST_QUEUE, SendConnectQsMsg_Fail)
{
    QueueProcessorSp queueProcess;
    rtEschedEventSummary_t eventSum = {};
    rtEschedEventReply_t ack = {};
    bqs::QsProcMsgRsp rsp = {};
    rsp.retCode = 0;
    rsp.majorVersion = 2;
    ack.buf = reinterpret_cast<char *>(&rsp);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    auto ret = queueProcess.SendConnectQsMsg(0, eventSum, ack);
    EXPECT_EQ(ret, ACL_SUCCESS);
    // for cov
    rsp.retCode = 1;
    ret = queueProcess.SendConnectQsMsg(0, eventSum, ack);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
}

TEST_F(UTEST_QUEUE, SendBindUnbindMsg_Fail)
{
    acltdtQueueRouteList qRouteList;
    acltdtQueueRoute route = {};
    qRouteList.routeList.push_back(route);
    rtEschedEventSummary_t eventSum = {};
    bqs::QsProcMsgRsp qsRsp;
    qsRsp.retCode = 0;
    qsRsp.majorVersion = 2;
    rtEschedEventReply_t ack = {nullptr, 0U, 0U};
    ack.buf = reinterpret_cast<char_t *>(&qsRsp);
    ack.bufLen = sizeof(qsRsp);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpy(_, _, _, _, _))
        .WillOnce(Return((ACL_SUCCESS)))
        .WillOnce(Return((ACL_SUCCESS)))
        .WillOnce(Return((ACL_ERROR_RT_TS_ERROR)))
        .WillRepeatedly(Return(ACL_RT_SUCCESS));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    // for cov
    QueueProcessorHost processorHost;
    auto ret = processorHost.SendBindUnbindMsg(0, &qRouteList, true, eventSum, ack);
    EXPECT_EQ(ret, ACL_ERROR_RT_TS_ERROR);

    qsRsp.retCode = 1;
    ret = processorHost.SendBindUnbindMsg(0, &qRouteList, true, eventSum, ack);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
}

TEST_F(UTEST_QUEUE, GetQueueRouteNum_Fail)
{
    rtEschedEventSummary_t eventSum = {};
    acltdtQueueRouteQueryInfo queryInfo;
    bqs::QsProcMsgRsp qsRsp;
    qsRsp.retCode = 1;
    rtEschedEventReply_t ack = {nullptr, 0U, 0U};
    ack.buf = reinterpret_cast<char_t *>(&qsRsp);
    ack.bufLen = sizeof(qsRsp);
    size_t routeNum = 0;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    // for cov
    QueueProcessorHost processorHost;
    auto ret = processorHost.GetQueueRouteNum(&queryInfo, 0, eventSum, ack, routeNum);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
}

TEST_F(UTEST_QUEUE, SendBindUnbindMsgOnDevice_Fail)
{
    acltdtQueueRouteList qRouteList;
    rtEschedEventSummary_t eventSum = {};
    bqs::QsProcMsgRsp qsRsp;
    qsRsp.retCode = 1;
    rtEschedEventReply_t ack = {nullptr, 0, 0};
    ack.buf = reinterpret_cast<char_t *>(&qsRsp);
    ack.bufLen = sizeof(qsRsp);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEschedSubmitEventSync(_, _, _))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    // for cov
    QueueProcessorHost processorHost;
    auto ret = processorHost.SendBindUnbindMsgOnDevice(&qRouteList, true, eventSum, ack);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
}
