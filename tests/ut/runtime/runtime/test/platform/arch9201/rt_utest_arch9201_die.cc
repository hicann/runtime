/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <map>
#include <string>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "dev_info_manage.h"
#define private public
#include "raw_device.hpp"
#undef private
#include "npu_driver_dcache_lock.hpp"
#include "ini_parse_utils.h"
#include "api_impl_david.hpp"
#include "context.hpp"
#include "driver.hpp"
#include "runtime.hpp"
#include "../../common/rt_utest_context_reset_helper.hpp"

using namespace cce::runtime;

extern int32_t stubPlatformManagerV2GetSocSpec(
    const std::string& socVersion, const std::string& label, const std::string& key, std::string& value);

namespace {
int32_t GetDebugMemorySocSpec(
    const std::string& socVersion, const std::string& label, const std::string& key, std::string& value)
{
    if ((label != "AICoreSpec") || (socVersion == "missing")) {
        return RT_ERROR_NOT_FOUND;
    }
    if (socVersion == "query_error") {
        return RT_ERROR_INVALID_VALUE;
    }
    // Synthetic capacities distinguish each platform; these are not hardware specifications.
    if ((socVersion == "arch9201") || (socVersion == "david")) {
        const std::map<std::string, std::string> sizes = {
            {"l0_a_size", (socVersion == "david") ? "32768" : "98304"},
            {"l0_b_size", (socVersion == "david") ? "131072" : "49152"},
            {"l0_c_size", (socVersion == "david") ? "524288" : "196608"},
            {"l1_size", (socVersion == "david") ? "1048576" : "786432"},
            {"ub_size", (socVersion == "david") ? "253952" : "131072"}};
        const auto it = sizes.find(key);
        if (it == sizes.end()) {
            return RT_ERROR_NOT_FOUND;
        }
        value = it->second;
    } else if (socVersion == "partial") {
        if (key != "ub_size") {
            return RT_ERROR_NOT_FOUND;
        }
        value = "131072";
    } else {
        value = socVersion;
    }
    return RT_ERROR_NONE;
}

} // namespace

namespace {
uint64_t g_dcacheAllocSize = 0ULL;

rtError_t StubAllocAddrForDcache(const uint32_t deviceId, void*& dcacheAddr, const uint64_t size, void*& drvHandle)
{
    UNUSED(deviceId);
    UNUSED(dcacheAddr);
    UNUSED(drvHandle);
    g_dcacheAllocSize = size;
    return RT_ERROR_NONE;
}
} // namespace

class Arch9201DieTest : public testing::Test {
protected:
    void SetUp() override
    {
        GlobalMockObject::reset();
        g_dcacheAllocSize = 0ULL;
    }

    void TearDown() override
    {
        if (runtime_ != nullptr) {
            ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
            runtime_->SetDisableThread(savedDisableThread_);
        }
        GlobalMockObject::verify();
    }

    void InitDebugMemoryDevice()
    {
        runtime_ = static_cast<Runtime*>(Runtime::Instance());
        savedDisableThread_ = runtime_->GetDisableThread();
        runtime_->SetDisableThread(true);
        ASSERT_EQ(rtSetDevice(0), ACL_RT_SUCCESS);
        Context* const ctx = runtime_->CurrentContext();
        ASSERT_NE(ctx, nullptr);
        ASSERT_NE(ctx->Device_(), nullptr);
        ASSERT_EQ(ctx->Device_()->GetChipType(), CHIP_CLOUD_V5);
    }

    void CheckStackAllocSize(const uint8_t dieNum, const uint64_t expectedSize)
    {
        DevProperties props = {};
        ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, props), RT_ERROR_NONE);

        RawDevice device(0U);
        device.RefreshDevProperties(props);
        device.davidDieNum_ = dieNum;
        MOCKER(AllocAddrForDcache).expects(once()).will(invoke(StubAllocAddrForDcache));

        ASSERT_EQ(device.AllocStackPhyBaseDavid(), RT_ERROR_NONE);
        EXPECT_EQ(g_dcacheAllocSize, expectedSize);
    }

private:
    Runtime* runtime_ = nullptr;
    bool savedDisableThread_ = false;
};

TEST_F(Arch9201DieTest, RegisteredCoreNumPerDie)
{
    DevProperties props = {};
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, props), RT_ERROR_NONE);
    EXPECT_EQ(props.aicNumPerDie, 35U); // 35 AICs per die
    EXPECT_EQ(props.aivNumPerDie, 35U); // 35 AIVs per die
    EXPECT_EQ(props.aicNum, 70U);       // 2 dies
    EXPECT_EQ(props.aivNum, 70U);       // 2 dies
}

