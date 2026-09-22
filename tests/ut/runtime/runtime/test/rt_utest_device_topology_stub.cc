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
#include "rt_error_codes.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"

using namespace cce::runtime;

TEST(ApiDeviceTopologyStubTest, DeviceTopologyImplLifecycleNotSupport)
{
    EXPECT_FALSE(IsImplDeviceTopologySupported());
    ApiDeviceTopology* apiImplDeviceTopology = CreateImplDeviceTopologyAndGet();
    EXPECT_EQ(apiImplDeviceTopology, nullptr);

    DestroyImplDeviceTopology(apiImplDeviceTopology);

    EXPECT_EQ(apiImplDeviceTopology, nullptr);
}

TEST(ApiDeviceTopologyStubTest, DeviceTopologyApisNotSupport)
{
    EXPECT_EQ(rtGetDeviceCount(nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetDeviceCount(nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetDevicePhyIdByIndex(0U, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetDeviceIndexByPhyId(0U, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetLogicDevIdByPhyDevId(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetPhyDevIdByLogicDevId(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetLogicDevIdByUserDevId(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetLogicDevIdByUserDevId(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetUserDevIdByLogicDevId(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetUserDevIdByLogicDevId(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtEnableP2P(0U, 0U, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsEnableP2P(0U, 0U, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDisableP2P(0U, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsDisableP2P(0U, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceCanAccessPeer(nullptr, 0U, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsDeviceCanAccessPeer(0U, 0U, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetP2PStatus(0U, 0U, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetP2PStatus(0U, 0U, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetPairDevicesInfo(0U, 0U, 0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtsGetPairDevicesInfo(0U, 0U, 0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetPairPhyDevicesInfo(0U, 0U, 0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtGetDeviceUuid(0, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetHostAtomicCapabilities(nullptr, nullptr, 0U, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetP2PAtomicCapabilities(nullptr, nullptr, 0U, 0, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetPCIBusId(0, nullptr, 0), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetByPCIBusId(nullptr, nullptr), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}
