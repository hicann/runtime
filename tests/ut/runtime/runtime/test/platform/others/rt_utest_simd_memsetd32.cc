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
#include "securec.h"
#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#define private public
#include "kernel.hpp"
#include "program.hpp"
#include "uma_arg_loader.hpp"
#include "raw_device.hpp"
#undef private
#include "runtime.hpp"
#include "api.hpp"
#include "cmodel_driver.h"
#include "thread_local_container.hpp"
#include "../../common/rt_utest_context_reset_helper.hpp"
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include "memset_common.h"
#include "task_info_base.hpp"
#include "task_info.hpp"
#include "device_properties.h"
#include "stars_base.hpp"
#include "task_base.hpp"
using namespace cce::runtime;

// 测试 MemsetD32Optimized 对齐地址填充
class MemsetTaskTest : public testing::Test {
protected:
    virtual void SetUp() { (void)rtSetDevice(0); }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        ut::ForceResetPrimaryDeviceIfActive();
    }
};

TEST(SimdUtilsTest, OptimizedAligned)
{
    const size_t count = 1024;
    uint32_t* buf = (uint32_t*)aligned_alloc(32, count * sizeof(uint32_t));
    ASSERT_NE(buf, nullptr);
    uint32_t value = 0xCAFEBABE;
    MemsetD32Optimized(buf, value, count);
    for (size_t i = 0; i < count; ++i) {
        EXPECT_EQ(buf[i], value);
    }
    free(buf);
}

// 测试 MemsetD32Optimized 非对齐地址（32字节未对齐）
TEST(SimdUtilsTest, OptimizedUnaligned)
{
    const size_t count = 1024;
    uint32_t* aligned = (uint32_t*)aligned_alloc(32, (count + 2) * sizeof(uint32_t));
    ASSERT_NE(aligned, nullptr);
    uint32_t* unaligned = aligned + 1; // 偏移4字节，相对32字节未对齐
    uint32_t value = 0x12345678;
    MemsetD32Optimized(unaligned, value, count);
    for (size_t i = 0; i < count; ++i) {
        EXPECT_EQ(unaligned[i], value);
    }
    free(aligned);
}

// 测试 count = 0
TEST(SimdUtilsTest, OptimizedZeroCount)
{
    uint32_t buf[4] = {0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF};
    uint32_t original = buf[0];
    MemsetD32Optimized(buf, 0xDEADBEEF, 0);
    EXPECT_EQ(buf[0], original); // 未被修改
}

// 测试各种 count 值，覆盖 SIMD 循环尾部逻辑
TEST(SimdUtilsTest, OptimizedVariousCounts)
{
    std::vector<size_t> counts = {1,  3,  4,  5,  7,  8,  9,   12,  15,  16,   17,
                                  31, 32, 33, 63, 64, 65, 127, 128, 129, 1023, 1024};
    size_t maxCount = *std::max_element(counts.begin(), counts.end());
    uint32_t* buf = (uint32_t*)aligned_alloc(32, (maxCount + 64) * sizeof(uint32_t));
    ASSERT_NE(buf, nullptr);
    for (size_t n : counts) {
        uint32_t value = static_cast<uint32_t>(n) | 0xAAAA0000;
        MemsetD32Optimized(buf, value, n);
        for (size_t i = 0; i < n; ++i) {
            EXPECT_EQ(buf[i], value) << "Failed at n=" << n;
        }
    }
    free(buf);
}

// 大块内存压力测试
TEST(SimdUtilsTest, OptimizedLarge)
{
    const size_t count = 64 * 1024 * 1024 / sizeof(uint32_t); // 64MB
    uint32_t* buf = (uint32_t*)aligned_alloc(32, count * sizeof(uint32_t));
    if (buf == nullptr) {
        GTEST_SKIP() << "Cannot allocate 64MB for large test";
    }
    uint32_t value = 0x5A5A5A5A;
    MemsetD32Optimized(buf, value, count);
    EXPECT_EQ(buf[0], value);
    EXPECT_EQ(buf[count / 2], value);
    EXPECT_EQ(buf[count - 1], value);
    free(buf);
}

TEST_F(MemsetTaskTest, ExpandByteToU32_ff) { EXPECT_EQ(ExpandByteToU32(0xFF), 0xFFFFFFFFU); }

TEST_F(MemsetTaskTest, ExpandByteToU32_01) { EXPECT_EQ(ExpandByteToU32(0x01), 0x01010101U); }

struct IsSupportParam {
    MemsetTaskSupportType support;
    uint32_t memDevId;
    uint32_t curDevId;
    bool expected;
};

