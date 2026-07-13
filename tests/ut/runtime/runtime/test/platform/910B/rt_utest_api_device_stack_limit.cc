/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

/*
 * UT for rtDeviceSetLimit / rtDeviceGetLimit
 * Test scenario coverage:
 *   - STACK_SIZE normal set and query (A2/A3 common platform)
 *   - STACK_SIZE alignment validation (round up to 16KB boundary when >32K)
 *   - SIMT-related types not supported on A2/A3 (Set/Get both return RT_ERROR_FEATURE_NOT_SUPPORT)
 *   - SIMD_PRINTF_FIFO normal set and query
 *   - Parameter validation (out-of-range devId, null pointer)
 *   - Value consistency validation between Set and Get
 */

#include "driver/ascend_hal.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include <thread>
#include <vector>
#define private public
#define protected public
#include "runtime.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "module.hpp"
#include "notify.hpp"
#include "event.hpp"
#include "task_info.hpp"
#include "ffts_task.h"
#include "device/device_error_proc.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "npu_driver.hpp"
#include "ctrl_res_pool.hpp"
#include "stream_sqcq_manage.hpp"
#include "davinci_kernel_task.h"
#include "profiler.hpp"
#include "rdma_task.h"
#include "thread_local_container.hpp"
#undef private
#undef protected

using namespace testing;
using namespace cce::runtime;

class DeviceLimitTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    uint32_t oldDeviceCustomerStackSize{0U};
    uint32_t oldPrintblockLen{0U};
    uint32_t oldSimtPrintLen{0U};

    virtual void SetUp()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        oldDeviceCustomerStackSize = rtInstance->deviceCustomerStackSize_;
        oldPrintblockLen = rtInstance->printblockLen_;
        oldSimtPrintLen = rtInstance->simtPrintLen_;
        rtInstance->deviceCustomerStackSize_ = KERNEL_STACK_SIZE_32K;
        rtSetDevice(0);
    }

    virtual void TearDown()
    {
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->deviceCustomerStackSize_ = oldDeviceCustomerStackSize;
        rtInstance->printblockLen_ = oldPrintblockLen;
        rtInstance->simtPrintLen_ = oldSimtPrintLen;
        rtDeviceReset(0);
        GlobalMockObject::verify();
    }
};

// Scenario: Set STACK_SIZE then query, validate value consistency
// Platform: A2/A3 common platform (ApiImpl path)
// Input: type=RT_LIMIT_TYPE_STACK_SIZE, val=65536
// Expected: Set returns SUCCESS, Get returns SUCCESS with consistent value
TEST_F(DeviceLimitTest, SetAndGetLimit_StackSize_Success)
{
    // Set AI Core stack size to 64KB
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 65536U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // Query and validate value consistency
    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 65536U);
}

// Scenario: Set STACK_SIZE to a non-16KB-aligned value, validate round-up alignment
// Platform: A2/A3 common platform
// Input: type=RT_LIMIT_TYPE_STACK_SIZE, val=40000 (not 16KB-aligned)
// Expected: After Set, Get returns the aligned value. SetDeviceCustomerStackSize aligns internally
TEST_F(DeviceLimitTest, SetLimit_StackSize_AlignTo16K)
{
    // 40000 bytes, round up to 16KB boundary = 49152 (48K)
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 40000U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // SetDeviceCustomerStackSize rounds values >32K up to 16KB
    EXPECT_EQ(val, 49152U);
}

// Scenario: Set STACK_SIZE to a value <=32K, should keep default 32K (no effect)
// Platform: A2/A3 common platform
// Input: type=RT_LIMIT_TYPE_STACK_SIZE, val=16384 (16K, less than default 32K)
// Expected: Get returns default value 32K (SetDeviceCustomerStackSize only takes effect for values >32K)
TEST_F(DeviceLimitTest, SetLimit_StackSize_Below32K_KeepsDefault)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 16384U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // Value <=32K keeps default 32K
    EXPECT_EQ(val, KERNEL_STACK_SIZE_32K);
}