TEST_F(Arch9201DieTest, AllocStackPhyBaseForSingleDie) { CheckStackAllocSize(1U, 32ULL * 1024ULL * (35ULL + 35ULL)); }

TEST_F(Arch9201DieTest, AllocStackPhyBaseForDualDie)
{
    CheckStackAllocSize(2U, 32ULL * 1024ULL * 2ULL * (35ULL + 35ULL));
}

TEST_F(Arch9201DieTest, DebugReadAICoreUsesIniMemoryBoundaries)
{
    Runtime* const runtime = static_cast<Runtime*>(Runtime::Instance());
    ASSERT_EQ(runtime->GetChipType(), CHIP_CLOUD_V5);
    ASSERT_FALSE(ut::IsPrimaryDeviceActive());
    DevProperties originalProps;
    DevProperties originalDavidProps;
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, originalProps), RT_ERROR_NONE);
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_DAVID, originalDavidProps), RT_ERROR_NONE);
    ScopeGuard restoreProperties([&]() {
        EXPECT_EQ(DevInfoManage::Instance().SetDevProperties(CHIP_CLOUD_V5, originalProps), RT_ERROR_NONE);
        EXPECT_EQ(DevInfoManage::Instance().SetDevProperties(CHIP_DAVID, originalDavidProps), RT_ERROR_NONE);
    });

    MOCKER(stubPlatformManagerV2GetSocSpec).stubs().will(invoke(GetDebugMemorySocSpec));
    RtIniAttributes davidAttrs = {};
    ParseIniFile("david", davidAttrs);
    runtime->UpdateDevPropertiesFromIniAttrs(CHIP_DAVID, davidAttrs);

    RtIniAttributes iniAttrs = {};
    ParseIniFile("arch9201", iniAttrs);
    ASSERT_EQ(iniAttrs.l0ASize, 98304U);
    ASSERT_EQ(iniAttrs.l0BSize, 49152U);
    ASSERT_EQ(iniAttrs.l0CSize, 196608U);
    ASSERT_EQ(iniAttrs.l1Size, 786432U);
    ASSERT_EQ(iniAttrs.ubSize, 131072U);
    runtime->UpdateDevPropertiesFromIniAttrs(CHIP_CLOUD_V5, iniAttrs);

    DevProperties props;
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, props), RT_ERROR_NONE);
    EXPECT_EQ(props.l0ASize, 98304U);
    EXPECT_EQ(props.l0BSize, 49152U);
    EXPECT_EQ(props.l0CSize, 196608U);
    EXPECT_EQ(props.l1Size, 786432U);
    EXPECT_EQ(props.ubSize, 131072U);
    DevProperties davidProps;
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_DAVID, davidProps), RT_ERROR_NONE);
    EXPECT_EQ(davidProps.l0ASize, 32768U);
    EXPECT_EQ(davidProps.l0BSize, 131072U);
    EXPECT_EQ(davidProps.l0CSize, 524288U);
    EXPECT_EQ(davidProps.l1Size, 1048576U);
    EXPECT_EQ(davidProps.ubSize, 253952U);

    // Load the properties through device initialization instead of refreshing the device in the test.
    ASSERT_NO_FATAL_FAILURE(InitDebugMemoryDevice());
    Context* const ctx = runtime->CurrentContext();
    ASSERT_NE(ctx, nullptr);
    Device* const device = ctx->Device_();
    ASSERT_NE(device, nullptr);
    ASSERT_EQ(device->GetChipType(), CHIP_CLOUD_V5);
    const DevProperties& deviceProps = device->GetDevProperties();
    EXPECT_EQ(deviceProps.l0ASize, 98304U);
    EXPECT_EQ(deviceProps.l0BSize, 49152U);
    EXPECT_EQ(deviceProps.l0CSize, 196608U);
    EXPECT_EQ(deviceProps.l1Size, 786432U);
    EXPECT_EQ(deviceProps.ubSize, 131072U);
    Driver* const driver = device->Driver_();
    device->SetCoredumpEnable();

    uint8_t buffer[4096U] = {};
    uint8_t output = 0U;
    void* deviceMemory = buffer;
    MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemAllocWithBackupFlag)
        .expects(exactly(5))
        .with(outBoundP(&deviceMemory, sizeof(deviceMemory)))
        .will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::DevMemFree).expects(exactly(5)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::MemSetSync).expects(exactly(5)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::MemCopySync).expects(exactly(5)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::DebugSqTaskSend).expects(exactly(10)).will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(driver, &Driver::DebugCqReport).expects(exactly(10)).will(returnValue(RT_ERROR_NONE));

    const std::pair<rtDebugMemoryType_t, uint64_t> boundaries[] = {
        {RT_MEM_TYPE_L0A, 98304U},
        {RT_MEM_TYPE_L0B, 49152U},
        {RT_MEM_TYPE_L0C, 196608U},
        {RT_MEM_TYPE_L1, 786432U},
        {RT_MEM_TYPE_UB, 131072U}};
    ApiImplDavid api;
    for (const auto& boundary : boundaries) {
        SCOPED_TRACE(boundary.first);
        rtDebugMemoryParam_t param = {};
        param.debugMemType = boundary.first;
        param.dstAddr = PtrToValue(&output);
        param.srcAddr = boundary.second - 1U;
        param.memLen = 1U;
        EXPECT_EQ(api.DebugReadAICore(&param), RT_ERROR_NONE);
        param.memLen = 2U;
        EXPECT_EQ(api.DebugReadAICore(&param), RT_ERROR_INVALID_VALUE);
        param.srcAddr = boundary.second;
        param.memLen = 1U;
        EXPECT_EQ(api.DebugReadAICore(&param), RT_ERROR_INVALID_VALUE);
        param.srcAddr = UINT64_MAX;
        EXPECT_EQ(api.DebugReadAICore(&param), RT_ERROR_INVALID_VALUE);
        param.srcAddr = 1U;
        param.memLen = UINT64_MAX;
        EXPECT_EQ(api.DebugReadAICore(&param), RT_ERROR_INVALID_VALUE);
    }
    GlobalMockObject::verify();
}

