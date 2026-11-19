/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "runtime/rt_inner_device.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#define private public
#include "config.h"
#include "runtime.hpp"
#include "dev.h"
#include "rt_error_codes.h"
#include "api_impl.hpp"
#include "api_decorator.hpp"
#include "api_profile_log_decorator.hpp"
#include "api_profile_decorator.hpp"
#include "profiler.hpp"
#include "thread_local_container.hpp"
#include "platform/platform_info.h"
#include "platform_manager_v2.h"
#include "common/rt_utest_context_reset_helper.hpp"
#undef private

using namespace testing;
using namespace cce::runtime;

extern int64_t g_device_driver_chassis_id_stub;
extern int32_t g_hal_device_info_not_support_info_type_stub;
void ClearLastDlogRecordLine();
bool DlogRecordContains(const std::string& keyword);

class ApiDeviceTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "ApiDeviceTest test start start. " << std::endl; }

    static void TearDownTestCase() { std::cout << "ApiDeviceTest test start end. " << std::endl; }

    virtual void SetUp() { (void)rtSetDevice(0); }

    virtual void TearDown() { ut::ResetPrimaryDeviceIfActiveWithDeviceDown(); }
};

namespace {
class SimtDeviceInfoTest : public ApiDeviceTest, public WithParamInterface<rtChipType_t> {};

class SimtChipScope {
public:
    explicit SimtChipScope(rtChipType_t chip) : runtime_(Runtime::Instance()), original_(runtime_->GetChipType())
    {
        runtime_->SetChipType(chip);
        GlobalContainer::SetRtChipType(chip);
    }
    ~SimtChipScope()
    {
        runtime_->SetChipType(original_);
        GlobalContainer::SetRtChipType(original_);
    }

private:
    Runtime* runtime_;
    rtChipType_t original_;
};
} // namespace

TEST_P(SimtDeviceInfoTest, ReturnsDimensionLimits)
{
    // Query every registered SIMT platform without creating a device for that platform.
    SimtChipScope chipScope(GetParam());
    const std::pair<rtDevAttr, int64_t> values[] = {
        {RT_DEV_ATTR_MAX_GRID_DIM_X, INT32_MAX},
        {RT_DEV_ATTR_MAX_GRID_DIM_Y, UINT16_MAX},
        {RT_DEV_ATTR_MAX_GRID_DIM_Z, UINT16_MAX},
        {RT_DEV_ATTR_MAX_BLOCK_PER_GRID, static_cast<int64_t>(INT32_MAX) * UINT16_MAX * UINT16_MAX},
        {RT_DEV_ATTR_MAX_THREADS_PER_BLOCK, 2048},
        {RT_DEV_ATTR_MAX_BLOCK_DIM_X, 2048},
        {RT_DEV_ATTR_MAX_BLOCK_DIM_Y, 2048},
        {RT_DEV_ATTR_MAX_BLOCK_DIM_Z, 2048},
    };
    for (const auto& value : values) {
        SCOPED_TRACE(static_cast<int32_t>(value.first));
        int64_t result = -1;
        EXPECT_EQ(rtsDeviceGetInfo(0U, value.first, &result), RT_ERROR_NONE);
        EXPECT_EQ(result, value.second);
    }
}

INSTANTIATE_TEST_SUITE_P(
    SimtLimits, SimtDeviceInfoTest,
    Values(CHIP_DAVID, CHIP_ASCEND_350, CHIP_CLOUD_V5, CHIP_CLOUD_V6, CHIP_MC32DM11A, CHIP_MC62CM12A));

drvError_t drvGetPlatformInfo_rts1(uint32_t* info)
{
    *info = RT_RUN_MODE_ONLINE;
    return DRV_ERROR_NONE;
}