class MemsetTaskIsSupportParamTest : public MemsetTaskTest, public testing::WithParamInterface<IsSupportParam> {};

TEST_P(MemsetTaskIsSupportParamTest, IsSupportMemsetTask)
{
    const auto& p = GetParam();
    DevProperties props{};
    props.memsetTaskSupport = p.support;
    EXPECT_EQ(IsSupportMemsetTask(p.memDevId, p.curDevId, props), p.expected);
}

INSTANTIATE_TEST_SUITE_P(
    IsSupportMemsetTask, MemsetTaskIsSupportParamTest,
    testing::Values(
        // Same device
        IsSupportParam{MemsetTaskSupportType::MEMSET_TASK_NOT_SUPPORT, 0U, 0U, false},
        IsSupportParam{MemsetTaskSupportType::MEMSET_TASK_SUPPORT, 0U, 0U, true},
        // Cross device - always false regardless of support type
        IsSupportParam{MemsetTaskSupportType::MEMSET_TASK_SUPPORT, 0U, 1U, false},
        IsSupportParam{MemsetTaskSupportType::MEMSET_TASK_NOT_SUPPORT, 1U, 0U, false}));

TEST_F(MemsetTaskTest, MemsetD32OnHost_basic)
{
    uint32_t buf[64] = {};
    rtError_t error = MemsetD32OnHost(buf, sizeof(buf), 0xA5A5A5A5U, 64);
    EXPECT_EQ(error, RT_ERROR_NONE);
    for (size_t i = 0; i < 64; i++) {
        EXPECT_EQ(buf[i], 0xA5A5A5A5U);
    }
}

TEST_F(MemsetTaskTest, MemsetD32OnHost_zero_count)
{
    uint32_t buf[16] = {};
    rtError_t error = MemsetD32OnHost(buf, sizeof(buf), 0xDEADBEEFU, 0);
    EXPECT_EQ(error, RT_ERROR_NONE);
    for (size_t i = 0; i < 16; i++) {
        EXPECT_EQ(buf[i], 0U);
    }
}

