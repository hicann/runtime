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

#include "api_device_topology.hpp"

using namespace cce::runtime;
using namespace testing;

namespace {
class ApiDeviceTopologyRouteStub : public ApiDeviceTopology {
public:
    rtError_t EnableP2P(const uint32_t, const uint32_t, const uint32_t) override { return Record(); }

    rtError_t DisableP2P(const uint32_t, const uint32_t) override { return Record(); }

    rtError_t DeviceCanAccessPeer(int32_t* const canAccessPeer, const uint32_t, const uint32_t) override
    {
        *canAccessPeer = 1;
        return Record();
    }

    rtError_t GetP2PStatus(const uint32_t, const uint32_t, uint32_t* const status) override
    {
        *status = 1U;
        return Record();
    }

    rtError_t GetPairDevicesInfo(const uint32_t, const uint32_t, const int32_t, int64_t* const val) override
    {
        *val = 2;
        return Record();
    }

    rtError_t GetPairPhyDevicesInfo(const uint32_t, const uint32_t, const int32_t, int64_t* const val) override
    {
        *val = 3;
        return Record();
    }

    rtError_t GetDeviceCount(int32_t* const cnt) override
    {
        *cnt = 4;
        return Record();
    }

    rtError_t GetDevicePhyIdByIndex(const uint32_t, uint32_t* const phyId) override
    {
        *phyId = 5U;
        return Record();
    }

    rtError_t GetDeviceIndexByPhyId(const uint32_t, uint32_t* const devIndex) override
    {
        *devIndex = 6U;
        return Record();
    }

    rtError_t GetLogicDevIdByUserDevId(const int32_t, int32_t* const logicDevId) override
    {
        *logicDevId = 7;
        return Record();
    }

    rtError_t GetUserDevIdByLogicDevId(const int32_t, int32_t* const userDevId) override
    {
        *userDevId = 8;
        return Record();
    }

    rtError_t GetDeviceUuid(const int32_t, rtUuid_t* const) override { return Record(); }

    rtError_t GetDevicePCIBusId(const int32_t, char* const, const int32_t) override { return Record(); }

    rtError_t GetDeviceByPCIBusId(const char* const, int32_t* const devId) override
    {
        *devId = 9;
        return Record();
    }

    rtError_t GetHostAtomicCapabilities(
        uint32_t* const, const rtAtomicOperation* const, const uint32_t, const int32_t) override
    {
        return Record();
    }

    rtError_t GetP2PAtomicCapabilities(
        uint32_t* const, const rtAtomicOperation* const, const uint32_t, const int32_t, const int32_t) override
    {
        return Record();
    }

    rtError_t Record()
    {
        ++callCount_;
        return ret_;
    }

    uint32_t callCount_ = 0U;
    rtError_t ret_ = RT_ERROR_NONE;
};

class ApiDeviceTopologyRouteTest : public Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApiDeviceTopology_ = runtime_->apiDeviceTopology_;
        runtime_->apiDeviceTopology_ = &apiDeviceTopology_;
    }

    void TearDown() override
    {
        runtime_->apiDeviceTopology_ = oldApiDeviceTopology_;
        GlobalMockObject::verify();
    }

    void ExpectRoute(const rtError_t actual)
    {
        EXPECT_EQ(actual, ACL_RT_SUCCESS);
        EXPECT_EQ(apiDeviceTopology_.callCount_, ++expectedCallCount_);
    }

    Runtime* runtime_ = nullptr;
    ApiDeviceTopology* oldApiDeviceTopology_ = nullptr;
    ApiDeviceTopologyRouteStub apiDeviceTopology_;
    uint32_t expectedCallCount_ = 0U;
};
} // namespace