drvError_t drvGetPlatformInfo_rts2(uint32_t* info)
{
    *info = RT_RUN_MODE_AICPU_SCHED;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts1(unsigned int dev_id, unsigned int* split_mode)
{
    *split_mode = 0;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts2(unsigned int dev_id, unsigned int* split_mode)
{
    *split_mode = 1;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts3(unsigned int dev_id, unsigned int* split_mode)
{
    *split_mode = 2;
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceSplitMode_rts4(unsigned int dev_id, unsigned int* split_mode)
{
    *split_mode = 3;
    return DRV_ERROR_NONE;
}

class ScopedNpuArchProps {
public:
    explicit ScopedNpuArchProps(const int64_t npuArch)
    {
        rt_ = Runtime::Instance();
        EXPECT_NE(rt_, nullptr);
        if (rt_ == nullptr) {
            return;
        }
        EXPECT_EQ(GET_DEV_PROPERTIES(rt_->GetChipType(), origProps_), RT_ERROR_NONE);
        testProps_ = origProps_;
        testProps_.npuArch = npuArch;
        SET_DEV_PROPERTIES(rt_->GetChipType(), testProps_);
        valid_ = true;
    }

    ~ScopedNpuArchProps()
    {
        if (valid_) {
            SET_DEV_PROPERTIES(rt_->GetChipType(), origProps_);
        }
    }

private:
    Runtime* rt_{nullptr};
    DevProperties origProps_{};
    DevProperties testProps_{};
    bool valid_{false};
};

void CheckDeviceInfoCommonAttrs(int32_t devid, int64_t& val)
{
    rtError_t error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_AICPU_CORE_NUM, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsDeviceGetInfo(devid, static_cast<rtDevAttr>(111), &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_AICORE_CORE_NUM, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);

    std::string literalStr = "20";
    MOCKER_CPP(
        &fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string&, const std::string&, std::string&))
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(literalStr))
        .will(returnValue(true));

    constexpr rtDevAttr attrs[] = {
        RT_DEV_ATTR_CUBE_CORE_NUM,
        RT_DEV_ATTR_VECTOR_CORE_NUM,
        RT_DEV_ATTR_WARP_SIZE,
        RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE,
        RT_DEV_ATTR_UBUF_PER_VECTOR_CORE,
        RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE,
        RT_DEV_ATTR_L2_CACHE_SIZE,
        RT_DEV_ATTR_SMP_ID,
        RT_DEV_ATTR_PHY_CHIP_ID,
        RT_DEV_ATTR_SUPER_POD_DEVICE_ID,
        RT_DEV_ATTR_SUPER_POD_SERVER_ID,
        RT_DEV_ATTR_SUPER_POD_ID,
        RT_DEV_ATTR_CUST_OP_PRIVILEGE,
        RT_DEV_ATTR_MAINBOARD_ID,
        RT_DEV_ATTR_SUPER_POD_CHASSIS_ID};
    for (const auto attr : attrs) {
        error = rtsDeviceGetInfo(devid, attr, &val);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }
}

void CheckDeviceInfoNpuArch(int32_t devid, int64_t& val)
{
    ScopedNpuArchProps propsGuard(2201);
    const rtError_t error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_NPU_ARCH, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_GT(val, static_cast<int64_t>(0));
}

void CheckDeviceInfoVirtualAttrs(int32_t devid, int64_t& val)
{
    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts1));
    rtError_t error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, static_cast<int64_t>(0));
    GlobalMockObject::verify();

    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts2));
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, static_cast<int64_t>(1));
    GlobalMockObject::verify();

    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts3));
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, static_cast<int64_t>(1));
    GlobalMockObject::verify();

    MOCKER(halGetDeviceSplitMode).stubs().will(invoke(halGetDeviceSplitMode_rts4));
    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_IS_VIRTUAL, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo)
{
    constexpr int32_t devid = 0;
    int64_t val = 0;
    CheckDeviceInfoCommonAttrs(devid, val);
    CheckDeviceInfoNpuArch(devid, val);
    CheckDeviceInfoVirtualAttrs(devid, val);
}

class ApiDeviceHostNumaTest : public ApiDeviceTest, public testing::WithParamInterface<int64_t> {
protected:
    void TearDown() override
    {
        GlobalMockObject::verify();
        ApiDeviceTest::TearDown();
    }
};

TEST_P(ApiDeviceHostNumaTest, TestRtsDeviceGetInfoHostNumaIdPreservesValue)
{
    int64_t expected = GetParam();
    int64_t value = 123;
    MOCKER(halGetDeviceInfo)
        .expects(once())
        .with(
            eq(0U), eq(static_cast<int32_t>(MODULE_TYPE_SYSTEM)), eq(static_cast<int32_t>(INFO_TYPE_HOST_NUMA_NODE)),
            outBoundP(&expected, sizeof(expected)))
        .will(returnValue(DRV_ERROR_NONE));

    EXPECT_EQ(rtsDeviceGetInfo(0U, RT_DEV_ATTR_HOST_NUMA_ID, &value), RT_ERROR_NONE);
    EXPECT_EQ(value, expected);
}

