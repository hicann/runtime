/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_api.hpp"

#include "api_esched.hpp"

using namespace cce::runtime;
using namespace testing;

namespace {
constexpr uint32_t kReplyLen = 16U;
constexpr rtChipType_t kSupportEschedQueryInfoChip = CHIP_910_B_93;
constexpr rtChipType_t kUnsupportedEschedQueryInfoChip = CHIP_CLOUD;

class ApiEschedRouteStub : public ApiEsched {
public:
    rtError_t EschedSubmitEventSync(
        const int32_t devId, rtEschedEventSummary_t* const evt, rtEschedEventReply_t* const ack) override
    {
        ++submitEventSyncCount_;
        submitEventSyncDevId_ = devId;
        submitEventSyncEvt_ = evt;
        submitEventSyncAck_ = ack;
        if (ack != nullptr) {
            ack->replyLen = kReplyLen;
        }
        return submitEventSyncRet_;
    }

    rtError_t EschedAttachDevice(const uint32_t devId) override
    {
        ++attachDeviceCount_;
        attachDeviceDevId_ = devId;
        return attachDeviceRet_;
    }

    rtError_t EschedDettachDevice(const uint32_t devId) override
    {
        ++dettachDeviceCount_;
        dettachDeviceDevId_ = devId;
        return dettachDeviceRet_;
    }

    rtError_t EschedWaitEvent(
        const int32_t devId, const uint32_t grpId, const uint32_t threadId, const int32_t timeout,
        rtEschedEventSummary_t* const evt) override
    {
        ++waitEventCount_;
        waitEventDevId_ = devId;
        waitEventGrpId_ = grpId;
        waitEventThreadId_ = threadId;
        waitEventTimeout_ = timeout;
        waitEventEvt_ = evt;
        return waitEventRet_;
    }

    rtError_t EschedCreateGrp(const int32_t devId, const uint32_t grpId, const rtGroupType_t type) override
    {
        ++createGrpCount_;
        createGrpDevId_ = devId;
        createGrpId_ = grpId;
        createGrpType_ = type;
        return createGrpRet_;
    }

    rtError_t EschedSubmitEvent(const int32_t devId, rtEschedEventSummary_t* const evt) override
    {
        ++submitEventCount_;
        submitEventDevId_ = devId;
        submitEventEvt_ = evt;
        return submitEventRet_;
    }

    rtError_t EschedSubscribeEvent(
        const int32_t devId, const uint32_t grpId, const uint32_t threadId, const uint64_t eventBitmap) override
    {
        ++subscribeEventCount_;
        subscribeEventDevId_ = devId;
        subscribeEventGrpId_ = grpId;
        subscribeEventThreadId_ = threadId;
        subscribeEventBitmap_ = eventBitmap;
        return subscribeEventRet_;
    }

    rtError_t EschedAckEvent(
        const int32_t devId, const rtEventIdType_t evtId, const uint32_t subeventId, char_t* const msg,
        const uint32_t len) override
    {
        ++ackEventCount_;
        ackEventDevId_ = devId;
        ackEventId_ = evtId;
        ackEventSubEvtId_ = subeventId;
        ackEventMsg_ = msg;
        ackEventLen_ = len;
        return ackEventRet_;
    }

    rtError_t EschedQueryInfo(
        const uint32_t devId, const rtEschedQueryType type, rtEschedInputInfo* const inPut,
        rtEschedOutputInfo* const outPut) override
    {
        ++queryInfoCount_;
        queryInfoDevId_ = devId;
        queryInfoType_ = type;
        queryInfoInput_ = inPut;
        queryInfoOutput_ = outPut;
        return queryInfoRet_;
    }

    uint32_t submitEventSyncCount_ = 0U;
    uint32_t attachDeviceCount_ = 0U;
    uint32_t dettachDeviceCount_ = 0U;
    uint32_t waitEventCount_ = 0U;
    uint32_t createGrpCount_ = 0U;
    uint32_t submitEventCount_ = 0U;
    uint32_t subscribeEventCount_ = 0U;
    uint32_t ackEventCount_ = 0U;
    uint32_t queryInfoCount_ = 0U;

    int32_t submitEventSyncDevId_ = 0;
    uint32_t attachDeviceDevId_ = 0U;
    uint32_t dettachDeviceDevId_ = 0U;
    int32_t waitEventDevId_ = 0;
    uint32_t waitEventGrpId_ = 0U;
    uint32_t waitEventThreadId_ = 0U;
    int32_t waitEventTimeout_ = 0;
    int32_t createGrpDevId_ = 0;
    uint32_t createGrpId_ = 0U;
    rtGroupType_t createGrpType_ = RT_GRP_TYPE_BIND_DP_CPU;
    int32_t submitEventDevId_ = 0;
    int32_t subscribeEventDevId_ = 0;
    uint32_t subscribeEventGrpId_ = 0U;
    uint32_t subscribeEventThreadId_ = 0U;
    uint64_t subscribeEventBitmap_ = 0U;
    int32_t ackEventDevId_ = 0;
    rtEventIdType_t ackEventId_ = RT_EVENT_TEST;
    uint32_t ackEventSubEvtId_ = 0U;
    uint32_t ackEventLen_ = 0U;
    uint32_t queryInfoDevId_ = 0U;
    rtEschedQueryType queryInfoType_ = RT_QUERY_TYPE_LOCAL_GRP_ID;