TEST_F(ApiDeviceTopologyRouteTest, RoutesAllApisToApiDeviceTopology)
{
    int32_t intValue = 0;
    uint32_t uintValue = 0U;
    uint64_t uint64Value = 0U;
    int64_t int64Value = 0;
    char pciBusId[RT_PCI_BUS_ID_MIN_LEN] = {};
    rtUuid_t uuid = {};
    uint32_t capabilities[1] = {};
    const rtAtomicOperation operations[1] = {RT_ATOMIC_OPERATION_INTEGER_ADD};

    ExpectRoute(rtGetDeviceCount(&intValue));
    ExpectRoute(rtsGetDeviceCount(&intValue));
    ExpectRoute(rtGetDevicePhyIdByIndex(0U, &uintValue));
    ExpectRoute(rtsGetPhyDevIdByLogicDevId(0, &intValue));
    ExpectRoute(rtGetDeviceIndexByPhyId(0U, &uintValue));
    ExpectRoute(rtsGetLogicDevIdByPhyDevId(0, &intValue));
    ExpectRoute(rtGetLogicDevIdByUserDevId(0, &intValue));
    ExpectRoute(rtsGetLogicDevIdByUserDevId(0, &intValue));
    ExpectRoute(rtGetUserDevIdByLogicDevId(0, &intValue));
    ExpectRoute(rtsGetUserDevIdByLogicDevId(0, &intValue));
    ExpectRoute(rtEnableP2P(0U, 1U, 0U));
    ExpectRoute(rtsEnableP2P(0U, 1U, 0U));
    ExpectRoute(rtDisableP2P(0U, 1U));
    ExpectRoute(rtsDisableP2P(0U, 1U));
    ExpectRoute(rtDeviceCanAccessPeer(&intValue, 0U, 1U));
    ExpectRoute(rtsDeviceCanAccessPeer(0U, 1U, &intValue));
    ExpectRoute(rtGetP2PStatus(0U, 1U, &uintValue));
    ExpectRoute(rtsGetP2PStatus(0U, 1U, &uintValue));
    ExpectRoute(rtGetPairDevicesInfo(0U, 1U, 0, &int64Value));
    ExpectRoute(rtsGetPairDevicesInfo(0U, 1U, 0, &uint64Value));
    EXPECT_EQ(uint64Value, 4U);
    ExpectRoute(rtGetPairPhyDevicesInfo(0U, 1U, 0, &int64Value));
    ExpectRoute(rtGetDeviceUuid(0, &uuid));
    ExpectRoute(rtDeviceGetHostAtomicCapabilities(capabilities, operations, 1U, 0));
    ExpectRoute(rtDeviceGetP2PAtomicCapabilities(capabilities, operations, 1U, 0, 1));
    ExpectRoute(rtDeviceGetPCIBusId(0, pciBusId, sizeof(pciBusId)));
    ExpectRoute(rtDeviceGetByPCIBusId(pciBusId, &intValue));
    EXPECT_EQ(apiDeviceTopology_.callCount_, 26U);
}

TEST_F(ApiDeviceTopologyRouteTest, PreservesCompatibilityValidationAndSpecialErrors)
{
    int32_t deviceId = 0;
    EXPECT_EQ(rtsGetLogicDevIdByPhyDevId(-1, &deviceId), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtsGetPhyDevIdByLogicDevId(-1, &deviceId), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtsGetLogicDevIdByUserDevId(-1, &deviceId), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(rtsGetUserDevIdByLogicDevId(-1, &deviceId), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(apiDeviceTopology_.callCount_, 0U);

    apiDeviceTopology_.ret_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    rtUuid_t uuid = {};
    char pciBusId[RT_PCI_BUS_ID_MIN_LEN] = {};
    EXPECT_EQ(rtGetDeviceUuid(0, &uuid), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetPCIBusId(0, pciBusId, sizeof(pciBusId)), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(rtDeviceGetByPCIBusId(pciBusId, &deviceId), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(ApiDeviceTopologyRouteTest, ReturnsInternalErrorWhenApiDeviceTopologyMissing)
{
    runtime_->apiDeviceTopology_ = nullptr;
    int32_t count = 0;
    EXPECT_EQ(rtGetDeviceCount(&count), ACL_ERROR_RT_INTERNAL_ERROR);
}