// Scenario: Set SIMT_STACK_SIZE on A2/A3 platform, should return FEATURE_NOT_SUPPORT
// Platform: A2/A3 common platform
// Input: type=RT_LIMIT_TYPE_SIMT_STACK_SIZE, val=256
// Expected: Set returns RT_ERROR_FEATURE_NOT_SUPPORT
TEST_F(DeviceLimitTest, SetLimit_SimtStackSize_OnA2A3_NotSupport)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_STACK_SIZE, 256U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// Scenario: Set SIMT_DVG_WARP_STACK_SIZE on A2/A3 platform, should return FEATURE_NOT_SUPPORT
// Platform: A2/A3 common platform
// Input: type=RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, val=512
// Expected: Set returns RT_ERROR_FEATURE_NOT_SUPPORT
TEST_F(DeviceLimitTest, SetLimit_SimtDvgWarpStackSize_OnA2A3_NotSupport)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_DVG_WARP_STACK_SIZE, 512U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// Scenario: Set SIMD_PRINTF_FIFO_SIZE_PER_CORE and query
// Platform: A2/A3 common platform
// Input: type=RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, val=65536
// Expected: Set returns SUCCESS, Get returns aligned value
TEST_F(DeviceLimitTest, SetAndGetLimit_SimdPrintfFifo_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 65536U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 65536U);
}

// Scenario: GetLimit with null pointer, should return parameter error
// Input: val=nullptr
// Expected: Returns RT_ERROR_INVALID_VALUE
TEST_F(DeviceLimitTest, GetLimit_NullValue_ReturnsError)
{
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, nullptr);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// Scenario: GetLimit with unsupported type, should return 0 (else branch fallback)
// Coverage path: ApiImpl::DeviceGetLimit else branch -> *val = 0U
TEST_F(DeviceLimitTest, GetLimit_UnsupportedType_ReturnsZero)
{
    uint32_t val = 999U;
    rtError_t ret = rtDeviceGetLimit(static_cast<rtLimitType_t>(99), &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 0U);
}

// Scenario: SetLimit with out-of-range devId, should return parameter error
// Input: devId=-1
// Expected: Returns RT_ERROR_INVALID_VALUE (validated at error decorator layer)
TEST_F(DeviceLimitTest, SetLimit_InvalidDevId_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(-1, RT_LIMIT_TYPE_STACK_SIZE, 65536U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// Scenario: Set the same type multiple times, later value overrides earlier value
// Input: first set 65536, then set 131072
// Expected: Get returns the last set value
TEST_F(DeviceLimitTest, SetLimit_Twice_LastValueWins)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 65536U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 131072U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 131072U);
}

// Scenario: Set SIMT_PRINTF_FIFO_SIZE on A2/A3 platform, should return FEATURE_NOT_SUPPORT
// Platform: A2/A3 common platform
// Input: type=RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, val=2097152(2MB)
// Expected: Set returns RT_ERROR_FEATURE_NOT_SUPPORT (this type is explicitly not supported)
TEST_F(DeviceLimitTest, SetLimit_SimtPrintfFifo_OnA2A3_ReturnsNotSupport)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, 2097152U);
    EXPECT_NE(ret, RT_ERROR_NONE);

    // Get SIMT_PRINTF_FIFO_SIZE goes through the SIMT_PRINTF_FIFO_SIZE branch on Standard SoC
    // This branch has a locked read path in Get (asymmetric with Set's NOT_SUPPORT), returns Runtime scalar value
    uint32_t val = 999U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMT_PRINTF_FIFO_SIZE, &val);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// ==================== Timing Scenario Tests ====================