    rtEschedEventSummary_t* submitEventSyncEvt_ = nullptr;
    rtEschedEventReply_t* submitEventSyncAck_ = nullptr;
    rtEschedEventSummary_t* waitEventEvt_ = nullptr;
    rtEschedEventSummary_t* submitEventEvt_ = nullptr;
    char_t* ackEventMsg_ = nullptr;
    rtEschedInputInfo* queryInfoInput_ = nullptr;
    rtEschedOutputInfo* queryInfoOutput_ = nullptr;

    rtError_t submitEventSyncRet_ = RT_ERROR_NONE;
    rtError_t attachDeviceRet_ = RT_ERROR_NONE;
    rtError_t dettachDeviceRet_ = RT_ERROR_NONE;
    rtError_t waitEventRet_ = RT_ERROR_NONE;
    rtError_t createGrpRet_ = RT_ERROR_NONE;
    rtError_t submitEventRet_ = RT_ERROR_NONE;
    rtError_t subscribeEventRet_ = RT_ERROR_NONE;
    rtError_t ackEventRet_ = RT_ERROR_NONE;
    rtError_t queryInfoRet_ = RT_ERROR_NONE;
};

class ApiEschedRouteTest : public Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApiEsched_ = runtime_->apiEsched_;
        oldRuntimeChipType_ = runtime_->chipType_;
        oldGlobalChipType_ = GlobalContainer::GetRtChipType();
        runtime_->apiEsched_ = &apiEsched_;
        SetChipType(kSupportEschedQueryInfoChip);
    }

    void TearDown() override
    {
        runtime_->apiEsched_ = oldApiEsched_;
        runtime_->SetChipType(oldRuntimeChipType_);
        GlobalContainer::SetRtChipType(oldGlobalChipType_);
        GlobalMockObject::verify();
    }

    void SetChipType(const rtChipType_t chipType)
    {
        runtime_->SetChipType(chipType);
        GlobalContainer::SetRtChipType(chipType);
    }

    Runtime* runtime_ = nullptr;
    ApiEsched* oldApiEsched_ = nullptr;
    rtChipType_t oldRuntimeChipType_ = CHIP_BEGIN;
    rtChipType_t oldGlobalChipType_ = CHIP_BEGIN;
    ApiEschedRouteStub apiEsched_;
};
} // namespace