INSTANTIATE_TEST_SUITE_P(HostNumaIds, ApiDeviceHostNumaTest, testing::Values(int64_t{-1}, int64_t{0}, int64_t{3}));

class ApiDeviceHostNumaErrorTest : public ApiDeviceTest, public testing::WithParamInterface<drvError_t> {
protected:
    void TearDown() override
    {
        GlobalMockObject::verify();
        ApiDeviceTest::TearDown();
    }
};

TEST_P(ApiDeviceHostNumaErrorTest, TestRtsDeviceGetInfoHostNumaIdDriverFailure)
{
    const drvError_t driverError = GetParam();
    const rtError_t expected =
        driverError == DRV_ERROR_NOT_SUPPORT ? ACL_ERROR_RT_FEATURE_NOT_SUPPORT : ACL_ERROR_RT_PARAM_INVALID;
    int64_t value = 123;
    MOCKER(halGetDeviceInfo)
        .expects(once())
        .with(
            eq(0U), eq(static_cast<int32_t>(MODULE_TYPE_SYSTEM)), eq(static_cast<int32_t>(INFO_TYPE_HOST_NUMA_NODE)),
            mockcpp::any())
        .will(returnValue(driverError));

    EXPECT_EQ(rtsDeviceGetInfo(0U, RT_DEV_ATTR_HOST_NUMA_ID, &value), expected);
    EXPECT_EQ(value, 123);
}

