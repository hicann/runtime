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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "proto/dynamic_sched_message.pb.h"

#define private public
#include "dynamic_sched/dynamic_sched_mgr.hpp"
#undef private

namespace dgw {
namespace {
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

    class DynamicSchedMgrSTest : public testing::Test {
    protected:
        virtual void SetUp()
        {
        }

        virtual void TearDown()
        {
            GlobalMockObject::verify();
        }
    };

    TEST_F(DynamicSchedMgrSTest, AddRootModelInfo_success)
    {
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
    }

    TEST_F(DynamicSchedMgrSTest, AddRootModelInfo_fail)
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

    TEST_F(DynamicSchedMgrSTest, SendRequest_success)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        uint64_t begin = DynamicSchedMgr::GetInstance().DynamicSchedNow();
        halMbufGetBuffAddrFakeAddr = malloc(200);
        MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
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
    }

    TEST_F(DynamicSchedMgrSTest, SendRequest_fail)
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

    TEST_F(DynamicSchedMgrSTest, GetReponse_success)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::ResponseInfo> responses;
        ret = DynamicSchedMgr::GetInstance().GetResponse(1U, responses);
    }

    TEST_F(DynamicSchedMgrSTest, GetReponse_NotFind)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        std::vector<DynamicSchedMgr::ResponseInfo> responses;
        ret = DynamicSchedMgr::GetInstance().GetResponse(2U, responses);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
    }

    TEST_F(DynamicSchedMgrSTest, GetReponse_fail01)
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

    TEST_F(DynamicSchedMgrSTest, GetReponse_fail02)
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

    TEST_F(DynamicSchedMgrSTest, Cache_result_success)
    {
        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
        DynamicSchedMgr::GetInstance().invalidCacheInfos_.clear();
        DynamicSchedMgr::GetInstance().validCacheInfos_.clear();
        DynamicSchedMgr::GetInstance().UpdateNodeId(0);
        DynamicSchedMgr::RootModelInfo rootModelInfo;
        rootModelInfo.rootModelId = 1U;
        rootModelInfo.responseQue.globalLogicId = 1U;
        auto ret = DynamicSchedMgr::GetInstance().AddRootModelInfo(rootModelInfo);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);

        halMbufGetBuffAddrFakeAddr = malloc(200);
        MOCKER(halMbufGetBuffAddr).stubs().will(invoke(halMbufGetBuffAddrFake));
        MOCKER(halMbufGetBuffSize).stubs().will(invoke(halMbufGetBuffSizeFake));

        // send request first
        std::vector<DynamicSchedMgr::RequestInfo> requestInfos(1);
        DynamicSchedMgr::DstGroupInfo dstGroupInfo = {0U};
        requestInfos[0].dsts.emplace_back(dstGroupInfo);
        DynamicSchedMgr::DecisionInfo decisionInfo = {0, 0};
        requestInfos[0].decisions.emplace_back(decisionInfo);
        ret = DynamicSchedMgr::GetInstance().SendRequest(1U, requestInfos);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        const auto &invalidCacheInfos = DynamicSchedMgr::GetInstance().invalidCacheInfos_;
        DynamicSchedMgr::CacheRouteKey cacheRouteKey= {requestInfos[0].src, requestInfos[0].dsts[0]};
        auto iterInvalid = invalidCacheInfos.find(cacheRouteKey);
        bool findRetInvalid = (iterInvalid != invalidCacheInfos.end());
        EXPECT_EQ(findRetInvalid, true);
        EXPECT_EQ(iterInvalid->second, 1);
        const auto &validCacheInfos = DynamicSchedMgr::GetInstance().validCacheInfos_;
        auto iterValid = validCacheInfos.find(cacheRouteKey);
        bool findRetValid = (iterValid != validCacheInfos.end());
        EXPECT_EQ(findRetValid, false);
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;

        // get response with cache
        dynamic::FlowgwResponse flowgwResponse;
        auto queueInfosRsp = flowgwResponse.add_queue_infos();
        auto queueAttrs = queueInfosRsp->mutable_queue_attrs();
        queueAttrs->set_logic_id(requestInfos[0].src.queueLogicId);
        queueInfosRsp->set_logic_group_id(requestInfos[0].dsts[0].logicGroupId);
        queueInfosRsp->set_root_model_id(requestInfos[0].src.rootModelId);
        queueInfosRsp->set_need_cache(true);
        halMbufGetBuffSizeFakeSize = flowgwResponse.ByteSizeLong();
        halMbufGetBuffAddrFakeAddr = malloc(halMbufGetBuffSizeFakeSize); 
        flowgwResponse.SerializeToArray(halMbufGetBuffAddrFakeAddr,
                                        static_cast<int32_t>(halMbufGetBuffSizeFakeSize));
        std::vector<DynamicSchedMgr::ResponseInfo> responses;
        ret = DynamicSchedMgr::GetInstance().GetResponse(1U, responses);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        iterInvalid = invalidCacheInfos.find(cacheRouteKey);
        findRetInvalid = (iterInvalid != invalidCacheInfos.end());
        EXPECT_EQ(findRetInvalid, false);
        iterValid = validCacheInfos.find(cacheRouteKey);
        findRetValid = (iterValid != validCacheInfos.end());
        EXPECT_EQ(findRetValid, true);
        EXPECT_EQ(iterValid->second.num, 0U);
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;
        halMbufGetBuffSizeFakeSize = 0U;

        // send request second
        halMbufGetBuffAddrFakeAddr = malloc(200);
        ret = DynamicSchedMgr::GetInstance().SendRequest(1U, requestInfos);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        iterInvalid = invalidCacheInfos.find(cacheRouteKey);
        findRetInvalid = (iterInvalid != invalidCacheInfos.end());
        EXPECT_EQ(findRetInvalid, false);
        iterValid = validCacheInfos.find(cacheRouteKey);
        findRetValid = (iterValid != validCacheInfos.end());
        EXPECT_EQ(findRetValid, true);
        EXPECT_EQ(iterValid->second.num, 1U);
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;

        // send request third
        halMbufGetBuffAddrFakeAddr = malloc(200);
        ret = DynamicSchedMgr::GetInstance().SendRequest(1U, requestInfos);
        EXPECT_EQ(ret, FsmStatus::FSM_SUCCESS);
        iterInvalid = invalidCacheInfos.find(cacheRouteKey);
        findRetInvalid = (iterInvalid != invalidCacheInfos.end());
        EXPECT_EQ(findRetInvalid, false);
        iterValid = validCacheInfos.find(cacheRouteKey);
        findRetValid = (iterValid != validCacheInfos.end());
        EXPECT_EQ(findRetValid, true);
        EXPECT_EQ(iterValid->second.num, 2U);
        free(halMbufGetBuffAddrFakeAddr);
        halMbufGetBuffAddrFakeAddr = nullptr;

        DynamicSchedMgr::GetInstance().rootModelInfos_.clear();
    }
}