TEST_F(ApiEschedRouteTest, RoutesAllApisToApiEsched)
{
    constexpr int32_t devId = 3;
    constexpr uint32_t grpId = 5U;
    constexpr uint32_t threadId = 7U;
    constexpr int32_t timeout = 11;
    constexpr uint64_t eventBitmap = 0x55U;
    constexpr uint32_t subeventId = 13U;
    rtEschedEventSummary_t evt = {};
    rtEschedEventReply_t ack = {};
    rtEschedInputInfo input = {};
    rtEschedOutputInfo output = {};
    char_t msg[] = "ok";

    EXPECT_EQ(rtEschedSubmitEventSync(devId, &evt, &ack), ACL_RT_SUCCESS);
    EXPECT_EQ(rtEschedAttachDevice(devId), ACL_RT_SUCCESS);
    EXPECT_EQ(rtEschedDettachDevice(devId), ACL_RT_SUCCESS);
    EXPECT_EQ(rtEschedWaitEvent(devId, grpId, threadId, timeout, &evt), ACL_RT_SUCCESS);
    EXPECT_EQ(rtEschedCreateGrp(devId, grpId, RT_GRP_TYPE_BIND_DP_CPU_EXCLUSIVE), ACL_RT_SUCCESS);
    EXPECT_EQ(rtEschedSubmitEvent(devId, &evt), ACL_RT_SUCCESS);
    EXPECT_EQ(rtEschedSubscribeEvent(devId, grpId, threadId, eventBitmap), ACL_RT_SUCCESS);
    EXPECT_EQ(rtEschedAckEvent(devId, RT_EVENT_TEST, subeventId, msg, sizeof(msg)), ACL_RT_SUCCESS);
    EXPECT_EQ(
        rtEschedQueryInfo(static_cast<uint32_t>(devId), RT_QUERY_TYPE_LOCAL_GRP_ID, &input, &output), ACL_RT_SUCCESS);

    EXPECT_EQ(apiEsched_.submitEventSyncCount_, 1U);
    EXPECT_EQ(apiEsched_.submitEventSyncDevId_, devId);
    EXPECT_EQ(apiEsched_.submitEventSyncEvt_, &evt);
    EXPECT_EQ(apiEsched_.submitEventSyncAck_, &ack);
    EXPECT_EQ(ack.replyLen, kReplyLen);
    EXPECT_EQ(apiEsched_.attachDeviceCount_, 1U);
    EXPECT_EQ(apiEsched_.attachDeviceDevId_, static_cast<uint32_t>(devId));
    EXPECT_EQ(apiEsched_.dettachDeviceCount_, 1U);
    EXPECT_EQ(apiEsched_.dettachDeviceDevId_, static_cast<uint32_t>(devId));
    EXPECT_EQ(apiEsched_.waitEventCount_, 1U);
    EXPECT_EQ(apiEsched_.waitEventDevId_, devId);
    EXPECT_EQ(apiEsched_.waitEventGrpId_, grpId);
    EXPECT_EQ(apiEsched_.waitEventThreadId_, threadId);
    EXPECT_EQ(apiEsched_.waitEventTimeout_, timeout);
    EXPECT_EQ(apiEsched_.waitEventEvt_, &evt);
    EXPECT_EQ(apiEsched_.createGrpCount_, 1U);
    EXPECT_EQ(apiEsched_.createGrpDevId_, devId);
    EXPECT_EQ(apiEsched_.createGrpId_, grpId);
    EXPECT_EQ(apiEsched_.createGrpType_, RT_GRP_TYPE_BIND_DP_CPU_EXCLUSIVE);
    EXPECT_EQ(apiEsched_.submitEventCount_, 1U);
    EXPECT_EQ(apiEsched_.submitEventDevId_, devId);
    EXPECT_EQ(apiEsched_.submitEventEvt_, &evt);
    EXPECT_EQ(apiEsched_.subscribeEventCount_, 1U);
    EXPECT_EQ(apiEsched_.subscribeEventDevId_, devId);
    EXPECT_EQ(apiEsched_.subscribeEventGrpId_, grpId);
    EXPECT_EQ(apiEsched_.subscribeEventThreadId_, threadId);
    EXPECT_EQ(apiEsched_.subscribeEventBitmap_, eventBitmap);
    EXPECT_EQ(apiEsched_.ackEventCount_, 1U);
    EXPECT_EQ(apiEsched_.ackEventDevId_, devId);
    EXPECT_EQ(apiEsched_.ackEventId_, RT_EVENT_TEST);
    EXPECT_EQ(apiEsched_.ackEventSubEvtId_, subeventId);
    EXPECT_EQ(apiEsched_.ackEventMsg_, msg);
    EXPECT_EQ(apiEsched_.ackEventLen_, sizeof(msg));
    EXPECT_EQ(apiEsched_.queryInfoCount_, 1U);
    EXPECT_EQ(apiEsched_.queryInfoDevId_, static_cast<uint32_t>(devId));
    EXPECT_EQ(apiEsched_.queryInfoType_, RT_QUERY_TYPE_LOCAL_GRP_ID);
    EXPECT_EQ(apiEsched_.queryInfoInput_, &input);
    EXPECT_EQ(apiEsched_.queryInfoOutput_, &output);
}

TEST_F(ApiEschedRouteTest, MapsSpecialErrors)
{
    rtEschedEventSummary_t evt = {};
    rtEschedEventReply_t ack = {};

    apiEsched_.submitEventSyncRet_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(rtEschedSubmitEventSync(0, &evt, &ack), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiEsched_.submitEventSyncCount_, 1U);

    apiEsched_.waitEventRet_ = RT_ERROR_REPORT_TIMEOUT;
    EXPECT_EQ(rtEschedWaitEvent(0, 0U, 0U, 0, &evt), ACL_ERROR_RT_REPORT_TIMEOUT);
    EXPECT_EQ(apiEsched_.waitEventCount_, 1U);
}

TEST_F(ApiEschedRouteTest, QueryInfoReturnsNotSupportWhenChipFeatureUnsupported)
{
    rtEschedInputInfo input = {};
    rtEschedOutputInfo output = {};

    SetChipType(kUnsupportedEschedQueryInfoChip);

    EXPECT_EQ(rtEschedQueryInfo(0U, RT_QUERY_TYPE_LOCAL_GRP_ID, &input, &output), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiEsched_.queryInfoCount_, 0U);
}

TEST_F(ApiEschedRouteTest, ReturnsInternalErrorWhenApiEschedMissing)
{
    runtime_->apiEsched_ = nullptr;
    EXPECT_EQ(rtEschedAttachDevice(0), ACL_ERROR_RT_INTERNAL_ERROR);
}