INSTANTIATE_TEST_SUITE_P(
    HostNumaErrors, ApiDeviceHostNumaErrorTest, testing::Values(DRV_ERROR_NOT_SUPPORT, DRV_ERROR_INVALID_VALUE));

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfoSuperPodChassisIdMapping)
{
    constexpr int32_t devid = 0;
    int64_t val = 0;
    const rtError_t error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_SUPER_POD_CHASSIS_ID, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, g_device_driver_chassis_id_stub);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfoNotSupportSilent)
{
    constexpr int32_t devid = 0;
    int64_t val = 123;
    g_hal_device_info_not_support_info_type_stub = INFO_TYPE_CHASSIS_ID;
    ClearLastDlogRecordLine();
    const rtError_t error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_SUPER_POD_CHASSIS_ID, &val);
    g_hal_device_info_not_support_info_type_stub = 0;
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    // Expected not-support behavior must not trigger the fallback ErrMsg(EE1001) reporting.
    EXPECT_FALSE(DlogRecordContains("rtsDeviceGetInfo execution failed"));
    EXPECT_EQ(val, static_cast<int64_t>(123));
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_1)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    MOCKER_CPP(&fe::PlatformInfoManager::InitRuntimePlatformInfos).stubs().will(returnValue(0xFFFFFFFF));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_2)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    std::string literalStr = "20";
    MOCKER_CPP(&fe::PlatformInfoManager::GetRuntimePlatformInfosByDevice).stubs().will(returnValue(0xFFFFFFFF));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_3)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    std::string literalStr = "20";
    MOCKER_CPP(
        &fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string&, const std::string&, std::string&))
        .stubs()
        .will(returnValue(false));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_4)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    std::string literalStr = "xyz";
    MOCKER_CPP(
        &fe::PlatFormInfos::GetPlatformResWithLock,
        bool(fe::PlatFormInfos::*)(const std::string&, const std::string&, std::string&))
        .stubs()
        .with(mockcpp::any(), mockcpp::any(), outBound(literalStr))
        .will(returnValue(true));

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_npu_arch_repeat_query)
{
    constexpr int32_t devid = 0;
    int64_t firstVal = 0;
    int64_t secondVal = 0;
    ScopedNpuArchProps propsGuard(2201);

    EXPECT_EQ(rtsDeviceGetInfo(devid, RT_DEV_ATTR_NPU_ARCH, &firstVal), RT_ERROR_NONE);
    EXPECT_EQ(rtsDeviceGetInfo(devid, RT_DEV_ATTR_NPU_ARCH, &secondVal), RT_ERROR_NONE);
    EXPECT_EQ(firstVal, secondVal);
    EXPECT_GT(firstVal, static_cast<int64_t>(0));
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_npu_arch_without_set_device)
{
    constexpr int32_t devid = 0;
    int64_t val = 0;
    ScopedNpuArchProps propsGuard(2201);
    EXPECT_EQ(rtDeviceReset(devid), RT_ERROR_NONE);
    EXPECT_EQ(rtsDeviceGetInfo(devid, RT_DEV_ATTR_NPU_ARCH, &val), RT_ERROR_NONE);
    EXPECT_GT(val, static_cast<int64_t>(0));
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_npu_arch_not_initialized)
{
    Runtime* rt = Runtime::Instance();
    ASSERT_NE(rt, nullptr);
    DevProperties origProps;
    ASSERT_EQ(GET_DEV_PROPERTIES(rt->GetChipType(), origProps), RT_ERROR_NONE);
    DevProperties testProps = origProps;
    testProps.npuArch = 0;
    SET_DEV_PROPERTIES(rt->GetChipType(), testProps);

    constexpr int32_t devid = 0;
    int64_t val = 0;
    const rtError_t error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_NPU_ARCH, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    SET_DEV_PROPERTIES(rt->GetChipType(), origProps);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_abnormal_5)
{
    rtError_t error;
    int32_t devid = 129;
    int64_t val = 0;

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_L2_CACHE_SIZE, &val);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_SimtAttrs_KirinChip)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    rtChipType_t originalType = rtInstance->chipType_;
    rtInstance->chipType_ = CHIP_X90;
    GlobalContainer::SetRtChipType(CHIP_X90);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_WARP_SIZE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX_GRID_DIM_X, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX_THREADS_PER_BLOCK, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    rtInstance->chipType_ = originalType;
    GlobalContainer::SetRtChipType(originalType);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetInfo_SimtAttrs_NoPropertiesChip)
{
    rtError_t error;
    int32_t devid = 0;
    int64_t val = 0;

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    rtChipType_t originalType = rtInstance->chipType_;
    rtInstance->chipType_ = CHIP_NO_DEVICE;
    GlobalContainer::SetRtChipType(CHIP_NO_DEVICE);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_WARP_SIZE, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX_GRID_DIM_X, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    error = rtsDeviceGetInfo(devid, RT_DEV_ATTR_MAX_THREADS_PER_BLOCK, &val);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(val, 0);

    rtInstance->chipType_ = originalType;
    GlobalContainer::SetRtChipType(originalType);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityUpdate)
{
    rtError_t error;

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<int32_t>(FEATURE_NOT_SUPPORT));
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityCross)
{
    rtError_t error;

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, static_cast<int32_t>(FEATURE_SUPPORT));
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityTaskIdBitWidth)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    int32_t value = 0;

    rtError_t error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 16);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityInvalied)
{
    rtError_t error;

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, 20, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityFailed)
{
    rtError_t error;

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    int32_t value = 0;

    error = rtsDeviceGetCapability(0, -1, &value);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetStreamPriorityRange)
{
    rtError_t error;
    int32_t leastPriority;
    int32_t greatestPriority;

    error = rtsDeviceGetStreamPriorityRange(&leastPriority, &greatestPriority);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsDeviceGetCapabilityTaskIdBitWidthOnDavid)
{
    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    int32_t value = 0;

    rtError_t error = rtsDeviceGetCapability(0, RT_FEATURE_SYSTEM_TASKID_BIT_WIDTH, &value);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(value, 16);
}

TEST_F(ApiDeviceTest, TestRtsGetDeviceCount)
{
    rtError_t error;
    int32_t count;

    error = rtsGetDeviceCount(&count);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER(drvGetDevNum).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
    error = rtsGetDeviceCount(&count);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(ApiDeviceTest, TestRtsGetRunMode)
{
    rtError_t error;
    rtRunMode mode;

    error = rtsGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_OFFLINE);

    error = rtsGetRunMode(NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_rts1));
    error = rtsGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_ONLINE);

    GlobalMockObject::verify();

    MOCKER(drvGetPlatformInfo).stubs().will(invoke(drvGetPlatformInfo_rts2));
    error = rtsGetRunMode(&mode);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(mode, RT_RUN_MODE_OFFLINE);
}

