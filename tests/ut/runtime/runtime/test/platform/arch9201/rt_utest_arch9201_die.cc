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
#include "mockcpp/mockcpp.hpp"
#include "dev_info_manage.h"
#define private public
#include "raw_device.hpp"
#undef private
#include "npu_driver_dcache_lock.hpp"

using namespace cce::runtime;

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

    void TearDown() override { GlobalMockObject::verify(); }

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
};

TEST_F(Arch9201DieTest, RegisteredCoreNumPerDie)
{
    DevProperties props = {};
    ASSERT_EQ(GET_DEV_PROPERTIES(CHIP_CLOUD_V5, props), RT_ERROR_NONE);
    EXPECT_EQ(props.aicNumPerDie, 18U); // 18 AICs per die
    EXPECT_EQ(props.aivNumPerDie, 36U); // 36 AIVs per die
    EXPECT_EQ(props.aicNum, 36U);       // 2 dies
    EXPECT_EQ(props.aivNum, 72U);       // 2 dies
}

TEST_F(Arch9201DieTest, AllocStackPhyBaseForSingleDie) { CheckStackAllocSize(1U, 32ULL * 1024ULL * (18ULL + 36ULL)); }

TEST_F(Arch9201DieTest, AllocStackPhyBaseForDualDie)
{
    CheckStackAllocSize(2U, 32ULL * 1024ULL * 2ULL * (18ULL + 36ULL));
}
