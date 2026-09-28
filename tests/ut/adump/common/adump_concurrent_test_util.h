/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_CONCURRENT_TEST_UTIL_H
#define ADUMP_CONCURRENT_TEST_UTIL_H
#include <atomic>
#include <thread>
#include <unordered_set>
#include <vector>
#include <gtest/gtest.h>
#include "adump_api.h"

namespace AdxTestUtil {
// AdumpGetSizeInfoAddr 并发唯一性公共断言：N 线程并发调用，返回的 atomicIndex 必须全局唯一。
inline void AssertAtomicIndexUniqueConcurrently()
{
    constexpr uint32_t kThreads = 8;
    constexpr uint32_t kIters = 2000;
    std::vector<std::vector<uint32_t>> results(kThreads);
    std::atomic<bool> go{false};
    std::vector<std::thread> workers;
    for (uint32_t t = 0; t < kThreads; ++t) {
        workers.emplace_back([&results, &go, t]() {
            results[t].reserve(kIters);
            while (!go.load()) {
                std::this_thread::yield();
            }
            for (uint32_t i = 0; i < kIters; ++i) {
                uint32_t atomicIndex = 0;
                (void)Adx::AdumpGetSizeInfoAddr(1, atomicIndex);
                results[t].push_back(atomicIndex);
            }
        });
    }
    go.store(true);
    for (auto& w : workers) {
        w.join();
    }
    std::unordered_set<uint32_t> uniqueIndexes;
    for (const auto& perThread : results) {
        uniqueIndexes.insert(perThread.begin(), perThread.end());
    }
    EXPECT_EQ(uniqueIndexes.size(), static_cast<size_t>(kThreads) * kIters);
}
} // namespace AdxTestUtil
#endif // ADUMP_CONCURRENT_TEST_UTIL_H
