/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "npu_driver.hpp"
#include "driver/ascend_hal.h"
#include "event.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver.hpp"
#include "cmodel_driver.h"
#include "common/rt_utest_context_reset_helper.hpp"
#include <atomic>
#include <set>
#include <thread>
#include <vector>
using namespace testing;
using namespace cce::runtime;

class DriverTest : public testing::Test {
protected:
    static void SetUpTestCase() { std::cout << "Driver test start" << std::endl; }

    static void TearDownTestCase() { std::cout << "Driver test start end" << std::endl; }

    virtual void SetUp() { rtSetDevice(0); }

    virtual void TearDown()
    {
        ut::ResetPrimaryDeviceIfActiveWithDeviceDown();
        GlobalMockObject::verify();
    }
};

TEST_F(DriverTest, bitmap)
{
    Bitmap map(70);
    int id = -1;
    for (int i = 0; i < 70; i++) {
        id = map.AllocId();
        EXPECT_NE(id, -1);
    }
    id = map.AllocId();
    EXPECT_EQ(id, -1);

    uint32_t numOfRes = 15 * 1024;
    uint32_t curMaxNumOfRes = 11 * 1024;
    Bitmap map2(numOfRes);
    for (int i = 0; i < curMaxNumOfRes; i++) {
        id = map2.AllocId(curMaxNumOfRes);
        EXPECT_NE(id, -1);
    }

    for (int i = 0; i < 1025; i++) { // utilization: 11*1024 - 1025, available: 1025
        map2.FreeId(i);
    }

    id = map2.AllocId(curMaxNumOfRes); // available: 1024
    EXPECT_NE(id, -1);

    id = map2.AllocId(curMaxNumOfRes); // available: 1023
    EXPECT_NE(id, -1);

    id = map2.AllocId(curMaxNumOfRes);
    EXPECT_EQ(id, -1);
}

TEST_F(DriverTest, bitmap_concurrent_allocation_metadata)
{
    constexpr uint32_t capacity = 512U;
    constexpr uint32_t threadCount = 8U;
    Bitmap map(capacity);
    ASSERT_EQ(map.AllocBitmap(), RT_ERROR_NONE);
    std::atomic<bool> start{false};
    std::vector<std::vector<int32_t>> threadIds(threadCount);
    std::vector<std::thread> threads;
    for (uint32_t threadIdx = 0U; threadIdx < threadCount; ++threadIdx) {
        threads.emplace_back([&map, &start, &threadIds, threadIdx]() {
            while (!start.load(std::memory_order_acquire)) {
                std::this_thread::yield();
            }
            while (true) {
                const int32_t id = map.AllocId();
                if (id < 0) {
                    break;
                }
                threadIds[threadIdx].push_back(id);
            }
        });
    }
    start.store(true, std::memory_order_release);
    for (auto& thread : threads) {
        thread.join();
    }

    std::set<int32_t> uniqueIds;
    for (const auto& ids : threadIds) {
        uniqueIds.insert(ids.cbegin(), ids.cend());
    }
    EXPECT_EQ(uniqueIds.size(), capacity);
    EXPECT_EQ(map.allocedCnt_.Value(), capacity);

    threads.clear();
    for (uint32_t threadIdx = 0U; threadIdx < threadCount; ++threadIdx) {
        threads.emplace_back([&map, &threadIds, threadIdx]() {
            for (const int32_t id : threadIds[threadIdx]) {
                map.FreeId(id);
            }
        });
    }
    for (auto& thread : threads) {
        thread.join();
    }
    EXPECT_EQ(map.allocedCnt_.Value(), 0U);
}

TEST_F(DriverTest, bitmap_normalizes_allocation_hint_for_smaller_limit)
{
    Bitmap map(128U);
    for (uint32_t i = 0U; i < 65U; ++i) {
        ASSERT_GE(map.AllocId(128U), 0);
    }
    EXPECT_EQ(map.AllocId(64U), -1);
}

TEST_F(DriverTest, get_plat_info_succ)
{
    uint32_t info = 0;

    MOCKER(drvGetPlatformInfo).stubs().will(returnValue(DRV_ERROR_NONE));

    NpuDriver* rawDrv = new NpuDriver();

    info = rawDrv->RtGetRunMode();
    EXPECT_EQ(info, RT_RUN_MODE_RESERVED);
    GlobalMockObject::verify();

    delete rawDrv;
}

TEST_F(DriverTest, get_plat_info_fail)
{
    uint32_t info = 0;

    MOCKER(drvGetPlatformInfo).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    NpuDriver* rawDrv = new NpuDriver();

    info = rawDrv->RtGetRunMode();
    EXPECT_EQ(info, RT_RUN_MODE_RESERVED);
    delete rawDrv;
}

TEST_F(DriverTest, register_driver_fail)
{
    DriverFactory* rawDrv = new DriverFactory();
    bool ret = rawDrv->RegDriver(NPU_DRIVER, nullptr);
    EXPECT_EQ(ret, false);
    delete rawDrv;
}