TEST_F(MemsetTaskTest, MemsetD32OnDevice_totalBytes_exceeds_destMax)
{
    rtError_t error = MemsetD32OnDevice(nullptr, 8U, 0xABABABABU, 10U, nullptr, false);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

// 场景：D8 MemsetOnDeviceByBatch 已移除，D8 回退 V1 baseline 全走 drvMemsetD8

// 场景：ExpandByteToU32 字节扩展正确性
// 验证最低字节被正确复制到 4 个字节位置
TEST_F(MemsetTaskTest, ExpandByteToU32_correctness)
{
    EXPECT_EQ(ExpandByteToU32(0x00000000U), 0x00000000U);
    EXPECT_EQ(ExpandByteToU32(0x000000FFU), 0xFFFFFFFFU);
    EXPECT_EQ(ExpandByteToU32(0x000000A5U), 0xA5A5A5A5U);
    EXPECT_EQ(ExpandByteToU32(0x00000012U), 0x12121212U);
}

// 场景：同步路径下 totalBytes < 2MB，直接走 ByMemcpy，不进入 batch 路径
TEST_F(MemsetTaskTest, MemsetD32OnDevice_sync_small_size_skip_batch)
{
    if (Runtime::Instance()->CurrentContext() == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    rtError_t error = MemsetD32OnDevice(nullptr, 1024U, 0xABABABABU, 4U, nullptr, false);
    EXPECT_NE(error, RT_ERROR_NONE);
}

// Async path does not enter batch optimization
TEST_F(MemsetTaskTest, MemsetD32OnDevice_async_path_unchanged)
{
    if (Runtime::Instance()->CurrentContext() == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    rtError_t error = MemsetD32OnDevice(nullptr, 1024U, 0xABABABABU, 4U, nullptr, true);
    EXPECT_NE(error, RT_ERROR_NONE);
}

// Sync path with totalBytes >= 2MB goes ByBatch, count=0 returns NONE (while loop not entered)
TEST_F(MemsetTaskTest, MemsetD32OnDeviceByBatch_count_zero)
{
    if (Runtime::Instance()->CurrentContext() == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    rtError_t error = MemsetD32OnDeviceByBatch(nullptr, 0U, 0xABABABABU, 0U, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// ByBatch with mock HostMemAlloc failure returns alloc error
TEST_F(MemsetTaskTest, MemsetD32OnDeviceByBatch_host_alloc_fail)
{
    Context* curCtx = Runtime::Instance()->CurrentContext();
    if (curCtx == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    Driver* driver = curCtx->Device_()->Driver_();
    MOCKER_CPP_VIRTUAL(driver, &Driver::HostMemAlloc).stubs().will(returnValue(RT_ERROR_MEMORY_ALLOCATION));

    const uint64_t count = MEMSET_BATCH_BUF_SIZE / sizeof(uint32_t);
    rtError_t error = MemsetD32OnDeviceByBatch(nullptr, MEMSET_BATCH_BUF_SIZE, 0xABABABABU, count, 0U);
    EXPECT_EQ(error, RT_ERROR_MEMORY_ALLOCATION);
}

// ByBatch with mock MemcpyBatch failure returns error code
TEST_F(MemsetTaskTest, MemsetD32OnDeviceByBatch_memcpy_batch_fail)
{
    Context* curCtx = Runtime::Instance()->CurrentContext();
    if (curCtx == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    MOCKER(halMemcpyBatch).stubs().will(returnValue(static_cast<drvError_t>(1)));

    const uint64_t count = MEMSET_BATCH_BUF_SIZE / sizeof(uint32_t);
    rtError_t error = MemsetD32OnDeviceByBatch(nullptr, MEMSET_BATCH_BUF_SIZE, 0xABABABABU, count, 0U);
    EXPECT_NE(error, RT_ERROR_NONE);
}

// Sync path with totalBytes exactly at threshold goes ByBatch
TEST_F(MemsetTaskTest, MemsetD32OnDevice_sync_threshold_goes_batch)
{
    if (Runtime::Instance()->CurrentContext() == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    MOCKER(halMemcpyBatch).stubs().will(returnValue(DRV_ERROR_NONE));

    const uint64_t count = MEMSET_D32_THRESHOLD / sizeof(uint32_t);
    rtError_t error = MemsetD32OnDevice(nullptr, MEMSET_D32_THRESHOLD, 0xABABABABU, count, nullptr, false);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

// Sync path with totalBytes just below threshold goes ByMemcpy (not ByBatch)
TEST_F(MemsetTaskTest, MemsetD32OnDevice_sync_below_threshold_goes_bymemcpy)
{
    if (Runtime::Instance()->CurrentContext() == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    const uint64_t belowThreshold = MEMSET_D32_THRESHOLD - 4U;
    const uint64_t count = belowThreshold / sizeof(uint32_t);
    // Below threshold, ByMemcpy path is taken, which will fail with nullptr dst
    rtError_t error = MemsetD32OnDevice(nullptr, belowThreshold, 0xABABABABU, count, nullptr, false);
    EXPECT_NE(error, RT_ERROR_NONE);
}

// Parameterized test for various sizes through ByBatch path (mock MemcpyBatch success)
struct BatchSizeParam {
    uint64_t totalBytes;
    std::string name;
};

class MemsetBatchSizeTest : public MemsetTaskTest, public testing::WithParamInterface<BatchSizeParam> {};

TEST_P(MemsetBatchSizeTest, ByBatch_various_sizes)
{
    Context* curCtx = Runtime::Instance()->CurrentContext();
    if (curCtx == nullptr) {
        GTEST_SKIP() << "No device context";
    }
    MOCKER(halMemcpyBatch).stubs().will(returnValue(DRV_ERROR_NONE));

    const auto& p = GetParam();
    const uint64_t count = p.totalBytes / sizeof(uint32_t);
    rtError_t error = MemsetD32OnDeviceByBatch(nullptr, p.totalBytes, 0xABABABABU, count, 0U);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

INSTANTIATE_TEST_SUITE_P(
    ByBatchSizes, MemsetBatchSizeTest,
    testing::Values(
        BatchSizeParam{MEMSET_BATCH_BUF_SIZE, "exactly_2MB"}, BatchSizeParam{MEMSET_BATCH_BUF_SIZE + 4U, "2MB_plus_4B"},
        BatchSizeParam{MEMSET_BATCH_BUF_SIZE * 2U, "4MB"},
        BatchSizeParam{MEMSET_BATCH_BUF_SIZE * 3U + 100U, "6MB_plus"},
        BatchSizeParam{MEMSET_BATCH_BUF_SIZE * MEMSET_BATCH_MAX_COUNT, "8GB_single_round_max"},
        BatchSizeParam{MEMSET_BATCH_BUF_SIZE * (MEMSET_BATCH_MAX_COUNT + 1U), "8GB_plus_multi_round"},
        BatchSizeParam{MEMSET_BATCH_BUF_SIZE * (MEMSET_BATCH_MAX_COUNT * 2U + 5U), "16GB_plus"}));