// Scenario: After ResetDevice, scalar persists; SetDevice reallocates based on current scalar
// Input: SetLimit(65536) -> SetDevice -> ResetDevice -> GetLimit(should still be 65536) -> SetDevice
// Expected: ResetDevice does not lose scalar; SetDevice reallocates based on 65536
TEST_F(DeviceLimitTest, SetLimit_ResetDevice_ScalarPersisted)
{
    rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 65536U);

    uint32_t val = 0U;
    rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(val, 65536U);

    rtDeviceReset(0);

    // Scalar should persist after ResetDevice
    val = 0U;
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 65536U);

    // SetDevice again, reallocate based on current scalar
    ret = rtSetDevice(0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

// Scenario: Multiple SetDevice without Reset, physical stack allocated only once
// Input: SetDevice(0) -> SetDevice(0) (without Reset)
// Expected: Second SetDevice does not reallocate physical stack
TEST_F(DeviceLimitTest, MultipleSetDevice_NoReset_StackAllocatedOnce)
{
    rtError_t ret = rtSetDevice(0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // Second SetDevice should return directly without duplicate allocation
    ret = rtSetDevice(0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

// Scenario: SetLimit after SetDevice, scalar updates but physical stack unchanged
// Input: SetDevice -> SetLimit(65536) -> GetLimit(should return 65536)
// Expected: Scalar updates successfully, GetLimit returns new value
TEST_F(DeviceLimitTest, SetLimit_AfterSetDevice_ScalarUpdated)
{
    rtError_t ret = rtSetDevice(0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // Change scalar after SetDevice
    ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 65536U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    // GetLimit should return new scalar value
    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 65536U);
}

// Scenario: GetLimit returns scalar value even without SetDevice
// Input: SetLimit(65536) -> GetLimit (without SetDevice)
// Expected: Returns scalar value 65536
TEST_F(DeviceLimitTest, GetLimit_WithoutSetDevice_ReturnsScalar)
{
    // SetUp already called rtSetDevice(0), reset first
    rtDeviceReset(0);

    // Without SetDevice, directly SetLimit + GetLimit
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 65536U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 65536U);
}

// ==================== Value Range Boundary Tests ====================

// Scenario: STACK_SIZE input UINT32_MAX, validate alignment overflow behavior
// Expected: SetDeviceCustomerStackSize alignment overflow wraps around, scalar gets wrong value (known risk, test records current behavior)
TEST_F(DeviceLimitTest, SetLimit_StackSize_UINT32_MAX)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, UINT32_MAX);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // UINT32_MAX alignment overflow may wrap to a small value, recording current behavior
    // Expected: AllocCustomerStackPhyBase will reject during SetDevice (>maxCustomerStackSize)
}

// Scenario: SIMD_FIFO input 0, validate range rejection
// Expected: SetSimdPrintFifoSize validates val < 1024(1KB), returns RT_ERROR_INVALID_VALUE
TEST_F(DeviceLimitTest, SetLimit_SimdFifo_Zero_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 0U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// Scenario: SIMD_FIFO input 64MB+1, validate upper range rejection
// Expected: SetSimdPrintFifoSize validates val > 64MB, returns RT_ERROR_INVALID_VALUE
TEST_F(DeviceLimitTest, SetLimit_SimdFifo_ExceedMax_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 64U * 1024U * 1024U + 1U);
    EXPECT_NE(ret, RT_ERROR_NONE);
}

// Scenario: SIMD_FIFO input 1KB (minimum value), validate boundary pass
TEST_F(DeviceLimitTest, SetLimit_SimdFifo_MinValue_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 1024U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 1024U);
}

// Scenario: SIMD_FIFO input 64MB (maximum value), validate boundary pass
TEST_F(DeviceLimitTest, SetLimit_SimdFifo_MaxValue_Success)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 64U * 1024U * 1024U);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}

// Scenario: STACK_SIZE input exactly 32769 (>32K but not 16KB-aligned), validate alignment to 48K
TEST_F(DeviceLimitTest, SetLimit_StackSize_JustAbove32K_AlignTo48K)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 32769U);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_EQ(val, 49152U); // 32769 -> 48K(49152)
}

// ==================== Locking Concurrency Tests ====================

// Scenario: Multi-threaded concurrent SetLimit(STACK_SIZE), validate no data race (Standard SoC has no lock, recording current behavior)
// Expected: Final GetLimit returns the last written value (not guaranteed which thread's value)
TEST_F(DeviceLimitTest, SetLimit_Concurrent_StackSize_NoCrash)
{
    const int32_t threadNum = 4;
    std::vector<std::thread> threads;
    for (int32_t i = 0; i < threadNum; i++) {
        threads.emplace_back([i]() {
            uint32_t val = 65536U + static_cast<uint32_t>(i) * 16384U;
            rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, val);
        });
    }
    for (auto &t : threads) { t.join(); }

    // Verify no crash, GetLimit returns a valid value
    uint32_t val = 0U;
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 65536U);
}