TEST_F(Arch9201DieTest, InvalidOrMissingMemoryIniKeepsProperties)
{
    ASSERT_NO_FATAL_FAILURE(InitDebugMemoryDevice());
    DevProperties originalProps;
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, originalProps), RT_ERROR_NONE);
    ScopeGuard restoreProperties([&]() { SET_DEV_PROPERTIES(CHIP_CLOUD_V5, originalProps); });
    MOCKER(stubPlatformManagerV2GetSocSpec).stubs().will(invoke(GetDebugMemorySocSpec));

    for (const std::string& value : {"missing", "query_error", "invalid", "0", "-1", "4294967296"}) {
        SCOPED_TRACE(value);
        RtIniAttributes iniAttrs = {};
        ParseIniFile(value, iniAttrs);
        ((Runtime*)Runtime::Instance())->UpdateDevPropertiesFromIniAttrs(CHIP_CLOUD_V5, iniAttrs);
        DevProperties props;
        ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, props), RT_ERROR_NONE);
        EXPECT_EQ(props.l0ASize, originalProps.l0ASize);
        EXPECT_EQ(props.l0BSize, originalProps.l0BSize);
        EXPECT_EQ(props.l0CSize, originalProps.l0CSize);
        EXPECT_EQ(props.l1Size, originalProps.l1Size);
        EXPECT_EQ(props.ubSize, originalProps.ubSize);
    }
    GlobalMockObject::verify();
}

TEST_F(Arch9201DieTest, PartialMemoryIniOnlyUpdatesUb)
{
    ASSERT_NO_FATAL_FAILURE(InitDebugMemoryDevice());
    DevProperties originalProps;
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, originalProps), RT_ERROR_NONE);
    ScopeGuard restoreProperties([&]() { SET_DEV_PROPERTIES(CHIP_CLOUD_V5, originalProps); });
    MOCKER(stubPlatformManagerV2GetSocSpec).stubs().will(invoke(GetDebugMemorySocSpec));

    RtIniAttributes iniAttrs = {};
    ParseIniFile("partial", iniAttrs);
    ((Runtime*)Runtime::Instance())->UpdateDevPropertiesFromIniAttrs(CHIP_CLOUD_V5, iniAttrs);
    DevProperties props;
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, props), RT_ERROR_NONE);
    EXPECT_EQ(props.l0ASize, originalProps.l0ASize);
    EXPECT_EQ(props.l0BSize, originalProps.l0BSize);
    EXPECT_EQ(props.l0CSize, originalProps.l0CSize);
    EXPECT_EQ(props.l1Size, originalProps.l1Size);
    EXPECT_EQ(props.ubSize, 131072U);
    GlobalMockObject::verify();
}