TEST_F(ApiDeviceTest, TestRtsGetDeviceUtilizations)
{
    rtError_t error;
    uint8_t utilValue = 0;
    MOCKER(halGetDeviceInfo).stubs().will(returnValue(DRV_ERROR_NONE));
    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_AICORE, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_AIVECTOR, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_AICPU, &utilValue);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Runtime* rtInstance = (Runtime*)Runtime::Instance();
    rtChipType_t type = rtInstance->chipType_;
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtsGetDeviceUtilizations(0, RT_UTIL_TYPE_MAX, &utilValue);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    rtInstance->chipType_ = type;
    GlobalContainer::SetRtChipType(type);
}

TEST_F(ApiDeviceTest, TestRtsGetSocVersion)
{
    rtError_t error = rtsGetSocVersion(nullptr, 50);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsResetDevice)
{
    rtError_t error = rtsResetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsDeviceResetForce)
{
    rtError_t error = rtsDeviceResetForce(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtSetDevice(0);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, TestRtsGetPairDevicesInfo)
{
    uint64_t val;
    rtError_t error = rtsGetPairDevicesInfo(0, 1, 0, &val);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    EXPECT_EQ(val, 1);
}

TEST_F(ApiDeviceTest, TestRtsNewDeviceId)
{
    rtError_t error;
    int32_t count;

    error = rtsGetLogicDevIdByPhyDevId(0, &count);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t count1;
    error = rtsGetPhyDevIdByLogicDevId(0, &count1);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t count2;
    error = rtsGetLogicDevIdByUserDevId(0, &count2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    int32_t count3;
    error = rtsGetUserDevIdByLogicDevId(0, &count3);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtsGetLogicDevIdByPhyDevId(-1, &count);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsGetPhyDevIdByLogicDevId(-1, &count1);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsGetLogicDevIdByUserDevId(-1, &count2);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    error = rtsGetUserDevIdByLogicDevId(-1, &count3);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

/* ========== PCI Bus ID 测试：覆盖 ApiErrorDecorator → ApiImpl 全链路 ========== */

TEST_F(ApiDeviceTest, rt_device_get_pci_bus_id_full_chain_success)
{
    int32_t devId = 0;
    char pciBusId[20] = {0};
    rtError_t error = rtDeviceGetPCIBusId(devId, pciBusId, sizeof(pciBusId));
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_STREQ(pciBusId, "0000:3d:00.0");
}

TEST_F(ApiDeviceTest, rt_device_get_pci_bus_id_full_chain_invalid_dev_id)
{
    int32_t devId = -1;
    char pciBusId[20] = {0};
    rtError_t error = rtDeviceGetPCIBusId(devId, pciBusId, sizeof(pciBusId));
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, rt_device_get_pci_bus_id_full_chain_invalid_ptr)
{
    int32_t devId = 0;
    rtError_t error = rtDeviceGetPCIBusId(devId, nullptr, 20);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, rt_device_get_pci_bus_id_full_chain_len_too_small)
{
    int32_t devId = 0;
    char pciBusId[20] = {0};
    rtError_t error = rtDeviceGetPCIBusId(devId, pciBusId, static_cast<int32_t>(RT_PCI_BUS_ID_MIN_LEN) - 1);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, rt_device_get_by_pci_bus_id_full_chain_success)
{
    const char* pciBusId = "0000:3d:00.0";
    int32_t devId = -1;
    rtError_t error = rtDeviceGetByPCIBusId(pciBusId, &devId);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(devId, 0);
}

TEST_F(ApiDeviceTest, rt_device_get_by_pci_bus_id_full_chain_no_match)
{
    const char* pciBusId = "0000:ff:00.0";
    int32_t devId = -1;
    rtError_t error = rtDeviceGetByPCIBusId(pciBusId, &devId);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, rt_device_get_by_pci_bus_id_full_chain_invalid_ptr)
{
    int32_t devId = 0;
    rtError_t error = rtDeviceGetByPCIBusId(nullptr, &devId);
    EXPECT_NE(error, RT_ERROR_NONE);
}

TEST_F(ApiDeviceTest, rt_device_get_by_pci_bus_id_full_chain_invalid_dev_id_ptr)
{
    rtError_t error = rtDeviceGetByPCIBusId("0000:3d:00.0", nullptr);
    EXPECT_NE(error, RT_ERROR_NONE);
}
