/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <thread>
#include <chrono>
#include "mockcpp/mockcpp.hpp"
#include "dump_stream_info.h"

using namespace Adx;

class DumpResourceSafeMapUtest : public testing::Test {
protected:
    virtual void SetUp()
    {
        DumpResourceSafeMap::Instance().clear();
    }
    virtual void TearDown()
    {
        DumpResourceSafeMap::Instance().clear();
        GlobalMockObject::verify();
    }
};

TEST_F(DumpResourceSafeMapUtest, Test_DumpStreamCreate_Success)
{
    DumpStreamInfo* dumpPtr = nullptr;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_NE(dumpPtr, nullptr);
    EXPECT_NE(dumpPtr->stm, nullptr);
    EXPECT_NE(dumpPtr->mainStmEvt, nullptr);
    EXPECT_NE(dumpPtr->dumpStmEvt, nullptr);

    if (dumpPtr != nullptr) {
        DumpStreamFree(dumpPtr);
    }
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpStreamCreate_Fail_NullPtr)
{
    int32_t ret = DumpStreamCreate(nullptr);
    EXPECT_NE(ret, ADUMP_SUCCESS);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpStreamFree_NullPtr)
{
    DumpStreamFree(nullptr);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpStreamFree_Normal)
{
    DumpStreamInfo* dumpPtr = nullptr;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    ASSERT_EQ(ret, ADUMP_SUCCESS);

    DumpStreamFree(dumpPtr);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_Insert_Get)
{
    DumpStreamInfo* dumpPtr = nullptr;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    ASSERT_EQ(ret, ADUMP_SUCCESS);
    dumpPtr->mainStreamKey = "test_key_1";
    std::shared_ptr<DumpStreamInfo> dumpInfo(dumpPtr, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("test_key_1", dumpInfo);

    auto result = DumpResourceSafeMap::Instance().get("test_key_1");
    EXPECT_NE(result, nullptr);
    EXPECT_EQ(result->mainStreamKey, "test_key_1");
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_Get_NotFound)
{
    auto result = DumpResourceSafeMap::Instance().get("non_existent_key");
    EXPECT_EQ(result, nullptr);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_Remove)
{
    DumpStreamInfo* dumpPtr = nullptr;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    ASSERT_EQ(ret, ADUMP_SUCCESS);
    std::shared_ptr<DumpStreamInfo> dumpInfo(dumpPtr, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("test_key", dumpInfo);
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 1);

    DumpResourceSafeMap::Instance().remove("test_key");
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);
    EXPECT_EQ(DumpResourceSafeMap::Instance().get("test_key"), nullptr);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_Size)
{
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);

    DumpStreamInfo* dumpPtr = nullptr;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    ASSERT_EQ(ret, ADUMP_SUCCESS);
    std::shared_ptr<DumpStreamInfo> dumpInfo(dumpPtr, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("key1", dumpInfo);
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 1);

    DumpResourceSafeMap::Instance().clear();
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_Clear)
{
    DumpStreamInfo* dumpPtr1 = nullptr;
    DumpStreamInfo* dumpPtr2 = nullptr;
    int32_t ret1 = DumpStreamCreate(&dumpPtr1);
    int32_t ret2 = DumpStreamCreate(&dumpPtr2);
    ASSERT_EQ(ret1, ADUMP_SUCCESS);
    ASSERT_EQ(ret2, ADUMP_SUCCESS);

    std::shared_ptr<DumpStreamInfo> dumpInfo1(dumpPtr1, DumpStreamFree);
    std::shared_ptr<DumpStreamInfo> dumpInfo2(dumpPtr2, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("key1", dumpInfo1);
    DumpResourceSafeMap::Instance().insert("key2", dumpInfo2);
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 2);

    DumpResourceSafeMap::Instance().clear();
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_WaitAndClear_Completed)
{
    DumpStreamInfo* dumpPtr = nullptr;
    ;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    ASSERT_EQ(ret, ADUMP_SUCCESS);
    std::shared_ptr<DumpStreamInfo> dumpInfo(dumpPtr, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("test_key", dumpInfo);

    // Enqueue cleanup and wait
    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key");
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
    DumpResourceSafeMap::Instance().waitAndClear();
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_WaitAndClear_Multiple)
{
    DumpStreamInfo* dumpPtr1 = nullptr;
    DumpStreamInfo* dumpPtr2 = nullptr;
    int32_t ret1 = DumpStreamCreate(&dumpPtr1);
    int32_t ret2 = DumpStreamCreate(&dumpPtr2);
    ASSERT_EQ(ret1, ADUMP_SUCCESS);
    ASSERT_EQ(ret2, ADUMP_SUCCESS);

    std::shared_ptr<DumpStreamInfo> dumpInfo1(dumpPtr1, DumpStreamFree);
    std::shared_ptr<DumpStreamInfo> dumpInfo2(dumpPtr2, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("key1", dumpInfo1);
    DumpResourceSafeMap::Instance().insert("key2", dumpInfo2);

    // Enqueue cleanup for both keys and wait
    DumpResourceSafeMap::Instance().EnqueueCleanup("key1");
    DumpResourceSafeMap::Instance().EnqueueCleanup("key2");
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
    DumpResourceSafeMap::Instance().waitAndClear();
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);
}

TEST_F(DumpResourceSafeMapUtest, Test_DumpResourceSafeMap_ThreadSafety)
{
    const int numThreads = 10;
    std::vector<std::thread> threads;

    // Concurrent inserts
    for (int i = 0; i < numThreads; ++i) {
        threads.emplace_back([i]() {
            DumpStreamInfo* dumpPtr = nullptr;
            int32_t ret = DumpStreamCreate(&dumpPtr);
            if (ret == ADUMP_SUCCESS) {
                std::shared_ptr<DumpStreamInfo> dumpInfo(dumpPtr, DumpStreamFree);
                std::string key = "thread_key_" + std::to_string(i);
                DumpResourceSafeMap::Instance().insert(key, dumpInfo);
            }
        });
    }

    for (auto& t : threads) {
        t.join();
    }

    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), numThreads);
}