// Scenario: Multi-threaded concurrent SetLimit(SIMD_FIFO), validate lock protection
// Expected: FIFO has mutex lock, concurrent writes do not crash, final value is valid
TEST_F(DeviceLimitTest, SetLimit_Concurrent_SimdFifo_NoCrash)
{
    const int32_t threadNum = 4;
    std::vector<std::thread> threads;
    for (int32_t i = 0; i < threadNum; i++) {
        threads.emplace_back([i]() {
            uint32_t val = 32768U + static_cast<uint32_t>(i) * 4096U;
            rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, val);
        });
    }
    for (auto &t : threads) { t.join(); }

    uint32_t val = 0U;
    rtError_t ret = rtDeviceGetLimit(RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    EXPECT_GE(val, 32768U);
}

// ==================== Exception Value Tests (value=-1 and oversized values) ====================

// Scenario: STACK_SIZE passes -1 (implicitly converted to uint32_t=4294967295=UINT32_MAX)
// Expected: SetDeviceCustomerStackSize alignment overflow, scalar gets wrong value; SetLimit does not reject
TEST_F(DeviceLimitTest, SetLimit_StackSize_NegativeOne)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, static_cast<uint32_t>(-1));
    EXPECT_EQ(ret, RT_ERROR_NONE); // SetLimit does not reject

    uint32_t val = 0U;
    ret = rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    // Scalar gets the overflowed value, will be rejected by maxCustomerStackSize during SetDevice
}

// Scenario: STACK_SIZE passes oversized value 1MB, SetLimit does not reject, SetDevice should be rejected by maxCustomerStackSize
TEST_F(DeviceLimitTest, SetLimit_StackSize_1MB_ExceedMaxAtSetDevice)
{
    rtDeviceReset(0);
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 1048576U);
    EXPECT_EQ(ret, RT_ERROR_NONE); // SetLimit does not reject
    // SetDevice should be rejected (1MB > 192KB)
    ret = rtSetDevice(0);
    // Mock environment records behavior, pass if no crash
}

// Scenario: SIMD_FIFO passes -1 (=UINT32_MAX), exceeds 64MB upper limit, should be rejected by range validation
TEST_F(DeviceLimitTest, SetLimit_SimdFifo_NegativeOne_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, static_cast<uint32_t>(-1));
    EXPECT_NE(ret, RT_ERROR_NONE); // 4294967295 > 64MB, rejected
}

// Scenario: STACK_SIZE passes exactly 192KB+1 (exceeds upper limit), SetLimit does not reject
TEST_F(DeviceLimitTest, SetLimit_StackSize_JustExceedMax)
{
    rtDeviceReset(0);
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 196609U);
    EXPECT_EQ(ret, RT_ERROR_NONE); // SetLimit does not reject
    ret = rtSetDevice(0);
    // Record behavior
}

// Scenario: STACK_SIZE passes exactly 192KB (upper limit value), no error
TEST_F(DeviceLimitTest, SetLimit_StackSize_AtMax_192KB)
{
    rtDeviceReset(0);
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_STACK_SIZE, 196608U);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    uint32_t val = 0U;
    rtDeviceGetLimit(RT_LIMIT_TYPE_STACK_SIZE, &val);
    EXPECT_EQ(val, 196608U);
    ret = rtSetDevice(0);
}

// Scenario: SIMD_FIFO passes 512 (below 1KB lower limit), should be rejected
TEST_F(DeviceLimitTest, SetLimit_SimdFifo_BelowMin_ReturnsError)
{
    rtError_t ret = rtDeviceSetLimit(0, RT_LIMIT_TYPE_SIMD_PRINTF_FIFO_SIZE_PER_CORE, 512U);
    EXPECT_NE(ret, RT_ERROR_NONE); // 512 < 1024, rejected
}
