/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "api_impl_creator.hpp"
#include "npu_driver.hpp"
#include "rt_error_codes.h"
#include "runtime/rt_external_mem.h"

using namespace cce::runtime;

TEST(ApiEschedStubTest, EschedImplLifecycleNotSupport)
{
    EXPECT_FALSE(IsImplEschedSupported());
    ApiEsched* apiImplEsched = CreateImplEschedAndGet();
    EXPECT_EQ(apiImplEsched, nullptr);

    DestroyImplEsched(apiImplEsched);

    EXPECT_EQ(apiImplEsched, nullptr);
}

TEST(ApiEschedStubTest, EschedApisNotSupport)
{
    EXPECT_EQ(rtEschedSubmitEventSync(0, nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedAttachDevice(0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedDettachDevice(0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedWaitEvent(0, 0U, 0U, 0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedCreateGrp(0, 0U, RT_GRP_TYPE_BIND_DP_CPU), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedSubmitEvent(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedSubscribeEvent(0, 0U, 0U, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedAckEvent(0, RT_EVENT_RANDOM_KERNEL, 0U, nullptr, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEschedQueryInfo(0U, RT_QUERY_TYPE_LOCAL_GRP_ID, nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST(ApiEschedStubTest, NpuDriverEschedStubsNotSupport)
{
    rtEschedEventSummary_t evt = {};
    rtEschedEventReply_t ack = {};
    rtEschedInputInfo input = {};
    rtEschedOutputInfo output = {};
    char msg[] = "msg";
    uint32_t grpId = 0U;

    EXPECT_EQ(NpuDriver::EschedSubmitEventSync(0, &evt, &ack), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedAttachDevice(0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedDettachDevice(0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedWaitEvent(0, 0U, 0U, 0, &evt), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedCreateGrp(0, 0U, RT_GRP_TYPE_BIND_DP_CPU), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedSubmitEvent(0, &evt), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedSubscribeEvent(0, 0U, 0U, 0U), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedAckEvent(0, RT_EVENT_RANDOM_KERNEL, 0U, msg, sizeof(msg)), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::EschedCreateGrpEx(0U, 1U, &grpId), RT_ERROR_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(NpuDriver::DrvEschedManage(0U, 0, 0U, 0U, nullptr), DRV_ERROR_NOT_SUPPORT);
    EXPECT_EQ(
        NpuDriver::EschedQueryInfo(0U, RT_QUERY_TYPE_LOCAL_GRP_ID, &input, &output), RT_ERROR_FEATURE_NOT_SUPPORT);
}