TEST_F(DumpResourceSafeMapUtest, Test_CleanupThread_StartStop)
{
    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_1");
    EXPECT_TRUE(DumpResourceSafeMap::Instance().IsCleanupThreadActive());

    DumpResourceSafeMap::Instance().waitAndClear();
    EXPECT_FALSE(DumpResourceSafeMap::Instance().IsCleanupThreadActive());
}

TEST_F(DumpResourceSafeMapUtest, Test_CleanupThread_EnqueueAndProcess)
{
    DumpStreamInfo* dumpPtr = nullptr;
    int32_t ret = DumpStreamCreate(&dumpPtr);
    ASSERT_EQ(ret, ADUMP_SUCCESS);
    dumpPtr->mainStreamKey = "test_key_cleanup";
    std::shared_ptr<DumpStreamInfo> dumpInfo(dumpPtr, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("test_key_cleanup", dumpInfo);
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 1);

    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_cleanup");

    std::this_thread::sleep_for(std::chrono::milliseconds(100));

    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);

    DumpResourceSafeMap::Instance().waitAndClear();
}

TEST_F(DumpResourceSafeMapUtest, Test_CleanupThread_MultipleKeys)
{
    DumpStreamInfo* dumpPtr1 = nullptr;
    DumpStreamInfo* dumpPtr2 = nullptr;
    int32_t ret1 = DumpStreamCreate(&dumpPtr1);
    int32_t ret2 = DumpStreamCreate(&dumpPtr2);
    ASSERT_EQ(ret1, ADUMP_SUCCESS);
    ASSERT_EQ(ret2, ADUMP_SUCCESS);

    std::shared_ptr<DumpStreamInfo> dumpInfo1(dumpPtr1, DumpStreamFree);
    std::shared_ptr<DumpStreamInfo> dumpInfo2(dumpPtr2, DumpStreamFree);

    DumpResourceSafeMap::Instance().insert("key_cleanup_1", dumpInfo1);
    DumpResourceSafeMap::Instance().insert("key_cleanup_2", dumpInfo2);
    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 2);

    DumpResourceSafeMap::Instance().EnqueueCleanup("key_cleanup_1");
    DumpResourceSafeMap::Instance().EnqueueCleanup("key_cleanup_2");

    std::this_thread::sleep_for(std::chrono::milliseconds(100));

    EXPECT_EQ(DumpResourceSafeMap::Instance().size(), 0);

    DumpResourceSafeMap::Instance().waitAndClear();
}

TEST_F(DumpResourceSafeMapUtest, Test_WaitAndClear_StopsCleanupThread)
{
    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_stop");
    EXPECT_TRUE(DumpResourceSafeMap::Instance().IsCleanupThreadActive());

    DumpResourceSafeMap::Instance().waitAndClear();
    EXPECT_FALSE(DumpResourceSafeMap::Instance().IsCleanupThreadActive());
}

TEST_F(DumpResourceSafeMapUtest, Test_CleanupThread_LazyStart)
{
    EXPECT_FALSE(DumpResourceSafeMap::Instance().IsCleanupThreadActive());

    DumpResourceSafeMap::Instance().EnqueueCleanup("test_key_lazy");
    EXPECT_TRUE(DumpResourceSafeMap::Instance().IsCleanupThreadActive());

    DumpResourceSafeMap::Instance().waitAndClear();
    EXPECT_FALSE(DumpResourceSafeMap::Instance().IsCleanupThreadActive());
}
