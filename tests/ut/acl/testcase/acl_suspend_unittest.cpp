/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <algorithm>
#include <cstdint>
#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include "acl/acl.h"
#include "acl/error_codes/rt_error_codes.h"
#include "acl_rt_impl_base.h"
#include "acl_stub.h"

namespace {
using namespace testing;
constexpr int32_t DEVICE_ID = 1;
constexpr uint32_t MAX_INTERVAL = 1024U;

class AclSuspendTest : public Test {
protected:
    void SetUp() override
    {
        MockFunctionTest::aclStubInstance().ResetToDefaultMock();
        savedRefCount_ = acl::GetAclInitRefCount();
        acl::GetAclInitRefCount() = 1U;
    }
    void TearDown() override
    {
        acl::GetAclInitRefCount() = savedRefCount_;
        EXPECT_TRUE(Mock::VerifyAndClear(&MockFunctionTest::aclStubInstance()));
    }
    uint64_t savedRefCount_ = 0U;
};

TEST_F(AclSuspendTest, SetNullConfigDoesNotCallRuntime)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSetSuspendConfig(_, _)).Times(0);
    EXPECT_EQ(aclrtDeviceSetSuspendConfig(DEVICE_ID, nullptr), ACL_ERROR_INVALID_PARAM);
}

TEST_F(AclSuspendTest, GetNullConfigDoesNotCallRuntime)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceGetSuspendConfig(_, _)).Times(0);
    EXPECT_EQ(aclrtDeviceGetSuspendConfig(DEVICE_ID, nullptr), ACL_ERROR_INVALID_PARAM);
}

struct ConfigCase {
    aclrtDeviceSuspendMode mode;
    uint32_t interval;
    aclError expected;
};
class AclSuspendConfigTest : public AclSuspendTest, public WithParamInterface<ConfigCase> {};

TEST_P(AclSuspendConfigTest, ValidatesConfigBeforeForwardingAllFields)
{
    const auto param = GetParam();
    aclrtDeviceSuspendConfig config{};
    config.mode = param.mode;
    config.taskInterval = param.interval;
    auto& stub = MockFunctionTest::aclStubInstance();
    if (param.expected == ACL_SUCCESS) {
        EXPECT_CALL(stub, rtDeviceSetSuspendConfig(DEVICE_ID, NotNull()))
            .WillOnce(Invoke([param](int32_t, const rtDeviceSuspendConfig* actual) {
                EXPECT_EQ(actual->mode, static_cast<rtDeviceSuspendMode>(param.mode));
                EXPECT_EQ(actual->taskInterval, param.interval);
                for (const auto value : actual->reserved) {
                    EXPECT_EQ(value, 0U);
                }
                return RT_ERROR_NONE;
            }));
    } else {
        EXPECT_CALL(stub, rtDeviceSetSuspendConfig(_, _)).Times(0);
    }
    EXPECT_EQ(aclrtDeviceSetSuspendConfig(DEVICE_ID, &config), param.expected);
}

INSTANTIATE_TEST_SUITE_P(
    Boundaries, AclSuspendConfigTest,
    Values(
        ConfigCase{ACL_RT_DEVICE_SUSPEND_MODE_DISABLE, 0U, ACL_SUCCESS},
        ConfigCase{ACL_RT_DEVICE_SUSPEND_MODE_DEVICE, 0U, ACL_SUCCESS},
        ConfigCase{ACL_RT_DEVICE_SUSPEND_MODE_DEVICE, 1U, ACL_SUCCESS},
        ConfigCase{ACL_RT_DEVICE_SUSPEND_MODE_DEVICE, MAX_INTERVAL, ACL_SUCCESS},
        ConfigCase{ACL_RT_DEVICE_SUSPEND_MODE_DEVICE, MAX_INTERVAL + 1U, ACL_ERROR_INVALID_PARAM},
        ConfigCase{static_cast<aclrtDeviceSuspendMode>(-1), 0U, ACL_ERROR_INVALID_PARAM},
        ConfigCase{static_cast<aclrtDeviceSuspendMode>(2), 0U, ACL_ERROR_INVALID_PARAM}));

class AclSuspendReservedTest : public AclSuspendTest, public WithParamInterface<size_t> {};
TEST_P(AclSuspendReservedTest, NonzeroReservedFieldDoesNotCallRuntime)
{
    aclrtDeviceSuspendConfig config{};
    ASSERT_LT(GetParam(), sizeof(config.reserved) / sizeof(config.reserved[0]));
    config.reserved[GetParam()] = 1U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSetSuspendConfig(_, _)).Times(0);
    EXPECT_EQ(aclrtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_INVALID_PARAM);
}
INSTANTIATE_TEST_SUITE_P(Fields, AclSuspendReservedTest, Range(size_t{0}, size_t{6}));

