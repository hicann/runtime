/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>
#include <vector>
#include <unordered_set>
#include <securec.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "proto/dynamic_sched_message.pb.h"

#define private public
#include "dynamic_sched/dynamic_sched_mgr.hpp"
#undef private

namespace dgw {
namespace {
    constexpr int32_t kRequestCacheNum = 3;
    void *halMbufGetBuffAddrFakeAddr = nullptr;
    uint64_t halMbufGetBuffSizeFakeSize = 0U;
    int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf)
    {
        *buf = halMbufGetBuffAddrFakeAddr;
        return DRV_ERROR_NONE;
    }
    int32_t halMbufGetBuffSizeFake(Mbuf *mbuf, uint64_t *totalSize)
    {
        *totalSize = halMbufGetBuffSizeFakeSize;
        return DRV_ERROR_NONE;
    }
}

    class DynamicSchedMgrUTest : public testing::Test {
    protected:
        virtual void SetUp()
        {
        }

        virtual void TearDown()
        {
            GlobalMockObject::verify();
        }
    };

    TEST_F(DynamicSchedMgrUTest, AddRootModelInfo_success)
    {
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
    }

    TEST_F(DynamicSchedMgrUTest, AddRootModelInfo_fail)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_FAILED);
    }

    TEST_F(DynamicSchedMgrUTest, SendRequest_success)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        uint64_t begin = DynamicSchedMgr::GetInstance().DynamicSchedNow();
        halMbufGetBuffAddrFakeAddr = malloc(200);
        MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        rootModelInfo.responseQue.globalLogicId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::RequestInfo> requestInfos(1);
        DynamicSchedMgr::DstGroupInfo dstGroupInfo = {0U};
        requestInfos[0].dsts.emplace_back(dstGroupInfo);
        DynamicSchedMgr::DecisionInfo decisionInfo = {0, 0};
        requestInfos[0].decisions.emplace_back(decisionInfo);
        ret = DynamicSchedMgr::GetInstance().SendRequest(1U, requestInfos);
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;
        DynamicSchedMgr::GetInstance().DynamicSchedDurationEnd(begin);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        DynamicSchedMgr::GetInstance().DeleteQueue(1U, 1U);
    }

    TEST_F(DynamicSchedMgrUTest, SendRequest_fail)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        uint64_t begin = DynamicSchedMgr::GetInstance().DynamicSchedNow();
        halMbufGetBuffAddrFakeAddr = malloc(200);
        MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        rootModelInfo.responseQue.globalLogicId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::RequestInfo> requestInfos(1);
        DynamicSchedMgr::DstGroupInfo dstGroupInfo = {0U};
        requestInfos[0].dsts.emplace_back(dstGroupInfo);
        DynamicSchedMgr::DecisionInfo decisionInfo = {0, 0};
        requestInfos[0].decisions.emplace_back(decisionInfo);
        ret = DynamicSchedMgr::GetInstance().SendRequest(2U, requestInfos);
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;
        DynamicSchedMgr::GetInstance().DynamicSchedDurationEnd(begin);
        EXPECT_EQ(ret, FsmStatus::FSM_FAILED);
        DynamicSchedMgr::GetInstance().DeleteQueue(1U, 1U);
    }

    TEST_F(DynamicSchedMgrUTest, GetReponse_NotFind)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::ResponseInfo> responses;
        ret = DynamicSchedMgr::GetInstance().GetResponse(2U, responses);
    }

    TEST_F(DynamicSchedMgrUTest, GetReponse_fail01)
    {
        MOCKER(halMbufGetBuffAddr).stubs().will(returnValue(1));
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::GetInstance().requestSentNum_ = 1;
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::ResponseInfo> responses;
        ret = DynamicSchedMgr::GetInstance().GetResponse(1U, responses);
        EXPECT_EQ(ret, FsmStatus::FSM_FAILED);
    }

    TEST_F(DynamicSchedMgrUTest, GetReponse_fail02)
    {
        MOCKER(halQueueDeQueue).stubs().will(returnValue(2));
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::GetInstance().requestSentNum_ = 1;
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::ResponseInfo> responses;
        ret = DynamicSchedMgr::GetInstance().GetResponse(1U, responses);
        EXPECT_EQ(ret, FsmStatus::FSM_FAILED);
    }

    TEST_F(DynamicSchedMgrUTest, SendRequest_cache_success)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        uint64_t begin = DynamicSchedMgr::GetInstance().DynamicSchedNow();
        halMbufGetBuffAddrFakeAddr = malloc(200);
        MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        rootModelInfo.responseQue.globalLogicId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::RequestInfo> requestInfos(1);
        DynamicSchedMgr::DstGroupInfo dstGroupInfo = {0U};
        requestInfos[0].dsts.emplace_back(dstGroupInfo);
        DynamicSchedMgr::DecisionInfo decisionInfo = {0, 0};
        requestInfos[0].decisions.emplace_back(decisionInfo);
        for (auto i = 0; i <= kRequestCacheNum; i++) {
            ret = DynamicSchedMgr::GetInstance().SendRequest(1U, requestInfos);
        }
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;
        DynamicSchedMgr::GetInstance().DynamicSchedDurationEnd(begin);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        DynamicSchedMgr::GetInstance().DeleteQueue(1U, 1U);
    }

    TEST_F(DynamicSchedMgrUTest, GetReponse_cache_success)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        halMbufGetBuffAddrFakeAddr = malloc(200);
        MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        rootModelInfo.responseQue.globalLogicId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::RequestInfo> requestInfos(1);
        DynamicSchedMgr::DstGroupInfo dstGroupInfo = {0U};
        requestInfos[0].dsts.emplace_back(dstGroupInfo);
        DynamicSchedMgr::DecisionInfo decisionInfo = {0, 0};
        requestInfos[0].decisions.emplace_back(decisionInfo);
        DynamicSchedMgr::GetInstance().requestSentNum_ = kRequestCacheNum + 1;
        ret = DynamicSchedMgr::GetInstance().SendRequest(1U, requestInfos);
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        DynamicSchedMgr::GetInstance().requestSentNum_ = 0;
        std::vector<DynamicSchedMgr::ResponseInfo> responses;
        ret = DynamicSchedMgr::GetInstance().GetResponse(1U, responses);
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().DeleteQueue(1U, 1U);
    }
}