TEST_F(AclSuspendTest, GetCopiesConfigurationAndClearsReservedFields)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceGetSuspendConfig(DEVICE_ID, NotNull()))
        .WillOnce(Invoke([](int32_t, rtDeviceSuspendConfig* config) {
            config->mode = RT_DEVICE_SUSPEND_MODE_DEVICE;
            config->taskInterval = MAX_INTERVAL;
            return RT_ERROR_NONE;
        }));
    aclrtDeviceSuspendConfig config{};
    std::fill(std::begin(config.reserved), std::end(config.reserved), UINT32_MAX);
    EXPECT_EQ(aclrtDeviceGetSuspendConfig(DEVICE_ID, &config), ACL_SUCCESS);
    EXPECT_EQ(config.mode, ACL_RT_DEVICE_SUSPEND_MODE_DEVICE);
    EXPECT_EQ(config.taskInterval, MAX_INTERVAL);
    for (const auto value : config.reserved) {
        EXPECT_EQ(value, 0U);
    }
}

TEST_F(AclSuspendTest, FailedGetPreservesEveryOutputField)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceGetSuspendConfig(DEVICE_ID, NotNull()))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    aclrtDeviceSuspendConfig config{};
    config.mode = ACL_RT_DEVICE_SUSPEND_MODE_DEVICE;
    config.taskInterval = 17U;
    std::fill(std::begin(config.reserved), std::end(config.reserved), UINT32_MAX);
    EXPECT_EQ(aclrtDeviceGetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(config.mode, ACL_RT_DEVICE_SUSPEND_MODE_DEVICE);
    EXPECT_EQ(config.taskInterval, 17U);
    for (const auto value : config.reserved) {
        EXPECT_EQ(value, UINT32_MAX);
    }
}

TEST_F(AclSuspendTest, SetPropagatesRuntimeError)
{
    aclrtDeviceSuspendConfig config{};
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSetSuspendConfig(DEVICE_ID, NotNull()))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    EXPECT_EQ(aclrtDeviceSetSuspendConfig(DEVICE_ID, &config), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

struct ControlCase {
    bool resume;
    uint32_t flag;
    rtError_t runtimeResult;
    aclError expected;
};
class AclSuspendControlTest : public AclSuspendTest, public WithParamInterface<ControlCase> {};
TEST_P(AclSuspendControlTest, ValidatesFlagsAndPropagatesRuntimeResult)
{
    const auto param = GetParam();
    auto& stub = MockFunctionTest::aclStubInstance();
    if (param.resume) {
        EXPECT_CALL(stub, rtDeviceSuspendExecution(_, _)).Times(0);
        if (param.flag == 0U) {
            EXPECT_CALL(stub, rtDeviceResumeExecution(DEVICE_ID, 0U)).WillOnce(Return(param.runtimeResult));
        } else {
            EXPECT_CALL(stub, rtDeviceResumeExecution(_, _)).Times(0);
        }
        EXPECT_EQ(aclrtDeviceResumeExecution(DEVICE_ID, param.flag), param.expected);
    } else {
        EXPECT_CALL(stub, rtDeviceResumeExecution(_, _)).Times(0);
        if (param.flag == 0U) {
            EXPECT_CALL(stub, rtDeviceSuspendExecution(DEVICE_ID, 0U)).WillOnce(Return(param.runtimeResult));
        } else {
            EXPECT_CALL(stub, rtDeviceSuspendExecution(_, _)).Times(0);
        }
        EXPECT_EQ(aclrtDeviceSuspendExecution(DEVICE_ID, param.flag), param.expected);
    }
}
INSTANTIATE_TEST_SUITE_P(
    Controls, AclSuspendControlTest,
    Values(
        ControlCase{false, 0U, RT_ERROR_NONE, ACL_SUCCESS}, ControlCase{true, 0U, RT_ERROR_NONE, ACL_SUCCESS},
        ControlCase{false, 1U, RT_ERROR_NONE, ACL_ERROR_INVALID_PARAM},
        ControlCase{true, UINT32_MAX, RT_ERROR_NONE, ACL_ERROR_INVALID_PARAM},
        ControlCase{false, 0U, ACL_ERROR_RT_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT},
        ControlCase{true, 0U, ACL_ERROR_RT_FEATURE_NOT_SUPPORT, ACL_ERROR_RT_FEATURE_NOT_SUPPORT}));
} // namespace
